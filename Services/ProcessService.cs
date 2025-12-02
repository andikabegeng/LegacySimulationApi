using LegacySimulationApi.Models;

namespace LegacySimulationApi.Services
{
    public class ProcessService
    {
        private readonly ILogger<ProcessService> _logger;
        private readonly IConfiguration _config;

        public ProcessService(ILogger<ProcessService> logger, IConfiguration config)
        {
            _logger = logger;
            _config = config;
        }

        public ResponseModel RunProcess(RequestModel request)
        {
            _logger.LogInformation("Running process for CustomerId={CustomerId}, Amount={Amount}", request.CustomerId, request.Amount);

            // Simulate some legacy business logic:
            var multiplier = _config.GetValue<double>("Processing:Multiplier", 1.0);
            var baseFactor = 1.234;
            var score = request.Amount * multiplier * baseFactor;

            return new ResponseModel
            {
                Message = "Process completed",
                Score = Math.Round(score, 4),
                ProcessedAt = DateTime.UtcNow
            };
        }
    }
}
