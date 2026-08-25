Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13683218BA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787624904; cv=fail; b=XGNLc5XlV6+7OQMIJdli57j7WUrYlUiEtYaGbvlKWWRuM8dzuCejV9PaP9ee8ETWB6knvCZfj2suV3wnPTGRwwxz+W2BtmMQZA37Rp16FSqSt/RYEoi9Phtna3jwZJlteIJLRVECQYBGAN6ZmuNyrnQBabsDrWdqx6H8ppnUbOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787624904; c=relaxed/simple;
	bh=opHlU8132YTvqaKOvIgN7MpRGNyBCqwpcrmkwTdCOjU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzP5WMLxm+C8q0TwK9uKGN8Y//ag4sTnfA/IUoSl6y/gDFIVNy2/efmC0t1TuZ44fILi0DYY+k5s/R7uB1ZB1OpTENjp9blE0Luy0mvMJvDUNdRo8GQAgPJ9V+Z4Iw91ADnFK7ZhveAoG5yKdO4bu9jQuzK61mJXIJZlD5mE2Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RlEDyPtr; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RlEDyPtr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787624903; x=1819160903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=opHlU8132YTvqaKOvIgN7MpRGNyBCqwpcrmkwTdCOjU=;
  b=RlEDyPtrlRV25x3YhPkxlr52WAO0tY2QBZIK6+BMdNm/dumZC0VH3ZRu
   8KhIb4kfyQ7M9OG6qOrNr505RbrfVOSST4ChxV1UqlO8GHBEMQyoUDmKw
   HWwvq003COAM2maIBWD/IvUxA/1pN52unx0WAukRKkt2SZj3FZYMdu3pO
   YP3EatzuDbyrhe4eTBpnHgvvxoued5jM5rmMKkydRaCqJ9QkTupKFiKR0
   DzrEE9XKqvbdq7JPMUBNHxrXyepwU5x0bSIP1qmyyLMWafUA1l9V1QZgo
   PG6rcK0LANr+fQzbXSR7f5zPiuqtYi9QGsZZpQaGM8G9S3Ennwe86G1GD
   Q==;
X-CSE-ConnectionGUID: wX8OCGErT4SWItPXsNzNug==
X-CSE-MsgGUID: ZpxQYxa9R5ulS5P0CQsSWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="99250059"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="99250059"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:22 -0700
X-CSE-ConnectionGUID: YiE6StF/T7KCD/kgEtg9Jg==
X-CSE-MsgGUID: kn9Ipp9pTbSg/IdqX3PgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="269110971"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 19:28:22 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 19:28:21 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 24 Aug 2026 19:28:21 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 24 Aug 2026 19:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqBdT0J1mWrgMN4dHjtxjQuczp9rG6gm6tWhnU57GSXasckRh+qbCTqpNFXf/D/zVP0A1A3oAPnII7hfuon1eF2k3qhLHmQb86nGr3asw5jMDhSzPHe1Ohp87Tbg0PaNX+ISNxXD6PfkLG6mk/tTdNL3TnYXtAPJ4bXAlkP58RWo/nNgULBL0IU0Vo1MxetX+nzyQbjHGzvH5QXogcPGeYJI6CkxUt8EJRdKPmNxB/UBPH1CnV/bOoHLCeoNeCYpgX5jmJi0gTZm/YgXd31K9yQ+gH7/EcFUIKHJ1lgNZj5c90OGAPDxICKI6fF7du45eLXmiAeTAK/220R8NJbDyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJQRxb9utr0M3UBSp6AHh0kotdCra2ikrFGXyxJ/czw=;
 b=qTmZ/boD5T1NIAK/kDPXM2wO7RyuRm9cqhL+cJDAl/bt9kLR2HV6EzO6hJSZw/EDDFmRN1MfKOL8rVj/kZV06Uh3F1VzvyejpsPOsZQo8LiqREAzpCojZsDkVeZZ4SmQnQRxFA/c+l8NGZBOB6y+gvtivAjWV+0jla8ifzSc0E8XTLrLTLNXLAktkrgmBwfeCm2OPqtXcYlDBXhYrsJfrcM4+L09zSkyYrEyCGJtGecqwkOpVveOrbJJS4AA7uAodl/ZOh7ffpEX5oFm3kQIL3gwZh78Of5OJh6KwiJlSCWSSC7PwtVnN59E62j8nzFdbHu6anwM9zRxfjJXWlIyTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by LVWPR11MB9883.namprd11.prod.outlook.com (2603:10b6:408:3c0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 02:28:19 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%2]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 02:28:19 +0000
Message-ID: <2b53deee-6c11-4375-9650-4482854412f9@intel.com>
Date: Mon, 24 Aug 2026 19:28:18 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/i915/gsc: Validate the CPD entry offset before
 manifest read
To: Jesus Narvaez <jesus.narvaez@intel.com>, <intel-gfx@lists.freedesktop.org>
CC: Martin Hodo <martin.hodo@intel.com>, Alan Previn
	<alan.previn.teres.alexis@intel.com>, <stable@vger.kernel.org>
References: <20260807192301.3009387-3-jesus.narvaez@intel.com>
 <20260807192301.3009387-4-jesus.narvaez@intel.com>
Content-Language: en-US
From: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
In-Reply-To: <20260807192301.3009387-4-jesus.narvaez@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:a03:338::25) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|LVWPR11MB9883:EE_
X-MS-Office365-Filtering-Correlation-Id: 5abc655d-4145-4726-78b6-08df025086fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1Pj0/+8rDg88VJQC1hhgFOxTTFkBIirHXrwO6JtDRL908KNtdeXEfwgWieawS2zT2cV2eQCZauuFvD7w/Hz19eS3+fOY53jsdSREuYx50k9n7Bf7HyaIJNYHUrr9G9FbvMzPqi/KyyyT3UZfjGsFlnuZuCBIU2kMgYRr29SQXiptIa7doxPQQQIlVdZeOfCeMWhNYiUeT1GLKljMhhwWWDxvn4wGA2JuCwrKgpEPS576YuiPmEsNUqQXI7zRQ/fYMrntacPty+3X/Xn14/UjLF5qD3MXhVqVTuzAhw+7vIXwn6aQbe46UQBxFkqOVQ0QeGv4mVDHn+mYOiKDQ747gYkI4DCKCAqeHpQQogwcQn/tLgpp8/Ev0Bvi0QYULTBQDoOaDoNzRPb5g6jKNlDrTNZ18ciCZfti06MzjrRrh3rnlkPVgHMJ1m+U9ujvhSLgtiMhvcUJlRKppqOoRRpT8Yj9JYX9MMUr5EGuM5AP4iSuJrkX1TJ847hvYDQu412jvGk0i/7xpY1LnGa0HyFtdmgB1NmS7QxeIdq8Hw+uZa+PFkVygGE+xSIoHUQKG9PmLoVKCFG0vmE7D078Xk6EmYMnXTQJgCEMz5ZIJiysMCSUBAPGdFnH7sDVXz0ErMJI8BxYdubHMRF3XVqDfGrCbc0BtptfUCZrej9EXjBwP+4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4979.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjFib0U1Kyt1TlpaR1NLZE5nU1ltL3o1YURSNHMwWVRycE1BWVBVZXBmWHJN?=
 =?utf-8?B?TW5WWGEwVVRoWnE1YlQzcGtxSmZmTVA1ZUs5aXBpOHVHZms5U2F1M1hsWUph?=
 =?utf-8?B?SEJYaVVPKytBUGw1a0xVcG96YkRCZmFZNHM1a0Jyd3RrMHVVSHVkZHU2MTZl?=
 =?utf-8?B?UTlTRExwdlF4WkZDdGp0VXZNa0JndnpNc2NmaEYvaUpkOGx4ekc0OEdxZjVr?=
 =?utf-8?B?RWNTbGMrbytzai9UUEdYN3JqOVRUV0t0dU82d3NkbDJNTWpLSWRpMERJTnk2?=
 =?utf-8?B?NVBpc2QrRXdHdjBkSmJSWUJtQ3NBbWxXRm9MRlJSNDZFMkcrR2lhRUl5Q0tC?=
 =?utf-8?B?TitWaUIwWjFyMVJ1VmFvenhvcUZBK1pjQXBacnBqS0wzN1RxTVpJMGMzejUv?=
 =?utf-8?B?MWp0Q3pZVU1qQ2RqUDFBOUpINFV4VXU3Q1JZUG12NWxBM1FYNERGSDZWRk91?=
 =?utf-8?B?akpQVm9SK2k1Y3pyRDVDMVlvRG5zTzl3dmNXbXhkSVlyRmlwMjlzY2o2MlQ2?=
 =?utf-8?B?Qmhpa3VFUm5ncXZVRUFBeE9YblpqeGNjMENWWlRDNVhqSUZYcm43UkRnRWhG?=
 =?utf-8?B?dkNxOTZHQnpMbmExTjVKZGtuVEVZR2liMXd5ems0eVEzOXpFU3lVTC9STjNv?=
 =?utf-8?B?L1VPV294WDJ3V2NLSTFTOEVzY09TT3ltbWJiWFlsdmRPTTFmMXAwVExUb1JB?=
 =?utf-8?B?dlRFNVppczhGbUhGSncxZFhraXk3VFc5WHZLT3RCclIvQ0puL2J2ZzkxYk1l?=
 =?utf-8?B?Kys5UkQvTUZYdU5lbDZBTmdvZXovMWk5L0wyRHNZd1JkZDFMQUI2WlphSHJj?=
 =?utf-8?B?d3BkaWNyNVJoNjJSMEtDdlgyMzV0Z2hDT29EU3p4KzhNSlpPTy9peHJ5Z3BF?=
 =?utf-8?B?Y1N5VG1CdEc4dzkxSWlLdGJMNGdZRS9CSExiMnFHMG9qVmQ2akRkZ1d5Ym5D?=
 =?utf-8?B?Vm0weDlETFZZTFFqcDd4MklsS1VkNWpZb1l3YnVBekJjaEIyM2FIblE5Y05F?=
 =?utf-8?B?bjRmV1E1VUlPQnlZQjRuRG5mQ0lPRXcyc1ZBcE52N2xDZlBpMHA2bnAvRmJI?=
 =?utf-8?B?K081Q1ZQaUllYkl3cWQwcWwyek9wZkdYTjlUYTFkd3ZzQ0F3aHBkR2dyTjNO?=
 =?utf-8?B?LzNGZFRqNFM2WkEvMEpTTkVHUG5ZM1NZZ29jNEhleE9pRmZtSEd0V3NESHZM?=
 =?utf-8?B?R010QTlOVjlycmVDbU04YmdKUnRYRXV1MkRtRGRUWjd6ZkFRcURaQXl1VE5I?=
 =?utf-8?B?b2JaVTVMMGhqeXY0Ukw1RDhnT3FBcHFrNUIxaU03TGdyOFduSVpYYXpoNHNl?=
 =?utf-8?B?cGx0a29sUnlCUk1oUmRoOHkzeTh3Q3B0SkEwL0l6Yk9La3RMMDRJRVgvSGli?=
 =?utf-8?B?UTJxczQ0d2lLRTV1ZlA0dG9xb0c1a055dkVyWGRwSDFtT1J4N0hIa3hYY0tC?=
 =?utf-8?B?YnJLdTg2WkYzQWFWY0ZTOU5BSHJDU3EwZjE2YVJuV2pZZHNaTlVNR0hRZHcw?=
 =?utf-8?B?UTRncVFpenluQUxnWFJWdDhUWDFkNHEzcTVvTStqVHBVRldPakpINUl6Qmx5?=
 =?utf-8?B?ZlNWZTVxQVQ3SW9xOXVrdzV1Q3Q3RnR2SFpXU0JlVy9DZEswaWdXU3BETXF6?=
 =?utf-8?B?WDBSdE80TjVyYWNGVE9GOUJENTdPeVJPM2F4SXZkSFV5K2ZvUzhaTmRtK1VQ?=
 =?utf-8?B?dVkzTWJ5bDBkTlZJcGFQRVpEV2lzbWFvZER1WVM1QitCRWdGamd1Q3pqSitz?=
 =?utf-8?B?SlNyZFhMZ0tSb1BzSTJLNE5Ub2dJODFROStETTF0bVJKbk9maEZIUEhMenkv?=
 =?utf-8?B?a1pjb29zeXFBeEY5OTVxY2FzWkx0RlNnelh3L2lsQ1NCcSt6a2JVdHQvSzRt?=
 =?utf-8?B?OUl0b0ZXQXd6cTlvdkc1bE4zOTVKL3FkN21CWGUzSWFURllRRHIvNUdvNnYz?=
 =?utf-8?B?UmcwdzdRd3A4Tk42L0ZOY3lKNUtzcVRxbVlLcWJpY04vUE1QQS9XYXVQK1py?=
 =?utf-8?B?empWQ1NUSFljVUNVa0FRckdPYXVnVnowdk5QRlU3N21TTEUwWFFPNE0wRlI4?=
 =?utf-8?B?MWZ3N1pZZkxFZGIxR1RoYnJlaW5GVURJT3c0enBCU0RxU3laTEwwRnJobXVW?=
 =?utf-8?B?Zk4wbUc1R1ZBalVmck93VFlPem0wc3lLSHlhZjZ2MVJ4RkdHK05DYTNxZG9o?=
 =?utf-8?B?Z3BRUzhuMkhRazEwK3A0QXZEanhNSkdlOGxtOC8zWXBZaUg5MXVzSjJFeUZl?=
 =?utf-8?B?UVFENEJpMFBDNWduK05ucWowTzE2ZERPM2hCVXkrdEltbExlNGpqRE9Lc0tI?=
 =?utf-8?B?OFVRMnhLK3d4RG5EczNIcHNEdWVkSzE1MmJ5a0VlSmgrRWhDb1JabERvOVps?=
 =?utf-8?Q?ybhZMLXChWRj0XeA=3D?=
X-Exchange-RoutingPolicyChecked: RxPqHfRx2HmIJW7aq6S9twXfhEkzWDF1Dg5yUI5BK4vdd/4wYWWMkiBcNSp4mNTbmbnsvnCxcE7pgQd0mLZ95Ix0IdL2sSsG9DxxMu1hcSixJyQ03i3PrZ/LxKS3N0wdmto9LDgVFxRVoipjwSnpnWJb6ETk7e22EqEgf2+R7mc2WrdDhtCG7JHYtq3vb/Mn4tQBXKqQi35rY5Q91gCRfIbCkU/7vbrCeB3OpDZSwvrDZJqcnmTkUR126kzXxMnMyZ88uQSeRNokAwbTaSaPcDL754z4sU9m5W89LRT6eJAtaSPvpuffcrL6h7lKDfO3UN7DvP5PNWoxIVDQxSofrQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5abc655d-4145-4726-78b6-08df025086fa
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 02:28:19.6108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9m9NNRpGf6mpiy5Hk3IDy2HcCLd6v9UKLaFiW6PUMSiiPr1dgVkL/5QGC5LCY95ZZlwiJ0Mc+au7zdsa7Y5pc7chHaZ9rg2vDgYqASQFSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVWPR11MB9883
X-OriginatorOrg: intel.com



On 8/7/2026 12:23 PM, Jesus Narvaez wrote:
> The CPD manifest offset was dereferenced without checking the bounds
> first. Therefore, ensure the offset doesn't point into the CPD header
> or past the bounds of the FW blob before reading the GSC manifest.
>
> Also, validate CPD header length before using it to size the CPD
> entry table, and cast the boot1 partition's offset and size to size_t
> to avoid an integer overflow.
>
> Discovered using AI-assisted static analysis confirmed by Intel Product
> Security.
>
> Reported-by: Martin Hodo <martin.hodo@intel.com>
> Fixes: 56fafa569764 ("drm/i915/mtl/gsc: extract release and security versions from the gsc binary")
> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Cc: Alan Previn <alan.previn.teres.alexis@intel.com>
> Cc: <stable@vger.kernel.org> # v6.6+
> Signed-off-by: Jesus Narvaez <jesus.narvaez@intel.com>
> ---
>   drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c | 27 ++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
> index d550eb6edfb8..1b9976869c46 100644
> --- a/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
> +++ b/drivers/gpu/drm/i915/gt/uc/intel_gsc_fw.c
> @@ -139,7 +139,7 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
>   	 * --------------------------------------------------
>   	 */
>   
> -	min_size = layout->boot1.offset + layout->boot1.size;
> +	min_size = (size_t)layout->boot1.offset + layout->boot1.size;
>   	if (size < min_size) {
>   		gt_err(gt, "GSC FW too small for boot section! %zu < %zu\n",
>   		       size, min_size);
> @@ -195,7 +195,14 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
>   		return -EINVAL;
>   	}
>   
> -	min_size += sizeof(*cpd_entry) * cpd_header->num_of_entries;
> +	if (cpd_header->header_length < sizeof(struct intel_gsc_cpd_header_v2)) {
> +		gt_err(gt, "invalid CPD header length in GSC bin: %u < %zu!\n",
> +		       cpd_header->header_length, sizeof(*cpd_header));
> +		return -EINVAL;
> +	}

I think this check should be a few lines higher, where we assign the 
cpd_header pointer. That way you can also switch the min_size assignment 
there to use cpd_header->header_length and leave the one here untouched.

> +
> +	min_size = bpdt_entry->sub_partition_offset + cpd_header->header_length +
> +		   sizeof(*cpd_entry) * cpd_header->num_of_entries;
>   	if (layout->boot1.size < min_size) {
>   		gt_err(gt, "GSC FW boot section too small for CPD entries: %u < %zu\n",
>   		       layout->boot1.size, min_size);
> @@ -205,7 +212,21 @@ int intel_gsc_fw_get_binary_info(struct intel_uc_fw *gsc_fw, const void *data, s
>   	cpd_entry = (void *)cpd_header + cpd_header->header_length;
>   	for (i = 0; i < cpd_header->num_of_entries; i++, cpd_entry++) {
>   		if (strcmp(cpd_entry->name, "RBEP.man") == 0) {
> -			manifest = (void *)cpd_header + cpd_entry_offset(cpd_entry);
> +			u32 man_off = cpd_entry_offset(cpd_entry);
> +
> +			if (man_off < cpd_header->header_length) {
> +				gt_err(gt, "GSC FW manifest offset points into CPD header: %u < %u\n",
> +				       man_off, cpd_header->header_length);
> +				return -EINVAL;
> +			}

I don't think this check is valuable. The offset could point to a lot of 
different invalid places and we can't check them all, we just need to 
make sure it points inside the binary. If the binary is malformed it 
will fail to load so we'll catch the error then.

> +
> +			if (man_off + sizeof(struct intel_gsc_manifest_header) >
> +			    layout->boot1.size - bpdt_entry->sub_partition_offset) {

using bpdt_entry->sub_partition_offset is kind of dodgy here because 
we're outside the loop where we go through all entries. If we ever need 
to look for a second entry then bpdt_entry might no longer point to the 
CDP at this point. IMO better to save it to a variable.
Also IMO some parenthesis would make things cleaner here.

Daniele

> +				gt_err(gt, "GSC FW boot section too small for manifest: %u < %zu\n",
> +				       layout->boot1.size, man_off + sizeof(*manifest));
> +				return -ENODATA;
> +			}
> +			manifest = (void *)cpd_header + man_off;
>   			intel_uc_fw_version_from_gsc_manifest(&gsc->release,
>   							      manifest);
>   			gsc->security_version = manifest->security_version;

