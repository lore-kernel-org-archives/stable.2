Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A8D361DDC;
	Mon, 13 Jul 2026 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923105; cv=fail; b=jmk70vvzEycaZKqKMBlbHG9ICqDvqg5dl83LwE6i0+6wlHfhis2xOiE+47s41oGkmxfCeTmoIP8scWyxrU1pD1Nd/3Yl7oH99nLM64/ACVO5KlFwTNffsQ1oU3ovOt9E4duUyjPdaO1VJx0Mwgec71MObOMLVO66VEH3qYZQxVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923105; c=relaxed/simple;
	bh=ITNnixMbKV18kHsIT4Wxc1w/mkqD2amZFbht41uvhvo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Cu3mgCa/rYhOc4ocNmoXN5roEGBCSrSJhg9sAwXXj0HtA0a6pHGezrrB9tS+RAhPHf96laVjLUdsKtgWtDc51aC1Q6wBIzY7+4UUW5ass8VmI3+r4jaezk7uIBWZJ/WmH5DJ4h4uFiQJG9iAiTrYof+9EAqGrX/z76qhF3CTo7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OrQMdFxm; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OrQMdFxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783923103; x=1815459103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ITNnixMbKV18kHsIT4Wxc1w/mkqD2amZFbht41uvhvo=;
  b=OrQMdFxmHmjyOWHcp+zg0GIXjKTuOXZG95An5meI53WAHF8k1h3IcJtq
   QYp71uIZ2xz963co/gGWVXF6O9mgtj8r+rHPbESQ+Pt+UNi201Q3OfRLk
   mKx+zGMJIQ2IcMx6uLhPhxX9wpZevKGCh4IIDFtYFU21yU+1l2HPoXl5Z
   Ci+gNsQY79bdwIAuWTZu2SytcYR3wEWGnsTp1pXXxS8vCJQQGcPXB3vE3
   gntSxluwDCQ47hqOnbjr2UNTPBVUmNQRiy+0h8Wmo70etvwOZZS48Eirj
   S6YhH1mDRTQNAYOgAJPGkxmYVWaL9jdlJ6+MlXah7CcwSfVCOt0oUu2Hs
   g==;
X-CSE-ConnectionGUID: 09cJhLGuQwCYjqeXocRHUA==
X-CSE-MsgGUID: AThVy/y3SEqa1J++fa1naA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84641213"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84641213"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:11:43 -0700
X-CSE-ConnectionGUID: 1kXlAdmHQxGKcwz6Gr5yKQ==
X-CSE-MsgGUID: bMP0odgNT/edsUjXOZs2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278719274"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:11:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:11:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 23:11:42 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.14) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:11:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKw9in1xN/hwcyoXzsNZK8N3hpuyiW0j5m5rZZtrOcjv2sbAiYQbW1STrHS4HrlCEDxjhJPt2ICjBu5OLSyBzEbLJjPnT79v0JN+3iC2FkdAibDMcztSBjp7orpGs29jxK7HsUqUELC++f7nZDG4VluyjyZaMU1965OvkQtG4xqssrNrcGVRzwYgerM7oIgXt1lQc1jRyg0+kcSROCJ07iFtIHOGyFgN86VWJp3APWQDY7Fk79tTn8BZuRI/jo+yl5TkTL20m4VtAX2eH7Ptc4bZwmMGOHNXR0JISesxqjI+OgVUOq+XWN4wwcxPlIDkZCLn2m0WJRaCTnRhWRw0Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3duEC4TMODxh+v1qv9+dL4ytGNQfwbpFAOYbv+epRg=;
 b=mO+x2Lq+xG+JYGNNEu6rPxPWhnxuXb4Orh8vtogLW/SYgEQpBUzOfg7luRYwFpOP4nWmFJFJxw5BobbE5O0mJbmDHj5qZd7rUrOnQ8tpFYQZhnRuJozJ+Yz/5DdoALbVdP0gd3VAayqAYmd8VahRRT4QhcHcmvVFrPlht/xaIff2ETD11OgFuVJbD0kjxZslss+/vK6bv4a2oh07zQ/7C4pZROfTRb1cVM6g2sJyIz6AUvxBxwFh3lTPog50pIoopN2kckSB6eucBXKbywLyl0tmjtWD4iIS44bqKVIvLfR4pwK1C428tKJ18Jcc596Zklu94zqXWoVULla/kz4aIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB8920.namprd11.prod.outlook.com (2603:10b6:208:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:11:40 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.016; Mon, 13 Jul 2026
 06:11:40 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "jgg@ziepe.ca" <jgg@ziepe.ca>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>
Subject: RE: [PATCH] iommufd: Fix wrong hwpt passed to
 iommufd_auto_response_faults on replace
Thread-Topic: [PATCH] iommufd: Fix wrong hwpt passed to
 iommufd_auto_response_faults on replace
Thread-Index: AQHdEGgIsKOKeatU/UutFf8iR0Hz2rZq+/Jg
Date: Mon, 13 Jul 2026 06:11:40 +0000
Message-ID: <CO1PR11MB4835B407E797904D977DD5908CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB8920:EE_
x-ms-office365-filtering-correlation-id: 7822c6e5-60d0-450f-f274-08dee0a59af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|5023799004|38070700021|56012099006;
x-microsoft-antispam-message-info: LDPgvAcuPjlc535/4jR3PsHvnxVahOvXC2mBYpfkZV0Mr8kaQnXjChGmV3L8G0EyLM7xspthBnB5YWXsyVM6fucuBKNOMC86qoKbwljlFMi3sAS2SSUQrChpoRVO7aIlD+M8DoLWpFLpYXSk7ze1zFhQqpemNJ0nED/lzfhpHwDkpoXD6k4hwFeUpZiC29pD7grc/TJX8DmSEaPyvShrgQAZzIsDU/RpqWKPJpItxbVCb7zWFy6Ish6Jab1XDKwtEZS8PxN5cSsV4gXKQIYjg0jGH0VrQf4RoPGEZOb3v6Kh012eqTwHWqF7VVZN5ttwrWpaARzKm8bNq4DjjgdKFtFXR1kh5tGnbz2DZsofXM7BQnYLuHiDXfsmfFdQ639kMSBlUsbiRtahs4Fa73RFTjT9UJcDuJK5S0zVsDylI53bvtN20EzKFKSi1Vm+c9ikALwAiZQK1fhQVRW6jvSSVIlqFwEvJa0K/vdxnKXWgzh/sCXnfj4oYQgHbQWQDwO5Gn6paz/BJ9C+BFU+pCTrhpTNzmJwruHH4wgr6Tm6xt7wnrhnyFuMkgNDXd4+XsAZUE61BWFPCc4W8RPifOIwe0QypD4BV3BDsOQDiPXAN2HaCCfsdXpEh8Q0EERTu9EkSebE9Pi0TykXhfxvG94PY0qu2sQziUlkicQaHEkWa1rAwbscH5cz5r/HI698oJYIA22MQ5OWuVQTIjlhpPYJmlM3NYH9DGA0iHT9PSDJ184=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(5023799004)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GsJ9Xb07j3wPE6V90FvTM0c2p4jdxT8jKReRYmsV2YfMJ8DoLE8Bk3U4PenZ?=
 =?us-ascii?Q?b4TDxOUjHPHiYPIGiLF1l6rm6W7LT4N2IOhwmtdPchv7scHFBTbw2mC9GRqa?=
 =?us-ascii?Q?xDmOHY1CipxqbT9wdH52csC3Ea4UadISdry356eur2pGUbmLfeq+lxx7COo9?=
 =?us-ascii?Q?9IbeLfWEEamnQCUpctVd46RfWopeviHKAYtnPmQYGm5iXF83ouUCwaPrUi9Y?=
 =?us-ascii?Q?zPiqMzi6A/EvKZosQAlcrEVlGjgZKc6wvykVqzHg+Pns6oNkMgxWy6budjnG?=
 =?us-ascii?Q?NYTXzWne1jvRuynJhnSpDEpYXKeZK3ZRJzEVcy3BXGqSgNDU/a2qzjjEGzgG?=
 =?us-ascii?Q?A7VGMjnywQHjI0Vl5k1HgT3RmrG98PMjlNYuJVjHdYeufvaUN2noOPKDOVIs?=
 =?us-ascii?Q?r88YyCX8G8bhej9xNzdpS7v4Fh53fkapfwdHX1wHoevJ9OTbFqQb4OSoRge1?=
 =?us-ascii?Q?aNyDqPuuHxZA7r13BLrzsmSV8xOI+XX0lRWvhqaTYaS3LnwiJH0sQhepQn8S?=
 =?us-ascii?Q?SjhYBPWIYEWzG3KywQcOnCQUKmwLtpFLLqUzHq9D7vNMzBPkxVSdHO2SS5jY?=
 =?us-ascii?Q?2fZhCXuPYJLEeflsexf0hXymgUvqbQmk3xjRA2mKhPaZ7WiCQkyt47MWwnIX?=
 =?us-ascii?Q?X2/Uv6caMaBUxataRGQe2QhaPEn9memA7CgTCt8nBiH/oyLk5SOKSxBFkk8h?=
 =?us-ascii?Q?a689idzdV714T5Iw/XBZryVQ3U/vfjwn5x4hIazx1v2c5+hRYpVKD/++Y4gY?=
 =?us-ascii?Q?jK+DETquGARNUyW4qvgWgLST88GfRbx/d9CVvJs1O2cK/IB94yR1TjruY2rb?=
 =?us-ascii?Q?FhhUfRUspbGNupiP4753JvmvijPc8D8gW4Hn1Ehr/H1KYS9KBtV+hrbdN9g2?=
 =?us-ascii?Q?SE5BwqfeCiir/Gr9h8bjeRPvxkOU/+C+5zVbmY4wItJEq+rpMkDZyfPVBUIT?=
 =?us-ascii?Q?d9IcaRrCeEjJmDt/KtIkgimalpEGqj39Ta5iJbB4lYyeRE90oeulgo8JaByd?=
 =?us-ascii?Q?O2B1B8Z+Enllu4u2po9yFKLSjM/eCcOUi9rfQt+UDRYzSJssJU7oU9vyu6IC?=
 =?us-ascii?Q?IzeXeyhAkAZZsrta6d5ROMEFxb5gHR9ImxhRN6agJlMhAbqvzwwEoyuDyM3W?=
 =?us-ascii?Q?l8L21/q7dlHbBgBbGpW+5iC5wqozAf9j0cY3owQehf1YVJwT5fyPz5ROiJhU?=
 =?us-ascii?Q?4L2x1N39h+piomVVWX53BSq4YawdjgRvd0uIKUfA3rEbnHGdDFmEFB6w4RXd?=
 =?us-ascii?Q?ZArE9eCTtrUFKfR6tiHiHAJZDkPVOTUlPO5VFwShHVl810+OC4GvtZ0YxkDE?=
 =?us-ascii?Q?wpTZLp6ZgsQ75mgwPBVfy6moXDXUlp7C0c2XMle5gFZateGyJ6x2+eOceTrJ?=
 =?us-ascii?Q?QDKFg29MSxFEl2ZOh82fwKrCCmLUFwksQ/ElC7dndgaQMKhwomftetH8iFtz?=
 =?us-ascii?Q?0UD7MY3uxHA6tLOWFjcb5EAZx+8WnNTNK4po2TsyNVWEbaJYWZuuXtmvd5Va?=
 =?us-ascii?Q?dKky0rkIqdnOEBkrAzTIsPnfSGZ9EOPDIADhTKCfEnguAIedq290JUe2+NJ1?=
 =?us-ascii?Q?SXiVYTizaNX1I+R5nBduvXMZ/JdQus9rB20jqEOBwYgVYZumfAZvo/W50/PJ?=
 =?us-ascii?Q?ZHmj8Mx8ycP2KKHcKZEDo+5UFm0ituOIQmRidJiGYlFobTKR+1X9gFeGJk7H?=
 =?us-ascii?Q?LRF08Ozj6CIU22YDd0Ug6bt5MgYi9+zifrCI/xEDwwt0wxIZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b4Hb6VhH1K1T3JyDbI+yV9/xlAFp3rHYP1O5cI6eF2QrXAOC0jj+Hj9wNhICoGKZUVhIYCkWZjnU3WF2JcGu2t8ciBFaNgQMUO/X49GX1uRtT12uLbmTcZ9agFxCaC34cfClVGZRHz/b2Q3TwqxPi62gMtD4bRuW4++l1skMVQ1+4cuVvSpCgipBehe0zDwYKwsKWVhHz7krs1AgX8rHKPUSmuJK7a+KjBSUmp6eDXNJDeny4IvscXGPo0PUS0oWBWevR2HZo7CB+azqmEKgcxY+0FWORXxhwoDawSbNSC9IdLww7m0ulJI09n2xniVtM+/AOO59BkXi2wLsd2zCJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7822c6e5-60d0-450f-f274-08dee0a59af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:11:40.6817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hro742YAv5hZWfFJhTxkndflEzQXsPXFvlE/tCXk6Yly5ws6hNvvjXmmCaay0LtWcTi3qT/7ikZSd6WOAv9P2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com

> From: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Sent: Friday, July 10, 2026 8:30 PM
>
> iommufd_hwpt_replace_device() calls:
>=20
> 	iommufd_auto_response_faults(hwpt, old_handle);
>=20
> passing the *new* hwpt together with the handle of
> the device's *old* domain. This should be a parameter mismatch:
>=20
> 1. Semantically, iommufd_auto_response_faults(x, handle) scans
>    x->fault's deliver list and response xarray for groups matching
>    "handle". A group is queued under the hwpt that was attached at
>    fault-delivery time. old_handle is fetched *before* the domain switch,
>    so its group lives on old->fault, not on the new hwpt->fault.
>=20
> 2. Historically, the first argument was "old". The routine was
>    introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
>    attach/detach/replace") as __fault_domain_replace_dev() in
>    fault.c, correctly calling iommufd_auto_response_faults(old, curr).
>    Commit fb21b1568ada ("iommufd: Make attach_handle generic than
>    fault specific") moved this into iommufd_hwpt_replace_device() in
>    device.c and swapped it to "hwpt". This should be a refactor regressio=
n,
>    not an intentional change.
>=20
> Fix this by passing "old" instead.
>=20
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

ditto not required.

> Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault
> specific")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
