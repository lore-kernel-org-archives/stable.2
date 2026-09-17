Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD2C4BD376;
	Thu, 17 Sep 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644540; cv=fail; b=jPdVrLBdYyQHFN0Fua0hu7e5rna5SL6MsDXQ8VaEcsQxy3OtynDp+BOWpGzchIMvazr538AaXKX2KfTobeuWhzwFvOMoqzLH9VHm52VwSjT6tsOey07N/Krh54XemOncaTJQFFIhp4y7HCVB8ARg/j2hEzJre4ilSt2D52G7z6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644540; c=relaxed/simple;
	bh=3mGw6ORD/m5v9Fl5nCquq9EF2V7Wd4apmFwBxkqVy4g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eN714KE/PmQgTaSjfdRDACxEgOzBYPZYEvLkiWGdCoaend6+OrdRLfD0L3/VneMJE6mEO8B1mENZMRsreYeglAx/uxjgNVubImEQ+F/koHEFLtU9la0h8s49OhhcAFzmsvM1H2ZuharNv51/+GW0eRXotKdGgE9+RyRqsYvWjtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEjRGQ6Z; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEjRGQ6Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789644538; x=1821180538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3mGw6ORD/m5v9Fl5nCquq9EF2V7Wd4apmFwBxkqVy4g=;
  b=mEjRGQ6ZTA844iJB3aHSSVm1rbjpbQVo+Py18dEIVkyM1r7RpPb9MjgM
   NwuDdC7K6Uh0Go5B7a2eUSOcK28l/GnUDi2SbyFLMxlnpi1m36ldSlZQe
   X7qk5t8Zj4KO1FNkKh8iWQzYgnTVJ0Xz6JBMMF9tzoL91NCItomS0ciJJ
   86CuZHZyWD9E6pG8DFnb1rfh5xFu5OGoaRLFpOtdDsI3cBnzIui2N+wM9
   8ZYLYXwlxpCOhuyzo1Bh9rm3fnWiREl+lJWi/+EMUDIvVMhjvCKQSMo1y
   H9aWJfhebHI/qBh4ipcLHtCVGg9s/Rv01y3GY6DqKAFDWcOuSJyGflG9g
   Q==;
X-CSE-ConnectionGUID: Lm029uz6TWqxyVwATiKFuw==
X-CSE-MsgGUID: vXLTXPnTTymwGZ9GMKWVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="100720995"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="100720995"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 04:28:56 -0700
X-CSE-ConnectionGUID: RqUIFNHMQ52Tx8NRQ8iZIg==
X-CSE-MsgGUID: GTYNGV1PTzq5oo4iQbs7bQ==
X-ExtLoop1: 1
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 04:28:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:28:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 04:28:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.0) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 04:28:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itkXBsi6ORnRJRXxga6yVZT957xJjMpcigwjSEOxPF3txrcoHEzhW8xPwaEbnmKmi+cDyem6RiVMETzoMCXw6YyvbTdmZUYcYEkY6t1K0Nj43H39E3znri1gZYQtUS/b2bGjdDyZbPiDfBxLRKYolRadKUF+4O6dYIW7/A3FhrImV3V7y3kopXHAmh35j+GkBYdRiyeMgC4dgpOKAdB2fwhdbo0XuFfm6iVsHtKDjZG1MekBMEFcMn/iCa3TZT/LinO8Qq0rw6dU2oiO69LOn0A2zd2XW86mWA13Y7ecNFW8iXdaSQNvvSLymLtyICBrX3PcaOiICKXzOJHkG/83qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6orhvdTQBZFdYhmjlFwSMZHxwlGrrvxY/OXgkxzLiIY=;
 b=XOSSc2GzDmbXN87D6hVa7PjaPz/Q1n1qX7LWm7PoR2oy9YN4dyx8eyH8WgJQ9q3uZ3fkBTEISVFs9j3Hgf7tdEDPauesjo0pfGfdEQ89z5Uz3yZtU4QCyA/JFN93upuBRmMLe71dkbIOH3zoIG3TeoGOLhpAY2ALsCFVj1/Gve2YAwMeD6f5xhjWnHerTMLEja1UPrutys4aSVOl3a4PxovN0cgoZ7Xk1q3FZhqNiqq0WYyxkxBsqKrDsTs95jA48SLxTDuHoGJ5eNAuI2NYu5v2+ynHAsOclJ6/pzdy/dHA56IWKgBHr+pfkxB+i98sMJcZhkX2hBBunV6Dr3fMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7654.namprd11.prod.outlook.com (2603:10b6:806:305::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 11:28:51 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 11:28:50 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"kalyan.kodamagula@intel.com" <kalyan.kodamagula@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Swiatkowski, Michal"
	<michal.swiatkowski@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "Kitszel,
 Przemyslaw" <przemyslaw.kitszel@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Topic: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
Thread-Index: AQHdRpZw9C9AJgvGek6CTp3KJZif47bSoiUA
Date: Thu, 17 Sep 2026 11:28:50 +0000
Message-ID: <IA3PR11MB898619C38AC2792034B229C8E5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260917111114.2148482-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917111114.2148482-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7654:EE_
x-ms-office365-filtering-correlation-id: a9e70967-5bdf-479d-1d27-08df14aed919
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10067099003|22082099003|18002099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 0F+qrKvDtP4AGoPGCDX0PswDtOKYtFA+qhAgfY4CUyOW+hwCse3KtUV3A/HeMCm4ko9DDLmex9jQlVYEGPMMyuxbD1rpZ40HagZI6q90vjIGg+oDJs2k5TriEpIdC8xUXrJ9Z2M0quMaBbuoEjDOiW5VF2U0HZiDck5GRbIfUhIDnLW64GuZmK10rn+jl94KMozkA3hA34W+Rx/OUtkpJAYrvUclStEkIUFS+43jA4XVfMpS00UCvvVqTfGyGvPMr3pS2FBQ9Z9EqPugkaCDK2dKeQq9ddgfj3SMu5d276XcjY71Nl5VoivrzBsCyoWwLUeqInt95rcr4Bz5OZb3F2y/1Ua3EeiR8Rn3l7UObxVh5i3jq8icSFtd9agMQciNB6swXxiOHklcggpafGG7uEsOEoldWZdSaLCuYSW9VrGep+JBdsODi3dCIfLVEnXoR+qbcXfln9rQZ1LhJKQt0UCCdBFEfnJW5VX1rm4zYuReb2ZJnywDukI2SVPihn61Ddgopchxaq+GQvWktnmCDf87ESFPMD8nwfYzDX8KTKItkMvpV5J7ClypQ0FBHyyVwvqQ8QlOc9jJvNZXnbv/mt5WgRKsqtN5+HGf82AQ51Miacrz4zTi/r5mZ2CxwZe1ph8kJoUyWiGLqiRWcCkagSTWSLtVXg5R2inQYdZ0LzGrp4cv1g4TVexnafae87an7b5yxWsZpK0XdQICCQYVnbxGzldzj4Qyn5zaUTa0Wg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tMgeHSim6eLTdJKxUmv1ZtFpkHKCDqTvQ8KK710EEI6eTe1W9quAI+gDOcRg?=
 =?us-ascii?Q?/+e57/Ql234bIMsQ6IuNVsk6oF+G9yn1xnaLsrD0jcsUbQdpasYoArULNLFv?=
 =?us-ascii?Q?vK4FmwL11sHx/e+jQFTk8dexRo06WOoQg0QjBzcNid8blAOssquRKKcgrboh?=
 =?us-ascii?Q?7cE6FIQp0IfswZifFgGv0W6aHN367uu0m/dJjLA9pOBFGHYqsCQyyHeGLld/?=
 =?us-ascii?Q?fWa4y3nS9RpaYU++wj6G290nDBH+r8igRks5EfjM0qnJVKYV3DEsWHInZ5sM?=
 =?us-ascii?Q?GiZ6KkVUN+JHMtNcEV36wuWJ2OFQsdmw5ZtvAMHJ7SXkxgnTc+h7EYRkY7j7?=
 =?us-ascii?Q?IQI6q/TKM1qp3ZO1roiuojMFS1fjHzpSij2YE7DUkyUOeppiZJfqys07fdy+?=
 =?us-ascii?Q?DQks1vNJiOJQUisVTQtf7YGh0rVvxODPOrtGYovp6Ucj2ZSXQuRkpfKdW63j?=
 =?us-ascii?Q?ftZEMJZ1lrdpnW/UuQ/qbIKvBUbBKUzMvcEBxzLcahOFNuA7fIwJYpwOpQiT?=
 =?us-ascii?Q?PWKXZ+x2VIbh+Z6ovZ0PBgHwSdeLEVzYrUzSMhi+waYOyjtJifT0tqjaLT2e?=
 =?us-ascii?Q?qEagyXEcv+srzJWXgx38yDe/iQmMThmchQKD6HjBpmYOhMCUPsJWf4qMHc1m?=
 =?us-ascii?Q?nePg42fGYBqo2e53eChNep6rRX6uTJQ+Zs/TwU0pEfOayyVEybOqIq4AxrUL?=
 =?us-ascii?Q?oLljsoTtVlMfyWQ0wBT32GC4QSqXS2JA/UuE+3eHoUP9v0dEnyRzLZKQdaXR?=
 =?us-ascii?Q?oBvgdyLkCkw4prQrcPh5c9I0bPkcoouVNbUEhAxQBpRmafzA+e/1hkvNk6hi?=
 =?us-ascii?Q?U5YTaA0nbZjGUGfKPaSu6nkHWShV9Kkv2/JwyNLiB53aZ+K6XSF7G4CJ5v8V?=
 =?us-ascii?Q?1Z9tFM74kU33XvoSrH5a/Eq5LmjPF3jCl+sPE27FqnPcNCKSFE52Lcm9/shL?=
 =?us-ascii?Q?BZn0CAHJB0u2PmbwvKKjazHCRvaYkz9t1OMvKQjAmncbXg8jBwqBLyuktPeW?=
 =?us-ascii?Q?q1dht5QkW9Qgul+uevxqeEmqanDhzKvOLiYsLdl/bhr66XJYfF8zbxgEJDKW?=
 =?us-ascii?Q?UW7XsKnv5XZs9gFA5jdcbzMW3WIJtDipVxd/BsIkMkVgdDr4weOiOIaS1d8V?=
 =?us-ascii?Q?Gb4HwTL0M6/awWwg8XHR4McgrliGg52jINYgKZEWJidb52X09MbRcb8AXIes?=
 =?us-ascii?Q?w1iCy4f2vv1W3v9g7M7+u4QRnO34jgvjvCQkL6cuKHyUZVynHQbAhee5JU24?=
 =?us-ascii?Q?f+oPdpCWBrlwO1qXmwNdtUgyTHhOznNDF/17HysXKiNeLvCtFdhjk5jH77bK?=
 =?us-ascii?Q?xulCGsE/+M6n63yuIuq3rCWqNN88Gu1Uvs3oFgJdP+xcMsspipghZqHyEayb?=
 =?us-ascii?Q?BjArBWDUoXkZlbecSQiv97mNARiFUw4mgSa7B0MjOtgKhpUON6pReZlojfrj?=
 =?us-ascii?Q?BiM7FM3IiuJV3yi/7WKt0O9H1Iv/t/ADzsTEziYb9IyxDB4PH7/Zo8pb9bZF?=
 =?us-ascii?Q?lz2aD5osZGa62OOhQzruiy1OhyyLEEVnH7IHrVJMb+PL4ZCyDYw1q0gOmnne?=
 =?us-ascii?Q?JVtsKcLhS+1eSqnZhJTbP1Y7t5IWkLh4P7TE5RoZNykqypo/M7IXa2lfLykV?=
 =?us-ascii?Q?Nbnl2Dm5Vj34QUUxuwiPQzh3Ji/bHW2pDgLJGcaGP2dbfN5abkO3h+cn2fbW?=
 =?us-ascii?Q?1DURijb4T1+OQrdVzg90rC2KUAeN4aoJbeFXLXOt99hCdyGlf9yQzhUx9tag?=
 =?us-ascii?Q?VeHZILwkwY8CrhgZzzgi2WBlIo4iP8M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 3nU27Q2KXplEgx9eAoBTC7m8sxU0b4ln4bMv8oKMTnq3wvFGwSQc6p9dx2s/AafgUi3wzBmagUtmwT9pQj0kQmhHuCF7XCz8I9o2G+loOrdbvglutRBe/BLaYfLcVoZsX0vHJ0vZHrEZKU0wHTbX44wtubg3aYFH48W1C8t+VEZULy4HmzeOhgjFIC0ae2vRkELYJ2EQa1/E8O/g2a6tI2vkyyBZsb4JYQfnN2/18AvgYIhDYYIYSpVmKJTokLh4yu/KdkbeYSkk85B4rsvv0cE+KqDGs0cta0LKKy22De8sneQcq20Sw8Ta0cZi1YGrmDfhiZ7400nG83qBTdYWYg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e70967-5bdf-479d-1d27-08df14aed919
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 11:28:50.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ROvj0xD0JmFWH7Ohvg2dvYKGB52K7NYrwwjJW0Zqen5RrinXeo92KGZwJlUS1EV32TIIzhnOi9k4zYHVYHBBYGpx3jqoNvW7u2dIY9unUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7654
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Thursday, September 17, 2026 1:11 PM
> To: andrew+netdev@lunn.ch
> Cc: Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> davem@davemloft.net; edumazet@google.com; intel-wired-
> lan@lists.osuosl.org; kalyan.kodamagula@intel.com; kuba@kernel.org;
> linux-kernel@vger.kernel.org; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>; netdev@vger.kernel.org;
> pabeni@redhat.com; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>;
> Wentao Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] ice: fix VF reference leak in ice_set_vf_trust()
>=20
> ice_get_vf_by_id() takes a reference on the VF, which the caller has
> to release with ice_put_vf(). The switchdev mode check now happens
> after the VF is looked up and returns -EOPNOTSUPP without dropping
> that reference, leaking it.
>=20
> Use the existing out_put_vf label instead.
>=20
> Fixes: 83b49e7f63da ("ice: check if VF exists before mode check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 7e00e091756d..202224dba1a3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1384,7 +1384,8 @@ int ice_set_vf_trust(struct net_device *netdev,
> int vf_id, bool trusted)
>=20
>  	if (ice_is_eswitch_mode_switchdev(pf)) {
>  		dev_info(ice_pf_to_dev(pf), "Trusted VF is forbidden in
> switchdev mode\n");
> -		return -EOPNOTSUPP;
> +		ret =3D -EOPNOTSUPP;
> +		goto out_put_vf;
>  	}
>=20
>  	ret =3D ice_check_vf_ready_for_cfg(vf);
> --
> 2.34.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
