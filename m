Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794604528;
	b=h68gaZCwloztfWFP3L5sYaSj5afpG525OPwRXlGO5ZMCOAUdMBZGC3zoc8fE43yPSK1R
	 4UZggR6ahegZbi8xUBh7LDxM8SQKaTl8IUhU57NJCip2N5rccu5FIYLlkD28Qc0+4Ocp8
	 9DWXn3Fxc1ct2Nd5W/bnHzMxdyMiQK73sqrkFgFXkmhRqbmSCqKb8jVgVQgATE5tiwTX6
	 tq9BVTHij3Z5xsJC2+6cq/aEmqQLIejXiFq1fFMCeYMOPH9x4RRSjGAp9VdFmQZBxA+u9
	 fvj2sVW0n76cNE8nWG7dvIoQ3Y2oDqHTuUbLGrw84pd2aQnQGM6FOD0qk9sUbkgCgLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604528;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:Content-Language:To:CC:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=vv9M5YrB2iJrwSPQu+p2ArX7oBr6HguEbYCfvKU7Y+4=;
	b=g8JxJQU/Fozo2iLADxDgj6AYS5YjpZP3f159vIWOaQNMhccksxWgfnirdWODdCOopqxf
	 q4jl66AaKWJMSgstg6y1BFYOYcIFEApw8RW0SugkP40kOt4yZj7JD6XwVCpswKifww3jy
	 I1yhm1mibX+bPtzcfC2rqZ2ljmd06Ooi8XwrlAx4wT6wu4GKf4yubdXc1oAIyVbgXs+vm
	 fmSZjanyI8AGLSv2JJPZphbAvyyw4NgLqG7fukzxhclTE9gHyPL7HtL3bPDsoOsc4Jwbe
	 rT2Rh8fb8XylAuuVOtKUM0wzCNS6NUs3sMdV0bWFsKLfBwj9mE5IBVlUJnss6YmZ+3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VcPt8qtw;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BUfaXhSL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AAF606A323;
	Fri, 13 Nov 2026 21:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5AAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VcPt8qtw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=BUfaXhSL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794604527; x=1826140527;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VDNgBACBXL9ti1MibyTmgSrI2+4wcP6MvI5PsdogBRQ=;
  b=VcPt8qtwVubrgOisimSewzWjfx0kbocEo1WM5QOwYBBMejGd24sVcPR/
   LQwLtn6UhflMlFUi2qvmn2/82VvCvz6/Zgwmu6mFy1SAFW5mcre6bsg7Z
   V0YFqfJjHX3jki1E0LFMb0gLxunjHx1f1Zc1xLnl1XZ81hwwECDanwlAa
   01ETWiXmSEls/7vYlQANla3F0pARptQDf8+nHpFbFdk9QVV4R2PsaioXC
   GZC2SJudGvjSWmd2Me6np7udl1J/MRqzBFp2Yp06Mt2ZVTpSkXldxgTjt
   uadKVcSUKmkv2839LRBwYc2M/aLddtJ0SqzfqBYUGDlzZ11DRPnmX6QiO
   A==;
X-CSE-ConnectionGUID: 9x8vnwN4QVOZVsV1pLb5+g==
X-CSE-MsgGUID: NSIbf/bzQfaaGzuOPvn5+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3326803"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3326803"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 13:15:27 -0800
X-CSE-ConnectionGUID: a8G85FbeRBqPy8pwlYBA9g==
X-CSE-MsgGUID: noTontpTStWDYZKv8AzB8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9114787"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 13:15:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 13:15:26 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 13:15:26 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.51)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 13:15:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WomUoK1/7uGiy80PLJNyNo0x1NGt+BMoQrkuf/dS4/pgc+NijAlfueZZGuAVZgUx2/89iEq72R8NppaBkQsybaVWWrPIpOTqGlzrHfFuuFDu5WmKUhkxDOVpTlO5Qr1HaZqw31Wc/RetS99ipwxIO5FQC81yP5CrmOADF0RHSdkKlPIZufKG8i7brmRikrx7Up+MAvyyjCRdvU+rY6dAA/rAxqHnZTmbgG5qOVXHNDp4Dw81cipC1bQ5Ge9I1UdnjIZaK8Osp1Qa1e0UORLAcZaZ2ILCcNrD6/yXYUZDByEb2Uywj3F97l8frc2A+r5E2JZwkId7p1g0zbOMJmlevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vv9M5YrB2iJrwSPQu+p2ArX7oBr6HguEbYCfvKU7Y+4=;
 b=xObxviZExfuYEO4JdC11fWNPbnws010mpDUg0rK1Wp96bTMeeuLRg7swI33gSHikB9yZ0iLIgcbHo0RiICzntyVD+gLKfdJbg8NQYltJvhf1ZjZlY2BA6S2dq/1jFz4uFXDB9aFMcPE4Sg5Cma/qVB5T7ZuejOfgfkLRT78XPGlIrdS71LDYFPoxXarTO2OiEA/kMAIybJYSy3Ab8sGmxDQaduKE3O7zqjok+5SW3jNqmoq1pX/Xp8hFHAjH8IvqRYSZI9eRzyXaIzWw22KhDa1SvtFeGTQWorDBD/JLKzGlSwbhXvlWgI9nYyFxzWKR5pGvYCOwkof8jKUYBv8tlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv9M5YrB2iJrwSPQu+p2ArX7oBr6HguEbYCfvKU7Y+4=;
 b=BUfaXhSL/3nnw26c1tbR9UBRwMOA7PTETrld7B+742kjTOX8I9WtQ3EhAgLE6f7Ov96EB7P8AvhFCVcv4rl13jlSH5jMAvwRV6X9EE61GXcpNrY54iQq5oCh1JXH//c0/JoFKqVD74GiFHS89aSwloFakwXeE9v3RnTCm5I9seU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14)
 by CY5PR11MB6365.namprd11.prod.outlook.com (2603:10b6:930:3b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 21:15:22 +0000
Received: from CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395]) by CY8PR11MB7846.namprd11.prod.outlook.com
 ([fe80::cae0:d05c:b2fc:c395%7]) with mapi id 15.21.0592.010; Fri, 13 Nov 2026
 21:15:21 +0000
Message-ID: <88cf2dd9-9308-44a2-a536-6285c9783c57@intel.com>
Date: Fri, 13 Nov 2026 13:15:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] x86/mce: Restore rate limit on MCE logged message
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Qiuxu Zhuo
	<qzhuo@nvidia.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Rik van Riel
	<riel@surriel.com>, <kernel-team@meta.com>, <stable@vger.kernel.org>
References: <20261113-mci_ratelimit-v3-0-ada38c5a6c88@debian.org>
 <20261113-mci_ratelimit-v3-1-ada38c5a6c88@debian.org>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20261113-mci_ratelimit-v3-1-ada38c5a6c88@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::14) To CY8PR11MB7846.namprd11.prod.outlook.com
 (2603:10b6:930:79::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7846:EE_|CY5PR11MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ba1a9cd-304a-4628-ea6c-08df41cb39cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|921020|4143699003|11063799006|56012099006|261021123027099003|261102123227099003|261021121427099003|261102130727099003|261026121527099003|10067099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NMfh7pafd9F0DeCf56HF/VY+cVOkgo87RMNh+4kPrJl2rvxgD6iegkrNZCEb48xToocCREvTLaeguaqJAjFxFSqbwNvGLaUFIlSmFxMPQ7cPHeY0TBlMdyF1DBcx3uf+G3pYPQ1nfrUHoojTp50WfMuFAxN+Y7m1cKSGForfT2VUnHjLft0NfU4mueEGOokOAvpLgTtZXt4N72HFqtj3GlOnq4AAbblQMvrGEbw/sltuLDQX/Zbt7q7J1J/gpVHCalOUe70CMbD1QIz/UqJie9ttwZr68aSr1hb6P6hO80wz1pUZ7mrWhYzj/E2BzGzaqQ0X4JtQmLAZu98OWJKN06rGiCkUyeG1KR5AOSgNZ37FwSaDJd2K61g6xlwalygElGdIefsMyCHRQDPTFiDm37fu8rnD0I6aaWWs91MrYstyY31Xh7KQyKUj1pEFdxqZrAAui40WLF5oN8JD7NCAq3YzhslnNQ/tED4nyMX9tSxC2M0qKbZaDkhb1s43xUD8TiiEgEYWDjmA4Zn/GCWTmmpSj45PclFF2QVLPMOiTMpHn9DO7n+QpR0YxSxyctsBDR4RJ/C4Yx16RJzXqTguOXnjViQMsusxC+vJpAyJx+zBh3PAzKZFd5tKBcg91dvssr/uOpFGn3OIe5AlbQvQYCg7K19PCB3h3X9O2f4CbUYMtjyCsgI7HFml7LSwJsfpMzpDiuFMkG7iJFT+eAtyEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7846.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(921020)(4143699003)(11063799006)(56012099006)(261021123027099003)(261102123227099003)(261021121427099003)(261102130727099003)(261026121527099003)(10067099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzlLc1dWY1pPK0lVS1BZNmw0clR1NWVhcHdySFIxamNmeW0ybmdkRk1VRFVE?=
 =?utf-8?B?K1FQZEhySXBUVnJjWlhXRkVRUWtjV3JuVlpJa2loVm5rSDNlNWw4NnA5anp5?=
 =?utf-8?B?ekc1ZzAyS1VTRW5JaEYvYXNQSDJMb25yNURqNHpxUGpkWFh1ektJK0xlelVi?=
 =?utf-8?B?bjY1Y1JnK1lraWlSbkl0Vm43WnJpODNCT0dHQmJLSThEVU12aTF4QmhUVVp3?=
 =?utf-8?B?enhVcmFnZGh3OUkxYjd3WEl0VVlXZDcrbzRic2ZrT2ZWd2NtcU9QeHFaclp6?=
 =?utf-8?B?TE1pOWZ0d2VocGNFYXBlQ0xGcDJ1T0hML3VIRHZrVkdnZjB0Rk5oTTRJU2la?=
 =?utf-8?B?Wkkva0JadkxkVDVXVzVuaXdrM1lKYlhDdEhHdDlkbFRNT0oyd1F0NnVlOFk4?=
 =?utf-8?B?Z0VERW1TbnhSenB2ZndRWndPU3d4STgrN0xiY3F2OW9td2d1eFRYMFhib3M3?=
 =?utf-8?B?ZXFndG5DVVFsaVFnaWZ6TkxTcnpKQ0Z5eTlMNVB2UUhxNHk3MjhQQ2FSVmFW?=
 =?utf-8?B?aFNrbkhlVzVaRytjdTV6RlNqZXF1VGYzbS9reW9KalkxaXV6bHdTci81REJ3?=
 =?utf-8?B?YzQ2cWQzakZiRWRya1BCOEJTekRwSzJBZ0Fnb0NZMkt5ejd6a056QkJjZ3lI?=
 =?utf-8?B?WnhXZytYeFNCSkpTdlYzT3FYdEZqbnhoenFxT1pVQ0N2UjNEbUoyK2Z2TDl4?=
 =?utf-8?B?L1hKV0dJYUM1eEdDek1kZW1zakJlc3FKK3dxS0J4MVVmQjdTYzBvUXlhbnRr?=
 =?utf-8?B?dG1PUG5GdURWZzFiUWJpeWZKTUl4aURrbWtPSFY2b1ZpS0NlRHVRY0JrSXNz?=
 =?utf-8?B?UG5aak0vTzRWeDFhRUY1YVNUeDJJRzRoc2grQW9zZ2hzY2RlQXV5N1hmWjds?=
 =?utf-8?B?KzQwOXNEZFN2aENEU2NoL3M2Y3pxeG15ZmRVNUs3ZDRmaGZGVys3TDNxSTJI?=
 =?utf-8?B?eUdNeTdFZ0g0SE9La2lyRW5Sdjk0WDNTaEJHZmUzRFpoeFV4UXZBSzc3bnVo?=
 =?utf-8?B?WFdQdWVQQ2RRSlpWT3l4d21NR2NpczZrR2JLQmt1R2NvdU5XN3NWRWJaUVM3?=
 =?utf-8?B?b3RTWndXdXFGVXRqV29rMjJDdlVHZ3UyZ3Vzb1g0N3doNTBiVlpQbW9CbTBF?=
 =?utf-8?B?RlUwOEdUTk1uUlo3TTJMNHNEb1g5UEZISVJvSjJ4VDlYaDZ0dEhpN0NCbXAy?=
 =?utf-8?B?U3lJTC95VndSQSttSm1wWHhHTG81NVUyR01ydE5NNzY5WkR2S0Q5ZjE4N1lJ?=
 =?utf-8?B?R2hGdStLTXZJR2p0SEJ6ZHZqRkRMN281TEFsbDM2aTYyMlh4dmFEaVFGSFYr?=
 =?utf-8?B?NE5POXdKbjFvS0w0WW12U0lIS2FYajZVV1JyT1ZveVhFdzRLN0NYeUtqaXh5?=
 =?utf-8?B?a0xRdWlKWVpoN0F5aWl2bVdHMXpNM3g0RXpSWWU5dWxwNXZudjBTeGx1dE0y?=
 =?utf-8?B?NUk2bk13STdBWU9yZUJ2a3F2ZDNsYXRPZGRkNkxXM0RldldZalMvcm5xVmg0?=
 =?utf-8?B?VVV3aFFhZ0FjdjhBOHp6TjVYTXczSS9kR20yNUQwSkxTSEtqeUJnS25MbjQz?=
 =?utf-8?B?d1A4T2NQMUMwVUNFTEJBMlJYdndueS9JVThsRkxMUG5CT3dPLzJjVU9XUUcw?=
 =?utf-8?B?SVNHZUtCN244N1pNVjZ1ZTVRYXppSnNoRGc1L2FwVS80bWhieFcvT1dnQUIw?=
 =?utf-8?B?a0h4Z3FNTDU2dnMzNWdPTW1pQUdGTkh5R2lLeUdKN1doencxSWxPVzlIVEw0?=
 =?utf-8?B?ZGNUeC95ejd0cXRWeWJsZDRteWNBN0YreWdmeWR0MHRNdDlqTXlWUXlxdnJF?=
 =?utf-8?B?N3QwaDBLelgycFJpNlhKUXZSRHR1VWVQYXBKSS9hYjJmK09PM3FqaGZNMXlx?=
 =?utf-8?B?RzRmcDEyK1EvUVVtK1hDQjZNTzdTRVZGVDV6UzNoeUdMQjBML3hURmlld29C?=
 =?utf-8?B?N3FZdWZlSmp0a25pZXFGVFRWNkgyTmp5TldZbVBNVjNKYkwvYVRXdjJoMnpy?=
 =?utf-8?B?bUJrRjhPMEY4ek5QK3ZpUVFDYllWTC90QzRHMnhoaDltTlEweHBWVVUvQWRp?=
 =?utf-8?B?ZGNScHJ2aUlkc3N1K25jUTVPdTJydDNNRGJzMHg4Um4wd0dhcXJwSjZRRnFr?=
 =?utf-8?B?NXBVS3FIQUROMC9rRVZvYldzdFhjUXBjV1pPQ3BWdlpQdFRhdkdLTVJ6VDRr?=
 =?utf-8?B?MjZVWnhmTHNDOHZlaXZBNFZsM294Umx5NmRvUzhiK0x2QzZEVkNJVXEvS0pH?=
 =?utf-8?B?TjdXNlJqWjBUaVJLM3VrVU9GRzFFZ3Npck5YZUk2K2RXVWd1L1MwOXlJc2JH?=
 =?utf-8?B?NzZFVms5MEg3Q2ppZkJWcW1rUCtTTzRIYlFoQTBhUWtGNUJrU2s5dz09?=
X-Exchange-RoutingPolicyChecked: qiY1kLshcl46HLVY9biXWWJFAWglfWHcGgl2MCzayLuI5+kLJjKsv9ORcde+jtcddHcengv78Kv7jX7iH0Qe0Zzx4GzD3KjbMQnwVcRWioQz6wYI6T4WQqdRRCTOhuMwl1Qaj6wbdr2VdX3ziaMBYLG2Bw/fPneItQ3o/9QvQ+X+Kn9OqR4Bx0sivv7ESukN4HKTrMrqRepUZP8CYuxOpFT43RVEEdW6LzhWQRPo/XhlVYq25VCHLf8yCmQn+lbNglvpGv4ZZ8QKozrwrBo1Io496haLD4yTwjN7PrOj3gMAsBY9LseQ52YJt3z82kgE2RokVzSnftyDnppUK2xcKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba1a9cd-304a-4628-ea6c-08df41cb39cf
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7846.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 21:15:21.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WJYajlXZrAZb9IK6eQiovzcIE788b3+oMkkjW2LcH+0IGRiTX5KPs8yxWTWqnZEBiwpuKu7DaZsRTLWzUlhguQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6365
X-OriginatorOrg: intel.com

On 11/13/2026 4:49 AM, Breno Leitao wrote:
> From: Rik van Riel <riel@surriel.com>
> 
> Commit ea324444ece9f ("x86/mce: Restore MCA polling interval halving")
> moved the "Machine check events logged" print from mce_notify_irq()
> into mce_log() and dropped its two-per-minute rate limit as a side
> effect.
> 
> A particularly unhappy system can spew out around 100 million
> of those "Machine check events logged" messages every hour,
> without that rate limit. A large fleet may have several unhappy
> systems, leaving the netcons infrastructure somewhat flustered.
> 
> Reinstate the rate limit we had before.
> 

Nit: How about avoiding the 'we' and saying:

  Reinstate the two-per-minute rate limit.

> Fixes: ea324444ece9f ("x86/mce: Restore MCA polling interval halving")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Qiuxu Zhuo <qzhuo@nvidia.com>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

>  arch/x86/kernel/cpu/mce/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 50b1614968be6a..06f858faf2b1cd 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -150,8 +150,12 @@ EXPORT_PER_CPU_SYMBOL_GPL(injectm);
>  
>  void mce_log(struct mce_hw_err *err)
>  {
> +	/* Not more than two messages every minute */
> +	static DEFINE_RATELIMIT_STATE(ratelimit, 60*HZ, 2);
> +
>  	if (mce_gen_pool_add(err)) {
> -		pr_info(HW_ERR "Machine check events logged\n");
> +		if (__ratelimit(&ratelimit))
> +			pr_info(HW_ERR "Machine check events logged\n");
>  		irq_work_queue(&mce_irq_work);
>  	}
>  }
> 


