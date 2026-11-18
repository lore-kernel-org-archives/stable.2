Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795002808;
	b=wRdBgofxwT9Il5q2jX6cWb/pwoCL8mKD/93hX7yGHlIdtGWS1L5wuxJP6zenaWNc5vgA
	 VCgrLks8fOAlgno+EJSuRLzhmXAuZlhdIE99abMTC7WAmnqXbSShu7+RnMlbw289kZDkl
	 UwjL8/zt7hupH8voUthmbEJOPi1KY9B3PH1PAjC+q98IlLCOnbRgY/ZZbAG2wp77zP7gC
	 7eSQHmfuo04/ZfehXmcy2s4nlAkuiy54KjtVJHdBu7gh0nNHtHlmEAlnzk5M4R5yMgjwD
	 K/t+yuacRAiSKkxv42+SE4zoz1TG3aCoFeQBxeaqQGXAU/8zWVXl5J9VE6LlAoTV+0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002808;
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
	bh=apKoMkZozEZIy7elINl6ATdg3f+CmH2fTs19Ur7fzM0=;
	b=bOHXp5Rlo3p6c/b7xpiftK07t5YcKno7OV/UtKEosEccPxMWAS4AV2MyPnTtjY84w4wl
	 LN0VxYBEeTcEGzj5ye5qne5Uf2EW/lBfPVPlscYrioIfZRRxM0HsuysxZ6svkY/iw2QzR
	 TsEkDKVeIriBwAIqJlSKmqhU30cBmwQsCVc0QORxE/oP9Vqbt/GocdBPWU+v4IfcdzRom
	 UHz03FoXy8ja0H/Di+E8eCK5MxDft+K9fZr5AvD57kJjJC3vdF0xRY5yuk4BrQfyyRV11
	 RaEfPThZfB6dV0fsgqF/BRdCDXMJ3DRlxsfuXn9yQNchXpLToE4dfe1GC+El2nXNvmQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C2gnl5q6;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AfgPQY4j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6794860A2600
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6794860A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C2gnl5q6;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AfgPQY4j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795002807; x=1826538807;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UfGNeuAjsMpbjMKHwQxcD9ZnXiht+olnJiXeruyQ+Lo=;
  b=C2gnl5q68rYdasQDPikvBetmHA3LphQeLT3nlmaeIYyEuq4iopHs9qlN
   oTmqK277t4BJ57vLZWlaIkFc9D3juwWv34OcesCd+jHczzpi1vR4safEb
   AQbC1kqyKB5egzjjcbwyxXOyrnTfJXTyWUPohx82JZY5HSR6xoX4PkmLI
   bdjIrEVmLKSNGvWb91T7YjlgviYaSUm8UJbRC7JGtm6ebzeTXimKIHrtg
   G3++ubli1JMsmMwL48YbcNQ8TQ+Te0bqnfvNK2t8IidgkoAAD1spRO49i
   TIj1MglCHbrIb8+DYtKiYQ3GxXGZao+fT6RUfqCQjZDwxeDJlrVgdZkny
   Q==;
X-CSE-ConnectionGUID: OXKTwS41TVu9YQ6TS+xGwA==
X-CSE-MsgGUID: +qh+J/ymRU6s7ygAaNtX8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3690796"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3690796"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:53:26 -0800
X-CSE-ConnectionGUID: J5GEvYXvTRuVBUfF/idMuQ==
X-CSE-MsgGUID: s6yCWDDjQKSnd0mCdihJIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10522575"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:53:26 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:53:25 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 18 Nov 2026 03:53:25 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 18 Nov 2026 03:53:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dXBAEV3mdlijMZnlpn8mEd7EC1FGUdjbihSRs4bVg29rjGb8qboc2InsdFDwvhK0i7Ipiv4wIMKAY0iCwFES5zXO+AQFs4Jj0Iz0DJm65QUPFQqbFf8/ZWl4kQFu4ReobpSmui2nCMSogKgtRIejXHqVaW+0oz5w8EI8/IbBqj1TO+e2mfO4N6j5V9TpeomqqNqDtbvkNM3UFeCotv7iHQ01OeQuVFDnrRm7tnVP87YuON0M6WAJTNiv/0rajyJCutkXayY2ut6irNzSPYFz0jiihdAO2LWDiaiJgDfGdRdphXvkMJBs8bsmT92IMBSBNhnVK2/ROVO1lEKdjJ6M6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apKoMkZozEZIy7elINl6ATdg3f+CmH2fTs19Ur7fzM0=;
 b=UZ7H/bof3Q5Nybn5iGEDFknxyKw+ilPS6sTkXqLUFUny6OL5NBYBfl9f9sv4gxLyOTYgsqx6HM9yHReCzwstO2y8FbWAen7dvFVv/BJ//yiD3YAFMc4F1fVdwYts/PBtrEbYGb8vHaYGszh+K2bBV2q+/gNtpHOHUrH/DLLP876CX+ssKvGl2emAopUYkf+so8qbM762HYnNTDzZFsXwzXfW1R90EdXJMBpwFhf1MFfnb2eywmNQ9liUvbaobgocB3TxO+WcO2Dd5r3SmgQo6MXCdEDtki02uIL4E6v11/NsRC/F6NCzjWdP4liRZPaiBX48WJcZJ9rtfynvCWtBxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apKoMkZozEZIy7elINl6ATdg3f+CmH2fTs19Ur7fzM0=;
 b=AfgPQY4jL58EfLlNoex4UXsMMbBWGXavWPZ6/5FjIKAk28EoN9NzYXkVV1nELH2W/qTpLaBTCK4giOw093Qy97mIV+YbzawryllFWQHQIvPi4+/9F0HR1wsINB0PAg+HMKr44ph2ALveBOzAm1DTRYIo4nO21QpMT1QEh1J5jxU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21) by LV8PR11MB8772.namprd11.prod.outlook.com
 (2603:10b6:408:200::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 11:53:18 +0000
Received: from LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460]) by LV2PR11MB148960.namprd11.prod.outlook.com
 ([fe80::9761:b20d:6f27:5460%5]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 11:53:18 +0000
Message-ID: <da6f14f0-b2da-4dfc-98dd-0f837829b49d@intel.com>
Date: Wed, 18 Nov 2026 17:23:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
	<suraj.kandpal@intel.com>, <stable@vger.kernel.org>
References: <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
 <20261114070114.3308451-1-ankit.k.nautiyal@intel.com>
 <rp6bsjvjb74hzkjzt4f7heu6kfq3q4ja5dr3zqw5qcxgrwfudf@yifr7g26q5p4>
Content-Language: en-US
From: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
In-Reply-To: <rp6bsjvjb74hzkjzt4f7heu6kfq3q4ja5dr3zqw5qcxgrwfudf@yifr7g26q5p4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0068.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::16) To LV2PR11MB148960.namprd11.prod.outlook.com
 (2603:10b6:408:40f::21)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB148960:EE_|LV8PR11MB8772:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6f1cda-7ec2-4136-d1df-08df456a8922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|22082099003|18002099003|261009223027099003|3023799007|11063799006|56012099006|4143699003|261026140227099003|10067099003|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: B7PCGcXNYsIjq1UY/3bcy4l3/qhG1ZYtRpx/kbwyhp3sUzRis9tuPS1vQGh76m+Ll/4k2AQQZJGDk40dyQ5eFZ24wT7dltXTG4/tJRQ60UGrDFJzI4/SQhK2NSDBR6omA6slJrH8jSSzuCCJPNRZqEdLLFFRjIhnFfOUrkP3fZ/urVWdmtgy274ASWVScZ1eGnORFO6yUkOjj2boguQXcBP4gDO7Bj81fKgULT61CdD+szKO1D1iTMPtAXoaKOKhCwq92V9+WsjY2S9NFsDTE4Z4UF4D1tZiZxCf4Wab3uW6w2kbdBCxlcEGC6Y6G9PcbkxwP887fmoKKu/hqMaMKV2rD8kt7Q3xLkaU9q0m9HIFB3PFlOgSMgWhDzZ2uSBfJ9OQQS7e4J1U7YjDEsxLgfvqEQD5FGXNt3GgnXC2ItlVk6YP7r98Lsz+8eA0HIpJ9DOKbgjbI8GVlvIIQ+ny7UsoOJv+/f6ZiDd67SkHWg//dNCXGmQ+SAP6FNvL9ZxrmReaYsbuhNsQ+mL7YzpWKADDfg3xtUnkwWOV15dT3lv7Nk/3BviXSSIsXy9dmGZKMoncKACg+tWSDyfvAUT5iX5984Mt7fbe9x+GkkMh7S+U/c1CIRGeEzO7FqetDMQA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB148960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(3023799007)(11063799006)(56012099006)(4143699003)(261026140227099003)(10067099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmhqL0VRTWtVc01Vb0Zkblo5UFg0cDZqSTVxallISmJmMnI1V0hkY0MxeXll?=
 =?utf-8?B?SU9kTUFYYlJoSFNJT2tlaXZNb092UzRCb1RrNGhBWDBoZW9aaTBodElFUVg4?=
 =?utf-8?B?b2xZRm0yemE3M0R4aGRHdS9qVmVXdkQzbGFkVGY3aU5FZUgvak0yK0lIYzFM?=
 =?utf-8?B?eWhUOFFkYjlCMC81NmVZejhGVG5abW44eEJiK0RnMkdhc2Z4Qy9ZUHVWdjR6?=
 =?utf-8?B?SFgwYXVTcVdwVU41L2ErNVg3NWVvQ1grMWN5V081bjFURktDemhkamlrTEYr?=
 =?utf-8?B?RzRUZHdpamFMSHh0WEpRRkFYcGhhZlozWVlML2JwVFdQTVBMWTI5NGdvZFF5?=
 =?utf-8?B?SVZVR24xaDFwdHdvM3kycUNKbTl4dmgzOURaYVJva3BBb3U1NnNndUZjMTN3?=
 =?utf-8?B?Ui9tVnE4cG4vc0dBbmVWa0tSTkp2MFpFUXFNK001N0I1RXZkWXg0MGlkaUtQ?=
 =?utf-8?B?WTlRcTVUR3JrMWZQNEcrbnVyL1g3OCs1d043WFRrWUdXQmt2dkRBS3Iwa0pW?=
 =?utf-8?B?SGl2bHE1U3ZjMmtsZzB3Wjl1c1VoNXZKcTMxdkZFWWQxU3Y5Z0JjVTV5dGRj?=
 =?utf-8?B?cml0M3JnaktNZ0llcTRaUFR0cVhsV3M5T1ZTbzBYU2xLektrVWMzbHVHcUZ2?=
 =?utf-8?B?ZFdGRE0xMnNMZm5RcnRGbGpPL1ZkK0NhQTArTnlZcjFPeEN5VzU2MHlvdmYw?=
 =?utf-8?B?NkVHUDZOenJONU5DdzZSMEhiODNWN2h3UGU0eXVFVmxMS0hyNVpVMzJZOHY2?=
 =?utf-8?B?c1B6WlN6VmxRTlcyNVMwVEFjS2xyVndOT0hYcHliY0M4SnVNNWErUGJrcUtK?=
 =?utf-8?B?bWFYTHk3dU5WN0ZGREZNUVVPRExyTDVLbWtJdnhPTGRERWd5S1FzOGRpZlIr?=
 =?utf-8?B?RmxTQ3NVWHc4K2RwM3h2QUd1V1NsZWlBL3kzVVdVbnFVRytxeFJTUGR0ekth?=
 =?utf-8?B?MldTYmkrSGt3OU4wOE1laXZkckpxV0pEZGgrUExGREdwMjA2S1FXQkpLUE5j?=
 =?utf-8?B?Vmw1U3Y0ZGEvUE9uY252MUFNYVg0b296UEtOekg2aXVncDhxR3QxWm54UjU3?=
 =?utf-8?B?bHFOYTZGWGl4cC84NUxoVEFvOFJqWkJXR3VnYnd4ajEwcCswWTZQM2tsNHJ6?=
 =?utf-8?B?L3lhTnBoVHk3OVlPSDdLNFNRdVJ2RUtDUURMMHhQb3NiS1RTK2FCQ1lUM2lj?=
 =?utf-8?B?TVdtc2lYejB6UnBScGdTMFdmMFQ1WFpGYms2cWR3RVQzd3VDUzY5YzgydWpQ?=
 =?utf-8?B?RW5ZQytUUFRuQXJnY3pjTWdJNGxncEkxZFlid0hoR0tqM0E3OTgwVE9MdVda?=
 =?utf-8?B?aFp0Nm5MN05mbDlGRm9jb0pWb01hUDBRZ0lUSXZzdkFXSndML3p4Qzc5M0ww?=
 =?utf-8?B?UHNuSWFzMGJISVN6dE4yZTk4WUZ4eFZ5bThkRTJzM1pxMTdPaWYvYThkNmFC?=
 =?utf-8?B?c3IzcVB2NWVudGh2NkEwNG04bVFmSFBQOGhjejV4R1BqZU5nTjhUdUdrRFl1?=
 =?utf-8?B?QVFNd29Pakg4bkpDMmxtTjQ5MXFrN2xzOHNIcTNyK3lxbFZ3cFlKMTQyL0l6?=
 =?utf-8?B?c08yUFhOek1XVE1xV3p6ekl0bDdwYTRvZzE3NjlSVmhFUHA5NFZrVzZIM2RY?=
 =?utf-8?B?MzFPM0RXOWRIdXBkT2JYbG9KcGZwNG9JR3RYcXhDai9tRTVsWTQvUFlDQS9v?=
 =?utf-8?B?YTRBK0hRd0pjbnNsSXdMaTU4eElldUxyanZxSEtJZFoveDg2SnBGMHhXRGYr?=
 =?utf-8?B?eEYvZnVFWHV1bE9ZTnIyYVJNYU16ZitOeURSSFJOMHJYaFRVMVkvSjg4K0Vx?=
 =?utf-8?B?a3k3VVo3N3hVSHlWMURKZkFJTkxxTEpQYXdKK3Z2TklPcVRDeEVzQXRlRTZm?=
 =?utf-8?B?b0lHdE91c09wTVo5N1lNVjlLU2NKeXBZclNtV0V1UE52UHRDUUpWYlJTbkxk?=
 =?utf-8?B?UzdIUjJnVzF1MW1LNkdSR21Pbnh4aHBhdkd4cWJWSHN3K2VkVG1Fdlo1Q0VW?=
 =?utf-8?B?ZGdZdnJpYjhmZG0wc1UwVmJ2bmgrQnpnTGVqOFJSeEVjRDA4RHJZaUo3RTkz?=
 =?utf-8?B?SGtIK29PTGk2TlpIaEUvVkkxODVZTEJ3Y0pXdnY1VkRkcDlSQitYczY4TkY5?=
 =?utf-8?B?bnBxenVtQmVoamNvRWJMM0p2Q3ZSV1JMNHM4ZDNKUjR5OW1NVDBQcUZNSWE4?=
 =?utf-8?B?SmdXMG1URTlYUDZPUVYydjFNZ1laaXZtT1pBdWF6VS82K1dxMTE1ajl5bm1S?=
 =?utf-8?B?d3NjTFdSOWpQSnBOYTZzU1drZkJneWtqV3FkZE5pZTZYbGZEazltdUlUYmJt?=
 =?utf-8?B?Y2RtSUtFVFdBK2hadzY0TzF1YmtkUHlxek9CZ3hyMk5BQ2hmZzZXK2plL28y?=
 =?utf-8?Q?hes7HIKq4ENfdtAw=3D?=
X-Exchange-RoutingPolicyChecked: OiB9smbEFYJLCIy5KiwW/331JY53LOtE0o3cYJRa55njUhGE5YX56fv1y63bAdj+ZFLl62adxSzBsCrmSDDamvQbQ2rOFe09tdO4iw+qmdybz01j0sQN1fTFJI1mGJW3+T59pPR506G0qKb4A7KBiJ+dkA5sf33xUU9ItlSJQkaL9BBm022YZtLJO/VtVzWgpm6kBPr8eIIDxK9uHdl6TDK3fMd9ku7Pcrn0FYQh8A2rQ4j7WWo9b0jhAY1iqc1BNvjV0IJ06rbWEFZkESKTLNmsuhmWZsV5/666loJHFR1iOeNwm5gtXXuNivNrMbmA9EIJZTh7suVnTRe36MH+GA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6f1cda-7ec2-4136-d1df-08df456a8922
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB148960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 11:53:18.2491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YhYLpMX7zckGAG8yJL7BH8dHWCFYQ92IM3zH35s61K7ae0rCOl/S16nAXnH9uQ6ebM3qWHFyZAdJj3MkTzCQRbUkJAlE3j2HkncPJdV2Uo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8772
X-OriginatorOrg: intel.com


On 11/16/2026 2:29 PM, Krzysztof Karas wrote:
> Hi Ankit,
>
> On 2026-11-14 at 12:31:14 +0530, Ankit Nautiyal wrote:
>> The helper used to compute range_bpg_offset() uses an incorrect divisor,
>> causing the interpolation to occur in the reverse direction. This can
>> result in incorrect DSC parameters and visual corruption on some panels.
>>
>> Correct the divisor used by the helper.
>>
>> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9247
>> Fixes: 3abe2824e1af ("drm/i915/dsc: Use helper to calculate range_bpg_offset")
>> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
>> Cc: Krzysztof Karas <krzysztof.karas@intel.com>
>> Cc: <stable@vger.kernel.org> # v6.15+
>> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
>> Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
>> ---
>>   drivers/gpu/drm/i915/display/intel_vdsc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
>> index a6556a6e45b7..7a6452557a0c 100644
>> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
>> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
>> @@ -122,7 +122,7 @@ static int
>>   get_range_bpg_offset(int bpp_low, int offset_low, int bpp_high, int offset_high, int bpp)
>>   {
>>   	return offset_low + DIV_ROUND_UP((offset_high - offset_low) * (bpp - bpp_low),
>> -					 (bpp_low - bpp_high));
>> +					 (bpp_high - bpp_low));
> This change looks sane:
> Reviewed-by: Krzysztof Karas <krzysztof.karas@intel.com>
>
> This patch should probably include Suggested-by: Ivan Aslamov
> (+ his email if possible), with his permission, as he is the one
> that suggested this fix and posted it in the GitLab issue.


Yes right, I have mentioned about the contribution in the coverletter, 
but due to lack of email couldnt add any tags.

I have asked for the permission and the email info in the gitlab issue.


Regards,
Ankit
>
>>   }
>>   
>>   /*
>> -- 
>> 2.50.1
>>
