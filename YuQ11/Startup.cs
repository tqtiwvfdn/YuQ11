using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(YuQ11.Startup))]
namespace YuQ11
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
