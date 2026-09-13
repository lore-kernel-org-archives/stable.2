Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12C39934C
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789302138; cv=fail; b=ro5PoQXaZhiAS96nK+zQsqNWB4laO5YoDaHJ/1RpiSxbdO8fTEiIhVxxn092EuwCXXTXM+2q43G7jQYyLIyG0dXeq4ai3xT9WYM46GN2RYDrBKxQ1FRU6HzqnzJykNNR1PzrQM74uKToPAJsUAqmA+UJt8NHNZ0MWvN4TlXOxfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789302138; c=relaxed/simple;
	bh=UKrl6ETCMoYIAAbRVjmItt0FuiqNklaVkh0QEnYS8WA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W0eZxN0Nft9O269PerHhMnc68fpp4eiRAaWCx/89uF1PSBMklYZGwtoXQVQ4xPfdIzR9iDo2ZnlF85FgngegKDe3ICo9IGBRFiEJZzQKChwh55RL5ZGpgHGWMfeb/2jUtcfuLijYB5/vS6C97a/WvECZc6+VqniSSC8GuujGCXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W/CmYSso; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W/CmYSso"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789302136; x=1820838136;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UKrl6ETCMoYIAAbRVjmItt0FuiqNklaVkh0QEnYS8WA=;
  b=W/CmYSsovlMeznu2JYRSyWTvzv/Pn8CqJhdUBBiA96SR2aBAW+jURNTZ
   UfOpgMDyoSwWyk52kMauZu8p1h/9Bns8qrYTnhCfC5IpPF5sl10Vecqna
   A/hPeeaxfW71hDzovJ5a18yKgQ08Eqx+IWeS9Mv+nPfL5U5meIB67gxes
   tjddZJIQB9hIKc2nFZbeCuJH71kDhXOxhhZn95KRG6ZeYG1jINturAgyt
   AVRVsORBWoQzeaJ922pY8TdW1Wbo1Hczeq5V2mshpCwS8cbxfddH+gnKh
   xJSyTnKxOKBU1UHGt1PF7yy9ey42E47r4nBD8z85Bh80zMD3m18TYrjta
   A==;
X-CSE-ConnectionGUID: oRqcQhQKQFigeVAMImxjhg==
X-CSE-MsgGUID: IuYi2vIwRKeLrg4cpl6I2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11903"; a="89565064"
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="89565064"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 05:22:15 -0700
X-CSE-ConnectionGUID: vINJYeDBT6ed3w4WbmoyBw==
X-CSE-MsgGUID: oIXpSorBRlm5bmF3suGhkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,100,1787036400"; 
   d="scan'208";a="791393"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2026 05:22:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 05:22:15 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 13 Sep 2026 05:22:15 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.29)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 13 Sep 2026 05:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4SdyRAd8iBco27xjmYLPvjd9tfMENZh4TWTS3j57J0q2oh9K+tCwKFvesEIQSH7AMJ3Lv4ojodizJNxWBjvxp0oh78sVeG8mEXzQ1Tq3sp4lbhAkSAkAfxdFdU5MaUWpZDd/S/tMBhCmUENwKPp/WP02P+qJkF2GhvqbzdmdDW9/ldCpBszsJYdCxBKqxkOSjcXTRAMgAAUAUpV4o6PEJXABnXiph57lf6ykoiojBvj4qF+7VuwDHvNrWVED9FJvRL6vuoNbB+Q9CrKl+ehcBTBmZcG7F1ynNqeTxA7/G7m5Qrxoz5R6vglOX048pftppcioeq7TtyDe68yYZxjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5e7qRCJKttEp1Nx18JWQnQVi0nZ7yM6/pCktr0mitk=;
 b=nY4MzAvjbHE1+y+jcqTLztN4ShGw3S5Tu/IISP1/as6q/TOtmYd8voOwoOj48zM8ljpEQ0Y5OzjJ0XpPDa33ZQakkv7RV7tRRepCXGviEwYLv22NvWtnk9nRYiUr77jnf4wiS/uNzhrbfKg/H8n5msrWDSUWyvLKlS+1LMVyjgLztpXM/BT6fqaq+PmpSwcoASj3LXZIhakQMq93i0WLikQy29RVR8KE+PlEzx2nLXMVSdy6biBFCQjc75FZXtLJGgNAk838ZatVaLu6IG6IBoW576bVmuUmK2Y1PwWi3tEYZpqIxDGZrXZ0nVyX9huwgK23tvqW70N5Dupf/6Ef8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by SJ2PR11MB7427.namprd11.prod.outlook.com (2603:10b6:a03:4c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sun, 13 Sep
 2026 12:22:12 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%7]) with mapi id 15.21.0406.007; Sun, 13 Sep 2026
 12:22:12 +0000
Message-ID: <6b6b050e-0a38-4c17-b04f-84d558a36923@intel.com>
Date: Sun, 13 Sep 2026 05:22:05 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/i915/gsc: Validate the CPD entry offset before
 manifest read
To: "Narvaez, Jesus" <jesus.narvaez@intel.com>,
	<intel-gfx@lists.freedesktop.org>
CC: Martin Hodo <martin.hodo@intel.com>, Alan Previn
	<alan.previn.teres.alexis@intel.com>, <stable@vger.kernel.org>
References: <20260807192301.3009387-3-jesus.narvaez@intel.com>
 <20260807192301.3009387-4-jesus.narvaez@intel.com>
 <2b53deee-6c11-4375-9650-4482854412f9@intel.com>
 <7e0a5a55-e44d-4af2-ab17-4c1292cceb73@intel.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <7e0a5a55-e44d-4af2-ab17-4c1292cceb73@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|SJ2PR11MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dbd04a7-8136-4754-6400-08df1191a363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: arXgXoQ0JuwjrIJojYx7Dw4rLrmuEfMLShh+H+QUk12GMEsnE82AWLE1WeL7A+yjdQPcPpsProdRzxhKgdG1948SGpM8LPHvikkO6nyBxVvcEOco5/ICZQ4dHAWNyFOSH80u+ca+2lhSx16yE/uePNS1AtBq8XAZoCrbxA/8RsCCWTyzPwPSte91H6zY8w2iTnhqc67ZLf0UuYDUygRxlJ89zXatYoYGwbbdSs/juJwUUIN5tXM3Fp+8cQVuexbyfHkuGHYWnDWjInv9oE4bg3l0jWjlUlfrTeAGW/HbW/ZFZCX4elDHufeBp3cJnQGSSf2YX031F4+UeLJNanY3TLXXBSAj4sAemFuVCBofkSYtdKlWX8M2bcMqyYaFZmFnGHljppsJBz0XHBo37nBrzUXjA7tk+gV2qsACU42J1Az6RuXQyKVF2it7OJy1L3T/g+UbLdyuV9sIBkuV0MMSOc6OG4mDjgVSbXdGzMTYAtAauWHfBdxtdnShKfAS4JaqzUycMlhB8X7G5HCoPBC0lxz2RHQOlt5j4r04V0PeyGdAPtoKVArX1TuG8cu+Sb2mBUs1TKyDTPEobxBxXgXJBIjvfqmg5ykgYzHpbPVZFkXVkhriDSflv2zuXru4cUjF2XU8oce9Nz7XOs2y/xLNTBS2fl3l54uppYPCqScWQXQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4979.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5oclBPaFBBT1ZPNEl1bFg3QzdRYlNvQmN6dzB1dHBzK1pVbUFhcGgySHR6?=
 =?utf-8?B?bkNWSUttYkJCVDNQRjVpY05MZmtFdDQ3ek1jdW1zdHZRaWpqVU5acnoyS3dY?=
 =?utf-8?B?YTF6N3hSOG0vb2hmc09kRXc0NmYyMXYvWThCMjZNdlBvZUE2NWQ5SGJvYkRP?=
 =?utf-8?B?R1NPeUtlWXNJVE94ejIyRGFSY05IMkpmRG1mWlJrZTd5Y1ljdEk1Ujl5VlVm?=
 =?utf-8?B?NnFoaVVsUG5UUkNiY3RtWUtFaTVuZEM0QzlDR3ozd1p1aUdSaFhtdmlzamtz?=
 =?utf-8?B?UXQreFRCaGtIRFAzY3p1Z2krQXl1Yzc4RUhnT2h6eVUzbndrRk5jV1dSdUhK?=
 =?utf-8?B?Y0VRWkZrMHRndTFrM1VzSkpOTC9tbFpuQnB4Ylc0QVlqUTNVdFAvdTVjUHRl?=
 =?utf-8?B?b1ZZcGh3dWw4dUU1SGFnTktGbHlTR21US09JY09HZEgxM01kaWQvcjlKMHdD?=
 =?utf-8?B?dFlMMDNhSW8wMklnOU5YNHcxem1CQUlEU0tmbUtsOVNjL0gvYmhZcGFCbGxk?=
 =?utf-8?B?aTRXSzh1UEY1elo4VlBhWnlSVE9OWWhYTm01aDhidUQ2Y3dYRUV0VTdFWFlC?=
 =?utf-8?B?VEI3amhhVnBuYXpLNWVwREwxZDZQUHdqTC9zcnVuVTdyQmMwL2tpYmZvMFEz?=
 =?utf-8?B?aDFmSWRnZFJZdzdjSjc3QzlybGtNemZNOWdtWG56SnQwYnYxWGo5WXRoeFdt?=
 =?utf-8?B?Y1BYQzZuaXZEa0FPMFBKbllEYjQwWElPL3gwZTU4ZzdDWFc2VkUvb09vR3V3?=
 =?utf-8?B?aGJYRkhBTktCUE9ocTRwMk11WXhtQlVvalBMY2VDc3FPS1lhVG9qMitkTUpU?=
 =?utf-8?B?c3MxTVNrUnBVemE3MURxdlhQTHVUbnNYaWEvbzZDb0lYQzdkbngvMllLcXFW?=
 =?utf-8?B?TkRmSFpqWi9JVTYzZVE4SEtRSS9kVHNwb1BsNEZBYWNmdXBrYWtvcjdKWTFG?=
 =?utf-8?B?U2psMnVHa2JSSXo0dzRzMFFGaXNSTlM1RldSOHFFY1BYTmxtTmdITlRXYUY2?=
 =?utf-8?B?TjZtMjZSeGtjMXJORzV6YUR5dUQ3SFhMNmJXcjA3ci9IdTJKR3VhS1VreTlP?=
 =?utf-8?B?OWRHVkJJUUhpUU1EeWdNNjAxOU1UWkZXV3pyeFVWZlpmT1dEU2tPdU9MaWNL?=
 =?utf-8?B?RGJKZlM5STNrVkdGcnZYNCt1NEtXVElyU1YrZWg3Rm5seWh0aUZxR1ZTWjdw?=
 =?utf-8?B?Z2ptcnR3eE9LMVphampjR0FEVFFEOXh6TVZCOGR5VVRobjZqQkZmamxyTGx2?=
 =?utf-8?B?eENQNXZHY1h2M0hyTkVRUDlIaDZIbDN5VUNKODJLQjZFMWxZbUZiODFzU01J?=
 =?utf-8?B?SlVsQmNvY0FOdFFHMm5xcVpVeVZVOE1EczBwZTNxT3JGeUp6QjdoaTgvMDhr?=
 =?utf-8?B?ckNjTGtDY21LRTNkWlNva0xOZHgyTi9MYm11TXcvNm9rUUtMQmVMZXR4K0R0?=
 =?utf-8?B?dU9WOFZDWm5Fb3BJUHdCMi9JS3RrWGc4Y3hGcVpNMlVEUnQwcnFCUExIbjI0?=
 =?utf-8?B?RlhzK0crVm9oamJNekFUWWcrK005ckJOdWdpMExubjkwMkJVeWpJRE1nY21B?=
 =?utf-8?B?Y0g4TVovNEM1dHVFMkdoSkxXUDZ0NkNwOVVzVG91UWx4VEVSTVNRQk50cHZE?=
 =?utf-8?B?RHBHNkcxdzFkYVFyZmwrVnRuM1prSTdsRWdCd1Y1b2s1RGY2bHUwREU4eC81?=
 =?utf-8?B?M00ycUdWTzV3SDhtdldMZHZPby8va0tLc1lwVXJGNXozaFpFTVRwRzhnMkhT?=
 =?utf-8?B?V1VNTzNuWG40T3dqbHVTbXFJYVgwR1lLallBNzR6aHN3K2RhK2Q0WEhCZnJV?=
 =?utf-8?B?a3hGYThzQWtLYm5WZ2F4bzhhOTJmKy9iOXFDRzNGSGQ3SXM4bzFSeGpEang2?=
 =?utf-8?B?b1NFWnhldXBKUVBsdXJla25GblFMR1gyT2NQc0doRTNDNklJK21KWDJwOXZt?=
 =?utf-8?B?RFQ5LzBFODgwZWFmOW8zNlJ2L0tLYlRXVWdDZTQvM3E2VzlyeDJSWkRUczJp?=
 =?utf-8?B?RWl1K1c1cVlZSjFlRnBPUUhvK0xHUkVFa1VGWXhMNU9sL1hTa3JINnp3MHAz?=
 =?utf-8?B?cElLU3dhR3l6eDhadVRlaStqcVRIWGlnei9qQkxLV1lmTlFkWHhYTFM2dnJN?=
 =?utf-8?B?VERVWXZ1TTJPTkFzdEhtMm9oUTZ5dFJiNDcxOUM4OTFRem9aZlB1UGpNK2h1?=
 =?utf-8?B?dnJjc3JOUy8zUTAxUGZWSURaL0RSam9CQ3gxQlcrYm5vMmY5T0UzOGU3cm54?=
 =?utf-8?B?bDVuMEFYS2tITUpBcEs0SkRScTFvdFZjV2c3UnNvbC8yUnJJMktCS2twTEVT?=
 =?utf-8?B?aXZ5aDhsNGZlcTgzZ2xlWHpqM3MrYS9FR1d2VGkvcm0yV3lybHRHVVR3K1dp?=
 =?utf-8?Q?FiOP1ZPz2QbGIYe4=3D?=
X-Exchange-RoutingPolicyChecked: Nca2pA968kMG9W8ZBkfeN79J++mVyhzVQDQURxjZtFTBSFuhhWITQJX5DFzRtcg0n3kn3S/0f/mOP23af3vlVsPMlrBRTN3wSCde3JJBLGsP4+NlsEiVuGo7QwBxIYKtZxpScSjm7d6ARNGlOvg3D35ai5KbxPwTQjWWuf0aB51YhWL827Oqhw8EnoGhN4nctCY6s3L3kdPwXHVXLlVZ8mRSgHBs0jtvwBI54U9KhbVMVmGylYyTbGMc0nNajXuKe+4VTEzKLho7LmavVKQhQ486Ap3rgFkJ4k/zRUqa0SXFV3aeuibc58+dzm0oQW/wL2/7Cugt6/q3dwkacaNBxA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbd04a7-8136-4754-6400-08df1191a363
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 12:22:12.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWY8/31xlcnmSANmAk150sowg8mSatGJxd7gesTrrmEQGVFp/ZLCLM0Z9pyPsHQuyhq+v9zu15JGNHd+gbg+pbdCzpaH03JjR64+ISl3Z7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7427
X-OriginatorOrg: intel.com



On 9/11/2026 8:53 AM, Narvaez, Jesus wrote:
>
> On 8/24/2026 7:28 PM, Daniele Ceraolo Spurio wrote:
>>
>>
>> On 8/7/2026 12:23 PM, Jesus Narvaez wrote:
>>> The CPD manifest offset was dereferenced without checking the bounds
>>> first. Therefore, ensure the offset doesn't point into the CPD header
>>> or past the bounds of the FW blob before reading the GSC manifest.
>>>
>>> Also, validate CPD header length before using it to size the CPD
>>> entry table, and cast the boot1 partition's offset and size to size_t
>>> to avoid an integer overflow.
>>>
>>> Discovered using AI-assisted static analysis confirmed by Intel Product
>>> Security.
>>>
>>> Reported-by: Martin Hodo <martin.hodo@intel.com>
>>> Fixes: 56fafa569764 ("drm/i915/mtl/gsc: extract release and security 
>>> versions from the gsc binary")
>>> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
>>> Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.6+
>>> Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
>>> ---
>>>   drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c | 27 
>>> ++++++++++++++++++++---
>>>   1 file changed, 24 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c 
>>> b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>>> index d550eb6edfb8..1b9976869c46 100644
>>> --- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>>> +++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
>>> @@ -139,7 +139,7 @@ int intel_gsc_fw_get_binary_info(struct 
>>> intel_uc_fw *gsc_fw, const void *data, s
>>>        * --------------------------------------------------
>>>        */
>>>   -    min_size = layout->boot1.offset + layout->boot1.size;
>>> +    min_size = (size_t)layout->boot1.offset + layout->boot1.size;
>>>       if (size < min_size) {
>>>           gt_err(gt, "GSC FW too small for boot section! %zu < %zu\n",
>>>                  size, min_size);
>>> @@ -195,7 +195,14 @@ int intel_gsc_fw_get_binary_info(struct 
>>> intel_uc_fw *gsc_fw, const void *data, s
>>>           return -EINVAL;
>>>       }
>>>   -    min_size += sizeof(*cpd_entry) * cpd_header->num_of_entries;
>>> +    if (cpd_header->header_length < sizeof(struct 
>>> intel_gsc_cpd_header_v2)) {
>>> +        gt_err(gt, "invalid CPD header length in GSC bin: %u < 
>>> %zu!\n",
>>> +               cpd_header->header_length, sizeof(*cpd_header));
>>> +        return -EINVAL;
>>> +    }
>>
>> I think this check should be a few lines higher, where we assign the 
>> cpd_header pointer. That way you can also switch the min_size 
>> assignment there to use cpd_header->header_length and leave the one 
>> here untouched.
> I'm not sure I fully understand what you're saying here. Are you 
> saying to move this cpd_header->header_length check to right after the 
> cpd_header pointer is assigned, and then update min_size after that to 
> also use cpd_header->header_length instead of sizeof(*cpd_header)? If 
> so, my understanding is that we haven't validated cpd_header at that 
> point, and we'd be reading cpd_header->header_length as part of the 
> check before we know it's safe, so I think it would be best to leave 
> it where it is.

I was thinking of moving the whole cpd validation inside the loop that 
finds the cpd, but I explained it badly. It is also probably a bit 
overkill, so consider it optional.

Daniele

>>
>>> +
>>> +    min_size = bpdt_entry->sub_partition_offset + 
>>> cpd_header->header_length +
>>> +           sizeof(*cpd_entry) * cpd_header->num_of_entries;
>>>       if (layout->boot1.size < min_size) {
>>>           gt_err(gt, "GSC FW boot section too small for CPD entries: 
>>> %u < %zu\n",
>>>                  layout->boot1.size, min_size);
>>> @@ -205,7 +212,21 @@ int intel_gsc_fw_get_binary_info(struct 
>>> intel_uc_fw *gsc_fw, const void *data, s
>>>       cpd_entry = (void *)cpd_header + cpd_header->header_length;
>>>       for (i = 0; i < cpd_header->num_of_entries; i++, cpd_entry++) {
>>>           if (strcmp(cpd_entry->name, "RBEP.man") == 0) {
>>> -            manifest = (void *)cpd_header + 
>>> cpd_entry_offset(cpd_entry);
>>> +            u32 man_off = cpd_entry_offset(cpd_entry);
>>> +
>>> +            if (man_off < cpd_header->header_length) {
>>> +                gt_err(gt, "GSC FW manifest offset points into CPD 
>>> header: %u < %u\n",
>>> +                       man_off, cpd_header->header_length);
>>> +                return -EINVAL;
>>> +            }
>>
>> I don't think this check is valuable. The offset could point to a lot 
>> of different invalid places and we can't check them all, we just need 
>> to make sure it points inside the binary. If the binary is malformed 
>> it will fail to load so we'll catch the error then.
> Makes sense, will remove.
>>
>>> +
>>> +            if (man_off + sizeof(struct intel_gsc_manifest_header) >
>>> +                layout->boot1.size - 
>>> bpdt_entry->sub_partition_offset) {
>>
>> using bpdt_entry->sub_partition_offset is kind of dodgy here because 
>> we're outside the loop where we go through all entries. If we ever 
>> need to look for a second entry then bpdt_entry might no longer point 
>> to the CDP at this point. IMO better to save it to a variable.
>> Also IMO some parenthesis would make things cleaner here.
>>
>> Daniele
>
> OK understood, I can add those changes.
>
> Jesus Narvaez
>
>>
>>> +                gt_err(gt, "GSC FW boot section too small for 
>>> manifest: %u < %zu\n",
>>> +                       layout->boot1.size, man_off + 
>>> sizeof(*manifest));
>>> +                return -ENODATA;
>>> +            }
>>> +            manifest = (void *)cpd_header + man_off;
>>> intel_uc_fw_version_from_gsc_manifest(&gsc->release,
>>>                                     manifest);
>>>               gsc->security_version = manifest->security_version;
>>

