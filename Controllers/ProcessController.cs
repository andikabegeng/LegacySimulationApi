using Microsoft.AspNetCore.Mvc;
using LegacySimulationApi.Models;
using LegacySimulationApi.Services;

namespace LegacySimulationApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProcessController : ControllerBase
    {
        private readonly ProcessService _service;
        private readonly ILogger<ProcessController> _logger;

        public ProcessController(ProcessService service, ILogger<ProcessController> logger)
        {
            _service = service;
            _logger = logger;
        }

        [HttpGet("status")]
        public IActionResult Status()
        {
            _logger.LogInformation("Status endpoint called");
            return Ok(new { Status = "Running", Time = DateTime.UtcNow });
        }

        [HttpPost("run")]
        public IActionResult Run([FromBody] RequestModel request)
        {
            if (request == null)
                return BadRequest("Request body required");

            if (string.IsNullOrWhiteSpace(request.CustomerId) || request.Amount <= 0)
                return BadRequest("Invalid input. CustomerId and positive Amount are required.");

            try
            {
                var result = _service.RunProcess(request);
                return Ok(result);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error while running process for {CustomerId}", request.CustomerId);
                return StatusCode(500, "Internal server error");
            }
        }
    }
}
