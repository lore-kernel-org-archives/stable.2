Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB2C25333F;
	Thu, 11 Jun 2026 15:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781193440; cv=fail; b=puU9ip7KJ4OenyJCyITolPZBbQYgK4pczH8f1BuI6VEB28pAJe4RRfJ+Z/zY3pOboxp8kCRO90GViCanxtvoQ0UXgSWRBLOg5qVaVGE86x3NcPAO3R2TnGol4WS5HDD/FhPUJHijxFD1KA+nH9KK1Ahff2G1QaSAdBRfFgbUDcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781193440; c=relaxed/simple;
	bh=Ka3TMuPWQXhN/jkExosZdBpHmVnm7K+t+OXt2L88K0A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cxSt/jIld4CuXlbh++cchlMJKpT3D3H6SGuE4ln2q5lzhhEpx2rtRmkjmXWK627pTB8frFyNkR11eDODOWD7x5QivKme5YLJ6D2IpoalxWjGEaOFlWMrVs+/GCpu+xNkHe/R3lL/P+63cPATMJlwIjMpOJON8EWx+09agNDMeco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYlWlCjA; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYlWlCjA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781193439; x=1812729439;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ka3TMuPWQXhN/jkExosZdBpHmVnm7K+t+OXt2L88K0A=;
  b=GYlWlCjATIOnREvoOuOa+/wzk+kaLQerSeCGb7o6X0UQHZXOpes/FL0W
   NK5ugkmPUy5XbyI9dFrOT8X5KmRP5SyO/sYK6jaGTNPLfUqR2xGfWCiZI
   o1XSy+Km148VQCxCWQJHcO8nqrSsicYbHIZD9COUE9TA5JIElc3oIJYGp
   KgCumnbSTIRm4Gjko7RkBv2YgoH5O+8Usk2m+EVdPp5nrdikEPdzXxCNK
   3U4eEU9Awv3BC5nsLi1c8RPQGxHL20dASluIb0az1yxJ1PO0YMF5Blnhd
   a6YDC47PEcbkAodfEi2WBwn/ITfDH9HFBQb+vBMTkSug+j36GdycCfBlt
   A==;
X-CSE-ConnectionGUID: PZWbsZWgQnaFr2bxX3ro/Q==
X-CSE-MsgGUID: MneJlkBOSg2EG3UhklwZXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82201681"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="82201681"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:57:19 -0700
X-CSE-ConnectionGUID: aOGTAv63Td2dUfhZVELXKQ==
X-CSE-MsgGUID: PYtkis/9RFWEGiOW8cN7zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="246601155"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 08:57:19 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:57:18 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 11 Jun 2026 08:57:18 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 11 Jun 2026 08:57:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOa7UtocTryZ60w4u8e4dphaN0hvRHoI7lH4DkPjwI/SyTDIrN9vLHaL1BzzeguJP0knfPhQJQItBggvQeAr7R61Drg9fUPzq3pd0Q19/PTgs5ZSso2kxo2xhl2oqCVhP1zzeBQN8uvysQssVntmB2kmH11QeFpGxfawWLGvWUUBGl1Smy0xv8ZeGll9c/Q36f4frhtSw85WpcebJg/9D2CAql+VoZL2/HdNjR/CJrpZl3oLZ6aN4y7RiMVBC7fAXmm9ySICGAfCEr9dxiMo3qeD0FqszaX3+N5oCIzb9A8pQfs8MhFzbogPPdLwvYjysDI7Im7/3hoKQs3B7Es1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahPuEDe6hBaJsVQJ0jZfw2oWqcbFP2B+y/zjdfM/bQA=;
 b=Ni+36FgvsdRS3q/6i4aLnReIOfNcRALGWgbnbt7n9BRE933YAwxo+FZ/ruOR3drGGYZ7N+ZKQdd13VfiXvrKEicSohVfiWf/5yWkHrcuyn/2z/R+Q7AOZUDAbmrm2qz9MYNZeSSBgq92b+iCXQmY1TYzGGgFUaSwT7lfUOfWwsezR45NzuP5VXsx6VbppJDQFzaFmZWHRNMAdxvFnjtFBPWd6/48fhn06GWjGE0qzlJYdZ4keboogwf5dOzfVxSkkW34+XDatiQxEeE5u/T6HcHYuzdh/l6ZvlQZPIEdL+1HG4361G+cLx2OCYgMupOKCwzsY3ZV0p0UN+NTyX0PRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 15:57:13 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0092.017; Thu, 11 Jun 2026
 15:57:12 +0000
Message-ID: <b601d0d4-d472-450d-a966-e18c9642a433@intel.com>
Date: Thu, 11 Jun 2026 17:57:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: decrease statistics refresh interval
To: Danny Gonzalez <digonzal@google.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Decotigny <decot@google.com>, "Anjali
 Singhai" <anjali.singhai@intel.com>, Sridhar Samudrala
	<sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, Li Li
	<boolli@google.com>, <emil.s.tantilov@intel.com>, <stable@vger.kernel.org>
References: <20260611002437.1671401-1-digonzal@google.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260611002437.1671401-1-digonzal@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0044.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::20) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f5dddaf-e229-4652-a2e4-08dec7d219d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: h6Qes7soocOBwhTVau2nEmxgcqMFNE/ZW7gHms72KimkN7pwBVFYFE1LVzf5WeITC9k6t6HdmVRNzTJlZpjR3PqjqERPQsRj6xrNyT8RNSZRd4imBfQ9W34yGVyWHfF0koQX5+OMpKntmUsGPx/PpkUkNbmEup2k7t4PNdBGhg82vghoAY7wbIhq2I/kspppGkZXzdzue5cxZB7W2uC7XX5ntuUmHA5CqvenBRMvZznQicuh1owjXCFmNNZn+AObRADOjdVmKiP00qwGXI+9V6e/7UI+6y2OgQ1ZKYoZJzB+Gy/bQp9fakamO51ftkO7E+zHEHfXXSqd/H6WC4BvU7wb1Qtb1fa8waHLmFJMe2XcGsagqP98KpCIILU//ZgnMFwwGn19ZgtiRSfXnxUqy9IhFNfHjinDhWciEYbu54vwf+0sHnHyI1bx8GRsQufKFdxC2cot81+8g0rCwby5ONAOdEiWtKJDeAaONpPDIBWlX9DOgNka/eE7EyUq+Fn7/ZBnD7EceWNhSSLVaZbGnL1DTJLhtH0g6VVSgBj1bU74ni/gXHKtldPE4LKcCUKRqqo2cJ31pCJnYnjk9Xjqvn38W1KmD1jGKdwuLWUtdloVvuC99fvOEwSrMFWpbFrYaCunxWpGxsWds6Ish62R/Xj42jI+OsswJ1EVVvPwr4vP2OmtR4pC6tI5Um7VvCu/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3g0ajRSQUdramZHN1pJNWVBTEZzWDlhRGdyaTN5SE5jRWFCVWpFQnFkdUxt?=
 =?utf-8?B?MU9xQXUydWVtTS9JUFVZZ0VmV0dRRDRkOHB4V2FGZzY5YmxVNTNYZHZVL1Vp?=
 =?utf-8?B?bHJ0dmNlVnBtOFpIVHB4cWJUZ3Uxd2QzNDFlODdQN0ZuZkoyL1VtQVllN1NN?=
 =?utf-8?B?VDJTTThVQjdZUzBqN3dDU1JOeWxoNWp1enZXNCtGWVY3NWdsQnUxTTQ3QkNi?=
 =?utf-8?B?THJ4Um1iSDlXSktZa2xIem9lSHo5NWRjMGdIWWE2VzFYQ1NzK00zZ3R6d0Mr?=
 =?utf-8?B?RDNseXYrMjc4T3NyZytDbGdpay9JbG1VMDB1ZTFWYVpQWGZCNllseFlaTUVo?=
 =?utf-8?B?ayswRURTTm9YNm92cEVFeDkxNDdFbER3Tk1FQkdaK2o5ZmZGZEZ5VjJpQ0JZ?=
 =?utf-8?B?TkhqNTUyak1QcnhObFhmb2wraCtYWFc0bkVzWnMySmFpZkVyWWhtNFFvR3hn?=
 =?utf-8?B?Mm1OY3QzRHd5ZU1pRlJqNFVhc2Z1TC85aGhlQ2tpRkpBS3VPeTl0bXFITnp0?=
 =?utf-8?B?YVFZRi8zdC9ERmZMV1hrVC9XNlJ5Y3dzOER3a3MxSi9nejhPR2p1czF2Y3lw?=
 =?utf-8?B?SG81bVdNNnM0b2lRMFQxTi9vd3pORjRQZUZ5SUZ2Rmt4SEpDVEtkSkhqb2Rt?=
 =?utf-8?B?MjdYTWlrcXIvZ29FU3NaUFFQZWM4bmVpdWM1UmVpY2JKN2RFdFNNeGl0dUpE?=
 =?utf-8?B?VUpUWHB4b2E3M0hmMElnUWRneDB1K0t4SGxBT2g3ZE9xOWNyVFc5UGZ3bkt1?=
 =?utf-8?B?T1o4REFxSnZTL0dxOFpiY29tMFBuQms0ZVJyR3E5WUN3eTdnL2x6eXAwTlJD?=
 =?utf-8?B?NkMzWTgyUkVQSUt4MDhjOElpRFR6cERITTBHVkJqM3QxdndUVThGRzVpVFI0?=
 =?utf-8?B?VFR0NFpuY2hlTzhaTGRpNnNMMGtzU1RwMk5iNVJtaGdXVXAyNDdWeURMQ3h4?=
 =?utf-8?B?TGc5TDVOS3FoOHJWS2YwRjZoSEJLZVM4N3FPaVBSTUs2MnZQc1dacmpGdUVO?=
 =?utf-8?B?T2NhWko4TkdmVUozWHNGY2x2eUJrdWRob0ZRTDRjenVPbEFiYzFaVVV1QXdl?=
 =?utf-8?B?KzNNbG9NT1ptSTgrbjZIcy80dFg1RnZra3l0eHREalBQOVNCcVM2T0lrd3lD?=
 =?utf-8?B?U0xlcTk1ZS9nU0NJNEkwZFpUYkhFQ1VmTC9RbytuRW9VdkRTalVmUXhQcFlo?=
 =?utf-8?B?S0ZzUjdwNjZONEg0MFZhRC8zQkNuQzVVVVFLZEluVHRLYnFkY2E5ODlxSHph?=
 =?utf-8?B?dmcvOVFqbDFjalg5WjkvajJ1ME9Qd3daTkpwTzQwNk56T3pFUWRDS1VHUklM?=
 =?utf-8?B?N05uQXVMaWV2ZWhLWk9mR3hWb3NDVlpNRWozOWxHU0tvNHFRWUhEekRrWWhw?=
 =?utf-8?B?aVk4Y3FjQjFTMnFHaUFaaGo1bnBhRGhwSTd3R1grQWhrUFB2aURvTmlKYXg3?=
 =?utf-8?B?MS9LTWV4NXVnb0lsZTRsNUM3NXhQMy8yYzBRMHhkYTJNaEMxa2M5VTJkNW5i?=
 =?utf-8?B?dEpkNXQrc05LNFVXUWRuOEltTUxEL3JJVVNKcGo1NEFlaE9NdjJ4dmg5MTFV?=
 =?utf-8?B?R08yUWZoL1d5cWNkZGJWOWNoaE9BeS85Zm5QT1dRamhlY0Iya1ZISlNTRU00?=
 =?utf-8?B?S3JkWVUzOEZmU29VZWU5dnhBek9JL3M1cUhtUWdGZk44dFNZUC9PVGtOdVNu?=
 =?utf-8?B?K0tXL29UNXNFbWlnY0xvaVRTeTVLQjlEVkM1eHpSTzVmQ0FMd0U5QW5mUmJD?=
 =?utf-8?B?M09tVW9Xa3h2NHV1KzdzblhCeXA0UGFyK0ZhcFJ5VCtabk5yakpFVXNka2Nr?=
 =?utf-8?B?UnB6V1lGL1R6cko0b2hXczZZakFReFJOZ3FBTDY3dG9waS9rOC9VejFGNVo0?=
 =?utf-8?B?QTRwK3ZJWjhnblEzZWY5a0M2MUF3a0Y4S0lOTnhJTVA3NXZjNzZqUkhKQ2w4?=
 =?utf-8?B?a2pvWVo1R2RwLzRuT2VPTjFmL1p4bWUwSEhPTml3S0tlYSsyeUQrU3NCR3Fi?=
 =?utf-8?B?RWZ4aVkyNXBHK0E5TW53eE12dlpXb0tFVFRUaU82eS93Q0NOYUhIS2Q2bVUy?=
 =?utf-8?B?amxpTmRUMG1FY2ozbE1DZDR0R0FReWdLV055M1NYZ3lnSE5zYjNTUHJTdURU?=
 =?utf-8?B?UXNVQTlRVkRHK1E4TnVkcGJTVUJsSlpHcmVUL0VlVkhoOG1zTFlGbVBYUlhO?=
 =?utf-8?B?djV3SGlwN0hHNmxRUGR6bkZWWVBSMmFIYWNUMVRRazVlOXdqdUxhVHVGaVNX?=
 =?utf-8?B?S25wMXFuVHgxSnkxaTNQeFhsd3hlbzdvL3pOSEg0MFl3d3dJTXdvM01zOGJ5?=
 =?utf-8?B?MCt0aWRkWDVleTdXV0ZPNmp2enpCcUY0bXlkRFJONlRVVU5EOXdzMDZVcDFl?=
 =?utf-8?Q?pMERkgo6MdxUGjCg=3D?=
X-Exchange-RoutingPolicyChecked: MPm9fYH7jHTVFG48fimr2rzG/Rd9r8YFBNK7CnjnB9DdJzABgXpqIhVGj7bHOPgC9mWEqvEYoyfv5UsDnhwdajnUeokyCfXPK0INnFRhnuekVwz2KLavzklK6sUpinhT9Rgkx8IKIMsNppv+hrga29rO3NptMVEorJ1W1/eaS+p9Bi93ASNRBqHIfVQd0Svpj0fx0Klkq7d1COqH0YYvP6kTpDrLnvXWEi/09eRr0h5FDtSDL7Wrc9rqruKdcv55ZDKIIwfzncAGZ+dddBbqgDJQ4NnmwZbcGUfjPnfDJRojVsCtQvZv8Exu24tCuOogMIRgdhidPQyOkK+iGsxeug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f5dddaf-e229-4652-a2e4-08dec7d219d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 15:57:12.6870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bWdw6WycQYvK3oM5ZS0lGiENu3UI3KE7LOh0vY1zzLrc2Zh47O1QV5F3KputkSNGSjZiQfIxy3WiL6v1QeAAxriRUymz8P/6YA/kYLxYD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-OriginatorOrg: intel.com

From: Danny Gonzalez <digonzal@google.com>
Date: Thu, 11 Jun 2026 00:24:37 +0000

> The default 10s statistics refresh interval is too slow for real-time
> monitoring and causes network selftests (e.g., uso.py) to fail when
> verifying traffic immediately after transmission.
> 
> A 10s delay also causes aliasing in telemetry tools polling at shorter
> intervals (e.g., 5s), leading to inaccurate rate calculations on
> high-throughput NICs.
> 
> Decrease the refresh interval to 250ms to ensure fresh stats and fix
> test failures.

Have you tried a bit more conservate value like 1s? Wouldn't it be
enough for tests to pass?

250 ms is also okay, just curious.

> 
> Tested: drivers/net/hw:uso.py now passes
> Fixes: a251eee62133 ("idpf: add SRIOV support and other ndo_ops")
> Signed-off-by: Danny Gonzalez <digonzal@google.com>

Thanks,
Olek
