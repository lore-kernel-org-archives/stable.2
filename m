Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6783EDAD6;
	Wed,  5 Aug 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920434; cv=fail; b=TJHl0ifag7/bPoUV0cZFJyC98SlShIF3zztSUtwLoJGTz7+3RIpK8VGAS2ybIx2HQpD1fyNeEBKIG013UJeyhF/s2VaSb8n4UaSox1zZwWIovvTGueDaGolem631wc9Bi13hTfl97Tk28somYg6YXOou2Lt8iu+Aazg1evRWanA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920434; c=relaxed/simple;
	bh=oi2M8QCVe8gfYZLtQsy2Ah85IzG+12FBT9zghp6JNWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1qmMJ+uSHRi/l2ol642eoe0dhNwEsvfSCWb46eq1ZE8+IxUOspHw9SsdeHTvPeHsi2dLCvzob9FKvy9eOr1ud7BvsT/kUD6AcMhpifoYQPIswmBOz/ZIgDe/rxjJuaJd7OY+sHOSE8FBz448f+xwQcw8vo5z7VO17ksXCz7B9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MHB7bcTa; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=pMK9tHM1; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MHB7bcTa";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="pMK9tHM1"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755UHWV3475660;
	Wed, 5 Aug 2026 04:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=4FndrEkmAPWhcfdRyLVVNX/knbShDtZlpuDR3wpqn6c=; b=
	MHB7bcTaUm9TKvLzIkJkub4+cpqFEdaQRB5gDcTTLTgZgOpl0+nAfQmDLUSdyRH0
	JksNdR2u4Gb24QAG2Mp5z154O/hCP0Pkih2U2S9j+Io6Z/MWqcjeLX4H3MpyRaha
	dgF2XOD4MY/VXLmsN4+mxmhNbEys2us4geGcaq18rl5+rXS+YtD+uSloQRYk2IOI
	xRuQETsOpgvUxibQCt7wusltdbeN6/Jx3aTwjw+GtbEuodD9/7PGI/GPWNLkziLX
	lUpQ6LcilNhNACHl/HNl9/viWjP6NhbqH8ZKG+z/cIayGpSUr1TpJ33lUvAXtohe
	RnZfyyuIuIJYD83TYV+0Ig==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11020107.outbound.protection.outlook.com [52.101.61.107])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vnd4b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:00:24 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y0E0JtnWvG9fl+bPmfUBU1SOX4z6xdESV6RP11mbaneAz2+l1l76u0NlEoyZMhDJQowkbqNK55plmPBSn3aoB0Qvmr5FxIKE8bFmKhC5vyvNndgTyGpuhktyC0pCdFLmb/I7NSD11EcHpM37U9WUWgdLWsUIJA23Pa4wExIg6rdU/uD/tPh1nhj1Bq9HMTCkUnjjVxiKQO1gqwRrYFcuMIs8TVo6v+uWROSUxBh9M0hWZu1+iLhakuDjCcmAE59NgmFlA35WsjhovtHVuzWkhoAXFwwLsH24OGDT/A6AGuzi4BcnQ/dNbDXl5dg6o0dx8ydY/TxLYCaCPatlQmvVlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4FndrEkmAPWhcfdRyLVVNX/knbShDtZlpuDR3wpqn6c=;
 b=mYEDkdCtNc/XJifzFXcKSJ99q7jgMvRoIE9p6PwO4HJn/a5M5LHY4qdMPWoIKczGjNMFlvr653eTviMKi2pjD91WEVA4JzmmmMvETRdsuZ2om/dv6y9RaHJEDRTEebOHNnWI1J1dMJLZ0tG8y/60YHLUqg67wScycMHSri7z2f+RODM+vbbU0Whr+aAeWQ0Cc9cd88O0IWEZB9SXvkpAV7ZDzyL0chfB5FeDjFXGdEj0cDRkdod1wcp3h4cVuFehN4w8Nwc6zvoe3n+EoVLTO6wZbyMxxRySl+SYoDNcE9l8arlsrrbNhCpsFp1Aq3rWNPOZFTossm0z5CmcLgMqow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4FndrEkmAPWhcfdRyLVVNX/knbShDtZlpuDR3wpqn6c=;
 b=pMK9tHM1aKBrBNkmyDpLMjjci3wO4ew/DsXEqpxtkx2rx2GIppZ44J8QznUoijkJMB4HfDnfVywO/p8uAWveLaKiKsOWGWdEtmGWAAHDvhmAGeRYMikuf2AYPT6xQb/AYauZt1D6pB8HVNjxl9veQ3EXfp+LeV22AYrG65CL4rM=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by PH7PR19MB5944.namprd19.prod.outlook.com (2603:10b6:510:1db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 09:00:18 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::52) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Wed, 5
 Aug 2026 09:00:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 09:00:17 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 4BD62406544;
	Wed,  5 Aug 2026 09:00:16 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 42B3B82025A;
	Wed,  5 Aug 2026 09:00:16 +0000 (UTC)
Message-ID: <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 10:00:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR19MB5944:EE_
X-MS-Office365-Filtering-Correlation-Id: fd41080d-5d0b-4745-5cd1-08def2cff8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|376014|23010399003|82310400026|56012099006|10067099003|11063799006|4143699003|22082099003|16102099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NwmuUgik/+XDvmFQ5H/r8XxzgYpZwBPItPRruwR+8K81247Z2YVLlc2MIlCDstWw6mYBxKfnjreA0UdGd4NALIEsF1QjgyIL5u0L01Bh1pptyDmOffLvfrKKSHjWg6isjLnMYDdOiSbEXenci0L91+xDVwpulhuviHBpqkeahijgwH3cp4Daq/ybY0An0f+SsJIFk8r5iAaotMAXCvyYVWRFMS6/ChyRlTRozXumJZgIvBsC6qqfJ4Th5P0bS9m3gGhKGH7oA3WEBeYcB7hV2tC3trNVkMh4uocsYU3NMLT8q6e3eHDbQuAo3puusyL4+4vExyjasXNBHfu462xypuX/rIw98rIdFJmxQwGJqEm1zsiiBe+ASmxsGZ7pn1aRyZJOybTF8sqFL/Qk1ElbIlS/EuFJalHM7kbKUnAoCnib19rLp07MxSSarnZxjQKWQf+IftHtp5cksrfXb/c86xJiJMPBHvJgitB4/4ptSjd40aW59AX6/sJ29btCh9CzdAadO0TqTQtg1urM/oLpWJ1BjZxOZ8NE+PeATYaJUi9h/ERF0ZDFcVlQzd7qOELtpfWX61ckTKIJPfT/kYe9/Ff3V133k5toPvmMOl/Jigwk5GTMV90tKi6gUGk6+voCS7HxPIVsQ3EnRWgqG2ficUtQHDlB7sF45yj+TUTDm55mdzq6iD7XRe+OnonvX65Q+m4WMEyqg6PK0OCSlzr7aQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(376014)(23010399003)(82310400026)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(16102099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	brAY8fM7wGVchUgESTLCwj+NXzdnzK4ui68AaCJEJu569n6dY6JvKGzi4y3U4x7vUPlhTbp27Eg7G2wIbd6m6U1FtlCx6cJWOzic6THmv0sftVXOzBJKVQaPNZjSLR9Xx49DymEMUp2eB7lSBRiF4xbFSnyfg8zhVWjPyORi54+K1nfZUm4jwx8OfAlCWwOhaqNa9jFqqZsmTWQRRWBA/Xkk0fsdTLiQLIZkn2zK/ZXGkWYLjCAofbQzEqIzTDoPd+dV+3BZASAS3Q2N6POPJQVPc9yi3Rq2qbs4D4yxFoosfga8Yq9kDZE89zPkD0ye6gw6P8x71OZc0sZ2CK5SJrQaYWy1b9XzSEkdDWluCN1ZaTJUAkGrcqfF5qGLTuL0NkJQVJk65EnT7QmseJTm5JLvHDd7fnEDl+b9POHZ0Sllt+Th7KPnoGWQ0b1SPMF2
X-Exchange-RoutingPolicyChecked:
	YYi1B7vaG8PW/Yq5h+7VWULP9bdyVk9z9uNJCXq68ZtzCc5CAatpxlm/TidpjsHAfkhOgqc+eeAydsL0k7pBlqrHKtx602VXosDhB/vJ0MDqliJkpg5AOdaysnJPgqjX8AFUwkjEElc8ROhR1TiPCk/M09+rlUy/iTNcDe2h5Oi0O1pouZwWPFo8ooHH+Ya/rSZwJr91MP1P4wamBkWD7NM1dqie9I9juAp4mk/HybuwoSC+g5xqLSG7fp4nCTFJQ4IvLQ2JLX4iCgfnBlzVgUOQ4ep8+5ZhiBmRy9uczVxJRjWXXHhxVX9IpPwZxmhoZ0uJ6S2LOfYhfsgyMW+9sQ==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:00:17.4119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd41080d-5d0b-4745-5cd1-08def2cff8a6
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR19MB5944
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3MCBTYWx0ZWRfXyUVcGmk1pxPS
 SaYoFTIAvZ7qIHvJD2fmV16jO3vz2K6yl6mvTQ+06j9998VuuVBiwrTFSIEuJQlVaV4u4HqXbZZ
 8gVYi3szbWW3pbtj2KAOck66asfHa28=
X-Proofpoint-GUID: kLhgW_4vauflmn3GWgbqY79jJLVZsUUL
X-Proofpoint-ORIG-GUID: kLhgW_4vauflmn3GWgbqY79jJLVZsUUL
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a72fba8 cx=c_pps
 a=5R/USArCWZnskgXodYG4KA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=eV0OG5XM-WKryxnP6dEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3MCBTYWx0ZWRfX2nS4D1/fcMI7
 UcsPtcnVxmgejFl4oVN9WUQ3vT5roFkhr6zCKFeA+cjj8N6e2lmRE5TNbuvYY4YRt1yTWhO2act
 0zK+IAelrj9/cmU3tRxa/6kCYcK3p1mdOoMZ6kyAPmrFVITK2bKAeA3vtYiwHEMeTCg4dW0k4ja
 +FAgJ5XGMJRB44Gz7XaaBFHCy4mpo6fVSG57Qq9TVHOCsuZsXCQH9iSjXlin7hJiNZXjDUraxFX
 aIzd/P/KlK0h54xLRDmKGPAMPXpryse4B0eRY58OweXg2le5NYEyutwalMgBit05fXHACKvC9tB
 13hCkTeZ7y8jJz2+caOxRHR0ZRVUIYIfNK3xbqjT50v8bTDAVixSLBnqn61479Jf6O9+lvt1Po9
 RIiy2gygDpKcBXLG+GfVGYqK/Ry9CKWCX6Cla18fXQON5k1phIlhjCAmlaZJr9GXbtTXloAomNK
 MEtbEfFd0OfgW2x3lfA==
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 9:40 am, Pierre-Louis Bossart wrote:
> 
>> reg_defaults must be sorted by ascending register address as
>> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
>> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
>>
>> These three tables have entries which are out of order, so the binary search
>> does not find part of them.  For those registers regcache_reg_needs_sync()
>> cannot compare the cached value against the default and reports that a sync
>> is needed, so they are written to the device on every regcache_sync() even
>> when they were never touched.
>>
>> The patches only reorder the existing entries, the text of every entry is
>> kept verbatim and no default value is changed.  Each table was verified by
>> evaluating the register addresses and replaying lib/bsearch.c on them.
>>
>> Entries not reachable by the binary search, per table:
>>
>>    cs35l41_reg           2 (of 47)
>>    cs35l45_defaults     36 (of 73)
>>    cs4265_reg_defaults   3 (of 16)
>>
>> For cs35l45 this is nearly half of the table: the DSP1_RX*_RATE and
>> DSP1_TX*_RATE registers sit in the middle of it while their addresses are
>> far above everything else, which cuts the search off from the whole
>> 0x4c40 - 0xf010 range.
>>
>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
>> codec drivers are fixed by a separate series.
> 
> Wow. Would it make sense to have a regmap helper to double-check the
> addresses are indeed in-order in those reg_default tables?
> I am not sure how this requirement can be enforced by just inspection, a
> warning would help detect this sort of issues on more platforms.
> 
It does seem probable that anything that relies on people just
remembering to keep a large table sorted is prone to breaking,
especially if the addresses are provided by named constant instead of
a list of hardcoded numbers.

Should regmap check the table when the regmap is first created?
As it has to search the table during normal use anyway, one extra walk
when the regmap is created probably isn't a serious overhead.
