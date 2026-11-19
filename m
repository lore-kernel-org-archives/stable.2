Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795120421;
	b=UP2IXqLnXxfAkNxVkoyy51jVt65arhLIaSOVdJl1R2ESCzMGu1aJdALOr7kH+5DT5UP2
	 BFas8/wo4IJH7Xi0HDBlHU6ZhmdF7v7joCLKEkxWjj0WjAnjRO8kMW/BvaJCMFLZ7hSDt
	 rQVcBJ1DdOV9gfyL8kZg7PTmYS4v6QaqHddxfCFlcUp6CqtM462yc4MY4l6zLa+Iaj81o
	 Ze31pZSV8n4JrOnyoa2+iQwjPqd3js4fo2I+UhaC40a0aMcrU7WV/FeH4nZyLfkRLC+32
	 7RS4WuRalm+wNp5GCUGPMa+GwyMPfM33w5F0pZ/I/CZH0ihQEsBSW+IMTSyKMGDL/+A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120421;
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
	bh=OpjYA/yYh0ILIadAUF1utBdvC4N1Qzz8nT7vUgQc7zg=;
	b=vLGOePEjlpeDzHvoe3OuJK64lpF374qsFZ53owOezfLN5GM6pjfmwCaB3FFHLs4Wu+yP
	 rdYbSUH98jgVOSBQ0aX2Emb7Ivjh1iDEFHPMGGqhCgWlEfPywBvzeUTLH1kJTfSd3e2t6
	 i7E2vy81Q7lQYH0DaY5ylEHU25TklqIluotD+kbXp+WHtz8OMoC7Z2GMExFQGp3VJDmuV
	 SJVDOqTsFGZ0pDjDs7ys58IGcoI5H6g4F0KUd0vkS1JE7xvjw46DjChWnF+UAXCqELJwp
	 yRYjHv7k/UfyVzM61I2xIPlh00VvF3VCYmZL8Bdyza1ObqLb0jfgkU2rmXCeNhRzAow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLXWnMFw;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dwBhR4I+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84E60A5BCE;
	Thu, 19 Nov 2026 20:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A84E60A5BCE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aLXWnMFw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=dwBhR4I+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795120421; x=1826656421;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OpjYA/yYh0ILIadAUF1utBdvC4N1Qzz8nT7vUgQc7zg=;
  b=aLXWnMFwxcxhsuArg84pwUXoIUkJ5R16RH4oPDuo24AiH+/9GBFE3T15
   ZMzT7rp5WQnhL4zklknqJro9lmphsfTMcnHxFpBsnl9SxlmItpM/OPqSg
   28chRvOYDqeiGGN4ny5fiv5Nc+XEiS8uHqv8AJss+Yy3vx2iqKyiDl9t8
   /hNyTYraXFduSZU98cR5lrnDsRmwMImcAcmvQRKtuhpj+09No4dQ9iHJK
   t8rroEzsmKo1tSpXIoE+FgeUbmix7i13qBoX5t4MxHnr7+Kj5NaWCu+6h
   bS7Bd+3/3HDxM+lg7bbtXnQzMS3d3m01JrTFUofv67sxbCueBG5EQtcze
   A==;
X-CSE-ConnectionGUID: Km+vHvhCTBOclQU37QMO0w==
X-CSE-MsgGUID: g7wQtQpiQr2T53b84LVVpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3904539"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3904539"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:33:40 -0800
X-CSE-ConnectionGUID: FW0f3ZuuRLO+tZ8itjG6fQ==
X-CSE-MsgGUID: Krhi3wYuQKyQ8Ty/BY9vkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10750648"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 12:33:38 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:33:36 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 12:33:36 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 12:33:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jdefh5PrTYqcHxqg1Ee/tSs/nktYtEfDgg2DxebDJeNMRYJkNxeVCZHDe/Sx8Wsb9hZmiy/FKtaYq/cn5ROqL0p5KT+Zu/9tW8lTRd7a1m05x2mdvQMcyFgoJI5Py/nhB5aiZQtqRBYHsekWKrlGfp9jNdIVtZ7pOZvOafjEWOUvD2x7BvJgmaA6KkJN/skLLRiQn1hee3AxS7hxpndc8mxy3wmhPIxGypGJMz8Xl+8p/tBs/JoWf33ct9mxjPFwuBuAswuAzRSIAap1Nh6fqgJ1OFZwUXPlgZMRXJ8JuiDMxT9JPcOJPTz4y4wJJqAy8iIw+gLyVAtu2psOz21pqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpjYA/yYh0ILIadAUF1utBdvC4N1Qzz8nT7vUgQc7zg=;
 b=EzflliLjIT3hvhnO2A3eUQmZktbkoFQTg7FHeqK0zHHxap2hFoEvzb5CIRokGqjZKlLo5r8jIhgZPj41M7PO+/uxPUIlgFjKqqm4cGSrT2aQsnagIh+Ajj3ve/E6oZcmSQjWHzSlyRYFuN1C7U8D2+t7BBY3OBy7n8lS+LvbLHVZMFjBUABJUnulN9rw33IVjzgLMZNkwsOgUu4cqI0sjzcu7oO5P/BFvlKN0mbjcQH/EXGjlv2/RHtq+mkyp7GSmoiRfNi8/ah2bIUJGgKsL1eivwWwByemOsjM/27h/peyyAw4cuazyT73DLlU2qFrsHichAIjZX1/rOnJ7RstHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpjYA/yYh0ILIadAUF1utBdvC4N1Qzz8nT7vUgQc7zg=;
 b=dwBhR4I+dcIas4pYI4Z87zvWKOcGRU+U7f0xvsiMpfzQRlXCtIjLHtAHB+JVLzWM4mNN6V5VQUhBJCRXX0gAhJkt0E9iyaXDnRqvMcCzR+KLU/veriPlGPM/JQ1MQSAwPl7jp4bGZnFpOLY6DORQeuI6mc/yGhhBjMAapZ291vM=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by IA4PR11MB9323.namprd11.prod.outlook.com
 (2603:10b6:208:565::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 20:33:34 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 20:33:33 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "jgg@nvidia.com" <jgg@nvidia.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "ljs@kernel.org" <ljs@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "david@kernel.org" <david@kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "kernel-team@meta.com"
	<kernel-team@meta.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "kas@kernel.org" <kas@kernel.org>,
	"leon@kernel.org" <leon@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "gourry@gourry.net" <gourry@gourry.net>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Thread-Topic: [PATCH] mm/hmm: reject shadow-stack mappings
Thread-Index: AQHdeGU/H1l7ImqEJ0KOHtCVGoraMQ==
Date: Thu, 19 Nov 2026 20:33:33 +0000
Message-ID: <e5a7d15d0f5b5f91fb412b302386b5b7a88db568.camel@intel.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
	 <20261113200303.GA395967@nvidia.com>
	 <179460249376.482102.14669935557901467762.b4-reply@b4>
	 <20261114002027.GE3706007@nvidia.com>
	 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
	 <20261115000005.GG3706007@nvidia.com>
	 <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
In-Reply-To: <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|IA4PR11MB9323:EE_
x-ms-office365-filtering-correlation-id: dc09b3a4-aace-41f5-9b29-08df467c61b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|22082099003|18002099003|3023799007|4143699003|56012099006|11063799006|261022075727099003|261021121427099003|261102123227099003|261026121527099003|38070700021|10067099003;
x-microsoft-antispam-message-info: PAcBZLF3dWmFGXmx+21/7+Hi3l5axb8uyu2gBRzsERP0vqAOtYxehpDxEqiW57aNY0tAMiDRBJE9X8UC0QxwkkGqPu2qDIic2Tflj3nOJajs+KBm6ZBGptZ5OUA1LAPoMwz12bQDsBRLXZS46kLjnX6VdgFOP1WEVGT+JoHmjbVRVEg39pL7OYAiMptk8z9PjbcAv80JhZsUkh95fEcdHpKsv+Kb9rsAtA8aRDdd9YiSJ0jqirFhseEm0ZOA2tA10f3s8T+maeEju55w7y3yCUoWANmGYLrxYC9fzxWMuoYI36K7Oazk/FYQVqvuEXEwg4KN7L5D0FCxbLnVVY/jGKHBrbDUHe8Pex6x5dn7GnRxLzaZ4GwdJHndtScuTsG+GZ3xE3hpKWbfmJ8Iky1O0a47XmWZWGUpmpO/YZkGT+LAfAaUKoDNb9XodrvvrexvS1Dln3+/b9m5hHQwi4ZlxK/68MKOCnFrX4r13Y2tvblvjGhTusW7EhcZzcW8LoWUDYs6wRgi4exKsvF5yjApubWNZjqbHp1+0lEItymBJM0GLAwDeqRr6jhc7ev37iAy5JjVwxPooaN5imZKoR+LZpHzZjkAWlK1LyTtL3iJXTShVdE3GlDL3PG2tTGp9grm7JP97OT6an9eTyStrllZMkDROVJDEAyZuMPuVHVKTOgAkLsEXyvY3uOf7j81w9NrTOkq76ts6YTlDGM4Ol9FfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(22082099003)(18002099003)(3023799007)(4143699003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261102123227099003)(261026121527099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R21QeUxQWUttYVJLazlCT0p0NnZhTXhyWStTSEhkT2ZuRi9JTVlybi96NVd2?=
 =?utf-8?B?TUp2ZE9PRFlXMnRXUHp4aGErYUFaWTJWcTBGWUNiaGRKQmdzTUNrR2xadVNV?=
 =?utf-8?B?Y0V2UGZLVHdNWVRTeFNQUnpWTDkvWlFIU0NXQllYL0pCZmFnVWpKa2hocWpH?=
 =?utf-8?B?MnZkai9NM0JObTBZdGRiZGtXTFR1cnZkaWZLQ0FoQlFhRUljZFZFMS9Cakox?=
 =?utf-8?B?ekl2TmlwNzNqcTBlTEtXTUU2VVNuSHVpMkJqUUlaV00vNUVKMVZpWnpQdjJC?=
 =?utf-8?B?U1dmcitzQXhOYVlyRzVycHZjYkVwa1dCSkk4cUM1WkZmMkw0T3hKK0F4N3Vt?=
 =?utf-8?B?L3dPK1l0SlVHSEgxSkpkN1NHaHBzdmhRNVhHV25DbmNNOWpuVlVtTmpYMWZ1?=
 =?utf-8?B?bTFuaG5oOU0zTnJNTzBvRFBFd1NPcGJvdUs2S2Ywd3JleStKbkpQaDlvdE5x?=
 =?utf-8?B?R2VmT0h6WlJYZm9UZWUyNEUzdHBaOCtIVGt6Z0ptcTRyS3ZiV1BJczI1YzZz?=
 =?utf-8?B?MndSa3V4VkpaRjdlNTAzaTNOdGRXck1rRHhRZ1UzNWwxRkhHTFpNcjgyUXZW?=
 =?utf-8?B?V0xSZElqMmhKNzkrV2lLR1lRa0lnNDNLZkRYakRxcGsvemRLZlBZME14dklC?=
 =?utf-8?B?azNxOXJLcFVyMG96TnhXejNKMlV3dTRsS0RPbHBHejVreEFmOWo0OUFtWG4v?=
 =?utf-8?B?TnlDa24wYXFRUmtGU3JHelA5cG9JMWZaOURzZHQ2SUxnRUhYZkdhVFhGUFJi?=
 =?utf-8?B?b2xRM0ZZa1FDQ0NJRGZJT25TM3J4ZFJTRnVKU284a3ZNWTRYelcwMGlHQTI3?=
 =?utf-8?B?Snp3VXJ5K1lMMlJ3U3dHRmlrTkhCTzg1b3dJSURqQmhqUTFORDhRNUtmVVlH?=
 =?utf-8?B?MnI2YUpjL3FhbnZwWVB1Z2ZrRzlIeEF0OFRzekphUVMvc3I3cUhWbi9SZGtV?=
 =?utf-8?B?Z3JoZUQ1d1p3VFhVNTNyR2ZTRzZXUmNsQnJHeHA0STVqYm1PRkRZblRnVWtu?=
 =?utf-8?B?KzZ5ZngxNXpiVVAwODhJcExYRlEvSTBzVUc5NUhmZk1CbXdobTBMR2lBYW1p?=
 =?utf-8?B?QlJaYS9WQjRsZy8yRDFZK1pNSXIrUGJFSzJKcWM0SjAyWTUrMmw0RGlkS1FW?=
 =?utf-8?B?N0VoaUswY1VteFVYSXozQWJ4S2tBalpMZXdtdTJyWEtBRlo3Y1BUS1JUeVhL?=
 =?utf-8?B?cHZFb2xTb3UrZzFkby8xK0lKUFFBZVBlbk8xdWdqKzByUGN2RExlRk10L3pj?=
 =?utf-8?B?RTU2RjZhaC84dWtKWGZJYUNhUXZwWEs0NWtsMkFMRkxmZTAwSTNKWWlSS2lm?=
 =?utf-8?B?UlhmcTU1bjEzN0tqa1hyL0ttRTRJK2tjRXFhWnpSeCtNZExFMGZFMXV3WldB?=
 =?utf-8?B?eTVocGJ3WENXaEh6NGlNQ0V5c1NLdmdrL3lZMi8ySTJRL0xCYVR5Qlg3d0pJ?=
 =?utf-8?B?eWVMVGw3Y1kyNUQ2dGh2ek16MUc1S0x6eHN6eTl0S3phazRPTlpUMmpsUGVV?=
 =?utf-8?B?a2VjRVl3b3EzbzdyMnBWK05jdVpXcXBwU0F6bkQwUmJmTnJONFhML0FaNVBE?=
 =?utf-8?B?aE1VNklCUEIyelMrN2tNRkFDQlYzUXJrS0JnQStPQ2hZcTJxdUl3YThNWjVX?=
 =?utf-8?B?aWdFMEpicjI0WmRoTjM2NFI4WktwUEMvSG8wRjE0dmNmaSs0dm1JZjhpWXcx?=
 =?utf-8?B?VlB6T3UvbkgyQktuc05UMkZWOEdOL3R2b3g2bUJwbWdnNm8yb1NZc2wwRXdr?=
 =?utf-8?B?NEU2Q3dqYVo0UTZKVDNwMGxqQlFDT3F6dWdLc2c5bDlMR2Z3bVFsNUs1ckQx?=
 =?utf-8?B?YW50aFZ3Y1c3ODdST2UwamxGOTBIOWVBclhZcyttenFNM1h1TDBCT28xd3hn?=
 =?utf-8?B?UTF6RVZHNU1sRk5zZmluQlAyVXBieDhrN3U2WGRhbG9rUVRjc2g4UGNCK3Rj?=
 =?utf-8?B?V3pYeUZQLzFJQk1lK0d6UjA3KzJwNDBRTVhyRkthU3oxRkNGMFpEL1JpRUZh?=
 =?utf-8?B?THJyYTBhdUg1SGNtKzEvVmkvRnRiNW05WDhGWGwxSGpaL3ppdmMxZkJNZ1FQ?=
 =?utf-8?B?ODlHb1JsT1dzdytmUGhwZXFNSTA5N2x2RHY3MXV0U2Fidzd0R1RIZTNtUFFs?=
 =?utf-8?B?WDduamNGeVNVS0N0VmFkSnY3RGxiNEUxU0xiY0lRcnliVXhEVXB5NUU1OWJh?=
 =?utf-8?B?c3ZNWVlSTGU2MmNDcU5HK1V1MGxybXp1MlJid0pUTmZ6TUNGOFRucUgvaGxh?=
 =?utf-8?B?Sk50bFRXMWd0dXo3NUlIdVFLaHQvSGlOUGl2Q1psY3lDbFBVNVRyclB4YThE?=
 =?utf-8?B?OFh3SnNIU3hEWmQwM21BSFhWcGladDBzY2lib29nVHRFN3ExOVVJL1JPK2Zw?=
 =?utf-8?Q?nxrR7ntyerVFWqsA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48A6D63A036BCF4B8865F6AFECF1827C@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: TF5fT0elU8nKgev2mCEkPJM2VgEfLW7mpwuubbRTDOZOEeyCKBsYnDO8ItGrfQoUklZKT5Wkozwxu2e9wpimYaubTK1CMQyWY6R9vJOiGdicn0teYuV6OqSHmivhDSUR68vRoagLlafzBnyy0Do/sC3ryrwV5+0VpprFMWSiYaIS4PHft0dHi9QuE2W098aoEdH9/U5WCG4IzyviBhJqc0MeyYpaMyw+5L4iFSllh9AzYv3cnkr4t/tLNIBhgrTVT0Rc1VLxzm0AOS6I0gZH4tVxMzK1Q/LCWZ0Tjtg2dSbNy20ygTfsVV24fWEK7EUJZmWIBbUK1Dcti0jV5D4nTQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc09b3a4-aace-41f5-9b29-08df467c61b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2026 20:33:33.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: idFIQZ0D8vX6ppRQS+tLy3YUjRB7VT7Ruh4cTN1m2aaX6SCkJuYwnTUbX7yOTtBB2R6AXaBL90iLxJb+TdNquDbTDH+MZONdkdAfSkNJO5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9323
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTExLTE0IGF0IDE3OjAxIC0wODAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBUaGFua3MuwqAgVGhpcz8NCj4gDQo+IE9uIHg4NiwgYSBzaGFkb3ctc3RhY2sgUFRFIGhhcyBp
dHMgb3JkaW5hcnkgd3JpdGUgYml0IGNsZWFyLsKgIFRoZSBDUFUNCj4gcmVqZWN0cyBvcmRpbmFy
eSBzdG9yZXMsIGJ1dCBwdGVfd3JpdGUoKSByZXBvcnRzIGl0IHdyaXRhYmxlIGJlY2F1c2UNCj4g
c2hhZG93LXN0YWNrIGluc3RydWN0aW9ucyBjYW4gd3JpdGUgaXQuwqAgSE1NIGNvbnNlcXVlbnRs
eSBzZXRzDQo+IEhNTV9QRk5fV1JJVEUuwqAgTm91dmVhdSB1c2VzIHRoYXQgZmxhZyBmb3IgR1BV
IHdyaXRlIHBlcm1pc3Npb24sIGFuZA0KPiBSRE1BIG9uLWRlbWFuZCBwYWdpbmcgY2FuIHVzZSBp
dCB0byBncmFudCBkZXZpY2Ugd3JpdGUgcGVybWlzc2lvbiB0byBhDQo+IHJlZ2lzdGVyZWQgbWVt
b3J5IHJlZ2lvbi7CoCBBIGRldmljZSwgb3IgYW4gUkRNQSBwZWVyIHdpdGggd3JpdGUgYWNjZXNz
DQo+IHRvIHRoYXQgcmVnaW9uLCBjYW4gdGhlbiBvdmVyd3JpdGUgdGhlIHByb2Nlc3MncyBzaGFk
b3cgc3RhY2ssDQo+IHBvdGVudGlhbGx5IGNvcnJ1cHRpbmcgcmV0dXJuIGFkZHJlc3NlcyBvciBi
eXBhc3NpbmcgdGhhdCBwcm90ZWN0aW9uLg0KPiANCj4gUmVqZWN0IHNoYWRvdy1zdGFjayBWTUFz
IGluIGhtbV92bWFfd2Fsa190ZXN0KCksIGluY2x1ZGluZyByZWFkIGFjY2Vzcy4NCj4gQSByZXF1
ZXN0ZWQgZmF1bHQgcmV0dXJucyAtRUZBVUxUOyBhIHNuYXBzaG90IHJlY29yZHMgSE1NX1BGTl9F
UlJPUi4NCg0KQlRXLCB0aGlzIGlzIG5vdCBqdXN0IGFuIHg4NiB0aGluZy4gQXJtIGFuZCByaXNj
diBoYXZlIHRoZSBzYW1lIHB0ZV93cml0ZSgpDQpzaGFkb3cgc3RhY2sgYmVoYXZpb3IgZm9yIHRo
ZSBzYW1lIHJlYXNvbnMuIERlc3BpdGUgbm90IGhhdmluZyB0aGUNCldyaXRlPTAsRGlydHk9MSB0
aGluZywgd2hpY2ggKmlzKiB3ZWlyZC4gQnV0IHRoZXkgc3RpbGwgdHJ5IHRvIHByZXZlbnQgdGhl
DQprZXJuZWwgZnJvbSB3cml0aW5nIGl0IHZpYSBsb2dpYyBpbiBndXAsIGV0Yy4NCg==
