Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCB492E4C;
	Wed,  9 Sep 2026 00:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914368; cv=fail; b=cRnw/obQ2aeh5CijJHP3c6PjRYAbDJCnAxaxrJqaxhjMX3ysx5EIDDqTQC8pyU/Xpl39tu9ZoD+J0L1Gsv3XlLO3AYYSj3D0Pyeb/se3GPiXtoKbVmo0eLklpI09FXtoP81dicmatEOKjLt9H8f+1W/c8INwGyhB8mIzlF1gac4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914368; c=relaxed/simple;
	bh=PzkuEMSSVz3t3NJV+34M40RsRNKZ4zeHtrJktLlMmfs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJOkGF59vHN14c/3N0O7NKQSV0himeODRjC0Gw9YFQJnvt4nV7ITJKCjS+ttDa6q6HQPGJVzDHqpKDcH7RXmAz483CZx69I9r/wY7hLNkLYWc/HmjcTDKv+GwBaL6r0crT2hUrQfT8hsvh8yPH2ZCwm4xT1nhi3tNefMKgxUj0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDBleZ5H; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDBleZ5H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788914366; x=1820450366;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PzkuEMSSVz3t3NJV+34M40RsRNKZ4zeHtrJktLlMmfs=;
  b=JDBleZ5HKG/P+2TTbu6rLr06qE/N2BiiC1CVkY59CgN3lXYg1ksrJJ+r
   47cCirhXwU5CY6MGd18Gq7W+SQg0BFKZW8YWeQIfgVaPHAMIf+zMW+mcR
   NL3ggig7xhEuxDxRAliGW/cKRwoSRSz0uX/J+wfLWvzEEcE9QERzoAFee
   j4VpukbFm3RMTIoVVPrNmky5+unZi9G7sdHR7WZ4CbIluCT0aFSoPXOtX
   wwx4ROKPRypuQ9y7zZmwHtVb5OqBT+qsrO3aDmqIvgKmb43o4wiMGazYE
   +2c85ZFX9YQopCIqpSvXcVzPVfIIsoTcyugi26s+rU6XCwFc4njRsX+zC
   A==;
X-CSE-ConnectionGUID: 543hBViyTnGPwICDpYEkJQ==
X-CSE-MsgGUID: +nxMI+GNRpmMdY9vNj/Kvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99658954"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="99658954"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:39:25 -0700
X-CSE-ConnectionGUID: AVoS4oW9S/S30WEl8Eeikw==
X-CSE-MsgGUID: skVmw9GOQLu1xQZb7qn8Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269810210"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 17:39:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 17:39:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 17:39:25 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 17:39:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/P/0iTN6FyPtqkw2fsHZYJR0rNrJ0IS0TsUvnUdXbTjQaikqjVJRPzvlE9j9pBCoL8YW0BGgFKByOkiUTpzIexmpS3dflOdGb+ZoOn6bzNxL7BW0LSOcRggnQRofj+uoR3rDkbKB8huVu5Pnf8o/+iiSL8tJ0GDBR1TAGPSH+OaQ0wipuEokXf59SZ96NBMUBJYcvcSFx7N/AMijsRky+2yah9xBIGBF/LBOCU8rBG4dB9hr/ew7lmsbRAChyC2DgUDYpnauj7ZKxrgujzEmfm0jwD+1gztpDeotpFmIkVuE0g2AOvFHfGg7BSvF30BO8kk0nMxN2M4O0YirkcJQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eu/KMxArt0jjhlL5a5Wlk0zYTNcFxPBMQIVVYznULss=;
 b=tOYzOP91VEB0lVxHSEe5HwaGM6qgcpW9jTRYStg2xmy4evC/nPXsZotLqyvlVsVYOEWDhKASEYtel9tI/oolLF5cupoQb9NZrDWWlYl47zLHVcfexkaE1zzBpOba37TScaDrKu+TujkQZxguoP4bLFyFt+T5A3snT+UHcZkD98di/iGLVjTgQhDkTwYDJ9YuA2co4SM1NOdAOaA1QAifsK9zWD8Vw6WMt803CWyGwzgXpL9sl3px+OweEJwpZcMA3r1Tt2ia1Qw8UfAhvUkE+1vV3ne0G+1y9VW1wGipUdnzyM6N64/neuLeOkisOucEdopBclFOtnC6p3XyfsgEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7925.namprd11.prod.outlook.com (2603:10b6:8:f8::18) by
 SA2PR11MB4988.namprd11.prod.outlook.com (2603:10b6:806:f8::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Wed, 9 Sep 2026 00:39:23 +0000
Received: from DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84]) by DS0PR11MB7925.namprd11.prod.outlook.com
 ([fe80::60af:89a0:65dc:9c84%7]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 00:39:22 +0000
Message-ID: <d5ea0c8a-0518-4fc6-9d5f-9062acad45a5@intel.com>
Date: Tue, 8 Sep 2026 17:39:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: Borislav Petkov <bp@alien8.de>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <tglx@kernel.org>,
	<mingo@redhat.com>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<andrew.cooper3@citrix.com>, <arjan.van.de.ven@intel.com>,
	<sohil.mehta@intel.com>, <stable@vger.kernel.org>
References: <20260901231634.714144-2-chang.seok.bae@intel.com>
 <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260909001309.GGaqCklY8mNHjyJsH_@fat_crate.local>
Content-Language: en-US
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <20260909001309.GGaqCklY8mNHjyJsH_@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:a03:333::24) To DS0PR11MB7925.namprd11.prod.outlook.com
 (2603:10b6:8:f8::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7925:EE_|SA2PR11MB4988:EE_
X-MS-Office365-Filtering-Correlation-Id: fb864ff1-a7a6-4d81-2092-08df0e0acabc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|4143699003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4Kt2SA5JKdBnPC2b/iSoVBEvj9CRGkpn6KAxu4HV4kUBITdetTqnaDxmVn/a1NKIcxROAuS+AAT/pfVcfijD5qQFcGUjlXAoDfDNunqIyhd0ijSCYjqG3FBGWyB84S6f18SNk/R6BMX2/2iVox4NfpqMvnUTcXLCHIDLM/WPTtFcAFs0iQjkTDIq9NrrSi8b014DSnWfy9GgXPBNksQVHC32V5W3rsgp9PmxGyTYXM+qzZJllaVTyQTc0x1rfkg0shLYqWqRwvMa6dEWAlya0lPU5OQ4RMvgI8EgXdYCE4hGUCesa8twsn7lci+dAGCEqtKjxJ4DOzm87mzySglNiofJ6EUVdbhYdTH+nM9bN2OfKEBaqlC3vTFi8vFV5VAs1Tz7e8ICV5r/nUzPMmpQZM0ZlKjHglvp8dm5lRghFZu8zGrCvfLYFqoZ/u9reHwQsmeEPFwnn0Clv15vkVjdBxH0j6B4EjGSkRXtpDaIVWkFThNcDd45LizKqOmxqln92cfOrCYiTUA5lhFOMKaLTIXSL3pKW6LtfTGJDdc1myztp+yroNNEtxeiUmCbhsCHmerbPwjzovfD/Ci2c+lAiZqpAbwtuWnrv3LaGsrmA3mqL3p87LpHiKsRL42KiMhV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7925.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3BsSXN1N0NuTThnR2diYTBNVnh3dnpmeVRueGNCalVwM3VUTE1ENEUxQXZ4?=
 =?utf-8?B?VnFzNUMyOEx6U3ZsSDVpRHRxUUZ2NGtjK1VzWTZVMmRxYWQwTG5CNFdoZk1D?=
 =?utf-8?B?Z1NSSzNDelFuanFCWVh2WDVXNzduK3U2bFhPaEU3a05lMVpXNkRQOS9BUFRZ?=
 =?utf-8?B?SXF6ODVPUGNLcUZ5Zlc5dUxjQnBjcUdiVHFQYTNwdC8rTUQxcmd3QmNCZkF6?=
 =?utf-8?B?WWkrZDJNYmhTNVVOazYrazBtdVlVZUpYTlZyKy85ZWNyT3B5cHpSaE5RWUZV?=
 =?utf-8?B?Zjgxem1HTnBDZ3JBNHUrNFNIZWlpdWhrWVBxQjg1eVZQdEZaSTBLVXI4Z29x?=
 =?utf-8?B?OHZqS1R5a0FpYmRhd3JpaEdNdC9FNkxQd3FEdzlnYUZySEtDTUo0Vk42VXhV?=
 =?utf-8?B?RHRqTUhPK0RaQnNTTjUybFVwWllWMDVPa0ZvbUN3Nk5vOS9adlZIY0kzbVBs?=
 =?utf-8?B?aGQ1cnV6SFpseDByeGcyVWdFY3RHazFHTDlvb0JnWEVHRnhXQXFVSTAzeGNp?=
 =?utf-8?B?VlNQbHhOa2wzb0hvSktwNVVhQ2VsVzd0eXVMQ0pWRXVDdVIyUTZxWXlYc2xT?=
 =?utf-8?B?cDVTNlEvbVhPL2VGWEQ3cDVuSGpVaEd1ek5HS0dpa3RId2RpZ1VmRHFvdjUz?=
 =?utf-8?B?V0pxbFVQZDNBaXQwQVlxRm9tTnB1SzRPcHIyN3ovMXRMcVo3b1NFemo4TEl0?=
 =?utf-8?B?WG5qaGMxY1gzUDJDU1dBbFQ0c3U5V2UrM2tYbnJMelh5cEI5VHhhZ2p2VHlP?=
 =?utf-8?B?RFBxQ3hFelJtSjJNeENPRm13VFpKMnNaS3o3OUtpc3J5cm0yWjhZVDhSYWZ3?=
 =?utf-8?B?Z0R0aTg1SSttcDZ0T0FTMlU0VG9XcmN4MndiYTBmRHlFdXJwWVNNM09wSnJ0?=
 =?utf-8?B?TkxsQ0xsUjVUdmVIUlRxcUwrNVYyd0lDRDlTSnB6M0xqazBmQlJCNnRrMzEr?=
 =?utf-8?B?Qkx1ZkFYbmV5czMrMWwzVDBNWEZqUlVUTmFKR3ZlQktETnc2Z0pEMjY1aktm?=
 =?utf-8?B?UWlJODEwY0ZIbDdDNXYwV0UwSnNrb0E4K09BaG9saWErQTFjTTluWUg4Sm1Y?=
 =?utf-8?B?UFVORzQxaSt0UFJqbm1mUnNFWVV4YSthM2pzeFdub2w0RkZQbkZVbm5jMlFB?=
 =?utf-8?B?aFZGc2liQUQ1aWV1ZzZRYjlNM1ZPTmY0MndTUS90UUEvVDdzU0dlaXhySnZz?=
 =?utf-8?B?TjkxL2FOdG9DUG5qT2w1ZlVuTXZIbUVndlIvNFpESFhNalN5NldMOGRuOXEr?=
 =?utf-8?B?VkNJRlNRWEwwZCtKSUxxc2szcmd6TkdYVWFDbjByY2s1YnBvbEpZOFlLUjdv?=
 =?utf-8?B?L21qOTZQTWRvYnhyYjhFRzM5NDQ4dVc1NFhwWDdFcmpkQ2k4SU5xZWNjNEdG?=
 =?utf-8?B?WmNvcWh4UUFjYVVnOVg3ajVteGlLUmdVTjdodUxybUQyZzYrWGxSdThGcVVs?=
 =?utf-8?B?TGwyK1ZMZlMrMDVnNXNkZ0ZPaGZJUFBMY1ZhZjIrMldxYlcyMG1sc09qa2pt?=
 =?utf-8?B?Z0YyaGlVQXBXR0wyYjg0TG5Vd0svZm1vUHh1Skg0UVFHaC93cFlweGU2S2FB?=
 =?utf-8?B?djRCbVdrY0pJckdZWW14SDQ2UEtRZzhYMlVKZUJUMU9CYlFrZHk1ZmtuVy9v?=
 =?utf-8?B?V3dIa2x1eGJVMFZvcmFtVng1ejFtc2Vja3VyZ01oRTg1TW1WMU5zcEFJeG1H?=
 =?utf-8?B?Z1MydzRyNldjU0dVajNJOEdiTEl2VGxJN3Q0ZllyMHJzOWRzazFwZzhHVjVN?=
 =?utf-8?B?d1JIbi9kZkZ6Vnd2ekdxY3NyWjlYenVCTGtMT045NXBpUWx6bEZBdGhjdUhQ?=
 =?utf-8?B?aFlMZnJvWTQ5MVBsQkViZ3dQKzFlUkJrU3QyTS9QTkVyZXppejJhTjNYMnNh?=
 =?utf-8?B?c2NXVnZmWEdzcldVSlU5b0w4SStlQm5VM2Y1OHBGTHV1MXkzbW93R0x2c2py?=
 =?utf-8?B?Z2diTFBZSXdQQlVnZC9FZEIxOVFXam1kQ0dWeUhvR2UzVW81OThuSHhyMFc4?=
 =?utf-8?B?OHJHa1podlNWYXg5NVZaVGVYbnM2OU94dGplc3JEZlJJb2FuRHkvcnE5L1Vu?=
 =?utf-8?B?c3BMZHZjVEh5TjFWNERZSWRwL0VkdXhUbm9DNDFIQld4am5CY2VGMFVMaWQx?=
 =?utf-8?B?VVZIS3JZRzE3NTVYWURvL0U4MHA0RGVsZkdUWm9TMUhtL1liWVJDNVBaajN4?=
 =?utf-8?B?bzgzci96MUFRNXFjTVVhRWp3aHkxN2dPMzcxRHY2b0ZjTVBVQUFVYTFOMUU2?=
 =?utf-8?B?SU1EWm9VS3ptaGdrbVFEV05yb2FJbDhlUi9XWG5sd0UzVjFNZE13TXpqMXc0?=
 =?utf-8?B?SGVuSmpKS1VRRWVYNHZhWnc5YXEwVWJxd2p5MzZJelNPWGliZDBZdz09?=
X-Exchange-RoutingPolicyChecked: LRvxFCDFNoMC/bJ6OD9GVzNPVg2W0YFF5EjU7OxWqkKgAkUNt1yY1Q9NLD5xK5l6881YnUFNRUKVQP8O0FKAm8g6D/jzPeEaoznJqPIpI27HNFXAkXxnLtLmPf66lY5mLdg46i2UjpbVXlsnHtp6Jzn0v35NR2DSjTbzsea7skltgaDSbEUX5kRzbNPm6ArUVRXvAhRqE9iyOhv1eQqI1PJRdyJFpOdnvy9Zdv4mp5GShCk5KlcXeh2OaXVbZPjazlO8JUwHbLC+SE9wqa7DswXjG5s58ZIkzYrhvm7cuYnHaPpcl4DWVOkpugenPdOPkrUPAzqJP3KOfbvpWO7/LQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: fb864ff1-a7a6-4d81-2092-08df0e0acabc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7925.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 00:39:22.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9wvB1ETyhyzKQOtXdU3FIVknsv/USypxL1DIN9UR/sWG3DLRLgdAA4RycVQ3nK1QRZHvqNtbti10E9cJlQ30jmj2MZqvcnm2mcFVIhGpLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4988
X-OriginatorOrg: intel.com

On 9/8/2026 5:13 PM, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 10:32:09PM +0000, Chang S. Bae wrote:
>> Microcode updates can usually jump revisions. However, there is an
>> erratum on Granite Rapids systems. If they "jump over" to revision
>> 0x1000405 or later, they result in #MC.
>>
>> Prevent loading 0x1000405 or later unless the running revision is already
>> at least 0x1000405. Apply this blocking to both early- and late-loading
>> paths.
> 
> People have got to stop explaining the patch in the commit message. That
> should be obvious from the diff. If you have to explain it then there is
> something very non-obvious here which I don't see it...

... If they "jump over" to revision 0x1000405 or later, they result in 
#MC. Avoid it.

>>   
>> +static bool revision_banned(struct cpu_signature *sig, u32 rev)
> 
> I like Andy's naming:
> 
> https://lore.kernel.org/xen-devel/20260908171525.3196765-1-andrew.cooper3@citrix.com/T/#u
> 
> ...is_safe is much better than banned.

s/revision_banned/revision_is_safe/ in V3.

> 
>> +{
>> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
>> +
>> +	/*
>> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
>> +	 * microcode updates on Granite Rapids systems. Updates directly from
>> +	 * an older revision to this or a newer one can result in #MC. This is
>> +	 * documented item GNR98, #835486 (Intel Xeon 6900/6700/6500-Series
>> +	 * Processors with P-Cores).
>> +	 */
> 
> What dhansen said - keep this short'n'sweet.

Will replace the above with Dave's.

> 
>> +	if (vfm == INTEL_GRANITERAPIDS_X &&
>> +	    x86_stepping(sig->sig) == 1 &&
>> +	    sig->pf & 0x95 &&
>> +	    sig->rev < 0x1000405 &&
>> +	    rev >= 0x1000405) {
>> +		if (rev == 0x1000405)
> 
> I also like Andy's testing of the patch revs:
> 
> +         ((cpu_sig->rev < 0x01000380 && mc->rev >= 0x01000405) ||
> +          (cpu_sig->rev < 0x01000405 && mc->rev >  0x01000405)) )

Let me double-check this with ucode folks, first. Then will take.

> 
>> +			pr_err_once("Erratum GNR98: revision 0x1000405 is not loadable.\n");
>> +		else
>> +			pr_err_once("Erratum GNR98: revision 0x1000405 is required before 0x%x.\n", rev);
 > > And you don't need those semi-identical strings here.

pr_err_once("Erratum GNR98: skipping revision 0x%x.\n", rev);

Yeah, overall I can hear "keep it simple & short" messages.

Thanks,
Chang
