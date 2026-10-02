Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4435F43A808;
	Fri,  2 Oct 2026 20:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790973911; cv=fail; b=Zh3FxnxXfS2x8JKFdKUxh0L5zXnsc5i6NosWeWmrwXPQBzdDQ2Uc3EettFOVlqkPZbES1ptQQNp+ORmTsOFDyDCRn8OqxOJA7JS1AJcMYea+nhwFTgxKfaL2BBu5OIwyhIY8PdNvrG9aic3a3V8AP086HWJdvU2YD7ep18RC3Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790973911; c=relaxed/simple;
	bh=LWAbFqZzjpJ9FuOq3jw0V+IJgGYHXRebeAJ8FaqeDMg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O+KGPg4gSqUMB3fi7DvP4jo4+t1LBgY5md5/D8jY0LOkcJUqByQcnS4fXba7nzvvoyaIc+5baaHJwCks9qzOq7kJVqyJ7nT+/njfgllwjz2H+12TbHqZqL0wj28qt+U8qhwrkpi3FGWcVKFQQLzd9YkxzTrlgTt9k7I1E3wDexo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/PnnF2K; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/PnnF2K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790973910; x=1822509910;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LWAbFqZzjpJ9FuOq3jw0V+IJgGYHXRebeAJ8FaqeDMg=;
  b=Q/PnnF2K1B29KtNY5JL3Vceq++MDMfNYvfc2daEudyfvAStxal/37G6d
   OeTomeere0tqCVpHsq480LfBcKlq1A3VQMbLbXvQzpCwvfUEBSYkLWrQD
   EoJSKBiTROGEVssJ/BtrfAG0AbLrysDQMM2zXSYx2k3l1RvwJjUuiYhWd
   owvePpPwsercjqSVnrDD31lNd4lBqzrvFqXNwoK0xP9KA4zie9JtPxXQc
   jn+PBbmWpW/Q+ZOh6Wc1lnPuNGM5LQeBQGqaVRYnDGWix1LlW3NGnGEWl
   a/IoodS7CmSimPXV3+ZCKHmIpGyciqwJeuGIRDPvfkVzHUh2xfVjXz9tX
   w==;
X-CSE-ConnectionGUID: WRSTxBIVSESNuM9h36Zyhw==
X-CSE-MsgGUID: nxAZbw4OQoiHutJp1EcmpQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90642944"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90642944"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 13:45:09 -0700
X-CSE-ConnectionGUID: uoYjTBcPTuyrpJ0/oBGm0Q==
X-CSE-MsgGUID: 2vpQlteATvSiidUf+oqa6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="355564"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 13:45:09 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:45:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 13:45:08 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 13:45:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZtdE9L/H96CZBMWW20GLS/8cjGYgF0VW6WrQGCO72R6RWpCW+7b2B4Xj+ijB3XnJvYfQwXduA3bdysjvz9WQl0QUQS8H8bMDU3vVjfCNAo6+na6stCICRw60U0GpC+x6H8ZeeIruj1ILoMfpouEDyRwkw1W8DbYMg0WrQs21zVmB7u+2n0zzisH9E8o+GExHjhGEWwc6AWog7DEVkeEyF9E5SAqMeJ/tRz9eUiauRIhsBydXSEeQ78CpxFYIbbkRfrU7hWQ4C11rZ4wEu7TjprH0DdE2txrntb6GIUw72ao3rxSxdkY6/9Ri0UtA66YCergD55uK7ef5TjfTnsStAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=try3CTtG3kavv757K4ONMQ1/DjiqtUe9J6qGxHbdRQo=;
 b=Kj35AReNMk5kivcajSO/XQPFE+SX4eEVJEUhDH3TBObtctPeqxJc1zmDlP0Y/5N40KSBUHRlzFD1um8O8DEEieuxgRQQdHjJd5Q22Ue6zPWNeQdgEkXiV2D33SSQYHlE63bC3296H+P6eFRsakLnwgdgKpnoPuEXxGwnpw97lWk3L/WofO/bbq6Q6anELOZG6CcMHib4TDnJYB/N16z5rJk6FfChKAYvXyHLQViP37RRwMfM3SPCIuutHDG+9osF8CstlrIIur0EPtziaLHfc9dbbSRbvNILZB/50xWNb+JhCVafSB4B3hB2xr6lIh4kc/n7RqB38VreffpgW5B3Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 (2603:10b6:610:367::19) by CY5PR11MB6188.namprd11.prod.outlook.com
 (2603:10b6:930:24::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 20:45:05 +0000
Received: from CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823]) by CH3PR11MB046149.namprd11.prod.outlook.com
 ([fe80::7c3f:5300:19c4:b823%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 20:45:05 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: "David E. Box" <david.e.box@linux.intel.com>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
	"Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "Siddiqui, Ayaz A"
	<ayaz.siddiqui@intel.com>, "Muqthyar Ahmed, Syed Abdul"
	<syed.abdul.muqthyar.ahmed@intel.com>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>, "hansg@kernel.org" <hansg@kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 2/3] platform/x86/intel/vsec: Fix inverted walk_header()
 test in get_features()
Thread-Topic: [PATCH 2/3] platform/x86/intel/vsec: Fix inverted walk_header()
 test in get_features()
Thread-Index: AQHdUfDKEhPcl5FXrUuHYh2lnuz4PbbqucoA
Date: Fri, 2 Oct 2026 20:45:05 +0000
Message-ID: <CH3PR11MB04614961D00C07BD3BE88CC54DC1892@CH3PR11MB046149.namprd11.prod.outlook.com>
References: <20261001220351.1592138-1-david.e.box@linux.intel.com>
 <20261001220351.1592138-3-david.e.box@linux.intel.com>
In-Reply-To: <20261001220351.1592138-3-david.e.box@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB046149:EE_|CY5PR11MB6188:EE_
x-ms-office365-filtering-correlation-id: 743261f0-ef3b-4894-49f3-08df20c60a3a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|4143699003|10067099003|921020|56012099006|6133799003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: e1HYVAorGs41xE9+8mhEdZan2xDPM21mFFuuSg9zj1EJF/7gw1fTA2P5Lp+9cwFRGZGbZlOq6geNBeNW43FEn1EBsYhSWPKD1ZkPnbfvq6C/NoVBWrJsgiJt5Os/xtLoJOAnEvY/weoYZOpGpad+tgQ0dI/yQt0bSgIHZULbRzj097/WZd9nuJ3vq1FnW8qP3UCvx6rEIuvIKBAF5m7bL6KH/5VrTOOgpD+UABhi2tz3bd6jkLJX43O+mlPYtIBaX5wEea+GJQu4PniIabIeDJIb0emIO3oX6lRSU6t+anq8KY9EDITR+O8doXZsQxkF4MqbFiwGRcfEQCZPHaOF3mMyZhYQ5GUlwkp3X9mYXOQwJvt0qP/ajwDcLP24ICT8CqPPoFLAaeVuvnAWeLiDEPwQ9V4eFJlRPqrnLS5V0GpLBHFtocKT0nGaK82zH7KEpz0JCQJVo8Z2xRylKNe1V8OJJK+A5T9fTcqPE3a12sIRTFuXQhQUiIvCk+ipjlDdu2bBZjv0fRwJLoUIgb/zugWy3cKcXq5mam5phOB4O8gm63AKtD1CGcm0J6jXy9HJG2s9Jn5qG6POopdD63LjBSNg4gjtpwwPIFZaCkVobsKQva7tOWGuOlVLNyMHC5g9Q8iPWMC5BxJe+BJinOp1pwpf+lrVviOqZ1NL/iMnMoIEMdHYIe/oAS/mSvPUKcRy6h6hGfIF9HaJlDBqVJH8pYa9BQPy4X/O8mnFvucnTSh+tyjclnl5RIyq0jip68un
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB046149.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(10067099003)(921020)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gJ9PzlyiPo6OZ4EZwdEz25unOQXGGeRJwaYuQapvzjNT3no1OtJMIBOFh73C?=
 =?us-ascii?Q?sMwm2MaT2S8k9vXlpIs85vufPZ/lYTalvEeGwHNGrhQBYbCKOnigo7aiSs9N?=
 =?us-ascii?Q?Sq6zAr4hlwJoSDPzWhgDvW5u2wy0apz7lV30Lz3swBI+ebB9G6+wuQaXVPNl?=
 =?us-ascii?Q?XRfiFWIy+yEg/MkmAhT+qjIJuT/XCU1Y3UKVPpjN3OR0zWY7i6cotBs9qa4L?=
 =?us-ascii?Q?Jc8Z4qMyyMc09ee3ta5mLLsobepNGpkhouNt4jbJmirp4kEnQtTpl+5AVED2?=
 =?us-ascii?Q?Q6kfifB53bh6RiSnzKZmA0Xjyhxt0Y6BMj3fsRPku5SnETKvBadmzY1U2oHu?=
 =?us-ascii?Q?6tUA4u8lCGidkzrsjyxDUUS4bsRaPyulaV31MoC58SiBepciysRjL0VG/2sD?=
 =?us-ascii?Q?Ri0xFm8FbNCcyuzRLSoIMLdwr1XFgFbi8++an8bibfwj2JdWC6RJQ20nwA3A?=
 =?us-ascii?Q?NLLK/sRD7YFdubi6QXoydW1voQfryp30xOk9r58K+0ipPkGL51yYkTrumTOt?=
 =?us-ascii?Q?QhM5tLjcqXcQjhGlxSv/JVA6GyjNPVUf+YbizuNkYHYN+jaU9mvLGuLJszpE?=
 =?us-ascii?Q?1D3W/nDFMpNY8H8DY0Acnw75ktPflacuvPPQYE0njiO+/KjmsXTHB3vfGC+D?=
 =?us-ascii?Q?fAoFJhVNJXLaIGHFhKjK1HwNmcOBD5sezU6CH8GG5by0lau0fbNIgS0G8AUh?=
 =?us-ascii?Q?o/ceMQN2M6bOu+D2nXGvH7lG/Uqa90Qo4NIEJFrPaZixXUfCTPZMMP3fhOVl?=
 =?us-ascii?Q?7LcVma+cxfsp3vhk/bsA44/ZD+W1+ftAqoIt7v9zC29AU71tWjGcY1SfLgb3?=
 =?us-ascii?Q?UDzOnd0gTC6YfX77RYVrp6aEut5vmXQ3RT6gUBJbOK6UPVjPuvZczjr/vKr5?=
 =?us-ascii?Q?782YQSUS666Z23hB+ORirX/4XMeD1+aa7bQw8gLHaILubUuYTh/ZuSJUe3he?=
 =?us-ascii?Q?FmDfv/PDFRFnJKcS04Xy/qsj/grXuXPPe+/OTBoYuFHi9eNmUercxMSgikao?=
 =?us-ascii?Q?jImWkmg9DLuAhW5ES7YyUZ72h2D9Y8LJg7uheaZRtaXSbqnR8mKeeJBP9JrY?=
 =?us-ascii?Q?VcO8sN6JgL7MvAlqa1vSWD6SRlSkyfD2278k3mNzt5sre0WSaqibmvBtTCXq?=
 =?us-ascii?Q?m/FI3nkhm+w/KmLLBX6EDD0/adgadOizT6xnwRsCOy7c3B57Rw13yJ4Tlwbq?=
 =?us-ascii?Q?Lp4WPSWI05Uf/C3y6RjK/Tro2c9Ui83LltJV6r4N8ffn1Ris9FTVg8Xa95p1?=
 =?us-ascii?Q?JnEIHWDJZ+fuvDMeWFlGcISLtB97+eIfEIlpoDIO84TMj+qpghq6ZpiQf1Wk?=
 =?us-ascii?Q?pV4Aag/ozPdZi8ytDpIHl+50VZrSOyM6PAK6ZUz+dt26KzvqhBOCdbwZGsag?=
 =?us-ascii?Q?ez5IXhXAdErIg7Hdv68Pg7RzMHAS5FURxffxSWLdc2yyEXebKt8vrN+FwRkQ?=
 =?us-ascii?Q?Zwk5CXpnUKrsyS5cf5YNQ7WEi5hkjVNl+9uEsTN7urK31chm/lNKDuTWT6pk?=
 =?us-ascii?Q?kRk6JBVfBSmNQX8CN0TQ6QCAa83llAa+IeffTxgfCEFcfrjWoEjFZfkmqnxO?=
 =?us-ascii?Q?IVbUGe95uCl7WJbuhNGFIyqq8TFVD+7COY/gf3RkUmWbsOMB99R3b08R8rwR?=
 =?us-ascii?Q?9p2qgPspOAOV2hEOYCFEA9jn2XiUh90xpyoL574BASihdqCazzLhr54UKtiQ?=
 =?us-ascii?Q?bkU2UeuaHY7VP6sYeIrGyBFXMatZXuY/mwWqXoaYefh3nvhlWN0Xyw4wqS4l?=
 =?us-ascii?Q?2cVy2yVbBQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: vdsbc1KjZhwzL+EdjKNPmteSHD/q3A0ZssJbTHfAU/de9T4PTJW6+eFiYllgiuMLmfLsLFEBtDVOgsdKyVzLQbu8cKd1OpzB7pZbWOzLfHmijL3qPUC0u6/J4PnwvdB1QbZYDbSVnZ1eq5Wcd0qKpDvqbQVzqeoB746UxVrJyfnBHiefrVoTl2mq7hRNYJ9B1dRitjM3xj7x0vr74LiwK9r5vqFCm9OvLTVcWf/E30o9atFZb1ZzH3IXmgcd1p0NSM1LNDKQ9tYN3FaZARLJaqx64ASpsjx4xfin/tihCF6wv/rYTRqHkdgfVV1CtoWPBTZSvtkwmyDn/fo0vp8gRA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB046149.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743261f0-ef3b-4894-49f3-08df20c60a3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2026 20:45:05.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TRQG1jZS4jcCw+z7M2nozjSxfHGWjRK101wWkVPRSx4Yd4tM1L6SWLh+sMJjHYQoYo3HdZCFNPfYYspslzzTq4toWF7vsG/wYIlGLpQW1Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6188
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: David E. Box <david.e.box@linux.intel.com>
>Sent: Thursday, October 1, 2026 6:04 PM
>To: ilpo.jarvinen@linux.intel.com; david.e.box@linux.intel.com; linux-
>kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; Vivi, Rodrigo
><rodrigo.vivi@intel.com>; Ruhl, Michael J <michael.j.ruhl@intel.com>; Sidd=
iqui,
>Ayaz A <ayaz.siddiqui@intel.com>; Muqthyar Ahmed, Syed Abdul
><syed.abdul.muqthyar.ahmed@intel.com>; intel-xe@lists.freedesktop.org;
>hansg@kernel.org
>Cc: stable@vger.kernel.org
>Subject: [PATCH 2/3] platform/x86/intel/vsec: Fix inverted walk_header() t=
est
>in get_features()
>
>intel_vsec_walk_header() used to return a bool that was true when devices
>were found. It was converted to return 0 on success and a negative errno
>on failure, but the boolean test in intel_vsec_get_features() was left
>unchanged, so its meaning is now inverted.
>
>A successful walk returns 0 and leaves found set to false, while a failed
>walk returns an error that evaluates to true. When no other capabilities
>are present, intel_vsec_pci_init() then returns -ENODEV even though the
>auxiliary devices were created, and the driver core tears them back down.
>
>This affects platforms that have no DVSEC or VSEC capabilities and
>describe their features through device_data instead, which today means
>DG1. Test the return value for success explicitly.
>
>Fixes: a6ce8bf3c993 ("platform/x86/intel/vsec: Return real error codes fro=
m
>registration path")
>Cc: stable@vger.kernel.org
>Assisted-by: LLM
>Signed-off-by: David E. Box <david.e.box@linux.intel.com>
>---
> drivers/platform/x86/intel/vsec.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/platform/x86/intel/vsec.c
>b/drivers/platform/x86/intel/vsec.c
>index 5ab2215fdd7f..7d51f27f09bc 100644
>--- a/drivers/platform/x86/intel/vsec.c
>+++ b/drivers/platform/x86/intel/vsec.c
>@@ -641,7 +641,7 @@ static bool intel_vsec_get_features(struct pci_dev
>*pdev,
> 		found =3D true;
>
> 	if (info && (info->quirks & VSEC_QUIRK_NO_DVSEC) &&
>-	    intel_vsec_walk_header(&pdev->dev, info))
>+	    !intel_vsec_walk_header(&pdev->dev, info))

Reviewed-by:  Michael J. Ruhl <michael.j.ruhl@intel.com>


m
> 		found =3D true;
>
> 	return found;
>--
>2.43.0

