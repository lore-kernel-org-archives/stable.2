Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793817135;
	b=WIkb2tRhNazWgWOzRiuqtulss2hv2UsI9LdOhytfeNSqMDvR7MZk/GmoLWdt0XOG5QC0
	 AAowAsAjmonnx1F5aA3NJLRg4grOTiJO4istm4DAIFXXcEdCQ6PT2TeD96eGu0QRZjHew
	 x1YQDdkIMHlc+5HXYgU6NtA0v3cP7r8w71bArLi/k/ZN8OAaGZPEqvX7nzZZ+n/BO8T4p
	 F0B19ZRxJXsSVRkYJAagbrC9SuqcdWhLr7xiF1P5hEcSEDQOYnsAzaSHRIeIxI7o5Xf21
	 em2LPzcfoAzXi5TzPISBx0IB+3ptcB+KWFvWdhBg3Ko3KiLIou98hlGv0vzvn/oQc3w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817135;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=pxuoySc5Ru5v2zvfi8LGCPhlARwNSTRglkBqu/vkirY=;
	b=jLMQrFKNlMjeYZdCsANf24ijwSWPHw7W2PIYzpn2fppLKftgxIS+NehGYabJB/cDntZH
	 C7o8H6ZhmoIlXkRrjSNNL4VXwQ+oSDyuuJxvIQ66e3GC4RubyVRgGBy3ShM1UNt/0W4lv
	 CW+e4bzbpKHUK4zXXAoQ8uvvPTMnuxn2VSRHiMozXn7+kz+WNOCwEgpnBPrCgJw5z+P8M
	 uaysbgvGt3kUiiCSdaX4ujlNAIr1TxmpEXmts51EPbSPbQmjyneyPWAm1EwhqF4Gsq1Rn
	 eLlYe4W5Z87Nq9YCKMfYajtWZiir4dP4+tPIDEHbZZrdsvbWa96i937zLK0zFnfxFRQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExqGVT8e;
	arc=fail smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4804A606A326
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4804A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ExqGVT8e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793817133; x=1825353133;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=UsQSr2JMVK8l4QQLJWXotwbKQNtqNtjoXaqT9DADlfo=;
  b=ExqGVT8eD470ouBjZ6R+ndi7nAEVIziiAvn3wyb0bW3AyJbv5GyvzBBY
   0zPMRIX70Zw/TjPQZhEs1ExMcjDUF0xI3H1/hQc0x6G7Ki+feKTBGpzIM
   H5i7kWFdCl0ii3DFUV+gAv7yNSi1Pfk7ewADkrv6KfbX0l9RGhioJuZHw
   hbxjx9Ek9/u65yPT4wE4EwYE5AYNJ5rJdfB8hBJKGXqBLm4Is/p+fdZoH
   k5ftlqCHMNKWeFQ44NOd8hn9b/88vdE51kKvwvo4ZYNPYUY8XUnzervBn
   W6kgYSlZZ2aOsZFoSKQTGQQJqd7tAOM3qTxymq0r5CumUz5Zb7qjml9FW
   g==;
X-CSE-ConnectionGUID: Vmz29Ha/T4aAt/Ws61u3dQ==
X-CSE-MsgGUID: G50njSQHRxyS+ue7GmLTPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2459794"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2459794"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:32:13 -0800
X-CSE-ConnectionGUID: 8Y87GG/VRrGfKSE8NFI1lw==
X-CSE-MsgGUID: QBOI+foYRSe6vLoc6NqLAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6618337"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 10:32:12 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:32:10 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 10:32:10 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.47) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 10:32:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3G+DWLgXIF11eeXuPtq1MgU81nI/izwAwcOANKHn5i7ctH14qR32ng+IwPbDU/lImyQ5yQ58PFEGci34UfNhdOVenjm0DHJkJtxihjz8qu+9WO7yUrn1OeQNCsuHhA0eKEdEMfynlBqjjeK7YsF0is9IrWZxmd6v+zuIHQ4JHYD0TIMricSe9xl7kxMubcn/SZQpgWpCPzSP1zoR6W79F+D6joGyC1PlacyDQ+2YD7WLqFObHHc/AsJRdXfjUgzqbm+FMndr+P/Pkvejdk7yvyCXPx2szkoS/ZNcbA4rRI/tLs9fqEyLe7xz/w7cfv10MzpjyYYzdpbrnPB/ycH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxuoySc5Ru5v2zvfi8LGCPhlARwNSTRglkBqu/vkirY=;
 b=WojVtYXpVoNFkNs4DucDVNsfiEvNCQeNKjiqJ1jQwVUL15n456xoTnrzL8d60MkKXBv24jydn7e1d6Hgy2llHePmdm9ScTKp1fM1bDJ2VDxvUyihUBLcW5ITvXdHdl0GzK3SIbqYWd8Y+I59v+bF6rHtgGc2icm5W/shHw2Fqj8hMECrV3Bg4EZkR2T93kny65+dFat6dtc8cvPjcunQBz3sOfeVaAaBkhpHbpGICuYJmoa5A1WOXBiH+93mtXE7xk5iL+jsW3qLOBQ2foc4F3E7WM7r32hf9sA8+vuKHkOw3Zw/Cvy+LqtRXPu3dw5MsveKoe+q8/yY4XWtSV/RZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7408.namprd11.prod.outlook.com (2603:10b6:8:136::15)
 by DS0PR11MB6496.namprd11.prod.outlook.com (2603:10b6:8:c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 18:32:07 +0000
Received: from DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057]) by DS0PR11MB7408.namprd11.prod.outlook.com
 ([fe80::53aa:3f7a:59cd:e057%6]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 18:32:04 +0000
Date: Wed, 4 Nov 2026 10:32:02 -0800
From: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
To: Sanjay Yadav <sanjay.kumar.yadav@intel.com>,
	<lionel.g.landwerlin@intel.com>, <jose.souza@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>, Matthew Brost
	<matthew.brost@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "Aleksander
 Czerwionka" <aleksander.czerwionka@intel.com>
Subject: Re: [PATCH] drm/xe/query: Use ordered clock reads for engine cycles
 cpu_delta
Message-ID: <aut6ItIACilWOGMi@soc-5CG1426VCC.clients.intel.com>
References: <20261102094557.2321150-2-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Disposition: inline
In-Reply-To: <20261102094557.2321150-2-sanjay.kumar.yadav@intel.com>
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To DS0PR11MB7408.namprd11.prod.outlook.com
 (2603:10b6:8:136::15)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7408:EE_|DS0PR11MB6496:EE_
X-MS-Office365-Filtering-Correlation-Id: 300935a7-60b5-4f8c-2df8-08df3aa1ec9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|11063799006|56012099006|22082099003|261102123227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: siqneqv+D00NXw4ucxh5yAXAlOGG3K29WNXGZX4HQQNqImQYexVArGxOxvBbQ32m4JAu4GTEW/z6GQH5aQTdlIGlpG+ypnwK58Och/u3kWMPl7oe4PJMaY3FS2u6XEh++C+fI9oRY5loE5gjAOSiWJafTyNCB3jZhZK0/+58ih0NvoU7C+/tQLk3IeyYTqaB9x7XZd9hjIPwEP9LCLnKRFz6O8kuuQrC+Yd1HKE/yjTeKQTqKkxUoEUhBZHbaVk4K5CyQEGV0ggaFFTcKEUr8wqyRZdc4eQG62rcubJ+li9lT6PBo5UYBtyPrCHBAlgam/oSJKNDuUUaFdFosnv+hXevUtM7V2AFYzKr8GqYuudqduraFjHS0tPYNOina2si/bAfQ7h9mESho5ExcLPHdHFbCFINd9P4w++Bpdzpfb1FWlDsFvA7YhA/RngBr0mffF3b1H4OZkdCvXPKCJWZOaA/2qyoNVKMj45uAkHxUl/Ft1X2uaDqKdbFLPAwGfv5NmoHxTSkcfNwLBjfFEanPJLUuv8mtVr2TaRD3q6+PRvrrWhIFvlGEFCPXeDpbasEIkqS+CRgweto1zAENEQz2tTXLfygO8LlXaScsESki8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7408.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(11063799006)(56012099006)(22082099003)(261102123227099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2EwK3NHTkI5NWpTVStndElXOU4yVjZNa1RQUzJyWFkyYithZ3hxTk90Tkg2?=
 =?utf-8?B?TnZJaHkvamlWak95RVRCY2l5K0NrMlRyNitCVGExMEZ4RXhJblNiQWQyZFhH?=
 =?utf-8?B?N0I4NjY5NVo5YWlYbE12UFJWTTNyS0lpWit4N2pjSVRqQ3Z4SytCdFgxMXpL?=
 =?utf-8?B?aG5FaXovRjMvYU5DZ2Nqc3hyT3NlOHNMVHdnM3pabFhHTC9VWkNsN2VRVFNT?=
 =?utf-8?B?c3BHWjU2ZEJmWkZvUjVScC9STTFKdFpvd3dmS0hWZFFEd2JUWnEzOEpUYXZL?=
 =?utf-8?B?OUtYTUJOUC9aUCtTT1gxdzFHeDZCUXc4Qzk1Q1M5UGxKQjNiZGpGakx2Tzk1?=
 =?utf-8?B?eFA3RkVTZ2VyQmNibzRaN2xqQUlXcnEwa3NiRWdDa0EwYXV4dzhwb2xCWStG?=
 =?utf-8?B?akhKT3lQYmtKY3dpcHQ4d2RlczFGcDNpTklzaXJvN0dvak8zbkRuc3FmcW9R?=
 =?utf-8?B?bGswbk1ZUTNSM1lhNWppTTcvdSsrWk01eEJoK0hyRUlMTEEwenpTTGd2djRD?=
 =?utf-8?B?aTEwbnI4T1RsUkoxRjUwMXFqUnFkVytSaENmeDBSSmRkT0F5ek9UZFlZSnBT?=
 =?utf-8?B?d0JxelpRRnNiSVpZVEZvK2M5NVBOS0ZxeGVCNnNveS9NZ08xaVVLWEhUelN6?=
 =?utf-8?B?VDJpUUU3SlJWZHJRSzZnK2IvK0g3SWV5VUkrSVBpWDl6U1cxMHZzcjRvcE5h?=
 =?utf-8?B?UjE2KzhjNVk0WFRYV3h1TTUxR1RZMDF1bzg3Q0hVb2p0MmpPK0sySi9GT2w5?=
 =?utf-8?B?MDl0U3pkUWVMS2dWcDU2LzZGcmVSeDRUVXpLTTVZNlNMdEJDTTB2NDRzRjZR?=
 =?utf-8?B?VjU1NUtKL3puMkFjNFZET1l2UkVuVHFsb1JGakpQYjVVOG5tTWx0UE9OM3Z0?=
 =?utf-8?B?aTZVWXRYQWtoR1NVSXM3VHE5SzNhampSMyt6L3RRUzVod1llcHdyREFGZGRL?=
 =?utf-8?B?ZWhuUjRFUEZsbGpWWXJnS05oY2t5ejBFcm1WWUNZNmJPbzZrMUQ0N1FhQ2tX?=
 =?utf-8?B?c1J5cHlWRCtRT3V1L0RWd25VNUJ4TS9nVGIwNnY0Qy9LMDdUTUVwNWhUNzgv?=
 =?utf-8?B?RDV6NDhEY3ZDcU5MdklNS2prN2RMWW9uMXNPNkpBZ1FBZjlQOHozemIxUDhq?=
 =?utf-8?B?S3RpSFYzR2pWTSsyMUVjbzIrdjl1VkFuR3dXV0lhdmFZdms2emdDcU1JdzA5?=
 =?utf-8?B?aFExTk5XMGlRRmpLM0J4RW8yeE1vemYwaWl6NkRBVysyT2hwb3RnYnIzNzQ3?=
 =?utf-8?B?aVljNTFEcGNQVjJwd0ZseFA1UkdRZXJNK3krOGVZRk9JUHhDeFZ5VFRBVDBu?=
 =?utf-8?B?eWdhZnNLZk1wZDc5Z1V3Yk1sVVpYRklWbk5GYzhwelkwY1R2OEcyY1hxTHh4?=
 =?utf-8?B?L3NCcGx0QUtOcWlobHJvZ0ViL3E5OVRmSkpMbVlOakRPNlR1S3lkVnZIc2xx?=
 =?utf-8?B?UWxUODNhcUtheEZMQis5QitsQmE5Vit2a1JzMDJyWUJncVBZbWsreGtDUUhu?=
 =?utf-8?B?NEdiREZmK0JqKzBwMlQrUmNxOVBLYVlJU2RzQ1o4cDlCbHpCNHIyUkFOOW0w?=
 =?utf-8?B?TzZ4K2M1cG9NL3h5d1d1RzQwS1hXQ2VONy9Hd0R3clVOdlc0Qi80NGE0Zkh0?=
 =?utf-8?B?QVdmWHd5OGJid1pNREpiTXhZK0s0bHRsQ0wrdUhjeFBDTzlwOHNlY05abXpr?=
 =?utf-8?B?ei80czFWQmZOdU5vNEFERm5VMGJkSjhpK1dQMjVPWlByN1NwT2xmbHc3K2J2?=
 =?utf-8?B?RkRUeW9kRERneFRFUTFiR3dEbVhud0JzcnBkOFlYV2JmMUxET0tUZVVFcVZI?=
 =?utf-8?B?MXhvQkhHVnQ5S2hpZHJ1V1huK0VRODNrZWFZWkNLZnRGMlRwZHd4V2g5OXU0?=
 =?utf-8?B?UTRQenV0aHEyZ05aQUhrZHJyK0FUUjZ3OVBOZ3pjSzB4ZU9tRTBVY0R2cGM3?=
 =?utf-8?B?eDlVeWVGNUlCd0NlODdGZ2kvLzlyQjc4WjBQWkVpTEE4eW9vdExDa0QrcjZG?=
 =?utf-8?B?cHl0VUFJUHF6bUcrZFBoRnFRSnR2WHhJRHNlNmZCZkdFdE5XeXArbEx5SHBy?=
 =?utf-8?B?QnU2bWVFWnBnc0Z0MjZDQ01YQ01WcnBQaFRYN2JVU3FFdUhsU2tWRVhRb1Ir?=
 =?utf-8?B?Z2ZvanZobVpBVEhhMG9ZbTVZbis1YktrNjhMUlRtUFhFMk4ySHE5QUxyK3RW?=
 =?utf-8?B?bS9wUUZNUlJyM3lrc25QaXF5NkhPMjZQWVVwTmE1QmdsTXI0R0s5a0RwSmFm?=
 =?utf-8?B?b2JiYklZUTBmck1iMHBZRWg3U0g5dm9xTlpVSWdMYmFGZFBtdENqMEdoYUVr?=
 =?utf-8?B?ZTlZOGFnMEJOUVNBQmdYK245NXp4cmtCRUFMY3FYeVNmdGxTWXJkN0RwVGZQ?=
 =?utf-8?Q?DM0NGEcs6dRL19N4aFKoHJj+WKJwaBrWMNLXL?=
X-Exchange-RoutingPolicyChecked: manW0Z269of1i74x4cg0AdrbIaBpTf6ZMG/uRdypGV71mUm2M+pwV56lFF/yoAtLK9JXi+QfLOstIWfnyGEHvA3AvVd/yQYsZTY7aA40DOUML1tAEjgUw65B86prP02PAw5Y6paaniazWn2HvHH2r5rKhFr8jg7jROfMy7PGn4bDUfRlk4ejDmlNpO1PZPjdunNoigwT1EWvdJNB53+Q38+uGRh5w4vzPsOAS0FeJPIdCunGjxifBjjmvSUzt/uSuGrHXvhYN/TWJ9izWv8oujr7ilsUmqqJIdo6ZH0l1Y1VpyEtLL/b2NaXjnIxBAykWYgNN53uiRzyH4nd7mnp9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 300935a7-60b5-4f8c-2df8-08df3aa1ec9a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7408.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 18:32:04.6043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUlXbM2/B3Vk55MSeNZ5+/FSXbT74fia3izHmFrTfBMgoiLLKvDvAKCprHkYilMdD/aXKg3hQfQm0S9Tl50jOfOaqhLY34sO3A/lagP13HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6496
X-OriginatorOrg: intel.com

On Mon, Nov 02, 2026 at 03:15:58PM +0530, Sanjay Yadav wrote:
>cpu_delta is meant to bound the time taken to read the engine timestamp
>register, but it is measured with local_clock(), which on x86 is a plain
>RDTSC that is not ordered against loads. Either end of the window can
>thus be sampled while an earlier MMIO read is still in flight.
>
>A reproducer looping on DRM_XE_DEVICE_QUERY_ENGINE_CYCLES on BMG reports
>cpu_delta as low as 18 ns, while the MMIO read alone takes > 1.5 us.
>
>Use ktime_get_raw_ns() at both ends instead. Its clocksource read is
>ordered (rdtsc_ordered() on x86).
>With this, the reproducer reports min/median cpu_delta of 1567/1745 ns
>and no short values.
>
>Fixes: 7793d00d1bf5 ("drm/xe: Correlate engine and cpu timestamps with better accuracy")
>Cc: <stable@vger.kernel.org> # v6.8+
>Cc: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
>Cc: Matthew Brost <matthew.brost@intel.com>
>Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>Suggested-by: Aleksander Czerwionka <aleksander.czerwionka@intel.com>
>Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>---
> drivers/gpu/drm/xe/xe_query.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
>index dc975f595368..9cc35fc83954 100644
>--- a/drivers/gpu/drm/xe/xe_query.c
>+++ b/drivers/gpu/drm/xe/xe_query.c
>@@ -6,7 +6,6 @@
> #include "xe_query.h"
>
> #include <linux/nospec.h>
>-#include <linux/sched/clock.h>
>
> #include <drm/ttm/ttm_placement.h>
> #include <generated/xe_wa_oob.h>
>@@ -97,13 +96,14 @@ hwe_read_timestamp(struct xe_hw_engine *hwe, u64 *engine_ts, u64 *cpu_ts,
> 	u32 upper, lower, old_upper, loop = 0;
> 	struct xe_reg upper_reg = RING_TIMESTAMP_UDW(hwe->mmio_base),
> 		      lower_reg = RING_TIMESTAMP(hwe->mmio_base);
>+	u64 delta_start;
>
> 	upper = xe_mmio_read32(mmio, upper_reg);
> 	do {
>-		*cpu_delta = local_clock();
>+		delta_start = ktime_get_raw_ns();

Using local_clock was intentional at the point this logic was introduced 
in [1]. Adding Lionel and Jose for inputs here.

Regards,
Umesh

[1] https://patchwork.freedesktop.org/patch/422843/?series=87552&rev=2
> 		*cpu_ts = cpu_clock();
> 		lower = xe_mmio_read32(mmio, lower_reg);
>-		*cpu_delta = local_clock() - *cpu_delta;
>+		*cpu_delta = ktime_get_raw_ns() - delta_start;
> 		old_upper = upper;
> 		upper = xe_mmio_read32(mmio, upper_reg);
> 	} while (upper != old_upper && loop++ < 2);
>-- 
>2.52.0
>
