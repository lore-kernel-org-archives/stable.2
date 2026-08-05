Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242003C8C46;
	Wed,  5 Aug 2026 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929503; cv=fail; b=YvBg28PJUrpXbvRYceK9ep0Z9E/GfzS1OlfzZoitXCFBfjkGxSiFB1SYX1hHYN4r/TDkV4hiLQvMhJhU8SjHrlO+vH5hHC/dWN+xZobZ8PzYmDws7G0obZfEwCRsUJkiyKsE3cMgamcu4/K2Jv+kVOVnD+ggkLAvknyenoWmPpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929503; c=relaxed/simple;
	bh=o8hNIAtJv8mFoatPIW0pyrwrVJW1V07qey3fUq9Svjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJ1ilLac+LH8yoBC5HvssX8+5krf5zHjISwbwbt3duXQt8+1prOqPHCcrdJdoNWTyocyTRyvRnn2cgrNuyK5RSNE/z+RdCq8TDIrP2z+2Bbtxkli+HSH4ZRUu21ztThLJPMaItsyxaQ8riryhbECBOqY1UPpphCR7da58wsQylQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=BgOWLrW5; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=CwPovqAZ reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="BgOWLrW5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="CwPovqAZ"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754M1tn2512551;
	Wed, 5 Aug 2026 06:31:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=eA1Rr86AjwywofUYTwdcmm3flTkS2314Yr/H99NH+Nk=; b=
	BgOWLrW547gX63AhysVBMVn2D0ydeYw8pNuIk4RvejbTTnbU7JOLgCAg62zf4KYE
	I8S2tmvE0LSp/HAcK4Sx/kMNlFoZZnDQ9IWL3kgKOvJZNm6V14FIhwEKzeenqSZo
	nO1B2L0+OEjNzTdToSjqjQgM8nlZElxngJjEBVz3gw1REKXeZvCNv3Fwgb8d3y6N
	IC50zTBIXm0CGObdNNLTIkjjNJeqfyG3+1Ru89nt6aZNqq4xp3jM8XtasBVA2Keh
	TCkJq/6C1QwRCkuyc5kBnn+92+RjwDId8jzzZnFJeUeyFZ4T7zn3+QKJnVNn7m0a
	1g07nLXt3BoZ0CZyZHY0lw==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021089.outbound.protection.outlook.com [52.101.52.89])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5m4e-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:31:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSYiymS+cvwITJbKL3X8MNoDRLX02LMs5pvcDRYmlb8hysJSp8BLqovpgUrLfv+2jEc+sx3sBlysE2lxlX8Ge6CbRXk2egolOmYViP1CNXtkDq3M5qU3UWsuSLiDOmkbU2Is4GD112Z7QD2bz4nS+14oeA9TQ3TBUa7E+L0XrW97UpheUnGmYZB9/1n6S2ebYxQuMktAGa9Fnt+8z2khUI/B5T3JwsW+fDgMlSo5JOHoR7JzlDjZavJo7NKeTvDbUuos5QD/PlkhPNQUoOY3DkhRaLzL/JmCanpxl6LeKSvs0+scjgI2C8ovwlY75C+tG9Kaz9Qf1KShyAa3Yhqq2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIdT1Qdn3foCpP9pKdEuVXUNjn2lhKN2BKjRXspgB7U=;
 b=pfNoFV1IVxRmp70kNNWPBoZTXLPxR65EKFVt6bHK52Fhl0cXH7u2hFZAeboTDf+FXpKgtsVXSHHPNMAg1jvWfWjNYGWaBTrt0FTqumqmOBesV7R19suJUPuoVYHwZ3+pLDdM2qyQ73YdI3SAf5Q2ZSxDF9xlTOcKmz02N84aj8vzj3pXZ/kU/kVdexhGgbYFxu+zkGCjMGAO0WNwKlP9Qz1iJtXKqIuO4Qx+iLdBeBXvTU7jVfHElR5a/NPOVtLweZ/j4Hpfr8Iwpi/rfWiYwel5iPK8ynIUUl5CIpBZwhcskhgY7JwITew/5snaDxlw4rjfpXWSxA+wHfbbpjmZ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIdT1Qdn3foCpP9pKdEuVXUNjn2lhKN2BKjRXspgB7U=;
 b=CwPovqAZdnJZlNqnMFZnCn9xdZfRTxxJbc12hLX/ECCxI2AmRECAnJdjK30IyK3LsqJXWlwqacnG/27w1Dnqu7w9AehBYlv0KTdPlDosgwCpIZ6rq74hnCOnMVPQLNnaJa/dCaVt2Upu4VxVKea2sRVu40ByD+kmOzZ/mWP33vI=
Received: from MW4PR03CA0225.namprd03.prod.outlook.com (2603:10b6:303:b9::20)
 by DSVPR19MB997455.namprd19.prod.outlook.com (2603:10b6:8:45c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 11:31:31 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::4f) by MW4PR03CA0225.outlook.office365.com
 (2603:10b6:303:b9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.19 via Frontend Transport; Wed, 5
 Aug 2026 11:31:31 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 11:31:30 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 87B6A406544;
	Wed,  5 Aug 2026 11:31:28 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 74E0B82025A;
	Wed,  5 Aug 2026 11:31:28 +0000 (UTC)
Date: Wed, 5 Aug 2026 12:31:27 +0100
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
Message-ID: <anMfDz2CkDDIsVce@opensource.cirrus.com>
References: <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
 <anMMIH29hLtOH3kX@opensource.cirrus.com>
 <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
 <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
 <272f965d-4265-4467-9cd0-20259e107eff@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <272f965d-4265-4467-9cd0-20259e107eff@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|DSVPR19MB997455:EE_
X-MS-Office365-Filtering-Correlation-Id: 0957e975-b755-4969-d724-08def2e51898
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|376014|36860700016|23010399003|16102099003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	+rQq+SmNZCjaSAVkcQQEAwPVKaIQjAUu1KMslTgkjQ3jcAUZGYaWY676e4/TE7AAV7HN8gtArIutINhxQ/x73m6HqJzIJ1yldfhlOOK3Pvt55EuIGKVEKBmvJQsjitVWWgWtZl75nqUR8ck6Gm06qp2/YHS5Jkw3l3SlXYiKLhlbjMSGlHWZaFCLvkJmeEXZr+yTUK7q8pj/fi8MH5P7RWkZnpRLz2LnZeZ2WmpSNn7vyJj5U8gw2Gj0BcLyj/JeT9T9J7sZEYLERZ4qUBvUgVYv4Mx8hYG0EGyNaCt3bySMXVjqQYi7Bqk3t8r7vwZDwVFmVaRDYio+f6UX3sNPW1F4Y+2VvuYFusRQSW2Xkxhm/J+uUnCf13C9leuU091m3Ox2s+nDPKizwejSxy0uNKkqxcf56JBxaQ/BqCaf/dBps1+qoc226hJg2dwKUX92yDwcOM1xUWEp0pxoysUj9UHuvDDRDjJe7GWnEVuJ5tC866no/xiC+mFHdjE5nZEHAfLyTP/wxSBytZnoIhMBVtp5PRE8IStkkJD3uGt7z5aZr7qW+rM3mEpASqKye95wOCv8aCqADT9XtOdv0iNfwutXgtYa5c1qsbZHs4lnOwJYXXzX0HV9FMBMnWXzf4HMZP62SQeVpqViKj/Oa/T4CYURO219qfmp2uWgoa1RItBvRPleMGjrrSGn2mmYfI8Alp9u6TMFM59/p/BRLTsXVw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(376014)(36860700016)(23010399003)(16102099003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UW81UVRxduPmfYEyqbqMxvY4PnpYQJMfPWcGcUMYPb4eZ6mITPAuK0z/TkN+IwpDSEN5YmHmmiWvb82izwEw4KmtlvsRp0B8dbEoCSp1PF6YqTDcJAkjsgL1QhdmwAIW35bppOq01Yb0DJEdB1SDIOxha/YUjONwJ2T/YexnZ+JFMmJo7vMGZRC9+o3hDsC8cRDyjRjHa1xP2s2sGnHN45DKfS2tY4XNPGDLYsfZm1Abm/wcHcdvh9iLhR05wPYAOF5uXcyZHJywwADIJeK3QD/vJT6+T8n2DSJEC+EFQ4CnuHEKqsypv7/nvxXVaqkRaE0KMbmXi+oTlk9V8yUjJL4J/lutyVwwN6nsD8t9GpU+6yzTwcSiTyYv6aSXCOXuocnyfPO7M6VQo0zSs/pltgt2yvX6wMfItIwMBmEl8ALwdOWCC3jvWXpt0tjWwFv+
X-Exchange-RoutingPolicyChecked:
	FgxOmb9KQE910T6a/ww7vqSmE7cDYhVUPIVJsi08rkHHcUrucMg1+sC4ztLDnq2yEScsdvP+AinRI3vYYxcGExBPU63MBejTyzW1g4L1ezLVJagxDkB+LwEO3W945smPnW2SzopM3MdxO3s2EcpRvR01lm+6rOZflVklwJemRMwGvJGcMpP3B7PDJE5pFR/rWwo1vVRioIK9N2g5zrppFZaM6LFfQNGnXBoZcuzLVOVoc8FAgd41QwxzCA5y1oqQ7KQlhSkr7fyUINOnpYqlYt8MpbcNeKX2f6jRdBXEuzyYK+/XrRiv0kIa/o8mWb8+hw8UwJPucAytBtf6DP8JcQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 11:31:30.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0957e975-b755-4969-d724-08def2e51898
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997455
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a731f17 cx=c_pps
 a=BGK54fkyo7uEM8ETl7wc1w==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=mtE5UkdPCiRkzTbjn0wA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: _TlImIRiRzh-KOy-Qh4XeP6wwYCI28hu
X-Proofpoint-ORIG-GUID: _TlImIRiRzh-KOy-Qh4XeP6wwYCI28hu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MSBTYWx0ZWRfXzL/kkQ92XaGs
 JHDL2mdX0zKTDMn1Tvu3Rnv9fykr8tdACabCVMVtG6T4SdjTwUlDJ35OtPd6tf0K2qqBC7T8+8F
 J2Y9TGbS1l7qfboOTvj1bb17jiLDBdkENeLmGTjm8zQX14DhXLwmTJti9IdiYgOHPay0Fc2PMCW
 ahVHd/Fqkpa4g8Ng/OMXkUIxvMN3lWahW4u6bpr3gRgutr30d3VcNYu0uLmD2vJ+BiFK6DNZeSc
 z6bAvMa5JOEkmrzq04Ib8CY9/mbF3v7wPyPFgxYbOeeYrk27Y1DV1bYFG8fgd2B+H9oWi3xB1w3
 jehyCZF4IcknshMMn+jWXwEqqj7dgTI+AYfrbFuQi6IiFujgVdNGb0+dZrvA+y+5Q6vu9diXduw
 MyAafpnuTLshIPp4xs1gsJEeivTLUI6XLiDAQvVEvG8u+P1lGZMJNXMDgjGWnaM5aDSCCKKdzq1
 zubElp4Tyq5dS8rS9kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MSBTYWx0ZWRfX6a81YmyGBj1N
 V41W0JJIoIJ9hYusSd/k2V29+3bCnlGLGadC2xPdBw6TP6JlrlQEVC3fVE+AGmdJDBugryO1C0l
 TCyUZPdZtThrh9267sF4BipUCznzw6Y=
X-Proofpoint-Spam-Reason: safe

On Wed, Aug 05, 2026 at 02:25:52PM +0300, Péter Ujfalusi wrote:
> 
> 
> On 05/08/2026 13:36, Richard Fitzgerald wrote:
> > On 05/08/2026 11:17 am, Péter Ujfalusi wrote:
> >>
> >>
> >> On 05/08/2026 13:10, Charles Keepax wrote:
> >>>>> I don't think we need to sort them. Just fail, so that an unsorted
> >>>>> table
> >>>>> must be fixed.
> >>>>
> >>>> That would be a big regression all around the place, ordering w/ the
> >>>> debug message if developer is interested is much better.
> >>>
> >>> I think I would come down between the two of you. I definitely
> >>> agree with Richard on don't sort them, just encourages drivers to
> >>> be wrong. But I also agree with you, don't hard fail. I would
> >>> vote for just print an error message and carry on. That way no
> >>> regressions, but also a nice big warning message to let people
> >>> know what is wrong when they see problems.
> >>
> >> I usually try to avoid alarming/annoying users with error messages, on
> >> the other hand I agree that w/o some pressure, these will never be
> >> corrected at root either ;)
> >>
> >> On the yet another hand, if the regcache have means to fix this, it
> >> might be put into use as well.
> >> A dev_warn at max to get attention or info level perhaps and fixing it
> >> up?
> >>
> > I asked Codex (GPT5) to search for all reg_default tables with out-of
> > order entries or duplicate entries, looking only at those assigned to
> > struct regmap_config.reg_defaults (some reg_defaults tables are used for
> > patching - those are allowed to be out-of-order).
> > 
> > It came up with this:
> > 
> > Restricting results to tables referenced by struct
> > regmap_config.reg_defaults, 39 files violate the rule:
> 
> and some of these have duplicate addresses with different default values.
> 
> I can send more fixes while I'm at this for the clear cases, for Cirrus,
> Realtek and TI I have sent few patches.
> 

I was just having a look at cs42l43 so you can skip that one
unless you already fixed it up.

Thanks,
Charles
