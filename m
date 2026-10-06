Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149913B47FC;
	Tue,  6 Oct 2026 07:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791271737; cv=fail; b=FgPMHZefcxk151IUqzH/jy86FB9QocWRZXDOOXwb0iOXlflEz2qb0DmOxdR3eDOr3eUF7zlLzoZihiOkL6bxgnjGVT1fHoKetUnk0GBHQTRH9oLRRvEgst3b/4tfCzYI0t3UuefJEArNouCFYUqhzyDlcn9t6x4Hs7RubeSliBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791271737; c=relaxed/simple;
	bh=HVyVtUnN7Dyayak+1srAdO+WF7uFhlWYNmKTcjZO/NI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aRyCcsrlzjA//ih3yO1CF03SgKhiR1JJLfJyZPYD12737/FDO6Zn8TMSjXoSOAzwjS10pvMjUDm73d+sDMrYc5l/dn38a+7UgX3opWHdUMUlKYXBOpRRxefEORfEtAsn8g+HZK3DyZRWbSH5+pQiCw29tZ3jxxnFK2oUf1p4jSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dRi0Rqp7; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dRi0Rqp7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791271733; x=1822807733;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HVyVtUnN7Dyayak+1srAdO+WF7uFhlWYNmKTcjZO/NI=;
  b=dRi0Rqp77OgkRL8aE+Xxa4MsRyU6irZHVruv+/hk1siz+f/hkt1d5GZv
   JKO9/ahJq7hDqCRdiAk/35RejhWISqOcnybH8Y+2UOR9CNAnQPyE8JloZ
   9JJlM7UxjbqOamC/HXOseal/CiMnbhepdAS713FvpLc/em5+fdq4UBYHa
   mEna59+G4xvCkkbbE9NDGp7SUEWvzd4wcBaDXZ+WI8tp1G016CnFJTci6
   vpVHFTHK2XQkj35CAOgKw3fxVoYcK92EFDFTcKE+SGYXhdmnibn5CSKdC
   dXCYCEjAZAm7yFfzoZSCajUtmwrMvSiiDj4wPMo1c1Qup4gsWTIYwUs4k
   g==;
X-CSE-ConnectionGUID: KRt+65IZSyWo7aGM3iytVw==
X-CSE-MsgGUID: TNlRAXFLQxqRQFo8xcdc/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="99827"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="99827"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:28:36 -0700
X-CSE-ConnectionGUID: ff17EB9XTHSjD65xyDZ2Fg==
X-CSE-MsgGUID: hePr9gtASSm6+bwjf7wmCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="280368234"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2026 00:28:37 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 00:28:36 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 6 Oct 2026 00:28:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.45)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 6 Oct 2026 00:28:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7hxScVn3eOs7FBzNkU9wcFmYPqC2uNqUCDlPbR6nizCJsmVI3VoRMYlFJtFuwaJ4Ii/6SyVIRDIbDLL/j8hgcgM5OgjY2VlY5JYt5BG0N+TdrpBvszk5FB0yfI1uVeMaywStjIZaAETPSoJhxiqjdxo7/K6wgqrqAUFv1xrv6xmZUDjnYjsbEvz4Si1GSowo7RAJcb9V264wCo/JY6Bzej6Hyf+koC7MdUoapx/3tkG2xUgpR63oC7nsTb4Gkn77oNNaivqq5wNjAYXFaNtRsuw/syB6bbDDJPlZdAjd3BoaqS8qSnAtvTo/mjCqFd0iQ2IkVbbAGVjPNaGOGpXzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp1lZKBVY756pkhORpsU1dKWwzO6/37RDrh/ebmT4z4=;
 b=typY2jy6eLCMc2rLVXVqolmlUmsFuqs2XNzLAVPKDJCBkXNkE3vWSdoy4PvKt1fjfYGGmelUNeVEM5+Bxqe18L/S/TObJYGa3PBfQbpQMu0lMQlQyPhf01jcgwO9q8G7XH6AyrQjpaGtSlQ/pJqa/f0qOl2UBc3UBG6RfaNMdxXK0W7FrkLleUQhUqcrq4rK0F3KmK2RVDnsjznOCRX6+1vjbFpwRhNbVSGEXVC6DKZajDJFESyW9buEBIc75kZnMvsStqq7L1a5eNIqT85NBO2owkr8VIq7YL+Z2dPzOQHjjJ8GvTtR0K6orZRxBXaCYvv8dRk+h/FO5pgAWA5m1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7198.namprd11.prod.outlook.com (2603:10b6:208:419::15)
 by CH3PR11MB8137.namprd11.prod.outlook.com (2603:10b6:610:15c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 07:28:28 +0000
Received: from IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456]) by IA1PR11MB7198.namprd11.prod.outlook.com
 ([fe80::2c4e:e92a:4fa:a456%3]) with mapi id 15.21.0472.015; Tue, 6 Oct 2026
 07:28:28 +0000
Message-ID: <ae9b702d-6a19-4f97-8117-b6626e69cc9d@intel.com>
Date: Tue, 6 Oct 2026 10:28:23 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: core: Don't program invalid host driver type for
 fixed eMMC type
To: Ian Ray <ian.ray@gehealthcare.com>
CC: Ulf Hansson <ulf.hansson@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, Kamal Dasu <kamal.dasu@broadcom.com>,
	<stable@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20260926122908.866-1-ian.ray@gehealthcare.com>
 <CAPx+jO-59V8bg+DB4pOqEmdPZrfLi098YsyzkBRnf2Krb7ufVA@mail.gmail.com>
 <791c00cf-4f25-423c-b2f3-4cdc2d2c4a2b@intel.com> <ar5-udUwk8JeB-ut@zeus>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <ar5-udUwk8JeB-ut@zeus>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DU2P251CA0003.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:10:230::13) To IA1PR11MB7198.namprd11.prod.outlook.com
 (2603:10b6:208:419::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7198:EE_|CH3PR11MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: bc06ab0c-bab4-42b7-affa-08df237b6a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|18002099003|22082099003|6133799003|3023799007|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: g/vwxQeAvvvCeJJFtcUe5r8SPaqzDQpL4FZ95fj50jttKka/z4G2y/ripFOi4Ui9iSjueE6k3SXyUMSvvaerjKEX97JzsA0UmGx1siyPxsx1wE0pemnT6kc/jyWQqSITbShQvoRVjVHH8hVrt+XB7dDCWzS5ISayV3t/Mii6V37fh7DN7/YdXECL967KIAZLftlgTq83PjKaTOo7/Wmp444uG4vV9IiRa/gVbbRVSSJ3VgVlgklny4IxGwQMjpQAsLj6ICd+hG0rCdDSmXe3smUGE5F3dibaYltvfrWlkHFcrBez8OE2lANabV86BI+2jLwrLo5Vf34geUXLjymoX/cr/h/rslM4n70b9BZLxZmSHZdbT0I13Cx6MnZTKeXl9nyeqVek2K9XXpwXqW/thnmcS3I/ChjHrM+egndZ8OoOu4lChaZkHzc/RuBAzjMwAnCwX7e6/JIlyFNVza/b3mu24RxjdGqowyM19/Jw3cif2kXgL+30RzwXhu6PtbNiaT4Y8KZUec8Q0gi83ulKSy+qnIc2yVcmEBzBGqSRyoFkDIc1ecPJnutdfa5RuyqL4WXDiCFRKSvo8V1uc6PztyNYJpujySpebJEsDrxi2dKMdCc6nALV6vJ2DNqzoWgBG4ShnweMvRp4q8TYGnysupTiL+Eh06uv4JMrRSvtZhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7198.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGo5ZmFhR2FCTXJCUnQ1UExnQUdtdEg5KzRFdXFjN1hTUi9qZGJMNTMvRk0v?=
 =?utf-8?B?Zkt2NVNQR1VnbnRNTzRXRk1lM0I3UmttU29PTXQybXU5MmFmUklPc284aW12?=
 =?utf-8?B?TEhrUWN6ZEVxaFJreXdRc3dmNS84MERXOG9UTk8vQURWdnNYQTlSOE9SVzI4?=
 =?utf-8?B?VTJMM1hTOUZQLy9ZNjh0WVd6T1o4NlJiQUlSbUgxYjdQT1dvWmp4YzNPTHpB?=
 =?utf-8?B?VlZSc3owZk1uajVpRTdMZUozamdIRGN1OGQzTGk1SkNaU0pBSjhiK25TNmky?=
 =?utf-8?B?RHVocjdGbXduWGFrRDNKRVM0Y3JYQnpRaEFKNDJmVFhJSk41RGw2T3B3dEpy?=
 =?utf-8?B?R0dKamIyV2VnUDV1TTBuZ1k0YnRoU0QyT0FWc1hhaU1UNVFKZkwrajIyQ1VO?=
 =?utf-8?B?ZlZ2dGRONEhtR3gwaGYwQVNOM3RHNGFzTktDajNNOS8yMTVnc0VDa3o0VEx6?=
 =?utf-8?B?RmM1dTc5RWxnVURwNEpjRDl2WG5wRUpZaWxtdURhWXhWVy8yVk03OUlyU2dj?=
 =?utf-8?B?L05HQ1ZPcFJRV3JjUEl4NWttNkp3eHFYVXZyajJUVGs2VkM0OW9Uem5uZnNa?=
 =?utf-8?B?UGt6cEwwS0t2VitCb3pkRTl0Y0ltZG5NWDJHc0ZRcG9CdTdjYmIyOHovSEpR?=
 =?utf-8?B?bFkwT0VKTmlLS0FHUWoxTEUwNkd1NlVmVnN3WWRVRmNZTFp0SGpvS0Y5bGZx?=
 =?utf-8?B?cFlLU3FRYzVtbmt1Z1E3MXpQNG5Hcm1lQWVqRnIwencyck1ONnRvaTkxTFhH?=
 =?utf-8?B?RGh2WVFWdGx1RnkwcllCN0RKcmhXYk4vb3JrY0RHWW5Rc2lQWTZmRGNUOWRz?=
 =?utf-8?B?SDNudzZaUFhFY3FrMWxXNEFLakwxSUtCbCtmWVdkYzd4STJlcGFoQWsxbU1o?=
 =?utf-8?B?VTliWVhuTDQ3Tm9IUGRyMTFXdTZSZVdNKzJSM3lKR3RBamQ1R081T2ZDWTBv?=
 =?utf-8?B?TnUvMzd6RVA3djBwOFF6djc1ZGJJbWl2S09qRHFFcFQ2YzBBSzl4bzZ5MWRm?=
 =?utf-8?B?cndibURIM1lGWUtYaG8xYVkvMEQ3cjdsdFIwZXJGVFNQUVlJUnEvRGdNRDY0?=
 =?utf-8?B?RFpRL0JYeTNWZFFwd2hmK1R3ZFl3Y3NoZnY5Z3NuSnZELzJ3NXNMTU80b3lM?=
 =?utf-8?B?UU41blNQWTU3OHkyVjRRY1BOMGxxbUNnN1g3YTBheGxHVm1PZ3FscW5wT3hU?=
 =?utf-8?B?MGdxNHp5UDYyNkNBckE4bklCQkRVNzgydXM5aDgxS1NJMmdEU2ZITVlVMjVE?=
 =?utf-8?B?aC9oN2plWFNxMjhsVUVBaWZPdHhoQWd6NXl3Q0x6NDg2aVV0U2l5ZU9YQVh3?=
 =?utf-8?B?SElQOFR3Q0RkWHM5cDBtK0xPRi9FWERBc0RBb1FoRUFZeDJYdllPWnkvWUt4?=
 =?utf-8?B?T3krK3JqUWJkNGFYNUFVZTBaRWFEbGlNR2N6cEo4SCtPVFRTV3NDMjJHSjVu?=
 =?utf-8?B?bGY5TFNFL3N2UFR4Z25rZlF6d01BZUIzblQ0RlcxRGhQNUNiY3pJaXFsNGdz?=
 =?utf-8?B?S3MzTXNNVWlxcUlqVlE3VlhXdVpHVEQrMlpqR3M4RVNMYmR0T05aSi9OY0kw?=
 =?utf-8?B?dFUwd3ZDcmJzQTFaVWVaeWE0M045TmE0Y2hBSUJCei9rb2p2eWUyU0gxUWZ0?=
 =?utf-8?B?bTFHaVpPVTZBQ3hiN21GYWdYcmdiblV2TTd0Z09NSDVzYmN3WGo3TkU1eGM5?=
 =?utf-8?B?YnNtdXo3cTFnYmlSQkhCVnVCMnJJcDhiOXFEaDdtdG1EMHhiU2ZBaE9LUnEv?=
 =?utf-8?B?TVMyT2c4N3FNb3I3ckZRM3ZhRkdLRGtXTXloY01kM3hRL1V0MElFTDBjTFFm?=
 =?utf-8?B?NkRTZDY4c09wdnhTcmdYWHB3bkNKSXFRTElaR0RrKzgzVURscmtOcUh6aEtm?=
 =?utf-8?B?aFpOdjIzcFhQS0FxNisxR0c3VjdSdVZybkxnKzFTWGY0dm1COVRoc01iNHcz?=
 =?utf-8?B?MEVNWWZNQkUyL1djczJUdnJPQ09zcUM4RHpaTk9RUUNZTDgwTXNyL0Z5NFJy?=
 =?utf-8?B?anFVcDMyZEU1OFN3ZmYyOWhUNFRHMUdUNlhpOGhBUEhHbDlOdld6NzhPZ1Z3?=
 =?utf-8?B?cFpsOEc1ODlOUW1QeE4yR3dWWjY1RmpNR0pUOFh2ZklTcWd5SDFpVnpqeUJj?=
 =?utf-8?B?WGZ2KzhRUWR6dEVjSERsdE15TUxGcC9WTzMydTA5Wnhkb1BFSTA2YWpVWTcz?=
 =?utf-8?B?OGNTVGIyWDFydUhiQjBwdGVnUHp2Z2F1a2FOaEMwK1Vob1l6aG14ZWRSN0d3?=
 =?utf-8?B?K0VUY0tCWGYyMjY0WjFTeVdRYXpDUjBmaTZUUUlhekM5aUkxUEF6dGlKTjVZ?=
 =?utf-8?B?OWora0tEc1JoVVpGcURTNGRQams4bjJpVm52OHNSTFdRdHo3aUtvRE12WUhh?=
 =?utf-8?Q?rrilYhmnapWguEQE=3D?=
X-Exchange-RoutingPolicyChecked: R9aV0E7yAV7f3Tkt++yblfcTZWO6emfZVWUVShjPsSvvqRA2mej7FLQgLP4i4ze8ROGBbZ+miJ12MxhFHKvyITYB3ZYk0ofEFZs++0p3JJ+Btky6LUxDLyRuaGsRuOIkk+7zzdI0HeHc2ShnHZQZ9Y+0RMiFsooef6f8Bm4jPkMjpPDG5QU4GBxrAh2vZTyjBQnD912weDicVkIhGMb1O3RI4Rk6PojOzW4WLyrZhy1oQnR+sWqgHeRAOLpLUUwL0fivX51XtCrKANvjwwCCp8X6yi87sM/33cnhWQGDht6EFtFPSmZck4LsNTKmoxam2WY8rx7XOO2mFVbPOwtaKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: bc06ab0c-bab4-42b7-affa-08df237b6a31
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7198.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 07:28:28.3139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNe3uYjSxWr8R73wvFdju7dR5jeN8PtJhVo/UTuqdGy/+yjZsnvAY/oOb/Z3gOTiauSoBZW5Q9Erf2ZaJfr9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8137
X-OriginatorOrg: intel.com

On 01/10/2026 18:39, Ian Ray wrote:
> On Wed, Sep 30, 2026 at 10:00:47PM +0300, Adrian Hunter wrote:
>> On 29/09/2026 16:06, Ulf Hansson wrote:
>>> + Adrian
>>>
>>> On Sat, Sep 26, 2026 at 2:29 PM Ian Ray <ian.ray@gehealthcare.com> wrote:
>>>>
>>>> The host controller driver type value used by the MMC core [1] _mostly_
>>>> overlaps with the eMMC device I/O driver strength value [2] as shown in
>>>> the table below; however, there is _no_ host mapping for eMMC value 4.
>>>
>>> I think the mapping exists only because that is what the SD spec
>>> provided when this was introduced.
>>>
>>> We can certainly add something that corresponds to value 4 from the
>>> eMMC spec as well, to make this complete.
>>>
>>>>
>>>>   host value/type   | eMMC value | nominal impedance | strength
>>>>   ------------------+------------+-------------------+---------
>>>>   0 / Type B        | 0          | 50 Ohm            | x1
>>>>   1 / Type A        | 1          | 33 Ohm            | x1.5
>>>>   2 / Type C        | 2          | 66 Ohm            | x0.75
>>>>   3 / Type D        | 3          | 100 Ohm           | x0.5
>>>>   (none)            | 4          | 40 Ohm            | x1.2
>>>>
>>>> [1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h
>>>>
>>>> [2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
>>>>
>>>>
>>>> Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
>>>> for fixed driver type"), the selected eMMC driver strength is passed
>>>> directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
>>>> this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
>>>> complains on every ios update:
>>>>
>>>>   mmc2: invalid driver type, default to driver type B
>>>
>>> Perhaps the print above from sdhci_set_ios() is simply a bit
>>> misleading. For example, it looks like arasan_select_phy_clock()
>>> actually uses the value in ios.drv_type as is.
>>>
>>> To me, it looks like the problem is that mmc_select_drive_strength()
>>> doesn't really do its job correctly, as it should help us to figure
>>> out what is supported by the card *and* by the host, so we can request
>>> a proper driver type when calling the ->set_ios() callback.
>>
>> mmc_select_drive_strength() returns the card value directly and
>> the host value in *drv_type.
>>
>> fixed-emmc-driver-type as described by
>> Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml
>> doesn't mention the host controller, and the original commits
>> 6186d06c519e2 "mmc: parse new binding for eMMC fixed driver type"
>> be17f1ce8572d "mmc: core: properly init drv_type" seemingly
>> deliberately left it alone.
>>
>> 5a52c5701a67d "mmc: core: Fix host controller programming for
>> fixed driver type" introduces a new policy: fixed-emmc-driver-type
>> is a host controller setting also.
>>
>> If that was done by mmc_select_drive_strength(), it would look
>> something like below ( note it no longer allows fixed_drv_type to override
>> ->select_drive_strength() , and fixed-emmc-driver-type will then hit
>> any nonremovable SD or SDIO ):
>>
>> int mmc_select_drive_strength(struct mmc_card *card, unsigned int max_dtr,
>>                               int card_drv_type, int *drv_type)
>> {
>>         struct mmc_host *host = card->host;
>>         int fixed_drv_type = host->fixed_drv_type;
>>         int host_drv_type = SD_DRIVER_TYPE_B;
>>
>>         *drv_type = 0;
>>
>>         if (!host->ops->select_drive_strength) {
>>                 if (fixed_drv_type >= 0 &&
>>                     (card_drv_type & mmc_driver_type_mask(fixed_drv_type))) {
>>                         *drv_type = fixed_drv_type;
>>                         return fixed_drv_type;
>>                 }
>>                 return 0;
>>         }
>>
>>         /* Use SD definition of driver strength for hosts */
>>         if (host->caps & MMC_CAP_DRIVER_TYPE_A)
>>                 host_drv_type |= SD_DRIVER_TYPE_A;
>>
>>         if (host->caps & MMC_CAP_DRIVER_TYPE_C)
>>                 host_drv_type |= SD_DRIVER_TYPE_C;
>>
>>         if (host->caps & MMC_CAP_DRIVER_TYPE_D)
>>                 host_drv_type |= SD_DRIVER_TYPE_D;
>>
>>         /*
>>          * The drive strength that the hardware can support
>>          * depends on the board design.  Pass the appropriate
>>          * information and let the hardware specific code
>>          * return what is possible given the options
>>          */
>>         return host->ops->select_drive_strength(card, max_dtr,
>>                                                 host_drv_type,
>>                                                 card_drv_type,
>>                                                 drv_type);
>> }
>>
>> and:
>>
>> static void mmc_select_driver_type(struct mmc_card *card)
>> {
>>         int card_drv_type, drive_strength, drv_type = 0;
>>
>>         card_drv_type = card->ext_csd.raw_driver_strength |
>>                         mmc_driver_type_mask(0);
>>
>>         drive_strength = mmc_select_drive_strength(card,
>>                                                    card->ext_csd.hs200_max_dtr,
>>                                                    card_drv_type, &drv_type);
>>
>>         card->drive_strength = drive_strength;
>>
>>         if (drv_type)
>>                 mmc_set_driver_type(card->host, drv_type);
>> }
>>
>> But that doesn't help with drivers where the controller does
>> do not support the value passed by fixed-emmc-driver-type even
>> though the card does.  mmc_select_drive_strength() has no way
>> of knowing that.  The ->select_drive_strength() callback
>> allows selecting different values. fixed-emmc-driver-type is
>> one value.
>>
>> The warning in sdhci.c seems correct.  SDHCI is an SD standard,
>> so doesn't define value 4 (and only has 2 bits for the field).
>> The selected driver strength is not being programmed - deserves
>> a warning.
>>
>> Perhaps if the affected driver implements
>> ->select_drive_strength():
>>
>> static int ???_select_drive_strength(struct mmc_card *card,
>>                                      unsigned int max_dtr, int host_drv,
>>                                      int card_drv, int *host_driver_strength)
>> {
>>         struct mmc_host *host = card->host;
>>         int fixed_drv_type = host->fixed_drv_type;
>>
>>         if (fixed_drv_type >= 0 &&
>>             (card_drv & mmc_driver_type_mask(fixed_drv_type))) {
>>                 if (fixed_drv_type == 4)
>>                         *drv_type = MMC_SET_DRIVER_TYPE_B;
>>                 else
>>                         *drv_type = fixed_drv_type;
>>                 return fixed_drv_type;
>>         }
>>         return 0;
>> }
>>
>> But that requires the changes to
>> mmc_select_drive_strength() and mmc_select_driver_type()
>> above (with its caveats), so that ->select_drive_strength()
>> overrides fixed-emmc-driver-type.  That would be fine for
>> drivers/mmc/host/sdhci-pci-core.c, and probably
>> amd_select_drive_strength(), but it is starting to get
>> complicated.
>>
>> A simpler alternative is for the affected driver to hook
>> ->set_ios() and fix up the value.
>>
>> void ???_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>> {
>>         if (ios->drv_type == 4)
>>                 ios->drv_type = MMC_SET_DRIVER_TYPE_B;
>>
>>         return sdhci_set_ios(mmc, ios);
>> }
>>
>> And in probe (assuming struct sdhci_host *host):
>>
>>         host->mmc_host_ops.set_ios = ???_set_ios;
>>
> 
> Thank you for the feedback.
> 
> The "invalid driver type" warning that I originally observed originates
> in sdhci_set_ios_common() which is shared by all SDHCI hosts (IIUC).
> 
> Thus any SDHCI host configured with `fixed-emmc-driver-type = <4>` would
> log that warning.

The warning is valid.  SDHCI does not support value 4 and doesn't know
what is a valid alternative or even if there is one.  That is up to the
driver to sort out.  If other drivers do it the same way, then a
helper or something could be added.

> 
> The affected driver for my scenario is sdhci-esdhc-imx.c, and the
> proposed change (below) suppresses the warning.
> 
> But I am hesitant to open-code the same fixup in every SDHCI driver.
> And I am unsure whether this belongs per-driver, or whether the right
> fix is in the core / or to the warning itself.
> 
> Comments welcome!
> 
> drivers/mmc/host/sdhci-esdhc-imx.c
> 
> ```
> static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> {
>        /*
>         * A drv_type of 4 reaches this callback only via the eMMC
>         * 'fixed-emmc-driver-type' path: it is the eMMC I/O driver strength
>         * value 4 (40 Ohm, see JESD84-B51 Table 206), which has no equivalent
>         * host driver type in the SD standard that SDHCI implements (only
>         * types B/A/C/D are defined).  Map it to the default Type B here to
>         * avoid an "invalid driver type" warning from sdhci_set_ios().  The

The objective is not to avoid the warning.  The warning is valid.  The
objective is to provide a valid value.  4 is not.

If the actual value doesn't matter here at all, then say so and set
it to MMC_SET_DRIVER_TYPE_B always.

>         * card's HS_TIMING field is programmed separately from
>         * card->drive_strength and is unaffected.
>         */
>        if (ios->drv_type == 4)
>                ios->drv_type = MMC_SET_DRIVER_TYPE_B;
> 
>        sdhci_set_ios(mmc, ios);
> }
> 
> static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
> {
> ...
>                /*
>                 * Support fix up of eMMC driver types which have no SDHCI
>                 * host driver type equivalent.
>                 */
>                host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
> 
> ```
> 
>>
>>>
>>>>
>>>> The mmc card itself is still programmed correctly (the HS_TIMING driver
>>>> strength field is set from card->drive_strength independently), so this
>>>> is a spurious, repeated warning for a valid, documented configuration.
>>>>
>>>> Change to only program the host when the eMMC driver type value maps to
>>>> a valid host driver type.
>>>>
>>>> Tested on i.MX8MP (usdhc3, eMMC in HS400) with
>>>> `fixed-emmc-driver-type = <4>`: the warning is no longer logged and the
>>>> HS_TIMING register contains 0x43 as expected.
>>>>
>>>> Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
>>>
>>> I have looped in Adrian, to get his opinion on this.
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> ---
>>>>  drivers/mmc/core/mmc.c | 8 +++++---
>>>>  1 file changed, 5 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 05444ecf3909..ff5d4b805998 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card *card)
>>>>
>>>>         card->drive_strength = drive_strength;
>>>>
>>>> -       if (fixed_drv_type >= 0 && drive_strength)
>>>> -               mmc_set_driver_type(card->host, drive_strength);
>>>> -       else if (drv_type)
>>>> +       if (fixed_drv_type >= 0 && drive_strength) {
>>>> +               /* eMMC driver types >= 4 have no host controller equivalent. */
>>>> +               if (drive_strength <= MMC_SET_DRIVER_TYPE_D)
>>>> +                       mmc_set_driver_type(card->host, drive_strength);
>>>> +       } else if (drv_type)
>>>>                 mmc_set_driver_type(card->host, drv_type);
>>>>  }
>>>>
>>>> --
>>>> 2.49.0
>>>>
>>

