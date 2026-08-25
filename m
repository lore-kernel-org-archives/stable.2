Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D99C2FD69A
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787623780; cv=fail; b=mcmOjDXBXYY1+cjENtHvPkMl+sHlCthw2nDn9sZ5cwa0FRJwSZE8FbaQX4LMEkJiHgWlcO5PURtuUqNOYBO1Vlba+2CtvoUR6KmWmmxQFUI7VgvFcE7sDHRFu11/UwlP6+IpN4DLb/IMPpy5kaHtQRSKGJBDhs2VgtyiJa22AI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787623780; c=relaxed/simple;
	bh=eRSNPNNaRx0EM2Gzrljp5uBdtX4JnvQNVjS5iqe4DzA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u47t6OJ/LhenYq0lWwjMxKTkpCNCjBEEY4lYRlFX4SE8wcIol1ByFxUOxz0o9iXZkrqdlsQfdY10Hh5a+CMziI7f6ZiUSwhiD28C5Q2E3Rwja79tm56sUkKi1PYIE8EydpcC/374SIDVqEgw7c+rAv3uj+yeRFG50te3jC/L85M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XccF/q3X; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XccF/q3X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787623777; x=1819159777;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eRSNPNNaRx0EM2Gzrljp5uBdtX4JnvQNVjS5iqe4DzA=;
  b=XccF/q3XAKfQz5oP8bmsy2glMR52RXKBKn/IObPFLxCYQQSRgjt0L/Mf
   bTBlKxR63Hrr9PtMiDKX87niZpNTRGU3cl2MWaWc9Qg5V/UN+7SRL4L9o
   ZZ2zyHesR92Z5TLCNS6DRhAg4eqUEWQYYjPnCMnSwfQiG9MWjEho6ze0G
   weaefRpHSVhjsFKuMKuwokTPgrV8vGjn7dqkvswRTt9MAyunTA2bdZydb
   wYXoBjLnjWwLeeOiifSjveiMJ5iU1a3mmEJI9GCHybEzd3u0eccB4+jNl
   5HM5i3AceUQzAHgBJDAeHDEa84hXX+M1vXcqVrxIsGef3NrPjQKH78zBD
   Q==;
X-CSE-ConnectionGUID: 1SB/DDauSa69IIdhLJcd0g==
X-CSE-MsgGUID: fusJGxRaQnWwFmJD0H95og==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91954210"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="91954210"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:09:37 -0700
X-CSE-ConnectionGUID: jiXbzLqJTEavUk2dXSmszg==
X-CSE-MsgGUID: hIvHJEfgRC6nRUPNC5OYow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="272374988"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:09:37 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 19:09:36 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 19:09:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 19:09:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpYbC37cFeWOz09mHWNSpGdGffOroaJHMCOOcjd9kqUvk6T2NcdTVZjA2X28VYFQQ3zYrUhzIjpavEX089KqnrhQNB5fDBJXTMPVRKmgQgFC9ZN1//IIOqbBdzJo725BIPMYkB3MTKYHYApYSViXEaeBOarSjbxV7DMMwDRYnepUlANYMoWhd1tKRbGboj5lUkZl0MdxuGL+ikx6c3pBDtDKWKdKu8eQfGImPKygTmwcRi8h8CiFY1QjD5yQDrMSxzqH22j3gFrIZSFa5jby3p/th7dWKY+h/SCXuiMoArlrI6CBnj2D/U5ALy24U5ycmYoFzdzmyG3i7GC1B/JNaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiEWPsLTG7asiEyIHafQHOOHfiemdBj0sOvBPyFIz2o=;
 b=gG444pNR+P6hoUbTbDtCPNwR4ugcTtqfoLRo/lCoO2VXgHYDYQ1AZnR9fk2u6A2wYoj+7CdLwHgNgYNfKCFTDXPIYasCqwZlzRtpb1hGo036zIbo694Zvfa1FXvpHaXF1YFPuD9zH66urrmdrBvTBlIkyXi8Xlhr0zFWU3trCHW7tph6HsaMWVFtdECdtbODluoyOgXekcZiClqBqHD2RpdcDL0z7w0mopYz7UGCjpbSNoEWsi/bnM5mutbCk6EZmkqQbAU7BygDoJUJDQsMZaq1b4hCQfZsRNUEkQQ15bGlu17AIWPlyQM+EZ9+WUa0Qx083OkEmCScniC1AMEMog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by SN4PR11MB9968.namprd11.prod.outlook.com (2603:10b6:806:4fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:09:35 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 02:09:35 +0000
Message-ID: <5e9a52d3-97d1-4ec3-b0ce-d2d411a0dba0@intel.com>
Date: Mon, 24 Aug 2026 19:09:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/i915/huc: Validate the CPD entry offset before
 manifest read
To: Jesus Narvaez <jesus.narvaez@intel.com>, <intel-gfx@lists.freedesktop.org>
CC: Martin Hodo <martin.hodo@intel.com>, Alan Previn
	<alan.previn.teres.alexis@intel.com>, <stable@vger.kernel.org>
References: <20260807192301.3009387-3-jesus.narvaez@intel.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <20260807192301.3009387-3-jesus.narvaez@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0129.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::14) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|SN4PR11MB9968:EE_
X-MS-Office365-Filtering-Correlation-Id: 270f43a5-d6e1-466c-41dd-08df024de8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: GoEXuLicoMKHmlcugmBQgPEE1W7x2FhfRL0Zj2arxiOyLeWNquvRAOKcArhEl4DC6aZa+zledoJJ+mVzXarQ8dx+RDYL+JPhndE+7I1d4p5qPYjw6AExiYvV16WansxJoinQZBW6SaBdB+2oHSmnxrsgzeuYqBJXYRqau/YNi893q9rWNlSGD+BKYgQrgRT7Ky+AEw2BMngZZjFUsVaRjdUDYMooxLN6IQivu3VjQoUITWLbZj/cwVyM4gVXTLTG5L4NDCkaKownwblYIkR5u+i+yLiURi4mHi6yb7MaN23dLCTwCdq2fkt5cqZD0wWVg2fwev4hEGDL1EH81jzwQ0I+UqSepXM1u231QazZ8pHzXVJUSulZjIBAjWvbKM9HwOUBF2ovcVTBKnyzQWZvsELXp19cRIupXtQZrEQdw4Db6ANMO2I7BY7ILzBTiGLIFcVO/1ZK8/fgfGb1fisv8fjvgco1HDN0sk3DNodiD1P6UDgsPSkjQ0RYvrw0dN7RtEksPgLvrHOfVCz/LMumYwSHR60/ZUuFt1kU1ZybxTzhwBncPb40KLXB/hKRrX4yGEpzHNSOwo71rB9SRBwsbUtVqrAiFA9v/D4Jja2lBH/ggaHXoxzavQNUYnehD4OWh3vTr+EUUopH2ZtjMrh6FYQyDJdrjdEth2TbOvclDmU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4979.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0Q4cnE4MUNtSGlRcytUdm5TUHZBV2lzNUtZdGRTMVlTd3lTQkJlTFlTN3Ri?=
 =?utf-8?B?bzR5Vm5JYlBxcmxBdHV1ZEJpR1pua3pETFcxUlgyTDdpYXB1RTN5eVRJV2gy?=
 =?utf-8?B?NE9RSkNpWElERXhMUU1YMll4NGxnR2xpMmhFeXY5Y0pBbUdUY0wyTTZnaHI1?=
 =?utf-8?B?QWRpd1hSMTJick1TTGJ3b2VOMEQ5UmVJNlRHdFZVRWlFSzlidDRpU0M5Zjdi?=
 =?utf-8?B?eGx2SURxb2VSRSs3MkZ4S2pZNkRPZUgvVDJHT08waWpuakRic0JROWFaTE5C?=
 =?utf-8?B?WURWK1A4QkdPOWg3aUxEemoyVHA1c2NlaHRDd0hFNE55WnJwZkRkN2dmQ2Fw?=
 =?utf-8?B?TENlZzFITDBwZEp2bE5ac2lGa0Mra1QvOHRYUGxacEZjNDcydjBoL1BZZEZU?=
 =?utf-8?B?Mm93YSttYXlKN0Nza2pVdkhRNHBuL0lBZ0xsV1o4ZEIybGZ3SVNxK1VmU2VP?=
 =?utf-8?B?K0NsdWoyZWs2bW5UdXFEVTZ1NnNQRGRNVVFRU1Avd0IzL3RuRC9RTUlGM1d0?=
 =?utf-8?B?NjEzdWxyaTB6bXUyQU1VUVZIdzN0ai9iRjR4S0t6bkJSeTRWVlIzQ0lEMHRz?=
 =?utf-8?B?cVBIYUFjRnphd3QrVEoxWDM2MThyZC9UajhMdERMaGxKOTJYblBqaVNFdTlz?=
 =?utf-8?B?MDcyOHlDQVMwUDJkVDV5SnllZFRlM1BzMGcwdHpJNXdBRHkwNUlSZFplc0lE?=
 =?utf-8?B?RGppL3k0MzZSUFArQUxXclQzUVVkZ2UrVWVCRzlBZXpYNmppNU9kN2JxVDc5?=
 =?utf-8?B?cWVsUk1WeHlubGpHVUxYemQzZTRFTzJvaEJqTytRMkZGb1ptWFZWbllkNjNi?=
 =?utf-8?B?ZGNoZ3MxUjRQcXN4SHU1LzJHS2VhL2ZzaHQrYVVVRHF3R01YRWRWVjVNNEFK?=
 =?utf-8?B?anRkM1FRQS9OVDRMNlFsUEpHamhFWjJwLzZaWERGOENkbFpDR3p4RzkrMDZK?=
 =?utf-8?B?ZDdRejR2amU2RjQzS2wrZzBHUmRhTGYrWUdacGZQcElXbDJYdW1SVXJ5cDhS?=
 =?utf-8?B?MWdvb1VuR2tGMnRqdHBldDJ6TjQrMHloT3NYSXlSaUloeE8renJTd3NrM0U5?=
 =?utf-8?B?TlNGZm1PaUJodEpndmlodHV5NHg3UlUrN0o2UXdoUUpWWTB3UE1wd3BPNitw?=
 =?utf-8?B?bG4yZGUrdHNpeDQ3TTdBcTJnbWFhWktuTTJwTWhmemdJNjNhdktnRmJvRlh2?=
 =?utf-8?B?NVFUdENwTXI5dW5hQ21qeHlQdXZkWjV3QlEwREVwUU8xWDJZT0hIN0tTQVB0?=
 =?utf-8?B?Wk9BSHlmMmxSaDlPaTlreUpWdUpQOWZUSGF4QW00SVJUSklKdWFmK20zTVQr?=
 =?utf-8?B?L2gzZ1lWd3oyV2ltRk9XcUNnUzhNL1FIamltMTl4dXl1bHhkT3RVMTdFakpO?=
 =?utf-8?B?VmNLRm9jTXZzVDhjeEFkUUhCNWdvdlkvM2lKYzZjWjg5WHp6UXhkaHNtK0RY?=
 =?utf-8?B?Ylc2OCs0T1JLRTFsWFMyUm45NEFVdHJYcVZNRlFmOTc0eTY5QktqR1ZZSUdC?=
 =?utf-8?B?dWo5R24xT0F4aXZkMkdDZHVjVWQ1QXAzSkR5SWQ4M3dUc29GOTZoUkg5SHlJ?=
 =?utf-8?B?NjVrdERBVDNyWkhuU1RnRitLeWo0OGJNNThEcGpCRjh0L2crQ3Q0ZnNZOTA2?=
 =?utf-8?B?d0FXN05WKyttLytHMHpuT1RIN0psY2VzNW04MkhSd1JlUGJRRHVFclNNRkp4?=
 =?utf-8?B?dStlL2N0SnZ0R3VMays3OW8yMTh5OTVLcG4vOHQyZlZvWDdDZ1N6b1lLNFF0?=
 =?utf-8?B?dzRRdW9jdDh2MFppUWU0T2RSOGlsYzBET2c4OVpUT2NiWldEZHZsTGcvaTVm?=
 =?utf-8?B?YTNrZ2x1MlUzczJFOXJMWHNsVFF4WXJVSzFVQjA0dk9OcEpYZERRZzRLSmc2?=
 =?utf-8?B?aDNQdTVac04zeEdCZytLUHdkSlVxR1E3eEd5aExJbnFPQzNmaWs2WnRYU3F0?=
 =?utf-8?B?Ry92cUVUZ2xFUDZhQTZSaVI5Wm5NOTdQekw3c2c0b3Jld1RrZTc0RVFCZmNs?=
 =?utf-8?B?Z1lnbGh5WFFOK0pWSkR1YmpFbS9sd0FobDNjeUsvMmh6NGlQYUVobmR6Mjlj?=
 =?utf-8?B?SXgrTTk2cS9lVW42a3JjZGZvb055V3NzM2tudGRwcjVmRXY4TkdIaDNKc0sx?=
 =?utf-8?B?Y3pxNGx2RHJlQkg3MzVHRXM3WHhHTlR3SVp2TTlTdjJSTmVmTVJSSjNoNjJt?=
 =?utf-8?B?VHQ4bWlhNzl0VFJSczBZQURWeE4vdE1UcVp6RW5EaU5NT3ZKS1pKQi85TlVm?=
 =?utf-8?B?VTE0RXdQbDJiQjZLN1pVaWxncDl1dU8ydmo3ZXE0bEdvRlllWloyVW5UVjgy?=
 =?utf-8?B?bGJYSTBVckJpRXpVNUsrd3JkYXg1T05La3RWVFVZdFEycHB0NTB5czlRNGJy?=
 =?utf-8?Q?TvFRMLXjA4FuVIBE=3D?=
X-Exchange-RoutingPolicyChecked: Zf+Im4lV/zVdgJpoR+viEqfgxcMwG43gvdt779CvKhCvir7QEvFgaEq+OU6UePLXTrQHgx96HQaCvb/hVTsCHgzr4YXhZn4FqphVUlKK8rDpUDYzSOvzyDB1AzEkFroqdV6yHjNdkNTExTsjkdZWW9jCJwy7gbC3qVKt6QjUdHaUtj9WK0HHcuvsLqKLPFkkg+kXsefztAslt88axI2v4K0g2xmhVXV7xVNFu8a9+OZEdDlze9tJ+OsPXl2uFa+0jv3G+Y73zWIaI85ggItleJKxCOlHa3vhaARZmy1upqgsCJCvMei0o6HqWhFyjIOJ+cUj0yVr1jBFtS0TRBhU1g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 270f43a5-d6e1-466c-41dd-08df024de8a5
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:09:35.1368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYTcffJq6wH6yCIZWLX24zm2kXc8DI+hT5VP5280MoOvtQbdp+7AjBRwoIB4h5YsxDLYGjFp9moEnI/W5bZ+dOliZVgjy69ODU2FmmvyrfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR11MB9968
X-OriginatorOrg: intel.com



On 8/7/2026 12:23 PM, Jesus Narvaez wrote:
> The CPD manifest offset was dereferenced without checking whether the
> offset was out of bounds or not. Validate the offset is within the FW
> blob before continuing with the read.
>
> Discovered using AI-assisted static analysis confirmed by Intel Product
> Security.
>
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 93a575ab1533 ("drm/i915/huc: Parse the GSC-enabled HuC binary")
> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
> Cc: <stable@vger.kernel.org> # v6.5+
> Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
> index b648238cc675..b9cbcf973236 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_huc_fw.c
> @@ -216,9 +216,19 @@ int intel_huc_fw_get_binary_info(struct intel_uc_fw *huc_fw, const void *data, s
>   	entry = data + header->header_length;
>   
>   	for (i = 0; i < header->num_of_entries; i++, entry++) {
> -		if (strcmp(entry->name, "HUCP.man") == 0)
> +		if (strcmp(entry->name, "HUCP.man") == 0) {
> +			u32 offset = entry_offset(entry);
> +
> +			if (offset >= size ||
> +			    size - offset < sizeof(struct intel_gsc_manifest_header)) {

IMO this could use some parenthesis to clear up the ordering of operations.
with that:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

> +				huc_err(huc, "CPD manifest offset 0x%x out of bounds (size %zu)\n",
> +					offset, size);
> +				return -ENODATA;
> +			}
> +
>   			intel_uc_fw_version_from_gsc_manifest(&huc_fw->file_selected.ver,
> -							      data + entry_offset(entry));
> +							      data + offset);
> +		}
>   
>   		if (strcmp(entry->name, "huc_fw") == 0) {
>   			u32 offset = entry_offset(entry);

