Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793657778;
	b=dzWx9Po6bi2tK71LJKpUHC59wje4GIo4OvX0UWxbU8hnuJSQpzGlKp/Dv9ePMgUYZAt0
	 24/WtSRMNr204gneLmkOVcqDMsEPWO5tGNlEMAIfoneElg83E8DyFKw0gcTj39dClQIuC
	 HLmQ31jxrmN/3dUGz75yxGEcamUBWXRkeGeWg4V/nYNTlirv4rFZiKnTdQfNfM2bf6L2M
	 J10ZIHLBOSPdNNU9KiAfk8PKLkfmZd3Q56WC/fJIltxSD4Suzwu4eDI5Em/TTI1T4INyQ
	 J4t9/F2gFgDaSTuQ0oqHxYHtIiH6KdCum+veDG3QReMiQ4JnNrddtboJvsX2njuyhHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793657778;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
	bh=ygEa354wjp7dfC7MBduD1c9+E19IFP4yGJgNEGtT0ME=;
	b=twZ8znPHXWDnVR/s8zPwipfMCZWoml364/Hb2zwz5GbGrmma3UoupgSQgJHEZKo1LgGG
	 kvYxQ/gZX0MrN/LpPqRhVRqk5DXrA0qUzqSNWypj2Zs0O/oTX1FXJCK7YDh7BAVBXHd72
	 wKYhWGBtu3dKpDtTkS0UDWEkNLdbZ1E8UkYarXM0WH9RMFNAnip5+4nhgHeONpcLPr74V
	 Qc2J1PBhSLHsWZ95HbIzghgR8yIHwiW4NAWTDsNfoimysAMM9m3e9M9JJakQ2Jha+ksUv
	 VqKNjVpVHXwezeh+mR53t99moqJchUTO4LscW+4R/Q98Az0FAysyCtrsCj9ww8KqOHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfRHgF9p;
	arc=fail smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13758606A324;
	Mon,  2 Nov 2026 22:16:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13758606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lfRHgF9p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793657778; x=1825193778;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZLYlLqCV+jXPIiv8PrH4JKLwfhKtwm279Lx1uLmzYkI=;
  b=lfRHgF9p2/catAGPqgYrdOhLSEx34aGrwv25vZ1/obu5J39cPZK77Fiu
   mjh8yURu5c4U3xo+LvkB6b4aLuUZvHalrza6qE21zvQQJWVygWIkgTKL0
   ukuB3zAfZkvO9PEVXTL5/JREU9rhUHzl2hQWSA1VufJW5d8ctWrHUY1Aa
   sIK9iUpvA//ZfJuvdUcp2LARu1TmH+Me3IveEbLvgl1r0dgcTdyQ5qy4z
   7eGqWbWLxZ5IbUxqOUdKGtcl0Ky3Q3bRhypaKcGwNfXKVPtr1M3Ccgasb
   SSvF9BweyLctsGnpTPcIZ+supv8TEkYox2h1LKPEravNvN5M9JJ9MDZX7
   A==;
X-CSE-ConnectionGUID: PUzws7csSpeIove+qRLVWg==
X-CSE-MsgGUID: SPq8Q26HTvm1j3xlsIFEow==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2382276"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2382276"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:16:17 -0800
X-CSE-ConnectionGUID: CEcB+fkWQ1K7AK6A8YmnRw==
X-CSE-MsgGUID: cGOuCcl4TeerMdUF0r9USw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6098705"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:16:16 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:16:15 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 14:16:15 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.35) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 14:16:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=no5H2t/lGTUr4zzDOFwFK9LbddlyArgRkJnHg6RMz0SNVnrbyQhNLQanIV/FX0Ul5fW5ws5Uf+o8YxI1iIcPBwH5LqmYHlsH9QlJ0Ufx/9xlaz8oogbQqtLb5GYUwIcdqbzBXJwSk9Aw5J1bt12j4vWSkH9/eCYR4zCjJ3mmRKb8rCLHwVkSTT90wawZmwt0no56BOsmKl0Yn117g/M0wiJJ/lC+rvUN9EJtL8WGbBJieETX/oKaaZWP56cyc4KB/Fv6cMYn6xgEqhHSQ9AbJ4zd24JFjza3kYswfMMbdi4RMZyjn3fZwFXiZg7Pz7fbDelRghwUgKMbIete8tF6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygEa354wjp7dfC7MBduD1c9+E19IFP4yGJgNEGtT0ME=;
 b=jt8xZ4Toqv1ek9CksZ5G5xS4EI4QvazfNbPL2Jt+r+JK7oXmLoBddc9ItETQ/K3u1Z4N0bT3w26/N1v4mkpsQy70EeI2fNf7ePnvR0h3Qg+oT0nb57N9iFTmU2pwD2nr4ZIFNVIyOfT0NwKkACXTeAdfE57u6e8cwdnlkbcfkFw4lmasVTDvPUNTtnV42Z98z3Fsx1v3sLZp7W88+y17o8+UgPb5jIjG92ihHK0+LhyHaJb3peuYG4VIXvIL/s+XIOVipHmA3RdsEhxSTc1tupfXyQ09/Eojk+VLqqIuCu2gnMqH9URBMktuQyiavYPRhTdS1PP36GsqH94KMuDfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH0PR11MB7472.namprd11.prod.outlook.com (2603:10b6:510:28c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 22:16:03 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 22:16:02 +0000
Message-ID: <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
Date: Mon, 2 Nov 2026 14:15:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Linkui Xiao <xiaolinkui@126.com>, <anthony.l.nguyen@intel.com>,
	<przemyslaw.kitszel@intel.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linkui Xiao <xiaolinkui@kylinos.cn>,
	<stable@vger.kernel.org>
References: <20261028090455.2291659-1-xiaolinkui@126.com>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <20261028090455.2291659-1-xiaolinkui@126.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:303:85::6) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH0PR11MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d568fd5-a72b-4995-9808-08df392ed4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|23010399003|7416014|1800799024|6133799003|10067099003|22082099003|261102123227099003|18002099003|56012099006|11063799006|261022105027099003|261021121427099003|261026121527099003|261026140227099003|261021123027099003|261022075727099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: /hKuDaFug0MtZxqIh6uC5tjw4fiHjqRwvyeKZtuIkwpl/P8Bts7ypwwg7tBENZcfTazy6EVxmwcRzgojLl8jjDvlkgX8Am2mXhu0WXrucv8c8DJpcmFXotxz+jzCp3yx9rny7solSTocG1hRl21HUAlXKJNJmSNry+u5DIMo+3ThmeLMY8HjP5HeRDubIsdKt5u6QMsGMdmSXkF9aPHG49YPDYNvgFO2ZCmFdYPeiEGcZ5Ow/emFnE+RPzIl0BLp7W+kPx6szSgcH0ET80aSamtYCyfDH4sXcDvpztwbmrxr7ElrGi21E+u4hvQ9Sr04W2lijIAEx2ti0/9TbMnNH+UVyY8qoP0uReghi3Z7OvQFL07NtIgr5d9GGZENvuPmzdd8xkVIoK2hBX84eptnyorA7F7vH5qQMuJMFH0twd/MKqFN/0QdEEqyebfb+RG4Ca3q6XdxR2aeYZSOaBwzoRKCVrksJrrQo+Hisu454zAPMK1aTlYYynAISAFZ/yblel2VZKptce6QLXSMFW+vi/7uKiL9rfhSbBepucs5zs0Z3zWxLaib+dyghEJsxk2WRoTmitj534ioJTCdaofI7dEtlbC1gyXf2Nf9OsYinGmFa+K7NzFFE6Wobd6ylfVLEnAgeKpX5gWzb2MjCcoJInjK31wVE8531qlyZW1HtMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(7416014)(1800799024)(6133799003)(10067099003)(22082099003)(261102123227099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261021123027099003)(261022075727099003)(261009223027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNOVURiUVoyOHRCdVh5WE12L3RrRmJjOU5JNko2bWFCbkxta3dFeElSS0N6?=
 =?utf-8?B?eEdwYmZoMmxYRHpBRHRWUVJBdkxRdzZzQXZCQVhHMzZSMFhlc0lzT2Z6SW10?=
 =?utf-8?B?d1UrN3AwUFQ2Qm45dzJuTWZtaFVZYWhZTWYzV3V1V29RK2N5L0FOTkllYUE0?=
 =?utf-8?B?S2doNnNGU3VwZldqWjlVVWZDaXVRTHJ3YTd5WktlS015YWJYdDVHaHNDVlh4?=
 =?utf-8?B?bStkdE9memJhZ0lKdlV3WXQ2L3J2UFhmaVhsOWx3RkxMTFgwM1QxMlF3Z2lp?=
 =?utf-8?B?b1hHcGp1T2VsK1I5L3F1b2prY2FqR2ZxRGhIcTVkR1d3ODhsNVZLTHJVVHdt?=
 =?utf-8?B?REJZRE1hL29QVzhpdE5ubm5BWHo3eERDalBDMXVaYTUzbm9SVUg1VGJRUTdx?=
 =?utf-8?B?YkdSMjU1L0x4dXdHa2dwRmI4bkJjdXhkS2VRRTdlZ3JESlYrdEJONU8zdEVC?=
 =?utf-8?B?dzJIeWJ1QlVTY2RZMUNGaUIyN2xONnM5MGhUWGV6aHZlWktyeHh5MVFQK2J5?=
 =?utf-8?B?SGxQZnJ4dmNmSTFkVmgwWVphWmxNVEk0OGJ3Y1M3c0dHVWRENDZJQ3BRcXcv?=
 =?utf-8?B?T085cDNua1ZNa01ZSmxFRVZLMkdKZ0kvZ0FzQ2tkYVZ3MTVtbFFsekZITVdq?=
 =?utf-8?B?L1lUeUxBc0dRblA4b0x2MllKb2lSQzhIUXZyaVF5R3BydFhQTkxDMjBIeWlp?=
 =?utf-8?B?ZENCMy9MTTZMTmJyb2hyNjBSV20xSkRnZ0sxdVpiODg0VWdUTm4rSnpRcGtL?=
 =?utf-8?B?TGt4VjZjRTNXd0lCeDNmYlZ4MkZPMmxiS0pIVjUzaWxlcnVGa0NmR01ncVlW?=
 =?utf-8?B?OXFjSE1FRmZ4YW12ZCtGOXlTZkJseFFiZ055aEZqd2Y0NGpwMDR1NEk2ZVlJ?=
 =?utf-8?B?WE0zb1c0UzhHdlNQZHp3bkdXeXhmQXd4OGdCMzE1VEFEMHYvVlBBc0xFOFBx?=
 =?utf-8?B?Z3l6T3plWlhpOWdxaW9Tc0NjQ2RoN2ZUWGhaREJpVkFiNm5JazE2OGh0cUVJ?=
 =?utf-8?B?MUxuaVFjRHNZcmliT0ZXQTNVckJWOVhyOVVGay9uNVFxcjQ3QVhBVjdZa0dY?=
 =?utf-8?B?VUNRc0EzdDZZUys5bVFPSDNSSFQ3Y0VsOEg2Szk1amRRWXVCNHdjSk1NSEky?=
 =?utf-8?B?YjZkVC9nY284ZkEvSjd3MGxIUmlkdkN2MDBkVlVQR0xobzBqcUZzUU1YNDVG?=
 =?utf-8?B?TXp4SHFRaEtLMXZQRE9CV3RWRXVOSjlOelZ3M2h5Z29yODhWS21zdExMNEl4?=
 =?utf-8?B?cjJtRy9RdE9QczFZdFpCK1g2UnNka09aL1lwTmNCbTl2SlRmcVhzWWtzQmpx?=
 =?utf-8?B?cUJVVFlaUmExZXh3dFlJYnhxYVhubDVhK1N2ZHByWVluMUF1QUY5RllpTjho?=
 =?utf-8?B?WmlGalZYdHFlNEhFS1o4aWlzc012aUxwZ0t5QXU0aThJOVNraG9xMUszdUxB?=
 =?utf-8?B?ajVWc1MrRjNPMXZ3dW5yUmh1VjJJWUVhcUpybE5QbzBhNmtaT0RnVGxqRDh5?=
 =?utf-8?B?YzQ0Z2c3VFcrRllzRDJXUGJMMXQ2dDNML3B5aGhoUGpyYVFyNVY4RFFFaGht?=
 =?utf-8?B?QmFDN0ljRFlhSFh5YVNHQ21rN0E1NllpTmhhdUxtYm9tVi9jZGVjZmR3UzVU?=
 =?utf-8?B?NzZzV2RnbmRMRWVncWJwV1I2ckZOQVFpaUFMdzgzNjZWd2Q0WlNjZzZGMHV0?=
 =?utf-8?B?S0ZYa2loRnRIUEVMZHBqMnk0SkpIMDZraCtyQ0JBQ3UyK1VlMGY1MzF5bFIw?=
 =?utf-8?B?L3FmQzlEbWJHYmhTN29lQ0dWLzN4L2VFYkYyWExHakM0Qlh6YVl5UFZJVml0?=
 =?utf-8?B?NVZxQWlscExGOWxZZHJ6dHh4U1lwVWVRTUs5dmowSHUrZlpEdjFjbzFGL0N4?=
 =?utf-8?B?REVlM3doUUJ1TVFkQUh5a05xUkdkelJuV3FJcE1Pd0p3LzRuRExENVRCNWhJ?=
 =?utf-8?B?Y09wZWNkUU40cHlUWFh2ZTdoUGJRN0FFYnVzSU9zQTFIeml3WnIySUlOMFln?=
 =?utf-8?B?WDMrUldVQ0lrZXZYQkxFT3dYd1E0dVM5UmxZNmZ5UUpGY0R3ZDUybXpJTko0?=
 =?utf-8?B?MXA3KzRodnUyZTlYZnI1dlNNMWlVR3BSSnlrWWd6NTZ6c1c3bE1zQVNHRmhB?=
 =?utf-8?B?M2FqL2lPTFBMc1Fyb1NuVVVYQ09mMFFlb1ZEdzJBQ2xxU0lVdTg1V1NPZ2Zz?=
 =?utf-8?B?TklSdTFNMnFFaWxKREpUQWgramlkUzh2ZnMzdlRRbmhIREMzSFdsSXFIQmJ2?=
 =?utf-8?B?RHE5SEJNa1FRYU5IeVlEZjdGbTBuL255RldTOTFjaS8xdDZ0aTJCZFB3dXhN?=
 =?utf-8?B?NFlUSjh4YThCbmNlZlR6b3N2bzlkU0ZVclpRdno4aGJ6aVJSRWsrUT09?=
X-Exchange-RoutingPolicyChecked: t6uXo7qbmWD/33K7j1cWQVOnQ013XrrMXxdY3a72w5hFREznfzRnRdUVqIhp4PaS3h+yzubptMc24tURnR/urqugB8uWpvqbOxni2eDBvqyl+p4VR6M0fZBi4nZFZxfuB9e5ICtikZfqmA1vRU8QvKixlfH/DzhhdzCjnLb6ZEmjXxWAt9tu66Ys92IIIyHMInd64SIeMzeUh74bEVJAquilzo6jv4/qY8tG+0/89j4ByfVSkCsDQR16AFs/BRxUKozdInY68qMJsjvrXOICiJKX3HyDT2kWsf9MQOJBQkzASHzgFPLUKELpNGG8JdIPBJuTIt2mbgtdt5kgNEpDDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d568fd5-a72b-4995-9808-08df392ed4f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 22:15:41.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLkyjaPZKm5Uhco4sCWGr9jrG/QM+ZWjJVwinkOpsRV1JJTmwYlI6UfDG0rppEQgzEmascrmjapyBM4bRCyO01ahwD/RoUb0Oy9NtcI5Jqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7472
X-OriginatorOrg: intel.com

On 10/28/2026 2:04 AM, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> e1000e_config_hwtstamp() stores the requested configuration in
> adapter->hwtstamp_config right after the rx filter has been
> translated, but the two register writes that follow are verified by
> reading the registers back and each of them can fail with -EAGAIN.
> 
> When one of them does, the driver is left holding a configuration the
> hardware never accepted:
> 
>  - e1000e_hwtstamp_get() hands it back to user space, so an
>    application that reads the configuration back is told that
>    hardware time stamping is in effect while it is not;
> 
>  - e1000e_systim_reset() re-applies it after every reset, including
>    the ones the watchdog triggers, and keeps failing;
> 
>  - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>    filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>    time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>    are eventually dropped by e1000e_tx_hwtstamp_work() with a
>    "clearing Tx timestamp hang" warning.
> 
> Cache the configuration only once both registers have been verified,
> so that adapter->hwtstamp_config always describes what the hardware
> is programmed with.
> 

Any idea why this got marked as patch 2 out of 5? This doesn't appear on
either netdev or iwl with any other patches.

I'm going ahead and applying it to Intel Wired LAN regardless, since the
fix looks good.

Thanks,
Jake

> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 35f5590228eb..7ae33273734f 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>  		return -ERANGE;
>  	}
>  
> -	adapter->hwtstamp_config = *config;
> -
>  	/* enable/disable Tx h/w time stamping */
>  	regval = er32(TSYNCTXCTL);
>  	regval &= ~E1000_TSYNCTXCTL_ENABLED;
> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>  	er32(RXSTMPH);
>  	er32(TXSTMPH);
>  
> +	adapter->hwtstamp_config = *config;
> +
>  	return 0;
>  }
>  

