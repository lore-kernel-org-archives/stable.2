Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DE259CB9;
	Sat, 11 Jul 2026 04:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783743105; cv=fail; b=ubpGxRihwSF8vLeErlv2sJ5mCXPjU105SCfYnwAlS2LSJ/A+hkaJM3D7ilE0I/CyUbfgkRxTkzNirgylOhFW3xmPrHSgFQZ6HASRVOOWQGdvwOmkgHrLGDJcMe/4khw7vBPg1xQU+iOfDg8/y7L7KZbWkdoblANQucE6HzryV6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783743105; c=relaxed/simple;
	bh=taKWPpc1aire+NH21xapdelcADXan6YUH/b+bxFN8Fk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MRaDNggSJ1l4cml9YnrJwYQgOIHV8qdQysfSeZbgp/ZSTWxiyuD2KAX+5sJFWYRb5AsgRMo02iYsqBxpmfocqDc/qyGSmREUbulVGzq6gxOvjptVtLZiN7MLmO+tvGNFaE15tCRIDAtcqYLI1Yrt3zRAP46qW4B7gfZ+QsTukSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+kwwt01; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+kwwt01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783743101; x=1815279101;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=taKWPpc1aire+NH21xapdelcADXan6YUH/b+bxFN8Fk=;
  b=d+kwwt01/0Vn9MiJnllj16DRcFlxBeh++RhuWwcwy8rusBFOFuq3lbWc
   ySkY5zecFjzqcseVzGK2At+cTNtejFdSvgFpUg3t5cHAEGsMrmlra70yV
   v8CbaMPkg+XokTzWtEtcJKYHynWLBTSlDBxTDZnzxMDODEt+WyrWFQGGh
   OjVEIy7hrX0JO5xvLpOQMXjCTs9Sh2par47gJTWQWplmoz2ONsK4qp7WV
   6Ii+QpzwIpKqIf7ePpdB0wh2b96zZDVqeWWeseavIkZyzdiv6yvfSOKF0
   IGjd2RyS1nTtyuLTG0cZ/yT0wC+2IfULVupzbyiMLwdNnhTDlPLmP4hfv
   g==;
X-CSE-ConnectionGUID: 1VoCSs3IS/6IawiJ4AW9WA==
X-CSE-MsgGUID: SREt1NFJQZetLAyKByi3CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88348235"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="88348235"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 21:11:41 -0700
X-CSE-ConnectionGUID: PKhBO/f/QV6yMMrWX0MTpw==
X-CSE-MsgGUID: g9y3DVv1ROGsrDOR5kbrUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254551073"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2026 21:11:41 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 21:11:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 10 Jul 2026 21:11:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 10 Jul 2026 21:11:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kl2NX4TYYgNrhPsZBIXFldTUWnxCLOw3FvdK5GItxC/J2Y/U2MD2nQRZmok81tunpFdHPEd2I3TNRKJ57KxnUUrobOlUwCIxrSJY0aPva+3cWywSWn/+G+8wIpVc+bB3I70PZzc2+AUFivxpBlyy915pNINqVOZemIicU+BofkCtKz7DFK6oMdzWDRNWpAXvLaZ5XMtVVhFcFeWToMLaLY4zIQhL50hCPUSafWCCOmXjexqyY9g1N+QWP/vXNgeBJj7f37aaGoaeY2Ddqetu0BM8Hz9YwvFARFgoErQx2AQ2J3KvX2V+o+LQ5uasB0WgPNnSi4c4mXhByNQS3y8qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j4DGGYnfV7Uh3JfFiwEvLWuVzfN0hhdZw95OOxiYx0=;
 b=fzka6QXhHZezmXq+NFVgh6SVFz5wkSlmKs8qShRf1S2vqH+l6XnmRAvxLZ3sfHHOW2efNZoUFYTVuUqhuHJVhVGFzMKVHlVA3iCrYFxLpsgdLqZdKQ4v6HlEf+pfsy1qhp//xLiOhh7KTbiaC90QPbqsbHAOInv/9Zlz56zUZxhI6+DdggiaDoemvLve9nV2Uuzpl+QNLuuc9zgSNMWcJOObGCPJi4yqJ5SxyP1TpEQIkmjUZLQuzwgX7hTfd5jVjHl7LuOQlMoMqerlQBA4QT4j/5BIFGtYfcNTBXkixvbw8QqhhAhulM7aU4I+Dq6tk0JHKA+Dqca9bGPlWRC/mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA1PR11MB7086.namprd11.prod.outlook.com (2603:10b6:806:2b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 11 Jul
 2026 04:11:34 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0181.008; Sat, 11 Jul 2026
 04:11:34 +0000
Message-ID: <26632d35-15bd-4ac6-ae47-b39278fb47ef@intel.com>
Date: Sat, 11 Jul 2026 06:11:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
To: Eddie Phillips <eddiephillips@google.com>
CC: Harshitha Ramamurthy <hramamurthy@google.com>, <joshwash@google.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <willemb@google.com>,
	<jordanrhee@google.com>, <netdev@vger.kernel.org>, <nktgrg@google.com>,
	<maolson@google.com>, <thostet@google.com>, <csully@google.com>,
	<bcf@google.com>, <maciej.fijalkowski@intel.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20260709211906.3322883-1-hramamurthy@google.com>
 <0f0e1e47-2f96-44cd-9337-c3d910f1e202@intel.com>
 <CAPBb8HkwGTC_A1RVVHUVmtbhUxfUXn5VNYxdD-RTsSkN=dHi6g@mail.gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <CAPBb8HkwGTC_A1RVVHUVmtbhUxfUXn5VNYxdD-RTsSkN=dHi6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0015.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::18) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA1PR11MB7086:EE_
X-MS-Office365-Filtering-Correlation-Id: b83d6713-571f-444e-d32c-08dedf027ecd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|7416014|6133799003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yQULwJT4WT1FOaGwZkx6O1OZzKFHN3j7eUFzgeSZC0RD7zZJ1/WfDV/eNfA9ve7EAvySeiv0Rr/1t8iwa9t1pjUik2sAmmnyFw4nCgKRI6L0g2Dlia99UQjxftjNsFl8/uR7F+tsFsdHRgrXrSrdn7MbCWNTeV2c6GemgRKrS1RYhesz6EH79FvEloRAKoKftvBGd4SGO2REmXbNJhz4L28yUqFMNPEEMutuQQaUGQI0l4CnkA7hb5NVj/uDhW/zSK39KF8ctM2MtbvTZ+iFi+KNKnSIJAOw3TokgGgqa2eZ82uF560o0a4BwHUnpC2KXjuQuOuBeW8onkgKfsEFYJa9c2GP5Wue0b/1GylkKDXkVeW6dg5kn5YNlG24FI2FJlfDVRAwSCpQb+r09+zK/AKUwmy0g1X2Hx+RkvkolvgRrLu3oS+Ze1Spfm1LePH6ynUS3c49xXuP1uiG1xMIMfSaBNz197SnQnK0fRnoJBGeGcNOjVc06Xnze7P/CbK00OuVXQBA+9JnfbIPPel6hVRgcQB96AhLXkHZDm7d5CEC3HRVnyCO6B3EC5vkWsAUXCWotVb9lAKj8m3OiFQoZfF+q+fTYnMfOhRYEl7nEKMYEfSUFjiiBG/ZwnUK1MSrNj/6egvddbWtykYQ0MAwuFgD4tDbMY0Ijwsf0K74ngA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(7416014)(6133799003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tQQ1BIa2VldEt5VnFVOUdXRStRN1c4V2g0c3A4Ym5lUUQ5U2w0N1U4WWNM?=
 =?utf-8?B?ampuUkJRMDJjNVNTS2tzekJab3dRMTZUcEVoeCs4QXhCa29iTDA1Q3UzY2xj?=
 =?utf-8?B?TkprWW4yY09JdDNRQVhvY1RsaERTMkZ0L3pQM0o3QTI4bm9jQXVqMHB1dWZH?=
 =?utf-8?B?c3FqdWVmT213YXB4OUY3YngrVnJ1TFJ3Q25pRllOdW9abGlXWUtaVWxKNktM?=
 =?utf-8?B?RGRucjlIYUVZZk1qMmhNaWZUQjBHSTZhY1hsUWdmbE5NbDhMbENUQmhCRkdG?=
 =?utf-8?B?cktmU1hVTVU0VENqUC9idSt6by9wb1R0TUN0Y2V3OHpha05yYUN1ZTRlY2Ev?=
 =?utf-8?B?eVZpZVhOaVJuZ1htaTZiWlI4bTlacW9MTG9SdDFMT1lLNk1sNHZ5aGo0WHZw?=
 =?utf-8?B?RUxFM1JibXZ5Wkg5SDcrUWNTaWF5RnRTRGl3Tk55ZkcwTFBIN2Z6c0VpVnpG?=
 =?utf-8?B?Q2VPY0FjaGFMaStXRGh1TmNDbXRobG5qd0xXaWJrdzFWeS8xSG83dVcyVWdp?=
 =?utf-8?B?NHNEaWF3QjVjM1ZzTEZudWVtS1hia1FjRHd3NjNudlZBc0diQm1lcWcvaGdy?=
 =?utf-8?B?UHlxOGZIVkx3RytFQVFma3plY0ZobjgrazJkZkRERkFabTZPVytjSUl4K0Nq?=
 =?utf-8?B?YXMyQXpjaFJ2WHpoODBSdzFQUFNBdVpRcUZ5eFhYY3dxUWN4TDRmWVhYcFBs?=
 =?utf-8?B?UG1SZTU3YXN2YUQvRS8zWHJDQklua2xoaEZ0aTRhV2RLQjExNnZYR1lScGl6?=
 =?utf-8?B?aVUvWUcySHE4cDkwdEsxSkUxVjc0YnN3cWFpeUJpYWphMmQ5RGQ0R2hRMExh?=
 =?utf-8?B?MXMxU1dvUUJHY0JhaVhCM1FDZVVtMU1VSnRVMkVrNDh3UllrWlVhVllqbk43?=
 =?utf-8?B?NEtKSXcxTDc5NUl6cUl2dFVsRFJlUmlkdGtzcmdQaHFEbXNFQlZFR1kwRDVo?=
 =?utf-8?B?cGJ2WmdRVEw2Mkh0N0EzNHB6dWZCekw3VHN6eU5lUEMveHdBT2ZoL3ZsYzVm?=
 =?utf-8?B?aFh4UE12aVZVQno3U2JYZ3hLZ0t6UzRjTlEweG80clk0dy9iT2dWaTRIY3ll?=
 =?utf-8?B?UTZSN3gxRitGektBNCt0MVp5b21BOUludWI4M0ZBVnB3eUo5ZU9VQUN1eVdi?=
 =?utf-8?B?Q0JQNk1yR1ZvUGtnclljUGZoQnBaWkJpTXdaSkRYR3JpODlsYTFLOGZFUENR?=
 =?utf-8?B?bUFzQU12YitpaWJSdzNaN3doMitGem00R2RlMjV5ZURCV3MxVTFKYmRWT1RY?=
 =?utf-8?B?QTNucHB3enRWS1ZBeFBrcThPa3o1ZFFUenB2eEt4ZnhJUmZsd1ZJRGpYeFlH?=
 =?utf-8?B?ZitKK1djSUZHQTVzNzd4YzkrcTg1ZzlYcjdPcDkvYmgvbFg0VkhNWkk1Vm02?=
 =?utf-8?B?ejdwY053THhQMEo3dXFkK1dqV2NjaGo0K1RZREVwZDhCblBvcWJvV0ZFZVNl?=
 =?utf-8?B?eHprOWtaRlQyYy9xZFlZTWtsbU93SDduQmg1TGVjZ3orblJWZ2lSakZvV2RL?=
 =?utf-8?B?U3pwK29HbnczZExweEFoYUd5WnpaMzRuUndOWGFxTmQwa212bkQzT0VJS0hh?=
 =?utf-8?B?N1RUY1VheXVteVVpeG5TM2VIZ1FTNzVjN0hUV0FZRlBpR3lweHRKQ1hndzRO?=
 =?utf-8?B?OURkUXdpUFAxMldpMk0zYjNmM1liNWRRR3drR0JzUG9ZNnZQanQ2ajhuUHh3?=
 =?utf-8?B?aFk5ZU5BWUdUK3pFb2ZKY1Q4WEdnMVV3OHpLKy94cmdvSU14S01VSnlXdk1Z?=
 =?utf-8?B?TDAxZVc2ekhCeUV1Zi8vTkRHLzJXOFdXYWtXcUZzV0ExOFc4T1U1RmdpZisv?=
 =?utf-8?B?ajdXQXB4VXBrQUROcEpJdGZWdUJDNnB3RUtvR0NJbFNhSi8yUWZPTXZqWXhs?=
 =?utf-8?B?TGVjb1hxM1lsNitoWVFoWWNDd3hnbTlSYmNoVHFBQmJoQlZYRWxuajMxcGxQ?=
 =?utf-8?B?OFoyb1VXVklRM0Q1bENKc01uNUNHWHBLVDF1SFpIYWVHMDE2WDVmYllWemdC?=
 =?utf-8?B?VUJVOENxRUZqYVFSajBkelBvQ09rU0h6YkRRcGZldVYxQzMrRkxWQVdLdWw3?=
 =?utf-8?B?b2k0V0F6SUhuY3RmNDQwZ0MrVUd2bnVibVdtOFZ3TWJLcHlZUWIvVmJSVlhI?=
 =?utf-8?B?Vk5CMkNCNFpWYVFOZ2U4Ym9QVS9VaytCVG1jQnZZNFJRVEVCVkx6MVVQVGU4?=
 =?utf-8?B?eHlDUWMvTDJJNnR1dUhHNFVLS2xEMzlFZ1NSYlJBT2tpSTEzbU9BQ1A1c2Nu?=
 =?utf-8?B?a3RvZnV3bFQ0LzlZNm13YVlHNEozd2VIY2pCeXZuREluV0xCa2s2amJMTW1n?=
 =?utf-8?B?a1Q1KzFXT1lpdWJKSVZmM2FrcHFoWW9QOUorSkd2VEhQWHl2TEN1MGdiaDMr?=
 =?utf-8?Q?s+1Q3KX5XmqD9dE4=3D?=
X-Exchange-RoutingPolicyChecked: Hq9YN7vTGEesIh561+23TX+Gym3+VFub/7DkC+BOkT8+8yFOvfhDjrkoXK6RAwcjydEdMfCmAcmUB1LX3qh11baKwvFSJfijhbnCD8qb+qwb/cU64umKyXYJFt4WB/FHL4KL/h43cNyqG4KL1kXgxmGGG+27Dc/5qrYrZIqdiiPihsv5rQsqOBIm1pLP7+o1n1+87970Ro5wl8FWlRaqgpXwNUTCnmWKqImO+ik3C4FonF5e86ZWVdu465E97XqvlduQbzRhIXXsoP/JqsoL6VQPiJcwTVIv+mBJesTozc52SVAfiggTlDw1XGH/l51jdNtaKTeTNCe8zynye0LE5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: b83d6713-571f-444e-d32c-08dedf027ecd
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2026 04:11:34.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyP2UsTNcO2sHiQC90C4ZXxsH6OQsSE9vE9f3KjD9XOFd2X6iZh50lqZHcaXW7uhMqrSRj20Tw5mUCFRZJvtMufVcMnhXk3PjdhBfsIH9HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7086
X-OriginatorOrg: intel.com

On 7/10/26 19:23, Eddie Phillips wrote:
> On Fri, Jul 10, 2026 at 7:24 AM Przemek Kitszel
> <przemyslaw.kitszel@intel.com> wrote:
>>
>>
>>> @@ -400,6 +414,26 @@ void gve_rx_post_buffers_dqo(struct gve_rx_ring *rx)
>>>        }
>>>
>>>        rx->fill_cnt += num_posted;
>>> +
>>> +     /* If the queue has fewer than GVE_RX_BUF_THRESH_DQO descriptors
>>> +      * visible to the hardware, the hardware is in danger of starving
>>> +      * and cannot trigger interrupts.
>>> +      *
>>> +      * We use a threshold of 32 because a single maximum-sized RSC
>>> +      * packet can consume up to 19 descriptors in the Rx path. Lower
>>> +      * thresholds (e.g., 8 or 16) would be unsafe as they could cause
>>> +      * the device to drop/stall on a maximum-sized RSC packet.
>>> +      *
>>> +      * Start the timer to periodically reschedule NAPI and recover.
>>> +      */
>>> +     num_bufs_avail_to_hw =
>>> +             ((bufq->tail & ~(GVE_RX_BUF_THRESH_DQO - 1)) -
>>> +              bufq->head) & bufq->mask;
>>> +
>>> +     if (num_bufs_avail_to_hw < GVE_RX_BUF_THRESH_DQO) {
>>
>> nice bit-arith tricks, but perhaps a simpler condiion like:
>>          if (num_avail_slots + num_posted < GVE_RX_BUF_THRESH_DQO)
>> would be sufficient?
>>
> 
> Descriptors are only committed to the hardware in batches matching the
> doorbell notification stride. Masking is necessary because `num_avail_slots
> + num_posted` falsely includes buffers that are written to the ring but not yet
> doorbelled. We don't want the driver to overestimate the hardware's active
> buffer count, fail to arm the watchdog timer, and trigger a silent rx deadlock
> under memory pressure.

OK, makes sense, thank you for explanation.
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
>>> +             mod_timer(&rx->starvation_timer,
>>> +                       jiffies + msecs_to_jiffies(GVE_RX_NAPI_RESCHED_MS));
>>> +     }
>>>    }

