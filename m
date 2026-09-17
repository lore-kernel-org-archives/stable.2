Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610B59D604
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656014; cv=fail; b=ZUwFSVZMabDCK5CmwFas9MSIaIIonpEIodoOYltzUQUKl9g0MxRt/2k80AJvK09sw4u22aqKOQLnR1VYEpKDUt4idRbeORDUiQO8u42jZ/NMQSR7kncY3zQLePaCYblUI9LAqR1wW8JUOz10Yegrsx/9oxFFdjoVGZ5HIaOYiRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656014; c=relaxed/simple;
	bh=0L3YR9o+X0Iotl0gyxWebIvzfJZTn2yP1dTjKhvLAn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7OhoeX5iRqAuFwwiE/MJjsXQmxafGzcjUKSWrru+cZ5612z1XrqIB3l2CiwDN05ruDpp14AGZfjmZCJhgUv2t1YuVGzBXOIZ7O1tYj0vYRm0ctzvbWtkJCrXFvABMsvhkG+oZK522dSdYliI0NnVePLa49DEP8CtOzP80PFGEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=E39UgX6r; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=lAc8H8Ov; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="E39UgX6r";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="lAc8H8Ov"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HDLa08110492;
	Thu, 17 Sep 2026 09:39:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=k4FontnlkJrm2+S24rG9xEyquGr+XsmDtj+F2Qnqow8=; b=
	E39UgX6rb3Fr/tF0nvi75z/f/+gu8l8gc1ZeQOKWXlUQ6U1LRXP2NjuJOoiWnEI7
	kIW/vr42uyjWz8oZlpjPrTAg7na+q4WptRQlXqdkgWFkxxqdjM8wmyRQB6gjh5cV
	NBtghNh5dod49+owsCP75FjEB4hzXrn//40HHN/W60SrZjxzRFd0qOFJPvSbjhlM
	Ax+SEsxkCh1daZtgI9Fvdu5XdPdJMB7BkhwiRQ4ndjrobKLce6wHmesvHJq4QzVR
	clMXNFVYMXh9uEsyZawufkQDylBZL9eUvgrajAUS/WqPx7ptnlmxenLhO/m4MUTF
	huIDKIansYc0Fn94D4DZQg==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11020122.outbound.protection.outlook.com [52.101.85.122])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4gn35hey45-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 09:39:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o22G4ggnEx9PUI+Q3bKl2Ze8qpASXIeMF2vsWkLGhilWxfYRpQBCp0azGO+8aC1smLvqJwTVp6AHbJOCw662KpSyC22E95Yb7nczkQjBy6MyIJi917ael8zyy7FoLt1RG1+8zKFk6bPM7Q/xIhZRKb8SS+qKVs9xIlcLf7nOOHp9RRem42v/khKMyAbMCS/k+y4H8C8ZRiLAwF0adlP4jJqbgBqRktwqKtg4p4h2/GumP753eUyPj2zvt0tCN7rQ0DMQ7vOIP7qXBYnZy0KQB6FkGbTRsNX88i6eRPZneRO1xKwgnQQEe8ONXJWET8TWeYuiDTk+kXRO/jYgfTMZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4FontnlkJrm2+S24rG9xEyquGr+XsmDtj+F2Qnqow8=;
 b=E4pTszO2GdwKGqYdWxnV2igMoLAQEOeF8FrrgTdMGG5Sh8jQOR88vqLBtL8QtNhQysgb6z1oL845cOupGhLnIWCwG93vSChYy945Qb1Q9y1C3ugZb6BIzIabDsmiHV1hL5QFCisnyWP3xyoYRRY/C697IcV1eVG5m08d1FqXEgiFdfXcP29HclB5AiOcXcEiPylOWenSU+/x0KGlBEWLS0t2NBhxLT5N+2gtlOWGbPLCDUpcWNuHX3IeuWFQSH8zGS4GhwLcKo2G+1AOTTXrVOuvXaiIqDbG1XVXtCzV7X83wQr5yE3o7R0KLlaahl9exgB+XCUsQtjLJbF76TVX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4FontnlkJrm2+S24rG9xEyquGr+XsmDtj+F2Qnqow8=;
 b=lAc8H8OvXcXoqGpjd86w05eTsH0uBp5nKaftZ7nXpZU5JF6scBAy3toclN/wXRC4fuhS6NpGoMI4q7ix4mO/tBFIxdw082tYO87LFdTWt9KD/3G2NOO5GbhRJYwKLtvtbE8WKYtkf8ZzCo2mJl+knM+TvRd2fr+AL3rKF6lQ2hU=
Received: from BN0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:141::15)
 by MN2PR19MB4078.namprd19.prod.outlook.com (2603:10b6:208:1e4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Thu, 17 Sep
 2026 14:39:52 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::a6) by BN0PR07CA0003.outlook.office365.com
 (2603:10b6:408:141::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 14:39:52 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 14:39:46 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 2E4D7406542;
	Thu, 17 Sep 2026 14:39:45 +0000 (UTC)
Received: from [198.61.68.148] (EDIN4L06LR3.ad.cirrus.com [198.61.68.148])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C0CC6820244;
	Thu, 17 Sep 2026 14:39:44 +0000 (UTC)
Message-ID: <688ecaba-8692-4476-b055-cf6021814d24@opensource.cirrus.com>
Date: Thu, 17 Sep 2026 15:39:43 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ASoC: cs35l56: Fix race between kexec and"
 failed to apply to 7.2-stable tree
To: gregkh@linuxfoundation.org, broonie@kernel.org
Cc: stable@vger.kernel.org, - <patches@opensource.cirrus.com>
References: <2026091611-legged-other-642b@gregkh>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <2026091611-legged-other-642b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|MN2PR19MB4078:EE_
X-MS-Office365-Filtering-Correlation-Id: 72926504-2397-474f-e6a4-08df14c98504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700016|23010399003|82310400026|376014|56012099006|11063799006|10067099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	i3dVIwzKdVH9761NVYvvwhlffxljETIQxjUKzktH83tpixkJHhvG8Hs17FO4VQSd74h78vNtPii6nqpkeoLBu+PGQTwfD6Iup/7sPas7S+gw/99Ai7a6Q9TDYaEX7ysx5d3IBdo2Nr8rAo1LuX+aAYQgGzKXw4PyCIE7tXAD/jRbhMGhfrHCkkRQoWrCHTi9l5+oBlpv3Ecidv70uuEzbZ/y5rvgKuxPR8TK9GsKugCSwU3loowVS7IrnJgC4rEsMHWeHmPHQl/os1iIrc87hAvAboSysngemQMBjwzT99riM1gY7km1Gmo+LlTL3LStLhDWS3Zfga5WmHemTmJqbs2gNxh590MNvL/KEHiTWklQRVH8L02ofVpj92l2Y7+kR8EhdCrDcWLndZqeCExQjzyV7P8rYp+Ag2kkL04FecUukptoGPB4p+ISeY5H2S1lCkYgeWn348vRfWfjvdPA7doZpP6tI8zKgaxJC7ik3ClSS+Gqi95NW5hf5GFpp8doel0itYfMR6QCLQUfx2u5TQoOArsJYzZw6cr+84h5IcolK90ldtJD73P7GoVlHLhNIDRAWS757Bg2vJ86tXBtTKF2QQsJkSrsQhBki99zTV0jgKlA3PMMU7NnqPuUXimndJNvcAx6FptWCTqsxg0J1G7fkU7NAXryG937OG6ORHXpEgXGkK7OlvlPDr3oufUDAx4ZN7awEW70IP1Iw4vogw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	U004wTPIz3WQu6Rl8oyoJrk7TWUcnsXcs63h3KvQc/RZ0Y4R8LeneC2n6HLx6MQJEVOQERsZemNj9lmxKDxFqnLkEWZ3hHF6OkGP1cqYHdNIvnbV+xbyU/0ljY0o+aLbN++exNzqUWSuTqZf5OUxYF91c0OKUtAIc/AQPnDfSsq/tbBQumO1ajDsUz8yGgDW/fk7n4GC7a8wGevgDkOfUISEX1Wtu6nj7dTUz5jm6kaV2Gx3OuL9NUCgu8bbKHABJlXgLp9bszuASp3mifqXK0BSciNJnIl2aQdauvh3VYLGKYAhaAjthj9Z1nAgO6TmpktDY5teoyXMwMUdBywdQAtDarSsL25jdch94iBFp5ElUf47A+piRSqqo1GBXhYjUuqvhLR9rKHxET6yzjv94Nnyx9jbcRSbugyk6R/EIHeR6xBCBZi+teCAsEWQbuk0
X-Exchange-RoutingPolicyChecked:
	3lpi238SKMrkVuldDORsIiuvydwdditOlya324BQRobDqj2gQ78gTnxWuhTFaZFilJrvwTOH3s+oOj/3qeJ2ytjxIwUAy2Od6UGiSRGso9eH9RB7or6P2Eqwt8wmUAKbTjWy3ppkaVoc899iHXJNr1mRtT6pwPvUQXbIweK0PuPpO9tY5rjvtxGUKw0/tl4z95F5fs+1UZBETWC/WuqV/Z6vRUZfKXbtG/nBr5x63ohq0DomI1RR0W5uYQxOP7q5DLcn5oIfeJsBLunYZbCE4jRPf0VUCuLOirlSjaiUjr97VW8D6y4o1XAiw7upCFVtl7+zgY/V/OWkN6T7+8nlzg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 14:39:46.0434
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72926504-2397-474f-e6a4-08df14c98504
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB4078
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDIwNiBTYWx0ZWRfX6cm8M3Z3Cefa
 X0QZo5v0OqtpPmCrtb5Qe7Jzjq9SkwbyqpeiTnFiKY29DUPhSVsxH63d6myLZBcY4LrnPJD0jxV
 Qox3YJsUKJO1+i7cT5ImkMUiRWwf7Ug=
X-Proofpoint-GUID: 2JVwLFh534OHL1U58Iokyf2KDgKjp6MV
X-Proofpoint-ORIG-GUID: 2JVwLFh534OHL1U58Iokyf2KDgKjp6MV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDIwNiBTYWx0ZWRfX6kviGiAL8sfD
 HbBF7V3qixEdOKhW5hIXLDN93AzwjpgwlqNF2MRK4RukDwn1+1p7ENQ2fBrkm96kN+TFeznzfiQ
 JXmyTq7tuL03itxVfsA/CBOrCND39ZyPzC9lMaKLM7XmolMXPqSnyZOmmk4IAChHZ2BjLM8h5rs
 pW1Raqb+pptu2rGoLPBsiELSupvTeHl+DnrCAgliv1hGpibg/z617KKunlJsuLbGCWfvJuaDOhg
 A++/io5h+rJs9QStpx/emSo7lDwXlL4tHLUDVlUDBsjOKwq5sF6lN6e5+vnIsddtzJInCriqdAv
 h5HU9mDq2nSJpQHMzvYE1SNk8MrsLQOhZvUpTnNHEy0yavepZk6bz9sXAniHZ0F4UYLZy4IJ1cZ
 5rIwZzwjbOkEs3DZMUGyTsg331ZM0N6X7hmVgX4m606kmHVAFrKapb4zaHi0EOG436QgWd3eOBe
 ToSeUnQjqg1eb12vKIA==
X-Authority-Analysis: v=2.4 cv=It6L47/g c=1 sm=1 tr=0 ts=6aabfbbc cx=c_pps
 a=Qdo7Ea4lwGWRD8/XiwST5A==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=GChlb_yAJuWaN3FF4zwA:9 a=QEXdDO2ut3YA:10
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Reason: safe

On 16/9/26 18:32, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 7.2-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Hmm, yes. That patch (and the two bugfixes before it) are on top of some
other changes in Mark's tree that are not fixes. They aren't related but
they change the code enough to cause a conflict. (Unfortunately the bugs
were reported after those prior three patches had already been sent).

Question:
Have the two prior bugfix commits applied to 7.2-stable?
This failed one is the last of three bugfix commits:

883e78c9e6007 ASoC: cs35l56: Fix race between kexec and 
snd_soc_register_component()
1d80a4792f1de ASoC: cs35l56: Fix probe deadlock waiting for SoundWire 
enumeration
fbf2c660bac86 ASoC: cs35l56: Fix pm_runtime imbalance if suspending 
before first attach

What to do really depends on whether all three failed to apply or it's
only this last one.

 From my naive testing all three fail to apply to stable/linux-7.2.y, but
I've only received this "failed to apply" email for the 3rd patch.

