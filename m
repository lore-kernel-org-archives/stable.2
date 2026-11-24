Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795521094;
	b=XY3dYJ4s7OBt2XbIkck9aLM3Jn+WOifnr+Y96j8n2Tfs58r3QVHaLsimz0lEP0bZoThB
	 CwrwW/m4s0VfH3e6tnpTOeO1IMD72UtImtem7tNa4VGx284FuzyOvqFy5jvlE4FzUXpGC
	 wIdt/UYCqvLBav5rfopPdioYSspYYYL+L5O4N+RWvzhXlRmILYwU0jg/7kH8A1ZaPJmiy
	 HJVyjOVOpFTTKI9I3btmHBOp6TSINi+aSDsT9dRxiOHGel2ZaU4+VLemIO7mXN1aWT1na
	 KoNO5g8o9ijFITU9YWXqm5N04vN0deY4KdJL0iw8YSFIV4Q+mpHN/irreOD2zdShjSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795521094;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:CC:X-Mailer:References:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=vNEQQZAuxD7CtBZEBJqCVCTH0/+Odha17GZqfi9d9Aw=;
	b=ErA16FNBI8bm0DB+Bowg967LpOwucQYS1x6bsYK5ez509URiz1O3obQarR5zrPmjJylc
	 C0YfqHYKM2K9Jptol/EvpwBqoFxSbXMmGW33oZcfJPBE63QXtQQPabnTb+4K0850/KtgV
	 CYYwWsPRsPvZN1Jsf3nLz7TxTv7lzJ5W5px67Wogfczr33xbWs+ua+cGc0V0zv5SKiCOP
	 6JtzYvuaxTJYrAJY9X1yiL1MtzBjgTSjQGkgwro+rQEZbLz2oZ4F8sK3ij6DgzVxwIBMp
	 DB0Iy4J70YAA5EmRmtEsmhowfsdq/Iol5EKu48OeIxWc8zSZK9LnYznLVyKu47JZmsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eDJ2hPfR;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m+Jy9FPQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5702F606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 11:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5702F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eDJ2hPfR;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=m+Jy9FPQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795521094; x=1827057094;
  h=content-transfer-encoding:date:message-id:subject:from:
   to:cc:references:in-reply-to:mime-version;
  bh=vNEQQZAuxD7CtBZEBJqCVCTH0/+Odha17GZqfi9d9Aw=;
  b=eDJ2hPfRnO5u354N7G3EyOsuFLozDiT/iusCSBvflaNjIaBFZGaOO7U0
   XEBJPivpXWm757yEdPm2SVqJLy5WYoy4izjZ5OSmSgpoHtvkXFXb3RkWb
   zx99/vs63GAdS7geFCtsBPXH9qmwJqTAiMOElp7vvZjgPMjW8V+lFhaHm
   aguNSVUMOy652ZR4amZRNT875wE49CYmCE3Dak1ZAh5y4sbk1Eyd6evUt
   MIWvCQyV4hbTVPpIDhWtt1WhPWQI9BZqwbfxXC50lYOrF1aNuDp4mu733
   u3Y4zjU5VbS1Vhx6Q31VaVabCll0YFWLNzMFQkrfO5fc9GlEHjZvB5+Kg
   g==;
X-CSE-ConnectionGUID: YWNZreLyQkir6zPxDfcE5w==
X-CSE-MsgGUID: PhRCxxUzQDmoJpvdXGn7AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4372674"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4372674"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:51:33 -0800
X-CSE-ConnectionGUID: avGvv6TKSiiXgW+sDTOSQQ==
X-CSE-MsgGUID: ZfbHK9MNSr2b4H4uOMmPAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11604461"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 03:51:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:51:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:51:32 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:51:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXqFyIZm+j+gxrp9zBFZKcanvm2wxA9PJlagN97SWj+H1LCsVflb2Dh9q16kJoJDCC177LcaVjsAqKTebsHkUmRk8qOOprqQHc/OQyw/gwC5wDsDtnjsoBNZOIa1/M42U0lnS73uLZMPG7a03TcWVqcFWdeU8A/yPkPdiLwZN/ILZMNyRCTA0VtKs5+F8EHlmhqBo2HQ04/WsupqWMp8gHmVzsdxsh8tGHwpP+fdJi9Y10lzWWK3BEfNsoG1i0Db4Sb1ABoGVg49iqZCRalyPytwgseymKClPQRzwMpJyfveXBkNKpIc+szjZCUQfkoTZIeyYbDlrxdlhR0anq6eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNEQQZAuxD7CtBZEBJqCVCTH0/+Odha17GZqfi9d9Aw=;
 b=ImskLrQ5FB+/xpf3ohEaM6Wkw9jIl2N0MZePCgXhDmPUXg8nfQX6gJh0Cninw35xa3lTI2QuwT7YWO7oXkZvqD3WsNd5r/ezO3l197TqgRsb2eqtzPJy9s9BnkRvMwmYVc33nHtgKFjVPLuW+iKFrVgZy1kOJLT9OocjenjLNMxTsH+yvs+TalHcay9fWatw5cL03hlSPNVbhPB1FIKI8QKbCrwf6HYvKmBOi2JazeYk4wz1AUXkHtAXtGtNtqb+zV6GVH/eoKgGocwNr9uAlymIh2ssGlMZzxV9qVdMFzX+Ei3XffWaSt4j+TktPwE1pcaMA9w5z/z8Jh+0q2JGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNEQQZAuxD7CtBZEBJqCVCTH0/+Odha17GZqfi9d9Aw=;
 b=m+Jy9FPQqWXPlDSY+WKfbwzf8fyDTv7uGU/YE41/6uLjWFlxj8H/TMGyEV8SanICuzRJTMWKrU7Ax/ePLMujh0XEAJcrH0P7GRMWwB0xNK3DCigTWIM6si6ZIa54WG2HGsxSyJZPs0q4Iy68Tj2uy3Ybswk2VhttiKGbh1WMWD0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by SJ2PR11MB8348.namprd11.prod.outlook.com (2603:10b6:a03:53a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 11:51:29 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:51:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:51:30 +0100
Message-Id: <DN3F3TVQME6V.23B9ENI1LA5SJ@intel.com>
Subject: Re: [PATCH v8 2/6] drm/i915/gem: Count mapped pages in a folio
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
	<intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
	<michal.grzelak@intel.com>, Janusz Krzysztofik
	<janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
	<sebastian.brzezinka@intel.com>, Krzysztof Niemiec
	<krzysztof.niemiec@intel.com>, <stable@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-3-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-3-krzysztof.karas@intel.com>
X-ClientProxiedBy: VIUP296CA0141.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34c::19) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
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
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|SJ2PR11MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: a5ea5f49-7faa-4876-bf9e-08df4a2146e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|261022113327099003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261102123227099003|261009223027099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: rhT/WOpYu4h7/bG9DTkREDrI5lpuIp6xJcR2ScbS4bxw0rMvOXX/7EPJtTp8SBBB6Rqkw3vDxjYYDzTlR5ATWEyA4OXH2xYOKGX7OLATo5SbNikJQiDYd1RkUxe+0/7WEOGghqEku8l6vFGC2GEJ15gNJgVuxIglaGMNGu+MHZsJM7qM8+ZMkHMh0jmjkytaX+nYJ4vt9Cqscax40/8jEIVj1OFf7RC03KS/cDHTfMe8XVjjJp2aQU6F/VYVWX6t+ewaj+y+4dqrhJS5z+96FWsCsmcsMqiMJqCf9kRCjZv9pz/rUmaC457frygUYwT5IJRlQLh9ihn6dUBgRwLPcEkL2ZqE72mCmiWukwAMOcKLMV3z5hsbXHks8ZT5UWN66OQHe2iv/OP2Yr/yjDXNCo/egV6X/Jdoi/qmfUqzVlxPxXArulCj1xUm4qYhFunKqJQG7WAJEoyTpM8bMnMx+NpRYpAbqpMOZGoxo87pd8cmRP3KUTNlhIAuVWmEYyDZJ70mA3mAFkf2hFVen8Or02KDbropUwItr2y1pAZqwTtW3MpRnPuPp7zuZnnCF+yLv1IeCm+JlQKx8Lld+HifKyUDc+ucRi4Zz/ipkLu6YFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR11MB134916.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261022113327099003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261102123227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkVhYkJxazc4aTM4Z3pWMnNOVk5nVmhLNE1OamNNbDFGK0tQQVppdmJpa0Vt?=
 =?utf-8?B?MDFBZXdjclFoZzk5SG5RcnJmbXM4Wm02dTJuUnhFWlpMUEs3L1BXQ3lnQmVV?=
 =?utf-8?B?bklzRFgwbi9ESHJDZHhFUTJxZDFrYUNhdnp2cnB3MEdxcXJSMjVmQlZiWU1N?=
 =?utf-8?B?ZTd5MFFXbThJSERkU0grMDM5Q3p3T0t2OXFabHFKWkU4enpTeHpkWGp5ekhT?=
 =?utf-8?B?eS9oNHlWVzJhZHpkSHNHRDAxYmYyUksrWElIdmhlMFVwc2psMzlucCtDUklq?=
 =?utf-8?B?M3cyb1o0Szd5M3lmUnhiWUx5SmQyLzRQU2FLTTU0R0hpZEpsVy9vWFBmK1l4?=
 =?utf-8?B?V1hmU3hxMHplTWFsN3FzL1E1QWRSSDRrOEtaWWZDaVowcWQyRnppdmJMdlVy?=
 =?utf-8?B?OE0xT1pxQnZQdE05dFc2V1EvbVJOQ0M2SHhMbE1qeVl4OTdRSVBlYjFrRUp4?=
 =?utf-8?B?WkxYMVRGRC94TTNtb202ZkJhWFRhVnhSdUJxV0owZVkzYTFLOWlIWURYVFVJ?=
 =?utf-8?B?SE9XdWZlVjJNT1k4L0ZZc0RnLzRPUTIzWS85UlJRQU5oM1ZjOWdLOFNvK1Qy?=
 =?utf-8?B?Y1c0aXV2RW14a250ZEJsUUFTTDdYUG43OURWY21lVUtIL2NhcnRNNUY2Q09l?=
 =?utf-8?B?VzA2OTJVQVByL0c0NDhwaVJGalR1NXBhZW5VTUdMOE04dC9lK3RFdDRCUjdG?=
 =?utf-8?B?L2xreEI0RGIzY3k1M3hVTlB0OTlsZkFEdlI3REJ6bWdobndNYU9JRW9qZzdF?=
 =?utf-8?B?dWNPT1MxN0dSaGdhQnlDUjE4QkN5dWQyV3drQkJNRHRWK1dVR2srRHFZeVZj?=
 =?utf-8?B?TElJMSs1aUUrRWJwdUZUazNnUnVyMDVxcGNxRGt4YS9qOWM4R1d6Mm9EY3JB?=
 =?utf-8?B?T1IxV284c2piYXJrcnI3Y0s0RWZ2T3FXVlBhNVFja1FySEdtSGFNVmRyL0w2?=
 =?utf-8?B?L0RUdmhmNW5RL0ZEWDRKQkpSUmoyZUp3c21mWUd5UDEydXBkSmNQN0l2Ymhs?=
 =?utf-8?B?QWpmN3NzdWRwZHFOSVNZR0xRcVJrdklMM0dhWEx6eFhSaFY4K3RkdUdRSi9t?=
 =?utf-8?B?dmR4ek50NWdoSEtYRUhGMkRSNytZeENsTDJNMEx5dDNxbG1ldGh2MDV6bXhU?=
 =?utf-8?B?cnIwN05FUDJnNzBHN3NVeWc3M1hDaDF0VHMvb3UyNFFVWUlCMjJKVDVrY1Bn?=
 =?utf-8?B?ZkQ5MWp5bW1sYlZCZTJXZkczL1hGeFVZSVRxYTlIcStSWXpmTDBST0M1dW52?=
 =?utf-8?B?cStablZlYjVSY3JRRVZaOXNiRi9tYmlvVXUwbHNOaWhoK3dtUllGUHB6VE03?=
 =?utf-8?B?L3RmYzJHYTNvNG1oRWNKTVJEaG5tQnlRZU9sYUNhNytXNXF5M0YzS1JNYzNy?=
 =?utf-8?B?SU0vSTJTNDMyd0REc09IUksrUzVoSzZYcUJZdmJMRVdudVRITm9NcGhaMnFO?=
 =?utf-8?B?V0RUNGZUdGlDN1J6OUpBc3ZVNllVWDAwak85MGd2bVhiUHhnSWRwYnAzSEpz?=
 =?utf-8?B?ckVSM0dEV28yZ2pJVlBGUjMwNjIzaDlVY1FoY2RSd21OWGd5Q083TVUwblNq?=
 =?utf-8?B?YmFyNldWUHhUcC9hZVhDQXhocmp3RHFXNTNYbWVZZ0psN29tbk9YTzBuN0xo?=
 =?utf-8?B?UFdFUU5qZ2t0U3ZtVlNWY1orOFhPS0JuMTdBVWY5ZjFaNWEyYURObW5sa1pX?=
 =?utf-8?B?N1FUam1Za1oyLzYzUGY0ZENqOWhQd05NSWNjRlhwcjhrM25JaUphaEV5WG8x?=
 =?utf-8?B?ejkyZG1DSUk1NGdOSWlDUS94d2FyYklXZWxwbkhGdEdXVUFKa0NMQVVtUTdx?=
 =?utf-8?B?bUMxRHlNM3JKYW5MbThWUnJ4TElrUGF3QmM0YmhlYkNERjFsU2x6QlQyblJO?=
 =?utf-8?B?L2ZncnAzekdydmovdDJNS1RDUTFoWk8wVlM2MTJtbElRTDRmRVd3YTdyWW5k?=
 =?utf-8?B?RXgxWGxvdDBrTnNyTHBYSCtxdFp2Wks3ZW9tSFlDYWVVaFdMN2o4Z05mSU1E?=
 =?utf-8?B?OXgvb1VCSUwrWjdnYkFnSllUa3hzYXpkRGFGSXZkbWtDQmYxZk5OSUh1aG9N?=
 =?utf-8?B?R01BTzhKcXY4dFUwY3ZOWmg3MEtXN1N3bGNPMEoxdDhabVFMeEFuZzBDN2tY?=
 =?utf-8?B?K080MGFyWWNFUDBVcGZrMnJ1TUxDUkRxaVZuci9rdVN0c0RQMG10amVEcUVa?=
 =?utf-8?B?ajBFb0Nzd3I4UVc2ZDZGQnhUS01vZFp3bThIa3BObWEzWGlHYjF6TXk1bzE3?=
 =?utf-8?B?TEg2Zmh0UjJkWGFoOTJKNUgvNHhINHdTMW5SWUIzUDAvTEdqcnNScFlKZjc2?=
 =?utf-8?B?K2VTM29jeXV4SmNVcnJTa2gzbysrWm1KRlFSUHh3R1FyL09wanFZVWE5d1Y0?=
 =?utf-8?Q?aKX8gdePLamOl5yo=3D?=
X-Exchange-RoutingPolicyChecked: NZH9ObeWeSxPWn2LqnkziTmNEQNbN6V5RmT5a30a/JflMUpQDHWqE+R0l+guRHEzxvecrp1mwq+vOps45ZgVFI8ZP42HZfI9iCnXZNbyFyHyrQX2qEryEyx+ydHxojnIzh4Mnl42x+/VQxt1+aN6FnZHX1bHbUklsRTSxR5RhWWjG473Jez3quf8MaycyQkrQWiBioNU5keaKmzyNt9GGc6uy8oPxW6vNl1yvpzuAcE2njSqQBTKmP8TxaNeSJHYuBTkSAvnNnwogdmcp7yMZpB0jJst2I6uQMuDg2Tolh4iPfCSTJ8YaOEeFkqqZKqAb0+xX/wKm+fYoHqDNjyaZg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ea5f49-7faa-4876-bf9e-08df4a2146e2
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:51:29.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bTwGBZFjix0UYMgi4QmnIJe69pSo/3djCKB22ID5lc0ijDaiCNjy8AnVC8Fgtoo1P1/++q5MAXi6Gyq1UqO8LQ6qMXE3kWi9OkKXK9jB644=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8348
X-OriginatorOrg: intel.com

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> Before addition of commit 029ae067431a
> ("drm/i915: Fix potential overflow of shmem scatterlist length")
> and after folios were introduced complete folios were always
> allocated, possibly overloading the scatterlist capacity which
> was never truly limited to PAGE_SIZE when requested via
> max_segment. The above commit addressed scatterlist overloading,
> but unintentionally disabled PAGE_SIZE as a valid max_segment
> value and failed to take care of remaining pages from folios
> above max_segment boundary.
> This created a state, where multitude of scatterlists were used
> for the same folio, but never counting enough of its pages to
> jump to the next folio.
>
> Furthermore, current do-while loop goes over the same folio
> multiple times, increasing the refcount each time, and breaks
> get/put symmetry: many shmem_read_folio_gfp() gets and only one
> put in i915_gem_object_put_pages_shmem() per folio.
>
> Track how many pages have already been counted in a folio and
> use that number as an offset on consecutive allocations from the
> same folio to ensure it is fully covered before reading next
> folio.
>
> Fixes: 029ae067431a ("drm/i915: Fix potential overflow of shmem scatterli=
st length")
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/15816
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

---=20
Best regards,
Sebastian

