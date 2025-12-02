namespace LegacySimulationApi.Models
{
    public class ResponseModel
    {
        public string Message { get; set; } = string.Empty;
        public double Score { get; set; }
        public DateTime ProcessedAt { get; set; }
    }
}
