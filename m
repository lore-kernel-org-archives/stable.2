Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D43382F28;
	Wed,  5 Aug 2026 09:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922718; cv=fail; b=qqS1O9Dn9v+FFSx0HiDlf6L7hBgBwXtVvG2pXQUnlLyoYlN827Bcde7I4t2VzJ8J2DTZg5Yh5Mlxtp/h9U5IYsuE5qz5Uyn++EhC9+jHdpjvxTFSvwgMA/OLb9EDtNaXBdFVRC6JCkgvwfUpby09WVnvUV3l0usLCA0piXO1XEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922718; c=relaxed/simple;
	bh=UzZeoIybxu8MXKeFLts1qnxHlq8+N5mRYipqekm75F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmvCSC8T/gifVw6s4wTyiO7tk7F+7yA8cRys3PPDJdPG051CV6Bi22d6NvJveM2UhHpsHtsWE1baXT4HHkflI4KOtE27ckh6xcRCDgk+csk6oDXxRCBBxaxB2Y1w8PN7mvFRgnTfkAkKv9+S3IogBIl7iN9UEqrCTJWzputBz+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=VxJFSs4O; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kZ+mLX4Z; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="VxJFSs4O";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kZ+mLX4Z"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6754V8Zv3379452;
	Wed, 5 Aug 2026 04:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=44qPk/CsIGD4j+O0bdrG3t1mfizC/bA95yuUsGg6agA=; b=
	VxJFSs4OPBHLqdV/5LVj8UDBGJT6Tsy2Vv0FeJa6nahHkdn/67gkFNlV6PHaKlsu
	N6Cfel9x4SXbemVa1CQL3xdsVn3WE++Ki3lbGILTdDTFDyYpKa0GpJMOU8ib1iI2
	56xPMNY06fxCobxxsAB7J6hmNIhgcnXTGGDh3IoEeba+lX+Sepa3JhnLIKkzk4mP
	J0kI717sYMonrnq+jKYvQXTk0te6Wipudn7cCa4XjdJHqWeTPnILpMstXWUip5m6
	GDRZ3P7o7hU3vt3/AD+x5t/dYVWqA1cRarMQ1MZN7RE+V3zkfo9jSjE3tPYyxS0Y
	WDZpdQeMxfLIpQDcnxf3Jg==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11020112.outbound.protection.outlook.com [40.93.198.112])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4fse6vnej7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 04:38:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfzQQmTP1TlX4c3pGT0N49yRU57lc2D7hWsPqBoJe43LNSR4dFeuSfFsI1R81SHkpL+i1ugPj7gPoc9N5hS87XTZUR/Vhwnz/+bQoZP9uS5hgh+VY7p4QhjdLM+4WBfRqETX7Lh15j7PRzIJIjcy2rHGbA2oOPT29mV7qGSCFkGnJcqAMkqVAIg68CgtR74pMEZCZpG1aJHz1+okJDyo8yUtez5OVZKr1NwdNGHbF9XaT5hWz3CCKbo+I5d0h6KT1/usEl99FMeqIrceVFsWwSqyymba9GACE1JthFeYB3tJLOYgQeQA7SmOqcyZho0lhA69J1o7+MrxMtXwJ680uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44qPk/CsIGD4j+O0bdrG3t1mfizC/bA95yuUsGg6agA=;
 b=u4bNj53at0qQSWok6bhBnBwMfbw8ZY8nzmHNJeo2qlVEP7lVoAmtw6B3ZAlrFlWROARDtSn0FTINIrvkaolAdLa2gIajM8cbK51DnqBBnYKBiGoRj48XW0KwlIWVPo7EWOus29U424LMT55RUMytEl3eU1CFqZ35XMFxpwps5Qi8F3VNSL4WOwKd7KCLRDO1BpA2uj97cM7oYrpAiNlkfVCgHTrvfkusDrfOmpvjq3SEAV2qDPxXhI7FuMhK0ri8by7UNQTw93dxyP8cM3R6RQB1VEu5kTB3rtZmTXUi3Z8ZdaVCbMo2NJEjRzn2BahuOIdiw2oOyJWCkDQZjJPFug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44qPk/CsIGD4j+O0bdrG3t1mfizC/bA95yuUsGg6agA=;
 b=kZ+mLX4Z5CZ4G+70fK/ncsmy6NHBYekOT8ick9pRyIHH7+WgVWR089eebs70XCXv8hYhpr3w3/gYDRvat/dfacf1/JqtW6DNygN0M0CmeEspIL8tGVv4RfkGBHgPsN1s/ml+oPM2PF7t9YwxWDaLB08m6nEUeCRMRCOq5/TwOJ0=
Received: from CY8PR19CA0014.namprd19.prod.outlook.com (2603:10b6:930:44::19)
 by LV2PR19MB6030.namprd19.prod.outlook.com (2603:10b6:408:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Wed, 5 Aug
 2026 09:38:27 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:44:cafe::3b) by CY8PR19CA0014.outlook.office365.com
 (2603:10b6:930:44::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Wed, 5
 Aug 2026 09:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Wed, 5 Aug 2026 09:38:26 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 51EC9406544;
	Wed,  5 Aug 2026 09:38:25 +0000 (UTC)
Received: from [198.90.208.11] (ediswws06.ad.cirrus.com [198.90.208.11])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 33BE482025A;
	Wed,  5 Aug 2026 09:38:25 +0000 (UTC)
Message-ID: <81391ad1-1097-43ca-8729-ae01c00db3b2@opensource.cirrus.com>
Date: Wed, 5 Aug 2026 10:38:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults
 tables
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
        =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <anMBeeNG1fDpFHzN@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|LV2PR19MB6030:EE_
X-MS-Office365-Filtering-Correlation-Id: dba3f166-e6c9-4850-733a-08def2d54d13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|376014|36860700016|23010399003|82310400026|56012099006|10067099003|4143699003|11063799006|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	zyJXObFh/Ev9wWOCHZExaIiUlJL7e7NtClz4uIrGBftFgX+a2qbUuvSF90h6/80ftBgMYoDqOIo9O19XZqJI2ycnYnkfWdv/HZd9+zwzfMBayzs4YfoVEX2zXw2pXhlskivtWFplep8KTlnvug1w61vwf4X8ZZuQQF1gpOyh2On3bCMuEDL+EooUFjyOy/RxxPWqbvzoV/Q5V7K1wPPlKyQ4FQmTMcJ+H78LXim4aKBUcTJVmhZywuDZiOjod4uPT6mKWQ9nredv+vrQ3yA3mC2Zwe3Bmgbh+4uEQf446MFxLHXx8VK/H0MRZo115MnV+6l0ddaBLlpJBrdlt/XJQg7REJnCBYI6M3GYp7ep+DMovZzLxfvtqaqeKD+5dERR2Knjbxjy0X8BfisS3rOg33vhr/hZcB0e2z0+7/tqc/0+CBvMB5YgUPMi59xFWuQy18QefqLiYpnzGNUuvrFt2PAkkCU0f6DTyqdSU8YSJjl2EGluPG3e7+MaWl+ZiZRZgNHmbNkKLRy9uWCRQMTLftS0rKWQwQME5ON6hYh7/54JkN2z2xU4i8Xipxjh9EsNfztgiKNo0LrG0L8m64vvdSeBfXDnqr2PuzsAlNueGAK0YX7e+IvvHA9eq9NG1i+fQybfO3NEiqsxW2UD3jZP0uKIEDYIDIXoOXfu/UqJPec99pHBc81g+WZa/vG3rp/WvBJ0Ytp6Tp6E22ljDZofNA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(376014)(36860700016)(23010399003)(82310400026)(56012099006)(10067099003)(4143699003)(11063799006)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y6C39v3hyrSnf+pIGX6QLciEAOu/O3oF29NVQNr/1jbTBt4jSL2KxfUxwnsZdhZaPKGB6lBs+sjTtBkqhcA2apU61RyIWtsEm4NJmV8XEinDhFVpyWk6iAucvRwYW0T9AxQHl+U6yG2nKNx7OQAEeg/girkqXuNfJSILhEyxCszApznhvR/SVJ4AyFgdYA6nVS43n7sznIIREwQGDbBRVi0c6wbFfE3CNpMLboTm4pDdG/pa46C1DC2pKMO4m9PkTBDLn6hZoK1GEe03PGNco/q/kz5sLUvuRWazFBDGXpD7mds/79z0xDC12Qd11jUMxMIQ8wvpwdNQwHZBIFOjYIEAS8OxCyi2cy1OZJhiOCC7HrDGI/TOwDDMQ/Z04xpPSS3l0upal3dR5m8iUR/PeO1NOp8KtmUtrSyVbvqPhlYrqGCRY2El+/OxQhseXuQT
X-Exchange-RoutingPolicyChecked:
	P7GEdZmmYPcjQfPjJUAAVM5X4QTx6liJZONNSbtG3yPxu9+EvEWhRhTPGJOL1kcyEKdRuFABw6Io9uMRwRZMYMOu6hZkqG+TLtBS3RvkDUrHx7G06r5u/umU2g11kcOXnbtnM64kQaa1iQ48Rryl1B2ppjRWXfwrelkXEA43nPe2tdhqtaTNidRgSVpYvJkdaE7qrTFbtkkaDp9t44LlLhvfm1tax5FSqqy1sB3kupLoJOAeKycOtcXUmaiaRBNuh4EU28TSljHvQTJikyHxUhJzk5epe9gHVv2Mm6TtWUb3uGtWtmI5Giz367MS4Kz44obUMku7dSz372jvtW87Zg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:38:26.5355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dba3f166-e6c9-4850-733a-08def2d54d13
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR19MB6030
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfX+wdWpPGfI+tn
 UgG36QjwJfSibUmi9MKN/4l3RGw/8buqNr6fkYdsPiXjjpD1NT10ven5d+MOlJqvBlGiN4NiS1Z
 I8aTQ9StTSyVZmNMUBxPARUVV+08lfs=
X-Proofpoint-GUID: BAxiB9fRJydB-GSxilrhvwWP4xe90LB4
X-Proofpoint-ORIG-GUID: BAxiB9fRJydB-GSxilrhvwWP4xe90LB4
X-Authority-Analysis: v=2.4 cv=N+MZ0W9B c=1 sm=1 tr=0 ts=6a730497 cx=c_pps
 a=waeEY1lgPsvMgfEg+IY2ww==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=TbQujXIpDSk-lB6M3kcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NiBTYWx0ZWRfX+D5EmMT9sjGV
 RHjjEu7RTqa1DAReLN76ChVVGV9laQ1LFnjuJEABlhauaf18j/5ZHmzUZv2K6wGR+t2rrnCJtcJ
 O598w9Ylk+/9j4ThZIYdA4H9DKL8jQP96bexUMRA/aYLOJ53P4ZII7JlrELEI5Tpou+F4i6FeW0
 hXHu+S3IlQGrhssJWRT1Ju07cwdbpYYGYduBzx2hCh4YMKLPbu8eiAckc8dqCHi65r5T7iG7TSI
 Ma+9b3wrupIMKcqks0jbor6E9Ot9HJvFP2Qbky/0P2GcGLeZG58jxhEWJwvIKNmRGzmtYEcP/Vj
 wSGwd9CxM6ZkynXCiWW2szpy4DHcr/JTI9pNL9jR5P6XvTnSmy5Zzswl0NFLRFshrKePnmVtfbH
 8KZdzlsabYHAei+KHSx5GpDK0uDCaYkofRfMRe6oR8gUkoFntJPIXvU0Y4NODzTvhWwMWM7jOy9
 zUBfURBqo0GuINYN7/Q==
X-Proofpoint-Spam-Reason: safe

On 05/08/2026 10:25 am, Charles Keepax wrote:
> On Wed, Aug 05, 2026 at 12:10:10PM +0300, Péter Ujfalusi wrote:
>> On 05/08/2026 12:00, Richard Fitzgerald wrote:
>>>>> Found by an audit of all reg_defaults tables under sound/, the SoundWire
>>>>> codec drivers are fixed by a separate series.
>>>>
>>>> Wow. Would it make sense to have a regmap helper to double-check the
>>>> addresses are indeed in-order in those reg_default tables?
>>>> I am not sure how this requirement can be enforced by just inspection, a
>>>> warning would help detect this sort of issues on more platforms.
>>>>
>>> It does seem probable that anything that relies on people just
>>> remembering to keep a large table sorted is prone to breaking,
>>> especially if the addresses are provided by named constant instead of
>>> a list of hardcoded numbers.
>>>
>>> Should regmap check the table when the regmap is first created?
>>> As it has to search the table during normal use anyway, one extra walk
>>> when the regmap is created probably isn't a serious overhead.
>>
>> But it will be done for _all_ devices which uses regmap on boot, small
>> things do add up, see my reply to Pierre-Louis.
> 
> Indeed, if we were to add some sort of auto-checker it should
> be guarded behind something like perhaps a Kconfig option or the
> DEBUG define.
> 
> Thanks,
> Charles

regcache_init() already walks the defaults table checking the stride

	for (i = 0; i < config->num_reg_defaults; i++)
		if (config->reg_defaults[i].reg % map->reg_stride)
			return -EINVAL;

so checking that each entry is larger than previous is trivial extra
overhead. I think most regmaps are cached.
