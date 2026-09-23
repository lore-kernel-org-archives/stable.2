Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7408D33ADA0;
	Wed, 23 Sep 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172390; cv=fail; b=PRrHJWyVg/esZT8z2P76rnlzGCeQc351u9J0NyF5aNiuQrYw1FlUA62zVPkfzY/EEnSzNgI9b+5U9L1BAhsS1buioiYSl1jFgTBJQAAtHDjrrdZGO1ihN3cfrjBOXvKBv4+/bB2tw2Jh4E6r18/QYSgfBF316nHwqpx0iXqrSa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172390; c=relaxed/simple;
	bh=fxlnV55QTYnpnEgtE+/i5drgJdjwaCb8D12ITvSQQws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eB5xzXsrX7ZSl0yl0vwKVfrPey6yo8Vn6PNCh6iI0f84U8Efj+z1GDawG3DNJWfNamatHBmQ6yvZDHTgRD2H+RwsGXynKzFSJnb2jczsylEYrzG28LS8CnjHXMmA7Ldw+kzRzznQ4DKVTPgv8nYNbk7mVhh3oLtC2/qktwMz1ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JORLilIg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JORLilIg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790172386; x=1821708386;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fxlnV55QTYnpnEgtE+/i5drgJdjwaCb8D12ITvSQQws=;
  b=JORLilIg96Uwjy1Jkbb7wl+1TM6qEGk2EYXpfNVT3WavSc3ZbgR0Epav
   eLQqGzWmaKWdhdNDHylz6gg9M5hYDSU0k20hJ6Mn1HKMRxm0Y5+AcaCI7
   0LIZqYFg/GXg8Ss1Mq6XgkZlHwuebmxNwLZOz6jsspCrh/bNoLGBazYG+
   xgMotdhsH63csz58XF87FvzjV31TVRD0RZ8Lqlzj6A0npS4PIsTXNmAU5
   0aUb3dQm3KqpzeXM1uBhPpGLsjPrBMeTocObOPU2rm27GY7CeRO5XvbbW
   mHxR1P1ddt0yyu7IVlq9w2hqb6abE9RliHE2APGYSbFNWQqWSRWek1/R9
   Q==;
X-CSE-ConnectionGUID: AcQG9iyoTVeer0zSYDpiWA==
X-CSE-MsgGUID: PsF+vrJQRPC6xMPaR8F1Gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90987472"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90987472"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:06:21 -0700
X-CSE-ConnectionGUID: ohcwNKCpRIeAz2pKUlRolw==
X-CSE-MsgGUID: LwKr/VwKR/aKM1mPGea0OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="281696542"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 07:06:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:06:20 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 23 Sep 2026 07:06:20 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 23 Sep 2026 07:06:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp5bDYp9oej5DMkAN+iZKqU9z2UOGsBTVn5W0MypEgOOt2rV2i20Q7IafxQrxdBa1aoLuGslYQxpU+nHrMAIG4J/ToSCHGqMx3f0rExY7zgznvJPrEbqKriBVXzS0TydsMY5LZ1Ix7Wdpoth0tSp8XHLsnkT5jV3ozDz+m09B5MX3T+87puaMBFjsAkFWy2MaaiuaJVwjH6y9lEJAH9ksgsllo/nKoODoPsGdBnKo/CAdHAOxAXP526nEQzNy2swAIHZcGAKRwmAQh+8EpCSek+DU27tiZr4jzIPLB6GzicQeqCGvPonxPDDFXw3eMHVEX191MKoXY4Taq/GWx2IcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UYVJEyohIVROH30PFF00yH//qcmt9JWs7FhWJ5VRps=;
 b=cbwyg5C7W6wduUR+KMYVgjuBcMZsFgDBdxnUzgEmXBUOuqO/0ixFmTsT6H/IDobbPMZylnvct9GYGHcY10B8UjqsYMwm96bds4y2xFjHnkIsVIJyQtprrJBQNgXoDx9D0lbz5Ex8UWBCksRiuzU8n7fD7SCXC0yFuCHvRGDvHeOCTxVXvs7BPSwchpoWf9sX4HWvnndw9cfccia9hSNZVJLjISeWlm/tZZKLHunLXRL79wHqO/yz3HkitDRGm0+Nz5yDId5DB7dHKl+NNp0t8BCiFIKDBBkvhgoH2CcplUchjohJH+6xqk1Or1TNdsorRke+JmSXnj38RSDt4dOQbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13)
 by IA4PR11MB9232.namprd11.prod.outlook.com (2603:10b6:208:56e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 14:06:09 +0000
Received: from DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7]) by DS0PR11MB7215.namprd11.prod.outlook.com
 ([fe80::cba:8493:6cff:5cf7%5]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 14:06:09 +0000
Message-ID: <86cbf53f-c418-481b-96e8-de1c1c07dc37@intel.com>
Date: Wed, 23 Sep 2026 17:06:03 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-sprd: disable runtime PM on remove
To: Guangshuo Li <lgs201920130244@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
	<linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20260915161947.2479111-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: c/o Alberga Business Park,
 6 krs, Bertel Jungin Aukio 5, 02600 Espoo, Business Identity Code: 0357606 -
 4, Domiciled in Helsinki
In-Reply-To: <20260915161947.2479111-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0067.eurprd04.prod.outlook.com
 (2603:10a6:10:232::12) To DS0PR11MB7215.namprd11.prod.outlook.com
 (2603:10b6:8:13a::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7215:EE_|IA4PR11MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: f8928240-da13-4c57-3fa8-08df197bd10f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: SKtfmx6BOzIT2DlpWuxOGPNBVd+NpIFMjFK30+0f4FRifiI4IeZN8etF5zo1ELcRJBPvuT2wY+QXRI9kQmOKx+sQSKpJDGB7hjc2Mjmo4clSI/dkdy6usMh5tBktxyB5HEjKK8VP50w+etq/wAFiQrpBLn6wiBXN8K+e+reKsBeYODXr8W9HWeXAtAVWvoHZCw+zMApmiy/yV1QqHmZVn2EV0WMP40OA/2XAkxutTamVVtL88E/8zodJYF99FOaDpW4rj8LW5MOxg5ZGJdAilDD0hWGGkKuQRYA1oXC3xYTJEZv4SAbWi2L/owHACYbHoQmuzDvVJr/hUF6KJ7S12RBj81Ydj3+tBR25GcZmf7tp4pRZzqa5h17sO7M/lmlkGbmO8KXC0EWaUri+Jy2B9aWyW9mlPVocEBpLVt/hc4kShS71oR7pIAH2x5OR7e9UFrPsbhiUtsqSref/c4uAKh5raJpmABb0hrAGVlwAEUUjFD6Y4+ceUqXJavgvdQKNuWk4+dM2Sgm2jEcxtKbmgc7UdPb6Sq/euUg7NDtTLA0IgzkyP2XXMYlkLA3W7aell1udTqaRJdbYGl4/RwjclvnA9dfamYlJmFuEssQ6qtEOuP/OTZmXs2im1KW2tmS/0kduTOpZ3AYJwG5Yt2SMogtBqgBWvATbUj7L5JawG8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7215.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUx0WjRRV2lDSldveTFFa0p0MERPd3hHUHBzSzgxeFo1ZXJlMmpUUHNzYWpX?=
 =?utf-8?B?Uis3YUt2QmJ2VjRZU0RZR0pyeFc0cWY1K1JNYnhoWnBHdEhIQVI3YW5SSnUr?=
 =?utf-8?B?K2JtMHZvUTdnVlVEaG51NTA1TTZ5Rk11by8rR3dyQ0ZHdmE0MFg4TVBmdWNR?=
 =?utf-8?B?L0t0WjVrR1dlc3d4akFvcnFiSW1mbTh1anJaZGN2aTNZZm9TVkRUa3NDWkJC?=
 =?utf-8?B?a0FtVno1eTZiUlJQRFp0d0cyUVNXVkcwU0lLV2Q2anlFSnlWdXlSVHNBbE9j?=
 =?utf-8?B?SlNjYWVlRlh3WCtHRGJIUktkZGRsUkl1YmZYS3dYTGpOODBaUVhZNTZRNEJ0?=
 =?utf-8?B?VU4vc3UrVlYwaWZncnNFQ3NZWkd0M1NWS1d2UHZWNG83THRTYmlLMTUrWUZm?=
 =?utf-8?B?Tm1hSlE5RFlWYm9aR3FOd3V5dHl5MHJvZGR6TTBZSldzQXpHTUIyV3ZSdWg2?=
 =?utf-8?B?MlNza1BScXppSHVPR25OaVFDcVNVTWtBVjN3RkhoWTZRR0w1R3pJeU40dUxp?=
 =?utf-8?B?SW5zTzhNYTFIWTJYcDJRWGxUclVidlZ5elB6dm0rKytZanN0d0cwbkRHVHR4?=
 =?utf-8?B?NWVrY25BRXZpVmtlQ3NRbjVVbmVRSUNEZW16ZGViZEIyc3o3Vm9hQy94MmJo?=
 =?utf-8?B?QjkwSHZVRUZRSHNtQWg4b1NpZ1IxeGxLSGdCL1ovem4wVUVpakdUVjlaOWZh?=
 =?utf-8?B?dGxrTENGa3pLT3k3ZjhGMUNDTjlwK3RCYXBLeDVVL3dwcHdEcHdYNUpIcFow?=
 =?utf-8?B?SkdPaEpRQWxWa00wNFdqL2QycXpnZTAxT1NDck9UYkRYVmFhWDE3RW5JSUxE?=
 =?utf-8?B?VmdQKzArY05iWlZ5T3ZBakNvOTBaaVc1QlZxQUE0aEJNOHNPMUk2eGh3bWdP?=
 =?utf-8?B?dTB4ZGFWNlBjcEVja0FKcGZzZ21makJTMEpZUWpqQmw1cTNOZGxGWit0ZU02?=
 =?utf-8?B?WFZyOGc1N21rbTFHZnlGM3NqVTFQd3pvVWlhcFRpMXlpczROQis0MG9DQkZp?=
 =?utf-8?B?RU9oOWxOTVVEWGVYbGZKU2pBbG4rQlBOQi9FUmllQ0Erd3c1b2RBU3ZMUUdW?=
 =?utf-8?B?eFZHeEkzWmxlRUt6WE9FZXRLTTN6YXFOSzBYdjhuN295V29ZdHVzT21uQ21t?=
 =?utf-8?B?VVZ1Nnh1SDVOY0pjN1hpei9NaW9XcTcvUHFKRUdmZWUySHIyUjZ0aGRiVlZt?=
 =?utf-8?B?eU9DKzNSRmlPaDdwNldVaWtxR0dQY1NVVDRvaGViZ2llU1g4Y1MxZCtiSzJL?=
 =?utf-8?B?YklXT25iMWxtN2MvNDlxNHlqRjJJSUVHVFpjQUgyeDJmZmpoZkRra2pldnV5?=
 =?utf-8?B?NFZjcGtHM1VhK0gxRFBhTnJURkhUSGNmRjVNcmE3ZVE1cEZPQnZSR2VVT1FT?=
 =?utf-8?B?WTRnSm9vR0ZrdWxoTnJhUkZ5Y2tndW9CL2lYSVpXRy9sZ2crNlRWQTZkSm82?=
 =?utf-8?B?czlFeWVzMk55dCsrVzBGN3JEVG4wVFo0bGt6Y0tRVmc2cEQvdjlsbzFoMjBV?=
 =?utf-8?B?OVUvM0RCY05VRStsTmdsak5FQ3VrbTIzVU44OTJ1blA5ZTh5bGk1ZWMwTFU2?=
 =?utf-8?B?T2J1MkgvV2xNM2hrdVFiZDVmWktGSjlpTzNISDZ1OCtzOVJESDBiOElqSy9V?=
 =?utf-8?B?N0RvK1U2Tk5SMWdtQnBYMVZRMS84WmxhejNRUEFnU29EbWl5SndSMm0wL1hv?=
 =?utf-8?B?bGh0dDBpaDRjaWdjL2NzamE0QXVLSDdpUStGK3dhMmlWY1pzTHVjZTJNSExK?=
 =?utf-8?B?NHNIeWxrTHNQWVNpTWFzaWNtQTFyNjZUZER0NDArS2dQbldTYjBmcHR5QSta?=
 =?utf-8?B?RFRNVkRQNTVZcnMyMmphZUJXc0oyc0VibkdJb2pLK0N1Zmd5VjFOcnU2a3V6?=
 =?utf-8?B?eDJTb3RtQ1YyNWZmWkZsdXdtQWxBaHRFd3Y5NG9PeGJlL21SMVFlMFV1NXNy?=
 =?utf-8?B?bStFbG56SjA0Y2ZncEdNcC91OTMwMDZybzRoWE5vb1dmZjM1Y0svcWZZQXJn?=
 =?utf-8?B?djJIbnJ4cjI4UzB1MjBFWmtIUy9iYmxvK2hnRTJ5Vk9IbjZZRURSSHhxaTIy?=
 =?utf-8?B?NG9lT1A3Tnl1Y3RPeGc3YkxCZmROM3dibUdueVZ2M05kb3RGNTZ6bWQxL2hJ?=
 =?utf-8?B?dFVRN1ZxdWhERlE5QmlST0dtbGJ3QnBKQTYzSzFoTWVmWEtkcnd6NjJoZmhT?=
 =?utf-8?B?em84bFQ0cEdacmFtSlJ2OE1yVnVsVnlOcnY4ME1uM3F5aHkybStBZkVEMXcz?=
 =?utf-8?B?NFphZ2dQQ3dzV2J1ZTFVcHlOL2VXTmcrSUkxRmc5a3RYQURkd1R1cmVFYmx3?=
 =?utf-8?B?eHhuQlVsT3BpT0o4eGpncjlLblI0THV4bDd2MDN4WU12aStPZ0lJV2V6dm9K?=
 =?utf-8?Q?8IbRV1JF0Lh2XgLM=3D?=
X-Exchange-RoutingPolicyChecked: jFpFWZK/7dkdtL9VWBB3A0VDKtGYQ8rjg7qNGfdu5/anBzApZbCF18YI3ZI0zxwzKMOrCejeAy/rW4ZiL/hXSDIGXT/yXwA19JtXz5p3yDSDI19nXwHqguWWlSzFoVU1crux6AGcijx0G6aJlYhpmHhsNnErDGhR+4GMjs5h8zkyy+Bae1eI/Ev7ohHpfjMWMZ6wicIP/ruJx9w87pWHb+fNvw9mSETjod4WyAFNW6ausFrd4uLoLSzs1K6QBi7Mj74B85b5ToEuDrTOv0/1cVTOYX5XezO8e2TfP66A17BbM5r2AtMKSJt44gzLd8n5DECluaKG315aAYYLpAMCtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f8928240-da13-4c57-3fa8-08df197bd10f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7215.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 14:06:09.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XoVavrRXcAZ+I30QXusyGVZTW8CQePD1YIWvJwoSxUnYX3qnQ3yElf3ObzF/1QaivkGrqfoggEu234/WuVCDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9232
X-OriginatorOrg: intel.com

On 15/09/2026 19:19, Guangshuo Li wrote:
> sdhci_sprd_probe() enables runtime PM, while sdhci_sprd_remove() does
> not perform the corresponding runtime PM cleanup.
> 
> The probe failure path disables runtime PM before disabling the clocks,
> but the normal remove path directly disables clocks that are also
> managed by the runtime PM callbacks. If the device is runtime
> suspended, those clocks may already be disabled.
> 
> Resume the device before removal, disable runtime PM and drop the
> temporary runtime PM reference before disabling the clocks.
> 
> This issue was found by manual code inspection.
> 
> Fixes: fb8bd90f83c4 ("mmc: sdhci-sprd: Add Spreadtrum's initial host controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-sprd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 3584a2b314a9..0c8f389fe584 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -890,6 +890,10 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
>  	struct sdhci_host *host = platform_get_drvdata(pdev);
>  	struct sdhci_sprd_host *sprd_host = TO_SPRD_HOST(host);
>  
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +
>  	sdhci_remove_host(host, 0);
>  
>  	clk_disable_unprepare(sprd_host->clk_sdio);

