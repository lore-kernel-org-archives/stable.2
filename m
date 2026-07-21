Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0905C78F26
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 03:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784603937; cv=fail; b=i4O/ul01kIvwHMQ65Gdi0xtxMMnq0Gv9lrVYywIIPNLo04teubHlXtxIRKBqFRBYgtYDQGOjLcR8rWTpK/GiF8T34Eaz4HdMgt2fQGqETH3aCrzMqfYFIf1TckdFZi6uiVhOQAO8Mm1rWRF95ZZqbX3o5GHzOIJ7l9RJmbJ8ers=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784603937; c=relaxed/simple;
	bh=BO2P2mrk9S2u3+WCy9i0R8S04kH83qXMUwaXnua3oQ0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qHSjGXdb3zqEo3zYfuMnJehC3A5dvXvIMUvY7/jmg+pWhPO+TjbMIarcpHTiZcwnSnPlQcz8sZ8GheRxHXdiM7x1gLlk/4owTmiN11fD56cJvDtHw14vurYfnsw2djovqpycaJaBFOZaZPz41hUwXNYFtXAXjnh+c5HK7rIM3uY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyoPEBrg; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyoPEBrg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784603935; x=1816139935;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BO2P2mrk9S2u3+WCy9i0R8S04kH83qXMUwaXnua3oQ0=;
  b=kyoPEBrg/TXhDJ/aHalX3oNUuSEIUuabaXWSxz1MldJH3tKpqJ0eMpO2
   RnvA8aUzf+hitQutKsQGupa/FQovEUjQy6A3H9zQLRAaMc4YEA9VfDZ7a
   QIuS8vXGToCn/NId/Aj2xLH1oVKMlTKZAt6RGLzkqRzzVW7oyf5sRSP+Q
   DujjPHKMwwsYSh+Bc1na72p4hWjdgfrOsi29lgP8sRMUGszGrBgrK2AVM
   XE2P3xZV5r2G1JsXAifa3dy89r2JeN787u1hWyyO/ZQxWkFvfWzyHm7vb
   /I82KKzPp09eP8LV6cPVBhjBSH6tjoAohVcm6fbPyTmvNo/yPlDWL7qYP
   g==;
X-CSE-ConnectionGUID: wzaHiv02SY6ragFSN+i3Sg==
X-CSE-MsgGUID: stQbfw+5QMC/fL2GTjDYUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="96327346"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="96327346"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 20:18:54 -0700
X-CSE-ConnectionGUID: FaMqgt8hT1ObJFZ746kL8g==
X-CSE-MsgGUID: IWzmCgMrQdai5u4f1Qo64w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257067999"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 20:18:55 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 20:18:53 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 20:18:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.68) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 20:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1Jc1ae2M3ici1NJyvONNNgFmOALr9sOxDHQBMRPx5LTSrwIY5zC+NfFbGgu+Zo6w1pFRR7thkaUsVhTU+bGGAboqJSCREnppCap5BT+RZHPzpePQZVeQEKM65GY0H7KbY5QgS0WLcfncdWkutSPpgK9aELK6Pkt1xn0HWu8uFEOC75Tt0jsA/LSzcntDED2scx0MuvgSs/315CWXr4xit1/a/YhW8l3sZPNyJAm1qfSfEJ+bCRE3z6ySSjKXNZV5dCYfKYMDZUXv4/baAoc8PWxIAaVVQSxqHGxKu5kHiIknSixekeEOrATshRIPKAVVmj8Yzfl3YhEhleKXJ75ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niabzXFWOExY4+kgO0i1suPUtWeLmAEd/RN7UZ0KF0g=;
 b=TaofjWkO9jzYnBW/hQQKfZNHiBUsNC205TtmWzPFEMxgG8dgJoc1oNTaL790Q4F+E9kkpPqpphA91fHERvav3c90tx1+Y4zZHskcgMryHPV26Dia15Cx6+JXAUaillPY19GPzfjQTHKsmSetlEtxLmwpl/v04PJZ+zAZBS4POV+WGl/o9m0kFq4u5nSeP8F4Y8XC0hhYE4YSXwqcYU6qZKL5mK1GDuqNy1L6Vk38JwnENsDc8BWWj5EHB/AMCZ0sotZnIu/K/a6B2lALbCt+yNdmh4asVx2FP/Yir5XmiYxzYccIFJlqSMddqpSjGyqkBoLj2shSJJEw++x5LB1+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) by SA3PR11MB8076.namprd11.prod.outlook.com
 (2603:10b6:806:2f0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 03:18:50 +0000
Received: from DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983]) by DS4PPF691668CDD.namprd11.prod.outlook.com
 ([fe80::a3b:efa:42d5:e983%8]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 03:18:49 +0000
Message-ID: <2b97703c-5c67-4258-8224-56325f47f6d4@intel.com>
Date: Tue, 21 Jul 2026 08:48:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/gpusvm: Fix MM reference leak in
 drm_gpusvm_range_evict
To: Matthew Brost <matthew.brost@intel.com>, <intel-xe@lists.freedesktop.org>,
	<dri-devel@lists.freedesktop.org>
CC: <stable@vger.kernel.org>
References: <20260714170025.3487974-1-matthew.brost@intel.com>
Content-Language: en-US
From: "Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
In-Reply-To: <20260714170025.3487974-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0217.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::8) To DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF691668CDD:EE_|SA3PR11MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: d370014e-cf3f-411b-ba9b-08dee6d6c8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: epOWBsHuypNwMnXkLSDoUMo4uUQWYMDBUcggrO3zx01l6p1GNU4VgQclj2FBWZzIiKw/XFYAApjGchQ/V/N1uJueVc7mbYrgCi64Eiie/jakW8/3/rNenlIZa9VDdWdSKiHiZRnFtqvt+tn367LDKw5TIelsdkWyoGBd/KeYqTEYmgKzcgk885sMhBzZSmfssf6G41QAiMqUB9IMaZDo/ANWcY/29arINGTylVOYnInZdJ+V2EJg0QPJJ74UM6UGzn1lPNDY5QdW17JNw0fy/n9Gia1kS99I8caI9trZ+2GIaLRGe9cLBygjtLvgrwkSgfUNOSbPWFov9DsZZkSbLtbVbejpbTUVmMRkRXhNYGsFfw8ihwvVRKTBe0DDzweTjofBjgxpfwcFkEF83SUUsnCOLq7R5b98i6PCPEI0u1sAk+dmbt9I+C/0JVxHg5YIPUnxGlZ1hsX1a7mNkCkv1W/VpsVhjMHfoAu+eJ69kOtnvrkdgpuwr8nzzrc6IlmOLzp6xw78xptNq8rlAn3T4KxnqtohEhYm5l7sFq71TiY0dVeIyPA8fBTaskoRfRcFsE5Ft6JNqtSlHQ0H/gU04mLyjgtLYQXIxWPaCjauaXB+fEzhMoPwTddKOufJ6jclmAiROjt4T75nfgzCgUcjHZRs+aPVZC++t1SVeHv6Cf0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF691668CDD.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjR1ejhrYzB6aVJTUnBjN3pLZHBLd0VMUjdPNktUaTZFeXltVng2azZCdjRa?=
 =?utf-8?B?WTU1Q29tTVN6dnAvdE9LMHFianRPTkgwMkJJa1VhZ25oQWV2Z3Y3U2ZYNFBD?=
 =?utf-8?B?WjJwQm5WREQ2T3paTU96TlZCcUZuaW1IUisyMHA0OUpYVmtNKzJJaGcxM0VN?=
 =?utf-8?B?aFpNZmY0cDdweXcyWG1idVIrZlpWTVNWbURBZjBwUnlqaW1TRWZ1TnVMK1V0?=
 =?utf-8?B?SXllTHRYd3lBWUJwd1d5Mkk4UmhjOEtXdW0rMThoMEFKczRydmJyQm84aWgz?=
 =?utf-8?B?b1ZTNEJiNUVEakF0WkR3NUdrQjREcUJDM2dGMjZKUTFLQTQyc0JLeUVXZWRq?=
 =?utf-8?B?Y1A5R0JaQzQ3ZnY5UzZlMFVuZ2h0VVBIN05NcEpRcXlVR3UzMHNlVTRqaTVw?=
 =?utf-8?B?S3JpNEFtTUt3cE94cFhMNVVvdEF6ZTdRd25SN0dCWmYxeUcyWS9DeWxvOVBz?=
 =?utf-8?B?ck0zTE0rTlhUN1ZzanBKdTl0dTQrQmg0elBMT2RYS2J1a3dpenlzaEpraFFZ?=
 =?utf-8?B?bHhXaUIvZTJxekVqUlhEaTlWcDBKS1licEkySVkwMmEvMWFVTE1KVHF2KzJ3?=
 =?utf-8?B?Q0gwd3ZRZzNJMFZBb3VHUlMzUXh0OEpGT25jM28vcEFWc2JBUUt2WHZHRkhy?=
 =?utf-8?B?aXpPUUtDa0t3UzJ1QjZUVUxYeGhoSnoweHZVa1ZnR2FabXdldFNFOThwZDFB?=
 =?utf-8?B?bStWNGl4MDFEb1k5Z1lmdG5hczZnRTQ3Vk5ibDBxNyt6T3lhWituODJ0Y0pL?=
 =?utf-8?B?eXQ3dEI1R0lkTW5QSzVmaXQ1Wlo4TXdPbEsxcFI4RXl6QTBMek9IVE14SUg4?=
 =?utf-8?B?UHpPVUE1RUdLeENoRE1JcmpUOXI1QmdXVjFlcThPcmxnT1RRL1ZrZFBMSkhJ?=
 =?utf-8?B?eEdzQTFKR0pIZFpYMFNnYlJsekMyaytPOTFVdTBHdWNtR2JzQ1plRDdGN1pX?=
 =?utf-8?B?VExqbU5uVXpyYkJFV0ZKb0Zpdk84YXMwQkR0aSt5S2ozbVVBdkdWMHFRMGkw?=
 =?utf-8?B?SndoYTdsS0RYRGFhYlFUb1NYbmZsWWNOWUpXWEg4TzB0dDEzeXB5Q1d1VzZQ?=
 =?utf-8?B?M0tiQ1g2V1JMOXFORGNrSWhOVE9ralhXR1FjSFJVK3RaejBwTXcxNXJ6R0U3?=
 =?utf-8?B?ZkxadTFNS2czVFFnRzNPZmdrbCtxZGVOeERFSG5iSDFRVEVlWTVZOVZ0Zzl0?=
 =?utf-8?B?OFRTc1dPckZqYTBnTTdmamxFRGVQT3Z4eXhRUmVmM3hXWk5ETzQyb0d0Y0Iy?=
 =?utf-8?B?ZWsyODhYdms0K2YyRitwWU5mVUpGNXZlc3JJT2tRVHUyOFJwZnBjTitwTzRv?=
 =?utf-8?B?VkMxdWlKS0p5STFpZW5zNmx0SWVxcERMU01IajlGa1lCNXJRcHpZeFBpTEgr?=
 =?utf-8?B?ZzROc2NBWk05cFNEVjg4TmRGb0ZrajJCK0IxK08vSEMwZHRSVGs3TzllZEdD?=
 =?utf-8?B?ZUJiS1g0Wnd5SWpKdk1yOHhueXhlRjl0VEpTQmpiTjYyc25VN0JtSThqU3oz?=
 =?utf-8?B?T0lXMVhhaTFlVW5JYm9Ra01yV1RJQkx4Y2oybzVUaEdjTE1xUTVmZUl5enF4?=
 =?utf-8?B?MDRRdEdDT2NQaVRjaUZnWnZXdisvZHVsdXZ5QWFBOG1YWFJqbmVUZFJUZy9p?=
 =?utf-8?B?ZkEvYmhFOE1ld3hwRDRHTU9LYkYzcExsTVAxazBsWkdySUtTRWhhSk5Vc215?=
 =?utf-8?B?ZUFzVUZ2b0pYK3NsOW1VOEVWSjI0VUc4cHBVK21zbnNYb2ZuMUxDUE54a2xj?=
 =?utf-8?B?UDZwWlhzd3pmMlZyenNhQy9QM1RMR2M2NitWSE5KUlJEVG9WR2t5SFR3SFRS?=
 =?utf-8?B?bXAwa1hTQ09wTkIrSlBkKytINWU5dlp6VmhmS2F0MUhvSGhqQkdHZUF4SUMw?=
 =?utf-8?B?THRlNUtGbTBtSGJweUhBSlZ4SXNUS1BCYnpxd3EwVjA0dEdGOTJRMTJqWW9k?=
 =?utf-8?B?Z2Jub01jVE5XVVc2cENOQXJPMXJmRGZEWTRubE9MUDJCZDFaY01ROHRRWUVs?=
 =?utf-8?B?ZXVPUWQwL3pNcVdUR1d2YWVubkV2WWpMZVVmVE5LOEdSTDdldzlIa2xRTFpq?=
 =?utf-8?B?ZExsRlgvWExUS29PcEF5V1U1OEdQeEdNckJ5blBKZitwdzJFbm1pcC9BNUc3?=
 =?utf-8?B?NGY5eFFzNHBoMHkyUjNqT0F1Y2kyUVluY1pQeWxMdDlaQTloVmdOclFSeURh?=
 =?utf-8?B?Nkx5UXgwc2k5Q1BwTDIyM3QxT2Qram9MQTN2K2NBNkxLdEFRSW1VRXBweUl0?=
 =?utf-8?B?U2hHYVRUUENRMnh1NC9oaVloMlNiaFFiQ05TdU5PZlVDS0dyRGFjdTFvdWRT?=
 =?utf-8?B?dDF2QlhiWjd4MnVGRFFiMEZ1bDdndDNCR3FabDVCU3FReVpTdGxBV2xYZncy?=
 =?utf-8?Q?mEsA3Ucame2px470=3D?=
X-Exchange-RoutingPolicyChecked: fVDlOT4Sj2BQGjWGlEIr7YLhvpWe/GaYKdgZEpJrLYjqp35fgFVOp8FdNQYOofQGQZMyMnbODtuQRvU2xE42dZOpCw1xWsFeu31nUorI5u2GiyqTeAClPzFcPVB8dhym+GSKt+f2u4b/DSIopaGNUQhbOBMmmTvYCnoSWoujDjicXdar0u8pGx6IXYpTrBKaf+bP5QTga9z2UNp/Q28wNXJtjqLk2Y2Ey+PF9Lkqxg5nVEutq9Vr3YlBX60l1pqfNHGbCsymCw2RfcRi5VWoDbXrOgd73hRoSkU8b+vTx9CR6hmhUk/hsFaWlY7FqAQHmKfuCGsJuOAT2BUGO5d/Ng==
X-MS-Exchange-CrossTenant-Network-Message-Id: d370014e-cf3f-411b-ba9b-08dee6d6c8a2
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF691668CDD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 03:18:49.8737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EBiakAUKWuAA3gMnMQuGVyUvpsjglQccjXgidUc/X3iJStRzg3ZFGm5aHGGOxptC5efM3R0YLOeD1c+c/+2jYKyHWnYAI34n82Z79YI8/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8076
X-OriginatorOrg: intel.com



On 14-07-2026 22:30, Matthew Brost wrote:
> If kvmalloc_array() fails in drm_gpusvm_range_evict(), the MM
> reference acquired earlier is not released, resulting in a reference
> leak.
> 
> Fix this by dropping the MM reference on the kvmalloc_array()
> failure path.
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/drm_gpusvm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index f45bf1d59a06..ac1f135abe68 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1778,8 +1778,10 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
>   		return -EFAULT;
>   
>   	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> -	if (!pfns)
> +	if (!pfns) {
> +		mmput(mm);
>   		return -ENOMEM;
> +	}

LGTM

Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

>   
>   	hmm_range.hmm_pfns = pfns;
>   	while (!time_after(jiffies, timeout)) {

