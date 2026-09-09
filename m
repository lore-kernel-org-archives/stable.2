Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5F469847;
	Wed,  9 Sep 2026 20:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986917; cv=fail; b=CSoGpIho9FiZIMrrPAVe4e+Zinb8jSU5C2BH7MLEw/HoXB3q4w4oDaj6Vgn3imkBb0YcQtlH5tXNfzQo8xOQi96zRaTtZ0eYqfU/RfboC2huv88YSxMmivibOnKm3153CIT7agIw4W1l9wm6unNORfXN0LWYul37VUJlEHgpAck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986917; c=relaxed/simple;
	bh=pOhy+/gxlbivSaU+/OofkLrRHFcRP/mwuE4zikoaMfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=koO7vnmOInOvJeW48VKHHYxAw+gRLHfYKgksw+v/mjmnkrsZ8k06esdsJmhN8Z07wq55U6QoTxxUGC6Wkp4+fv14kjOFrYz1+pU+uTi0/d9LM67NFxRe1aUOB8tu+QsIvK9bdP5LwQHA+Vk67GjwQCj3iFPHUkclliIEiFFf+Ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qgs/Wu5m; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qgs/Wu5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788986905; x=1820522905;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pOhy+/gxlbivSaU+/OofkLrRHFcRP/mwuE4zikoaMfY=;
  b=Qgs/Wu5mv9dKq+ltKKLWKSOJ4AppMU0nf6jAze5EZMNvotKoH9yhfi+O
   v4xsqRxre1LVA9puegQHvuS9+iZKHYW3whmcDq5NfiQVO1qZLSfo2wS44
   JLR0Qf8BoEkKQahGf8Ec4yZLyGm4aE4t+uDJrMubI97B3XTD4+zfCGqTO
   kUTlam485hEYbW6Gh0pjWUQl+s2KZjmwvMthV2kOMA11KDWx7/OHXdV6Y
   iQ2EEnx25k+0EXrdOOwXMaFNMPhlpjeE7oCAZeGGh/EhMjCaoS+13J/vz
   C0tQqIa6JlDpZNNro7LgVXldOs40BhT9TvNOrixoNwBNtj30tcyuHjbDv
   Q==;
X-CSE-ConnectionGUID: lkrhFYHOQ/Sry7t6r4zshg==
X-CSE-MsgGUID: 8Z+xuz5pR9mOIX6VUMHvMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99757028"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="99757028"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 13:48:19 -0700
X-CSE-ConnectionGUID: 8S781K8LRB2g5vb8AOZybQ==
X-CSE-MsgGUID: nJwdLc8TRWipbXTArc0TdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="274940322"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 13:48:19 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 13:48:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 9 Sep 2026 13:48:18 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 9 Sep 2026 13:48:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awzd1i+S0WqgTuv6JxmAi4VmJtXN05YzzyZ0ZsXTspX4VplMJrs2ZGbM+kq6S04jb46k6Fp3Wj84NuFjxkTZUIifJLiT5pc73lFdT+020p574wZ+dtnYM70ElnTtFQIUFtjW48fldHjBGGXm85Jt3lH2Mzss47PPRukdiAGwMuKt8Y3BL43NO/Nd8m3Ja6yffLvpKYuDPw4v6uhYBHLcFDIN3eDbMa7rYvls4lWTm3cl8Rl13M47vqfjRZuyG1voFxuayEVI3jJ0s5J3dewnLq6NsDFne/p91SrrI0g1G1/dvt4JhhaBQoOsj2p8zqjaanztp3ovBJnrpqowE+4fHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LK+XXQOOPIq3l7gFi26G0MfkLlHb9cHDZnlokgC+23I=;
 b=rizb1tUefYRpkrzz1ypKN4BYjR8bw4a/yvoyIQxfBuoQXskeZE9byYvTU1nAG1kRgcbVpoRMXvkaXQ/0b2aH0YHD1uQQjUS8UhHiyx5walWeE4VoaHACVpy1EHMT1rgBi3Fl7V7kkXQqzhtjMmyNoeNe5pxGKMyJ0PGacrRy878FT9DpltCt2wiu4K3wBb7MMvx+XpYZbXfQQlVwqSwahWpGAe0Ov06As9wjiyauKSknnLLsad3J/p2nirUuzuM8tZKXEA72GmrBVYP+Ziylwez8I9pRUzCSULAnHanOBA6kDd0eWxMLs2lYTvyFAjuCXGIicMx+mOXUzld9mYjhow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 20:48:16 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%5]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 20:48:16 +0000
Message-ID: <cd12af33-ed01-4eca-88e3-703b59c05453@intel.com>
Date: Wed, 9 Sep 2026 13:48:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igb: initialize PTP lock before registering PHC
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Alessio Igor Bogani
	<alessio.bogani@elettra.eu>
CC: <przemyslaw.kitszel@intel.com>, <richardcochran@gmail.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
	<stable@vger.kernel.org>
References: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20260830154912.2712900-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0005.namprd06.prod.outlook.com
 (2603:10b6:303:2a::10) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 666fdfa4-8802-4687-61f6-08df0eb3ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZtUFysIHSuSlAR7SA4aokhRzeqYEGBizEDNDfQyCVaiX/CxtOdvaTP/vDtBjsmxIy64XivVX0COifwx27UL7xkA5yz2uy2TMckA3nAILv2mP/jgLAgdSNwfgIExqXszs9eUNTAnMRXTzl8If+FjbwNoLr/Bo/o+h5Y63xG1tK6iY3C8sN4+p1mm65DmF7ic5BF3XMeGb61lQ3YAQHvIAN68zv+YWw2lIcfsIVMW/Ey+QOUtgYqPt/6bsnkOTGoAYZ1xtf+pgSo+1VYmCQrU7/PcnNHIEIRudSaYzAteja75hC6tV/bSSHPPGvqBXRJNdrzzpuDPkLj60eRPqU7gmjGoDaSC5/x2lzHBhJ3Iy+b0T30D8u905Foe0iYSSpQjtqr0FdS/Y0/eNUDBGndUlt3dCN5kM+cPdjjY6fYMFFsj7bC/941khfdbsB6R2WbsDcnk4FncjPTtZ+2/mLJhfbL4mXG7vDtCjoRzESJt9Bg1LcPIKWXAAT4ysZMqgDyBJy2cp8uvi5zk/f4/X1vDPhYYThKNv5T5xWS7P+mUIRS2xUG2IHDmzamrFvmdfiyRseM0mWY7Sz5D5EjEp7u89LJjmbV3JIeOCw/lpbyYhvJvIOai/jHmXvJIkiCE2H5tkgMufUcYI504nALOYNE9OgO2utrxpj9mLRp2Wns0dZHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFpNHN4VmhFYmZUUGtCYkx0SjViejFwSW4zK3pZclRoMFZPYjBXaVA1b21D?=
 =?utf-8?B?bTN4dGY2Wm4wN1o5QkhVczBTNHk2cVBqczZyYWk4NnFlclZUU3ZBaG44SFhv?=
 =?utf-8?B?bHNzMXdGY3prUFRSZktza29xYW8xWHBZbkNMeXBGQWkxYi82OUZWaWJDNG1E?=
 =?utf-8?B?L2JNUHFuK3FuOUgvN05zZzRQVWxHRmc5TjViV0ExRy82dHY5OFlESzNjZVdE?=
 =?utf-8?B?UDZldFlITHViTHFFMTc2NG1mNjZtclhtd0NCNUlGeHhPK2J4TWplRUhhN2Vy?=
 =?utf-8?B?d3ZYeXJaMUNER3FkdnlXMDgvSXVUaXlrSDlmWEJmM2hCM3VRK2ZNUlR2cSt0?=
 =?utf-8?B?eUFwbXpGMGdFT3JtTVhRUWlQOG9GYmhMZ1FBcFZtbVpTZElQME12NTJxZy83?=
 =?utf-8?B?aGwyQldzOFI0S24zZGlLR1hhcndaZnpyOTJNaCtvNkM0eHFnYWpaWUxBRzIz?=
 =?utf-8?B?NENmY0E0Q3I4VFpLbExpRnJlRk0xcnJNODNvV3RSU3ozQ3l5Y1RxOFF3aG9h?=
 =?utf-8?B?NTl4U2plQk45OHpjODF5ZlBIRGRGVlRnR1BTbklkL0l2L2lhWXFTamYrbjlt?=
 =?utf-8?B?RzdvbDhtQ0ZkaS9iZFlCNTZGMStRbTBPWk92NG5SKzVRQ2F4T0xFTTBoU05T?=
 =?utf-8?B?Qml1a3h4cmV5VkRmVkVaQnhqT3prZk93Y1RlSzc1NXlMeTB4S3pXMGRYTGVC?=
 =?utf-8?B?YWJTYXAvTTFiOTlBRXk3blNPNDc2Mmc4SVRmZGVVL3Z1dzRLRW9jd3pTaDVK?=
 =?utf-8?B?ZWFHajYvcTNmZnpRdEx6SmJBeDdjbEtaTHQ5cGQ4NnljdnRRdlVyOWNsWjdX?=
 =?utf-8?B?Z3N3eHlRNzBBTmIxc1d6RjEzMTZXZGM0SUVNejRzVENKRERuaGNrYVpPTXJh?=
 =?utf-8?B?VEhFd2N0c2RNcTVLaWNGMVg0YTJ6L0FrSGgvQVdEeG9LMXZDTzBJaFk0QVVk?=
 =?utf-8?B?Y0tkUUlPKzQ1VXhNL29uVk13Z1B3S3N2Vkd1NjVOMy9nMDRMZjZhclVtRC9Z?=
 =?utf-8?B?NkZqRnN6dGVtTHo2aTROdXZ5ckhpeU5FaUtJVmpUUWxOa21yYndDUTA0Sm8r?=
 =?utf-8?B?QVUxL25nTWlqalU3TUxUUE1IN3p6V2pITzFpelFaWmRRS0ZSMHpRcXkvbk55?=
 =?utf-8?B?SDRsZ01sU2NVZVExcFordmFXRTN3RGljYjA0RUwydHJld2M2QVhJUEs3WVAx?=
 =?utf-8?B?ejJ3ZVpHUDMxaDQ5bE4yTmNIMGZUQll6a3ZiSTEvTGZqUTRKM20zeTB2VWgz?=
 =?utf-8?B?S1gyelNEOUljeWkybUlBdjZmY0ZKcDVkQkZlcURnMFRISGNjN2JhWFJRT3lF?=
 =?utf-8?B?M3ZaUjNIWW5FOXBwMzFwUzBqSU9PNnBzYTg3c094RVJ1Y0g3aEdXTWptQm5B?=
 =?utf-8?B?UzNOTXpQVjFGVGVjVDZQQlY1M0VGSEN3VUJSTDJnWFRxTnhUdGQ1NmR3K1lY?=
 =?utf-8?B?QkhUNGE1U3FwMk82bUZVbnE0UG9TcGJtRVdQSE9LL1NNOENLOEVUM3NLYS8z?=
 =?utf-8?B?cmNsT3ZSNHcwdFNJN1A1NjlJcnBEVm01Q3VEOGJPeGpYcGwzT0NTRWZkODNX?=
 =?utf-8?B?Y3JWb0FZTGptZy9wYnU3akcwclVndXVrRFN6ZDYyM29FQXZGT3dISFlyZE43?=
 =?utf-8?B?dTFCZ2pWMmRia0NWWCttREZwUnRsQVhKNnpmRGRtSVphQ0prakRlVkN2VERM?=
 =?utf-8?B?bHVFWmFjWUxUK1hJSkVUM1JDZGtLYW1HVmNNdDFuUk5FeStqSTNLT25wOVBx?=
 =?utf-8?B?YVIrQkpGKzVlU3Rrd0tVTVFRNDZFU0E3cDlZK082MDd0Nmh6Mmk0a2RDVFZQ?=
 =?utf-8?B?Nmo4eGRrUFZyMXhkRUczSUM2ck5ML2JJajR3RlVrQ244eklWTStGQVBaTU5L?=
 =?utf-8?B?TTdHQk8vVDBNdWNoQWdlRStiSEdjcmlRNDVtTlJ5Y1ptMW5RcER3UGY4WmxH?=
 =?utf-8?B?TnFGd3lLd0UzNCtQYjVHUEJEaWtFUEY2S1pISXplbzI1VHlJcVQ1cnJIbzJV?=
 =?utf-8?B?U2JDd0NMNWFxaTd1cUVHK1BkcU0wQUI4eDFReWM1M3pPcStEVVhMSStZYkZy?=
 =?utf-8?B?K3N3NkJSUlhudTM5cUxhbmhsbGVtSmtSWDJ4SjlIZS84Zk9NN0NSNnVUQXY5?=
 =?utf-8?B?cXdjRUtJN3dsa041NktTR1pwbVVvOU53UE91dGg4NEtCNG1kanFZeTZ6cXN4?=
 =?utf-8?B?VStscFA4dFhWOTNvNEpxcDR0TW82R2YvRWw2UGoyKzhheFJkbE9yVFpLNW9Q?=
 =?utf-8?B?dXVlWjRzYmZRUWljaXFWb1FFaENKa3ZIRFpML2c5NzdpK0dDcGFVY3hRdllr?=
 =?utf-8?B?MjFxWlhOY2pjYjZLeG5iTlF5M3pveVlVRkZhbnFuajdJeUdHYmZYUE56KzB5?=
 =?utf-8?Q?84EcCvP+r8mfjSEg=3D?=
X-Exchange-RoutingPolicyChecked: PhBn4v60GSwRyLvMBwJSaAH5tWfieGs5yjz1Mc2aQzrzf26/PFpd6QRGK5kJG1iFxqCP+plw2NFqgB0lmrzKmFo/805IuH3OVHlm/7gGvm8RX0125FWkmoBtdmRTZA+RLrDMuouzlfYIxh6qIVldqCnQcSoxG822wxpaqI3CLwOK3PClu9Q0ZeaUYqp9qw98hHj8gQLJkkUmFzwsoh7Cji0AUhqRXpPC3b3SgPxeg9kYwQKE3pAQhG8cRWgK+dqkCn7HvD7EiR6cMM0rrdGl3FopSYv0YjYcsyepkt+Fz18rpYcGwVcxrXqnlLUH+antKlYAmw2HpRcDLynISA60Rw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 666fdfa4-8802-4687-61f6-08df0eb3ac2b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 20:48:16.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG3r56wRZnbLxcqJPKnhb3S39vhvHyw9emc/aiJLdss86Nit9o3VYrkV9SGrYUTZO1eWxtFGl6DnYyKu4BKxNhZafQWQwJc5q/QIQsPEmSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com

+ Alessio

On 8/30/2026 8:49 AM, Runyu Xiao wrote:
> igb_ptp_init() registers the PHC before initializing
> adapter->tmreg_lock.  ptp_clock_register() publishes the PHC device,
> so a userspace PTP operation can enter a callback and take the lock
> before it has been initialized.
> 
> Initialize tmreg_lock before registering the PHC so all published PTP
> callbacks see a valid lock.
> 
> Fixes: b888c510f7b3 ("igb: Avoid starting unnecessary workqueues")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>   drivers/net/ethernet/intel/igb/igb_ptp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 638d8242b..2a4ea327a 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -1378,6 +1378,7 @@ void igb_ptp_init(struct igb_adapter *adapter)
>   		return;
>   	}
>   
> +	spin_lock_init(&adapter->tmreg_lock);
>   	adapter->ptp_clock = ptp_clock_register(&adapter->ptp_caps,
>   						&adapter->pdev->dev);

Sashiko says:
This isn't a bug introduced by this patch, but does this expose the PTP
character device to userspace before the timecounter is fully initialized?
If userspace immediately opens the device and issues the PTP_CLOCK_GETTIME
ioctl, callbacks like igb_ptp_gettimex_82576() are invoked. These callbacks
call timecounter_cyc2time() on adapter->tc. Because igb_ptp_reset() has not
yet executed at this point to initialize the timecounter, adapter->tc.cc is
NULL, which can cause a kernel panic due to a NULL pointer dereference.

>   	if (IS_ERR(adapter->ptp_clock)) {
> @@ -1388,7 +1389,6 @@ void igb_ptp_init(struct igb_adapter *adapter)
>   			 adapter->netdev->name);
>   		adapter->ptp_flags |= IGB_PTP_ENABLED;
>   
> -		spin_lock_init(&adapter->tmreg_lock);
>   		INIT_WORK(&adapter->ptp_tx_work, igb_ptp_tx_work);

and:
This is a pre-existing issue, but does initializing this work struct here
leave a race window for list corruption?
Since register_netdev() is called in igb_probe() before igb_ptp_init()
executes, the network interface is already visible to userspace. If
userspace brings the interface up and transmits a packet with 
SO_TIMESTAMPING
requested, igb_xmit_frame_ring() can execute concurrently and call
schedule_work(&adapter->ptp_tx_work).
Because the work struct is uninitialized at that time, enqueuing it can
cause list corruption and a kernel panic. Should INIT_WORK() and other PTP
initializations be performed before register_netdev() in igb_probe()?

Tony:
Even though these report here as pre-existing, it seems these originate 
from the Fixes commit. Everything needs to be setup and ready to run 
before calling ptp_clock_register() so we can't defer starting these 
until after the PTP register. I think we need to back out the fixes 
commit and add a proper CONFIG_PTP check and unwind path for register fail.

Thanks,
Tony

>   
>   		if (adapter->ptp_flags & IGB_PTP_OVERFLOW_CHECK)

