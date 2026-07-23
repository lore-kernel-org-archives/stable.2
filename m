Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AEE345EA5;
	Thu, 23 Jul 2026 06:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788371; cv=fail; b=URdBWpkfKml3YjUZFowrF0BG//OXFzMRJoOcrF6HFMK6C6GbiISWiUFoSTxaOXHTrbIRkz98XmrfprcrzcH8kjlNuk+2ro5m2jpMvnBTu3dJOEncRONRGNJH3p5XSjAinFLvvmh6Y2hY2j+adBWT1gYcEVzn7hcmK7WesX8F4pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788371; c=relaxed/simple;
	bh=rhRfyiAm8q2cgyYNjTI8QiVShBIARbUAubBU03TuWm0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FMg/vcQgo38V0pKtvqREylMeDPPe2QtUsob9Lcxlzb0/2feYdBG69ZWNtmxGaMdjqZWi5aU8VqgQUsl6xf4kYX7obfL8yfw5D6iDFloWI3RN4ogYYM+ZzbymxqRuFguG4ZcuziBfnipHRCm9fB+oM//G+HolwbryXAYeDQ/3Zm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DWq8lPuD; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DWq8lPuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784788370; x=1816324370;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rhRfyiAm8q2cgyYNjTI8QiVShBIARbUAubBU03TuWm0=;
  b=DWq8lPuDPMVnLvB0iDeHHBKojilaL2UOMYc0LgwDowNVWXXgGPKqPhRf
   nlWMJnHaROVRsmatDcQyeXberHy1cvrm7vNajgTJ8/EBNUoyzoZvR9EpT
   JqyOAGeLNHOJF2x3yGdVaAvtsACrXUxGLmpAXu2w5L2un+Cv3aLeDoi2s
   GZcN3ArSJtHeNwuCJFb+YZaTX0NLkdWZtAJ82Ypck46kMRSclkIXQ8Uww
   owBCev+osEgoR7ufAaRm1C+R0Qc8LLm84/Z2oc0RMd1Y2aMMlo3n46GV9
   BKUXxiytF2eIPvNtIm6lZxZg3HKy7h0+hg9gyYNNSCzcjum5RB+Y27QgE
   g==;
X-CSE-ConnectionGUID: 4SymXrorQAOPzO8nGiZMEA==
X-CSE-MsgGUID: 8nR1ZlawQmKfJR9nbVa4Dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96806141"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="96806141"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:32:48 -0700
X-CSE-ConnectionGUID: FmWhOgY2TBKzxi5ZUxghJg==
X-CSE-MsgGUID: frpednw4R5iMBj1aCrs67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="254383299"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 23:32:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 23:31:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 23:31:37 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.12)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 23:30:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIRHJXwvhYLYJSNzdAGR/M81WvY91g+jrDaOyyExFN96FJlXtRgx6UKLtj25EyWw4rx75BxeXcdu2wd/sz9Dcp7sNr3OZSP7aY7g7GWv0+t2dKnlR0TgAvhdnLs/TyRvTkibvI1c+cxUeZiRaW+UHGbQirrpHejOeujlp1ByqWUyMgtOKUnc9lVPoiCVryOaN+urzQRncRpUNHbfhREmTnkxIc72P+9YXBugBsFx8UgkuKysf5zA2yLl0xd2aPHq8uj5W3VeTY36jZtoe+D/nI+aKkW/gw7mjv5twrq6ho1Mi7cNLwH8KDd7L5art58CVYJMSczLFHSc1cdYCGWeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMgJTnpmW/wyGYoBefUw5nTaoyE3tD3ieELr6nMHW40=;
 b=qmVC4rb3mWfMpk5PIKNriVrGcFENYKzgdfaF9H4U75UN3HQiZNQYxLDINMsFhg6yxaqi3iI7Kaoab5akNClw5D6RPl6KSLeArXAw85o5lJy9dwDUPR4bV/pFEuPY3b/ybpXw/41RFmN6hXgTa/Nv2u405EXnEbu8iiH3rfXf7IjJ5Maom3TRT6QWaUtngkQZMqHxoVVnSJweg+328Tk2nFXXWUxzGNj9/37x7fMYNhhhA17NP8Jm+HEOizQfoc0J5lMdyfeFHfDMxHQ0dZ0nlwxlaNVOIvG12hj87HJ+LdiBNY4vOP4V2Cn2QFDNn5T5uxCqI/HjJPBt5wyU3UA3fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7631.namprd11.prod.outlook.com (2603:10b6:8:14e::14)
 by DS7PR11MB7929.namprd11.prod.outlook.com (2603:10b6:8:e5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 06:30:57 +0000
Received: from DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825]) by DS0PR11MB7631.namprd11.prod.outlook.com
 ([fe80::cdd2:4a9a:9dca:5825%5]) with mapi id 15.21.0245.010; Thu, 23 Jul 2026
 06:30:57 +0000
Message-ID: <80993b70-352f-4069-84c7-39a04c061e98@intel.com>
Date: Thu, 23 Jul 2026 12:00:42 +0530
User-Agent: Mozilla Thunderbird
Subject: [REGRESSION]: [PATCH mm-hotfixes v5 3/5] x86/mm/pat: acquire init_mm
 read lock on attribute change to avoid UAF
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, "Liam R.
 Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, "Mike
 Rapoport" <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki
	<urezki@gmail.com>, Toshi Kani <toshi.kani@hpe.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain
	<dev.jain@arm.com>, Ryan Roberts <ryan.roberts@arm.com>
CC: David Carlier <devnexen@gmail.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, "Denis V. Lunev" <den@virtuozzo.com>,
	<stable@vger.kernel.org>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
References: <20260717-series-vmap-race-fix-v5-0-606a0ac6d3e5@kernel.org>
 <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20260717-series-vmap-race-fix-v5-3-606a0ac6d3e5@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To DS0PR11MB7631.namprd11.prod.outlook.com
 (2603:10b6:8:14e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7631:EE_|DS7PR11MB7929:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fbaf93-9051-4ef7-0197-08dee883f40d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|4143699003|13003099007|921020|12006099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ow/GuNEnkgnvrrz1wkk3wmkzGZCC5lWSS0JgaEKHdURa+ZBnP0vmlapJepSHf6wzMdhDeIMo83g2IzKlsoUI9X6C0Qv6irQl5r6A3lQEovYMsW+O68qvdoStkidQ2oVtvHSlXZAQw88/lWxZhHhUv7fV+rU3wlWn8RO8bEYhzX0E/qj8BwbBcwTuuo8uZ+CMPHuOZTNo7qB5ROaU2FiXNR6WabyC8iyoGlczLSdtqhaB0b+/0qeHVMJWJSU+E3jcIuL49S47pA9PXFk2HPCKoW+fw8LWwokPuoaOlKQlmFbO96InYdVvgY2QcoIUf1q3b8VsMQ5V1O5j+VUeIEVxTodv6wkcKLoWQ8G0hDIPOUE9WZ/4wZ4P/yOsGxKIx5HFD7gJ9u4ru2LoykZBc7MtIWOQa+jewyrloLOfYu5qi0pXVT8R8/kFCIixOz1n1cYe05KLowBp3bk8lrKUKiwAXftYDt4xgO/idHP70kYLje3zg6+cBHyHinskPocFGtFS720RMwZ8df/UoXAB8Wdl6hgugZgMnJvj2d5lw6U6tgRSkL5E4l/QGYhtJVtJcZpecpDNfIyYCsfXrUmZ4wF01hs6yzRUVtp/jJfs184BrMSkM4KbzmBR601sEEadsSIF5Loq/7oFybmPx/GgkVDE7CXWfgvPWSYwYyMYIZ7Z3GM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7631.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(4143699003)(13003099007)(921020)(12006099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNBbjEwN05zOEdkMW1kZnVFak83SmNaM0hXY2Rtdk00Z2tEZUtmZkVUZVhq?=
 =?utf-8?B?TFNqam5lOEN2RXBPNC9EWTdERVpGcDdzZndpbm4xR1hibUZVZzZMbVRLRVlG?=
 =?utf-8?B?SktOYnhUR3I2Q2ZxOWFRTlVEUUFhdEgrN0hSWlZCRk1JazhHWGJwNlFDWHhN?=
 =?utf-8?B?amNVNVlZczI4aXpEY2VqN1dpMFYxR1FDWGZ1TnR4WXQ3Q0dmQXdPQTZRb0pY?=
 =?utf-8?B?NEkxNWt3Sk0xb3VDemYxa3ZMZVUzV3llc3BBSFdSY1A0N1NFdDQ5NUNXNzBz?=
 =?utf-8?B?TGFvQkwzdE00cjNvU1UzcEJwTzFlUDBpcjdtcWxwUlZEZEpnUjlDK1RRNUhQ?=
 =?utf-8?B?eWFMSFRvOWdEUFVPN3J0VEZMUHNWV1NjdnJQT2s2dHdRZ3JiM0s2Q0NKeHhM?=
 =?utf-8?B?SkxZVm9RNDJWWDY4ZzlxQW1tRTFSSk9pQnRsYlZlQjVJMGYwLzJCRFhjLzFJ?=
 =?utf-8?B?bTlaem83dStkNnV0YUpZNnlJQkRNMVEyK0kzdUVNMGphYm4rMTNIS01xbnpx?=
 =?utf-8?B?NnRPSVduKzhJOGdjVFdUa2VmbGpuUmN0QXB0UEFqUnI0NVVBKzErcjNVSGRV?=
 =?utf-8?B?L1cvOTN1bnZjWmhkTGFnMkVsaHc2N1JMWlZSYzlCYlgwazRSWmNTc2FRWXpx?=
 =?utf-8?B?L3Y2V1FrZ3BzQzBnRDBtOFc0YUxMTEd0cnhiMzRCeDVjbXc3RWM2TUQ0RXNu?=
 =?utf-8?B?OU1EMWFHaUcyNEpSVTJrbk5jNDdwRTlORWdrSlZHWS8rOUpMODNpeXA0ZFRG?=
 =?utf-8?B?U3MycXBLbVFObVlSbldjVlVnZUpTWjBkallrbWRRWk1NZ0ZpTlRBQitrSGVy?=
 =?utf-8?B?Y3JiOFVRZTEzWnB2Z0FkLzJIUit6R1pBenNSeGxtUHdJdTlyTDFjRjgyTTJz?=
 =?utf-8?B?WUlhQWxteEVyU3RRVFU4dUlhQ3p2V3p5OXlGaTJpOGtMM2NELytCb2MwWE9T?=
 =?utf-8?B?VXZhc3gyT2pOWFk0elJtMWtmMGJoYWZRMWZ5QTQ3Nm5jaWhwSVZYaGlXU25H?=
 =?utf-8?B?YlY0bGptRmNYNTFFdDUwTXgvUHRiMXB5UThPQ0gzZmhBNERRQlN3djJ2WXBu?=
 =?utf-8?B?QmtLS3pxQWo0WGFPTjFmTVNlNWZjM2QxY1lPN0hZa2x0eERaRTJML1lVTUVF?=
 =?utf-8?B?M09SSzZQOU1mVGI5TE5VODA0RDhLNEd0NC9RYlJxNWhvcEtLMW1xSTZTVjc4?=
 =?utf-8?B?aUhtRCsrRzdqcjlUSnU0TWJFYm5DRmFsMUtIV2RCdU5nZklDcXZONk90cThQ?=
 =?utf-8?B?S2FtaExDNmJGQ1ZlTFhEVkxMWEd3em9SaEZBZ1NsUjkxckJFeEEzYml5SmxO?=
 =?utf-8?B?NWJlMmdXR0swT3FsRVVnVWpiQVJWbFFiT0tJRkVodWw5L1h2Z2crVlNnOUMz?=
 =?utf-8?B?SDROdC9qazQ2RythQzhJODlBYzhKcVJDZGwvN1AwcFBpWDU2dVZpTjU5dUhX?=
 =?utf-8?B?SlgyL2kvY0pVV1YzZGJ1d2ZqbEZPTXUvclE3NjBpWXI1SFVzd1JrSDlXSnBi?=
 =?utf-8?B?TjBtdkFFSytoM1JuOUhsRGlNNDhTZllDUldFcHZ5UlJBRHN0aDhYMFRib1dn?=
 =?utf-8?B?bDl0TWhYZks4VUdKR3VmMzh0Z0NFK3NYRlZMcWNFQXpRaWNlMGZiZkwzNkpx?=
 =?utf-8?B?WE14Y3lJWlR6ZStUcGVBMWtzRUJqMjlBR0hwNHBpdGJ1SHU5UU8rVjd3TE9i?=
 =?utf-8?B?U3YrSmZrZ1ZoSlkyV1RqbVBXNElFUDRES3JCMVlDUlZwR0xweHNZL3pOMnBW?=
 =?utf-8?B?Ym5leVNsKzUwYVQxYitVSGhtUVhkb3lCNlBNUkRieHgwUWVmQy9heEtWU1lF?=
 =?utf-8?B?aEhQUTFOWk9acCtMWnQ3Z05VUC82a2l0S0RHQVZPbkxvZVpqaHdOS1dNUjUv?=
 =?utf-8?B?aS9VMlJFUmlOeGlEL2toeXByMUkyZVdsYmhRVG40allBV3UyL3pMNlQ1MWVW?=
 =?utf-8?B?VjFMNkJMMGV0RmZVWlRjVVlOY3cvcVlIYVo3cU1oN2ZoNUFodDcxRXppYXlX?=
 =?utf-8?B?Wm1ZUlpsdC8vdUE3ZVQ5cmxsYUJSZUFKbVVSSTFZZkpsNjJ4ejRqS1BaSDZl?=
 =?utf-8?B?WVNkSVNkTjZxZ05idlExZ0FTMVl3LzBjS0RFSkhjRFZmcVluWjlMSnR3ZVRp?=
 =?utf-8?B?UnlnUWJQZThQak9mYk5XbXM1WkdBa1BqbFRYUUtGUFdORDFFRjFmRWM0ZXJo?=
 =?utf-8?B?ZWM3b1FkZTlXY3NRQktmR2FtalUyQUI1M3RnS01IMDZmZmsyVEc0K2YzV0Ry?=
 =?utf-8?B?Q0ZWVGRjMHFhU2hwVC9ocG1sZEdOZG5JaWJFSWZqV3BNUStVTXRuL1JNSXpi?=
 =?utf-8?B?TzJyWVh1NVZ6M0NjOFZHTzBtcDV1TmNIbnFuekxDaXNoOCtRYmdFRmVEWnNv?=
 =?utf-8?Q?PHITbtNqw1qF+tVA=3D?=
X-Exchange-RoutingPolicyChecked: IO0PGJqz0ySIMrYsEj84JrsQKt+ieB9RZ7GM/QQSjWYwqnQLlmad1aAlTzEsgzgMaWR/cXpPHxVSJQ7d5UGiVAuJFhWf+nkMReXzE22sTEoz6xzPD2Zyq/I+9vluM9E0M1HX5uGcn5N8u2sXmGbgj0f3pB8cOMcRuQnaCo64P7D4jmZxWgk55TIuhz6sxAnh7pDF/sZvO2KN2CNaOI1fXViODEn2Orx974xEaxEmYw20kmBadGQFXrrm8H17OLhTktEw0MAaDNIlt+x9oD3uwW6uOqiIvDRFjV95dwqhgco/BmYgkW38VsT4gZmncQG25fLY8qcf+wBJ/45OF/e8ig==
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fbaf93-9051-4ef7-0197-08dee883f40d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7631.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 06:30:56.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxGEFSRvkcMEJmlUmtutbg8we1exxViVTM04LideO63OdaSDfZss1R66I1V9bWAtFu1EPbT9SoK4+2OBS+Ve1AQjaJSDRC9kqIv0ik5mNg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7929
X-OriginatorOrg: intel.com

Hello Lorenzo,

On 7/17/2026 11:00 PM, Lorenzo Stoakes (ARM) wrote:
> A previous commit protected us against races between ptdump and CPA
> collapse, however one still exists between attribute changes and collapse
> as reported by Denis V. Lunev (linked).
> 
> When an attribute change arises, a lockless page table walker obtains a PTE
> entry, which is later written to via set_pte_atomic():
> 
> ...
> -> change_page_attr_set_clr()
> -> __change_page_attr_set_clr()
> -> __change_page_attr()
> 	-> _lookup_address_cpa()
> 	-> lookup_address_in_pgd_attr()
> 	-> [ lockless page table walker ]
> -> set_pte_atomic()
> 
> There is nothing preventing a concurrent CPA collapse which can free the
> PTE that was retrieved here, resulting in a use-after-free.
> 
> With the mmap write lock taken on init_mm over CPA collapse, we can now
> resolve this race by acquiring an mmap read lock on init_mm over
> __change_page_attr_set_clr().
> 
> This locks across the whole operation over which the walk and the PTE entry
> write occurs, solving the race.
> 
> It is safe to do this here, as no spinlocks are held upon entry to
> __change_page_attr_set_clr().
> 
> The CPA_COLLAPSE flag is only set by set_memory_rox(), which exclusively
> operates upon vmalloc ranges, and on x86 only within the module mapping
> space.
> 
> This is important, because some callers directly invoke
> __change_page_attr_set_clr(), bypassing this lock. However, none of these
> operate within the module mapping space.
> 
> * cpa_process_alias() - a recursive helper called by
>    __change_page_attr_set_clr().
> * __set_memory_enc_pgtable() - operates on the direct mapping and (via
>    __vmbus_establish_gpadl()) the vmalloc mapping space.
> * __set_pages_[n]p() - called by set_direct_map_[invalid, default,
>    valid]_noflush(), __kernel_map_pages() - operates on the direct map.
> * kernel_[un]map_pages_in_pgd() - operates on EFI ranges.
> 
> This work is based upon Denis V. Lunev's excellent analysis of the bug with
> gratitude.
> 

This seems to be causing regression in our linux-next CI [1] on some of 
the older machines (fi-elk-e7500, fi-ilk-650, fi-pnv-d510)

<4> [196.236867] ======================================================
<4> [196.236878] WARNING: possible circular locking dependency detected
<4> [196.236890] 7.2.0-rc4-next-20260720-next-20260720-g3fe08b9796f3+ #1 
Tainted: G S   U       L
<4> [196.236906] ------------------------------------------------------
<4> [196.236916] core_hotunplug/5687 is trying to acquire lock:
<4> [196.236927] ffffffff839048b8 ((init_mm).mmap_lock){++++}-{4:4}, at: 
change_page_attr_set_clr+0x10a/0x220
<4> [196.236958]
but task is already holding lock:
<4> [196.236969] ffff88810c852238 (&vm->mutex){+.+.}-{4:4}, at: 
i915_ggtt_driver_release+0xab/0x260 [i915]
<4> [196.237572]
which lock already depends on the new lock.
<4> [196.237585]
the existing dependency chain (in reverse order) is:
<4> [196.237597]
-> #2 (&vm->mutex){+.+.}-{4:4}:
<4> [196.237617]        i915_gem_shrinker_taints_mutex+0x35/0x70 [i915]
<4> [196.238267]        i915_address_space_init+0x226/0x2a0 [i915]
<4> [196.238961]        i915_ggtt_init_hw+0x2c/0x140 [i915]
<4> [196.239638]        i915_driver_hw_probe+0x208/0x380 [i915]
<4> [196.240260]        i915_driver_probe+0x113/0x5b0 [i915]
<4> [196.240883]        i915_pci_probe+0xe0/0x1d0 [i915]

Detailed log can be seen found in [2]

We confirmed that reverting the patch solves the issue.

Could you please check why the patch causes this regression and provide
a fix if necessary?

Regards
Chaitanya

[1] https://intel-gfx-ci.01.org/tree/linux-next/combined-alt.html?
[2] 
https://intel-gfx-ci.01.org/tree/linux-next/next-20260720/fi-ilk-650/igt@core_hotunplug@unbind-rebind.html

-- Bisect Logs --

git bisect start
# status: waiting for both good and bad commits
# good: [2b74f1f2024486c7a81915528b6aa7f8f5daa021] Merge patch series 
"software node: provide support for fw_devlink"
git bisect good 2b74f1f2024486c7a81915528b6aa7f8f5daa021
# status: waiting for bad commit, 1 good commit known
# bad: [3fe08b9796f36ef437ab9328e7dd1e5ff2d66603] Add linux-next 
specific files for 20260720
git bisect bad 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
# bad: [19137e3cffc35f327bd14d7b8b02f739f1e5c7bc] Merge branch 'main' of 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect bad 19137e3cffc35f327bd14d7b8b02f739f1e5c7bc
# skip: [4f9e9b2e992ca79e090771e244bc2096709e13c6] Merge branch 
'mm-unstable' of 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect skip 4f9e9b2e992ca79e090771e244bc2096709e13c6
# good: [1aa4e2ed7caafbbbedff89fb226a982413469baf] dt-bindings: clock: 
Replace bouncing emails
git bisect good 1aa4e2ed7caafbbbedff89fb226a982413469baf
# good: [daec24a5ed5da77a108e246ad77aa8b889911f93] wifi: iwlwifi: 
validate payload length in iwl_pnvm_complete_fn
git bisect good daec24a5ed5da77a108e246ad77aa8b889911f93
# bad: [247e42b76590a27408e5eea7009067cac5ad9feb] Merge branch 
'for-next' of 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/peter.chen/cix.git
git bisect bad 247e42b76590a27408e5eea7009067cac5ad9feb
# bad: [d623282ba80e07d3bd7608d905b143041f865f3b] Merge branch 
'tty-linus' of 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
git bisect bad d623282ba80e07d3bd7608d905b143041f865f3b
# good: [6f5156d7a31a8c3b0f34af4675c9299c8f877cbe] Merge tag 
'pm-7.2-rc4' of 
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect good 6f5156d7a31a8c3b0f34af4675c9299c8f877cbe
# good: [7d6ca51a444234ca436d7c19282825797507fe82] Merge tag 
'drm-fixes-2026-07-18-1' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 7d6ca51a444234ca436d7c19282825797507fe82
# bad: [499079fbac564b04cce6a750111bf1c36aaeb4d5] Merge branch 
'mm-hotfixes-unstable' of 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/akpm/mm
git bisect bad 499079fbac564b04cce6a750111bf1c36aaeb4d5
# good: [a2b81de43ca64832fe09844bbf97d1251115d80f] Merge tag 
'io_uring-7.2-20260717' of 
git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
git bisect good a2b81de43ca64832fe09844bbf97d1251115d80f
# bad: [b55b09b68a9cd81d2c1f4004e4c258cbfa61b16f] x86/mm/pat: acquire 
init_mm read lock on attribute change to avoid UAF
git bisect bad b55b09b68a9cd81d2c1f4004e4c258cbfa61b16f
# good: [841587a3eaad22b288d9701f783e20a5046e76b4] mm/hugetlb: fix null 
nodemask in alloc_fresh_hugetlb_folio
git bisect good 841587a3eaad22b288d9701f783e20a5046e76b4
# good: [2272f397e66bd9f78c2e1f524f8e7b1e01e15005] ocfs2: fix boundary 
check in ocfs2_check_dir_entry() to use buffer offset
git bisect good 2272f397e66bd9f78c2e1f524f8e7b1e01e15005
# good: [a5bba3c7f83071427f5f770b53ce5c59f8ed0af0] fs/proc/task_mmu: fix 
PAGEMAP_SCAN written state for PMD holes
git bisect good a5bba3c7f83071427f5f770b53ce5c59f8ed0af0
# good: [f539349310317df97b5f1b501c4c6dc2a73c3c37] mm/vmalloc: acquire 
init_mm lock on huge vmap to avoid ptdump UAF
git bisect good f539349310317df97b5f1b501c4c6dc2a73c3c37
# good: [c6d14c413d47a772a54f6aa7e545a15abc06b1d0] x86/mm/pat: acquire 
init_mm write lock on collapse to avoid UAF
git bisect good c6d14c413d47a772a54f6aa7e545a15abc06b1d0
# first bad commit: [b55b09b68a9cd81d2c1f4004e4c258cbfa61b16f] 
x86/mm/pat: acquire init_mm read lock on attribute change to avoid UAF


> Link: https://lore.kernel.org/all/20260626163213.2284080-1-den@openvz.org/
> Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>   arch/x86/mm/pat/set_memory.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index d1e63f7d267f..301fb9e77d91 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2122,7 +2122,9 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
>   	cpa.curpage = 0;
>   	cpa.force_split = force_split;
>   
> -	ret = __change_page_attr_set_clr(&cpa, 1);
> +	/* Avoid race with concurrent CPA collapse. */
> +	scoped_guard(mmap_read_lock, &init_mm)
> +		ret = __change_page_attr_set_clr(&cpa, 1);
>   
>   	/*
>   	 * Check whether we really changed something:
> 

