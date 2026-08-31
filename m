Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247A639B94A;
	Mon, 31 Aug 2026 08:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165413; cv=fail; b=Heefc1kbYHmct9MpfG48tvXVSX/hgNXcLpujQkuFV3D2QhRtY3Cus5lvgo2PAyb8Xk9/BE4dztnPjYz9jPRzDyfWF7Z7gt7lVeqBACGh1drYtyOhSdAhFMOvkTaR6pO/JTeu30iRG4u3JGICeR7cL9x5hzwoKDfxptWOsJwf6Dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165413; c=relaxed/simple;
	bh=6YIlmVZ+QjGM4ny2g3X+bQXs0Ju8vVTkC583Dw5HTCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQeXaaFOL2rIjO4jwcK/YryLAtwm+0QAEn9UBIZ+DqaX5qXAV4A2EaaOfEFKqbh1pMMPUeIZpTvbUxKTBore8YehmFsMYNp8Kv41ZL/OOVxG872+5ENQvVYoJLUuP95awO43INcQeOIVzoSOyYfWlOrsfzxlW0rZGikKhWfijc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Ny84FgVu; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=AJdtGpAe; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Ny84FgVu";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="AJdtGpAe"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V63Twd4037069;
	Mon, 31 Aug 2026 03:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=E/xIafV2mYnJU70abU
	kxaXssj+QQlLO9kFy11zaT9gw=; b=Ny84FgVu5B9dkRgwwv5pR3QHojrLMkaGgy
	5EpHCFK+KdLsoASV6EdAb02z+Wjaexm8mWuvc2HWSs63CifzU901z/Tamy39gQK/
	/edhY14GzVJJP8BOOekphwBxgKqQove6Pn4paG06KgKJRtUlT8oiDydI0rDumsGq
	5bDLTPjbvPAtKQoYQK5Ow5tQnW18v+uBK+ZBdpf0mozF2hf2+KWmuB+o5m3JA4Lw
	c1Fd30taEAbFReMvULIyTQt3wfoYlMg2KS7F+aL/cZPexomlmU3hIb591rf8xC2k
	8CsKro/aXKBIUi+feaoyTamc6DK3Yy0ORPgeNiGoZcSiELti0OzQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020125.outbound.protection.outlook.com [52.101.61.125])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gbuuh1q6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 03:36:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HytVmSuN0Bb+N7hPIRXu1WoJg8rIMFXQ7spzOdzGybm8CYgbzSV34X9NzqVh+JbEuc4Y5U/HWt/24LxBlarQXfa0HEk8NvJEEwVEQn8GErGR3+wvrPGV1ixsqAXIplb4QGV4Wcm4ydcS/7NeTznDiwk9jTYhb/sN3IKs4Ela1S4Wd1Kw6iwQsiixzTBiIrIKiofsAPwP/fTGZeXsNZL/4cEF7dhQanJ/2gWxKD8TDuYmm/nbgqlo4xmS7gAuX/2fXldrJ6BGMqiwPozHtKK06Qg97ReeMPY/CG1BAVnXrwbVvDpEqdgPB7jtVUoHe3ELFiao8C5IoxZZnZ5u1oG8sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/xIafV2mYnJU70abUkxaXssj+QQlLO9kFy11zaT9gw=;
 b=F5+XbNVLl2elSAWlly39Yt0AtZxIi0weMw3+76rcyO4HDxCeIHPvd0gEOMhzCfIkOCmFGfgYpocQNID/LOcE4JWCiWrI0Ypcs4baVjVMQnjQT6LXsIVaBMdOsMg+B89X6ydzBcu7SUMDe4hXrIfLCTzJDbqbge/wH/HgQjxPvq2yfBm/mIEdF27eQgoPzbSyQJUtkIFduEZe4hU21zkogjAjFL71xd/bRAy6XYpwlMU2LGPG54g4IhD4GRxDA+c6VAiu8KCIwil/Be65kj1lpUFOYmWxHOV+AeeZrUVTtr0t6qg66tcvmHj3oUm50h/mDiYV4OZwhiLqQ4dGe0aJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/xIafV2mYnJU70abUkxaXssj+QQlLO9kFy11zaT9gw=;
 b=AJdtGpAe/JNRKe3IKOb95kcyejtrtZ379mfYj/eIvKf3OweranP0l83zgBV3/mMJYJbi+egT7FZo7Wt0rkjvGvrR+74yVAAEeGPN4lNnq+vE87GYvGDtoH8Wkaciz6bAHdmh5rmWfwBFu4MWUyOX56xRf1HjHno4cZ/SufolSD8=
Received: from PH7P220CA0089.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::14)
 by EA3PR19MB9471.namprd19.prod.outlook.com (2603:10b6:303:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:36:07 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:32c:cafe::86) by PH7P220CA0089.outlook.office365.com
 (2603:10b6:510:32c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 08:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Mon, 31 Aug 2026 08:36:06 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 901B0406542;
	Mon, 31 Aug 2026 08:36:05 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 7B476820247;
	Mon, 31 Aug 2026 08:36:05 +0000 (UTC)
Date: Mon, 31 Aug 2026 09:36:04 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Ian Luites <ian@luites.com>
Cc: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] soundwire: dmi-quirks: Disable ghost Realtek on Asus
 GX651AX
Message-ID: <apU89HNgEg1pZpQm@opensource.cirrus.com>
References: <20260831082534.224716-1-ian@luites.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831082534.224716-1-ian@luites.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|EA3PR19MB9471:EE_
X-MS-Office365-Filtering-Correlation-Id: 10942e91-d5c8-4440-9aba-08df073ae6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|61400799027|34020700016|23010399003|82310400026|36860700016|56012099006|10067099003|11063799006|6133799003|16102099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	urqxKDs3prjJAaZ8jakffHoyu6wFUJDgR4spn3Si4AxUy/lS691/RnjrtYvwEKKij9ondxQNRrIFxG2r/qhwuAI3pLuApWlAvKg2dWYUMNe2qsnlyMUjxP6YhbkRZXwAFzYYKEPUckuK3wnoHCwnLKtyDfG13PPrCLffPNl02fkrece2CzyHvkPe8ORURBDMzvZXODLNUsVQXSaLYSIdd1g0mutLeEJ5R6KOOncjupkqaKrbH/mnjbBhUq6LuU8URYdD7KlGHSaywqcgkhkX1PjQjoOZ2uaY1EqQH+Igkgw+3iCsWgw98k7gfx+ahqPKSd70EvxmLsNFwHuYYm/BtAKRgiDtr5m1fSJ0mSXEkYzGk6S9j5DOXjkoaejneIJ2sWupoklWWp4PfJ5Xsfyce24oHUvySGTa6p+RLPDEOWkpwLPVq3XUYEWkx/C6mvnouCXKjhR1EpNfukVFWUFITabgWfyRr0uACcsQbhxNHzxTh+nPKBhEC0VdJLRyFAF9Ahbul7dBMoFOzV5oR7HoTxiEfq7TlXZnoOK+6gWmpAtGtdXLNxCkJRaYqVzRXYYlUJh/nIyFHuXyvBHF6BZxQd5CeiJ3UQ15CLkWEyp1NhBCCl2+/jMMkEfgoyBJuB4/OgvaUMKWT8C+csDnVnx21v3ijTLXSjxQR7H75YSyX82GEiDV+K/mpjhD59e5a//3C1cuRaB6+X+/02u+xJkUyg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(61400799027)(34020700016)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(16102099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m9hHn1zLHeY/nzKtJViXVEr9SQ2+O/x1HP4pHax22cmh4SzQrC+inGSUZ+aq4fgTFUP6CQDBLg8BaimHD1NZYr4tCDj9v8x/oBPit4fxPec0Rq2MV6fxQ0Ci8DLiBmpCWSKAU3HAM342G85MvQc/1bQ8+aylOrS4OOwBDUFKaVlfCNY8w+q8qw48RqunsUWNMGV9Q2mVeGGjD49y75fdKjExUt/h/YIUi1TUdWG5r89kSXp1WQYoadPm3pfxqh9GN/QAtxUz3gOxNJ2kAIxCiVAZWe1WExCKL2jo04ledcJ0C2Bd9mSIfntR39rP6i5cRrh8UJb6AFNeUWWm8SraAEQ2I8BdL/HnA/YkGhe+yoetGOaMxKaPrGdnJSytRK4RGtmFeunDM1zIjoESLeCJdEAa3yRCvDB5urqA5GbMRvFDmQwrYHNss4SEpeV/kauZ
X-Exchange-RoutingPolicyChecked:
	ivxhbJZ6KPSMqNg60NAQgcodVkv1dEeqDDdxYetCoGKxhR/Li8eq8KdQfhjXRq2kRRLofcU0a0f/9tVAqTtXg88meQEmP4VEKDMRG1RQR2Xu8NkGfFMptjN63smg/1WMj63/jrVP6ei859RrVGftd9d4eP68dzAhY5TXMCWeaV21bv832FHIdF3Z18pSse9gSkmh9bX4VNJNIluxYQFBhcAvF+7W9t0pFHTt29Wev43SN9QWGjRfzrzWKHCF0z8cu7vnhPlXrfoZc6wguX4byR4gTmxmuLMAaOj+6froFjaj4lwKFvtLqBloFJGb+5rS6P6LJDO2WSeEDJdjDwnU+g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 08:36:06.6661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10942e91-d5c8-4440-9aba-08df073ae6ab
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA3PR19MB9471
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MyBTYWx0ZWRfX4vqAD/Hno0T9
 KEDYGhMIdnFTWS0Wt1oNbcCC4z/YPysovLbOPe9rZmNYd1lKn3s5O9Qas1UmDnZT1PPCuPFwjUO
 VoZQCZtaSGK/ePFdaMVbzVhuGzYHkl2KDSwLnq58+B8u//W7IDqg7b0gqczCst8Jp9GhcRv26+n
 6uFlxYwXB0dXihn+RlgVjuVlA5Aq3/pTNZNTDP1o+x6/NULobEmIunO0ARqKrYB8KFc9k4AaVu3
 DM8lTyNVAtQIXhgNvgxEmU0vY4QnXg7HYjNbOrVnJSx6Vtlpsfvd6GwvHhRgZSueg3rYuoIiDFk
 m1anFomKbMNqCVK1jNqY+NzxSKbLA3qKFlPPpHhWZQ4kuNQCvDMODmPPD/tv82uVnyZO9auSTAO
 /FoirI9IHdEKjbaXbzR9WLJ9JUr7ugVeCTZHqJdRFDYy3nXrauM013z0VP1oyst37ifS0dhK/IF
 d+kk1BpD/KlO6uiaCCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MyBTYWx0ZWRfX7fkMnjONVoVB
 JR0Pp571x5EwyQpH8Qaqf5HyTtT1XZLpREA/ogZOgpPqc8rioxaJCIa5WOPms16qAXLfmA6DQIP
 rsWzSDFExRD+F/f32X0ueSSqVU+f8nE=
X-Proofpoint-GUID: nD17-R6Syvz1l9FQOl9Qqems9zwl8KKj
X-Proofpoint-ORIG-GUID: nD17-R6Syvz1l9FQOl9Qqems9zwl8KKj
X-Authority-Analysis: v=2.4 cv=d4nFDxjE c=1 sm=1 tr=0 ts=6a953cfb cx=c_pps
 a=J2I5gP+8VxcSyNNGd87E2w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=zIP_hvxlAAAA:8 a=w1d2syhTAAAA:8 a=JsVLyC06jNI8Udb1tmAA:9
 a=CjuIK1q_8ugA:10 a=zM8sW5_fC1UjBFrgDpAn:22
X-Proofpoint-Spam-Reason: safe

On Mon, Aug 31, 2026 at 08:25:47AM +0000, Ian Luites wrote:
> The Asus ROG Zephyrus Duo GX651AX exposes a Realtek RT722 device in
> ACPI which does not exist in the physical hardware. The device remains
> unattached while the CS42L43 and both CS35L56 devices attach
> successfully.
> 
> This confuses the function topology machine driver into creating
> duplicate DAI links named SDW3-Playback-SimpleJack, and the sof_sdw
> probe fails with error -12. Add a model-specific quirk to remove the
> ghost RT722 device.
> 
> Fixes: 45cf24da0a10 ("ASoC: Intel: soc-acpi-intel-ptl-match: Remove unnecessary cs42l43 match")
> Cc: <stable@vger.kernel.org> # 7.2.x
> Assisted-by: LLM
> Signed-off-by: Ian Luites <ian@luites.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
