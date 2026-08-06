Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69F3403FF
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 16:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032083; cv=fail; b=pBvJ3jTT+My5jXZeCJLnLwaDWQg76oNfUmpIhbHjKg0uTAUcjnO5f+Awt2hZXU65YPodGwx0dRJZxp6D3ItMwhcW3PoKmtn1jJ8QmGtf0klXlOstz2pcmuhesaoIQJZAX63rsD3A86th78ZsZ3dVzbxXBhTCttyYoAV3k15RR9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032083; c=relaxed/simple;
	bh=uBn6LFvPVPBsuB4qRlzEzT5xhc61HjcK45AVet6CWMU=;
	h=Message-ID:Date:Subject:From:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mAtdprndXxSrYOuuEafkHfoPf1nt2DBeHrYgnJZyJ6pNIn/4NASOvyMEEknD9yBE+W6nSxNGlpi2abEtrtnuKHugwgoOJ1QMW84jgKK8O7n8MbkCYTnZlUy+c4cmmGUudFK6wF7rX5J9x36FDKV4uN+J3BMpnLeVINhF+EOIQHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3LvPB4b; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3LvPB4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786032081; x=1817568081;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uBn6LFvPVPBsuB4qRlzEzT5xhc61HjcK45AVet6CWMU=;
  b=h3LvPB4bmIncw8rkeFYReF8c+Gq2LcTfN3IcOVQnYxCgjNUN/4ztsZ3w
   t/l7RI8iyM0Np7AgsIb3ja2TLhKf9KWLx4I9HP4NSrgor6h8uiPUBBK7z
   iSgV/TuZoCFtEqGVH/jhqYipI1w3x/ldwx8+gXALJwP0ChzbdlWCVSUH6
   TeeuR5zhJyXtemwr1F0O7wiNRQrBm9nwk8VvhGzZ+bZRI/tNY4+RLnS1e
   0WBhFzat4taA138IbkyY8/lOBrYCvwkD2y/A18VLPHxpAzn3iOr7vunk1
   WYBMLq05a80Bl3QzFipF1obJEU7xeXaUzNkx9qfKUOPhBUPnuFZ1eXpNH
   A==;
X-CSE-ConnectionGUID: 4/76gKFxRkCWh5drzQ2Mlw==
X-CSE-MsgGUID: RIbIVUOsSpGSG7lwOXg43A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="89154521"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="89154521"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:01:20 -0700
X-CSE-ConnectionGUID: w5N8xmrjRoG/2wq47KJzRg==
X-CSE-MsgGUID: CE1JYV36SUCHokRMoZ1b3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="265988073"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:01:19 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 09:01:19 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 09:01:19 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 09:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTeKCaGhhYAZlrG9Bv17Nw0MNwR6NXMltb4Tx7aubDic1I2OBfpOs1n96GXzmJzKkNYmptXXuvI/DJ9xWmxUGPsZUyAYpjHoWXetkud9ZJMzWe7JpXKB2DJ+vBFSXoSCJ6mWBQtbEgyaPV5fNdUwo/SeJPLo0P2v8I1GxBQlv4Zxhfo0tmjL55/+ToqU2XBfip9kbQquZmZyP7F4lgdOximQ9wdQDuSspXspw8CCA3u+sfeBFf5E7pWD+Kihu7N2rXIpX3oX0oDiEbuvIvCKOEc3Czv2EJX5iQTDHCOo6LfoEOBYYnuMvr4gblhJ6dKMca71O29yd0F76w+6rFy05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVeJMidxDf4kR9+qI2yhw1Oi/krxxP0U+hJZj9WliAo=;
 b=XqQVBww9FWAqWRQgGsA7XiOrx5RzsDedQ1hr//aA/p8pry9FqKdn6j/9LPAqJF1ZqH1/e2P6WeKfvTUFv9HKSWgNEai9+DoMRng99g+/TbYakeCojDsdN591KOFXNiQ++Y30zKUiRzM7rAsX8mZgqw2r52LirnfnClc8fOUXs8VZIOicu7Zxdz6WKXNWNpJzkbKQc/2c5rLx1TgVPWtw01nXBXS3jG3jRzadtkWvPTNiHtKRiw7B0NsVsobz8QqbBYLLulEiyM0EyfwlWYEAE+/LVuOEXMFGcCVcwXvD13IqblLZCB8/Mpl49wB98tNJqvyBl/UJVYI+J4Vkp+g2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 by SJ0PR11MB4880.namprd11.prod.outlook.com (2603:10b6:a03:2af::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:01:15 +0000
Received: from SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b]) by SA3PR11MB7554.namprd11.prod.outlook.com
 ([fe80::3ec0:2280:db82:d67b%5]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 16:01:15 +0000
Message-ID: <95cc059b-056e-4aa3-8431-1e497002f58d@intel.com>
Date: Thu, 6 Aug 2026 21:31:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915/display: Limit max joined dotclock on pipes
 available
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
To: Jani Nikula <jani.nikula@intel.com>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260806143738.2710312-1-jani.nikula@intel.com>
 <ca6f4f3b-9c94-4b24-a8e4-7c351e730429@intel.com>
 <788a51d6-4eca-4365-bad1-037d25f388d0@intel.com>
Content-Language: en-US
In-Reply-To: <788a51d6-4eca-4365-bad1-037d25f388d0@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::20) To SA3PR11MB7554.namprd11.prod.outlook.com
 (2603:10b6:806:315::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR11MB7554:EE_|SJ0PR11MB4880:EE_
X-MS-Office365-Filtering-Correlation-Id: e85e6110-2023-46c2-9e19-08def3d3f1d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|3023799007|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: XVaRoyY937vJ4eYYv/enVhSgsxAvTI+XQQ9GU0eiBfmEHyY6ux4lfOdiIYBKCnDCOTVC5EA0nsbB8ZNUxyddITtNEdyTSuxK4CMsNjF8jAIsB+hw2D6bz2FJzJWr9C4qiPDQ0yitxKL2M7NLpcYXmxI8yS6uKmOAr0R+Ic+smZWyD+pMYgMcQ2iQzd1tB2M5VqblBXljPdHCJZOZ5vE0cJW6NFe/cJfnN+JnQkHRCAuVOuc+gfHMQrKfqyK6F8PMbolKKsf7+J9BVPdjPxGWAIW5VwKPICHm2qh90kOOB1Cbx4jZ8BlJd9U6RioUkYD0LsAdoqoT8b4cekia5n9JpTgbrJaNeT/x+80MS3zbMu77je8G9JBAumLtrzSKxmmvdWTBPI9kLALg03GlCtV5gMqF6qhqkVXpAbZsKR40qgr6negJWK1ll5I9ykwW9Qke27/oEGTxUwfn8hCIKBe42eHi5MAsM1KvPVwJKTf+zDJ4tplsH3aUNwq92g1MEnb/wuAuJ+RIxmjEH7b4Mv2hM0SQXd6mEK3XmZRdmAItwEafFVwjegAnq/78uz75/jRwFauC2v+L4YSEydIwXPxa3vdkHCUXSGwYOzloi6aMS5h/6DFW7zbEWHvOqgP3g9iIldtMNtJq/IuMWE3FKoBTmhF6wFYxZAz4YMTRAi8qW6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB7554.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S01TOWEza2NseVRKL3lCNG9MT3hiSTZ2THlYTDFQeTFEY2dybGdSSHFoMm8z?=
 =?utf-8?B?TC9JU2UvbHQ5alYyZ0htRWZMSXp2Y3Jhb3doclkveTZVakNRNmFJOTR4emFH?=
 =?utf-8?B?WXdMclMvOUNWQVVQZ2NJZVo4MkZwZ2NiSldURjhmOUR3LzUxenNZQVc2M2th?=
 =?utf-8?B?RUJhVTB0dkxqNFNIK2UzdWdaaGdPQm11NkQ1K2pzdFFveVhVOW1ZMVZnblhP?=
 =?utf-8?B?clZJcm9jY2NzOWFvSzhBYmxxeWxoKzBkMytwN3FSeWFIRm5maVkySFVPQVIz?=
 =?utf-8?B?amJyaWd0bVhrNHhrMndTOHhiczhFQm85b0pmU3ErRnBKakZJSXBhOVFDS2h5?=
 =?utf-8?B?RlRUSE14bjl4MUp5dTFxeWpTaFYwU1pKL25RakdOU0tYK0o4SElJNmFlcDhI?=
 =?utf-8?B?TFpZSGlRN0VjT0FpaTEyVklhK00vTXdDcWFCdGJleGVZMnpEMGdDYnJxcGp4?=
 =?utf-8?B?Z0pVNGxQQkxybjJOTjdESnR4QTdGY1lUYU5uenZsZk10SDFyRkxxNDE3MWhr?=
 =?utf-8?B?SkQrZnpnWUFPOUNBUWRzUjBnODk2bkZhbUkvTWtZN1dSVkh1RkpNcU02b05I?=
 =?utf-8?B?Y2xJS0dZc3hVaFZxRDVvVGlpMlZ1OEduMFFvMU1tMWdLY1hNVitVRzAzbHRJ?=
 =?utf-8?B?ZHE1VkJOSldqQnhXUUhqOXRDZXQ5NXZLYlpyUzVYMzV1SWNMWmZYc01jYmZ4?=
 =?utf-8?B?QXNodlprYkZIbVJTNitDeURlcmMvOWtIaG10QzZwMlBHRHZqZCtoNHZGbEVF?=
 =?utf-8?B?bjRjN1lUOWtWTUtrZDVPaWU5bzFWREQvOGl3aXdrM0V1aGdOOEVxdzJLdzJz?=
 =?utf-8?B?SVZFUy90TFFreEZEMzd4WGlTZ2FHZEorNks2Yk9IODVKYnpsL2QxUk1ySzJD?=
 =?utf-8?B?cy9Rd3Q1eS9MbUdKUExScmJ6Ky9hVnBmWEo3TDI3ZGlrYlgwV1JmRTVnajFo?=
 =?utf-8?B?SzQxUVVwcnVJWXRNNnA0MnI4SWVCdm1YU0tETlV5OFBvMk9Gb3ZPdm1BQjUv?=
 =?utf-8?B?NlhvMys1Nk84OXJDVllsYXZlUFE1T1dUU2JqQ1hlK1JPUTJlZERETlc3bFFS?=
 =?utf-8?B?Y2g1WG4wMjRBN0VNNmZ4ODE5UkhFRFlOUUVmZmZ1elVwcXBzZjJXUjNHM213?=
 =?utf-8?B?cmN4MWZKMUViL3JGSVFuTkpKbHJhZGhPQ2doM2QrRVNudlpIWjl2T0dCV2l1?=
 =?utf-8?B?cnpzWnBzbjUvQVBoVEczMVdtNEpvM1M1emhQTFIwRnJZVk9reEtKeGxqaHZx?=
 =?utf-8?B?RHJiaG0xRDE0SGVTTzZRUjYyWEZjeTRaaFdqMmI5L3BUZWIzZ2FYU3lPbUcr?=
 =?utf-8?B?R0dvbUdobEJ2L1BuV3IrMjZDVnpYRFVLanoyZXFrbGsrcDFpMUNjTVgwYTFS?=
 =?utf-8?B?VzgxZTBZRzJQYXJIRDF5ZmRrS1MrRjdhaVc2di8xKzU1RmFUL0xMUEtjMUZL?=
 =?utf-8?B?ZnordmpIOHZML2lWTElrZ0w4Wm5mU3FlVGtxUVNCMkZOaExHVUZucTRhdzY1?=
 =?utf-8?B?Zmk0TUNUU1BqTDRzWW5HTGFNWXBCMndaQmlzOENFVjJkOExTejA4Ynd4WnJH?=
 =?utf-8?B?L05VeEsvbkhXZlVxQjFqaFdIRXhNcGh6UUFDcXBQUEJtTzMzcEpiMUhvZ0ph?=
 =?utf-8?B?cXdDL2JPcTYrZnVQQ3BvSC9zSVYwdHFXMklhMmxIb3d0elNiNVFGOGtqeXl5?=
 =?utf-8?B?dmZMS21RQ0tjWWRCV29kVVRHaVB5L3QzTS9xVXZhUUJrb2FEbnhLNWlnYXhR?=
 =?utf-8?B?RCtHU01kYWM2bW9FN3ZOU0E1MGZmV1BIZExubU8xaHU5ZGIzNFpwcmppV20w?=
 =?utf-8?B?L0ljTEUzVGN6MVZ0MHEvM0dPMkloU0pnTWpPV1B5dDV1M05iblk2d1pZemN3?=
 =?utf-8?B?ZE1yVGpRd3ZLMmIzcUhsKzM3SUtrRGl0VkhSb3BjdkVMWG1kUjNaY3B6MHV2?=
 =?utf-8?B?TDJHaHN2N0V2cFV4a2tXcm1zMEdmcEduVzduOFREMU1vb1llV3ArRU1lWEZu?=
 =?utf-8?B?MFo4bjNzakJGSTVKcHgrYXRURGF2MWlTU1pLNG9IS3VYWHV3cmEwQXA3RmRY?=
 =?utf-8?B?ZXJhVDVVREhZcDdxbERueGNEWU9FTGx3N1lscHl2U2dUVG5xYVdFVFk4YzVJ?=
 =?utf-8?B?ZTBPek03V0lueUU0RlBDbWpqOVBSbDZlalAyN29vTXcyWEJWaDFicE54a3J6?=
 =?utf-8?B?Z3dZN3VKT1JWN05YREl3MHM5dmxmRFoyYlUwdWJzWDg3SldVTVBwYlQreHpu?=
 =?utf-8?B?OS9Hd0JIbDZTamdiS3JsNkJHdFJCSE1QdllXeVNhTnJHVkZUeVBmRE44bTRi?=
 =?utf-8?B?TW13VzlFYlF3ZHFBa0ZQbjU1NGgzVm5lc3ArbWR0TGZKSjNWa1J3OTgxNHJ3?=
 =?utf-8?Q?zzNQZ5JxKiSrrl9w=3D?=
X-Exchange-RoutingPolicyChecked: kjG5ttnHnT0HjRtoy2d9ffx43sXn7xAc+U+xYh3gNHV9E9ppgGqlOgoGji8P5Q/jQgYiZJet+OpIa+ERrZKpOw8uen0POydTtsP3eBvFj3/PXwSLXzYZ3tCxO18wSk4arAYNztmiODWt/+b/Gp2HpgcvwW5aQirTWp8KHq8++Xr9+Kkite8FgZePIZqHXnksk/M6v7OXGmNmWJfoGb4PH6q1lxP2FSw4uUfqT8nNiKID+81Zyyi2FDZHbBtT2nW6Q3PUEWN0jqnjJiS3WH4oHSbrU08apGe3XbPvxg8sgUpXK25VnEgsXSBnu7LNdZkFE4W1FQBDEeUlBQMHWfqnxw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e85e6110-2023-46c2-9e19-08def3d3f1d6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB7554.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:01:15.7658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYgtD0qjVQvKk/WKaAHsETJOhnSYZvdOz/teOhbVp8/+ndgKGN3FMWbPEHXZqOMI4bxCQXkDpeht6GAoIImWV7sUbODpp9bJk87DAAPH9/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4880
X-OriginatorOrg: intel.com


On 8/6/2026 9:19 PM, Nautiyal, Ankit K wrote:
>
> On 8/6/2026 9:15 PM, Nautiyal, Ankit K wrote:
>>
>> On 8/6/2026 8:07 PM, Jani Nikula wrote:
>>> Multiplying the max dotclock based on joiner availability on the
>>> platform alone does not take into account the actual number of pipes
>>> (possibly with some fused) available.
>>>
>>> Limit the max joined dotclock based on the actual number of pipes
>>> available.
>>>
>>> This is still too optimistic due to other constraints on actual pipes,
>>> but it reduces some of the false hopes at mode enumeration.
>>>
>>> Fixes: f4f8f0eaaafc ("drm/i915/display: Consider ultrajoiner for 
>>> computing maxdotclock")
>>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>>> Cc: <stable@vger.kernel.org> # v6.13+
>>> Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>>> ---
>>>   drivers/gpu/drm/i915/display/intel_display.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c 
>>> b/drivers/gpu/drm/i915/display/intel_display.c
>>> index 829d7a411dcc..44c5d1dde255 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>>> @@ -8113,9 +8113,10 @@ static int max_dotclock(struct intel_display 
>>> *display)
>>>   {
>>>       int max_dotclock = display->cdclk.max_dotclk_freq;
>>>   -    if (HAS_ULTRAJOINER(display))
>>> +    if (HAS_ULTRAJOINER(display) && INTEL_NUM_PIPES(display) >= 4)
>>>           max_dotclock *= 4;
>>> -    else if (HAS_UNCOMPRESSED_JOINER(display) || 
>>> HAS_BIGJOINER(display))
>>> +    else if ((HAS_UNCOMPRESSED_JOINER(display) || 
>>> HAS_BIGJOINER(display)) &&
>>> +         INTEL_NUM_PIPES(display) >= 2)
>>
>> If fused pipes are AC or BD this will still give us 2. Perhaps should 
>> have a check for atleast 2 consecutive pipes from 
>> DISPLAY_RUNTIME_INFO(display)->pipe_mask
>
>
> ^I meant :  if fused pipes are B or D, resulting in A,C and B,D 
> respectively, as available pipes...


Correction (typo'd twice (facepalm)): I meant if the available pipes are 
non-consecutive, like {A,C} or {B,D}  the count is still 2, but 
bigjoiner needs 2 consecutive pipes.

So we should check pipe_mask for a consecutive pair.

And I should probably wrap up for the day...


>
>
>>
>> On the other hand we can have the consecutive pipe check in 
>> mode_valid() path after for_each_joiner_candidate() is called, which 
>> will check whether there exists any consecutive pair that can support 
>> joiner.
>>
>> As discussed offline, in any case, we need to fix the 
>> compute_config() path for SST and MST where we are using the 
>> for_each_joiner_candidate() to check for a given primary, there exist 
>> sufficient consecutive pipes to support the joiner candidate.
>>
>> Regards,
>>
>> Ankit
>>
>>
>>
>> Regards,
>>
>> Ankit
>>
>>>           max_dotclock *= 2;
>>>         return max_dotclock;
