Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E68632B;
	Wed,  5 Aug 2026 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921928; cv=fail; b=cBNjsc7sXv1DkXqhnQySdJ+hzFB488u188gVipzh6xymygfckfhkB6y6n0S8raEx9UflHnDfWUYdFvGuK1+UStmdqW6mq+d/S/tN/ZlrWiVL+VBGt7jhBZe1y50PQ4kqcIKO00i6oP6fx5jhk8VmAk0FPyj0bJK+mSiy4u0SNNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921928; c=relaxed/simple;
	bh=V9fXYRxi/UtyT48BdbRwwPdvbe4itPcP6yHFOsaaQrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sK8bn+29EH4YwcFy2QZDb2ia7a3lxRGtEieLT2tOFJnVADw3Sc3auV6YVCbtKgHas/abAUoFssUrtKSJyolcB+WDsT6JkW2kO3vkpJeveVEqg1MvIVugeUVJd4+SVuIK4eJEVI6IZJRhChdVTaiR63MQPyEqai+Saxc1Hi4AhDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kv5Pnqhw; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=xnX5b8Nw reason="signature verification failed"; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kv5Pnqhw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="xnX5b8Nw"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674HY9vI2306777;
	Wed, 5 Aug 2026 04:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=/JpMvuW3wqF26b4mD7Ov5miR7lNuqWk7zspfx3rKGr8=; b=
	kv5Pnqhw1HPrBuz/wTFW3R5b9u1Ne2D1alyFBitdPyW2oqVyt0phsIdiAuwmsCGc
	NikqnaN6WTquvGy2nTjttUUvY61OgilJ6fqv0xercQXcStmNPIoYJqqsMN4eKdlo
	U5xXkimCBhnh8j29p7TxuoEvlthYMHN7wHBdJcjmtfrkmbWN/kNH2f1SWIvzq6+i
	XsXPPq0krqzcgss1RQ4LUN+hxNZpi1VQRQuYWIA05ykTx58cBXdml7LkKcJgwy81
	VvQkJy0iqZv1hBxYCcQzpEjXfLPhmgWECWX391sHubJLyORHvZ3IwFRHRkGscrts
	VoK3iMtNFedFMpXWGpUeTw==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11020136.outbound.protection.outlook.com [52.101.56.136])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vne6h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:25:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHzO+n357Vfd9s5/woeWG8omIP19nhjUga0Fo5p9O+gGZl7N8c2t44kBIkBOK/U7OWQh87KHWVHZ90pGnHSsABTgAcZaueRiH8d/ytiLfpyS75DWkYwMPBoC1te0NJu2TLFlHAADl3Wd0gNxdX0gBWAXgfty5qPeVJiTbhWtCTY+PBc7Kj7YlyfHULBlPjskkCRNXjNOZeUQ6ip5c3GajCY/Ce8BFRizstsSAQ9MGFjO+45sZmVAGE5RJw453kq+NjHZPFcJJJGJ1UlWazfWTbOz7bEphtEN2z31fr/p/K6THadS4hzxC4Nq4Q70kyOP0vO7JS/ptQgXPHYAvQ3MWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCFW/+tnh72Xrlyj3Zk5EDmLOdNbZ/2TVRbAKxIBGNg=;
 b=GOtoqiXOOW4UOM0qeulXE/BhNe+may6QhkKGGAs6RviZvk9gvvZgXIqP2CjeAvRYw1P6VSC8oKe+kcB4apY6lYAyrZRqbhwA5m9WEl3oYM3nr3lOkOzww0vvK5+MZ7LDUMM+cYWKuIoc4wjkUS+NZlUv8EbTHU1icjzcZcU7YaX+WJrWdeZKXnko7lc0QeucA5xr2LPqjmwbGkU7nbcYRuHVs14O0z0qsC0TcL/Clv7ezl4VqLtmsQNxF+raj22g3LKVtKwnck2Anr+QODrYctGd2VbEgay1T40fNp5SnaxiTNLDIw3h9uX3BG0vLnB2EWtblsF+3/Imh4yxnzAXMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCFW/+tnh72Xrlyj3Zk5EDmLOdNbZ/2TVRbAKxIBGNg=;
 b=xnX5b8NwSOVRT47ojW5XDmnOQvdNCPJ48KfXKHPaDQIfrcyYZj5koG9hstRG9SDNgcbabLq4J/lSsxwG+16dkrBJfYi76AcZm2dRSjbNy88iDaBk4aSlAYYFDwMbGFJ3cBgLpW1p1gQDhSbigeOpp2oSe2+chROLTAv9ieOf29w=
Received: from BL1P223CA0011.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::16)
 by CY2PR19MB175845.namprd19.prod.outlook.com (2603:10b6:930:110::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:25:16 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::4f) by BL1P223CA0011.outlook.office365.com
 (2603:10b6:208:2c4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 09:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 09:25:15 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id D58FD406544;
	Wed,  5 Aug 2026 09:25:14 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C561082025A;
	Wed,  5 Aug 2026 09:25:14 +0000 (UTC)
Date: Wed, 5 Aug 2026 10:25:13 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
Message-ID: <anMBeeNG1fDpFHzN@opensource.cirrus.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CY2PR19MB175845:EE_
X-MS-Office365-Filtering-Correlation-Id: e4d3e8c5-3b12-4015-4057-08def2d3759d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|376014|82310400026|36860700016|11063799006|10067099003|4143699003|56012099006|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dxzF3mU09DHULnzJipGjwok+awxyFj9KZdte3ri1ieHL4bXSEYiSI7KJv/q3ZzcSat4hpig4h/83qX4j6x8r7IzQ5Nnex2q3NJsQGnAcyjGrA8e6kEWikphdV2Zv0Q51ElVlF+PrNTrWsgK2FHaIRK+I5DBvsBiUoxFnLiDhGviGS8zz8M5PLYgZh8wHG/243ZoUrVjsLLjjtsSbQ+ljpoviXlxrT9hL7W3TvC1gz6ug9aiNAe6mfeOLt2jOcq52w+wO1b2153YJF5VZDInrrXwLnda+rtN0FdBgSWweZKpt4PZmQrjAnY/KiN1VszNrtNhMTrfkP1qi04lHO+WEdaSu4bOcYrGTnsSoUnSFupKhiR6GThhb2fKR6kXuAk1UhAoFxkIbEvF2hr5CmnId/C/+82MrLHyno+yVINmhJ1uRUQ0duUf9udikeFZNse41lK0gh6gSHK7SUIxwho7flPJIFSueeZZ/2zd4k9pecPrrnDQGAwUGPegmGX9fGfEOJJ7ZmD6wTDKLg0Z4YTX8cfHy0hvVXpYVDVKw99D21klf0/Qc6GzCfhkYh48TvP31iUP6dsux1fxxeytC3C3iaHwzyH9zKMwdeU/Nbxf+AU5PuCA8z8JBW/GUyK5nXaWaYSrfIXSkKo2a1ZFinWzGcZZgn1JQcv63kWGI8Gu/IKjHnF+vyeIqJJNbGYvbnE8t2N3MFNQjDz18SzF8KllkCw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(10067099003)(4143699003)(56012099006)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n48GDZuRl4PE5BkJtmrODV2W8sSM/ZpcOncTqEg+xT+OeA3jb9841ejq6UM9FsWI774rAOV/MpgQqNAZn+Z4KTZaWRWVgJnduVM/3aYv4ECcHo7gz46wa3R2hywQM8Wxa2PYrs4yC09PutcpRMicbu6zy/pdrwt76nGBtpmC2rUkHxMJ+vO4hQ+9ToclyT9Wdie1W5upKCKJRWc5dy9qoMdoK0cWao30ap4XcFKbDMGrHnjXujvpJUAcxVFx9MQ+DmRf2Hu9hcU15ssXb/DW6p8wtTpKvWZVqHdW3UaPwOS0nUNNn3mcVrnY+HPNDjEr9ODsQOKR44DLJoWYwxVOXHTT+996ePm9vzHkSRXt7rvToHszu78N6JOOaIrIOMr/+Xl+ccvUCcEWoYut790mOlZ68ZphaRpLKs98US7fepKyIiK3r7CrlZ7pHhBobPYi
X-Exchange-RoutingPolicyChecked:
	aFzDSyfPTllJTdxw/jVXYxyF2NzhVea9oS4Yf4666aIFxvK5q95TGet+YWN1QQkSByKBhNYhq6AoqZqQ2aoHDLeaqhsAak3vxV1t5DD7CGuZg6dpNi3Le8E0wdoCq3Z0M/3ukfi/jQwGZac8jRMNdmjt/hk9i7CbUz0xhR0rmok9gxg2PUNUNODm7h82g32C4mEODddex2DJvQccq+bmmgYZBoBbd6XWAuTxb3XpmRKy23RzUED3sTl5e6kJyf8HM5CeHrQ00HnAouJGjfJ0ZcuOpN99A1khliqFiQ95J0EMOvjyhA+8ZnNWjrs5FSKHorzrOOOQZ9YNPRHtTHuHSg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:25:15.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d3e8c5-3b12-4015-4057-08def2d3759d
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY2PR19MB175845
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NCBTYWx0ZWRfX2Pjlcpjn8azo
 0zSij1qSC9JugqPD8Ihp+mBaidpWtnFTiK4FgPXKf84Ik2lx27mOFVTLWBKmWkneV0DGIX+g42b
 dCpvcJ0PxyTfPuFM+hVSKTEOW76+cD4=
X-Proofpoint-GUID: ddJa8R154y0TFUhqQzyGhDbPBnTEGnPQ
X-Proofpoint-ORIG-GUID: ddJa8R154y0TFUhqQzyGhDbPBnTEGnPQ
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a73017f cx=c_pps
 a=fuZeKWo3Wg5M7x5zI0EODQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=dhVvYe_80OOQcEE4_qwA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NCBTYWx0ZWRfX67Vd3tm+NtLW
 twFv0scJmOn2hw67t9Qgbj/Trh6FqgSXFfjV2XrnfGQ4RyfzQ9dndn4nCVBaGLX6MmEItP2NgUF
 ym6aBiR6BYkMaTBPsNONhWoaVLAFulsbprDP+EGgqxQDInLawA1Yh35cMIiDJsvbGKUHQPBUWIt
 Iyk/+SVML88UiyGjJIbLcrI1B8whgb/mQMw+ZMaXkrmmdfjbzk8Szprd9xiSwIP6ByJOJgfIqSV
 a6YYPFZCtP8DZeoEhQOTo1IS5hpyhGrtPEJ3iN7NlxRRuyBaLGuh9qmsAe8myPe8oXwFslWzuMB
 AZQakgQS9zrhwQARsnGAHGapax7D7pGHtoKPVyEj6tbBUBm8QgUQQvf04ahTEADIw94DKk/8Prw
 SkKdX/O6pQ3wpfh+1S05Dot/Yc9bD/CBlc73qnzjR1Dj78tFk7iZ2O4x3TGYUXn6Ikc9NjA+CSW
 uwGBStkcPYvMrIualrA==
X-Proofpoint-Spam-Reason: safe

On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
> On 05/08/2026 12:00, Richard Fitzgerald wrote:
> >>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
> >>> codec drivers are fixed by a separate series.
> >>
> >> Wow. Would it make sense to have a regmap helper to double-check the
> >> addresses are indeed in-order in those reg_default tables?
> >> I am not sure how this requirement can be enforced by just inspection, a
> >> warning would help detect this sort of issues on more platforms.
> >>
> > It does seem probable that anything that relies on people just
> > remembering to keep a large table sorted is prone to breaking,
> > especially if the addresses are provided by named constant instead of
> > a list of hardcoded numbers.
> > 
> > Should regmap check the table when the regmap is first created?
> > As it has to search the table during normal use anyway, one extra walk
> > when the regmap is created probably isn't a serious overhead.
> 
> But it will be done for _all_ devices which uses regmap on boot, small
> things do add up, see my reply to Pierre-Louis.

Indeed, if we were to add some sort of auto-checker it should
be guarded behind something like perhaps a Kconfig option or the
DEBUG define.

Thanks,
Charles
