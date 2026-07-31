Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013056.outbound.protection.outlook.com [52.101.72.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC76C1EEE6;
	Fri, 31 Jul 2026 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523145; cv=fail; b=YTuHCqCLioTtWhYIPoxuqXk+T9HnWjiPGVZ16iO2hoAYC3Kil+Xa5YV7D0LrB5PC6R1ZKdPwiUFfsIip9gF0bRlSxGHug+/HlByV7qj1C4fY89F/VzYwhrgXcC9Q/epayisKz8UHdASoWYwJ6QgWi0CCNYwjdS08aMiXUCamT/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523145; c=relaxed/simple;
	bh=uiTJklZfT/Peth/YXGgMJ8xSzkbMB74RhHwcGdCtc68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A3tME6QLn+BzM4VlflzLZsGCq8Vd7eQ/I/qWim/yJ4iNJArh722yj+7T54ElWm9OnX7nDGuYLtYoiFjqWmru7S1BbFDC+B/QVYSrWmnjLUuc1COfS9ZrAoJU/Z3InNhZN6xy2pPce3rgWaU5Ql/B+NdI/wjkS6/l7gMCry31rxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HuA+nFFt; arc=fail smtp.client-ip=52.101.72.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HuA+nFFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjbWflQLKiNOLcVf4jcZoaN0LmoAFMNpmGF0ljSqb/crwJm89OHJyDFJ9BNtsuGcrmrbYJq/ZV3ieOIn3zL0RbupctyO9g7K6PggrTPBt3WsK+m06o81Vm6JvQMQ2iTisXp+ZvoIj7Ufj/5Ft9rvDYVCG99d77mhJRQi+g3GE6/u56I4Ni2V/ao1ZbmmvjYO+Z4S/NDVF189InvEyebnHLIgxqK2eMl3snNEqOYOiv2uXRxcZgFyUl3mG8MApQ882ybjgDpsnPu7hUfP/jPwa/b0/PTizxNAfEF4FM+qCV5ryTcZk4fEtskR3gkiGeaAW+UG9vUpjR2C/2mHOoai0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia0DqGUa2XXoAmzsV6VqWsE8QytI+B6npF/KMkchDEQ=;
 b=fC5xZTQ0C9u+CcSOrIZo3AAydEgDRA0yLQAgaSCDFF1zIQokzAimUN7ezqN7UKlcvFs3X5IFydQrgJ1esSDzWksS/J+CQIF3z8gk/7xLvIrr1WolKvyxcmNJYqC73cNRHkJosNxXZD0fUqNYoTj8JRhvtFHku9xgfZWu21HlkMPA644WBFMpzNvyMQT/1t4PN4cbKQbUfC8webWETPoVY+kb5PzdWwKCueVZhMmpdg44CMmsqgEvIQ107K/6o4B9T0zcjSbhRvWp+jamou8sOh0SLl/wJscBnH28l/WvfFbfl0Upn+6RYCsHxKZnj8ESzPL93WhIw1ncNpwy7daW2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ia0DqGUa2XXoAmzsV6VqWsE8QytI+B6npF/KMkchDEQ=;
 b=HuA+nFFt5S5LlNXvtJil0e6sW41zXCWYsNQMHRNFWy15+SK+Pz2t9XjZIJObnmqKRKZHelQegwebRadwrH20n8wRl5u8wXmtxzfEutafJB9WShtKjfMrq3Pr0A0oPlVPNKQR1Z8yVrs/vtWIySIXBGWTLCeg1NSr0vs+bLGDB8IXkDHftUcSJNPgtSsSozEH3NgP2Zb+pC36UW9EG9cYpkEnUVLSHauJlz3ZlNyzq2Tqn9CNsKct2wZg53KfbZlmftSC/ADnGTvKjjy/HUrDN+G1BiIBqUDYlqBJgnLcRgyc8TDHKHGfeiQ1RV023KEKBNif9edUoNc5V0cgPmeGgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB8587.eurprd04.prod.outlook.com (2603:10a6:20b:43a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 18:38:59 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 18:38:59 +0000
Date: Fri, 31 Jul 2026 13:38:49 -0500
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
Subject: Re: [PATCH v3 5/5] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amzrudchE7v1Uj27@SMW015318>
References: <20260731180519.10988-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731180519.10988-1-kmehltretter@gmail.com>
X-ClientProxiedBy: SA1P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::31) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 458c5db9-f72d-4fba-9404-08deef32fc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|19092799006|23010399003|1800799024|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	40FBiz9X2TOuL28B5sGqfYF4PFqmHqoFVWjAai6xsq/CnY1aDgxraXIgTbC0YNeCtYGdZ215QYFcVbHCov5zXSkSJI00raTrQktTdoRPPkutxOmsCRAlnoeqJB4lDFTMz4hfVSQwS8QPMYPmOCwc4SOFYIhpvM+jiPBxl5FZcLuPOiF46Jhd+SgpxscmZl+Fn/IEp4Kd7ecpC+AjPLJdEH4OpBLwfeu8M3mvYiJygrUb+ETWWfjr+/eykqcF5nz7QUautDt4JApumalh9JfXCikfga6BFKwmjCre0ahPKlSJsXxmiwMgM8RvPYKege484BMXzoRid3jqKUyy9FCvcGRbCjRQFS0WZhu+bGIP1nc4YS+tlC5fmPqirD05WsCMSStf/63txT2pNIuOjB+yPFSRW+c8ABuDKDAbEYoyBo1NvZVc/54Itd5LZWc79mvUbCie+mmgyG6O2npayFGZPu50hv4/gyP50wkej0O45TV0Ue1l+p06u3l/if3c4lupVQ4cCHjB+OL1QSsbSqz29Jot4XxhW7J9Rkxk0HmXZoDYlDw4tplSj99xoaa8SjaRTRmV8jjcqkWBtzd9SFzLZBnLSMiPmZ6NtF8J81qzxOSmPptNGf60cJ4ATJKcnDqK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(19092799006)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OhOuzCHq5GWvQbC5/Pp35A2HtIkvbeRIlecCiCpRGqxt2xt1l0YNZvg1CTrY?=
 =?us-ascii?Q?qgqj7YOo1R5x272LvURia0wIup2UPwrZesG52gtVsJxhJ5QA9YNNIlq/ZPrL?=
 =?us-ascii?Q?wR1IUc/aP3OWk1gfGniPM8ROkIaHpsT5ldIM8sAgwJtBKrCAsipYzoGANUI3?=
 =?us-ascii?Q?mHDH56a/u/EwAAG1rVJqL6lsp82eWbSzGmqyiBSPh4qEo9MKxDkbKfzJYMEg?=
 =?us-ascii?Q?txE5jqNM5fA9h4dbND6GMZWS0K5pNdPWc98h61o80WvrJCBcPQvK1loeanEj?=
 =?us-ascii?Q?ro3HWs0UnryLuKScRKnnRbi9TxmHMdbPNhkUI3+hARM1uwDA0MtW7yDbNhod?=
 =?us-ascii?Q?es5b6HJYJN0PtEzMn2RQTY5xdPlnOULH9f7zRz3ffaj9+Z+T8KTubW6695H8?=
 =?us-ascii?Q?WRMlU9vJIGBXJnXCKg8QA6K175oanqy5rizuU8qjh+KsEAR25tVi3+eOgdXh?=
 =?us-ascii?Q?4+Wb1qwtDLEIVltRfeOe0onIvIW9eMelt5FmXf275ciG3vu0ZIRW+hsd9+rH?=
 =?us-ascii?Q?nzjn44OoPT0VCDav9fV6m/hjFU7UGevF0WKKScJZjbTOvMW2hqN2bvSnVZm9?=
 =?us-ascii?Q?NaANTb0uzRCu0VTeWUIV+pERULQjCYFXYqI8+jVO1ubo/u1F3hyMJDs1uw7n?=
 =?us-ascii?Q?uNsINRd+aCy5N5+l4VKH1yVKbfy6rVrs1kLKdhRV5Ns5mGWYTbyH19QfVFVV?=
 =?us-ascii?Q?jheLp9VcWDdkXyR8mcvMwRbUt+rq3GPXSaikJYymuJopb5KXs29Nf63hSc3V?=
 =?us-ascii?Q?vRzbLRwpy0ZOGmd1MWlSRfwT1HjB7oQa0JLY8XkY9D2jGXCapfA7R/ffsUUC?=
 =?us-ascii?Q?VtpcT2jtOAbkq5xakQpglKo7l4WJw4gzhw3wPc8Rnead004ZcMXFM9Yr4zsl?=
 =?us-ascii?Q?H5pDiE3124MZKnNx60B/MGhVBTBJgXQwEQ+WQCMPT5WGgrqWXNnNgozD54Z/?=
 =?us-ascii?Q?Fi5HpaO2OwoEeK2sFFcpIlILm1/HH4VQIA9dRnBitLCTT3v4H2S8bsl/p8Hj?=
 =?us-ascii?Q?pWYXN7vBxGkNYWaeTkLlpwhoNdWVWdqOLmibSASLDmVo8UkvYgLq7j8VaS1B?=
 =?us-ascii?Q?ov8zuikzz0qgNTL5M62NAy8LDK5B/TyEATZJdOSHkapg4P8ixrdkFA2t9O74?=
 =?us-ascii?Q?31SHsISkVn7lylBNHr+wDwylHQX1MOkA1fcNmVAYUANmMUsuDNnIKYZv2e67?=
 =?us-ascii?Q?0/tmK6xPr3FmY6w0LXbMpFL+YmuYW2NDWDv+Y5OcvkwzWSQXoNpWbPSWkHbw?=
 =?us-ascii?Q?cNVQa/uSDkYQavWofEoIfzpGWuYX3LkxWCj9H4zgYQjdhrelYP9dB579dPV5?=
 =?us-ascii?Q?D49DneQ7oDBHVhhO1CEImNUgpxCyg67FgcL33ht0uOpM4oYcvCViJfX1sRvO?=
 =?us-ascii?Q?6DMD5hDHbibatZZVLaebPN9UQ3LU39nlynw9jSQ+UMA08Ix8fbp9P63D/FT7?=
 =?us-ascii?Q?/f7JeCFDVqniusk8YNFTzUjzebfOQtZN8fX3K4MIIyQxnurg9NC5cYQHbQjP?=
 =?us-ascii?Q?mvth1XNcgFD4FOQSnjbLSVtvE0PVWLLrns8JYb56C9pjfTYq6P0BQ4aogIx3?=
 =?us-ascii?Q?keSktsL41gLlLLqW6S29+lcVkt3HW8w4KvG9/v4G3pImYeN5E08++HZ7jnLT?=
 =?us-ascii?Q?PE5vg6fHS6uTLrrjS32dMB3UirrTihtHtk/eIDBNoKFA7D/nnNuX32P2zBbP?=
 =?us-ascii?Q?dn2FAFvQBzRHpXXlVcxW+XbImuZ7X8/6/JevhICIXUcG0OBwsn5OCajXIFf7?=
 =?us-ascii?Q?opf6kgtlZUDOhb2sbbAx4Rq+qarHEkdbby+MqmqBodYBb1mm0LD2?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 458c5db9-f72d-4fba-9404-08deef32fc0d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:38:59.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Re4T4qPdEeGf6flp0TAkPdULxeGhABSByW0qln10P2Ab3uVKENXSeUTi6aBmK4cgy5o+GEFddqKFGKUT7q3wr9V+qbyVldVfvWdbtNkLGYJjQwkbkRGGXxbYsxgoXZRO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8587

On Fri, Jul 31, 2026 at 08:05:19PM +0200, Karl Mehltretter wrote:
> imx_uart_probe() publishes its devm-allocated port in imx_uart_ports[]
> before uart_add_one_port() because console setup uses the table. The entry
> is not cleared when adding the port fails or after removal, leaving a
> dangling pointer.
>
> A sibling probe can register the shared console through that stale entry.
> This was reproduced under KASAN on QEMU mcimx6ul-evk by unbinding a
> sibling UART, unbinding the console UART and rebinding the sibling.
>
> Keep the entry valid through uart_remove_one_port(), then clear it. Protect
> port addition and removal together with their table updates so sibling
> operations cannot interleave. Reject an occupied slot rather than
> clobbering an active port during a duplicate-line probe.
>
> Fixes: dbff4e9ea2e8 ("IMX UART: remove statically initialized tables")
> Fixes: 9f322ad064f9 ("imx: serial: handle initialisation failure correctly")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/all/20260719162850.043B41F000E9@smtp.kernel.org
> Link: https://lore.kernel.org/all/20260719222501.CB4CB1F000E9@smtp.kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Backport note: the removal fix is self-contained. Complete probe-failure
> coverage also requires patch 1. With patch 1, all fallible allocations
> precede console registration, so rollback can safely clear the table.
> Without it, a late allocation failure (only reachable with fault
> injection) can leave the console registered after imx_uart_ports[] is
> cleared, turning the pre-existing use-after-free into a NULL
> dereference.
>
>  drivers/tty/serial/imx.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 251a50c8aa38..b0f34a6e7d4f 100644
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
> @@ -2080,6 +2081,9 @@ static const struct uart_ops imx_uart_pops = {
>
>  static struct imx_port *imx_uart_ports[UART_NR];
>
> +/* Held across uart_add/remove_one_port(); console callbacks must not take it. */
> +static DEFINE_MUTEX(imx_uart_ports_lock);
> +
>  #if IS_ENABLED(CONFIG_SERIAL_IMX_CONSOLE)
>  static void imx_uart_console_putchar(struct uart_port *port, unsigned char ch)
>  {
> @@ -2632,11 +2636,19 @@ static int imx_uart_probe(struct platform_device *pdev)
>  		}
>  	}
>
> -	imx_uart_ports[sport->port.line] = sport;
> -
>  	platform_set_drvdata(pdev, sport);
>
> -	ret = uart_add_one_port(&imx_uart_uart_driver, &sport->port);
> +	scoped_guard(mutex, &imx_uart_ports_lock) {
> +		if (imx_uart_ports[sport->port.line]) {
> +			ret = -EBUSY;
> +		} else {
> +			imx_uart_ports[sport->port.line] = sport;
> +			ret = uart_add_one_port(&imx_uart_uart_driver,
> +						&sport->port);
> +			if (ret)
> +				imx_uart_ports[sport->port.line] = NULL;
> +		}
> +	}
>
>  err_clk:
>  	clk_disable_unprepare(sport->clk_ipg);
> @@ -2648,7 +2660,9 @@ static void imx_uart_remove(struct platform_device *pdev)
>  {
>  	struct imx_port *sport = platform_get_drvdata(pdev);
>
> +	guard(mutex)(&imx_uart_ports_lock);
>  	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> +	imx_uart_ports[sport->port.line] = NULL;
>  }
>
>  static void imx_uart_restore_context(struct imx_port *sport)
> --
> 2.53.0
>
