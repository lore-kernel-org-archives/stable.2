Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795642947;
	b=LR4fynwylltjkIGGthDJn0dbKVaGr8/QvEIUJwMoneQ8RlXuIZIJkDy8KBZqVMUAqHcl
	 agALx7Is22z8UPD407siVJQbxqaaUF+PhR5afgAaxsOCD3SisKTje6GByP+HcF8Vj6UyY
	 UAieM07gtWnwXyTKaoRw5cSTdjGlBGAYkYPj9oQU50ySUN9foFimKyq4btH9HWGkfRDxl
	 GCXkFR8Z1J/Muy2mzLtAmP50hQzO84cbqscxUahoeaMVhqdkbVgM+MzkXjZvYxScQAidW
	 h8ByxFc2idZ9L9W3YkM+yIRyqWToLJvXsZZeAL7oHRjo3sc4Cp6OTwY22WOcjU0DN2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642947;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=9vcldXNaCU481XCr5rpJvXAhwenagsVYILb/yuEwSJo=;
	b=HmJ2XVAW+Ho0BJZ1RBiP+j0LxF1BiDa5i7BTIdQawz6vEv4xl/rweCwrxDMNbyfyf1q1
	 KuIidoVj5a0mUBwzLqOStNWzQM7Z5cNFuszr/eirskNuoo2NHK7owlWbfGuGayTech+Z1
	 DF09fMUSd7w13CDDNB8m6E9R5yunDC8t0XO18eOYsRBgSwrkR+h/uNLXtGqZaJ+yYnAsR
	 8XMZATA+2lJZX97tvB98Wy84t77eq01+lKxjL0U8WdFeLzWE+JTxJwvB93+9NEdeZfiLw
	 3HkSeLtvtIW9FPpyMgP8NsfmryezG0YtNeoOlEBZgnnHe22fW9jZpTJOYFNFEzzwzzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MxZ1HJab;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iY0u4PVU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D60C606A321;
	Wed, 25 Nov 2026 21:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D60C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MxZ1HJab;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=iY0u4PVU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795642946; x=1827178946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9vcldXNaCU481XCr5rpJvXAhwenagsVYILb/yuEwSJo=;
  b=MxZ1HJabJKULiAjrVvAZs2hohmmjF0xiHU/p/Ey3ZNGvrn+l2JYMje38
   b1bjmPBG0BCLLpnLI754DiSftIbQYL9bOtbZFMF0Dh7ABBdqwepmdJ9gI
   NyC/Ja8bq4AOLu3N3V/OcJOmO1RgkBW4uB6E7iDvhY6W6LnHq5lnzidtH
   6GNG/ngwllRb2cmhaZ99lL4iTISJCuRiobSLng2d3VKZbgC3H846v6Nye
   pBz4HU94T5K2syWt2xjbFI8VV2l4gJO0yG+PwQKAKekVFKMf0D4pNAIXm
   t00zmYjM5Y3BwxWVle8/nKyDs4crActq1UzkMHxZZBJO6nuV8iqt51rVy
   A==;
X-CSE-ConnectionGUID: BmV3GgPKSWybH36dUWvuhA==
X-CSE-MsgGUID: oV1dou3IRvaO6p+E7QpGsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4446215"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4446215"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:42:25 -0800
X-CSE-ConnectionGUID: 5MzJfi9+SW6lzF5ZorNCyQ==
X-CSE-MsgGUID: lTvoRvxdRReark4H0F3aug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12292292"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 13:42:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:42:25 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 13:42:25 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.31)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 13:42:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcOHcpxNIMhusnhn34Q5H9LshUfgdCvqKzLif4b5hGhQidbmUBhVfgS89AIAo9zriK9nvMgYr89g50Zw8ZWHFyV0g8Yz6jdeKmWvNoL5rKkZKCsQqr9cKjGFmFBe2lWy6FzZXrOMoj2la7TxVG/01McXp81aKKesjamb1x9QnqHXQjt8d7g55a9Uxwj/ErF7fim2jbdwdVc0QzwwyUiMUYJTd+oi33Pe9gHpBMbWQwXZtGXfzV+Od6BEq+EvttQKhN0te7bitjOrcgWTwcVjfn9UK7AbBv/q60HraoP5elpKeAzxV8o9l7Qh+Lb9GlFBtgX2p8b38yv8gLeBVUkhEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vcldXNaCU481XCr5rpJvXAhwenagsVYILb/yuEwSJo=;
 b=XTOrmzEs1DZW3goTEHSirPT4LbTD0mrFtlTSi2mSb0/Ui8l0N1xPevJz7FACRqX8nNl26pn8XvuNNQ/Ct5SQJi1731YRoICPjNZHfeM7HxQ9JFBG3EqSZCnj5E+HrH7tS+qlMYlKjmyyXa/M83d5kKbVDFtOTKhyrwRn9hWGfDGmJ5va7mCiurwl50xt45lkaEwIC9XutcDNinp6WRlPQzXwvWl4ADQ0uQ6Dcj9rWRHEdkhW0km6AYMKTf3chnZwaWRWeETdN/Tq1rqkMDDSkRQHffaza032Vy37MfBSfoRWpVgrweur3ZgDaIDKUmsgxQFFp5teF/mKrjWvdPs6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9vcldXNaCU481XCr5rpJvXAhwenagsVYILb/yuEwSJo=;
 b=iY0u4PVUQjtj20jHx0KT6S/UdxGx4oP525+ukvPnrIA89W515CYRsxFgUiYtzhUXzO78PoNAJKzIFapfGWzul74EksdgohSRKktyorFR/88TzX/f4cLIz8mznBI/xE101OVS4RCvAoXryEBjDkvFEzBrEkBRiGeL8r092udwNpY=
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 (2603:10b6:208:549::23) by CHBPR11MB551639.namprd11.prod.outlook.com
 (2603:10b6:610:40c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 21:42:22 +0000
Received: from IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57]) by IA3PR11MB634048.namprd11.prod.outlook.com
 ([fe80::760f:f0a4:7417:6e57%5]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 21:42:21 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"kas@kernel.org" <kas@kernel.org>, "Li, Xiaoyao" <xiaoyao.li@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Aktas, Erdem" <erdemaktas@google.com>,
	"djbw@kernel.org" <djbw@kernel.org>, "moe@flashbots.net" <moe@flashbots.net>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "Miao, Jun" <jun.miao@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Thread-Topic: [PATCH v4 0/2] virt: tdx-guest: Fix and speed up the wait for a
 Quote
Thread-Index: AQHdfOb/N/GpaIfBTEOt4Ji9kuU4Irc/UeKA
Date: Wed, 25 Nov 2026 21:42:21 +0000
Message-ID: <cd7bd4428398413e16ff214fc46f5d65076757d8.camel@intel.com>
References: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
In-Reply-To: <20261125-tdx-guest-quote-poll-v4-0-d89f26854b88@flashbots.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2.1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB634048:EE_|CHBPR11MB551639:EE_
x-ms-office365-filtering-correlation-id: a7bc3ac9-599d-4370-a2e4-08df4b3cfc5e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|23010399003|1800799024|921020|38070700021|56012099006|11063799006|10067099003|261028144727099003|261021121427099003|261022105027099003|261026140227099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003;
x-microsoft-antispam-message-info: scgpTLJ32e7SAcqMzJUwAjke3Gr/5D8J+iKfnYFanSqrVBNj7Y7Nbk1b75yf3/1aYKZEVqSXyjeJwpc9AfeTZTkKtwEiCDAFGIsDk+DBr9FxUAwYvCW+tWHib+AHGe7h0n9C7i6J8JVquNcDQkh4WlIXY0IquMt5Dtxc7taSX40Pknx5oWP1t1WsElJueT9qyEhcpjtJ98hrVyAoo07VC/qpVmuGKPoGRj/Bg8ohZgFzXOitBKXpNqC0Ruw4VFyld9/e3puRDODTn9vZlBUihmBdQ+u47i2GRx0R0EIvvP7XvIJsYbIh4T8meEDpdBR7HylSMig7ZA0sSwglJ9CjJak33mYDCOEp1kcEdivOW7Z9Cra8ZrsEhnANnLS3fqR7a2JPKaMBiGOydzAgp7mw/s76vcPTYImRuQmHYs4cT8RKQ6giw0MB4ecjyqFLeS4j5tokDlReWGw23zlm+gx4HIQOFe52+TZesauXvgG1G2b9aItPH3YQhaPQWYSgTUc/Ndu2Uji5z9ZBWe5Ga8XYbYDNUFuVARjL3NtgBO8PEmBzB+9BAHxBuf1kabA50o90eiy+zbRJuU6JNeY7xrW0RdnlIXAdxCD8mTg/oT7QABJt8RNM4SJC2kg4/zvL0DfcYjln/7sDu+Kuej+jiD0c1GVGUAgIdUGlCKZgN8EdmgvIR0/AxG8VFpQ4J0x9cotADt9XMAM6loFa+dLipEAn8MVwIq1acPz3Es+ieP7IXtp3OU5A6lFyHHqFICEFQwCL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB634048.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(23010399003)(1800799024)(921020)(38070700021)(56012099006)(11063799006)(10067099003)(261028144727099003)(261021121427099003)(261022105027099003)(261026140227099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUtmaUY0aG42YlIzakhmV0o4WG9oai91c2dKSG9adlZ5YUdTcXhvaDJMMDdw?=
 =?utf-8?B?VkJoNytOMDN3ano2Ujc5aks3UXZ4YzhDYnJRZFozL0NIT3VQMjc2eHRRRHd6?=
 =?utf-8?B?d1pRYUV4Z05IbDhFRDgwRWF1UVh1bG8zcFdxSkxoa2p2czRQL3BBUnZxN1Y1?=
 =?utf-8?B?cS9mQXhmdVBhSWUybXplUVhvTWxvQWs0MHZjbThhRnA1U3pFRkZPUU1tUHBV?=
 =?utf-8?B?dXlwS0sxaFl3anRBQndQRldYSEpFNXlSa29TamlLMzczUUViNUdXV2JmYkps?=
 =?utf-8?B?VHBoNUN1Nk5RRDhzMjJqVE91SHI1bXJzWlBTWE5rVTJYTlBnbEhuRWZMbFNL?=
 =?utf-8?B?WkdCZUJxWW1wcEhiMnQ5STdNbUsrT2NpSFcvYUx2RmhBbDFHMGQ5MmZWNzJ2?=
 =?utf-8?B?ZWdtUWRGTGIyZHMxVng2aVpZUytWeFpBTFVwVFRPMmIyRFhtekllZnIvVE5z?=
 =?utf-8?B?QVJOZzFBZUdQbkV2Z1pkWUZIamc4SUxMSlNKd3NpblpsaUxQNDFDRjVsVDZX?=
 =?utf-8?B?ZHpSbDZ1L0NIaUltSU9EWkFsQkpmMHpFbW43ZWlhQWUrajBHcFp0dmh1QVRU?=
 =?utf-8?B?Rml2Unh5U2FEM3YxVE1pTmx4Yzc0VVBOT0c5bFUxbVkzV2JFZmhnSDZ1MFdp?=
 =?utf-8?B?YzllaHZWdER3K3RhMGxnOFZTdS9mK0NEVVZpZTQ1dUtJVmVWaHFaRWNLNXdX?=
 =?utf-8?B?Z2YreU1zdmNuajFxaTFyYlJ1VWwyTDhvR3NEaFJ0b2hCbVJpY1I1SE9SY0Rv?=
 =?utf-8?B?STBMeDFJckpjclp1czBOcG5DTGZQQmM1ZVI2M0I1eVJkQlZhZy9Nc2VKQ0tY?=
 =?utf-8?B?bDlGS2F4N2xYQVkxL2xtdm0zV1pseVBXSnJxTkVIM1dmYW94OHNZQ1dRQmlR?=
 =?utf-8?B?L2xxUis0cFZubVdQaVdseEZBM0dtTWMzM0hpOGoxdU95TnpxVTFNZUhGS0U1?=
 =?utf-8?B?VlJjWmFoSmIxOXhVYzl2SXQxVDhDMzZjTUQ3dEJaT3Y2RHpSeTJoWTMzVXVu?=
 =?utf-8?B?a0w3Rms4OFdmU3kvak02VDZDSUUzRDM0eS9qVlRhM3F1NXR4aHJGZFplVE12?=
 =?utf-8?B?Q0NUZG1LOFVCcVh6b3RMOVExZVBmdWFKWWFrcXdDTzNIcGZ3MFJ4UUcrMmtV?=
 =?utf-8?B?Y1M0azlsU1hDcFBibmh3UkdtYjFnWTFRT0RkaDhNQkJwTXJGQWtiQWVxY3JI?=
 =?utf-8?B?bDBZbk05OS83NHN3UWxuQUwzdXZWNVVJSU1rNzA2ek45ZmwzWkxzc0ppN09E?=
 =?utf-8?B?SUZhL29WZ2U4UVozTitPK0p6dmZqVkw3Q2JyYTZadGN4b1YwUXhiV3FBYVYx?=
 =?utf-8?B?RE9TaU5WS0d1NHJnMVlXR1dtSThYSm9sNjZsUlB2a1VtRjB3R3U2MDFJRlY2?=
 =?utf-8?B?dHBJa2FZenluSWRDS3BSNVNscHVRS2wwTHhsZDJzaWIzU2JmNWJRbWtzdi92?=
 =?utf-8?B?Szl2QjZqQ3dUamRNa2tReUpqUEw3RTlpOERHRXFuYUNCei8valVGWnkzK2kv?=
 =?utf-8?B?TVVobi9KMDZ6c244RitQUHl0d3FNSXRpdWw4a1JiSXJELzgzdFNjTk9LNWZN?=
 =?utf-8?B?MWxSREJ3N2o2TThaZWJIUlcxQjNoRkNuYndkdmJoRENhY0k2YmR1Qk5GZWxi?=
 =?utf-8?B?Q1dMVjVWcmpZT1VDVFpiY01HZDdmUCtkTVQ0UWQ3c3lab2ZoTGtzRGpYS3Z1?=
 =?utf-8?B?bUxMQXNYYUpBd1BGSDNqYkRkcUZjYmF3bDlHdUJJSzBydm5wVStscVliVE5x?=
 =?utf-8?B?S2NLLzNYZ3VjZ1JqamdxYXVUQTZqdmEwNE5ucjhBV0pvWEpwWll0aEdodXla?=
 =?utf-8?B?V2FBbGRjbEZBczhNR2pxNGY4ZEcrYzYwTTVaaktBbVltZERxdlRZbm5rUkJB?=
 =?utf-8?B?SWcyd1phUVBRZllBNnVYeXpIWFBMcE42Rm5EYTh0SDBBSTZXcWw2ZlRIVEhS?=
 =?utf-8?B?Ty8veTZqQ3gvTENZRmZXVUl4UTdPMzlFbFFYUXJNRUZiUzdQcmw5SFBKaERw?=
 =?utf-8?B?ZUZ6NDZRWW1OZUp2V3VXb1NsS0ZYZlAwZ0dXYkFyamVQK0NUWTJRdkI3SkIw?=
 =?utf-8?B?WGo3L1c0cGRKN01zcjZSa3NMeFFmV1d2K2k3akRwVFJxV2xOenliNi9wTW9V?=
 =?utf-8?B?Rk9rK000eTh0QW92RUtpdzRnMCttY1VvbFBvd0NZSERiOW9ZdnJIOGZxMGZW?=
 =?utf-8?B?OVJtUlFBMjZqUU9vTEcvMmcyN0xxVXU1WStRamVablVTdEZydytUZmg4eVov?=
 =?utf-8?B?RkVucVdVWHJFWloyZ1RINnlIdE1ndmJ0Z2lHKzNLajdwc3hCd1I0MUg3cnhV?=
 =?utf-8?B?SGJkQUxUc0tTSGZYM0IxNTlOTWd0NVdjZEVaK2FDaEVqOU93bmVJcndwSzlo?=
 =?utf-8?Q?OkvV/DgBkoHapbfA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDB0AFF6A568B949BBF2983D12BF0F15@namprd11.prod.outlook.com>
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
X-Exchange-RoutingPolicyChecked: TzvjQYiXcyFXZfTGvN7Nf+qtsOWCqpkKfBORfEtsEoF2o7aHEuBarwFFdLiYYTrkwqOnqzgdYnfV9FQntuj6OKbNygFdp/S5vnsOiRLiAp+rvZCz2L7ORrcVXuM4R09d00+/tRa4YRraldypN0EMb33u74QhCMmgwUjH8I57mn4Q6wzBLUEneEnKdMrd4POZbCT4A3afpUwpQ/aIQ2JZkvvkMAA4qk0CMVBnj8zXzXFAV1775PvZosBl3TH8FGkXjyg79Kw4GwFW0/CNhYZQ1ol2UnK+T9izt2qZLW+8xWdJkY7F83/uxHghS4d92K5sCNKitaPdXooOK7zFzVI2GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB634048.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7bc3ac9-599d-4370-a2e4-08df4b3cfc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2026 21:42:21.3640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfZ5LfX7+twmfvCoU9TuojQMMAJyjji4smB3ykLd48z3m6sY/OVWDLn004QFE1zGrVdrKE5jUBBPlY5l8iIgeGG1L0rMchKKrnoAnomgy/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR11MB551639
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI2LTExLTI1IGF0IDE0OjExICswMDAwLCBNb2UgTWFoaG91ayB2aWEgQjQgUmVs
YXkgd3JvdGU6DQo+IEdldHRpbmcgYSBURFggUXVvdGUgdGFrZXMgYXQgbGVhc3Qgb25lIHNlY29u
ZCwgYmVjYXVzZQ0KPiB3YWl0X2Zvcl9xdW90ZV9jb21wbGV0aW9uKCkgc2xlZXBzIGEgZnVsbCBz
ZWNvbmQgYmVmb3JlIGVhY2ggc3RhdHVzDQo+IGNoZWNrLCB3aGlsZSBhIGxvY2FsIFF1b3RlIEdl
bmVyYXRpb24gU2VydmljZSBhbnN3ZXJzIGluIGEgZmV3DQo+IG1pbGxpc2Vjb25kcy4gUGF0Y2gg
MiByZWNoZWNrcyB0aGUgc3RhdHVzIGV2ZXJ5IDEwIG1zIGluc3RlYWQuDQoNCkkgdGhpbmsgc29t
ZXRoaW5nIHdlbnQgd3JvbmcgaW4gdGhlIHNlbmQuIEFsbCBJIGdvdCB3YXMgdGhlIGNvdmVybGV0
dGVyIGFuZCBpdA0KbG9va3MgbGlrZSBsb3JlIGRpZCB0b28uDQo=
