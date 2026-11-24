Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795508271;
	b=tkugxm+e5B3DL+AHmG+SDdhXug2sFl7cE35UsrVOPC5U6suMkw+/hm1slVFKT5s2Io8f
	 kOutGN9IpM/5cklvKpo9hx5zTq0D9dVlV/5n2cjBoRZANLArrSTKGWCZ6pYpTbftJe+Vh
	 QHHW45OgS39sjhGbb418EF1gZwLYXQ5dDrDeOjPilLAzVEnh38om8icQhm3ViGowdvdZl
	 GTdnG5x8z6XUeMewxYj1x7Zw579pd3h1s3op7vcNm2l4Aoz5RTZIXUEOfQEpS7lF3i/hH
	 bqul25hlSf8SfT+bXf3UF2HKdVtip7z3u0vitQjnt6liD5spXpVUlPh2QS6VSLYbx9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795508271;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
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
	bh=zdkk7yHlG/V9VPfyLOR81/A7zNdnlt0AgDEd0uFxSnQ=;
	b=PWRd7gAkQ+ZZX3ZnGpcpxv4nR0qIzAXkVTO+fwCs3QwPLfzCaTDUWj9WS3IvyQd28Rye
	 A6qrSQ8JKFbhePZBmWL4L78MO8lLeJ9UGeG8rZTUHbqQzL4uSyCoiW159IiDiSMlGoqid
	 I9QNRGMoWChjIyhQ9xqJfgEsDik6aeiYhGbQ7Us9PRDHnMCZ+P6EVBk7WKqlcj8HTDrBD
	 eHAGYTSWDB4GbN6EwWNsAckuI09mHPxBF4aocGw7HQG3kFhLM9RxeYlG0zNRHgOP8rU6Q
	 2IYmLfAAIkPVsFIxl1kvlTM/t1APKRaP6HnxYptutWGYGEku3pakX9p2z74xDlUW+5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K9PlMx0J;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TjREHaIk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9503606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 08:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9503606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K9PlMx0J;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=TjREHaIk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795508271; x=1827044271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yzHtERIvN2r0IlbJ+NLOZ0SC/3qjYssfbU2aFp2h2qA=;
  b=K9PlMx0JFHlOaWpUk8lxW2N50lpZ1d7H8YtL+aDcvc0oRiu9PEpXmq2N
   8HQWl8ZDhB3EDTM7dYmSaScSUDOOTxxpBEH5+Y4t7oLXlp3u59sP6Igk8
   c1AGbWDb8F8gdY2VS70sjoHAPEY3gvzW81oaLPPTNjO/JYzBTvTiEe60w
   4f5uAgvEXtwE32nDjUVpuHtsUG4iyDPaWDwiucOvJ0+Q+sVqz6sSlNdKh
   pxRUHT26Tqv/Q7bUJAW8pdTrRbErtyCc6qrWZ4/DHHEt/wcM47U9Vf4Hu
   X9O8wdPwHPECRf2OGm8ud+EX08+qFjydHczRInixVEKGfLl/s0vWGguDq
   Q==;
X-CSE-ConnectionGUID: yfpYXxG0T2iRl3UJqT9JWA==
X-CSE-MsgGUID: 39nFzNgkQS26ALTQkivcLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4349992"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4349992"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:16:37 -0800
X-CSE-ConnectionGUID: 5uJPnqmvQkKKgiHN48HXug==
X-CSE-MsgGUID: +eJ6zBoTRQGhvOXph+9QWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11719085"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 00:16:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:16:36 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 00:16:36 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 00:16:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5LiB7AXwxLzg8vOY4Uwa77liFnMaDwwO/2QBVbhkzrmqbDL0umNmBK3MifoSJgKOGPkbPvBNnkj/PpQacIeG8G3ShPE06g7FBdoBQsR+Fr3tNK3w5YtkAB7YQQek5eZ9ZYXoikoE51B6W5WC2ng4em6kBUdfny2K2Uf8sicl8A+wmaOrdd6eLRj8FRHkA63/T0L3MUrW7JIFiDPfvjmK3Ut1UBzXE4cFmOHkvavi9DYJPCo5PW/tvaPME0G9hiG+IZXhpOgcfJ//yJGX7Yp/ivrY8vT25UuElaUsK+2HkOQlIuCrQIkAj3neCyWAUF6yuUvCbEOLA/nYoGl3NqC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdkk7yHlG/V9VPfyLOR81/A7zNdnlt0AgDEd0uFxSnQ=;
 b=woiox5Ra8UW+wwDYYvgl9J4SGmE2NSxIiNTS6V9zwXGsQ7OrTUqmCA7sbQ74S3PJ6OWS1B7bPE2udGK0McdAuFP/LwMoJZthFdVZzLBtt7gUljtzddrBAi8LTO/7dyexLai20/nD/yfAbz2eltp4gql2UWvQ034Mov5pnZwo0CjLdq8zIg9exxG8okw7JIKmXCIcc5yA1Ue6DKqdULfj63ye0FUl2dwnhwrT815yu8YHvL97QQYm1BIUq9Nayc2J8x9x15fWxrUi5czn/sXaJ7n39mONNGaJfCZ5jyADN68ASw1ULC4/a3Aun5qhkx+/xYP2BPi7FpUk4tMsD6Z7nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdkk7yHlG/V9VPfyLOR81/A7zNdnlt0AgDEd0uFxSnQ=;
 b=TjREHaIkKma4pIP3o/BfDJPKu8tHVtoZBns6auanRwB6Dqx9KTEMPM1WjMUZyI2vsaYHHAYImaE9OAWcjgFB7DaQ23DKtVnOVqwWbOAedZpiOZCK6KwPaEdQ9LTgcYKPwJxVxucS0EdgODFO2srhfnzeetLMXQSj24ODR5w9vUs=
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 08:16:32 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 08:16:31 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] drm/i915/bios: Add quirk to allow eDP joiner on ASUS
 ROG Strix SCAR 18
Thread-Topic: [PATCH v2] drm/i915/bios: Add quirk to allow eDP joiner on ASUS
 ROG Strix SCAR 18
Thread-Index: AQHdc38Z6tihN3N6oUao3iDvEh8jo7c88RnQ
Date: Tue, 24 Nov 2026 08:16:31 +0000
Message-ID: <DS4PPFE901A304F08559172B55EBFC52E64E3442@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261027024334.1140596-1-ankit.k.nautiyal@intel.com>
 <20261113121106.3241899-1-ankit.k.nautiyal@intel.com>
In-Reply-To: <20261113121106.3241899-1-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|PH0PR11MB7424:EE_
x-ms-office365-filtering-correlation-id: bd7b4d10-50b3-4048-4d65-08df4a033f57
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|261009223027099003|261021121427099003|261022113327099003|261102123227099003|261022075727099003|261026121527099003|56012099006|4143699003|10067099003|38070700021|5023799004|11063799006;
x-microsoft-antispam-message-info: AaD0Puzc+fy7rLPK8zTbfM8rym2nA34O3yGrSx0sgas7YReQVjuvV5ikhZkRaibILQfapeYw6kDZRaG3kDLUp9vuxCFR9o1VM4ErWeU/lHSbBIbNdc7Grer/btB0rKTskyR8B8cowQrhxWFinqeaaIjvoE9I4DeYyY/R/vJ3pipY3gDdEc14+QZfQEG/ViTpd8eYdbha2VT0cU2dv2ZwnlSfoN3vsI4DVnonK3aeCB9ycsqTdVPtTJhy5nwgwQznByRm8+oijGgCfQuG0zIdUVKrJ3tBPTWqfMkj/F9BagvgVnLXI/zScwCi6/FgiVNWKnmmwVIFVNuBB78aGYeBtmxy0mJ3dB+3wRL4qj4GDiiHuO6ilKerJqp2Wr1jqBPkCYuXwmng4F9m4jIuCOC+abCrJ2Hhta2qdrC0FjoUgl7soJR3joJsI24CCWXBBaVvs6+A8Fdw7aOWQBGtTJlkBY3pdk5MzMTQYr73DUjQVG0MufNjQBEuTa6A+b/gUM9W7rzylqYX8BCWBHwKt1R1/zXqmFm7ezmWcnFOhINx1ELI0avb/sgR3SkzFUq9OgugBeXEF8UMX8jrnQyJ/PRIUUPcOoxazvxto1Ypmq0uTM3I4VA1spqFiOjlpg5NZemP4tUkN1JVBczZ48szl/fGMNW+3IEwZYgLNdnCK+mEFVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(261009223027099003)(261021121427099003)(261022113327099003)(261102123227099003)(261022075727099003)(261026121527099003)(56012099006)(4143699003)(10067099003)(38070700021)(5023799004)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JpXNs7JELurs+LLyGh5uqYdwLNjBlromPrQ6asVGsgadm/79Slky2bAstpCt?=
 =?us-ascii?Q?rUd5c7kEEqc6XtoCrxEjhsC/hw8B5rArRGoRzuevotPyfBJu5S6Q1+bmboWW?=
 =?us-ascii?Q?7mGNdbL2zL9dKF3YEJ3pK/ZeIPqZkDPO7zwZyGRbBb0Ukyx/f+tQI+EDUvlL?=
 =?us-ascii?Q?u2E4OjuhXJrsSiIhlrIqsludA5XvY3r1ihCYZE/IaWXAVpDk3JSmjLYkf6Do?=
 =?us-ascii?Q?xLkU5s1Ft9+fZN7M0q+ulmjHLSDhO2K19mMVp7w72vVbE1PRm15nwrYLP2qL?=
 =?us-ascii?Q?jUzsZlI3P6LKHAgECh5JHTvVrlTbgmq4S0WmRAh+PK5e1GdyxhvD/Dm1Wiix?=
 =?us-ascii?Q?kOnxcOVkaZYj/XexlY2NQS5K7ub83JnRZRDRjqMc1IQkNd1HnQ4JsI70Ve72?=
 =?us-ascii?Q?6F08WOrPTg3t1MWLKEg2vhPA5CcaKfMafQyDnW6Ij2Vjdx+LqZz8azZR4Tvr?=
 =?us-ascii?Q?iAbCBIBEua6XNjEQl7FLXOQRSLWm7FERvswXzGNBErJcQONtF0u7ZRlAQubM?=
 =?us-ascii?Q?f3/Pwn79Ilz42RX5q3aXwYXXn7IdcLwWtAD+gYf2lPtJTGzxnD8qQ3ReDQfi?=
 =?us-ascii?Q?S6+tZUtlSoe7vWSzfAOYOidtCqwidC8ASAvRt1eLAXxk5pXCe3gbp0PRwWY+?=
 =?us-ascii?Q?jJbyBwb4R2jwq2sMrnlnt/iCueInB0k+8VQfOPAb1Hv6HMGcHAWkzwMv92Cy?=
 =?us-ascii?Q?VxZFRV01mXXxZ/7zM3YS8iXAoQ2LAscm2k1Z3ksBKHMJD8mohxaxvvV2E+4V?=
 =?us-ascii?Q?ji9yz9+TydVeDQkI3n7PDm/+iyGYIPVuPEzRHSjx8a6yE0etKUFNgXwcZCq7?=
 =?us-ascii?Q?R3E9soTDMKZ99HBtuYO/H0mh++NdZH0kP5bppSrbR8MDpJL+Z1LBg5g+L8jP?=
 =?us-ascii?Q?rs4PfVJV1h7LD2UrLCtmqo4NLf5nMAg+8+I36jIaAQ/DQOLVsccMj8lMgs1z?=
 =?us-ascii?Q?SarocHL7TQOktuVbP+4BztO0135nnHV3ielR+DkqCjsorkXskdeklFeYVOOs?=
 =?us-ascii?Q?WH0afgtQkuBFhEIlXcNJi0KZvAIXx3fRVmAuWiCCqDuvBrMuN3ASzMztCCqY?=
 =?us-ascii?Q?93VDnghtJ4hOkRd/N8xhuc6a6tXglfx4Yx3J/SeAXTSb9Ma+DAH8MLjSUjXU?=
 =?us-ascii?Q?G2ft6s4iRb5bm1ZzW0m8sMMKeCISIL3JH/TqS8ZH94nBhVazgc2KRizhp1vt?=
 =?us-ascii?Q?fuKEWi2/94WIDtouCgwu2IsI+4M2I+j5H4DsmEKQXb2cA5qcjLr1//nJ1Le+?=
 =?us-ascii?Q?3fqkYBP6s7VXKtAp10PHMUak62beeGRgYtuLAfIwkC0JyDcnIIo0DH4VG8B5?=
 =?us-ascii?Q?pdPSwroVZVP1W1G0KVMyn6G3z0/5+wZRrefnfCiUt+e1bEJ8JG8hoE+LZTHY?=
 =?us-ascii?Q?HjkYMgW2G39H2oWDywUm+QjTZzCIV4Xei1YYx6dF0Qhs8f3vC1WkkKY5ItB+?=
 =?us-ascii?Q?TNGzyJV7O70jcYHww72NX7meZUycyU/1yVyFdODz2BOAOD30CSiqImQpMBvp?=
 =?us-ascii?Q?uvKD8kN+7S+741jW/Pba7TbsQnF4tSgXIsR41HtZO2NDuFGwX8XSelQDzp7X?=
 =?us-ascii?Q?lRIbcE6MVm2b/Msjkv8kh7EymRdlszBJmnJlVFevXXgo181GYTqpO84+LaCz?=
 =?us-ascii?Q?NhAsbXa44DJH+gJPaYeW0dS/hjEIhDRtxxqehUwH+ys0SHsptaxRbhkXCTdr?=
 =?us-ascii?Q?6G+n0e2ZN1xPRzG/eB0/0ZPkxQhi0LV53KgBvUngUyhO9M4FqotyC/fP2iuZ?=
 =?us-ascii?Q?OckveDeXNA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: jr0vK9d8obXntQX2YUQX6SCk/7UJAr5wnnJCR+5S/08YAzZuhKUNku/6uCiOWPRJAcYxzeO/fMKc5nE0zRKaJDkzFq9Wk8hSa0ovWfkndrq21nrB+75zn63tnXNYzO4UKH1cgLpsDOkrODab9QEUEklhuZM7EvGFBv9wqbU9Ac2zCdwIFUny1k5XvSSecLcE2D9R+oJqdRlp7LFduH+9uvFSYSdWD0Iv5MeDJ/gQaToAl1dHtSwNOkqxv3x5bcHTslkFe20XqaykvN1UVMkjUPwZpz7Q3T1n33HEw26O1gI89EqRHmExD06S4WSH7U25n9pTr3xFHvxfka5L0H0N0Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7b4d10-50b3-4048-4d65-08df4a033f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:16:31.7791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IOrp7jrZXcOKHKkH8FMqHD3bXkZiOOQZQYpct33RpfreozB1uWnGs4Tf3/LXEJ+RQcUNZ+3kppj7cNktis817g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7424
X-OriginatorOrg: intel.com

> Subject: [PATCH v2] drm/i915/bios: Add quirk to allow eDP joiner on ASUS =
ROG
> Strix SCAR 18
>=20
> On Arrow Lake, VBT defaults the eDP pipe joiner enable bit to disabled, a=
nd
> commit 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in
> VBT") made the driver honor that default.
>=20
> On the ASUS ROG Strix SCAR 18 (G835LXG), the bit in VBT is left to the pl=
atform
> default instead of enabling it, even though the 3840x2400@240Hz panel
> requires the joiner to reach its native mode. As a result the mode is pru=
ned and
> the panel is limited to 120Hz.
>=20
> Since the VBT bit cannot be relied upon globally for ARL (it is needed to=
 block the
> joiner on at least one other machine), add a machine-specific quirk, to b=
ypass
> the VBT restriction and allow the joiner on this machine.
>=20
> v2: set panel->vbt.edp.pipe_joiner_enable directly in intel_bios.c
> (Jani)
>=20
> Fixes: 650471948e49 ("drm/i915/dp: Avoid joiner for eDP if not enabled in
> VBT")
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: <stable@vger.kernel.org> # v7.1+
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16854
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> ---
>  drivers/gpu/drm/i915/display/intel_bios.c   |  5 +++++
>  drivers/gpu/drm/i915/display/intel_quirks.c | 13 +++++++++++++
> drivers/gpu/drm/i915/display/intel_quirks.h |  1 +
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_bios.c
> b/drivers/gpu/drm/i915/display/intel_bios.c
> index 7b6a6f8c3cf1..b77d1599482a 100644
> --- a/drivers/gpu/drm/i915/display/intel_bios.c
> +++ b/drivers/gpu/drm/i915/display/intel_bios.c
> @@ -41,6 +41,7 @@
>  #include "intel_display_types.h"
>  #include "intel_display_utils.h"
>  #include "intel_gmbus.h"
> +#include "intel_quirks.h"
>  #include "intel_rom.h"
>  #include "intel_vdsc.h"
>=20
> @@ -1575,6 +1576,10 @@ parse_edp(struct intel_display *display,
>  	if (display->vbt.version >=3D 261)
>  		panel->vbt.edp.pipe_joiner_enable =3D
>  			panel_bool(edp->pipe_joiner_enable, panel_type);
> +
> +	/* Some machines need the joiner regardless of what VBT says */
> +	if (intel_has_quirk(display, QUIRK_ALLOW_EDP_JOINER))
> +		panel->vbt.edp.pipe_joiner_enable =3D true;
>  }
>=20
>  static void
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 96eb9a40df9b..613a847184db 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -108,6 +108,16 @@ static void quirk_enable_dpcd_backlight(struct
> intel_dp *intel_dp)
>  	drm_info(display->drm, "Applying Enable DPCD Backlight quirk\n");  }
>=20
> +/*
> + * VBT on some machines defaults the eDP pipe joiner to disabled even
> +though
> + * the panel requires it to achieve its native mode, so allow it regardl=
ess.
> + */
> +static void quirk_allow_edp_joiner(struct intel_display *display) {
> +	intel_set_quirk(display, QUIRK_ALLOW_EDP_JOINER);
> +	drm_info(display->drm, "Applying allow eDP joiner quirk\n"); }
> +
>  struct intel_quirk {
>  	int device;
>  	int subsystem_vendor;
> @@ -270,6 +280,9 @@ static struct intel_quirk intel_quirks[] =3D {
>=20
>  	/* Xiaomi Book Pro 14 2026 */
>  	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
> +
> +	/* ASUS ROG Strix SCAR 18 G835LXG */
> +	{ 0x7d67, 0x1043, 0x3b29, quirk_allow_edp_joiner },
>  };
>=20
>  static const struct intel_dpcd_quirk intel_dpcd_quirks[] =3D { diff --gi=
t
> a/drivers/gpu/drm/i915/display/intel_quirks.h
> b/drivers/gpu/drm/i915/display/intel_quirks.h
> index 4996419ae76b..c64d0fc39905 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.h
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.h
> @@ -24,6 +24,7 @@ enum intel_quirk_id {
>  	QUIRK_DISABLE_EDP_PANEL_REPLAY,
>  	QUIRK_DISABLE_PSR2,
>  	QUIRK_ENABLE_DPCD_BACKLIGHT,
> +	QUIRK_ALLOW_EDP_JOINER,
>  };
>=20
>  void intel_init_quirks(struct intel_display *display);
> --
> 2.50.1

