Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011042.outbound.protection.outlook.com [52.101.65.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D63AA9E2;
	Thu, 25 Jun 2026 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404181; cv=fail; b=RI5KuqvsIZ4ltpg+xtNXVITi5hRPq+HJqKQRQY8yIv3EUKuJm+tNIot6OtfRMfpPK6CLVUd+ZQBF9UFBisZvHhnwJY+j5Qb3inaXQ+cFREFJ5DjYiFREnuH/f04lnyefEeqObs/g48d6LztYMvpic9P0w7qOOeNyIWn7s/5B1wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404181; c=relaxed/simple;
	bh=aDNu8SI9XOMsLflidUwkhRPD9dqPl+a2sUeiFYMCuNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YzCy0GatAR0nBw1hJrijEUcV69YPDJfC5drP//fMPnPVnhV7ObEdqQ/o1fwe9/mtU0IPvEzG7DdcGHZL3LHOHeQlMGMgR5GygwdpFNSMfD/KPSSXjvTtDJVb06/nn81g/YWOThYNgH2mnimZpnpzyVYKDZAblf9UraGrUYf0LUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HPWFHdW1; arc=fail smtp.client-ip=52.101.65.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HPWFHdW1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAyq7EuIVbkGTQPK3HIzyoEbJho7z+Lk5Wjw/qTx0jlP9mAqXMmG6XqQ/6uLraHzenzH8J/dUKUcX3oy3o9QdK6bdcgPPavVXAZU9LQMuZyf8iT3L5PtiSz8xwz9ekBfxMFiFWvbR6+IxYm/ciTSx/xbrMQayz9Fd3zDgi7mTOkSa2opP6t3kULcA9VITVpme9Hq4ItGJr6R4v2ztSTgkI+kWPAF7tWcMO1as64LigWtgcQgtZNSS1mQjLrqeNbgN/gchKdJXLUefQq/cJhngqZLNdhsfKlp/GHX+JQvC3O7Gss8qnjkT8nabRHlR//cpdtO+LjF3gfRJ0gjht/IFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPOL0Eqdv4R4nmGH4LgFX2vwQhWwNia4bGgtDOfeSF8=;
 b=YqPYgDPepFvfvrWzDUbfxJetZD3+kcEl5zDEq53r1jJcqOVwCgSoNpoFb80epkiOGFOzpgt/XipeAREIgrNzsgXjERl4AkjdfzLvhycXSYWu4Hn6Aikdh99jWNZapF8Cwdous/shEEBqSTE/xoJD75i0y+c5Fk92sYVbBO6n6uChm7U/9NcYA+5rJ8FxLXFk0G9iKSHVsOP3+fNjJ46Rr/XJWwsM+x6JOh0PclVYUHchDUplnOVYm5Ih7ph56JKhLHuDRuUncs3F5JjmTL0YdLCt2cWo5NO+vdaf0gATs2Ci285e6OoSkRrDsEeEkJpn5agxqP8ix24M8vosCLltQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPOL0Eqdv4R4nmGH4LgFX2vwQhWwNia4bGgtDOfeSF8=;
 b=HPWFHdW1IeDEYCS7kU3EoZf74VJyycWEP6v8C0EE0LenaD6n2+3PB5Vqp3Y67H/DiuyOypzf569G9fyz7SJJuMki5sWXmsxZrvMo/Eiy9I3wduM3DsKp5qPvquoRbhNpKayICqvW1UpSEVo3EwZLeD3A6pvqYcuS0gBPvTR0j0uonMLZpSxRskTlQpJ6qkwwV987dPNWrvOOJxoTzGo2ckkl3vt0jTRCsx+B9sqUML4CYwj9GGp/Y6zYOWh+0Tb71XvCXqiwrhjKfYFl43dxq2fHx8C1Qgg8AHQZF87/b87pa3IK/r72CWnc/jfiBdNpFC5S1EB1QycLOYbaYLX1Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 16:16:16 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 16:16:16 +0000
Date: Thu, 25 Jun 2026 11:16:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Liem <liem16213@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Biwen Li <biwen.li@nxp.com>,
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: imx: Fix slave registration error path and
 missing timer cleanup
Message-ID: <aj1UR5ddawsdMbZC@SMW015318>
References: <20260625071130.93544-1-liem16213@gmail.com>
 <20260625160219.55116-1-liem16213@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625160219.55116-1-liem16213@gmail.com>
X-ClientProxiedBy: SA0PR11CA0195.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::20) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e898f1-9caf-4e7c-f07a-08ded2d51572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7csmJY2ZgRvPBdjzQ00Y0IVDNT3Xi2+nHrgXG9ki/chTbwU/+Q8dNdg+TjokgD2egpPAhIOF/1QipjuEMj/CHj+z0jEbqHpHB/3fbx2LSz19elmLk4pmNCl4gidc4mIZWmvwONOh1UEILAWEmVYLpp8UmNa/jN5ievPlFSYY+mJt8xLTr9y3uy1q12clWbEbmBKvMESlVM91MZmAP/MQbeD68HVQdQ2G/fpx0EC90xcPdRxNk8Q+Tj4X/nMvvfxrWUA9MUBwHVgdQMn+Ofcuycd8SKgbLomvrZyagEwvdJtWSJyM6O+gCILJiLzPyv21XLytMSPxO466XN6krNlA5U7z72kdKnTzXWMvC/54tgXAV8iNTl0cvH8EZA3QM22b+Mtqp2P2sY9DOuoLa9PqGH9yvsNLMzyW1GWbNf7rD+0oTY8meO0rZl1oE3Z959O33QYczXY7NPMSMI49OC5pcHuSXtVaoBl7VlGVXTI/shrR+n/EY7GHvFL3psd2HRN3x9LVbjOLtIuEZlUkQMwy+YXzPFfoGe0Y0OFqJsw7/WprY/IumXrJHed/NDxu8XogJCGYZGlt0sWTWUMq1uooi3iKvYAfU65Z65o307Zh9btXEpfWSJmijVZQlMLGh/qHCOuoS0GlXrkgI+xK14PT6PjymfB4xYY5XsNWT5BMnlU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kjAMQWgWeVM9+wjnyQdKanJjBRQaBBSwACTBPD95lXm1rV6+cEDBAkuaHoby?=
 =?us-ascii?Q?CyM3RAUteO36qnPSPgSVAK6KWjaSyNBucpEsWTJGyeqKU+rLfWWvOYKU8Yn8?=
 =?us-ascii?Q?8hLi1IDXrtGNbK1Wa6mS2EDEJKVDOEBWJE2QJZSZYjFwMJMLNBl00WhyiCYM?=
 =?us-ascii?Q?INT8901HW8EXVmsUhA+FapWUKj8HSqlrrIWYVXQeLXuNkLzTKiVyYmR3E0/V?=
 =?us-ascii?Q?FQhpS5fIR1xpaBVWFGUjIahE/L41VLWt4Drfck5BftjgpA28AJtdlNWs+Po/?=
 =?us-ascii?Q?tve7Qn79/VHG1izzn7DYlboY/1Nf4/6PM4g1PTuMp4E0Kz7g9zGkfYCw60pK?=
 =?us-ascii?Q?EXZM4OJZszg4xN93K6E1sJPls9x7/A82XN83gaJT8PJdnhZ0m2NxbXuFXiBE?=
 =?us-ascii?Q?4eAFLzrr527ByhYEDoBGGjUW7QLjIx7tGx7szeO3lwIuURXXVGIr4onLnHjl?=
 =?us-ascii?Q?VpuKZ/RnhxZsnHA47qvphny1QOCLByEgFtJJ74kuZ1fmV8RMPzW2rC2IaPJB?=
 =?us-ascii?Q?siQPr7jGB9px5FvdfssE76hCJzOdPfNT4ybKU8S9ZM7H1fcg9f7LAbPtoeoI?=
 =?us-ascii?Q?gjMmayy1fTwiUSVlkgy//v68yFzzeXkGsQbn47aE8djwmKkNNNhDTgSOtjL8?=
 =?us-ascii?Q?nn1B6ucJAOb15HsK5cXbGa178O9sD1Az4h+GxwvuqJ6hamxxnuqVmTBCzg/t?=
 =?us-ascii?Q?W2lGrOuU74f1N0SYYeDfYgNK+C6p4YMx405eaMBG2DLiJm1UsMcI2lSHvZE5?=
 =?us-ascii?Q?6Rb8Uh9ttLrRmYOjN+K7EN7cxqi6R1lmMT9t+Foai1acJ2qbwIT+8DiVT7Nf?=
 =?us-ascii?Q?8Gm7E+oVkKj2C4HEqEJMYIcXO9d4Apa/OvPPq452LISoLTYaIGB98Nk2hL5L?=
 =?us-ascii?Q?CrqFr75UHDS8ldUxngpw0jChc8GMMiAxv6ySzAcy0RlfwS/Oi1edVON9XFYd?=
 =?us-ascii?Q?YvOFXKbmiard4A6fZb7VAi9QE5Y+o0GLpj6qqcOiIHYbN1NjURSX0atWTbou?=
 =?us-ascii?Q?Vy3OxZkRlP1a7in4XtUeiZVSS0krXs5nS0hfr+f0mKvJkxm/+x7v5jB8Ovvs?=
 =?us-ascii?Q?yAO9wZgNM1Iv4vZco/39xWgya5gTpEzJ+jJg+KwVlfSxzjskeZCzcUbzbFeb?=
 =?us-ascii?Q?69L7uS+4lzbGU6trEdQeR+uI6XH85oXB21SD64meEKUqzThK3raG0FtTMpqC?=
 =?us-ascii?Q?YJjUuEhVsrfaeMMBIMJrXPuwo2G+vYRP9rc1TWUY84AUAgnmd/0L3aemdfpL?=
 =?us-ascii?Q?cEHyRlweU3KBUI+lYL7UGnd9dJp4Q2ceh//L6Z06wogQZZqHwNv/BkwdQpot?=
 =?us-ascii?Q?KRh9HgolBxOTkVHu6ybKVrpRCSLeGS1mdgxAmuzP1XCSYIdf/6xdbIQNKWv1?=
 =?us-ascii?Q?bGIPGo7O1erOtptIlsP2iyDulU9QMp2UhH/JVYWoddybpJBwU6b6OYA1j0v1?=
 =?us-ascii?Q?MTlaq+0RLHqBzgnegZXviRszIp2o5+qpImPKpBaNnz3MpzRd9WVS5ifM+exf?=
 =?us-ascii?Q?6m5ClyDVwSsGyEhU3g6f7c1dYnN3bX9IDjMhtYPBgKGSJsXyd8sbV6kDfUp5?=
 =?us-ascii?Q?+bZiht3JXfcgVdHQ9EIr6LhuFLU3i+adnaMmL+f+j6SV0qlHxFU0R4svChwd?=
 =?us-ascii?Q?/rVBQRWxJjZqu3/D2kyXZbdAogNjTbDcx8eqqztkR+hrQaeRel8VDfwx+/kJ?=
 =?us-ascii?Q?aL92bq2ZYkrBAs0uTp8Y5JHg0rn/Zb203vcIkV8swWRQp9A71BwhO3FRY9xe?=
 =?us-ascii?Q?sfcZSe3LDXePU0/iIT2yd1kxRnSD8/4OpMAN+JbphYKBj158qnbU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e898f1-9caf-4e7c-f07a-08ded2d51572
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 16:16:16.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M2DIfh0P3fwTG6qCdGAdPwKVMOECxjYqUoUFCjS8D04C+BwhgjtjzAABZ4d/TT5CWZMPRVJXw80fiFvWf7ySJ5erGdkIgB+Gb/Utx76j518DjpxmZS7CQgCSUCvqiCRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805

On Fri, Jun 26, 2026 at 12:02:19AM +0800, Liem wrote:
>
> There are two issues that affect the i2c-imx slave handling:
>
> 1. In i2c_imx_reg_slave(), i2c_imx->slave is checked at the beginning
>    and the function returns -EBUSY if it is non-NULL.  If
>    pm_runtime_resume_and_get() fails later, the error path returns
>    without clearing i2c_imx->slave, leaving it non-NULL.  Subsequent
>    attempts to register a slave will then immediately fail with
>    -EBUSY, making it impossible to register the slave again.  Fix
>    by setting i2c_imx->slave = NULL on the error path.
>
> 2. In i2c_imx_unreg_slave(), the slave pointer is set to NULL after
>    disabling interrupts.  However, a pending interrupt might already
>    have started the hrtimer (i2c_imx_slave_timeout) before the pointer
>    was cleared.  If the hrtimer fires after i2c_imx->slave is set to
>    NULL, the timer callback i2c_imx_slave_finish_op() will call
>    i2c_imx_slave_event() with a NULL slave pointer, and the
>    last_slave_event check loop in i2c_imx_slave_finish_op() may cause
>    a system hang because last_slave_event is no longer updated.  Fix
>    by canceling the hrtimer and waiting for it to complete after
>    disabling interrupts, before clearing the slave pointer.

Please use two patches to fix these problem. One patch fix one problem.

Frank

>
> Both issues can trigger a kernel oops, system hang, or permanent
> slave registration failure under certain race conditions.  Add the
> missing NULL assignment and the missing hrtimer cleanup to harden
> the slave path.
>
> Fixes: f7414cd6923f ("i2c: imx: support slave mode for imx I2C driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Liem <liem16213@gmail.com>
> ---
> v1 -> v2:
>   - Instead of adding a NULL check in i2c_imx_slave_event(), cancel
>     the hrtimer and wait for it to finish in i2c_imx_unreg_slave()
>     after disabling interrupts, as suggested by <Carlos Song>.
>     This avoids a potential hang in the last_slave_event loop in
>     i2c_imx_slave_finish_op().
> ---
>  drivers/i2c/busses/i2c-imx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 28313d0fad37..04ffb927aba9 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -936,6 +936,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
>         /* Resume */
>         ret = pm_runtime_resume_and_get(i2c_imx->adapter.dev.parent);
>         if (ret < 0) {
> +               i2c_imx->slave = NULL;
>                 dev_err(&i2c_imx->adapter.dev, "failed to resume i2c controller");
>                 return ret;
>         }
> @@ -957,7 +958,7 @@ static int i2c_imx_unreg_slave(struct i2c_client *client)
>         imx_i2c_write_reg(0, i2c_imx, IMX_I2C_IADR);
>
>         i2c_imx_reset_regs(i2c_imx);
> -
> +       hrtimer_cancel(&i2c_imx->slave_timer);
>         i2c_imx->slave = NULL;
>
>         /* Suspend */
> --
> 2.53.0
>
>
