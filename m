Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010012.outbound.protection.outlook.com [52.101.69.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05431B837;
	Tue,  2 Jun 2026 20:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780431187; cv=fail; b=VaB75vEkSi2nSdhia96NQH0ZGaQqx3PhGF7uwmWyqIsVJrl4rJfGeGNZGS6Jploupvyicnx5jBb1pINbP0U0uOJ0KbWlnycda/AKtOOU9u9nxhbxtzhAkvhoeg//Wr09upIyu3iiEtmV11w5vK/z7fsuewdySzhjWF9HcRPhDkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780431187; c=relaxed/simple;
	bh=6mZneZlfHoiwfSVcTIBQ1PnSQlhXvXLigC/kjegRMBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ftjX510J9u4vHE01wDVcgWmHz+Yx0Px2CEokYOY7XfYrakRiUw0oQMU/hWZrWV1jOuhgFeV8Hu+Q0zDz2Bb04pMsgz8xI5bV6VJJpkOoeEsZGo2MGxmdqcTcJQAG3hVahQhX0bR/c6vK0sDioDwZvOtDBI8B+ZiB9WnJEs8YN+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O13FgV2W; arc=fail smtp.client-ip=52.101.69.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O13FgV2W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtWoPpdpjvnCe17F8jRAYjaThLn2H7yG+++FiazSwOmo7S2NCr+KgM6sw3HsL2y0PRQaSwHRRmBPU93mVWHH5ItyHfaFW8hqwlS6jmAKFXbd7bSAbqz7uSJmyg/lL0cy/IWr1p3pfu8/ezItQXBoIVdGp1kx7UNGEekQkZpVuIbE6lqigE3pEkQMcGg6+rD66OsjZmD/tQ8x4Ro6muw6bZcmyV+l8ExjQez4ihD/Pwqq5UMCBowMR3xJIBkBBWcs+zS/XB2iVQkvqAHqf5jWrXgrazulihvvh4b3FAVhIuo+dYNKguEUVpRzuVUknXVZtPoaQn/pZxzgBvjrV1USDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mZneZlfHoiwfSVcTIBQ1PnSQlhXvXLigC/kjegRMBI=;
 b=kwt+bnH+77caOOvG+HxWyHBYSawePtqpLcRP9t21kvu7vfSkPe2FRTTn6qsKm3T1UfH7zCeQFZ6nZKXV7V+vSyBxjee4KpuVFAIJOzl2HU1//9JvEVwhB2WqAWzo4ESbtB1Ir7KlpUIWdDqupM8V2lVq5p/Y3c6D5q5PokE/UONrs5wnDzSZ0tQM+WzqhuGFrswZ7RzryfGqZCZROQUomfnbSom0AHYBBieKIhy+fTZpobRY5CfgXMP+ysPzVUkTEKPBqFNQLLihWuGo9hwHB+6XMMsoYAMcyyPwIpk/cFAyOr7qEtqBi44MhfDNmHzc5YVQ8Bqp/fGXApYYpRO+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mZneZlfHoiwfSVcTIBQ1PnSQlhXvXLigC/kjegRMBI=;
 b=O13FgV2WO/JKNStHKrYvqCDJrk9NCrx/IqBVYgRGxl1fMu24/LR99lSRA9LeqN8u5vUvpIeDCJjdtvJYnGuoAFiIK7aedn8jAlVdiniJQa9jt5WW6dw1QeUPPVkVMPuRuiCBalgGYj9HRc0wBg1dcsP1EJFWFVEdL5phOSblz6MwQAGhXZ0vSq3d/PlAQtRmUgKanSFegKFyPU7zhPADuklTKvPbf8V7uPi/bA5ktER0R7aNv8LU4hV7U3q6OjUcgvoIY+ADZWl3Rlq6uRpylct9vvPSHsYW6Ge01FO9QTUEBhBqyLfNMX+wB8J+UWDs//XY8vfIiYd1BxFeY1TGjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 20:13:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0071.015; Tue, 2 Jun 2026
 20:13:00 +0000
Date: Tue, 2 Jun 2026 16:12:53 -0400
From: Frank Li <Frank.li@nxp.com>
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	alexandre.belloni@bootlin.com, p.zabel@pengutronix.de,
	claudiu.beznea@tuxon.dev, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 06/17] i3c: renesas: Perform Dynamic Address
 Assignment on resume
Message-ID: <ah85RaUXmaBVFkYk@lizhi-Precision-Tower-5810>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
 <20260602132824.3541151-7-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602132824.3541151-7-claudiu.beznea@kernel.org>
X-ClientProxiedBy: PH7P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::8) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 28f21711-f608-4a21-65db-08dec0e357fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|4143699003|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	9FzGFhNveCdMtVkN6bySZwSk/dMP4qfdMysJuMHFJN47JElfMWLKg3Braa6WfFNz6LDPCvfBagSl3agq3YUNsXaOsOJWXKgrYu4GoiFKsNTTK3/JnQBnDXruNxd63vVDNabQ5GTqc+XdyRsGdphVelWeDpid2bJOGPeg0GruP7aUxQIU/Fjz2kIzp7BTaB4SiAvKSFaekOItheUJHul1JxUQKLF7VuwCs4r6zGjBkz2qSqB3TTo7BZvg4PhFsWZTHc70FNviC+F1OfC7W84rpkW3TD52bq6SOItZYri8/+sS5x8zowOwvZRrzH3dQR1KVIIb3egyemDGeElAtgL9QgEc8IQGqFvhP8gLs3tOjDtxNAc7hopvIsnjn2Tnem1dx2rDUIXNO0TkghadE5SoaYwRQ+JbujHqATq+xRrSMjJxxZRYwyWk9Tv7P+pNa2f6OBQlTPzzuWe7GaMrHTSLOZRjXxFIE6+YGdsp+75iH0wWtJ/D9htsjF0JomIg5AItLUGI7gg020U9d75WnLVSTpVUp9F/cDFeVZ8we/1wXCTiMH63zexcxbKe+stG68B4Neu/tl3+mS5scFgUxnH90ciIB3vkXOp0ZIeNP8gzFokQojnXb4MDFGazAAlDKMou9EwSsZ02c+kN6xQgw7GhtZiAKfsfEsrtD4NK58jPypvp9wOfL3lQUVxTW+IlcePL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(4143699003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VJHfoWoh3ke0E8osgd974iP1zz/cxHtSkSNhkJvLl0WRRsQQ/Uy6+5r5qoaX?=
 =?us-ascii?Q?1MFf5q84VYGM2p9Ma9EzU/CO4bKXJVV/ciLzFl/QNE8cofIg5dKwJP1O4Mmy?=
 =?us-ascii?Q?sQjvht+8J2HjRwJBMLpJPSIqLnZd84lNTSFjMseTaZB9kqtYZEJH5pp/fGYZ?=
 =?us-ascii?Q?rTtgOy+PgJgkt/tm6TB1FzvUUEvxsiAcAWLoenUISiq27AiihcfcKtjXwXA8?=
 =?us-ascii?Q?Nn7lRtEfR3KnU7b+kZL03Z/hq4LFk3btexqp+d034EIx6sAHhT8XxOxG1Pus?=
 =?us-ascii?Q?h7/Z6WAtEJIRP011Dq9486XtgJYTC0j2/946DHkFGD1SobtUVGLIwmmf83df?=
 =?us-ascii?Q?8/7Mvenf1fZtb53ZK5c8reYAZiW1dDRzKJPzWnh8lV5d3f/Vjx9QXVf55TZa?=
 =?us-ascii?Q?DIRgg4/c+uOuhKbT90X0SbGm2lFkMb14QWclLGl8mJUxWaS0hQF6ovaU6dtl?=
 =?us-ascii?Q?P14TGA+L/F/v9bb7xrgW+7jAEAjbkAxdazYMV76Y0BUScTEd3zoIXQGRKNrM?=
 =?us-ascii?Q?j+uCxxtFl6c3Fh92GVL2EEP4ssPda4ZJR4ZjVxPxi2CfFexPvFNNYW31wF/U?=
 =?us-ascii?Q?i4Bb0KoXvOENhhBioZ4XlkmO9fQ24jvDxEgPn+tbYqHBIXmQZHqBjvJ5v/kY?=
 =?us-ascii?Q?Wojpmpd/Zk8jsmNRtBUgwXUQ0iBG2fjRC3pLgJdx6vOqhk0LzNRd+Xu/RQPo?=
 =?us-ascii?Q?Uco6OlSeNkxS5s76WikASArs5t7m5ZSEp5VDP/Vsj7adgG/69bQHGSJ6mycG?=
 =?us-ascii?Q?4z6OQLdJV+4L4pRZxTvwWzuN+ktbsTCub6MOSoOtKuSl1UvGlgZR3CuE06SI?=
 =?us-ascii?Q?tz/5EkibYbsbLSOyawWPMGmKfA7R/paxRZqt681p58thjDv2dyjbQDy7pSmb?=
 =?us-ascii?Q?fX9WXpfduxE2e6GCG7Kxyj6NsDaJxV5H0wr4B0C/MPM4Lhbob+bZ46iyuNo6?=
 =?us-ascii?Q?a1+FykL2HRWvhb596zp3tDS8VpoGYihEX6UOCK++cC2Ian17CWz24yO6sE9N?=
 =?us-ascii?Q?RoPAz+Fr5PFdaWaj9c6ikgwSTcNk9tDMfjK5USVSNnQhmQTBQ0UBGtQFFF4p?=
 =?us-ascii?Q?uJUTyoQ2TLZXGellIWiITlXRbt1WAw/gc+m56ZRNMt4zXXk8fNg3KF4TJ8lV?=
 =?us-ascii?Q?v0Q41KGB6qT6AEbQQwoOushWpFNa+X3PlsWkzkDkeTrR4OA+oRiA1M8Ub7P1?=
 =?us-ascii?Q?/BpePHEWd63XG7nO9ve/gIMB3jW+NHolqPLPeoNLHvYTMWShcy+bRv5ujGUW?=
 =?us-ascii?Q?QGImRC52wJdO6UMOrCF2VrANpd/WgCpwPXSp3d/1eH4XVvfS3h/FX4WgM5y0?=
 =?us-ascii?Q?+NRD7r/ANLOOYvkIf9o9vJLCai/1tfh9K60IPySIC4vlLAFJOdB0Qh1rgVYG?=
 =?us-ascii?Q?Mx2D+e77ho5TU0/FMEpG/xZwr4VoJ+Rb5My6z5J+hhnzx3UdbaMJaeTdNhgT?=
 =?us-ascii?Q?RktPtn6FG/FMSKXuKpAXOv5ZugppUk+L6EmE1Gq2SwwIvcR0zXK1laEV1pMb?=
 =?us-ascii?Q?4U5J8otPGOY8fXxBTEFDvLPR0sRlIHcmQ7xQFLGb1x6VEBvW9H7NCfElwKnY?=
 =?us-ascii?Q?QwHBI8b50GI386oV9XSIm1MiUf0skUXe0s7gFcI8J5dLIHH31siG+XZWzpwq?=
 =?us-ascii?Q?Q3kDNYPNlgWwZhEUYqd+vMXWhT8QN2X6IYhMc1SP4Mp6DON+OeqGsjtN0Jk+?=
 =?us-ascii?Q?SjffZE9KWvAUE+IALBJCbngT55X5BWHCeXnJBA7Wrn0dM11Cu6aaLm+gItMV?=
 =?us-ascii?Q?yJLOnvjPsQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28f21711-f608-4a21-65db-08dec0e357fb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:13:00.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +mHvnIHgkK2Z5rE0K6iaA/gfLanVXg70ihakamfgs7RnceJ4+tQbCTaAvHcyDHNg+wEX2UUNOMcVSihKt1neuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572

On Tue, Jun 02, 2026 at 04:28:13PM +0300, Claudiu Beznea wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S SoC supports a power saving mode where power to most
> SoC components, including I3C, is turned off.
>
> On systems where the I3C devices also loses power during suspend (e.g. NXP
> P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
> 2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
> resume.
>
> Running DAA in the controller resume path restores communication. However,
> DAA relies on interrupts for TX/RX, which are not available in the noirq
> suspend/resume phase (unless they are wakeup interrupts). For this, the
> suspend/resume callbacks were moved out of the noirq phase. Currently,
> there is no identified use case on either the Renesas RZ/G3S or Renesas
> RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
> the noirq suspend/resume phase.
>
> Since renesas_i3c_reset() is not called anymore in atomic context
> update it to use read_poll_timeout().
>
> To cover the case where the controller had already attached all the
> i3c->maxdevs devices before a suspend/resume cycle and i3c->free_pos is
> zero, struct renesas_i3c::resuming flag was introduced.
>
> The flag is set in renesas_i3c_resume() before calling
> i3c_master_do_daa_ext() and checked in renesas_i3c_daa(). In case it is
> set the previous saved DATBAS register values are used for the slots
> already occupied before suspend. This allows keeping alive the connection
> to the I3C devices when all the supported slots are occupied before
> suspend.
>
> When resuming from suspend, renesas_i3c_daa() re-runs DAA for al
> slots except those used by I2C devices. I2C devices are attached during
> probe, at bus initialization time, and always occupy the first positions in
> i3c->free_pos. In addition, there are no DATBAS register settings
> associated with them.
>
> Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---

Please check sashiko review result

https://sashiko.dev/#/patchset/20260602132824.3541151-1-claudiu.beznea%40kernel.org

Frank

>
