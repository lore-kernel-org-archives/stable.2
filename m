Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795472346;
	b=vnmxpDyk9FBhnNt4elk6IBd0z7jmMyQpYvhYVnW6tZIlNuo1eT261agdEWhdTIIXnxkG
	 aXXD+D9+9RYLZ8Lfj4AwK/8Y6oYrr6hvY5bjC7MtZ+LNB55kwoVd4pb/iPukkj+U9DYTR
	 E5njhfah6V3gZ1MYFHhv8xADQfdbM+CemF8PNhkibo7CjGQ51Cmt29cZ1Iw5QDaxVnAg9
	 liucnWkXb1Nmj1i0EpFVFuj6ZakGmq0iomTM0Bxm6s6PmqEVcCXqLv6pOJzI9/14/etJL
	 dRcUEZzMNUI5HaXYQaeHUrtDMTG1S0wcDpuwdbaIzR3Y8+TVc8QfDsGhPTXLWp5odug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795472346;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=BHHHUNI+PP0tzHUsTXtxkG7TLkZM7jhb0JHQM2/5KyU=;
	b=JpjeV4tCI4qxe/EicXRs9YVC0AFLunR7+2tfUrMj3SU39N/xXQv8eeygDDyzQHjqf3Yy
	 r6s4EsEzawJSp0HSdbJlk8W5yb0vfuT5AIc2GDF4sDNkBnXMcqNDEvfZcdEL9Ivm+RWiu
	 prlf8OOXqAvGhR/63sm8SOPtxbvKMfz1Q9XBwfZOxXF91IZxhI4MyEQHYtcdv75BDO++0
	 sKNvTMan+IQZQLTd3l+Syf+7mW3eLw2tigTHAQEp4AIlYbmQKmfvVPUuOhgsXQfR7jeYK
	 SrsSjA2UUntuYQrBXIzH4w7X+5hw8a0EEB/7uJohlXcBmctpeY9Q1ZUv7Jmguf8pBUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OZFCih10;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=POnaqrOY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5A606A326;
	Mon, 23 Nov 2026 22:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OZFCih10;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=POnaqrOY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795472346; x=1827008346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BHHHUNI+PP0tzHUsTXtxkG7TLkZM7jhb0JHQM2/5KyU=;
  b=OZFCih10NuPshZVNAv7sD9ua18x1ySIu726GNQOvj2zFEYvaEfXXJpQj
   vVgtXr7/9kr2Tsdy4vMmhP8h6TM42ncxmzmG67CH3YSM5nf1lUFR6LdTI
   9uADlpNJhBJqAECW45rrukosEFWjiTl+J3WV8TX/JLLq5e0PC3Ywsvo0S
   jy8dYhJSyojyxfAbSZ2BkAGYpgltU+ZQVUhQqa/kdxA6SmUdDgg4r1QAZ
   F5aqol7h9G4sCE9nOM/vVqlJJyFJBk2gMo8U7wK5IQfs9UEy/YDN1DhT7
   zvnYVplz6X1MOYKIvFCHHqjL5SihARKRJythezQK/ZBdiIfT4cWe3cBmF
   Q==;
X-CSE-ConnectionGUID: EaM6E+uRRr6P4mHx76xw9w==
X-CSE-MsgGUID: ztVahTrlRImUzXFIPLnwQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4170851"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4170851"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 14:19:04 -0800
X-CSE-ConnectionGUID: v5YxIPWARWC60aa6yD8BFQ==
X-CSE-MsgGUID: 5WU8ox40ROWACHtU9DMDsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11307552"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 14:19:01 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 14:18:59 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 14:18:59 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.10) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 14:18:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTTSsXw92Suf6jqgZmSiNu83zqT7b+8Gv5U3+aZeiDVno9T5adS11M99+Dw7vPiPEs8tdG1UJAyxal2H6P+yaC594mayyUOUpy2p7l85Z3C8p2tkPvA08WW0GD9AWwdzmMUYLdD35vtMXJd0mRFS7lFVmaMYiqBaoBTelac75EjRTOowbruo4iKSONSFqVudrDUkbYZ62qAVdavSX0+pNH2Iizerw/7+5mnsPYt3OXCVd3IJb3tNIF0gCVGCksxIjVadCG9YTpVTIA/wuKwOlfYwLsc9ILY9SBlAu5Lb/RlRgJjvJWTcIamWXICbR35LPCqcQ9nFI8CDR1gJvlij4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHHHUNI+PP0tzHUsTXtxkG7TLkZM7jhb0JHQM2/5KyU=;
 b=M5mAHoeGiQGIvDxHrg5OnFjXqodHsQLTy+AJ5fKA20YlXmT6GuBrlQahJrHwTPRkikNefRQ2MSbqe01S2ItwkC+rqhFH18mgKG66jwgOcVnLXzB1lvbXJZVq5W8Guk3a687opGk5eswlvcMzWALdBoDxwgQjoELg3LCH2dZrRBVXq6NoyREuC53SY1bN2tPNFpzH/n6pKHZOXLDIe29uFCWEsTG6xjgkAVr/EsT3QfDvmo/r2TZZyMA9b3li1Np9I4emjb75nQ0F96LrcFfpEKU9TqnBgOW9mYxPTJ7zvo64evB6uGekhCKQMOJYmiH1An68+dDYkkWO9hAggqAuBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHHHUNI+PP0tzHUsTXtxkG7TLkZM7jhb0JHQM2/5KyU=;
 b=POnaqrOY6O1Xg+Vb2XQmTR229CG4oQDKxJfIFCF+3IZL23EODcfx0vVPNqDyNgIxrXZtr5J45Tr9Ms65VttjAjFftjFkdPYyQCfQjR+L8tTjLojkJtpCrky5UlIsC0biDQ19uT+1W91YfujfQ6tAlpKkvF20PLr9J5YiRAV3XPU=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by IA4PR11MB9230.namprd11.prod.outlook.com
 (2603:10b6:208:567::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Mon, 23 Nov
 2026 22:18:49 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 22:18:49 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "shukai.ni@kuleuven.be" <shukai.ni@kuleuven.be>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "jo.vanbulck@cs.kuleuven.be" <jo.vanbulck@cs.kuleuven.be>, "Reshetova,
 Elena" <elena.reshetova@intel.com>, "pasic@linux.ibm.com"
	<pasic@linux.ibm.com>, "kas@kernel.org" <kas@kernel.org>,
	"carlos.bilbao@kernel.org" <carlos.bilbao@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential guests
Thread-Topic: [PATCH] swiotlb: clear read bounce buffers on confidential
 guests
Thread-Index: AQHde4y30SzPfx787U6hITZ+e2u/sbc8Oh8A
Date: Mon, 23 Nov 2026 22:18:49 +0000
Message-ID: <3a70a26adccc47b1bae3a22e4907174271703a10.camel@intel.com>
References: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
In-Reply-To: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|IA4PR11MB9230:EE_
x-ms-office365-filtering-correlation-id: 34b00a85-22e3-46f0-1be8-08df49afbf86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|261102123227099003|38070700021|10067099003|5023799004|11063799006|56012099006|261022075727099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003|6133799003;
x-microsoft-antispam-message-info: FKvNr1Te2Y/pUVyYF5qm/YhDLdhRT7czy1KO+Bu8f9peViq+OoKngeDoP/GQR+N1TjYiHGdwT7PdI4Ohdvt8jctT3Cf8TvRP5OxhV9+WynmiJOID7yyJGNtu61xAWUdEYX56GnGuRwvbbRwUYSOipe8jdhWHpe/vcv4UEPTBXXZqFxCIh6ZX5C5yKy51dEgaLtlq6eq6PWpsUZY7pKGitfd2f+qqQ+D8dRy4hheie9xnq3ovTQ8IAZvAstyci327U2T57ICmMogUrlUexDss3PBH3IJHfZJTZMls5yIve+2zge63fhaJ8UQwM5N4CHM08PGJoW94hu+rEiZpPMdzlRoPyS4LNuVA3xBB+g3VJcbundbl4s6c26jH8O4U8GqBIblvw9rgMtBkNhB1QDGeMw6/dLtyNx0zSELJVcNl55NwNAyy1mOSHfANZ9yzU98tV7jSqoM3K67fDog4/T8ksBnksqLnUGT3tw6BD9itGYEjhNyPAIxKDfOFyB7EBX2k4ETg0YmYk0if4zEPBggnvU+N2DcQbgJjTnQDJLfwKx1lsy8HDBSVkTkeKWjxnHYgaF3bqJhGZN5t1DXGtrOyZJPB1vjG+p3Y8ssGvdWlwJ3TNxbWn0rJXfEcsF2EDVBjG01tVe2MW2cS+6zXBUjNkfV+KRamklIgUHNo8S+H1/TrTC/R8JW0tGDm395gwkiyrYEd+tbLIKRx77J7iTip13zML/Pu1IaHsY+3aEolth4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(261102123227099003)(38070700021)(10067099003)(5023799004)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2U2SFh3amt0ekxvUGpaMG1ZbXFvOHRRb0R2ME5sMmQvTmVzckdXRzljbXZP?=
 =?utf-8?B?YUxTczNQOFF4V0xxc3JKY2ZzMXJZVUlPRHN4eUtwVkNETDZWcnh5amlENzg3?=
 =?utf-8?B?NVRqSDJSNEVvVEkwL1puVmlXVUlldzhIaEQ4bEtha2JIQWRRdjAwZlFwK2FP?=
 =?utf-8?B?Ri9kNEcyRVNraDNzUHFka0ZIOWI0U1lPRHZJUlNiZWlRVkkwVXRtYXdJZEpU?=
 =?utf-8?B?aktkR3NPSGEySXZiY2NzczJFUVVhT2p2V3RTL3E1WkNwakZYNUNZc2hJS3Ir?=
 =?utf-8?B?aUN2RDRDc3hmQTloZnY5M01maG5NaUxNSURMaW52SmlNekVOeDY1ZnVPVXJ1?=
 =?utf-8?B?a0lCb2FkNDF1MGZkdkc4YytpaDFic09maDQrbmdzRXZBWHo2YWlSWFB6NjVM?=
 =?utf-8?B?RDN6cHJKakorZkxTZDBTYW1yTEdzZy91YUxKRWNMY20vb2I4Q3VWQzVjRTFx?=
 =?utf-8?B?VndPQ0NoWGw4WHQzZzVVd3p2SjdaRzVZem45MXdaSnB3d0g2TVFZN0Q4aERQ?=
 =?utf-8?B?VnI3cHY1MU5UTUs1dzhEbTdqTWR0ZUdPN05oZk5VRE90VkVhSFJ4MnQyT05z?=
 =?utf-8?B?NFJPQWVGQWVhRGF3SlcyRk13ZEJ2WTlZYU5mUXE3NDRjdlhBL1BHVkxZMmo2?=
 =?utf-8?B?Qk00cXNJOFZHREJBa1JjVEwyQnhQa24zcnk4eGRycDRWOVpsaVBoalR5QlU2?=
 =?utf-8?B?TnlIOGJ2ZHZ1d3BTQmpLVmJXNDUvYWp2eEhscUhUMXQwOHBqQXRnYmptb0Q4?=
 =?utf-8?B?M3pCN0ppcGkwQjZLUStKQlEwQkdIdEIzZjh1MHFVSUwwcG5tUDNwZW5ZMXRE?=
 =?utf-8?B?N01qbkQrRzZxWXBQOFZWWFA2alhFZmtKZng3UlpXQjBaS0NKaTRta2RsdE5X?=
 =?utf-8?B?MUpPSXZXbUtwNjV0UVpoeTkxVUcvL1M1cnd6ZVZ3cHo2eXdxYWR0THJsRGw0?=
 =?utf-8?B?bmJOcVdpQ0dUNGh5VDdaK2RzRlNqOXdhSWloL3Q1cExqdGNOV3U4OWFTTXJv?=
 =?utf-8?B?NzBkNFVLaFB5RjFVbDBjRkZiMWhkcGFLSmEzQ3Y4VmNWZzBOV2JLYVpjc1pB?=
 =?utf-8?B?N3R1M2Q2RlE3UHRlZCt1MDdJRUlFT3ZaMkZNbmNCWXhqTVZRc1owNG1Sekhu?=
 =?utf-8?B?a2ZvOUFlT2ErL2xHbFVTOGdZV0FEblUxdzNqQlVGRDdnRjgrR3k1a3F3NnZx?=
 =?utf-8?B?MjdaTm1rR2JHeHhqTnpKYjVJekZzNU9sYkhWQzRIZklNUUZNZGd2UlZrUE1q?=
 =?utf-8?B?ZXROdXdpTFBBQkZvaXJyRk01RURia2NDRWtJVzEyaEZjSEg1OUpPRUFWMFUv?=
 =?utf-8?B?VWtoQlJYSmF5WDNFb0ViUjNtekRObG1OSUg1WmdkdVIyY3BwTVVTRGx6eXlv?=
 =?utf-8?B?Z2oxOTNobHR1OEl5U1FEdUhndGFaUnY1b1dzTnRmR00zUjVsazFQYVpIcEZO?=
 =?utf-8?B?bmJYZHhLMENwWG4zaEdCL1JCdUxNZjY3OEpYODdpbzYzWERPQ3NGMzlURlpt?=
 =?utf-8?B?ekJMc0NsYXF4MTdOeEtJQTczeVNMSkY4VkRaZ1VZN1l2aW9WZTUyeTliSXNz?=
 =?utf-8?B?UXF3RXFkaGpKOUtBOG51MjJxVUFqWVE2dHI3a3JMalFVelJlQnE4YW9qdFZj?=
 =?utf-8?B?TE1ZYWZheDgrbHlRRyt1cDNEMmdCSGtQT2ZWY1pXeFJZdzJNMStLcjFPamZS?=
 =?utf-8?B?MVJCaUMvaU5lT3IxUFcyS0lqbmt2d0pRUS8razdpVFNiZXI5N25Fck9aajJj?=
 =?utf-8?B?SFdhdmNSWjRkd3RXRGhXamdFamIvcW5wZ1RhbkExNi9DK0ZKWmFZdVRlN3pG?=
 =?utf-8?B?NnNEaDV1MGh4OERzRnR2L2EwWDVyM1NlaHV6TGNJUWlDeTZMbEZ1WWUrUG5a?=
 =?utf-8?B?TTJGWjlWUkN3UUx1a0dzZXNHL0JZaHhld0hQREMzMEtKQnpmU24xT3ljODJU?=
 =?utf-8?B?SnU4cFVaQ01QR2hhK1g1cG50ZldNY3JpWm5rS3docWVNVmd1NjFUSnpiaVVx?=
 =?utf-8?B?alc0TVh2R3kwTVlzdlJrTkpQbndnWEs2VlNpNjI3TEdHd05sOHkxZGlseEk1?=
 =?utf-8?B?a3VQRlprOXdrcFQwbnRhWjJIV1RnWmNkVi9YbEhHdFI4MVBhMnRyY0dCMlE1?=
 =?utf-8?B?ZkhHY2Ftb1l6cG1IL1ljRkNMc1FHWkRrem10NkZZdVd4cUh1RFo3eTQzK0R6?=
 =?utf-8?B?NFlVRjEzdk56UWpra25seU5FNDl4UkN2K01yaTdQQ0pOWWp6bFRFaWJ6SkpC?=
 =?utf-8?B?QmhzVUM4eHM4ZnM3eENyV0Fuek5iWEwvMFBGWGg0b0tRMVgvRHZPY002WmN2?=
 =?utf-8?B?bTg1bjhGemk1eVhYYyt3OE9vNkRVSTQwY1pPZWRQYkl0WUVPdUdQMjJXRlZH?=
 =?utf-8?Q?AITISmQADVpplr50=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2290D830ED8D7E408B86AF5826D35110@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JjvkGIEk/fLRoqqtBGOxEuz8MoFXkEXV5LpjqjvnN7yD3blr8/jZwp88NiugslhTzzWNGZzGNshdyOmUrj8P3/Nxiw+Ym7mJwf4o6tRVKLh/kw9vyffpg8lS+qNlTMBg4spMeK7HilaVbWC7WL9L7oPW7P/PeHkKXrArQoIqxNWebeEeWm98DQUTPkDvnWxvYz/0SiJXNb9uCmUt27zpT/gvd2JYuUz9NVRX9W/+0AaFAPDck/Yrk/GNK8KjSNIpUaL/Wn8n85fK8dUGDpd+1eUfgoxd3vi99/WP60YZiNML7/75QqLBWzW6s1XeA44NaYhHPFFAAKISqKAaS/kXPg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b00a85-22e3-46f0-1be8-08df49afbf86
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2026 22:18:49.1095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kqbGPnRKB4E7+rBMee4+cXldbXI+zWJwSo8DbYIz999hPjVfUY467IHAUhFbudLoz+ofIVd8j5ums51lvhoxJZn+eNnjl4jI/sSXfzMsub0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9230
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI2LTExLTIzIGF0IDIxOjUzICswMTAwLCBTaHVrYWkgTmkgd3JvdGU6DQo+IE9u
IGNvbmZpZGVudGlhbCBndWVzdHMgKEFNRCBTRVYsIEludGVsIFREWCkgYWxsIGRldmljZSBETUEg
aXMgYm91bmNlZA0KPiB0aHJvdWdoIHN3aW90bGIsIHdob3NlIHBvb2wgaXMgc2hhcmVkIHdpdGgg
YW5kIHJlYWRhYmxlIGJ5IHRoZSB1bnRydXN0ZWQNCj4gaG9zdC4gc3dpb3RsYl90YmxfbWFwX3Np
bmdsZSgpIGNvcGllcyB0aGUgZGVzdGluYXRpb24gYnVmZmVyJ3MgY3VycmVudA0KPiBjb250ZW50
cyBpbnRvIHRoZSBib3VuY2UgYnVmZmVyIGF0IG1hcCB0aW1lIGV2ZW4gZm9yIERNQV9GUk9NX0RF
VklDRS4gRm9yDQo+IGEgcmV1c2VkIHJlYWQgYnVmZmVyIHRoYXQgc3RpbGwgaG9sZHMgcHJpdmF0
ZSBkYXRhLCB0aGUgaG9zdCBjYW4gcmVhZA0KPiB0aGF0IGRhdGEgZnJvbSB0aGUgYm91bmNlIGJ1
ZmZlciBiZWZvcmUgdGhlIGRldmljZSBvdmVyd3JpdGVzIGl0Lg0KPiANCj4gRm9yIERNQV9GUk9N
X0RFVklDRSBpbnRvIGEgaG9zdC1zaGFyZWQgcG9vbCwgemVybyB0aGUgYm91bmNlIGJ1ZmZlcg0K
PiBpbnN0ZWFkLiBaZXJvaW5nIHJhdGhlciB0aGFuIHNraXBwaW5nIHRoZSBjb3B5IGtlZXBzIGEg
c2hvcnQgcmVhZCBmcm9tDQo+IHJldHVybmluZyBhIHByZXZpb3VzIHRyYW5zZmVyJ3MgZGF0YS4N
Cj4gDQo+IEZpeGVzOiBkZGJkODlkZWI3ZDMgKCJzd2lvdGxiOiBmaXggaW5mbyBsZWFrIHdpdGgg
RE1BX0ZST01fREVWSUNFIikNCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ28tZGV2
ZWxvcGVkLWJ5OiBKbyBWYW4gQnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKbyBWYW4gQnVsY2sgPGpvLnZhbmJ1bGNrQGNzLmt1bGV1dmVuLmJlPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTaHVrYWkgTmkgPHNodWthaS5uaUBrdWxldXZlbi5iZT4NCj4gLS0t
DQo+IA0KPiBOb3RlczoNCj4gwqDCoMKgIFdlIGFyZSBvcGVuIHRvIGRpc2N1c3NpbmcgYSBkaWZm
ZXJlbnQgYXBwcm9hY2g6IGUuZy4gY2xlYXJpbmcgdGhlDQo+IMKgwqDCoCByZXNpZHVhbCB3aGVu
IHJlYWQgYmFjaywgc2NydWJiaW5nIHNsb3RzIG9uIGZyZWUsIG9yIGV4dGVuZGluZyB6ZXJvaW5n
DQo+IMKgwqDCoCBmb3IgYmlkaXJlY3Rpb25hbCBETUEuDQoNClRoZXJlIGlzIGFuIGV4aXN0aW5n
IHVzcHRyZWFtIHBvc2l0aW9uIGFyb3VuZCBjb2NvIGRyaXZlciBoYXJkZW5pbmcsIHRoYXQgdGhl
DQpkcml2ZXJzIHNob3VsZCBiZSBmaXhlZC4gSW4gc29tZSB3YXlzIHRoaXMgYW5vdGhlciB0aGlu
ZyB0aGF0IGNvdWxkIGJlIGZpeGVkIGluDQphIGRyaXZlcj8gVGhlIGRyaXZlciBjb3VsZCB6ZXJv
IG1lbW9yeSBiZWZvcmUgc2hhcmluZyBpdCBmb3IgRE1BX0ZST01fREVWSUNFLg0KDQpCdXQgdGhl
IHN3aW90bGIgd2FzIHN1cHBvc2VkIHRvIGJlIHNvcnQgb2YgYSBnZW5lcmljIHNvbHV0aW9uIHRv
IHRoZSBwcm9ibGVtIG9mDQpub3QgaW5hZHZlcnRlbnRseSBzaGFyaW5nIHByaXZhdGUgbWVtb3J5
LiBJbnN0ZWFkIG9mIG1hcmtpbmcgYW4gZW50aXJlIHBhZ2UgYXMNCnNoYXJlZCAod2hpY2ggbWln
aHQgaGF2ZSBwcml2YXRlIGNvbnRlbnRzIGVsc2V3aGVyZSBvbiB0aGUgcGFnZSksIHRoZSBib3Vu
Y2UNCmJ1ZmZlciBhbGxvd3MgZm9yIG9ubHkgc2hhcmluZyB0aGUgbWluaW11bSBzcGVjaWZpZWQu
DQoNClNvIHlvdSBjb3VsZCBtYXliZSBsb29rIGF0IHRoaXMgaXNzdWUgYXMgZml0dGluZyBpbnRv
IHRoZSBnZW5lcmFsIHByb2JsZW0gb2Ygbm90DQppbmFkdmVydGVudGx5IHNoYXJpbmcgdGhlIHBy
aXZhdGUgZGF0YSBpbnNpZGUgdGhlIGJ1ZmZlci4gQnV0IGFsc28gdGhhdCBpcw0KY292ZXJpbmcg
Zm9yIGRyaXZlciBnYXBzLg0KDQpJdCBzZWVtcyBsaWtlIHRoZSBmaXhlcyBjb21taXQgd2FzIGFy
Z3VpbmcgdGhhdCBjb3B5aW5nIHRoZSBjb250ZW50cyB0byB0aGUNCnN3aW90bGIgYnVmZmVyIHdh
cyBtb3JlIHRyYW5zcGFyZW50LiBTbyB0aGlzIHBhdGNoIGtpbmQgb2YgZ29lcyBiYWNrIGFnYWlu
c3QNCnRoYXQgYXJndW1lbnQuIFRoYXQgc2VlbXMgdG8gYmUgYW5vdGhlciBwb2ludCB0aGF0IHRo
ZSBkcml2ZXJzIHNob3VsZCBiZSBmaXhlZC4NCklmIHRoaXMgaXMgZXNzZW50aWFsbHkgbW9yZSBv
ZiBhIHBvdGVudGlhbGx5IGJlaGF2aW9yIGFsdGVyaW5nIGtlcm5lbCBoYXJkZW5pbmcsDQp0aGVu
IEkgd29uZGVyIGFib3V0IHB1dHRpbmcgaXQgYmVoaW5kIHNvbWUga2luZCBvZiBoYXJkZW5pbmcg
Y29uZmlnIGxpa2UNCkNPTkZJR19JTklUX09OX0FMTE9DX0RFRkFVTFRfT04uDQoNCk9oaCwgYnV0
IEkgZ3Vlc3MgdGhlIHByb2JsZW0gaXMgdGhlIGJ1ZmZlciBnZXR0aW5nIGNvcGllZCBjb3VsZCBo
YXZlIGNvbWUgZnJvbQ0KdXNlcnNwYWNlPyBTbyB0aGVuIHlvdSB3b3VsZCBoYXZlIHRvIGZpeCB1
c2Vyc3BhY2UuLi4gQnV0IHRoZW4gdGhpcyBwYXRjaCBjb3VsZA0KYWxzbyBwb3RlbnRpYWxseSBi
cmVhayB1c2Vyc3BhY2UgaWYgdGhlcmUgaXMgYW55IHBhcnRpYWwgd3JpdGUgYXNzdW1wdGlvbnMu
IE9oDQpib3kuDQo=
