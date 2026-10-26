Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792980520;
	b=BW880WxzVEPogOWEe9EriqVGYIwlHaLpW77kI0RBRaB7jTB6pA+GsguuYJB3m9eVm/Qs
	 r/ZD6+9GapVDZLzYFTKp2JYQMjXZ0whycMT1H8+SmfOCpvhrZHVYFI9hulZSWmnyE6/qx
	 yK8HvVI6pHSXEQsSRF9/RjUSV4Tiu+VTSK/VN/MyOZbomdg5P2uZ8GlHpDd4voRGCVCci
	 unSV+00d/uOC+ETIWhmSHm6A0U9rdnJYM8EdlMmK8yp+RX6n2X/NVfuHDYmVKvhZRhaR4
	 rsWSWdn4X5Irodb246wi5scYkLx8+xFS9FzdcFgivRjQtrZv2os1acRLQMqyoFYFn/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792980520;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=7a4XJl8ZFs10DUO7g8dmavnaKCDVT20CAyckOgaIrGo=;
	b=s4Vg7hHJhLUlhlIzN/7jufQdUB8Pb3d2YRfQoF4d0E/IjKpqh+M1BfGrza6wC7iSbkDf
	 bgaS+RtPXB1DrRtDiNqrzD+Pj7CVIkHrk2Eteph2LXJFOYq1a8ltvjlciFTdEUy0B6oV7
	 wgeR7XALJ4Mi+qy4LKS2uCR9gC+tlRuc09w2imuJCmRygANKawbC94SXT86nUISGP48I3
	 u17anhL324VcWPSMXNVWd3D0ae5xC2YFN2qLIKs2B0JJnjiaeUgWvaEkopM0Ot20Kx6+Q
	 yMtjLTMkdpmOx+vtWEczDILxN3Ld6nuu0ykCd5ZCESL+KBHvxoVt11lhISl26/0lSUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="jBQ4T/N0";
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697B9606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 02:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 697B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jBQ4T/N0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792980520; x=1824516520;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bBI6G7wmTQUOZ8dK2EtpcLUnXuW9DujOAvdy2ts1+XA=;
  b=jBQ4T/N0NVvobGhPUo/48TvMyfz9m7xVZHhB63IpqIGN3kU88uIDP9XM
   +PuZgVg/MVCJTBg9pcIaNptoQr+hx9AzgXQG30/tAUJPvg2rLwnhwY062
   GGt7YHzVbYn44pk9fk0rCaKxCfZ6XV3Q1gUR1zPuf7en7mVo1hePTWQuO
   dQ7vRkK9eY2DK3eIbZv6uT68sAVQa15EDPtKMIcUevCTJsGeJWvO/krmo
   +9WI1rOCNR6/RnWMRBFpNfd6jqGFvw/OWs9lVGZm/KbrWxT+lpDF9y2j1
   BG4YQ4RVRapcMoe9EySlbNGYlxx31S37InkzQaixiyo55CQ9gW7XuMNE3
   Q==;
X-CSE-ConnectionGUID: thRy+ngESO+1dSDA0hR35g==
X-CSE-MsgGUID: qjf6IKMwRjWUzydlAbvMJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1649752"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1649752"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:08:39 -0700
X-CSE-ConnectionGUID: k99qHqIpSqeUIMCUkyOgIQ==
X-CSE-MsgGUID: IXM2MdpyQ1yzocYm7UF//A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4150966"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 19:08:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:08:38 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 25 Oct 2026 19:08:38 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.0) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 25 Oct 2026 19:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqxoXpvzSEJq18kNZ/EuSyst2QppoEkNc2U2n8cQiEckrb00PiNSP42gc9Du58WMA9qrkKqWFFrVyluz5mHRVnKUms0NLNq8P5/YOVlNwpizDXa/9MtR3rha6SzlUuCvPf5+NpCK2Y2qlhiR2InNUCxyIEkAMD7ozH+am/pSIjkeV+1ozPk0Jk4HKMoS+Z2P9amzHTG4KmKEOzwqe1Y61MFxX18qsoAjHdT+tuMt+FNoSaLnEi0g7LoPplVzPiWTLmPwkeXGJwO51RMdm7TxCx0s+2H2TnlLV2hJP3joP3+SuOEwNz+cvyWn2cMkIwX0rdsGVoE67vQHnjSplUrDxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7a4XJl8ZFs10DUO7g8dmavnaKCDVT20CAyckOgaIrGo=;
 b=vyy4aupt56NEW6m1lnRvZNBg7ul0d7I6a9ZssukOSjRqjijcOdZZJhf056x3Lsfs4xXSxhF4FAM1kPsc/XkBc08Qu3MUH7kGH83maZp1nOSlBcHqkKp8oOd4A+rt3RRSwgtbvvUdrSS5mVhxOk5Wxt81y9SZdNekO/hm8Pdqxf5Wo1BGnxZQnA9DlhbazMdmzdRDvgX+TzTlyCd45gVkaRlv3Zbp9XysrUH/Rly4CklhZUcGGpHxI+Y19bCXtPKT7qcqdkFKOix8uG1rY4UbFj9xjn4r8BjPiui7qhucYnKQRymxgG/3kcwR2G5sY2sJiZPM5aCf3p3Rssfb126KbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by SN7PR11MB6972.namprd11.prod.outlook.com
 (2603:10b6:806:2ac::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 02:08:35 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 02:08:35 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Karas, Krzysztof" <krzysztof.karas@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
Thread-Topic: [PATCH 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
Thread-Index: AQHdXVnKYetkWDxgnEWMRwaqLiFeurcPIsjQ
Date: Mon, 26 Oct 2026 02:08:35 +0000
Message-ID: <DS4PPFE901A304FEDFF0EBC3C7DD9B1D9BEE3612@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261016101713.230013-1-ankit.k.nautiyal@intel.com>
 <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|SN7PR11MB6972:EE_
x-ms-office365-filtering-correlation-id: 8db20e91-f94a-4188-97d2-08df33060af3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|261021121427099003|10067099003|261009223027099003|261021123027099003|38070700021;
x-microsoft-antispam-message-info: HDRbDFLzkSbNbTIBsVcSz/HfnUTiukjRKyU3mcyKP8+xWKQUceMI2ns6Y5+fSD51XFBWGPCDBNpTbLXPOsR1Q/4m+QKUcDMy8VAXDJ2UEsYm0mnFJiiBa89oAJ0oPqT2BXof/5fDymX/MN3MZ2Hg7dnAd9KpScRfABjc2+tdi2hoq+si370HISRxeeCKcpkVj5sGialBROE3jGZsy2bEUqEWhkjo+DQXM5olLzN1BqeXmz+I2QwvJIi+1VNtUdSFTMCZt1bJqPpfDCpxCbP3KMN0xQNDWWaJksgRu108sDkFy4TO61n1GHdhLXjj31pxDgQ2RUGRrdlsMpgTRP0NV6kYZney/rrG9LIlBlYyltxu5cV2v1yNW/+IrYV0ZBo06Kg+bt4qZ5t10+L/TTp0MESHv1MLnWXdZmQKA+sa39qrPMe6s4MFhPvBgfXshdJNVOkvgtC2hYV8TMpQblnHw8sVuKpxalLa1Vcm/0bD3GstFnpE/WeVN1HQ6h+cUBIzn93xg/WjwVy+WiVg6UgktRYo/iUIR+hU4wXbyhgLID684O68AuIltJck+CGrZiPn7Yx2+2eQ2KA+Cuzdmv1eMYf9O6F/tmeiMos4xHUs9AQf1Gl6B3iZrdtUTK1cy6Hay8xh6qeIAYh50YECcsR6asGGnymmCu0aJHD4uCiYzeA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(10067099003)(261009223027099003)(261021123027099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i+2sYEVz+/KK5rvVN90V54HAZuyaHHYQ1eZhev+zb7ISpicMhCxhEMstLBYw?=
 =?us-ascii?Q?bhI/0P+dJc1H738pirj1RJ2ht4ZgFoo9UBmLtvpFcAJi28eaRG/Xt/hqUBNm?=
 =?us-ascii?Q?mZN9qOBvHqM+eq/Szth6Fw48MaqfealGhUcIIIekEX9bYzfwsMFB5oQhYppF?=
 =?us-ascii?Q?9duchDtQNEm8rHQJTh4JruUUFwZ00WWjGWN089FDaPJjph3shux0d7Vk/5Ur?=
 =?us-ascii?Q?e0p/0vaRcm9ZFYOToAoEoL/WwyGidsTxucwp9OCdZ8bRs7/00CB1cq8y2+wz?=
 =?us-ascii?Q?orL937d16s7AeLMym5sMpHxRZtOGryqYley4SxOhA7+bphwd5fftaOcZYI/e?=
 =?us-ascii?Q?x2fIWeEkxjg7hxgz0CsNMyhglH9MfFaCwcIBnsoyeq7cfxZKE+5HI2THWa/t?=
 =?us-ascii?Q?h2IQWOUWlr+xXxFDTyYLS4ZZ5iDyfgnB/op9FpCWQaemn0CRy9FwjmQXWjo6?=
 =?us-ascii?Q?jjJ07PV3Sh3ogKS7sZFbeuLnrrYa9oAQOtvXMfl7kbNtDTWBgCQpkpscUFLF?=
 =?us-ascii?Q?dm/t8aU2O6sgLnpOCm6xPHyoE8Y6MTUSVid2hlVzUS6kf9VwKQeelluDkMNx?=
 =?us-ascii?Q?hL29pOkcUOoWuz4A3AxSN7+w3W+3neatnUm0zF2uVdL9FzjESeB0/y2Awqcf?=
 =?us-ascii?Q?LTplUaefQHwD7A8xRzRiaq4G8t3AvkL8/a75A3SgPplGqnXjyqeht2+wpwmJ?=
 =?us-ascii?Q?6BAlAcUQb6Wbmv6OIgMM9TLW+bc8J9xXZi4v/vg00E2G7wojQDHU223OoEhz?=
 =?us-ascii?Q?0bj+6Pxk/sbJ6paLZ9RpJElEH2hCS/5P5FegnW0vCJdc8V8bPuFyqXTcdjTG?=
 =?us-ascii?Q?dzHpweQVvW3tKbzLxi0ZbS09Ou3sf4CR4a4vwK3pMEuJhdNa+V6w4V3HiFaU?=
 =?us-ascii?Q?sv7CG7JqlTWM2tRM2EsCI28KjcATvOJJd3kbiVr9U7pkd2Lbl2tRUvv3hxQ7?=
 =?us-ascii?Q?RO3HOE047Illas2kNf7M40wgv9oGN5/Doy3S+DVoTuKPdqSFRk0TH8tOGhzQ?=
 =?us-ascii?Q?H5RBXXiR3Y8a6/3SwirSb4yn7Z5tVvR1DWIrhekwuc6/jKa6bP7hFCJ+NF9r?=
 =?us-ascii?Q?uX2sHjihyIi4Hi/eZvdZJmTbbqKlm+gdNTD0w7zBuihhVKDhRIpfUBorDj8V?=
 =?us-ascii?Q?xHYYWpdY+rYhccVf6VQXrjtLGwhRIkZiBhfuyW4Gt+Z1HScgj6OG/33faZMW?=
 =?us-ascii?Q?rBrveRXZ7pWrNqErQlnHK7crEao6QgbaKQkStSmLDL1PdtCvOq6XVm3IQHdl?=
 =?us-ascii?Q?xt4DLP/iCH/rOtYVoLWDNSgizn5wZZK71QiJY1nD5jTcShyzXHK2jXEAFqL2?=
 =?us-ascii?Q?tyhPqYKAGwqg2zjSvdEweM7ua/gdANkTrZeFhSFutFTfZydB5w+9yRWgpYPd?=
 =?us-ascii?Q?2PyUtIq8nv5emZvnppKv1ZgggWCbCIPfciAEx/bkY9T5stiTWAmAkgxz26MA?=
 =?us-ascii?Q?nlcgeUsrxJrh9q2Nk5BNStL7G7/73j6TAE83/c6JzuQ7y/beo/ppvnqtsvYJ?=
 =?us-ascii?Q?jRnfjxxpvtIcHlya9HKjHC7FCxeigRbyKVN8ds5Op8v5sWxgcIG7vhANYVB0?=
 =?us-ascii?Q?uMvu1Zi8/mk0hI1+Fgr+ZPo9tflIO1UdtTN/gKM0u6htqDYaKFBv845tdW2+?=
 =?us-ascii?Q?MGdOYa7/VXTng02aH8XiDkkVu74bNTNS3DukSdsUAIVOljkM+Oe5N9+3FeKt?=
 =?us-ascii?Q?6OFcJB5oUriLvsWZGCjdGrcA0g2bMcFOK5AoxdF0R4tzPPuKUM6QmJPnIO7v?=
 =?us-ascii?Q?jrFZvgvUaQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: f7WauyMTU/mkcX3GBdXtBW5ogQU/lEsS4vZ7vXUNOPEUkRS9zfLjbzzo+SioOQwUp/VUIrMxyB7OMRKGBj2vyHPP77SijSnVWoSCY4DLfuAX0oQrgCEp/S7KqZCo+ccSj1/7jpgobCX7RjNTYnT4fxTZ6rI7lR3gKgFsxx5MwHit14tbNoNTpmZOCgn9a2lSjU2byWoMQ1mLSTNu0fq4N0LbJfMrWtJ8styVcMobF5BbTIa5hSy9Ng23nBmvEG8qJMZYi+RqYER7soLzbewF72rCKxYQWcUXSjE7K/9f92tQ8u7o4S4k3+JKCE2e4KsXopO21nZQ9/jbLEfl5rOMxQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db20e91-f94a-4188-97d2-08df33060af3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 02:08:35.6018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEXbd8gOTLmuzQCM1kTH+fqniboxNCNqD6pkCq9P/f4mlN80Hi+5sQClwLIcxNvSIY9Am1rhr/k3LV7lDqonog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6972
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>
> Sent: 16 October 2026 15:47
> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: Kandpal, Suraj <suraj.kandpal@intel.com>; Nautiyal, Ankit K
> <ankit.k.nautiyal@intel.com>; Karas, Krzysztof <krzysztof.karas@intel.com=
>;
> stable@vger.kernel.org
> Subject: [PATCH 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
>=20
> The commit
> 3abe2824e1af ("drm/i915/dsc: Use helper to calculate range_bpg_offset")

You don't need to mention the commit like this you already add it in fixes

Otherwise LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> added the helper to compute range bpg offset. There was a mistake in the
> divisor which caused the helper to interpolate the offset in the reverse
> direction, causing visual corruption in some panels.
>=20
> Correct the divisor in the helper.
>=20
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9247
> Fixes: 3abe2824e1af ("drm/i915/dsc: Use helper to calculate
> range_bpg_offset")
> Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Krzysztof Karas <krzysztof.karas@intel.com>
> Cc: <stable@vger.kernel.org> # v6.15+
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_vdsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c
> b/drivers/gpu/drm/i915/display/intel_vdsc.c
> index 7a573c2b6a7d..d70c59849c39 100644
> --- a/drivers/gpu/drm/i915/display/intel_vdsc.c
> +++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
> @@ -122,7 +122,7 @@ static int
>  get_range_bpg_offset(int bpp_low, int offset_low, int bpp_high, int
> offset_high, int bpp)  {
>  	return offset_low + DIV_ROUND_UP((offset_high - offset_low) * (bpp -
> bpp_low),
> -					 (bpp_low - bpp_high));
> +					 (bpp_high - bpp_low));
>  }
>=20
>  /*
> --
> 2.50.1

