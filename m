Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C2E38E10F;
	Thu,  2 Jul 2026 06:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975017; cv=fail; b=fw7zj/rARrWcrElp2M18H32l9UeYm9wMMGl3AckkZAM9eI7tXiVQKqoZhg6I4pbq8gVRyZ8CW7XBQlHII29UJZd0zoGeaUIXz/lLMy1stfAatDDLj2kngU5qZTx99hvx7RRD/FlJc19DM0mpNAwjfEIFpRI4ZlvP4k29hV4SIjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975017; c=relaxed/simple;
	bh=g44vGZzPcz2x90ihn2/zVlZYQBKuk17EqMlFol8SkeU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=upkehD6Ngt0mXL9D38MiGIa4ihYg1arKfqoOtqs2xvNY1Kqz6plCzcjOvVsO0t/KdpAxkeb26cbx+TqzfzFliXZMQu8lNax8C5m7DDN44I/XCtcwfjVf4ra01tKCSoyCFjjl0EFLY2dtSHCnc2p3HtAc386P45+8WnpfP4vnCrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fhtMNP0d; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fhtMNP0d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782975016; x=1814511016;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=g44vGZzPcz2x90ihn2/zVlZYQBKuk17EqMlFol8SkeU=;
  b=fhtMNP0do+gs/x5mGM8Sr8GsWn6TzVwSXlQYhIWvLLR3hK9rtz1nTn0e
   ONuJq1DPs07XKPhYa8y021wNGTYvr9sb5tf5sZS2PJ5ZgprCeAXK3XXts
   u1QYo7DBpN12HZdTR7Gp23W7uoU3pYMztV5NEgQ/J1Kj2HN7QCCN/Y6F4
   aBRSF7O4GoiIj0zmOi7B6eIY5lMTS58XiNdOE3AH21J0hBRdT2dauWjPv
   90OGtIC9Zbu1o1tSlMaCgDOKEqwGXkn3mvNM+IfrvDjqSR+7jwMbkPi5Q
   wLZmVxXfcGnFrcZabK/aZuxpU1JmurZ//cGDVu+fGQp598gbLIAGWEuhk
   Q==;
X-CSE-ConnectionGUID: Rn0vr+s1RNGFtvWxjI5S5Q==
X-CSE-MsgGUID: v2+1XIhGSgWsHn3M9lGm5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="94317322"
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="94317322"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:50:15 -0700
X-CSE-ConnectionGUID: BxyG+wNxSJKpsFNeEzcMrQ==
X-CSE-MsgGUID: d0XSdr81SEqKKJyvl+RuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,143,1779174000"; 
   d="scan'208";a="248319883"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 23:50:15 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 23:50:14 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 1 Jul 2026 23:50:14 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.36) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 1 Jul 2026 23:50:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/AN4kpAjdMxEt+w4e7SjYlRj7KPKrQn5Qmz2jp4yOSQBR3O4DU0V7k9W4oWqf7jTQgwZD6916R694b24jNx3gjYLO560SrfSWlx2Xh3W9FvIClf5hejGxqdDOdoHX2wUE4SVTRMJUh7sB02WnQPC2q/PoAb8EA+42nngvqkqOoByklwgfqoZzGniiWZTtslm4mEX0q1/8aagLtqyAB6AQDh2CSffCSqL6k0fwk14aqMP7T6XbcfmfydpL010mUdZUpAoq563ZB6UWfrK88ZOW1o9bzu5IYu8+5x1czuwY8+Qhs2EIvQDnNFT3VerK867sJ6pKcRjXV1UruLWU9Osg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16KR+wL/KGPx3UioA2yTFQCGzmh6NyUJTiE7xzRxEKk=;
 b=lcvyMnsTFEkoiQDPDqSGv9yjLOwFPxm1tLn2SK34ik9HzjqfCVicqpkXt+iz7V4L2ZFhHME+coQPWmPK1LchHvMKswuejKeQXOtUfwlw3bDb5APN6s7F4tsK0sTyvItdL/BIxng0moVPNHq2uATDoP35hT4E3nJMsXQPWkqwO+1msaPRvydj0m7tnguQymQuzVB+Yduaq+c3Ab07h3G/IXASWv3GgSEHW9qGtuaIE2blW26m6NtdW/+HEeMS5v6q8h7DsZsEo3QZqMB1YUPAGosU5MWQzk2WRyb/riMYuhv1N3K81HL9qd/teejRenM+6pk21gDWbTJd2J09PvkBXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by DS7PR11MB5967.namprd11.prod.outlook.com (2603:10b6:8:72::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 06:50:10 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.008; Thu, 2 Jul 2026
 06:50:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
CC: Mika Westerberg <mika.westerberg@linux.intel.com>, Ashok Raj
	<ashok.raj@intel.com>, Chris Wright <chrisw@sous-sol.org>, Jesse Barnes
	<jbarnes@virtuousgeek.org>, "Mallick, Asit K" <asit.k.mallick@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 2/9] iommu/vt-d: Force requesting ACS when tboot is
 enabled
Thread-Topic: [PATCH v2 2/9] iommu/vt-d: Force requesting ACS when tboot is
 enabled
Thread-Index: AQHdCehB95a1zc2IIU++hbh0rg42UrZZyFPQ
Date: Thu, 2 Jul 2026 06:50:09 +0000
Message-ID: <CO1PR11MB4835A6A2C3EA4A9D3985E9738CF52@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260702061216.388743-1-kevin.tian@intel.com>
 <20260702061216.388743-3-kevin.tian@intel.com>
In-Reply-To: <20260702061216.388743-3-kevin.tian@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|DS7PR11MB5967:EE_
x-ms-office365-filtering-correlation-id: 03bff668-4b3e-4d74-f89d-08ded80628cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|38070700021|56012099006|11063799006|4143699003|22082099003;
x-microsoft-antispam-message-info: 089y1zj7hbgA6DKR6/srd+coKx8OQCV5pbkSaxO8AGXswZmQt6/RyWThdaKKIXE8oDMhXcw5Md2XGRFpDx1v7bTtLX9m9PPjDGo3VlkVgxrsW6pnl3cTq3j4ZzHsgGUjJJneWUWk1rKTe+WY8zRa3A5vdgLeFP8V+v26G1B+LaaEW0z0EMDMS2OLtAcPu6uw65yvn96tQU7XyCBV8Lgzpmbqyy5w8lL/FXKBebj6U0njOZrc+11oQRIGUrwZ04QKFtmqPqpa2whMyQGSC8UbanYqb7hxPEemKgLuNPouZ2MeA5LcEpFQ59tQ+Cbz/yNsF8k/pWngzQRiZ3BG3BYXDNuSTIyFw/UJPOfTZ6GhRuo+TjHDVEyv3Pr2zj/2/PHtBlay40OZBxkQkYei9Zxt8OQkV11NCnjS83gPUyAi8QHMszAP5qrYO2z56VXLFzJIvyPDN5KxGPle8IMt6ddnAWElkXJRnbV6yIAMXGdPAz9S5ghCnlsCI6IqhTQWb2YqH1ZpnPSv0/FwYmVcwGwlRU3EmdUrnOg17aO7WyYxh7gI7lJDzEkCprKJ+P2XNa4+z3fd68EHNeZEFHLfIsQsEmzGFKAb3WizaTct4SnWATVeq6mdas6VxTPRDOVERpWySqiDAoz7393Fmw6nVMVbWnMNeMTUVO2kA+yE+KYGYj4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(38070700021)(56012099006)(11063799006)(4143699003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EGO1dM5sjmycZuQurVBQwIS/LjmRc6aZIXTEJpehR6d0lrR6ehXalEzHOlg2?=
 =?us-ascii?Q?hpPFcfOLxqXXz5zPOB6cs6jt+rYsWB/n6g6/YuX28iQdVrwMYFXeE8NIznvz?=
 =?us-ascii?Q?X9JPMn5HBydWpuwj7p9cQ34pfi8q+6wFdaGtlUFtsaYtL9INKTQIWRtf8KEM?=
 =?us-ascii?Q?vWhiTrzEh6bnIS4qmviX5AlaX914p2E0iqlgivVW1HQLdYjURMtVx+LLFDTc?=
 =?us-ascii?Q?Y2eDpggnqtS1ny1ScB3yauFEa4Ay6MKYAQcdznF/Y/cJVv7YCohw2LsixyH3?=
 =?us-ascii?Q?GPRclZI5ZvIheS5OdJ/VX8FN1UEYwjACBSP6yEx5ceTaLDpt249VbLZo2Id8?=
 =?us-ascii?Q?iGKG4ekv/oHBq9EUAvQU9+iCuCibQOPfuWL99JK1UaOyZOnifcGxOYt40TjJ?=
 =?us-ascii?Q?GXdAgnZ7I7zX8DBDfIc3zSp8kNYhORVDv6eW/F70wybskLg+Ru4RK7yvl+Ar?=
 =?us-ascii?Q?YQtwYHtSoM5B2MJkxLYO1V9y5PJrYyv5plhjTD5gci/45aDurlWZUk8WYux2?=
 =?us-ascii?Q?EXRzq1te8BW2vcOfitiCIDo3WhJ9KbXXn742/SAIz0Lx7LrvUi2C0ht9S8xT?=
 =?us-ascii?Q?dYKMdvzKaQ/NLq+bAocFAgydfIpRYE7/+iRQMIz9+S+SQN6vNO4OpwYJvd6Z?=
 =?us-ascii?Q?8WgouMXwMK7iWviAQ9LnCOAOxQocnMEQ8Ams0IrIevIpmYXySTwzVIAi1sn9?=
 =?us-ascii?Q?zRUax98BYcAOlQbAmDkgl0usdc2QCqgFL+vvNqv6NKchF/CrEvnCPFQt7ieD?=
 =?us-ascii?Q?jQn/ihPRH2TMHI7RXuw1/QwSx9wK227WhuF0sNKqyHQgx0bUdjIMjyaOtOI/?=
 =?us-ascii?Q?dzszLOo+KYhUfhHkyPkt0gwAY0vjWWgzoREUV5I3XvkcXwvGGKcAdfThH3zg?=
 =?us-ascii?Q?xVXNDmZv9ef86PD+uqujokF3CoprSs+LpydAulPFYKMWw2En9Q1wSYImyEZT?=
 =?us-ascii?Q?XYwyz9YE1fxjr/iLk2yS0gI9FpiA/Q5XKHd+zbSkvjBfw6FIR1v9oTzCJ3AI?=
 =?us-ascii?Q?wfjZM4Q7GnOOloVPi2nGWx5FSWzYjjcgS3lXEjeWLNL/CL9GVe92b0WRiuYz?=
 =?us-ascii?Q?3xsCpabH6S6wR4g7gA9i5/29dvTHd7vDDVz3qJLFPuBvCnmbmVkry7gUVZKM?=
 =?us-ascii?Q?Ec13SRm+tZRlXLX+89gdz348lCzmn/E2K5GiSGCPJusUVsbafYgCMxfEp0k/?=
 =?us-ascii?Q?NFZ43n4ss4kGK4kd8GQftaGGbmBftrdr0pUsBEu4GW7UsPI64JwMinwctGmN?=
 =?us-ascii?Q?fqZ6Z7G9moDYqIKakUFPzZ0WIxOIwdWdNZlv41987eSi5/mndolYiPsqugMw?=
 =?us-ascii?Q?cGLux8KxC0ZmbcZV9DhJj/uqOslHup7jS5WDIakoNsptRgwpdJVyg3IwCA0g?=
 =?us-ascii?Q?HsJprlj9opOp12mutWP8cIzvF0Son5VlUN8tLUOgw8vjHKSnKF/sAxK+9KgV?=
 =?us-ascii?Q?Be4QrPvxBNDn7YOACnS85+wgxzrzJ7N58mpf1/GGW2sCLKLn72N1vlimIpEj?=
 =?us-ascii?Q?1H+rereJIXQAfFNfhus0qjlFUxzlS+kpI/A+6Bzbku8kH5JxTTjmYQzPSULZ?=
 =?us-ascii?Q?ux3YCWfFn2B2IPX4YO5PyzSPvBLmNKwqWGdCwE4U9L63SrNqYH+XBqxRQcYs?=
 =?us-ascii?Q?XRI02L8PxF0sCkS9lJVE/U+DXjEKiy1c4S7jvYUXc8rzIsKBQLkTDo6CMAM+?=
 =?us-ascii?Q?IZpOBEbv3FZIY7N2F6tCymx3SEoFFUjx940/SAWP3tnmTbCG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RNvWM9FZQZx1kpHd/4r3uOnPrCzFnp2fpguD6mxh00V8YguhIYM+zuVx3YkMUjrtoYGqheVmEwjoktvPl1XoaDxrU9hH+t0tQZMpbF+sVLXmwhJcng6dXmNcUjJUfGXwJORHb125TycBcpy2+B5Ga6qZY3jEp1l6IG329wD0vFWbZXaIpyLtK5qwwi9/5g5X2qqll/9gEknxgkAeu8QvAxrmPImTKI/Dqlwx8FQWrOXOdergqT+0wQ3i4NazH/yGeborXSlGcvWKTlfFWvN7Iw6S32o0Ba8RL9sHa65JA3/T9hRDToBkJ+p2GYbGTewmsULWDuj9Z3P3spuJY2huNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03bff668-4b3e-4d74-f89d-08ded80628cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2026 06:50:09.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NW41+RBEvZX6IFuv3u5O1bH9cObbjjWn8t7T5tMqZ4tUxPq1SBJJzPkZk5AkAI185ZM+XJSW5ehPmu2szXkhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5967
X-OriginatorOrg: intel.com

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Thursday, July 2, 2026 2:12 PM
>=20
> +static bool dmar_required(void)
> +{
> +	/* tboot supersedes any user/platform opt */
> +	if (!intel_iommu_tboot_noforce && tboot_enabled())
> +		return true;
> +
> +	if (!no_iommu && (!dmar_disabled || dmar_platform_optin()))
> +		return true;
> +
> +	return false;
> +}
> +

Sashiko [1] questions that parse_args() is called after detect_intel_iommu(=
)
so above check of intel_iommu_tboot_noforce is always false.

But actually parse_args() is called in start_kernel() way earlier:

	parse_early_param();
	parse_args("Booting kernel", ...); // where __setup() is parsed
	...
	mm_core_init();
		-> detect_intel_iommu() -> dmar_required()

so this comment is invalid.

[1] https://sashiko.dev/#/patchset/20260702061216.388743-1-kevin.tian%40int=
el.com
