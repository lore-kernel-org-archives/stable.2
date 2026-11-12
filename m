Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794478973;
	b=xkPn1cXifRBc0Tbx0Yklzrworu8NueoSKNzMdystBkLmXC1MFMKLNH4bJxX+Foic38MS
	 uMXLfhoXCbM6OIFT4BlUMPm5x4tghIQzbyUf2ttHanrIPBG2HztSYCqNn4iztR8/yt09J
	 9sm7p55fCPDFSJxDk6DPyI3F5STfjZLFwVV8hM5ZZWJUZzGjUQRXBfjRZWdJl+wAGDlph
	 azoWSIgjDrSCfF5MWR9ih+4aq4oqmAbwurDxSVvPJBaQQrIlYZTW44s71U9iISe7AGLv4
	 aNfhZLOk2Vnw2wztkclfL8KkUxDnhVFmjKjr3fotf3yR4aMJ+Fgg7t22M41+1mmxcgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478973;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Subject:To:CC:References:From:Content-Language:In-Reply-To:
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
	bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
	b=nE+g5+JpPNPT7e0iYHnniiZepjDoQ9qA4aPgVfQnZ6UTfnXXc0AmtaRWKie9am4YPxfy
	 f+tbXqVvi4mTIG9sQrIfZ3UsW0B6xhKZsmYx4FM9uPKl5MW8CwenVPIrLJuZo7YbQy+3t
	 gGTjc3vyjdMFt5aTHAX7EWA9Tyif2s1mljzGQYD8/yRx8o8alRYYeP6EJ1sG+kCecVD80
	 zNCxaUM7+DxHCxUdNQszuefD0CJWiJ+OTDDC2sktS7vEHMpL391AUpyCeXc6fQNvaDsTW
	 MTu9Gf5vQP8BiLH7lC5zfIz/9KzVBXdgTe0lhntCQNr9XQaDfgSfFj2JFU+wXcpoFFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEbKEJ1b;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TXJfhZWk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7801C606A31C;
	Thu, 12 Nov 2026 10:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7801C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nEbKEJ1b;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TXJfhZWk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794478973; x=1826014973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HY5waR1Tyvdpl8pasIy7v1O7d3VcXV3LdCvNHdxy44g=;
  b=nEbKEJ1bLJuGcVGUwzwtd3SXM6ULV40MvyP32pwhtioFBtGfkTLRBKRc
   LSlMXdz93o/1qmqlGLadzzFET2id7oeaAOQcP8jOomKMtyDZ9UJjIKFEv
   RUPIR+pjL8GmUKBzcgJrTKYKljOquuk6imwUuEWhOZoL4SE+BUc6B+E2b
   5Y2gvznJh8F3qDz3Pgbkt0OWF/g63spnkzc75BC/N+2d742ldCrMFzaHY
   hs6oH5/FZNEB/Mw9NKBRxZVMCPlvIZYxP/+/KbCKM50hChNT/E9kWQwA8
   Hj45cvAozv/zbPhRd6fD95zb8SJyVNLuaCLrHdhBRfRTXAoXqR4waeel0
   w==;
X-CSE-ConnectionGUID: bcfhNp3ARESAG7zbgDcFTA==
X-CSE-MsgGUID: J+4DxaYERgSllislPJkOSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3179901"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3179901"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:22:52 -0800
X-CSE-ConnectionGUID: oCReWnkRQ+SUuki/d8pk3Q==
X-CSE-MsgGUID: yq3c2tD0QlmjKVJyWF915g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8966493"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:22:52 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:22:51 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 02:22:51 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:22:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEDJw+nH42h3DmIaOtD25Zoi2L9PhZqr7Tvd5N1nrXzedGvkATvSTv037Luz9BqW6WJCW65wEqA8AK0KoTBgNAj6rH0s0dFRIf6TVx8Qb+fz3Zo40AIeDHS5/s0eoeL7lV4WwRHOCNEElwnlxpd3OzChoZ75iDqqvdzT9dDOJx0J8sBrIxOPSQkagycYqGql6QL1zlvU0cbcN+3S4BxArVorQ9OgsQBzHtrZ0M6Y9o/rza8UiqzPOb+B4PG9obPzNZ6BygSbkpS9pts7mKlF3j6cp5Ckp+FZlPuBo3VxECc23/yGDzYA/kOXf/Nzwvafwa68Pp626feKN8l9CV1/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
 b=oz5G/avZPOh/WLsdeYZy7xpS78IuDOsRtI9SCBMgkPHRHdrI+pesFqZzlnuL+pIO9bg3is35PMStGCjYhLZNlDQ8oh+/Y8+M/NHrJrmtbvWDGCepT171lTxB/NEhssvhpUWZkTzv07teUyjlwC+f1Glgr4Aid/mq+nWLNWdKoU99R/hvCAVGfZEayvi1QbmYmknypOCAtFyc8LH3nbi7kUSOISL15XHxyBGVoUY2sx4DeIBelIWh3KRqAIsvdlvixaglpAMnKBzHatHRCxnEl8QqRq5z0hSYHRAABgk7js6f9hlqGoCsvjLR9He7zLa7EFKDaxIOkTyKRrQboynIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOtvO6rEIRBMiwrSUVckgxceTSMvSqj/YwnXzhSHiO4=;
 b=TXJfhZWkI4eXyp8AnKNxbC6ujk9lO3wu4i0pGon7koFSF6VwjJut1/IUns+0VY4azhoWM+PwQJTcrqrrS4WPoNUHr864cl+czpHXoR6Tb3Q9x4/StjpuV3byfU84N9BukKm07nHLMfUXRraXzVN4g6SScjwhk/MPUPlPzE+Cxbc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:22:47 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 10:22:47 +0000
Message-ID: <2432bda7-8867-44ff-bd86-1897995d3acb@intel.com>
Date: Thu, 12 Nov 2026 11:30:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] idpf: select AUXILIARY_BUS to fix link failure
To: <darren.worrall@shopify.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <intel-wired-lan@lists.osuosl.org>, Eric Dumazet <edumazet@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Madhu Chittim
	<madhu.chittim@intel.com>, Joshua Hay <joshua.a.hay@intel.com>
References: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20261111-idpf-auxiliary-bus-v1-1-e76b940fc929@shopify.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0162.eurprd09.prod.outlook.com
 (2603:10a6:800:120::16) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
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
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|LV2PR11MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c8dd34a-ef90-4b06-c81c-08df40a6e5c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|6133799003|261009223027099003|56012099006|11063799006|5023799004|261028144727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261022105027099003|261021135927099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: mDqhs2uZwybD9yAQyLds5vz475pnc90LAa2NEJAKYj45jwaiqurMFXOixJ3bxp2qX9n2Il3xJpaQuxyikUm7P8uCL/PkYL8hujOd6GDIdta8rnT9/VxHltW7ac4eJgMWo2nbVjh1mSrjWFYIZ0zCrJXSaLyjZvJtrByq1I+YeQPvr4/MAg9b1Q49qsC+ZJA/1HtCZkZFxHYcgauSmm7b+XwbaW3/cKGP3/J+U7nRCr9VlBK1z7ssjnM/C2zIq3XbNaJuDftGD0gayRzRjCifIY7HECmxxrDyFWBgosxb7gjhB9IffPzQgO1dIeKNmeYSPcfaUX1VA2VtTp6scWkXKqQfdpoF75ZfS+r0BpW2v89sauIKYL2zOMViG0L5BC2h1/uYfkdoktX/6rmaAJqynYC8k7mAy5x+l6vJ/Nx9uYyK53h3QuZ6bvG0574SHRmBsDZyzN70oZo1n4td9w/gmgsgeedEJevf5EFY224cGeH/IyRONN/PBvdKYQcE6rtMjr8fPhhX8w8rkBIDtNOzF+UUARZ8HhTIUlL9aaJjMTTyotuYqaFe+fFnWPzV7wFBXGbXhxl3slGvIqbqRqwVLd5zbR46m7dgB5GrRHjb4hQEI5K6MFVhJRWVDimgGB8Al7fN91l2IBniMwvPXdSqDY5woG0Y4yrrkPleKJ2rFuI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(11063799006)(5023799004)(261028144727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021135927099003)(261022075727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThkZElzUWtrNWEvUmV6ZTVOWGNZbmJpQnN5Kzl0NkZxTGZRRUVlYlk5UzR2?=
 =?utf-8?B?ZHpDTUNSeFJzcXlldWE3VXQ0S1hFem5zNStnZ3dtSko2dlRqaUN0Rjh3ZTZk?=
 =?utf-8?B?cm5lTUw5WHY3RzYrSjMxTGV4cmlvRHJ3YnZGTTNBYkhRY2FwcDNsOFhJeDBz?=
 =?utf-8?B?bzkyVlJLN3pJYkJHOWk2dDBtRXpGY2RzdFEyNDRyYUZ6eVI1VDladmR1L2Q0?=
 =?utf-8?B?M0xYdnpGVXQwcDlDOUhuYkpxWTI3anBLR3RBLzN3c2tEWVpUenpCblMzMTBs?=
 =?utf-8?B?WFUzS0hyR2RhRUQ3bkR6bDZRMjlHbHA1YW5TcDRLa25YUkhWOEw2MXJKWmRB?=
 =?utf-8?B?Rk9KeUxhWVlhNmRFQ2tCMktjZkNIZjRNSzJBQlA5MUMwR3AyZGtxZDI4SWNz?=
 =?utf-8?B?QTlteTNqbjlZcTZlOFljN0dRMFhZTG5sVE1hMkNLcDJGVjFmZ0dlU3VqcXBL?=
 =?utf-8?B?cUdrWm50WGttOVpFcFFyaDlNVDBlOFBBeEdsaE91QXFmcmk4UlRHOE9mL2ow?=
 =?utf-8?B?ZDBQcXR5UTRoQnJiVjYvWTJDUzhTek1sazI5UTl5TEg3TFV5Z0pjY1d3YnZ2?=
 =?utf-8?B?ak9MVEdCTTBGOVFOVktTWkptMDZIVnE4cVRlTHlOcStZVHdQTDVqcno1QXNB?=
 =?utf-8?B?UHFVd0llcnBLSW9LR2VIeUlmTkF2RWpHQ3hrVUpFVTl0U1Y2cHdaY3llMTlN?=
 =?utf-8?B?dDNmd3R5VGlhcTkwaElrUWtMUFRWVEh0MEQyMGdNVW55UFM5ZCtlbnRKcFpC?=
 =?utf-8?B?YmJtRXhzMHA0MGZCWkhiMUNrYjJkRHJ5bUwyMlk2dDJ5c3pkL0VPVWFyd1JX?=
 =?utf-8?B?SEdLRXF6cnVWeDJHMVR5WTQ1OG80dXo0VFM3SVRaWEpLUXozVm5ZTTlEanhE?=
 =?utf-8?B?Q1dPZHdYa1B1ZkhHTnJUWGorbytDMlVzREU2MFBBWkJMUVMvWnZrdGYvako3?=
 =?utf-8?B?b1UwaCs1UXBROHRGbkZldkJad2R1ZlJIYWVGazdKQ05rRjFoendDcFBVVUN5?=
 =?utf-8?B?WDh4ejRNSzczQzc0cmVnVHg2N1d2eHVrU1oyLzRWdUZIWmRtQm1lU2NaaS96?=
 =?utf-8?B?Tm5LWFVFTnIvT2ZpMjdXdHRvclJ2RjZqSHlNL1BraWdHNEt5Y0JoM2xBcnRN?=
 =?utf-8?B?c1dYaGpKTjkwV21qeUxIeUpON1pha01acXhrRE5LckZXNXR2WGFDMHErdTJx?=
 =?utf-8?B?UDlEQStzMnRLdytDdVNsZlZXVjFwY0w1YVNEaEVqZ0MwdXBWUUJkOHhQTEhP?=
 =?utf-8?B?bkJzeEpvOHpkUU5IdHJBbE56TUMyTlZzUi9jM21WeWNINTNYSWlKa0hoVXlw?=
 =?utf-8?B?Smc5RWViQm9pR3dwM3FRWnNaM3l1OUc0LzI0RzRiWEVuY2tmS29nRVE2R0dB?=
 =?utf-8?B?TnBNNVV1b01MMVlIOVZVNWsxYmhXa0UreFFFRGpIc08zZjIzSEVVTXRTNGJZ?=
 =?utf-8?B?OGZpMmVROG9Xd29DbTl4MVJYQSsyenJkRmlVK3pCd2dkRE5nK21ONGpWNUx1?=
 =?utf-8?B?c2RyVDZoM1ZUVzkxKzB3MEF4Vm9GYllXMVRGcGFVQ0VyL1pqRVcybXBZT1Qz?=
 =?utf-8?B?Q0lITTYwaGFES0ViUnQ5eWFoLysxTGs2MjRselVwMnZqOVVNNU5HdzdXMSt2?=
 =?utf-8?B?aEZWNGY2T0NmOGg1aGVIb2habGV6eUoyVEtTUVZIOTQzS29wdWx2RWo3Uk9k?=
 =?utf-8?B?OWNIbkM4cnJ1UkVOY3VPUjBKaHFCY3FQUHBRaURHMXNiOG9YZE1vdlhWSTJO?=
 =?utf-8?B?UVUxb3ZHbkZsL0hyd1ZnQUw2QkZRejU3dDBUcW5QZnpEM2ZTejhCZ1pzWDlm?=
 =?utf-8?B?UnZEQzI1emgyeGY5TmFzczB2ZkxIUDJ3Nlo4Z1JLZkRxcTQ3dTl3SFN3Rksz?=
 =?utf-8?B?cXg3d1A5THlZc1Q3cjVrN2xKRGFGdXIwdlNkRVFtaDkydE41RTdEZEhGVnMz?=
 =?utf-8?B?RUhrVlM3Wlh5NHBrb0hIT0ViQktOS0N2RWRJZ2dvc1BWMmh2Z3hTbkYxemVT?=
 =?utf-8?B?RkhEai8yelpNczAzNHhyckRzbXA3UG1lVTUvSG9keldpdHVOZVM2NTRzVWhy?=
 =?utf-8?B?VjREOTJ5ak8yTFU0eDZVblBnVHZGajBUekNxWkFBNFNBTk1yYm1NY3BqVVY4?=
 =?utf-8?B?eVg2RWxTRzhGRGswYktNbmJYME9ERGFHZmtvUVJ0bVJ4blEvSTRjTVdHK0VJ?=
 =?utf-8?B?Mkd6SkxmaStOUC8xUUdHek1UajZGajR2c3RWU3FOV01PV2MyR2llZDNzNkx2?=
 =?utf-8?B?VXgxWjRCUmg3S2N2N0krS0VwV3g2d2VmSGdqVnh6REw3eHJlY1l0eUkzVXU0?=
 =?utf-8?B?eFRXc1NLRmw0eFpBaUd5bGdUQTZUUnFxaEFQVDdTK1l2YzVkeVFkbyt6Y0d1?=
 =?utf-8?Q?szzlenO5g95ArvR8=3D?=
X-Exchange-RoutingPolicyChecked: MzCaQv7KjloYJuTyp+FiUCx8+WaMqpVEaQCm3trr6W9Owt8tyhTUW/RxoqAYq+b3hO9yOYe0Ngq1zla0SeH1mgkXVel3tvcxwHRFlzcDdlzRcwt+M2iyi0YE3/XHrvFcfgHwJohhgIBZFsvBDqVfXFN5yzdBd8zsp+s6J3u8AT52RipBm/QyiUcTS4FpayIeKvgJqVOWJFCrU0siTDzdOEbtCeFz71E/ztsg5cI4b9475+R7Wyeb34+9M4BskTZSRnX/KJzecjfj74wtGlj7SeGXS+vDzwYSaFxcQSP0cKP9R6RtdhTr8oVC1iNpf5q4sqYWeyWTW8rxc3y6joHNbQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8dd34a-ef90-4b06-c81c-08df40a6e5c2
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:22:47.5558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wCgLupvkvWbWU9v6Yziu5XFh5pP+1S1KlK5imE1wtSgpWo+2GghvJbhMa83PPMwzsUi0QWKiXFV5Wn2+NrSBnHc9mqwUBFdFMagmx3VeFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
X-OriginatorOrg: intel.com

On 11/11/26 8:31 PM, Darren Worrall via B4 Relay wrote:
> From: Darren Worrall <darren.worrall@shopify.com>
> 
> The build can currently fail with
> 
>      ld: vmlinux.o: in function `idpf_plug_vport_aux_dev':
>      drivers/net/ethernet/intel/idpf/idpf_idc.c:82: undefined reference to `auxiliary_device_init'
>      ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:86: undefined reference to `__auxiliary_device_add'
>      ld: vmlinux.o: in function `idpf_plug_core_aux_dev':
>      drivers/net/ethernet/intel/idpf/idpf_idc.c:223: undefined reference to `auxiliary_device_init'
>      ld: drivers/net/ethernet/intel/idpf/idpf_idc.c:227: undefined reference to `__auxiliary_device_add'
> 
> if IDPF is enabled but no other driver pulls in AUXILIARY_BUS. We hit
> this building a minimal kernel for hosts with IDPF NICs. It can be
> reproduced on x86_64 from allnoconfig by enabling PCI, PCI_MSI, NET,
> NETDEVICES, ETHERNET, NET_VENDOR_INTEL and IDPF.
> 
> Select AUXILIARY_BUS in IDPF, as ICE and I40E already do. The same
> link failure was fixed for BNGE in commit d7065436e8a0 ("net: bnge: add
> AUXILIARY_BUS to Kconfig dependencies").
> 
> Build-tested with that configuration on net-queue (dev-queue,
> 34a70a40c954) and on mainline (067c5c24cef2): vmlinux fails to link
> without this patch and links with it. Boot-tested on bare metal (AMD
> EPYC) with a Google Cloud IDPF NIC, using a 6.18.60 kernel carrying the
> same change and IDPF built in: idpf probes the NIC and its link comes
> up.
> 
> Fixes: f4312e6bfa2a ("idpf: implement core RDMA auxiliary dev create, init, and destroy")
> Cc: stable@vger.kernel.org # 6.17+
> Signed-off-by: Darren Worrall <darren.worrall@shopify.com>

Thank you!
Acked-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


> ---
> The link failure was diagnosed, this patch drafted and the tests above
> run with the help of an AI coding assistant. I reviewed the patch and
> the test results.
> ---
>   drivers/net/ethernet/intel/idpf/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
> index 586df3a4af..6b59173e0d 100644
> --- a/drivers/net/ethernet/intel/idpf/Kconfig
> +++ b/drivers/net/ethernet/intel/idpf/Kconfig
> @@ -5,6 +5,7 @@ config IDPF
>   	tristate "Intel(R) Infrastructure Data Path Function Support"
>   	depends on PCI_MSI
>   	depends on PTP_1588_CLOCK_OPTIONAL
> +	select AUXILIARY_BUS
>   	select DIMLIB
>   	select LIBIE_CP
>   	select LIBETH_XDP
> 
> ---
> base-commit: 34a70a40c954fb8044ecd124840a2c38cd3aa4cc
> change-id: 20261111-idpf-auxiliary-bus-c0058e27cd9d
> 
> Best regards,
> --
> Darren Worrall <darren.worrall@shopify.com>
> 
> 

