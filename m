Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1449339B952;
	Wed,  3 Jun 2026 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496539; cv=fail; b=ni9nYwuFrdW8VljQaZhkGtItW7UET2GQFppAs4mxmCa2OZgkKt2jEY/1xiapZ2xzoEG1GM3Z9Sy+RAhjip6hAtvbXWDq+2yPqYebRE4QNzIUGJnWzV20HLgQ1wE5KEVwcs1rbA31aH5AYiq87RFIV4/+MhcTKs+C3Vu8MYHWkao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496539; c=relaxed/simple;
	bh=pelBkeVKP4cGUQbJ10Sr7+d+rO6QKZgCO64P7Wh9laY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O+OT9jalA7HQv452h3UQ1faEnfOmzem+VqOSPRAIjTpaTfweF81ikpms7eAiohU5eO0IvPZkxaMer0UjgAobEUukFJ2EwfVwBJDAHUQE6548/IT6jczF3xp6zp2sYmwbL5MbuXvZYAjlqNwRwGBtQMtjU57yDRo2BvJyqtj1+r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe+4ay9x; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe+4ay9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780496538; x=1812032538;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pelBkeVKP4cGUQbJ10Sr7+d+rO6QKZgCO64P7Wh9laY=;
  b=fe+4ay9xr84pdRecVizlJNOz0f1vZ2HGeHmcVDO4q9jySirnDdWYfUZ3
   ajkB8Y/8Njs3EOYjgDL6s8ZsdUnyC3Lajx4ohACocOCVg/W+nAISb36IM
   6x0+RJEu8Pq0nRQ/NrGQbuIZEQ1tG1zsm1mjBYekQn+j19rfC5V3teyv3
   NYA68mvYY2Fh3xHfduldgTe3HBNS9g7TB/iNAltPMLePW7z0xkRtgIR8a
   FnOOc+0zHH3s2iIXxZwr+V2xu55qDcQ91sG5Ta4RMvPnpJFx+WvkMZlnw
   tvgnChjTfM3BSyNKbTg+kYxD2ywgiqX4AxPd/tLUZt+OHbxAT/ZTzI5Dm
   A==;
X-CSE-ConnectionGUID: uRLowX7tT8uGzLkkbV19Ow==
X-CSE-MsgGUID: 642Szk25TUefiXlwOjcqrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81368747"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="81368747"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:22:17 -0700
X-CSE-ConnectionGUID: 8ZSTO/bGS26arYM1k5ASaQ==
X-CSE-MsgGUID: fAcrjbxcS4SLmr/wvemA2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="246075357"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 07:22:17 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:22:16 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 3 Jun 2026 07:22:16 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 3 Jun 2026 07:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9VzohPViEb1KoOylG8MQhvZw9g+UJ8pyxgH96lPgYbUaowoBbub20GvLpa7Yq4bcySwzs9r8Ll2k/sHZHkhPqocPcIEet3kHkvbRjK97sbZzp2TbjB0z3CvbBPLv7IH3/yosQjceFM+gcGLdhxbimwdtMtskFYb5o+hjvcuMlgyNNcb5hvHFCV8Q0D3HQh5NrcUEa+QdcmpcIFJ53b0o9KSAu3M700JNElicOXknbT1CYuzPL9heiVWL8kd6/ncPETH1hYBI8cVA2qd5RJQG8s56pmLF5CqUO0NXg92vZzlFDABRB0OZuwiGhIDqSgLJFw1y3F5FPbrSDViVBJdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbQ4fR7nUlVJR++260nE77cZqFq2XYELeXGWwEDXXWQ=;
 b=TEmjqahrNl3hw0p5FvJBa8Lb53PbC1TG8Uue2Jd62mUi8VXnF3wNUf2ldzkDgAxGPkX3kNryAwGmQg7UPv0RGwGtMLoCEUEkvvgwuTfgTxZGDGg9WuRCdnBCOXbR0vsfHUJY3gp9FLUSszZJOetMealz6vt7Y3Uu3jpvGN71Auvff6fBPAtY+jwvtsi6LCR5fzadXw+7aOdd42CbCol0c7cd7JKUgheVlistC5n9gPff2u/Emlxvn26XDAxUpvTfMiR4MnBr8wfzB/IjOJvQH9RN1VUE8IELkJrteMdzMAZKBkpJhIlpSvVgitXneHfy1RjPXKpmemo8XpSJRdWsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 14:22:14 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 14:22:14 +0000
Message-ID: <c4aaea87-b84b-4877-81b6-fcc71e203d41@intel.com>
Date: Wed, 3 Jun 2026 16:22:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] rtase: Reset TX subqueue when clearing TX ring
To: Justin Lai <justinlai0215@realtek.com>
CC: "kuba@kernel.org" <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
References: <20260602114659.12335-1-justinlai0215@realtek.com>
 <29f4493e45cb43aebbfb2dc6b93eb4c0@realtek.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <29f4493e45cb43aebbfb2dc6b93eb4c0@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0178.eurprd09.prod.outlook.com
 (2603:10a6:800:120::32) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 29279aea-9488-496a-e0aa-08dec17b8187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 20nwNuV4Ie34DJthKAzT88yNEiy4B1pIEWTvNVnQ73NfdHmVcsGuZZGvAb0EaLNDybWjwzYMPUQR0WnkUlr/CwfDGSYvE5tC7WeK32bd+paHrkkYYCi/biNvar7OFNMYdRbaTAtunt1WG1wekVYjDFAO8LUB1Dp/3AyUM7cQKaIsl2jTl57XKRy1up/iMiShvUiwGr/Zc2PdIrp0LzPTRSbfMyjsO0+yVgTtXRcdNJkSzQBDv/rDNnSCN20EJVPUeodjC0P/3YRECDFHbnBCjn41grO6p2mhkkSJ0/i4vz+5t6xHHY6Kn+m6vi4Dk9B6E0UXTpXwBL+GNC6iGKWNfak62N9pVEGhEHdDWWxYU6sRiSTmNIzhnTwSbEk+OxBk3G+DQfF5ntW1/3PEydwC6lVd3zN70V1nJxen9OTBWkJy//Wz3KYa99Z+2iASgSoCVaYKZ1/U7/ggCni/qdJ6XX5Dsir+jw/bWrxlyZAsNrKduhGdODZ9PpIai4nA5pZAj1BUCF8cWJydrJfpL7vsc+q1fMjZ57Qk8OfKVNGBqYzLFvmwYPEF/M3Cokm4GNirfQC1LbxfWTkk72M/u2d5pa7SKVxpDIWgL9ZtyqjB4zMtSiFPHq0ZHFuo5KslYmJjIAR+EgIkxAFxFNyHRvjtjkhU0HsrJYO03rBlBKtsgMTMEeTHkYGX4mF0MyyVpJqe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2d3RDl4VENjeU9RL3JFMFJCVlRnL0RyUTdHL2NmWDc1Tm1UaVNyc252dVVD?=
 =?utf-8?B?MTFJZXM5YnU5NytNeHY3STdKaXlNaG5vSk0yM0dqa2NsU1pqQS9ocnBWZGUr?=
 =?utf-8?B?Q3NtL0VpNkhiUDJZZmNBaHFKNDdOdS9NbVlmNjBKemlTczZOWERZdk4zNmJL?=
 =?utf-8?B?QUdxQmxtQ25QWjI1U3N3cFhpeEJnVWZPQ213TFlpaW1lSWVuY2RFRW55aWJG?=
 =?utf-8?B?aTd6R0RyU1lYMS80YnhabC9KaHRUcS9vekFjZncvUlkrZVdqb1ZxYnNoMUM4?=
 =?utf-8?B?aUx5VFpFYjkydjF6c3VjZGRMa2EwTFFWdGh4Y0x2M3pjWVBtMU1LaU1mcFYr?=
 =?utf-8?B?cnhydGk1T290bU1WeG1VcVN6VThHVGpJWUFoajAwdW1Ya2dhTExvTEVOTi9Q?=
 =?utf-8?B?R3cvTlJ1TkxxbHJRcFByblRGamlzbDI2V094dmw2ZHYzRDlkTGtmaEthTUc4?=
 =?utf-8?B?cUJhOWlobTZBVyt1bFdEcUhqU2RmWjdDOC9KNFgvdjVBYlBwb1lYMWJHOUZl?=
 =?utf-8?B?ekNIQW13dUsvUUE4TU9NODhVUE5mRk5oRFlxZFd2N0VWZGM1ZDRFSFA5RTM1?=
 =?utf-8?B?Y3FHcVJ4MTU2SWQvNHY4ZU5xT3lNaWxYTm11WkkyS3d1L0g0OFZVVkFnOFJq?=
 =?utf-8?B?bi9DS1grempFM0w1dVhaV3VPVW5TTEQ4UmhRNGtRbG1GUkVRcHp6NW95T0Vw?=
 =?utf-8?B?QlNEcnYxeE1CblZYQ0ZZV0RrYmNIRFNHTXJ3eWd5MkdpcWNHWWcxa2lTb3U4?=
 =?utf-8?B?L0RadUJTRU04K2VHcXYyRUIwOTVQZ1JLTFlGaERzU0o1NHVLSXlhdC9zVE5R?=
 =?utf-8?B?clZjQS9UOVJYbkNmeEQ0cUhyWVNDcmlydTZjcy9oaldNMkpjUWxqYUh0cFY2?=
 =?utf-8?B?VnZLQ1ZHenVxbTROcXI2ZVE2YjgwTk43TC9rYmpvbTU3dTJySHhJTDVzc2w3?=
 =?utf-8?B?UFo4VjdEL3daRXZzZzBnUzZpUzhvZnRMYi9ScWVaYXROOS9keWxEZzRLOE1y?=
 =?utf-8?B?YWVxV1FiMzd0ZXdlTWxPNlVNVWNKZG54MkdRSUwwbU1KTnc1L0VtNW81R3lQ?=
 =?utf-8?B?RVNZYmdEaWNoV1BjeHE0SVN5OURFV1lqK2gybzlpckRxd2pxaGR0Q3hzWmVx?=
 =?utf-8?B?TXljUU96a3JaMzFzdDZodUxiSWpQb0liRHBHUVpHaTdnNmlZSXFSRUY1cndB?=
 =?utf-8?B?cXU2R0pINGdYMU9YNjZ1Uk1VaEsyY24yQUNHOUFFVjhsMllYc0RlRW5KSlFy?=
 =?utf-8?B?SlVudUJmbi9jTkw0WkQ0Z05kY2pNNVRNQVdndThjWjdjU1QzWEhzUUp6RHlE?=
 =?utf-8?B?TDFYemdUVWtNYUVnVlpMeUVCekFJWk9SaUExZ0VkZklsdHZlUC9tUlJyZjFi?=
 =?utf-8?B?SGNaSy9vL1RHT3F5UUZMNXNqY2ZVTGRNNHl5d2ZLWVZMQUovTkdYUDA5cC82?=
 =?utf-8?B?b2ZrcHp5TUtDYlkra1FoVk4rQTBTM3RNaThtQ0s2akxOMDhUMTNZZFVFZFdU?=
 =?utf-8?B?NlRlQ1NMWEpOcWdOWmg5bFN1Q01rREdLTk5EZnJHTkVGRFdWQUpiaStiYkVF?=
 =?utf-8?B?V3ovSlZ5U01QUUQ4MHF5Z2lyUHRBaXZFcDZHaFBGWHlJNmVkZDZ6OHN4N2dl?=
 =?utf-8?B?dXMwZWt3VmZkY091RWdyTk44cnhycjVGMHRTZldYZGVFaHNqVGNNU0tRNjRO?=
 =?utf-8?B?YmVVdnU1K05QemgzcnBPZEFKdmZVeXp5VDNjeWFNTG5LQUxKb2lreUN1OGMw?=
 =?utf-8?B?L2UwYmdQTjFaa242Q0Z4clNBeU8zNkthZ0hMTlZZOGVlL0o4T3BvT3dJNXlZ?=
 =?utf-8?B?N2Y1VzVQNUlIcGNEa0grT1VmVHpyV3hnaklwWm1qb0tQRCs0bUdLTm14MmJC?=
 =?utf-8?B?Vm5xMnBKS0k4RUNNK2dScnpEL3N1VGM3cXN0RHpOVUxrOEJFMG5EN0V4SUwr?=
 =?utf-8?B?V0RWQk5WS1N4eW82bU5sZVhjZWtFVmZCMUhLOUM5Rk5Wb2gxcTEzcGNSbk41?=
 =?utf-8?B?aEpZalB3bURZUTZHanFqY2pVemQydG9vK215QmlCT2RzenFzdi9IS0doT2FR?=
 =?utf-8?B?ZGNaMTRoVU01ODdrVXdSc1FUdTJKRXVMZWdyVkwzYSs2L09sakZhTVhvLzNG?=
 =?utf-8?B?NzRIbGtNYWJlR0RmQ0kxS0ZSRXgvM3Q3WE9SRlVUb3FySW4zZ3RlTVNXMDdj?=
 =?utf-8?B?MmRoczJPcjVjakM3clBOT0xnWWV4Y1VTRzNPRmo3RklqalI4M0JiNVhCSjY0?=
 =?utf-8?B?SXM3dzlESWdWMlZlMFUwM3NlYmZyUi9nZ2M0QlppeklGNVhnWFJ1NWlIT29o?=
 =?utf-8?B?WG9MRGFuUktUcHAzNzBsTk1XYTRCZE14dS94RElwYnVIb2U4ZmFka2tsWkt4?=
 =?utf-8?Q?tBd36gKJKG6MdJ7g=3D?=
X-Exchange-RoutingPolicyChecked: ak2h6ht4o7KymiBQgI/NT7IafeKcOIMG0hWGqTP708ouMMzCpTgbLfRU7AZTMVPsXcjVud9cggUu/0SP18KMp8tWRQYNGvvUNxRNHqAU+3xWUIb3Kjx6eUCWpkZ6TKKlCG/KnovCWjacSTw/HlUoukn9WYpNORb2ES6xds1701d56l5irskqXcGT3cHXM8YQc0xafuVWJY/O/1BhXN/qh6JLJ/NL5b3+SaQS7wTvKdEgmCJSWECMepS87U42sY95gjxZzNh67DydEbV/TpuxNFK7KK3jVEYGKS+U1c7a4tmFSFOV0V4CKPCPD/hXhm6DmeUEoFVtEG4/bRtWan9hRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29279aea-9488-496a-e0aa-08dec17b8187
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:22:13.4917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VHVYkd8Vo0ztVttSyNGzBl2XeIx0n0K7PNE5BjZnYY57MEXuc0lGKzRXTG799ZV3pJ7ORSle5Yk8sSzt5znPfb5uPcmS+MLlUKf3xMTudu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com

From: Justin Lai <justinlai0215@realtek.com>
Date: Wed, 3 Jun 2026 03:21:34 +0000

> Justin Lai <justinlai0215@realtek.com> wrote:
>>
>> rtase_tx_clear() clears the TX ring and resets the ring indexes.
>> However, the TX queue state and BQL accounting are not reset at the same
>> time.
>>
>> This may leave __QUEUE_STATE_STACK_XOFF asserted after rtase_sw_reset(),
>> preventing new TX packets from being scheduled.
>>
>> Reset the TX subqueue when clearing the TX ring so the TX queue state and
>> BQL accounting are restored together.
>>
>> Fixes: 5a2a2f15244c ("rtase: Implement the rtase_down function")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Justin Lai <justinlai0215@realtek.com>
>> ---
>> v1 -> v2:
>> - Target net tree.
>> - Add Fixes tag.
>> ---
>>  drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c
>> b/drivers/net/ethernet/realtek/rtase/rtase_main.c
>> index ef13109c49cf..6ccbefb5acf2 100644
>> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
>> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
>> @@ -239,6 +239,8 @@ static void rtase_tx_clear(struct rtase_private *tp)
>>  		rtase_tx_clear_range(ring, ring->dirty_idx, RTASE_NUM_DESC);
>>  		ring->cur_idx = 0;
>>  		ring->dirty_idx = 0;
>> +
>> +		netdev_tx_reset_subqueue(tp->dev, i);
>>  	}
>>  }
>>
>> --
>> 2.40.1
> 
> Adding Olek, who was accidentally missed from the CC list.


Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek
