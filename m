Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312CC4DA9A0;
	Thu, 17 Sep 2026 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671183; cv=fail; b=hR2rT56cNmTUfa6E6VG1qBngrjh0sntEKx+EPiFJjWp41iLnuAf4MBMZBjZU/gDcUzJDUEY9F4b4ls/WNb/LsA9alX6R/I+1q2Z3yvnV1o3XzQeNLw2izJrjTh4NMOIHLE7j598Lzhg0TQvqg88lFhYCl1GN5Ng6pD6g2ozCaTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671183; c=relaxed/simple;
	bh=gKHLFK0Huwd9mKFgtrHhxSV+itELw57e4z5VDA3Woi4=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G8G+HlgNuHDXqzGA/F4XqAWaEpLQtyh2NdkQmeiSAqeBsyYXXCoFkd+2vjfsUwx2DksQ6Ee2KZAApaQgVXdiuz8iUhdbkUEs1setJpFWSZOI2qKFAZj3n/eYYr0EgcUSPSiP9Arwgg5Og703XyDwoo/avBr4T+mCn5WjDz5N90U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OTJ4EdIY; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OTJ4EdIY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789671182; x=1821207182;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gKHLFK0Huwd9mKFgtrHhxSV+itELw57e4z5VDA3Woi4=;
  b=OTJ4EdIYmUBED+P6EGgWLhDAA+ITvmI8dwWxz+MMpfl/3piuAPzI9RrZ
   uGVmHV8pLnob6V5xgfKZuuQCU4c+wITERFQuJhF/GZSzE94tGEhHIn654
   ucwipKFrsmr9F4//++vaPP7KeB0jHjkDpoup/AfyJzN9t1gxR1X9y7ONR
   WO6dYxVkTdpMjUmVcfmejCxOKWMeHGlejGMk8+8cOBPwDwsqwgAMeuD+1
   NdtCzEjSgsgEgSvhdY+VHDmdtGsXci7VWhVE+Eu0KlP7pjR++HZIlVrvF
   4vzjPBvue7jwawBq86nQ+v+8hEOrOKxz+uDwC0M0xdk2xncUbE7GI0jcV
   g==;
X-CSE-ConnectionGUID: VTaD+VefTm+Cm8jcuep59A==
X-CSE-MsgGUID: 7a8J+my1Rb+6IblPxTTB/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89063321"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89063321"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:52:49 -0700
X-CSE-ConnectionGUID: YXpm/JoCR2GeTMTQKrqXyg==
X-CSE-MsgGUID: 5TDHgytXQ46BhJpWqLz8hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2162803"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 11:52:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:52:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 11:52:47 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.59) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 11:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nw76UUL0lnVSKccEL8cM46uVmFditHkzCs8e1LG+d0bNCCAb1lHKL2xEmh/eFVoUafrrhmWOry/KZmmg03X7tb4EyogCkzpbO6MNsD+u4EvtcCnKV8DuCmZHOMEGEjrfoPLlxtzhZ13+ufmo9/mev+vxdcgT7jFw73nlqHVAPNw4q49lZS5Vfk2gMce76UT/OIHoD67Osg55mS2GGC4/pOw78Kh7BQOzWFivN0ZsJFWGAgtduFWzLgppT47HhC+V7DVzZzmuXwcbjJzvDvJgqhA0cf0tuI5zM1yS0vWzNXu92ELUgM9SVbAtXvTsrFkLhs4QtXpGuH2LcBUAI8tbUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxpUnFLdm9nrfAyPCfOdyV0eeXVo8fNMB/zO8I+GVT0=;
 b=rn2450V3NJ3mgRO2rA7XONzMP4/2m57toNf6Rq7UPSpwJ8S2A+MuFUl/M6FeQsGjpgHzteZcK3mGi8C4cvw079O8hNMGz+kwnL1u9+nX2htRLPaQQdOIi3O2MjAVKJw0/n1BLBzDvL4PI0gj4ReqiIOdlyAnUkYHj3v9ONF3U0j5ymH3syPnXtKquw0Bf4hC0W5NMkM+E7HNBay+u1JRtH+JakuWCG1wWmWKdTzNrI3wRY1d63KFM/GOxrPP0MtGbOpzhYn9P0ntho+IQwct6PSnspHe2C5n7jl6mStjIuvXoUjka86sYh6+iaisFerrjxnCrBWvHXdAFzzIMbs1JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 DS0PR11MB7216.namprd11.prod.outlook.com (2603:10b6:8:11c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Thu, 17 Sep 2026 18:52:39 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0428.008; Thu, 17 Sep 2026
 18:52:39 +0000
Message-ID: <0604bfab-3783-4fc0-a276-a632dd7526ae@intel.com>
Date: Thu, 17 Sep 2026 18:25:54 +0000
User-Agent: Mozilla Thunderbird
From: "Chang S. Bae" <chang.seok.bae@intel.com>
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>, "Mehta, Sohil"
	<sohil.mehta@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "tglx@kernel.org" <tglx@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
 <51f6a0e2-25bb-4ac3-9b3e-2883ef7e57e3@intel.com>
 <66a43c1b-656d-4dec-95b1-3f56c9f9057e@intel.com>
 <LV1PR11MB8850F9AE30CE6C60F372262F92B82@LV1PR11MB8850.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <LV1PR11MB8850F9AE30CE6C60F372262F92B82@LV1PR11MB8850.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::12) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|DS0PR11MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: d1abab48-0228-4fb7-0e5e-08df14ecd880
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|18002099003|22082099003|10067099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: fF3jyNkHYloSaYEY7oZkuLFZSdVywZ019yF4m1VOpZVsYzJvurjnGVgi0uMy5p4Ny17eBXSCEbo1rPfDNf3LUhbGXcS0X4Djm3n7INzJNiON+v59nx/3EbqH8ScQYyogn5z/9ioG1RldJY4gSBKdLNKZzNC3NGVsxB5Mb3n5uBE4k3NX0Xwwk4VGxfHgOt2TBWDjoAowxOZ0AG6ZnS9VW5Ng0wgW7JMPGDcwhe8pij3uKahQ2R1tJnqFxe5MlWY9Jgr0XnQDdJPLDUy++VJutUD0Sv9ckcIoNsiak21cJwqXWlDAMajQspMaLRrKafFrZfHyDTJJyiS2s05tY80w+hB6e7nDhshm3KX51mOiZ8KCm1mOhzkcs0OkUgSAuMxImox4+qZTiNmN+csYOxDmzSfRPa8z/J016DUssGkWFxgLdYOvYcZ9RmxXsZ0iP9pr27/PuZACDFrgvVsHV8CQffcqlf0I9euHkAuOeMPqcESIcDsd7UvT6qR4rAINjyAamy7UHKnHKFzA/YMZmz12ibSmweMLWz8gVY8dNqUf1G+cOVHWg2JGqKAfNeGNiWPG1K1z7lalTJeYj7zvQ9eODng7PqECZJvsDw1zgUAa6a2DFormX/Dd4Ig0e89lksvu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1EVGptWW1NQnVDUTYrNTdRc3ltbUc5SXVWZ0VzZE8xbmF1ZCtSeUJyLytO?=
 =?utf-8?B?Y0dpaTBwcGhsNFJLeSszTjhycW1RVTA4ZFVaUVpVNkc1YmFTRFpSN0RIUjdB?=
 =?utf-8?B?TzNhZDVTLzluUjFTaVNoSGIvd1NYRHg1d0NqaEpxVEJjVFc1RDh6OHFJUEV4?=
 =?utf-8?B?R1IxcVZnVVozQlJ3V3NYNzVrQXpSWjYvTTJHWnZUN1NYVys5RmtEQmQ4QTFI?=
 =?utf-8?B?TjZoWnljQUt3bXV3RDl0bGROYVVML2tPK2RESnh0MmtTSWlZVllWS1VuVFpQ?=
 =?utf-8?B?NmFJV3B1ZUYyeG9MNEI3MGlsemw2bEdkK2hkODNHS1NnKy8wREJYSDdtZXZz?=
 =?utf-8?B?Q2p5eVdEWWxxamgwbUE0ZkRVejlwLzV5TE9rVmNrZ1lINkRsUlpEenp0S3pG?=
 =?utf-8?B?bEVqVURnVk80L0F6blFDeTN0MHdCb3psL0NXdjhoQUlwbStXVTdid1RuSTRs?=
 =?utf-8?B?cWI3MFgyWjdoM0ZjWW5tNTFrUWdlK3NlcUg0SjNlaktPejdjUXVKa2dNeFJp?=
 =?utf-8?B?KytoRWJOd2xIRE05QmFlK1dIYjJoWG9BMTIyYVBncnNxVDhGMkMrRnJVbTRI?=
 =?utf-8?B?ZStvVzJiMXdoTlBabmdmZTZ0UmVCQzlNMi9tdWV1QS9pMXRCYWJDVWRvV0M4?=
 =?utf-8?B?akxUU1pOQk94NWlmQWh6cmRsOXpITU1OUVFiTy9JZy9RVGRoL0VZayt5WEt0?=
 =?utf-8?B?WHhoVHRzSm9HbjlGdVRhU3VlMk5DUTJDNE0vcmk2NGJwaE9nWWlueUZQaHl3?=
 =?utf-8?B?M3RzS1JsalZLd3cyM25KTGMzb3p4dGw4RFdpV1VZLzB4eVF2UDNuaEt3bHlK?=
 =?utf-8?B?cmt4Lzh0NnRVZ0VlbUo0YWltQ0d3S3dKZVh4bWI1bmhScStjZk1YdFBLVDhx?=
 =?utf-8?B?S1ZocXlVQnhlKzRqVWpzaWJBTHdWaHFVeVU5L3dNV1hWYlJmUzNzaWcxRFZM?=
 =?utf-8?B?VlJxTVo5ZXFjcE9Zc2k4NEs2a05mdkVycmVET0MwMlhvTjFnd3RzRUFpRFly?=
 =?utf-8?B?QWRKTWZDVFcyUGZpYXdpbVJkTzlJakUvN1pMZitmRTE4SUVyRWVVckkwTWhF?=
 =?utf-8?B?cWxBdkw1SHExYXRYbUl2dGVQM3VaZXRBRUlxQWx0UGduZVpkMTJlNGtRMVFH?=
 =?utf-8?B?aW9BL1dSUHVkamIzMksrMDlvRW81NTVxZ2VoVW5Ucy9RRWF2aFQveS82d1hl?=
 =?utf-8?B?VmdlM2pZajk2Z1V5eWxHK0NNd3I3N2FOQnMzTEZWYnVTY1ZidUlLOVdVMjJw?=
 =?utf-8?B?MkVyL1VwMCtwSFB0L3ZXbUtKbWJPMTVDSlp6WWpncDNpem10dG1xOHh6RVlZ?=
 =?utf-8?B?TFRadUo3dWo0SlFrZXdIV0x4RjF3ZU9vTDliRnovZW1XS0ZRSnBET1dWU1c3?=
 =?utf-8?B?ME1HTElhdWJOdlFKVmpQb3JpZ2RmWFNjdktIZ1hBSmdRS2N0ak9kWmRJaGVS?=
 =?utf-8?B?di9TaThUMjg3Sm16aDhmL0dBYzJUaXZZanlvWENoNmJLZTRnM2wwVGR5Wld2?=
 =?utf-8?B?bUp5VHh2RGN5THhrK2dCMWR5YWZFRnZvMWNDNW9oSnYvR2grVzhtS0owZk9R?=
 =?utf-8?B?aUlsYzdpTkJyeUh4SUZ0Vmh0UGFQNENha2ZvUVZ4bVp0SHJTWUFaSkJDbU9x?=
 =?utf-8?B?V2oxRU9yT2IyeUtNajdmcEdEQ2xkRXlkMFZBOEd0anRSSERqT2ltTW9ETFlP?=
 =?utf-8?B?U3pjQ3NrMjQ0ekV2eXZneTF5M1lEcmJZNXEvQlhON3N1djFaWEMyVzROd0cx?=
 =?utf-8?B?akVvZHZ1Y2R6bWd1dXRISFVSTjdQSTltdG5HVHJYRW02WGpOaXF3Y24wRGM1?=
 =?utf-8?B?ZXNUQzBwMDBHdFJTZS9QMUhDaHZMd29ubHhCTlpHNkcvV0hySTNCc0RWa25m?=
 =?utf-8?B?OStIRVlwaVI5U1c2RDhCUkxrWGhzQmRIUlk2ZjkzcktFWURzQi9RMUt2MjZv?=
 =?utf-8?B?R29LbXpNczdINUtMYlRKc1d5bG54R01JdEQrYlBxUVk3SFFjWUNNLzJnS2hC?=
 =?utf-8?B?cFlKdHZQamVsd1lCYlF3NXp4OVZ6MHd3R0Q5RUlORTFqa09OTlZFQlRJTE1S?=
 =?utf-8?B?V2JiakVrRWlZM1dzOEp6VmZkTGJWTHVMRFFiNHl3WTFWOFZTTThkdzVxaHlX?=
 =?utf-8?B?UWNNbjBvdHBLV2RpTHNKR2xHUGpnTkJvR1pjYUt0SmY0SisyRWIzdTk3Umg0?=
 =?utf-8?B?dWVHTjhoajlxdVFaRjAveEFwM25qNnBwNmh4S0dPUi83ZUt2SmxwYmgydnBR?=
 =?utf-8?B?Um42Y3REKzV2d3BmR29rMVVGeEhCNFIvajZ5Wk9ucnQzUE45SXVlV0hzM2M0?=
 =?utf-8?B?R2h2MnRhdTZWc0x6K2pTQ09FU2sxOWlNZHJLMG9yZmRBc01IVXZMUT09?=
X-Exchange-RoutingPolicyChecked: YZ6pWo/emxjWszxvuctxL3VgF8XQs00LivWk94FAL5MoLEzIcDV98ESv+nq0cDnK4yXQ34klPSZ0WHj3SISO3F8DHYO4R31gVS7hqS1iooXnGZIos+VnBFVBlmAQB27OWOvsR9cG4PVvOAXGAJPPzMsOG5fpBp3s7Gy1WiAkHvhL0MEA/3tCU2LE4P168QcXF2jPvlEhLNxPZNbMUWVjX92YihE2AIU2H/pxiPxvoKA9IgpjVw3OpyWvEsYrooDx5bZ0j+6C1/BW8rdOnjQN2f3H0jKYNCqad/YvLjstNOsUVzC2fystZi/nT6+pXNMi+DuqxtOIRqBcs4+T4DcsnQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d1abab48-0228-4fb7-0e5e-08df14ecd880
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 18:52:38.9646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bnsX2QhBFMV7Z/At5XxslchSQ8czSoT6Hd//OhPZh7ghxWXan2rFd/FW2Qp+9luDNFm5EbXfPQbOYvBPgSqCZL9/CDAGqgJEvcL56UDtjCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7216
X-OriginatorOrg: intel.com

On 9/17/2026 11:43 AM, Van De Ven, Arjan wrote:
> 
> But we could, on the actual application, at least check if the ucode 
 > already got upgraded to EXACTLY the target version, and skip the
 > actual application if it has been upgraded. That is a simple check
 > with basically no policy ("identity") but with huge savings

Yes, I think that' what we do now:

__apply_microcode(..., struct microcode_intel *mc, ...)
{
	u32 rev;

	if (!mc)
		return UCODE_NFOUND;

	*cur_rev = intel_get_microcode_revision();
                    ^ read MSR0x8b (aka MSR_IA32_UCODE_REV)
	if (*cur_rev >= mc->hdr.rev) {
		uci->cpu_sig.rev = *cur_rev;
		return UCODE_OK;
		^ we skip the loading if updated
	}

	/* write microcode via MSR 0x79 */
	native_wrmsrq(MSR_IA32_UCODE_WRITE, (unsigned long)mc->bits);
	...
}

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/cpu/microcode/intel.c#n646

Thanks,
Chang
