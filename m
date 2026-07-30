Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53838472;
	Thu, 30 Jul 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438142; cv=fail; b=DPf0LJ3LWHwC7bLxtJ1zsSqhzXUucLJAvw+xx/Yjj0mMx+GKEEelyxX3W+dXAFls5PFB7+zjil/3UOQZdlNKE2WAm87PcpCwmbQBr+ZdYN97gXPvaL6m02hSLT86NF7vRS6cVLezfjKnG9WJRQPiux8dis6EEYFEVIGMtfnrxjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438142; c=relaxed/simple;
	bh=Mnw/a1Z87VieH6XEArZWoOk7sdj+O8hcxbfqG8rVmvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qEvnCL/F4pCDUcpTmbOrml+zlwetS0LvkGZFgk7szzpIg0RDDMvXGir+ZCtdb7moQ+ODfcJLcAbT0+uQHJsWJIv0YBP6DWEHWYqFKXM26HGn7FoL8BEqcHJipR0uBd3B6DyCZE6ssRtCrZSwZs4PodoclZXiwgqb1DxjVHkItM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AAA3wVy0; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AAA3wVy0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bw2QWyl4S0tVKZ7Z4lszADaHukkkCY8SbcbuPLco5XbHL3A4fvbWgNc6DvwBqxWwVKMqfP2ZFv7NwDzjX2LNK/bCUTSDmW87SWt4LrXtVrftaWp7LCjDf3LKzfYbDajKGPBK1yvBBpDimzKnEMrcX2CAzrRsnRTK4Uyxx0dFahj4HHLTjN7ch9qb9cBblKo25hy+Htqnj39d84L5iWM6XUJFFCjZfPagJtPzxaMhB5LE5uM4m+cvL9cU+Kf1BbuRyskTE3X52RSjV4+Tvp32bJdSDSrOGixFvZce2+p/+plAsTHbqWzzmiuO78c6U3UhBRnZK55td6LDUaFyVaflNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eym2HDx2N3xRiFaoTQyng5PelDkIJBOhdpfYXq9Blig=;
 b=wRwp3Wqq1LfGtyRbPAXFeCu7a0iXF4ZJyZ61fsDqNn+cl9y+Vs4zbANvBMSHUk9qdGRpRwV8105s581ih0rKVpIkKb/Xut8xXPUB1KMWfaDwJ0cNqdgJG3DhN34vgWHtqH6frffo3ZparphSY05afZBHy8znKUwXh4U51Wan0X++U1vE6L+447RQ07aJ4TwhRatSk13dnD92uibQ5FRagCJxK+kNzMZiuKt9PhA9OUX3C4Lq20vNHTewpGQAku13Cmw3fqYSANFYWXlBR3yWGgoGarZDYsUgIyl6CR8L2VRCed8CqXXPhzF5IllJzCzqvPwkaWzCamES/jsE6cTenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eym2HDx2N3xRiFaoTQyng5PelDkIJBOhdpfYXq9Blig=;
 b=AAA3wVy0u7EdtKMXWdmL0VHRE1n1cR3jwVoJYrHsa4IhJlgHpwM/Afu2myHO7Behsgom5a/f75SeyRnaH+ZgJGGh60AFIcB7eiPkam69m7gZ9ODEDy9qnje/cMUYZYBRzgBiNiHXii1JRxFGKbSaHaOqDWzzr+uRD1liaUMh/qh5cEUsQCoWZPcPUUjsvDRSPyLBlIl/EgccKpaW9NJGFzzLqJECM+1k1SigeP9vjYNKW6IN6NrLhcnZGHJ9BroDs7YObZBjwPlNyFaxrOxerb1tg00B/svA56LVzYGXcnxhqj82F/QTNyytZnytIYR5SAESHonPPAIJTIuTMfIgVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DB9PR04MB9776.eurprd04.prod.outlook.com (2603:10a6:10:4f0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 19:02:14 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 19:02:14 +0000
Date: Thu, 30 Jul 2026 14:02:05 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amufrR-1hop2pZOz@SMW015318>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719221014.44354-5-kmehltretter@gmail.com>
X-ClientProxiedBy: SA1P222CA0163.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::22) To DU4PR04MB11791.eurprd04.prod.outlook.com
 (2603:10a6:10:623::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DB9PR04MB9776:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c61c763-b6fe-4e23-47fb-08deee6d109c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|19092799006|10067099003|4143699003|5023799004|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1cLdSufxYNtWuQOfBKLGJbGC1yRAm+bxdSQA5CqIXPS9jee8hMwHSWOoFwqkoEYQRsOaoX1RkQOAOdq+mpKGtDVSy4b7SCtaQF9MNvJo3M6BtRfBhLeGGCJu9CvsL2YGRPaNP/8xLbnNqkHniCx9dsVnynrxu4e3aJ2xWZ0DcoDquG9PVz7SLnN9HK9yaoZbTloSSHjrziu02aYMAHiLMaXCicYBsfdEqIAr8eFxa9YDV+u/Qootx9fksoxhf/A4CvDYo0Shk9GBcfNvkteBYh4Otjb9AQ64m3IPk6a4arxrWT028NZ8YX2Fj3bYlL3YWP2i4HGwBPa7QjRjXYW3kQGTkv1mWOk6o5L0sQLafT3lLfKfCgPd/497ZfxYDmna1ymtMDXAPgD4oC7NIoooSe0QebgGI7y/OusPyIBVam04aSXsmsIhI/ArVSnUybM+04viD3swb6agdEXh+xbM1YrVQwXzql7GMGw1gKkwdbsTlt/GxoJfRiwQyX/Aw+G3liRGynSyktMZV4+fBOydlAGk3ayR3mX2NdAPQIcx6UnjxY6+Do6VWzFGyjHrKdYB87tYo9TlpgfxYqBXL8gcJ2mQc8LPIuPTmP07z9PCYirmFEqGQ8t30tiSVHkEEAkm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(19092799006)(10067099003)(4143699003)(5023799004)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ijyym7k1cqq64OV/R+UWveBzH2sfmSptjpHsMsU1AR6jtWwRZbcjyxPv59UJ?=
 =?us-ascii?Q?p0P8J7F5xtYzYBUMGP7atzGc81jbnFP9JS1xWDFY0xAzxJoxMMCjOl2Fs0H9?=
 =?us-ascii?Q?1KPoikZMIYZkFAwrl1pckiyr0mlemsk947WvLOPHleWE4UdBXodtD8EMP1EO?=
 =?us-ascii?Q?50cY4F0ik2dcB85HfKFy0K/SPzCGBOJlwvCPC4x+f2KTkUOY/COiY2OrSiO3?=
 =?us-ascii?Q?CF7mEaR/4cOEoinqxBXI+t7VVNzRzgvx6Cm1nbayxeyLckEkZiub5Kj+sYCD?=
 =?us-ascii?Q?4ekx2S86qb96xzzUjP/xhD1KI9wI1w5kHLM0qtC/4VNI6t/qeUyQlOdCwSZU?=
 =?us-ascii?Q?Y/g7xWnwmHMI0NYKKwsWyUTshIP6nQ56u38TuKTW0onW3bHo+ao1fl9Dsw7k?=
 =?us-ascii?Q?vi+veEauiazTr0dK7WCy808OO7hq+AKYpTCSDGEBNpzNbhegPhMjP3wTG1mI?=
 =?us-ascii?Q?PJz+T2TmTwoLq5x2hD2KXAL5OQyXjYR/LjT1WqM0W/e8RSTkb7RpnFF4phMU?=
 =?us-ascii?Q?WsI7qCbFYPCjJyvZgxXMvqE3gpdal20YdYtj64NSIqY41A82olSoPgbA4jgF?=
 =?us-ascii?Q?hc/awxnPsmgAhr2LlwQPpbCLG7fXh2HEO3CB36vKmayAPkjZDdr45tfZgmrA?=
 =?us-ascii?Q?sUsJSjZ9QgXSDoQNytHmYpi79WN5esm8+Or7hiJjH6EwcO0/h5oD5PdE7/+O?=
 =?us-ascii?Q?hjDWu10AlqJVvcQndaKZjNxfZya3gfZR329657oX2Oqf7dwU+tWUzZVo2DPv?=
 =?us-ascii?Q?w3upXY7Jlm6DQ7DT7tpWd6yT1/lQ0yCEU2av4bAVn5MBdiAwk2dFdmTIzmCu?=
 =?us-ascii?Q?q/kmH7b8PqxO8q4MRxSMiTswxvNiivHCc/5MqYLCYT+cxS3YFOuLD/tZWFFs?=
 =?us-ascii?Q?OAVbQo6sot2CdN28aMZNnIC4v47PNtT1xBDAA/LxlBdzWJzPKS+jCLqY2XFh?=
 =?us-ascii?Q?QwzEVHK+DAS/adhUD79kTjzNw7QFWey5i0yUgY11vK4MAFMJ9uPzn5oI5hI2?=
 =?us-ascii?Q?jmS3yHaZIxhBwYEjZ63/hUfAcgvGF26FFMw0pLKNG+GPMy3ql8Ba6oZin59H?=
 =?us-ascii?Q?N1N7jSgwHY0RcczKUvXhwOWyuZPjyQr0lRHfbaR9MqIPidQNoEwJd3GIPa5R?=
 =?us-ascii?Q?0V1ItFdB95EcUDqbW45ALVh/uOGMBt/Pk4bJNazOujQlibLKBMcefQ2mHseQ?=
 =?us-ascii?Q?SQNrSTu5aggbTLSN6ff3j0eUlgFw0Wan3cT0Y5yGTGQ7PREnl2gpS5X37h3w?=
 =?us-ascii?Q?SP0i5W6MIpVabOpVmy1Uefr1actOYLXE+eIO9bPQJ3hZ7KiwvokqOt8gMqeY?=
 =?us-ascii?Q?VFc2PdtLYEJnh7Q3FhJtferQTKDKFn4yCtpBgnW/G2uIGqDrmdP/+1Xz/As8?=
 =?us-ascii?Q?cAswNUWscLuhGTyIUaknrcfxGsSTRw2PaKbGm9LTk6G+K/mAXOqLT54W31Ue?=
 =?us-ascii?Q?JUE3FVOHBZMUzD6EMg4A/vQptb9T8Yb56IdYyOnP1FsNk6YejfQTZjXqF//K?=
 =?us-ascii?Q?dc5k6XGs0qcJkt2sKhYNfvXqPtnldbsGFytcvK2rHzQJUJaAVCrjt82oJRnm?=
 =?us-ascii?Q?gagEXHumSxcE7elUseFUSvt2kX9g/BkbYCWYuOeCbyqOoxZ8vgvWtYmSGd/b?=
 =?us-ascii?Q?i1c9Tji1cobuYoMiAX2IiMI890tnuxBeZgRz9UZJ7bZmDhUtUoMMqUiOAVmu?=
 =?us-ascii?Q?Y3VM5TOa1ZE09X5Fhy2aWNHhDhTCrqz7zHs0ZM9R11wEY32OaKFEj7DX8rkA?=
 =?us-ascii?Q?umG4AFUM/7HpDvLLQxRyumruC7WZRv8PxfNV30V0CNWeMZdiBnGs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61c763-b6fe-4e23-47fb-08deee6d109c
X-MS-Exchange-CrossTenant-AuthSource: DU4PR04MB11791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 19:02:13.9420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJ4Sn9vWmntwJz3zECchQqU4NZSQpBBVjAbj2zyTQU5Ex2S2PAvFfRBzg4gzXJ1v5QQH1YP+vfc9X7JKkTV3Urx3JCNWGHE1/p2/qyz2UyjvBTFvvS3K6QzizkZTahAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9776

On Mon, Jul 20, 2026 at 12:10:14AM +0200, Karl Mehltretter wrote:
> [You don't often get email from kmehltretter@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> imx_uart_probe() publishes the port in imx_uart_ports[] before
> uart_add_one_port(), because console setup during that call uses the
> table. The entry is not cleared if adding the port fails or after
> imx_uart_remove() removes it.
>
> The port is devm-allocated, so a failed probe or unbind leaves the table
> pointing at freed memory. A later registration of the shared console can
> then dereference the stale entry. Reproduced on QEMU's mcimx6ul-evk by
> unbinding a sibling UART, unbinding the console UART and rebinding the
> sibling:
>
>   BUG: KASAN: slab-use-after-free in imx_uart_console_setup+0xd0/0x3d8
>
> The entry must remain valid until uart_remove_one_port() unregisters the
> console. Clearing it afterward without serialization still races a
> sibling probe: the sibling can register the shared console using the
> dying entry before it is cleared. The next console write then
> dereferences NULL.
>
> Use a driver-wide mutex to serialize table publication, port addition
> and rollback with port removal and table clearing. Console callbacks
> remain lockless because uart_add_one_port() may invoke setup while
> probe holds the mutex.
>
> The probe-failure path also relies on "serial: core: do fallible
> allocations before the console can be registered", which moves the
> uport->name and uport->tty_groups allocations before console
> registration. Both changes should be backported together.
>
> Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
> Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  drivers/tty/serial/imx.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 251a50c8aa38..def874f9cd00 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -22,6 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/ktime.h>
> +#include <linux/mutex.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/rational.h>
>  #include <linux/slab.h>
> @@ -2080,6 +2081,15 @@ static const struct uart_ops imx_uart_pops = {
>
>  static struct imx_port *imx_uart_ports[UART_NR];
>
> +/*
> + * Store the port in imx_uart_ports[] before uart_add_one_port() and clear
> + * it only after uart_remove_one_port() returns. Console callbacks in both
> + * calls use the table, so this mutex serializes these sequences between
> + * sibling ports. Callbacks must not take it because uart_add_one_port()
> + * may invoke setup while it is held.
> + */
> +static DEFINE_MUTEX(imx_uart_ports_lock);
> +
>  #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
>  static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> @@ -2632,11 +2642,14 @@ static int imx_uart_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       imx_uart_ports[sport->port.line] = sport;
> -
>         platform_set_drvdata(pdev, sport);
>
> +       mutex_lock(&imx_uart_ports_lock);
> +       imx_uart_ports[sport->port.line] = sport;
>         ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +       if (ret)
> +               imx_uart_ports[sport->port.line] = NULL;
> +       mutex_unlock(&imx_uart_ports_lock);

ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
if (ret)
	goto err_clk;

imx_uart_ports[sport->port.line] = sport;

return 0

and at imx_uart_remove()

imx_uart_remove()
{
	imx_uart_ports[line] = NULL;
	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
}

Is above sequence to avoid use mutex?

Frank

>
>  err_clk:
>         clk_disable_unprepare(sport->clk_ipg);
> @@ -2647,8 +2660,12 @@ static int imx_uart_probe(struct platform_device *pdev)
>  static void imx_uart_remove(struct platform_device *pdev)
>  {
>         struct imx_port *sport = platform_get_drvdata(pdev);
> +       unsigned int line = sport->port.line;
>
> +       mutex_lock(&imx_uart_ports_lock);
>         uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +       imx_uart_ports[line] = NULL;
> +       mutex_unlock(&imx_uart_ports_lock);
>  }
>
>  static void imx_uart_restore_context(struct imx_port *sport)
> --
> 2.53.0
>
