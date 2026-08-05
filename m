Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681E3F9294;
	Wed,  5 Aug 2026 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926213; cv=fail; b=cIqi/T0sKaM7ExroquW3Bb3ZA0f5jRNcNwU4Bq32e58lMQ/C3gQVM7qmoSLiEyrCQchcik6N27NVl2gIJOu7XKYemMMPbXO1kRQpqLseLjv/5vlec9LvAG258ePg20X9LOrPZ+zrCBalDizFidRaAD1MNarF0ow4c67fYQ2prqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926213; c=relaxed/simple;
	bh=ZO6u1A3bZTHrjBIh9K50hkIbXZB9zdPX2w7hsEGu8Lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mnhFGXfdqc6WFKq8ORUKBr5dzohod1z0nFjAd2v3zgX/apMDoHUfIeQ/DE2FuwjDK0j7FrxpVZDlW20txn1D1ftCArPB0Gv2SDcbxCrcsomFet4kBD8Zcm2cReeDwYFmI3RiDcj8DSyQ3ddt8PPPTxoM1YaWRHVcA/CCEvYaqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jCCaIoXS; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=eli7Bvw2; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jCCaIoXS";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="eli7Bvw2"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754M1rP2512551;
	Wed, 5 Aug 2026 05:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=rGj09gtoGL7YVKoUXISarY4gZaAAwjDpG7NSa26gDSw=; b=
	jCCaIoXSlXQVMd+676i5YNblVMXYlRz7T1uqXBWSz7NMZ0amL3/f+hopoVJcK6tg
	4bBk45mF7NT5tWbaAv/UGhRdZninchxJOAT7KFmfqG9tYwsJh5V6R0KV2TKqWY+A
	xfgdCrS97Ieh+ttPGYebifzEeNmgtXewVHmvgDttLQALe1uKWLlK+50kLGg7eTFQ
	C3KDCDGSvgwH9HvrKh7WemIrw9NNGZWS2hq8dPtsCDNgtS8rRopCmgYA/MIZKhaG
	IaIXIGzv3ERNGTCOOyaAyh5igfsv1+K0bwSiru1s75nTfup5iCp1OxblibEU44Gm
	OiyTOzZBXRH3yYASga67UQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11022115.outbound.protection.outlook.com [52.101.48.115])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4fsd7h5jgs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 05:36:44 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zMyGMH4mvr5m7s/BaqnrDZMK4gDZB2q/Ykxr2iC7htd876Rm+KF8TRm+9Bl561mqhr/cFTy8kEm1kovVwFx3aaAk64yycnhCOupSZ43T6EAX97YvV0mWQFbUloEwBMWfhGPdxRCsNW9nnP7i2iNtP3rhJJ7VY0jMC1qg822End8V3cUpOwm2M8cOHMkiDlamG7D+yPqfmUCgJg0WzAUnMs6SyeJ15TuuoVKvuKbPgz6tEEH6xdbzO2gH/QCTZa2o5fFxMhUXX6GOFaUxiPJPfHBsrOKwEr1Vj4oKoBOZ8/Bznmk48OC7EIt2WVtKbidCMAHmFZWYVGo34CmExemOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGj09gtoGL7YVKoUXISarY4gZaAAwjDpG7NSa26gDSw=;
 b=PtgCs1vxZeGMJ3bLcnJd16QJWybT2tw2S0qHL4HS03gdyzTCKBTmqjAohk8sFsNVRIBFsmfl9jZYQNiAoS4KEPwQf8ycpnH1lIRUTAbEW03g2lNEPRgIuPwXjyN7YYQ65/H99oRoknDscIjHC25lFKSloIp11XfUKTzdB77U7kIHNict7/22RgFQU6Poqh5rqlzRdUanfTtmasS1b4WlsyQ1N4x8SBVZhg+BvGEjp98ISWxnO211J65omYPz7m/qSKUgLF8lC8Va9cwvbwiJT78f0M7Gc3AmlEjGghsgkkTxPMvJPR0yBukz06gDfVKbAXYV1D7dnGss3zWh0RsoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGj09gtoGL7YVKoUXISarY4gZaAAwjDpG7NSa26gDSw=;
 b=eli7Bvw25IT/xJRgmJsBC01wsVx70UH16mv8F7TcfKUbyWzDuByoCHR9yHUyhFtVyk/ZKSlCZCF3Anz+GKtS3XrDtcRAPs4UyI5HYOEc73O4A2fMNORoxtJbUpUjpwOfN4twwe8oJMUu31L/3H6dsv3uVHzjk+cfvNZcKYT6sXg=
Received: from BL1PR13CA0423.namprd13.prod.outlook.com (2603:10b6:208:2c3::8)
 by DS4PPF08D96AECB.namprd19.prod.outlook.com (2603:10b6:f:fc00::a08) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 10:36:39 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::63) by BL1PR13CA0423.outlook.office365.com
 (2603:10b6:208:2c3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.15 via Frontend Transport; Wed, 5
 Aug 2026 10:36:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 10:36:38 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E1D84406544;
	Wed,  5 Aug 2026 10:36:36 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id CFD7E82025A;
	Wed,  5 Aug 2026 10:36:36 +0000 (UTC)
Message-ID: <2585c2ec-1146-4a48-9169-274449d1bbda@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 11:36:36 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Paul Handrigan <Paul.Handrigan@cirrus.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
 <c8aac762-c1a7-44ab-afff-72610cabe341@linux.dev>
 <b5631801-2904-48e3-b4f7-9ad6009c1198@opensource.cirrus.com>
 <96c0cebf-3ec3-4136-b010-32187ff8c870@linux.intel.com>
 <anMBeeNG1fDpFHzN@opensource.cirrus.com>
 <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
 <4c407a93-7cb6-4a44-a7b6-4d972e714b4e@linux.intel.com>
 <ffa045f4-dfb1-4ec8-b9f5-ce2205e83fb5@opensource.cirrus.com>
 <5d84444a-c472-4881-9432-e0dbe5610696@linux.intel.com>
 <anMMIH29hLtOH3kX@opensource.cirrus.com>
 <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <9eadca12-1968-49cc-8704-bb6f37dccb95@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS4PPF08D96AECB:EE_
X-MS-Office365-Filtering-Correlation-Id: 876d0ab3-7fc5-421a-bd8d-08def2dd6e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|61400799027|10067099003|11063799006|4143699003|56012099006|18002099003|16102099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UzTcDrSfEVcLIwjvOR3JGGZDkW4XGcL/BUBG0YBscVgjQeHu0drS5rrRf/FFBiTV4fgxNHvLdv9f+0vWGbRYm8x7UnXoTfIgo3N8waaqPYqwRe1ZJjXSYkWM9Q3rkgcytntwwOONbntKdP/KVDeLXRee8gYgAiwr1hFQj9co5I4sM8qmfh/bT+1F5YwsIOBxxyy0y5Me06kjE1yp4vL/ca7PiucJSAaMWy9iUIV5gNg+8i6R6Mab71/3kq8fZVzSsDc62jwm0pE1nVoZ2TS4GWRDcZODQdftHGUzkM1F90TWZMUWOG+uqDEksFxOrOI0SPQ2wuZny91RbM1ujHD0/0p0zZErCJxJVrcHW9tJo9Z4HLy2m0drqI3WxC8nnmn5lPgUQgQ9mlkTHAnVs2q8I5zAS2ld45P+xmauw0R1gDF8vawzhijsjeVG7CwgxpEFuI5Yk6gPYXLX87QGsbaEElLYkJ1vU04VvubTFMhhnZJUpW+9gAmQk6OGd2JtUeI9cXD7Kr5Jg35cqg8M95j/0NJpA8mxxzSRSqYY6Kjn2m4Mh7P9/tEiJqXgnotD+Zb1HErfDb16kXBRtOZBgN20ajHt7E4wzhysgp+0eNWpXVxsz6RosHz7EhRkYaXJ+VTl6gwr38vTYS4OJi/KukdStyKOLYCU3fwcJzobuRwGarq8birgSRQaHL2htl7eG0fDrJZLqxTbvnUxzPxmZNWSAQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(61400799027)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(16102099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmv8zrFS+uyWHH1E6grEv8Zq+aEKmi7QBgvQyWTGwg6ArHdwTMomiUgMExkXJp9LkE4hraZO4KxemAnWntBW4fEDTodE+1FPeHt9gESY/N2RkxqP/En1PxAz4P6KpPhEm0wqJi+Q0vTWQanXWW8PKVaZO4PsqJKEis0j0aOHOSM9GH/UEdXpAOn/kOE7AcHq1QlEZ52tHoIDPoThxeUpOgmz577l8p/gAtf3i6y8p2SfYKZqwPP8FVwWvNhIjo2Ql2EhEOeUoY70VpK8WGnPFs6V8a6ZJuwoVICSIetYD45dlL17QiMOom9uOKTdtL0Qn/M9WRPSV6G4SE+1WLhoGivkQqX6Tn/VNOr9mt9Z+YSoXqhSemiqPC9+TDlNJ8xalQNW1eAFv5eKZIJbRrEzlZmJZkO4KTJrZ6y2kGtgN8lNvFy4PDU8/JA/L029KPLG
X-Exchange-RoutingPolicyChecked:
	LmD5s4FxPDRislYlf7VIds9xXuabsCj22MRdo95fa4GjLwE6fMRP/wLB25GWClIe6KYxx1SqLfA4jaWtrZdPm0kZl35j1boATzIbROyI5WLDwyqL0zKg9R0kaZvQsbg0ujXiGCG9N8XlRpf/2Gd4B0Gokqh4TU/DCk4bl7G+wBFE7zdZ4wZudETsAs1hHSgCxDDANK614qHXBNHjGzsbJcm+kuUD70aP+MmV6hhi6M7x2S/0HHJtlsdKmGme38ATcfDe+Rzati6Hhykb5oiH5L535GQ2IYMGCiJ3r0OcxTiOyU14vg0jv5NmeicODmSUqP0ri6bQ577oTHAaVnZdbA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:36:38.0690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 876d0ab3-7fc5-421a-bd8d-08def2dd6e24
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF08D96AECB
X-Authority-Analysis: v=2.4 cv=ZK/nX37b c=1 sm=1 tr=0 ts=6a73123c cx=c_pps
 a=p38iFvuc/7KNR/RXw9CScQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=LFTPXolYK6JZ0oyPEtoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1_CYQydtHvdTwjncey8G2Q2qdH2PDz4B
X-Proofpoint-ORIG-GUID: 1_CYQydtHvdTwjncey8G2Q2qdH2PDz4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4MyBTYWx0ZWRfX8XOsMRMC3jTI
 Vvtv9i/AnAROCTzJMVe7IiNa3zWo2dJ8UNQBzg2jvn4sY7Jx1TE5oXN3FqV8WerzpOHqWN86vi0
 JsJEffGtdBz7myINUqIL6uUZCA74YZ52JCmh82evHUN4sQ67T/gpud64pjHeSc/C7k0fMFaciiW
 h9o8WjBPtFr7a7j1KwKscVcTahppo13FL3Th1YHTGlOpdJ4gErKRf0DKi6FHh0y6I/5SQWz/VFL
 Te1t4dDhY8aKIJqWhZokZ51PL0zHMJZvNJPowN+8lLg9xEDjmIFkXYQff8NdDLK9Yv7jEbjJ7ki
 YGtHnAaI1lsHcy3FQUKg6A4gXbfCKyq89hLDHFug/kIrBXPQIu9E3ADpVjW0ycz4dhLXpoNObaz
 DTK6ItHTNG49TjZc6YxBJJY0WsRtXUfiq71eK0BhtdklEI8vbIzX4zuxYAr6f0JR+UlxIOM2Ku6
 oipCnkHPgRNyaAct9QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4MyBTYWx0ZWRfXxO9xeJJ9azBv
 3xGRsY8+t6LUMWIYVfRpVmnFvY+CsJJJDEQ60hm4sm0XZFC2p6YIMiHgMBfty916EoCM8Wc6Flz
 F780XiyvBhxdK+GhbgyPvSJdgDrsbck=
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 11:17 am, Péter Ujfalusi wrote:
> 
> 
> On 05/08/2026 13:10, Charles Keepax wrote:
>>>> I don't think we need to sort them. Just fail, so that an unsorted table
>>>> must be fixed.
>>>
>>> That would be a big regression all around the place, ordering w/ the
>>> debug message if developer is interested is much better.
>>
>> I think I would come down between the two of you. I definitely
>> agree with Richard on don't sort them, just encourages drivers to
>> be wrong. But I also agree with you, don't hard fail. I would
>> vote for just print an error message and carry on. That way no
>> regressions, but also a nice big warning message to let people
>> know what is wrong when they see problems.
> 
> I usually try to avoid alarming/annoying users with error messages, on
> the other hand I agree that w/o some pressure, these will never be
> corrected at root either ;)
> 
> On the yet another hand, if the regcache have means to fix this, it
> might be put into use as well.
> A dev_warn at max to get attention or info level perhaps and fixing it up?
> 
I asked Codex (GPT5) to search for all reg_default tables with out-of
order entries or duplicate entries, looking only at those assigned to
struct regmap_config.reg_defaults (some reg_defaults tables are used for
patching - those are allowed to be out-of-order).

It came up with this:

Restricting results to tables referenced by struct
regmap_config.reg_defaults, 39 files violate the rule:

   drivers/firmware/cirrus/test/cs_dsp_mock_regmap.c
   drivers/leds/leds-lp50xx.c
   drivers/mfd/cs42l43.c
   drivers/platform/mellanox/mlx-platform.c
   drivers/power/supply/bq25980_charger.c
   sound/soc/codecs/ad1836.c
   sound/soc/codecs/adau1373.c
   sound/soc/codecs/adau1761.c
   sound/soc/codecs/adau1781.c
   sound/soc/codecs/cs35l41-lib.c
   sound/soc/codecs/cs35l45-tables.c
   sound/soc/codecs/cs4265.c
   sound/soc/codecs/cx2072x.c
   sound/soc/codecs/lm49453.c
   sound/soc/codecs/max9860.c
   sound/soc/codecs/ml26124.c
   sound/soc/codecs/msm8916-wcd-analog.c
   sound/soc/codecs/pcm512x.c
   sound/soc/codecs/pm4125-sdw.c
   sound/soc/codecs/rt1019.c
   sound/soc/codecs/rt1318.c
   sound/soc/codecs/rt274.c
   sound/soc/codecs/rt286.c
   sound/soc/codecs/rt298.c
   sound/soc/codecs/rt700-sdw.h
   sound/soc/codecs/rt711-sdw.h
   sound/soc/codecs/rt715-sdw.h
   sound/soc/codecs/sgtl5000.c
   sound/soc/codecs/sti-sas.c
   sound/soc/codecs/tas2552.c
   sound/soc/codecs/tas2764.c
   sound/soc/codecs/tas2780.c
   sound/soc/codecs/tas675x.c
   sound/soc/codecs/wm8996.c
   sound/soc/fsl/fsl_easrc.c
   sound/soc/tegra/tegra210_admaif.c
   sound/soc/tegra/tegra210_i2s.c
   sound/soc/tegra/tegra210_mbdrc.c
   sound/soc/tegra/tegra210_mixer.c

