Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010046.outbound.protection.outlook.com [52.101.69.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1920308F39;
	Mon, 29 Jun 2026 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742453; cv=fail; b=KF2Hzvs3A8EpE8BoT+PYHVuEw/H/KTr6/mq8KZBrMNiIedPy3ynRKqzCepeKGkrDON0i8wdqUFVJ0yV+yKszmp+B9/Bd/UnLehg3YP5tRwVxOO/JKlh3C8DFAKgO11zU5MDeb35F6kyqi4bxGyiQXiosZK1vZRtbye8Ceby2pRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742453; c=relaxed/simple;
	bh=f5SdHYF6fDnf+E5aQ2QxE3PT3PLlqsMPBb+lOb6Az8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EXO51nclzW5lgaBxohJtSNSzIiuCyrapLS1NUimQ5gI1wmhVeF+GP1/R7iYAVxlvoRD17nVGXIlqsOrvbsdCemQAwQIr+3Zu5y3+Dx4MIcysYNjvpqjCNUgGqo1XN6y8OEqGNoTmoF3pm21WTy9TSZHM7F5OsKr+ji/ZbRgZ320=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=B9WLH1iU; arc=fail smtp.client-ip=52.101.69.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="B9WLH1iU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYfLlRH9lgB7enm74XOfYGJIkV2c7S6FbkA64TvLFjMQHmRoKpWH9D2cuwBTaS5CDPxs4WbOQO6rCHw308XzV3D9gpA1ifi1G07TzyS3hleyJHuhTrGtyRSsRjl/0Gp+gaYSfoFZJ5C+u2oOl8EyFzbh/KIjQwQzrWUA63UffrSdDdzpI8QVhkp887q8w1vlkoFznT3M10kYCnRRW7O+RAY8g0LZDZblH9c6jBdJBEWO16n5aCT+ihJLG9OBctCrKwGQerlrHFRCJcEmvYJx1iaRy+y+LOlJGXmpy5jhYOFdB8+GOC4CJ8hq07XguHBmV3z1cQKhvBk3ZNLOrLmjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/R4V/K1DYcg6JkY7/Rl83snI9Ud1EjneOdY5udjMq8w=;
 b=bAJAibFH5huIAgQxmvSh1AvMG+WSakjPRvNDsJy3YRoChWBCNC3tR46LFdm/w/R3DDPQDs/KkjZgVUQJKC9bfcHpjmnDzaVTp4y/k7bbAwrpW6YaGAltiq7pBgyQTQWwH+bugWVRtii6eW8MHYcKmPl6ua3iir5xKwHXR004hiCiMozfKmDmndMDCHE22IpEzgZXqdNDrK+atQLLUf2/IrOHCXyGqmoCUReo0JNWX4tGsQ30K+Ukg1Ka6jMldDDKtUFBmhdniZwlUvts99EI24sHjSW+yiYQGtOMMPNBuEhLXFyGndWeS/ZgMVtSw5p4FbVJ0BvBUn3iTX9uVbm75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/R4V/K1DYcg6JkY7/Rl83snI9Ud1EjneOdY5udjMq8w=;
 b=B9WLH1iU/OeklvpZoOljOg+ytShnrEsibiQBapd7k9n/TvSDStRr/nwmX2ic7XiGoNZmubRT3L6Rkb3WmQjWeeBL/Y+fpIPCJHQvXxpj11de7cWI6Jh37etT01TCW3cpxA6eOM2lsWtVL+f2v3/PIHGohdc6DWWn0rQJRn2rspiu/PScbb5bDZtZYSXl3XQwDbmvVkBgejtjDtQvgzNuSoAsVIalRYxcSoyFtsG7EplVp9cWGbZBBhbq0oLsshXnzeRRhL5DaO3sSCsVtjVpuXhLvG3XuxLe8wMfCle/v30ApOgxKpQBS2PrziYKgJSD1HAAdl3myvc209zzdblPsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU2PR04MB8999.eurprd04.prod.outlook.com (2603:10a6:10:2e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:14:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 14:14:07 +0000
Date: Mon, 29 Jun 2026 09:13:57 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liem <liem16213@gmail.com>
Cc: carlos.song@oss.nxp.com, andi.shyti@kernel.org, biwen.li@nxp.com,
	festevam@gmail.com, frank.li@nxp.com, imx@lists.linux.dev,
	kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de, s.hauer@pengutronix.de,
	stable@vger.kernel.org, wsa@kernel.org
Subject: Re: [PATCH v4 1/2] i2c: imx: Fix slave registration race and error
 handling
Message-ID: <akJ9pd8uhXA6y2s9@SMW015318>
References: <AM0PR04MB6802B863CD9B9AE1609C1785E8EB2@AM0PR04MB6802.eurprd04.prod.outlook.com>
 <20260629023829.152651-1-liem16213@gmail.com>
 <20260629023829.152651-2-liem16213@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629023829.152651-2-liem16213@gmail.com>
X-ClientProxiedBy: SA9P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::7) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU2PR04MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: e173bb87-81a5-4b92-f576-08ded5e8aed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|23010399003|6133799003|4143699003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	z5ZB8jNLhpNwAC5NTH+tysLvvtOkpiwYib1eHpuZTf/RMm2/WmIPtPCZJyd3K37qnU38Tzd9Xqxg7fs2eZ8+pcsps7OlcB+Rn/u81dT/5xghq4gtCYyE+BfEzfrTVw3JANLFhqMNADSUtZ+vVE8z23nN990Ug64ARjicP9wZpp6L3ytbylLeLDnYYeGY0feKNp+CvVWpadn0ygIrDWplqULuU4QGQQcsXuBM5XQYaiEWNTAdaWpn4YhfizlT8hCYK1nOH1EurGwyIX3+4rKepNKidKAD8Zh/My7wyowyvKvCJrU5xAbeFaAzmVG5toayvkCIEINvzI/CvG9yTy2Ox7ZZdWsb4Nf80qYyOpzfybVxhkCLl3YAHAov1k4FRYwuXiSgQ/F+shq1KMRpc6kcIPw0KzYeERzlRwivBroB4noYPa+n9m3fADoSRqh3R2biZa/j+eM8/QQ92savkzRQlmGO8rG1W0xuCcYSasN7/cLW94rozj4QBOuRXgOlWAncQaBm8IUoQB0l7ctDH2ysPFDvrdru4UpBuSBRft3tyE6QuFaiafDYokZe0PHNO70miERyio2EnPbrR1YgogQpObxyCA/xiCW/7WM7ZVaNYRZTqUVdp6YumTjiExrjbX+IKoM6YubYbCY26+XLfmq0K+syuPQkBBanB6N3ABui91U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(23010399003)(6133799003)(4143699003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LY602QJFxI/tddPZsL+psJgimEcE7B9vohQCAUbyu0rRnds6uVC8MurmxIrD?=
 =?us-ascii?Q?RYvQ41ZqEf07KOjQpZx3NWtzkheLqhBz/ZKjOi1xHZnuClXaKTBZ9yzStU2W?=
 =?us-ascii?Q?FMsLGskMo4gB1po1OXFt1q+qpEJUJkilbZ4jzzEpEpNqtotZp1M4XpcT4+vN?=
 =?us-ascii?Q?pmm8XHeZXoU8s7R6ffZK3szppy7pL0ZgImZ9ky6X2t8p9PLlKDzSSstAm6HZ?=
 =?us-ascii?Q?KAe21K7zt7ftkcqYPleb3YTvk9K+5PFXBnb4skqpVPBmYgpo204x/BkjOCGO?=
 =?us-ascii?Q?mcm9SZz+IybQTURiSNq2R/KmtTHgV3kHtg8RS05wRugnA4rGO9FaP07DFJDW?=
 =?us-ascii?Q?9E/8lOdSbxu8DndeE6eZt861rsSR9LmVY8dvnfZ9lPnTg0xYud8gz2vaDnoG?=
 =?us-ascii?Q?bVWJXRRn/K8qqUMe53055XGZmLzbuQmJQokgR77iiIr93dPsgvmWq4GT3vUM?=
 =?us-ascii?Q?n7i2dabLM21GOgW8eFSkoswNRU73tiLDPSPdf6h56TUtRJ6PGIyA/nzAq9LA?=
 =?us-ascii?Q?gEsMYxzctP7w5ka8XG717zpoZCoQ0M12k7yoyCHXIaI4Lt+X84z5yXb0jhm9?=
 =?us-ascii?Q?raXTroLPGfCZnOJFb6wNO3PToa3b/AjQywTPplrU/y1mmNF5WOBJmPLDxFnS?=
 =?us-ascii?Q?CL6GYfYYRyZml97fzjSB5yL5x5JYk8Znp3TCAOGbsDPL6iSkrL15IFQsCJ0Q?=
 =?us-ascii?Q?MTewnoD/zLA5IaX91I/GfHr4LcrGLmjuRr5Jw1NQl0SDUEVgjYmOJP5Udf3L?=
 =?us-ascii?Q?oQnKEL+ME7tSnpR4VWrcMgozQLt2qBtjsVnqkuvYoc0UraCBtQ//mEK3IBX3?=
 =?us-ascii?Q?GfkCQpeU2wwI77WBxYAKz+hCS6JhPw+uifwmhkyRWVCLZzR9jTKWMB/IUw10?=
 =?us-ascii?Q?atiCYHHCIHlLv8MdGT8GyfZLU5f5+bLn+NNd5PUSnfX7ecvMFNaL4XlXzcqz?=
 =?us-ascii?Q?Ub3t/qp8Z/FtSDIEmdpQQs/KBx9ZA5Ai/qHTOGBvZhlT76d0LpOwfHCcntxL?=
 =?us-ascii?Q?q+4fnRWz4BocXOImUy7th3amEkUeDjXMFmFAj+iPYjVgl1r8EXgDEri/Lq1s?=
 =?us-ascii?Q?GTgYt6pBew7IHOQV4iaupOTHyEDZBYNCkZ0Y9srfQUiesDkPXgBGTRLmb6fz?=
 =?us-ascii?Q?LuOtgdhj1/TpbC8LS5pqamFN+eiB7YdJuo6+dQEmHS83UXS6Y/T6hlMQGhck?=
 =?us-ascii?Q?HXcZ4je6vzOX2Qg9O6FEzGlGlloeOwbx0a1n9t0Fc0T/u7qw9lwPBWFcvEOD?=
 =?us-ascii?Q?82npxqFjDGWZxbTUpIcn0y3cgwiFdJEgGLp63SRwtqLkluHstfaXBIYROMKL?=
 =?us-ascii?Q?E+1KIJnvaevxqkM+hzNrH9+taqu52COESUMNV6jmaK7XVPu7C4wt1nJV64er?=
 =?us-ascii?Q?XWPr8uvIxo4gotOpbQRQ9yjKAisj1k2hGn8zj92Ld4yhw07ZE9ee8VHtnjoG?=
 =?us-ascii?Q?M1osbGeP2pirySVvjYVV92FDx0RpcnBdTirTIGJay48uA14cFHx0KTQYpF/m?=
 =?us-ascii?Q?LGnC58diIBd0V71pNCw8lyfa7T6NQmLiTTOHEPrS7MT1aCR7DmSXcYl9vPFT?=
 =?us-ascii?Q?5eeQm6mrjwZUvXvnn4n7Fx5ynBVB6XrrMDWSUbLVo1C49qkP4bc/hZd0/B8i?=
 =?us-ascii?Q?LK0x7nGQ3EMiEbrlffL+Ph6P/jXCQz88iVbJUVyZfb4eq7MXz/gbqDZy5fEn?=
 =?us-ascii?Q?1RcxAuq/VTjB6/D641pAOgjdZg3JisDgHWpJlCzSBcAW5E8H8EmPrGl6uNuT?=
 =?us-ascii?Q?Xph6SGYQCNFVYvqk2Kz3JrDdGGXUWhbk3fmz+iKLoHQs0OGhuKVE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e173bb87-81a5-4b92-f576-08ded5e8aed1
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:14:07.7757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 516nEV0NTO+iWpz6SUZJ/cNu3cd9Fb/mQNW4Tr3a3AqoHZKMpBtVtGqffy3wPxiWeBXS59xHt60J9CsL+ZSI/P6fx9Zovmll8DdJnTofkzheEVaPreWMsmBO7KH8+7As
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8999

On Mon, Jun 29, 2026 at 10:38:28AM +0800, Liem wrote:
> In i2c_imx_reg_slave(), the slave pointer was assigned before
> pm_runtime_resume_and_get().  If pm_runtime_resume_and_get() failed,
> the error path returned without clearing i2c_imx->slave, leaving it
> non-NULL and causing all subsequent registration attempts to fail
> with -EBUSY.
>
> Additionally, because this driver uses a shared IRQ, the interrupt
> handler i2c_imx_isr() can execute concurrently and, after acquiring
> slave_lock, dereference i2c_imx->slave.  The previous fix attempt
> added a lockless i2c_imx->slave = NULL on the error path, but that
> could race with the ISR under the lock and still cause a NULL pointer
> dereference.
>
> Fix both issues by deferring the assignment of i2c_imx->slave and
> i2c_imx->last_slave_event to after a successful resume, and by
> performing the assignment inside the slave_lock critical section.
> This guarantees that the slave pointer is never left stale on the
> error path and is always valid when observed by the interrupt handler.
>
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>
> ---

anthor question, why v1..v3 use the thread? Suppose each new version should
start new thread. Do you use --in-reply-to in send patch?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v3 -> v4:
>   - Instead of clearing the slave pointer on error, defer the
>     assignment until after pm_runtime_resume_and_get() succeeds,
>     and take slave_lock to avoid racing with the shared IRQ handler.
>     Suggested by Sashiko and Carlos Song
> ---
>  drivers/i2c/busses/i2c-imx.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..2398c406e913 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -930,9 +930,6 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
>  	if (i2c_imx->slave)
>  		return -EBUSY;
>
> -	i2c_imx->slave = client;
> -	i2c_imx->last_slave_event = I2C_SLAVE_STOP;
> -
>  	/* Resume */
>  	ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
>  	if (ret < 0) {
> @@ -940,6 +937,11 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
>  		return ret;
>  	}
>
> +	scoped_guard(spinlock_irqsave, &i2c_imx->slave_lock) {
> +		i2c_imx->slave = client;
> +		i2c_imx->last_slave_event = I2C_SLAVE_STOP;
> +	}
> +
>  	i2c_imx_slave_init(i2c_imx);
>
>  	return 0;
> --
> 2.34.1
>
