Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAEF481FAA;
	Wed,  3 Jun 2026 19:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514794; cv=fail; b=TFgnN7ciFFLcyB3wf3w51V31DGdQPuSace+wSOkNdpw5maFJQKBxVgUKS7Y/mL7Gjn4avlwsogp6LkCGr+dM9pSTe9D1Fj4TPMdDnky1TICLj+Bxb+GJow9zc18qCVWFv2GYrJMIW7Bhxhd6mbnu1U094zAcgqUyyjqCAp+nlKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514794; c=relaxed/simple;
	bh=SLYfQGvKLOJGAhD4fmxUw6Dny6gRxg8o4Dqa0AuKQms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mE4fODSzIuymrdGjiNF+hE7FN66xVQR385Xffe3OSnHxAa4rSXQ1UhcLEEvoO4tP5hG2Yj/uixZk3S4CEOrx3BEdkrggpYNFUX3UotKhZhxxTy2lhBDkQ6hlgYSAv/rkIUgYediQlgO9zI+Yk3uU4rcxuPUYKrqwmX4vX/4TS5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nO/BDpz6; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nO/BDpz6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ptXJIMDVeUvTjNyBqibHZqWNq26xyjmWGNraoRyhVZnqQfyEWC2yBcNFaq0zw4XWRjBfE0MYulBJeocALbDoROF/GHUEuETpTQ6P220PYnBXqu/tEspjtyQLTd+Sk9pEPJ14fVrXpEiapd09a7Sl+oO/IBlNqZNgmdrv1BhOx6yHC/zKOpSQRzGYNF4K0QyZy68YhZurVcyumycq0YbNEbfW58qs37r6ylKyarQAbN1jdVTcU/PXTCnjmZRpoQBjlus3/g8upWI3XcVKSOvUULyCNWqqZnKlFf2oi4BBtdh4WLrp2jeds59bq8oD/nLUq5dzBSJsFovwCcrgJRWJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJgSkF4SziIRczhYR3iStgFv0Et7BKhVCLtmnOgKLpY=;
 b=jvWMVe0AiRf5A18PjKmc22Tmdn9vaRpsstBGFYmO+ethUUGXn3+V7SdIhyAtrspl2dzyoIGpO9z8AlHy1BZDqkOI5K2YxpPHYFtd4EOzEBDr//OKQSlxPu7/KEgHA3snF09PZWHuTZsJgpRkxjfK3Af5MmZXARv3Vu1X8cQkTfWLZqAud4lI7rGWPX+H0Ey7fT1ThfUsHvqtBtgjx11i5FejmRQTQcIvmv5JkMSYGn1F52OUVxoIo7pesm55DUa0GpbU2qdSEcuX2RtA3pGs5f5/HSg6l2clpSxlH4x6BzqvGHozL/JqL4f1vJ9XBI5JH4AbT12dTzx8glMf3bVE5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJgSkF4SziIRczhYR3iStgFv0Et7BKhVCLtmnOgKLpY=;
 b=nO/BDpz6Z2U4E6C5xm/xXCejIFmyDisNa40icxK9Td5L46k9ZuVsAllnoQ4HyUME22pvLXrVHAF9Jb+ucjg6Kb+QDPPUVrtXVwVLRS5I4DW8b5bsaEm5TewvuNDcWTfzquym5/hwEFKvbBAdgVwrUXIrr6GrzcPvWXkJo6bQBWCTSkfBBKc8gL0lRzn9nrPHGZS8T8KP5PZk5kokTqS2E07rkdEAi8OnyDDoebxua2qa2AnCPWlC9NftGsgbMZ4JEoTy+QUv7JbDBrXMK3GaGPNpk8xp8ayu4hAXtLZPALonf09s/dlcenEGCQMCisSLjCihdSrHtggDoXRdRnb2Cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 19:26:29 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 19:26:29 +0000
Date: Wed, 3 Jun 2026 15:26:22 -0400
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
Message-ID: <aiB_3kneo2Scy5bB@lizhi-Precision-Tower-5810>
References: <20260602132824.3541151-1-claudiu.beznea@kernel.org>
 <20260602132824.3541151-7-claudiu.beznea@kernel.org>
 <ah85RaUXmaBVFkYk@lizhi-Precision-Tower-5810>
 <8687d3cb-628a-477b-9dfd-2db8c412b277@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8687d3cb-628a-477b-9dfd-2db8c412b277@kernel.org>
X-ClientProxiedBy: PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: b8851293-d61c-4ee2-5dff-08dec1a602e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|52116014|366016|38350700014|11063799006|4143699003|5023799004|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/UeRAbVlD9AT6bUsfG7lZNZtQqXSwLevj/VAJF6HBfuoJiqSneG9cb6ixJrV0W8NhDqSfsTCJfPdkmzhO8+Tc+INV+rpakjTSrzkGTImAOij8UT+8gb8f3sMXNrwedwoZnfP+bp/VjoZSwnqJtEAzC4JYFVxNfg+V4F4+TtlThTss4XffdsSw6gXxIZquCpBEWqNQ0K4MdwZFzuJn5YvX/v1MRxVl4MVIMqs3BhnOeVPeVWD8Qz0cMhVt5jHTbqXNBhkEFhwJOrW5G06ilU4tiqbgSpo/DJWI1T67Dy/8oo+AkgFNAjReOJpV0qlOcn0pwQdvn5IliN88f8j5Ggqw2oafzANK/9R89RQd806t7Qa3U5C4qTzQfoz+EkDtNnJ7FOFnD9oGrYnO1+UzQJQmYiGNinCOHfpldOhyK3jKg6pVTmEbV/ByRsjLzazMmI7WunSXSNz5ULERce8VGvP6v/c2VuHnEYiQq7h1fJT6OUZPKNAy3WPgvk+UAlTS57agKgMdu91WV8FP8VVUJWw9HWjujM63SgNkpbYYBquP3+zGNRcs0qOE9NVMCUeJbOqlkImb7zqZdMwx5S88nExilGtkU1u1iRYm9SkQqtlC3ndEe/+8cZ6WwZ6metV5H5L0DHmb77sSU4iDohAau6m4F3iRPVL3SGNe3S53Ln0kZBu6EGfbQA3q8x5NxnoYGsy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(52116014)(366016)(38350700014)(11063799006)(4143699003)(5023799004)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFaLv9MkthH/6Lyj2bI1Q5Q6QgWK8lFejjt4NwqKuED1OKHY2gRVxnBPhWXe?=
 =?us-ascii?Q?L2OXrnLOfpZ6RncWTwr8361WHkPHlSZ5Uk6/D8czQUa+oEqJtiM1nDIqRQNc?=
 =?us-ascii?Q?U/Ab4NCdx9smW0ykBD1nwXswM2rtOvd54T6Pv1J02ryYvAIwrn2WJaEfEWdz?=
 =?us-ascii?Q?KVerCE+k7pCZFFAFZD8rDbUsdNOR5WRIEvH1gKY2QgwknHtBayjR+GBAh/52?=
 =?us-ascii?Q?yPY5bzpQknvMkbVZQSEIlNvffxanMX7H3ImkdIip3QzrycLyDIIsY6NUPbxh?=
 =?us-ascii?Q?1AgUcT9rrASOVEJpDS+nz+455sDNOr8mXqLG/wMEOaLZ0DgtnBanLFIv4XWF?=
 =?us-ascii?Q?Vny5xggkMX8eTuReSX0eR+87DYeIvWV8TZYsT5mPfk7rl0UiDUpvrgazaAjz?=
 =?us-ascii?Q?nDQs8MBaS8n/M2j5r9WGg67aHtEBvk6T+4EgC5HeKTy5SDdv5PhLG6SgALkK?=
 =?us-ascii?Q?B6pUDurf7g8vQS/lHU+vG+EnFevBgYiYHA2/LknwCEzVc+zfELtrDwTejO4l?=
 =?us-ascii?Q?lRbmeQwbOXckmcRVUlF2Pqj20GG4lZ/OeqlhDNgEJtfuDNtVY77+hkXZHTdN?=
 =?us-ascii?Q?FrsUUthCPeGPWzlyEsJl2yJ2NYHN/0Xa1XpTuHlvnM7rSERMgI2dhKzKf4uc?=
 =?us-ascii?Q?OHx+R5RSw3dHPDKHE3PyNbHH9i86BuyZ/krwhCxS++0f3y3Yl5YQJKE+eD8W?=
 =?us-ascii?Q?eNicnZGeAsmSdeSXKY8VCmUuSWc2cZBhP7IQWckXB48rY3ucTTQ/P/JIePHf?=
 =?us-ascii?Q?WBD2mAhLzxlO5VPi1V9u5MQ/nveDkJhEd6ddbWCZDyNu6YugO/+8bFpU0Cjw?=
 =?us-ascii?Q?Gr6GnzamUVlixwm4Ysh/wQZXFEfZedclJZG9jSYS3CXvj98r7HqS8l7l4rIK?=
 =?us-ascii?Q?emhpLLH/lVA048KvbLD53iQwnlfstL3hdL0uQZFJyOXWf/RiAsSL6Vi400sv?=
 =?us-ascii?Q?MFPWq0jTelNqVmXl0BPKOIp8BxEE69Hn2QfdkBYFhbHjwMSDxNLi6LhKl3Ka?=
 =?us-ascii?Q?HGW/n7D8JLtGdc23ulSSjTgDaK0PYUZMaJffiy+Y7C+KhONXKsRZujYWgkMr?=
 =?us-ascii?Q?vsGLQwIIysL2s4wu5pf8ArtjyEVdTyXwimM5KLxQ/UlRpJlIq5HSAuCKif0V?=
 =?us-ascii?Q?SmW/3Q/P4gmgEKh3F4AFuvaTO5GfEQvzbYKgs1FIPRJer2YFijco3VT5WVyu?=
 =?us-ascii?Q?Xfy/LOCY9lisE5fxA0lcvV16LrwEkMf+mgb1fLOWKI7aIQ/8YslmJ9KTIW17?=
 =?us-ascii?Q?9sOeU1FoR37vStH43d+AifgSOah1SDFSCrN+RBWPUSWo+iqky/UxYcmYbXI8?=
 =?us-ascii?Q?eIdlAz6LKlYAdJSjNmP4nu++aizD1fbZIRwwr/w19+MMzw1k16aWXonll0kq?=
 =?us-ascii?Q?8LrWcs285LUsqEp2evQFeS6jh1ufEl7/Rm1GbbK9uSp2K4VbqddZhjkSDk4d?=
 =?us-ascii?Q?Ip2tRhxdk+6BOiF7zogfLsWAkTM3m1SBMXkTFPi7QUc/pL4r0sgrLZhPYV3g?=
 =?us-ascii?Q?Lj+ahen5/kAU7UOEXp5Lw03qo+yp2JOoy5jaZkAg2bmuR1nV+pqRMbqhT8DU?=
 =?us-ascii?Q?LQHt5sLh6oPBhyMrWrN2uVEpp7j52iy4T6JeDn5df4ovK5yk3ejCvE79QDSW?=
 =?us-ascii?Q?kLxvnoqjabrv/Lj6K2fBUExYKRbnIWv8eH9n6awV8q27DSzIuCUGyo+6RDcy?=
 =?us-ascii?Q?kqmA3x3JjVkdimcI0V0VDA999WOkNbJ+Ny27QmFqh/koR2ArVtKXT2M3Mg0g?=
 =?us-ascii?Q?wL/0lAZnJw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8851293-d61c-4ee2-5dff-08dec1a602e1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:26:29.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70TtptEKWPNc+srUvm5Gs78FuClQuQssMEWTZMvVhU1Kw/VQgVvVYRQBdePgWvpaVFldJU2NsVaCVeePfPgYcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940

On Wed, Jun 03, 2026 at 05:23:06PM +0300, Claudiu Beznea wrote:
> Hi, Frank, I3C maintainers,
>
> I've inlined the sashiko comments here to discuss them:
>
> On 6/2/26 23:12, Frank Li wrote:
> > On Tue, Jun 02, 2026 at 04:28:13PM +0300, Claudiu Beznea wrote:
> > > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >
> > > The Renesas RZ/G3S SoC supports a power saving mode where power to most
> > > SoC components, including I3C, is turned off.
> > >
> > > On systems where the I3C devices also loses power during suspend (e.g. NXP
> > > P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
> > > 2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
> > > resume.
> > >
> > > Running DAA in the controller resume path restores communication. However,
> > > DAA relies on interrupts for TX/RX, which are not available in the noirq
> > > suspend/resume phase (unless they are wakeup interrupts). For this, the
> > > suspend/resume callbacks were moved out of the noirq phase. Currently,
> > > there is no identified use case on either the Renesas RZ/G3S or Renesas
> > > RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
> > > the noirq suspend/resume phase.
> > >
> > > Since renesas_i3c_reset() is not called anymore in atomic context
> > > update it to use read_poll_timeout().
> > >
> > > To cover the case where the controller had already attached all the
> > > i3c->maxdevs devices before a suspend/resume cycle and i3c->free_pos is
> > > zero, struct renesas_i3c::resuming flag was introduced.
> > >
> > > The flag is set in renesas_i3c_resume() before calling
> > > i3c_master_do_daa_ext() and checked in renesas_i3c_daa(). In case it is
> > > set the previous saved DATBAS register values are used for the slots
> > > already occupied before suspend. This allows keeping alive the connection
> > > to the I3C devices when all the supported slots are occupied before
> > > suspend.
> > >
> > > When resuming from suspend, renesas_i3c_daa() re-runs DAA for al
> > > slots except those used by I2C devices. I2C devices are attached during
> > > probe, at bus initialization time, and always occupy the first positions in
> > > i3c->free_pos. In addition, there are no DATBAS register settings
> > > associated with them.
> > >
> > > Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > ---
> >
> > Please check sashiko review result
> >
> > https://sashiko.dev/#/patchset/20260602132824.3541151-1-claudiu.beznea%40kernel.org
> >
> >commit 6783acf82418dd115df661f4dc9d5758f653b084
> >Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >Date:   Tue Jun 2 13:28:13 2026 +0000
> >    i3c: renesas: Perform Dynamic Address Assignment on resume
> >    The Renesas RZ/G3S SoC supports a power saving mode where power to most
> >    SoC components, including I3C, is turned off.
> >
> >    On systems where the I3C devices also loses power during suspend (e.g. NXP
> >    P3T1085UK-ARD connected to the PMOD1_6A connector of the RZ SMARC Carrier
> >    2 + Renesas RZ/G3S SMARC SOM), the devices becomes unreachable after
> >    resume.
> >
> >    Running DAA in the controller resume path restores communication. However,
> >    DAA relies on interrupts for TX/RX, which are not available in the noirq
> >    suspend/resume phase (unless they are wakeup interrupts). For this, the
> >    suspend/resume callbacks were moved out of the noirq phase. Currently,
> >    there is no identified use case on either the Renesas RZ/G3S or Renesas
> >    RZ/G3E SoCs that requires the controller suspend/resume hooks to be part of
> >    the noirq suspend/resume phase.
> >    Fixes: e7218986319b ("i3c: renesas: Add suspend/resume support")
> >    Cc: stable@vger.kernel.org
> >> --- a/drivers/i3c/master/renesas-i3c.c
> >> +++ b/drivers/i3c/master/renesas-i3c.c
> >[ ... ]
> >> @@ -657,14 +664,33 @@ static int renesas_i3c_daa(struct
> i3c_master_controller *m)
> >>
> >>      /* Setting DATBASn registers for target devices. */
> >>      for (pos = 0; pos < i3c->maxdevs; pos++) {
> >> -            if (olddevs & BIT(pos))
> >> +            if (olddevs & BIT(pos)) {
> >> +                    /*
> >> +                     * In case of resume, reassign DAs for all devices on the
> >> +                     * bus to avoid failures when all i3c->maxdevs slots were
> >> +                     * already occupied before suspend.
> >> +                     *
> >> +                     * Exclude I2C devices, as they are attached during probe,
> >> +                     * at bus initialization time, and there are currently no
> >> +                     * register updates associated with them.
> >> +                     */
> >> +                    if (i3c->resuming) {
> >> +                            if (i3c->addrs[pos].is_i2c) {
> >> +                                    last_i2c_pos = pos;
> >> +                            } else {
> >> +                                    renesas_writel(i3c->regs, DATBAS(pos),
> >> +                                                   i3c->DATBASn[pos]);
> >> +                            }
> >> +                    }
> >Does restoring these blindly from the saved state cement addresses for future
> >ENTDAA, bypassing normal device assignment?
> >If a device is removed, hot-plugged, or wakes up slowly, couldn't a different
> >device win arbitration and be assigned an address from an unrelated DATBASn
> >slot?
>
> Currently, the driver don't support hot-plug.
>
> I presumed the remove in suspend is not actually a valid use-case, but with
> this scenario, if that happens, the device still remains attached in the
> software data structures. After this sequence:
> 1/ suspend
> 2/ disconnect an I3C device
> 3/ resume
> 4/ suspend
> 5/ re-connect the I3C devices
> 6/ resume
>
> the reconnected I3C device works again after step 6 (according to my testing).
>
> Waking up may happen slowly, indeed. So, I presume this is a valid use case.
>
> Now, I have few question (if my I3C understanding is right):
>
> I noticed none of the I3C drivers are taking care of the use case where the
> bus is fully populated after resume (and we are after a resume with power
> lost, for both the controller and the devices). That looks a bit tricky
> scenario to cover, to be honest, as all the drivers check for a free slot in
> ->attach_i3c_dev(), and, for a fully populated bus, that will not update the
> newly assigned addresses in the subsystem data structure.
>
> If the ->attach_i3c_dev() called though the i3c_master_add_i3c_dev_locked()
> fails then nothing is continued so, the device address changes are not
> propagated in all the software data structures.
>
> In case we re-use the DATBAS() register values as proposed in this patch, we
> have the changes that the driver software data caches (i3c->addrs[].addr)
> and the subsystem I3C devices addresses to match. But, that may not be true
> all the time.
>
> If we re-assign new addresses to i3c->addrs[].addr in the DAA API, then
> write those values to DATBAS() registers, but the bus is fully populated, or
> no new devices are discovered as the indices remains the same, then, since
> we execute i3c_master_add_i3c_dev_locked() only for the newly attached
> devices, then the subsystem and the driver addresses don't match anymore. I
> couldn't found a global API similar to i3c_master_add_i3c_dev_locked() to
> work for removing devices and re-attaching at resume, for such scenario. I'm
> not sure that's good to do, though. If we call
> i3c_master_add_i3c_dev_locked() unconditionally, then it will still not work
> on a full previously occupied bus.
>
> If I'm not wrong with all these, could you please let me know how would you
> consider covering this scenario? This is what I've tried to address with the
> approach in this patch. I currently don't have a testing setup for this, I
> only simulated it by setting i3c->free_pos = 0 before calling
> i3c_master_do_daa_ext().
>
> Would the usage of i3c_device_do_setdasa() being called from a master driver
> be something acceptable? Though, I currently haven't played around with it.
>
> As I don't have a real setup to test this, would it be OK to restore the
> approach in this patch as proposed in v1?

This case is quite complex, and many people try to resolve simialar
problems, you may want to reattach device because controller lost state.

hub have similar requirement, which need reattach devices.

https://lore.kernel.org/linux-i3c/20260525064209.2263045-1-lakshay.piplani@nxp.com/T/#ma99fa92cb3aac770995350e0fc22c144b974a038

controller lost state, but may i3c devices still alive and they dynamtic
address during suspend. Does reattach to the old address help your case?

Frank


>
> Please let me know. Thank you!
>
> >> +
> >>                      continue;
> >> +            }
> >>
> >>              ret = i3c_master_get_free_addr(m, last_addr + 1);
> >[ ... ]
> >> @@ -674,9 +700,21 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
> >>      cmd = xfer->cmds;
> >>      cmd->rx_count = 0;
> >>
> >> -    ret = renesas_i3c_get_free_pos(i3c);
> >> -    if (ret < 0)
> >> -            return ret;
> >> +    if (i3c->resuming) {
> >> +            /* Nothing to do if all slots are ocupied by I2C devices. */
> >> +            if (last_i2c_pos == i3c->maxdevs - 1)
> >> +                    return 0;
> >> +
> >> +            /*
> >> +             * Do DAA for all the devices on the bus, if resuming, except
> >> +             * the I2C ones.
> >> +             */
> >> +            ret = last_i2c_pos < 0 ? 0 : last_i2c_pos + 1;
> >Does this incorrectly assume that all I2C devices occupy contiguous slots at
> >the beginning of the device array?
>
> I wasn't aware of the notifier used to add I2C devices to the bus.
>
> >If an I2C device is attached dynamically at a higher slot while lower slots
> >are occupied by I3C devices, will DAA start at a higher index, skipping the
> >lower I3C devices? The hardware would assign new addresses from the higher
> >offset, duplicating devices and breaking communication.
> >> +    } else {
> >> +            ret = renesas_i3c_get_free_pos(i3c);
> >> +            if (ret < 0)
> >> +                    return ret;
> >> +    }
> >>
> >>      /*
> >>       * Setup the command descriptor to start the ENTDAA command
> >> @@ -694,7 +732,7 @@ static int renesas_i3c_daa(struct i3c_master_controller *m)
> >>
> >>      for (pos = 0; pos < i3c->maxdevs; pos++) {
> >>              if (newdevs & BIT(pos))
> >> -                    i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos]);
> >> +                    i3c_master_add_i3c_dev_locked(m, i3c->addrs[pos].addr);
> >>      }
> >Since olddevs are masked out from newdevs prior to this loop in renesas_i3c_daa
> >(newdevs &= ~olddevs), is the I3C framework prevented from being notified of
> >shifted dynamic addresses landing in previously occupied slots?
> >Because i3c_master_add_i3c_dev_locked() is never called for these, the
> >framework could remain unaware of identity shifts and continue communicating
> >with devices using mismatched PIDs, risking data corruption.
>
> That is a previously existing problem that may happen. However, I am not
> sure how we should deal with the case when this is called after resume, on a
> fully populated bus.
>
> Frank, I3C maintainers, should we cover this case for now? Do you have some
> hints on how to go forward with it?
>
> >[ ... ]
> >> @@ -1435,7 +1475,7 @@ static void renesas_i3c_remove(struct
> platform_device *pdev)
> >>      i3c_master_unregister(&i3c->base);
> >>  }
> >>
> >> -static int renesas_i3c_suspend_noirq(struct device *dev)
> >> +static int renesas_i3c_suspend(struct device *dev)
> >>  {
> >>      struct renesas_i3c *i3c = dev_get_drvdata(dev);
> >>      int i, ret;
> >[ ... ]
> >> +    ret = reset_control_assert(i3c->tresetn);
> >> +    if (ret)
> >> +            goto err_presetn;
> >> +
> >> +    clk_bulk_disable(i3c->num_clks, i3c->clks);
> >> +
> >> +    return 0;
> >Since this callback is being moved out of the noirq phase where interrupts are
> >still enabled, is it safe to disable clocks and assert hardware resets without
> >first disabling the device interrupts (e.g., via disable_irq())?
> >If an interrupt fires during this time, the ISR might access unclocked MMIO
> >registers belonging to a reset IP, which could trigger a synchronous external
> >abort.
>
> That may have happen even previously if the interrupts were configured as
> wakeup sources. However, at this point, all the clients should be suspended
> and thus, they shouldn't generate interrupts.
>
>
> --
> Thank you,
> Claudiu
>
