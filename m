Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649342;
	b=mfXB6QQcmWOIVkTN9MvCgTL/3lz7fbSiKcaAUiTTrtZHCaeHwJsXd8GT5iH9+CzFLSYf
	 dnrnU6warweIBf0yqN3QO3FKj6HuBT53Fh1PJ24uG97pbU3249ItDIS1vyYIsqrkX3tiI
	 cYKniwYaiwAkyO57p88lrZar2hNCMS6cBjlH6X5c2Oj6uxreuB813fTDuo2JQ7OyLQ/qR
	 eaDQAXUR6COZIKeKjADfifv5xs0zttmmpFt527RnVlBdPwzjtMh6KScfz+EPCjzRlR+CH
	 PLNAvxJ1bmY0OidxTVDJD4wUxkvW2BPGtcF09cv7QJBvtCGzF9p1YxRd6KBpgB7Q2kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649342;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=4bVYooapFBOTFmf0q3okFltnWp7BV3Zpxf6ONwLJS7I=;
	b=X5PbXQlrc7l1AsAgmH3EeSg+1Mj9NXJS3aUgaUkhAHhlhnOunlAiuLvl7HjxlGxe3IQ2
	 5+1lL6omYx4pWgKy3DFNIh+PJyPG2rwDWOgPyBedIunmoQYVudRln6E2jv2BlEFDYOnYV
	 3Fc2Q6iX4YEgGfNrVBUajA5pDsfRmZklgd9tNSbE8SJY8SYBbPr4ld4iAFmBq88hLn2ex
	 hiAoloKe8bneL07JR+JKUXBcStJfZxdzKO/3rg577E1ahkBIOJNIsifNk0srJwzi7379x
	 3fty2dYFRwhk1dfHA2llDfrR3FVEAuS60qTte64Q3pyWb/dQNurT2SEUZicKO/siIFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q3wyVurs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FB1608508D;
	Mon,  2 Nov 2026 19:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64FB1608508D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q3wyVurs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793649341; x=1825185341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4bVYooapFBOTFmf0q3okFltnWp7BV3Zpxf6ONwLJS7I=;
  b=Q3wyVursIusZxO9CVEGPTAuU1VUjyTyKmaLkDaCZYasChHWvjFEumAbg
   YyXPu4sfQ3EDJNyTqcuIhZeeujpr6NV5Jf1kLCw+EShlWAYLgUwcopuFv
   0km0zX2b/8pL3u264bLlXMxaeyAMg7yboEaW/mNfdA7/K8+Z/3x5QsOQb
   SxnLSKt4jdzYhjRUJLR1u+wDmkMzztsfeBQwAin1FjTJZbkFl96/i2+LA
   +w3A/3v+SVRce3MnzcYey5DrzXLz7z1QBYk59sz9au4+My6j8dzpmIsYh
   lRTujCf/R+aGCi+63IBTGqX20w1aG5XUNyJz75uTIQ5Cl0t1+TwlTy8Np
   A==;
X-CSE-ConnectionGUID: bMLBUSeJRd6ArSQOprl45w==
X-CSE-MsgGUID: ip5/cn1YSWqi+15LiWM3Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2364354"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2364354"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:55:41 -0800
X-CSE-ConnectionGUID: lShWNWh4TFOt04RQAuSyWg==
X-CSE-MsgGUID: 9mucqJZ7QaeKi6dWpn2wtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6208622"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 11:55:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:55:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 11:55:40 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.29) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 11:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uISqzR9TnrmzwIRD56xPOGnAfPZRuGtUSt0czKzKfN403KFm2Z8rYtM+124oRmh5p21Lzyzadpu4JrSDr5gs3dmO4iZs9E/zSvqRDfr4S2faq9/z4KaDBPHqtiW0DEkfPR/KvJ/SV7340fyyE9cGNcTOgk8nzs78iA0CQ/5+VYa5IHFAMzRDK0nFPPqpR5SnoHyjnWsCk+HYXKve3T8zpz7DqiRrRZuIJmy1VIwxO30MVJ+Ivbxiw9/vSGJKy/I4FNb1zZwWMNxZK/p4+0wXsTlwhzT9dVrkm7+uTGOBlaEj73Fk7QBB0VZ7ZIZJT9VhKWW4XIDJNsZ5R0yDYzqiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bVYooapFBOTFmf0q3okFltnWp7BV3Zpxf6ONwLJS7I=;
 b=UwI593vxDd9FsGwypotD7VxftazUlGaQUvaLsPYu8AQoJ6PUR5KNgRGPywjna5cA3vsaueXFkcdVBig7p6F+tfwJ2+WIio4hEmyWj8mN+G+CQKZ6HT94mZknRipcCbRce7vDp7K4m+UwFDqrFV6Orb7lO/3UHcXCNG//JBc6RTPJ4a9QunFLiagVIUYucX9Q+3QsB4mK34WybghgnGfE8AXIqsnwrPtR4HzWXzbTHBh+34j5JUXaCAHMGlqlI+4QR/GgaKvuTs9zlZbDii6I9/yuOF3w23OHCV9iE2RN4aJS+EVLMhD3eHyMIlWLcbLlw87668O+HjrfTp/T+nQAiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by IA1PR11MB6290.namprd11.prod.outlook.com
 (2603:10b6:208:3e6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:55:37 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:55:36 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "kas@kernel.org"
	<kas@kernel.org>, "Aktas, Erdem" <erdemaktas@google.com>, "djbw@kernel.org"
	<djbw@kernel.org>, "moe@flashbots.net" <moe@flashbots.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v3 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Thread-Topic: [PATCH v3 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Thread-Index: AQHdY+xbWjjgSCvIwUKkNDKjcu8hYLcbQGeA
Date: Mon, 2 Nov 2026 19:55:36 +0000
Message-ID: <3b582cdcfe37f1d01ee71611ab2611f845261089.camel@intel.com>
References: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
In-Reply-To: <20261024-tdx-guest-quote-poll-v3-0-6a83bb767314@flashbots.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.52.3-0ubuntu1.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|IA1PR11MB6290:EE_
x-ms-office365-filtering-correlation-id: 7a1d95bb-fcc8-4192-1f1b-08df391b4377
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|261021123027099003|261021121427099003|261022105027099003|261009223027099003|261009221227099003|38070700021|261026140227099003|261028144727099003|11063799006|10067099003|56012099006|22082099003|261102123227099003|6133799003|18002099003;
x-microsoft-antispam-message-info: 71YV0R7mHShMyQl662teJhjBxnSwmBTZsKxLQhX3Gp6Ef96eVFkFxO+FbB/nmjj0cWE2Zq+LJRBLgteuWsufWBjKhOD5vdOYUbNv/stXau7O6suRiL+8Ox4Zw4EDD9fznPzN8FF1pJdwiaCUlsi6J0r0oRpoZ/5FRTyURfkHQ0xyxNj9LHVWaZBhPVyxZ56eS+pwC651ofrmp8TrutURPoEVaBrQXcpEYL+sSOqAT41bOga1mPTNnqmW3t+xk8y5mrpEJZN7AmmxLx/2qS/qEdMmsTDAS8Wb2Eu78Z6hE+4lhzzyofR/uGLW4s7IfrFLdqLDKOBIg+q/K6iypf46JvC/NMTiPVWiaJv9NhQjMA7JXnuFRzcKM3ofwOynrfCl3QC8PvZnA+OYs8UnTfHqHILYypWNpG4Lv+JZZtZyUqZe6vk1KxTkbdnVmove4z2rsH8b9BMOtugGBpy6oNQYirbS8OLPY7byzN1fj4qwuOfcYO31OZ/jLAHr3nDrzBxtug/zJPNWYi0IC1uy1TqiYVZ+vIl8Rd2HsC7W3qMYUY4Bd/hG/mQSEgQIs8Oom0Wc/pkXc6w/9hb4sUyOZ1h13NEZZCL78sSQDGgUdlO7zImB5+6PFdlaqXXClxeT/TWVn2hkueZWDHdyY1OnzBsr0zpNm5LvsPOb54qFITlny2bs2pAnhsV6ha81UqIwfTHO5ef1Suz0d2VYdMtnq4xcse20PR3lzdFu1DFQWorLq3c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003)(261009221227099003)(38070700021)(261026140227099003)(261028144727099003)(11063799006)(10067099003)(56012099006)(22082099003)(261102123227099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ry8xdVIvWFVBcThtYXlYQmlTUk5GK3FwMDVOU0hieWVYV2ZpZ2pITktpVW85?=
 =?utf-8?B?TFE1OXFYK1NZTDNrYXJpUjN3c1pqbXNHWC9OVDJpZEFqQ3hURU91WFY3VG1J?=
 =?utf-8?B?YUpPTEt4cWNhaCtNa3YrVTF4Z1ltSmpLL2c4cU9HcHE3bVkvbHEwYnNHczND?=
 =?utf-8?B?cnR5Rjh5K3RNZ2IvSGFMR0F0Z3pKYmVaQWd2ckdCeEFvNlkzVTBmV2I0SXUw?=
 =?utf-8?B?dEhaakpYS3FuMkpmYnRsSGpoS0hneXAybW9nMmpWMEVMcEJDdHdwbEYvVUxN?=
 =?utf-8?B?ckl4THpuNGRLYWpycDloZGdodGJBQ1VUTWlBMmVLa0hveEdycFNFNi9HUi95?=
 =?utf-8?B?WHlIZjJvSmlxVjA3bjBRVW1nYUxldnFXcjdtN0xqSTlMU2NtdmVSSkNxS1p2?=
 =?utf-8?B?Mk9LVHBoMGpickxOTUpwWGRxSzdkb2NpdUlTTS8vTFN5ZzFHRHFGMHY5VnFX?=
 =?utf-8?B?UUtNZ29WQVI4TGl4dDFXakwyaGlBNjFweEdDNXZsMHBpRWRRV2hCOE5uUDV6?=
 =?utf-8?B?clgrU2RsSFFERldhdmRqQitzd2RyTURQYnhGRVQwSHpNdWUzOVl2cGVLR29r?=
 =?utf-8?B?blBFZDNERHdxQ2N5WVIyb0puR21jajc1N09KM0VEQjExVGh1TE02eGlBcVV0?=
 =?utf-8?B?UmU3ZlZSUFVtc214czM1V2JhRFVYMktzTTR2Rkhqdml6WURteWlML1RwbERM?=
 =?utf-8?B?cDZoSXE5TDRTM0l3YWdlL3hYS1hlUzkvY0QxTHJpY0ljNHcyV0M3TmdyZlhz?=
 =?utf-8?B?TnZnYVRaY096MnZYZTBVL3ppalg2TklVU1gwOTVGK2FWazUwQkZHcjVjRzlH?=
 =?utf-8?B?S1ljYldVbVhleVY1NlZqTCtDbmhrNTllQmorczNneFlia0R6cDJWVHBFOFJs?=
 =?utf-8?B?SVBHdGRjbGxzS0ZrTUVkaERiTXh6cklwTUtwR0hlRDRqdFNqWGtRSldxUnFM?=
 =?utf-8?B?QWQ1QUV5VnZZRDJZdURWSFh0cGwxWGNIYWhvMDVSUmNTQzVuYmlvMXFIMU5G?=
 =?utf-8?B?b05hU3ZsQlJBMkxwdUM4Y0ZUWmp4aXdBTjk5RlhwdmtmUUltZmh4UWxhWTEx?=
 =?utf-8?B?bU9xa2Y0WGFNQWxWdkZkU0R3a2FKa04vWHd1RnVpZnlyQ292UHVqbEtxL1FX?=
 =?utf-8?B?SnNZbVBBVHhKQ2pPR0owc3N3TWZaMVcxRGhEWU5pN25mOFhPMUZFd3BKVW5u?=
 =?utf-8?B?NXNManNqcXFNVmdEMWpGM0FPS29MenFyeXo2V1ZzQ3E1WGQ1L0xFYlc4c0lJ?=
 =?utf-8?B?QkR4aGQ4Zit1TmdNTGJQYkptY1NPc0hGUW5LTG9GcXYrN1QxSllVV21iRTRQ?=
 =?utf-8?B?SzhpTGlRZGNPclgxSEdhVVRKZVcxWDhrb1E1Zm5vZzZsWDBLT2g3WmtJSm9N?=
 =?utf-8?B?MTV3TmcwcjQybklxQVNWZC9TcjB3MGVFMFp5cG1CVDVMOHREYzJSS3pDRkY4?=
 =?utf-8?B?ZXFZbHZPWkhOdm1NbDlINHNteGJTQU5nLy85dDIwVXg1OHg5SHA5U2tYczZF?=
 =?utf-8?B?Z2d6eGQ4Y1JQY2k2TzM2a3EzallHVy93WDhMZ2k3WDF1UlR5b0ZaY1lVRXYx?=
 =?utf-8?B?L1NRUDJ1aXdiM3VaempCS1d3cG9mNUc0ZWNraW53MDVVNzhOWlN5cFRKMU81?=
 =?utf-8?B?aFh6VTJqc0dkZlRFWE4zNXJYKyttQVluZFkwci9ObmtvQkxJa2JHaCtNQVl1?=
 =?utf-8?B?N3hTOHR3NWNZY05Wb2NrN1AxVHdHZng2bWY5dG1KRm9WRWN1REoxbWFKaE4z?=
 =?utf-8?B?M0h1aVczaUNKbjkzZTh3c2lYWFlWRUplR3puV2IwZElhSHduNWEwOS95bGkx?=
 =?utf-8?B?bFhIMVIrcjlFa0QxY0VucVFKYUdTVkNVZFF2TGRWdk9PL1RYelZCVUt6Yy9N?=
 =?utf-8?B?OWtIMFdFaE1IZEgwVnhsVGlUenR3MURjL0E5RUVHdEk0VktlNTRNYmFZOXZ1?=
 =?utf-8?B?RnlBNUZGTGd4QWZKT2xSWTczL09RRjdjS2NxbzQzNW5wWDZxbGJkWkJJdUd3?=
 =?utf-8?B?OEZBZUlBdWFmYjhyRlFxWk1PQURHOHVrZVl4dTAwd28rSFVDWFJYRnhIT3FX?=
 =?utf-8?B?OWRtd3BueUdHT3JLeTBTVkhWdkpWTnAyUmt6dnBJNU1HWFNSVXZjSmFnaUl1?=
 =?utf-8?B?eldVRU5ZMm4vWmYyWFM4OVRiWVdENTlrY0o4by9PNXZvMHlOanM0Z0Z3R2J3?=
 =?utf-8?B?SytFb0lJdHp4SDh1WDBLMWRtejdOU1hFVGJZVFFEMFYydzBJMlYwQXMrV1NZ?=
 =?utf-8?B?Rk1iZEJOVWtUTXMwTUd0ZW9LN2RwTXBvcjRKdU01Wk1RdjdFdjNtMCs1QUVv?=
 =?utf-8?B?RE9vSlp0NTFNS2x2MTRibnJCTWpkTmUzbGJOOGpkNFdpWmJwOWtBallFVUpH?=
 =?utf-8?Q?Krrvx4+joUDGm+iw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <04E25566651460468D3684E3175169A0@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: MngCo61vPUSv3iqUtF5Kba7hlC/TMOoOUD9W3jv0EpA/MiK3IDR1TN4Dvpa0lEiIOmwsoGY5jkowc4KCExFNnkVEDtm/A0+po3jZtckw3dBqMdS2qc//FLYPZRrN/xtaTgc5iuXE/A417DpfORhRmVfI4nR8ztTkLXeSsI0ejv+vJh/5hUZfK4nL4NlskfZqG3NA6JIrelFF/ALuqCdhQGA+6h47Uq2h1F4x1hvXymxo73SL1Pkgk9H46CXzTuqPY2b8KXhuFowLtA6zTdrwHy+aRlf/yuHbYPNxkayBuG1FMtYHqcpGpIjwZGCr7uvRIYui5hsdi3ZzD5rCS0EiqQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1d95bb-fcc8-4192-1f1b-08df391b4377
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 19:55:36.8089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: InLeflGneudfxL7WOLg/y1ftAcZNXOW2eJAjvNNz1zMv9QDjMB4GsdVbqrkiUkjCxxaSl3gV7evEF5f3tDM2SlmH7dtStMmRbfVyufocAxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6290
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI2LTEwLTI0IGF0IDE5OjE3ICswMDAwLCBNb2UgTWFoaG91ayB2aWEgQjQgUmVs
YXkgd3JvdGU6DQo+IA0KPiBUaGUgR0hDSSBTZXR1cEV2ZW50Tm90aWZ5SW50ZXJydXB0IG1lY2hh
bmlzbSB3b3VsZCBhdm9pZCBwb2xsaW5nDQo+IGFsdG9nZXRoZXIsIGJ1dCBpdCByZWxpZXMgb24g
dGhlIFZNTSBpbXBsZW1lbnRpbmcgdGhhdCBzZXJ2aWNlLiBUaGlzDQo+IHNlcmllcyBrZWVwcyB0
aGUgZXhpc3RpbmcgcG9sbGluZyBtb2RlbCwgd2hpY2ggd29ya3Mgd2l0aCBhbnkgVk1NLg0KDQpM
b25nIHRlcm0gdGhvdWdoLCBpc24ndCB0aGlzIGEgYmV0dGVyIG9wdGlvbj8gVGhpcyBwYXRjaCBp
cyBlc3NlbnRpYWxseSBhDQpwZXJmb3JtYW5jZSBvcHRpbWl6YXRpb24uDQoNClBvbGxpbmcgaXMg
YWx3YXlzIGdvaW5nIHRvIGJlIHdlaXJkLiBBbmQgd2hlbiB0aGUgYXR0ZXN0YXRpb24gc3BlZWQg
Y2hhbmdlcw0KKHBvc3NpYmxlIGluIHRoZSBtYW55IHVwY29taW5nIGF0dGVzdGF0aW9uIHBsYW5z
KSB0aGlzIHR1bmluZyBjb3VsZCBhZ2FpbiBiZQ0Kc3Vib3B0aW1hbC4gSSB0aGluayB3ZSBzaG91
bGQgZml4IGl0IHByb3Blcmx5Li4uIFRoaXMgc2VlbXMgbGlrZSAidGhpcyBoYWNrDQp3b3JrZWQg
Zm9yIG1lIGZvciBub3ciLg0K
