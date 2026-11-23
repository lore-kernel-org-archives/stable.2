Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461684;
	b=WEyI4IXAoyKE3tkblJXCHkoVP1C+smiitt3m38J/1vknBwBjSF2WHnLkmxjD0hTSE717
	 cTAKDbLLX8JaJ6SL2KmX1pz2mO6oQI64PvDgS4Nn7u5Ji0S6cajaQ0G8HOodOAP5VdrGh
	 33tGGYwIYHLfNg0Bbtl/UKsKGUoMN1786p+uCRVmcCK4GpCVbxPoEQve2Y3tpCL+l5ohv
	 ZlwbOjAleYbAPWucuGz6RzqhejitN8Ehj4J2wGJTY13fPI9UKgoNspkSWy/RfRlouDAxj
	 ZVCa2FY4v8dJWq9WR/fTFHV01WZaOA8AVRtTsDJtO9zanD3+nEPND3LGeALSPBz69lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461684;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
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
	bh=h5nORR2uGxxqV1iPr3cmsdCnEOujccbZNvNXNDc7JkY=;
	b=cnYuHJEyE5eZn5SU2XnELijc97xZEyOrHd2BKdFzwmBe/l9pU+f8o+kjGx6dnPcbNAuQ
	 xMKVg29yUCSsMCsoRH8poR2F/wD8xuAhnlBtAV69YCGYCc7cPF86V2+guDX9u4Dhr4DgZ
	 3bsPFMLjUSotzyDjkM02vqOMIu+7f85+G8hYXnlte5gRyu2cDXnSiwOHSysZOmvoc2g31
	 p4B5EZTyWxqiw0auo/4f6aEseAdNH7sJte/whhcXQXy4Ldnfky7gXbQ7birtRJtRIRZxj
	 ybpcTeHmZC16C4LXYXWsKFaEEOC+DEj5SAeVUFdwdIFL939uib5qNr1ms2IosEX6b9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IrQKGNOJ;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q3KW2QPd;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CED606A31F;
	Mon, 23 Nov 2026 19:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95CED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IrQKGNOJ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Q3KW2QPd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795461683; x=1826997683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BeisGRgBdMMima5hibcA1gW3OOp9xgV8X8Q5WvNXWwk=;
  b=IrQKGNOJ37L53zBuuprgZM/d2iVWVzLmqHh/HZIP1HVH+LwWMxF2keDH
   hsEA/i5fowp6QjSHoBnOQiecv4c0Atev494IqFTXXQ7qu7phjbJHmCc8X
   xex2MGyUxQISJb3m51HHTwZ8wgDIoeGIrABdPeYc7Za/RA0618nRITXIq
   CtE68YH5BsA9u7lZt5CChydgs0pGS4fm23S6iqDnhF+EbgIuTyK5V8i1A
   u2DjTZLkzZmGtQf6jvsA5BShP3NC3LtBuYi4O/UacedW5NYLnY89tmqcI
   Z+Q6x16HgmtlIgGhklj+nHoR3h9JA7bdGHADpiSftFg9G8kvyVR+hjjrF
   A==;
X-CSE-ConnectionGUID: eknj4wVdRUqCrhWFIGYnKQ==
X-CSE-MsgGUID: 21286OZNTGe1hNzxTcsBWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4309822"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4309822"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:21:22 -0800
X-CSE-ConnectionGUID: T7yFGAbOSWiR0GCrXxUDwQ==
X-CSE-MsgGUID: h4JwevoEQjufgEoIm+K0sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11455200"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 11:21:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 11:21:21 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 11:21:21 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 11:21:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5nORR2uGxxqV1iPr3cmsdCnEOujccbZNvNXNDc7JkY=;
 b=Q3KW2QPdYSQake1TpkNwRZ1oB5AkwfmKrG/DJq6/6Mvm7EMoJs5SJTqw9RqYDDZ6TzcMlkWmeIDEWZy//TZR+FexGqlfq8Dd1Onm/a1GBL4QjIpAVbNNnByVZrBzFxWW17ysd+bKlcivbooYzZzhsj/TNGUF6aGdumRVGu1ic+k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com (2603:10b6:a03:56e::20)
 by LV2PR11MB5999.namprd11.prod.outlook.com (2603:10b6:408:17d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 19:20:15 +0000
Received: from SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c]) by SJ2PR11MB8451.namprd11.prod.outlook.com
 ([fe80::7d5f:b2ba:92d4:5f3c%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 19:20:15 +0000
Message-ID: <e5f2fb8e-1129-41d0-b627-6d96b81899f8@intel.com>
Date: Mon, 23 Nov 2026 11:20:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] r8169: clear RxOverflow before unmasking
 interrupts
To: Jure Rebernik <jure.rebernik@luxonis.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, <nic_swsd@realtek.com>, <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Sunil Goutham
	<sgoutham@marvell.com>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261121073652.410916-1-jure.rebernik@luxonis.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20261121073652.410916-1-jure.rebernik@luxonis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To SJ2PR11MB8451.namprd11.prod.outlook.com
 (2603:10b6:a03:56e::20)
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB8451:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bba298-6c5f-4364-fa5e-08df4996cd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003|10067099003|261021135927099003|5023799004|11063799006|56012099006|8126099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Z8UnaRQG7J3KdcD+Bemsctk3JLQRK1zQGsmB1wSmWf84XWPjjJeEUBJ/qsUYkwuXStm0mXbhuv6Rov/SUOFjN2iQ8vOVkznslYIc3c9P19m9w9/NOS9cw9YQ01TbOTokmo3QPHPguHilFecnK0VtXNjRvAMivvRba+n0TS9JLdUtwrRY8c32QlI4aViIy140w1TAAEeg+PkzHq4Qzj5AGb4GDSvCGeefhUdSSD1YoE20mfPiWFhRdb9vq60YOV9fpBSCItbDOmsBs61eoxpqMTf0fy+K+XhpH5UFUrwYU9KAehMB9dULmmsGYnEghiMjPA1+dbblH2JijHl91djZWBMrmUyH/GUrMavayQzQBepJQniKMJCYZNVo3nVk5cK03OGFvKaLhLCwgqL0N4HDQIjrfcDiRbQWa02djO3vcKakWuebhh2hXWT4CNDR+J2PBuHWShBE/05xv73ZstPOypNi8uaKlg1k+Z4YcMYlQtXkgqdLsjS1x765L8IDV/4MTC6k+BQFElS83mV74gOLlpOV81046lDuYSd4jjicrNtUXsS2MUNf94/ul09R+gXdSYU1Tft9oO2ANQTKHN27yKuoqcxJykBc+OVxv821Wbf79CFGR52wFwat2slaDLEL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003)(10067099003)(261021135927099003)(5023799004)(11063799006)(56012099006)(8126099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHVLMjFDS1JCS0lsMHMvaElNdk1KcnNIeGVzWnprMG9sVTMvWWRySFpmY3cv?=
 =?utf-8?B?R1VhQkQ3S0N1czl3a3JWUTg2NW5EbW5BRUdqQUdHVXZZSWp5MUJISFV1V2FK?=
 =?utf-8?B?czBLQm92UHhJdTRlREgxZlhlWGc0MVVKeVk2cTBBRGhHWXU1SEhMZEh0OXRJ?=
 =?utf-8?B?YkZac0RPcHBicEsrTis3aHc1TEwySDFjL1VkcjByU09mZ1pESGE0TGtnMG5B?=
 =?utf-8?B?WFo1blNzYThpbzZZY1liZU5KMXFOQlpwekk5OTBlRlR6WkRRcE5PNXhWbWdY?=
 =?utf-8?B?ekhyK0V5UW9yR0ZWVGxqMjVrd3hQWGRFdlNaditadFljQ05VR3VERnpqcHBK?=
 =?utf-8?B?THIwejNsdVg5QnVVUm5yVndzRUtKWWhOYzhRY1RTN0VFVG9hNEErSE40NnM2?=
 =?utf-8?B?TWFOUkRMaWsxcGhGZGo5NGh6RmE3VmZBUnk0ZU82VkprSTIxc1JJRUNUTjZF?=
 =?utf-8?B?K0l0QnlrVmZQVlJGTGdPNHBNSjZpZisyZHRNUnhiL1dSZThBMDAvaG10OGtJ?=
 =?utf-8?B?cnAzcjJ2UDJxUGZJMy9hR1VQVlFkVmpMU0xtTFAxWnJ2cGw5UXJMaEJZL2lK?=
 =?utf-8?B?OVpuNkhsZlpaZE16TkpWWm5Pd3A2VEQ2MVc5cVRNbkZwLzhHRlhBT3p2WFc1?=
 =?utf-8?B?U05VVVBqb2JxSlZHanFQNDE4SEdSV3RRZWNjL0hKU3R0Q0hZazdmbDNsT3lG?=
 =?utf-8?B?MjZ4cVpXUkF0RTFvVjM2KzV0cXZUd2JzUmZDblFVUkpNYmJtTWM0RVlodk4v?=
 =?utf-8?B?RnVsd2JCeXphSVNPOWVGa0tVTWE4RFhRckhNaHlKSGEzSTdvMnlXUjdyVi9S?=
 =?utf-8?B?b05vQW4venp0bHpMZ2w1TXorcG9SWEszNUgwS1pLTWVXZkM1UWZxVmdIcVBH?=
 =?utf-8?B?NFlLTTl4WUlDaGFHdUM4Z1ZzN0xjbHNGMFJoWDZHYTkybGpVcTRoOW03NHNZ?=
 =?utf-8?B?V1FmOWJ6UTlJeXdnVUprQ0FxSHpua0xmMVdzSlJ2eWlsTGlkaEZYeDcxL1ZB?=
 =?utf-8?B?d0VqWFpJajl6NmJKRUdVQWNHMnhTc1gzcDVaTjJZVkdVWThKTGM1REN6Z2hF?=
 =?utf-8?B?MzJlbHY0TVRDeFRQc3ZOdVV2b1lJZU1rWWR3TEMvUXFPUHM0Sy9nT3JCRmt0?=
 =?utf-8?B?N20yeGJySVV5Uk81ODA5N0laNWlwZXNiWWpDVVA3ZDZyN29Ydm9SVEZaNVo5?=
 =?utf-8?B?Z3M0TmJqZ2U3djBOdlI3VlNZdkI5L3k0b3pLNS9WY2w4UkJUTmNKZGR1WDJW?=
 =?utf-8?B?QUtIZHpRNXV0aDRyWkJwbC82N285UnIyQmJEclZIYTd5STZuZitadnlVNDBr?=
 =?utf-8?B?cDk5Y2lha0pYOGp0dm5ibGs0WVR6OTVUMEhscm1nRDZuUm85aHRFSzQ5SzZ6?=
 =?utf-8?B?Um9YQ0VFelNYVUpoRmpXb0FxaFdZN1dseGVTNVgrbHJMbkJaS3M4b3B5U3hS?=
 =?utf-8?B?ZkFMNWN0MUhOMGhDZlk5VGZzZm0zbHdqV0krOEFpOHQwNXo5KzJrMFRGS01G?=
 =?utf-8?B?UHZUMERpY0ZUZStiNk1uT3JMMEZkZkxLWVcrVDhPbGVuYVlvMXRQQ0RhbUFQ?=
 =?utf-8?B?ajdqV1lOUHpINkdJQjJDbTFqblZYWGthVmpSSWFLM05LSUNPS1BWZXBIZzBQ?=
 =?utf-8?B?NHNNa3NFdEpZRnVaQXN4L2VUM1MzTm9UaHZCNWxNWjJpeEMreTVDSDN0ZkVa?=
 =?utf-8?B?Tk9nc3J3QkdsekF6dDBWSmhteWYvWDFOdElyNGNzNUhDMWJHT2dYamtoakJ5?=
 =?utf-8?B?d3BBekRlcTNOeHNoRHpDVUNVNlNITW9BRHAxZEIyODRJUnVROHlaU1RUczVX?=
 =?utf-8?B?b005d0daenlVMXk4NEpWZWI1QUJuakNMSEYxOWhDRWY2MzM5Y3FyQVJlTnlY?=
 =?utf-8?B?TXlaOUxpVUM0MVZTZHc4TVN3OHRZUUVPL01LOG40SHRYZmEyWnVKeUhuejJD?=
 =?utf-8?B?cTEwdWJpTUNTVEVXbEc1ZkthMUJFNmV5UjZuYmg4Q0dYZTZycjY4d1FrZkxk?=
 =?utf-8?B?MlhOekQ0bzI4OWxnK0JZUThSYnI2N0pkZk9VOFNkL29vUGZ0a1R1N2hHSGRa?=
 =?utf-8?B?WWtrMDZKbTNFbGhQZ3lTRHBSSTBBVkEwSUJJSmlTcjM2R1JhOFpHeUlYRHlz?=
 =?utf-8?B?NjBWYnRHWGlldWNyczQzaDlZckY3T0NGTXkwTkxFZ1k2ZFZYMXVsL0E2UXJM?=
 =?utf-8?B?eU5xZmUyVTN6dWcrbWdBd2s2QVJUeEhsQVNKa1JPalVvTE1kalVSQ2NqeHhS?=
 =?utf-8?B?QWFBbGtsUEJDcVh5dllHVnFHY3hXMG1xaTFVYWFXd1V6NWpYUldxdGxFdkdr?=
 =?utf-8?B?WGlGdWhHRDRGWUtLWUxiM3dPYXlJUWJsTHN5czVreFFNWTdGaUo4M1hMVFFz?=
 =?utf-8?Q?WScg7Yt5td2ecdac=3D?=
X-Exchange-RoutingPolicyChecked: CHbP1rFEFbZXBU/rQIcJnpRZtfibSs+vYSNP/AnOfdax11fO4iEhSTAYMRd1exY/ZuaB98m2t8FWlBUJcMhHxu6ZbdqaM3VDw5cEGkgG4XGfP9T3CikIkJan1E2YCDMBqq3LH3cD+akb5BXvx8YG70Fi08eF9bDGd6G0pViuKV5JCkViqlhYCYpfHwabZvHAmye0NPqmIYy0uo13BB1AwSpGF1ODnPKJMTYwcGa3AgCiMbY78EmJs0q1pG+XFtkzj/qzsWlbgkmz71uvCzGRF/Lj6Qv+Y0c+Or7vF3qmyPggljakR5bEdkupCIkFsPeT6uGRvEG43OXO5x46+Vwj8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bba298-6c5f-4364-fa5e-08df4996cd88
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 19:20:15.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+N3FR6sDh8bU5Q6RnpS8v+BQGTDxG0uHb3jK29mrc2eahIUzgBuO1fhdMtpbJ8jh4yGIfWCo+5/bz0ODvm2IqzgVMvoS6eO33TWojjbEco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com

On 11/20/2026 11:36 PM, Jure Rebernik wrote:
> When the RTL8125B runs out of RX descriptors it sets RxOverflow
> (RxDescUnavail in the vendor driver) and stops receiving. It does not
> start again when the driver returns descriptors to it, only when
> RxOverflow is cleared in IntrStatus. Since commit 6994520a3328 ("r8169:
> disable interrupt source RxOverflow") nothing may clear it:
> 
>  1. The ring fills. The chip completes the last frames (RxOK), then
>     sets RxOverflow and stops receiving.
>  2. rtl8169_interrupt() read IntrStatus before RxOverflow was set, so it
>     clears only RxOK.
>  3. NAPI empties the ring and unmasks the interrupts.
>  4. The stopped receiver raises no new RxOK, and RxOverflow is not an
>     interrupt source. Reception stays stopped, and every frame is
>     counted in rx_missed, until another event such as TxOK makes the
>     handler clear all status bits.
> 
> This was observed on a machine in real use: an RTL8125B (XID 641) on the
> PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6 and receiving UDP
> at 800 Mbit/s while sending nothing. Reception stopped for seconds and
> a single transmitted packet restarted it. During each stop, a debugfs
> dump added to a test build of the driver showed IntrMask 0x2f,
> IntrStatus 0x50, NAPI idle and all 256 RX descriptors owned by the NIC,
> and writing only RxOverflow to IntrStatus from user space, through the
> sysfs PCI resource mapping and with nothing transmitted, restarted
> reception in 17 of 17 stops. The order of steps 1 and 2 is inferred
> from that state, not traced. Reproducing the stall itself needs no
> kernel modification.
> 
> Clear RxOverflow in rtl8169_poll() once NAPI has emptied the ring, right
> before unmasking. This restarts reception without making the "ring
> empty" condition an interrupt source again.
> 
> Testing, on v7.2.6 with an RTL8125B and inbound UDP at 800 Mbit/s in
> 30 s runs:
> 
>  - A test build with a module parameter that switches between the old
>    and the new behaviour on the same boot, 75 runs each:
> 
>      old: 9 runs lost more than 1000 datagrams, 1041366 lost in total
>      new: no run lost more than 1000 datagrams, 846 lost in total and
>           at most 184 in one run
> 
>    The 846 equal the NIC's rx_missed count over those runs. The NIC
>    dropped them while the default 256-entry RX ring was briefly full;
>    reception did not stop.
> 
>  - This patch as written, without the module parameter: no run of 20
>    lost more than 1000 datagrams (166 lost in total due to the default
>    256-entry RX ring). With the unchanged driver on the same day, 3 of
>    10 runs did (237264 lost in total).
> 
> On this tree the patch was only built, not run; rtl8169_poll() is the
> same here as in v7.2.
> 
> The investigation was done with an AI coding assistant (Claude Code):
> it wrote the HIL test scripts, the debugfs instrumentation and the
> register tools used above, proposed this change and drafted this
> changelog. I reviewed the change and the evidence, and the test
> results above come from runs on our hardware.
> 
> Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> Notes:
>     v2:
>     - Clear RxOverflow in rtl8169_poll() instead of making it an interrupt
>       source again, as there should be no "ring empty" interrupt (Jakub)
>     - Describe the race step by step
>     - Same-boot A/B test results
>     
>     Keeping the v1 approach also fixes the stall: with RxOverflow in the
>     unconditional init of tp->irq_mask, as Jakub suggested for v1, 0 of 76
>     runs lost more than 1000 datagrams against 5 of 76 with the old mask.
>     I can send that version instead if it is preferred.
>     
>     With the RX ring raised to 1024 entries, which this patch does not do,
>     and v1 or v2 of this fix, 20 runs on two boards lost no datagrams at
>     all.
>     
>     The patch changes only rtl8169_poll(), the single-vector path that
>     RTL8125B uses. The multi-vector path added for RTL8127 after v7.3 has
>     its own poll handlers and is not changed.
>     
>     v1: https://lore.kernel.org/netdev/20261101102720.702600-1-jure.rebernik@luxonis.com/
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f151ab681393..99b0a410f58e 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -5670,8 +5670,14 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  	/* rtl8169_poll() is used only when there is a single RX ring. */
>  	work_done = rtl_rx(dev, tp, &tp->rx_ring[0], budget, napi);
>  
> -	if (work_done < budget && napi_complete_done(napi, work_done))
> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		/* After running out of RX descriptors the chip does not
> +		 * receive again until RxOverflow is cleared. The ring is
> +		 * empty now, so clear it before unmasking.
> +		 */
> +		rtl_ack_events(tp, RxOverflow);
>  		rtl_irq_enable(tp);
> +	}
>  
>  	return work_done;
>  }

