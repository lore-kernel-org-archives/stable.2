Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5163E63A2
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791360229; cv=fail; b=OGh75BpLt0LJAJ/lQMH3I90Uh92ghpAirA93lw9RgRArwwPlxZ6EtDbp8U49zDpD+6ym1tpWJ1e3NV0ueG62bNNJzOITqJr+P0gRYopJZ4nL8JYm1S0zl3EUxrt9b4P5WIaZqnikUrQxhr77FwKTlehUV1ddxnWW2MLe0b+mp7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791360229; c=relaxed/simple;
	bh=uBm415RY1E2PH0thbosYQzd74ITkrRyx38t6cQKQYhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZJlddD/ztuvluaDnGR/o7vIdEthLyxiddWdefl5C4yDIZdg47lvU14++hph3BsXpYCyTyG+3JIiKl0TymZOWhLbcZFivvSIga09tTW5Dw8SOZB8+Phd1/9l7o4/nGEB2L29nfkzjsO2RZZJAR8rUeiXCvlXl5KqEurfqce5GeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mlA4n8Z2; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mlA4n8Z2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791360218; x=1822896218;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uBm415RY1E2PH0thbosYQzd74ITkrRyx38t6cQKQYhE=;
  b=mlA4n8Z2Q+goaW4yBV4qt6sMJXE+YEsWs2MLwuO9zI71iN3ADZ9eUEsh
   6bdolM3rWxwByJdAX/cRWBYDXSSxwi2JEPuzJCHuEc/ZIximW7+Ngxjem
   WpGNjBDrdpSBmeW9tKnaAZ4APSTNq4m8VULbq5K7tok9Ek+VHpGqtAGnp
   d1uPZy4kStPiANkcIlZHM5yq6YRbqhORW7gR4dC1LGqgG7AJi2enwbs+f
   oIZ6VuVXlseAvfd0A37If5bdzwc/RsTUYzEL72iymOCdgwS3pvcYtE4Br
   n6Fk2TNNrkC5Op+/0/d/pnswCmsrZ1atpQimlKV81UlAj76Xp5nJLWKeW
   g==;
X-CSE-ConnectionGUID: gHegdEYBRWSMebYDjvO8Aw==
X-CSE-MsgGUID: FeHngb+FTVicqtNni6mxiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="9564"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="9564"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 01:03:37 -0700
X-CSE-ConnectionGUID: qd1JN0x1TvaVmawOEuD7lQ==
X-CSE-MsgGUID: 2LJUc3UXRl+4a7/hOosfcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="281133275"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 01:03:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:03:21 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 7 Oct 2026 01:03:21 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 7 Oct 2026 01:03:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTAmAD0LX4f8l3fIXJpXz/9ShQ7mwGNkdd5qic78DjLdBm4iBJ1b7LAteIrd6F06URg2qzkOMFXwdZI4FnZ3qtMlA/3WekILb3uU1cbHc9ijaTzFRd0IiQW5gowLyRkzi0Vq/cX6eibXbPLyomNMv3CnX3j5fv1NZmKgNbvFH8bE3IbdArcRoS15hZHhaDq6j8UFy3lMS/AUkiwz1xhpWUnR4i4cZC9KmpnwRw9NaQRZdS+Hk8r65NS7z8eyynnXUxImb874T4lVNJZQbRKXGJB985spA41fYa2+7cxM3ePBLQXvz9ycsSHHkYJPasawxUBVWleO03q5i+7ZH8c6yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6XYW9pOX/H/j6NPtqHowIGUo6r2SID5mIJJ7TqA0S0=;
 b=QDAvDe9kv5XPwZRQqkLEOzUgVN/KxUWHytYec2AGt/rpK7zkIa3mgvtd57kxbzaWKhqCE5RiRhEzTc85vJlTTJFkEWeKAj2aeo2GVtqDsMzIxKX8MBuGZdspCwsK2qKcdZ8dirOuaUWNWeQh2HcpoyWoLnNYGTtbigs3nOLohvII0jmykLEn/K+YBDYxtTC3bXkVcTQ3BdT4HDjULaRwgV62m+7Sg9LftyCBG8PbgS1s4aDKYpi20iC4FZUHL9+J8vU4W3tcUbI3obVXcj9hXqNw64I43eYdYzESQarCEpGn/Wht5BMuDWCYGhNw5YeZCd/9FRUe/kfO6ZSpBQ8exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by DS0PR11MB7804.namprd11.prod.outlook.com
 (2603:10b6:8:f3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 08:03:17 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0496.010; Wed, 7 Oct 2026
 08:03:17 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "Murthy, Arun R" <arun.r.murthy@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max
 source width
Thread-Topic: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max
 source width
Thread-Index: AQHdVip/DpHzlzK2Wkm45TK4xOQPzrbxt1Aw
Date: Wed, 7 Oct 2026 08:03:16 +0000
Message-ID: <DS4PPFE901A304F1782FA1CD962D6DDE3BFE3942@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261007070601.3611674-1-arun.r.murthy@intel.com>
In-Reply-To: <20261007070601.3611674-1-arun.r.murthy@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|DS0PR11MB7804:EE_
x-ms-office365-filtering-correlation-id: 1c4cae8f-e556-44cf-5332-08df244971d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|10067099003|3023799007|11063799006|38070700021|56012099006;
x-microsoft-antispam-message-info: pIPj8xVrGz54EqDDdeX6TBTBRoKtUVYbhGNyd51JCDVBrBrZgwa/sggJIcwJuKbGWeM5KDZqgoGARB3MgLrAXPfO0dXC2OJ4EVpAp+GuQlIQaGvGwg4i9dDSSi/xgwMMZXP+2dTvCsPfZUAexQDD1C/nekz1/lqac6JkfEg/hQa6nbWixoTceeRMDBcEtMp3Oye/0fNlfeIgolCFHvmoCQuztrkrWxvV/BODColIBUY3IESInVFv1KOUisEjcwhM7WlOXJKw3YuEAZJSs/YCj18pGH2NcbQm5G/ba1Go21LAf+DYI44mDeR9y0zBhb2GNc3Up53ej7d7kFt3VKRo7phBVPgXg3MOE/hPYk/xSNElHDQRVr3QAy5Rn+VggCtgT4gBPPmL4OaegvzBBLbD05AItIlsSJ3U3nIhBovek8GakercnCwumRcHY7ui0/C7CcD5HT2HWIGbVeOw7zAVA7xhnntYq3clXA2R04LO/2dQm4kq025Y/9/9quR9XfwM9zzG73cL2e1S6PmPc0rlJf0KaPe+XUZNr0JGKd1qoXmOCfoUTb5xDXCCm42jMw7tyFLx4q3U1/iDO6TC35qx9XiHID4Tb/jH/RE33Ff7/s1GhOyRiF8eEaYTrQYUKvzUp9sDydPLtWd9ALKBWRKwJB5dkRC1Nco0jTr7pkyKGi2EOmAhUoufzXlCqw0SQ8xKLAAoiTwnQZ0yIW4Y6PWi+xpSVSnDTnVlaEWBhhtQNrQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(38070700021)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?W+0Ka82xgElA9Q10hCk/FmwmRcITY/8zB0Kbq0ZzEQHLh7PnPftDGRH99zxv?=
 =?us-ascii?Q?nqeb70Oh/uP/ha51xcon9pAftOC7WncKPHcM/q656cosLSINXgqba894k7Yl?=
 =?us-ascii?Q?wPbIUsUNwOZZoSjQPSATsSsR4xaluoenSmihD08ReRTc3J+Abps7g636KYC9?=
 =?us-ascii?Q?vim/cuJazkWYb6CQ1keJ4na1pNZSQh1WJcax3IF0jYxkwyrWy/AoXdNsH1gm?=
 =?us-ascii?Q?9G4BX/MxY6PYdgd1g4ODcQBYCfGnAeODXk0PhkOxjiPQFBA3oLqARjJqO3Yj?=
 =?us-ascii?Q?RJFzHn+DDIqJ9yqMknFJUDBcAEOr8A/ubXK7f0hfWiQ9Nr9eAlpxxgFezb0c?=
 =?us-ascii?Q?T8DJx3HFFpXyOjlxjL5s0ChgnXFoVJMQiJm5Wd6vap1b1F647KtRFf1F3nw0?=
 =?us-ascii?Q?8RPnqnBkcpoURqOXI65PSC5IYp5ikd2GcBCmmdhTTf4Vn2Nv/yX7AseZrpU6?=
 =?us-ascii?Q?EE+bhjRi2RuKppL82uJI6sOy54l0C2vDzklS4cvUjZvX+TWmHLsafoTM7b+N?=
 =?us-ascii?Q?etSxkOEmKhHozWWS7x5Rwta5hP9qxfM6dE5AUcvWlEZK19s8GR9a7DS04w3n?=
 =?us-ascii?Q?DJE2mUoF9NvtZA/Yk+aZDfUQ6PUWS8ARHdA2iyOQAO5AleBwKIkHi83ww8QZ?=
 =?us-ascii?Q?tXjxhBg/8cD5R52895+vs/ih2FVfuRmim6BKSnNoY4tu3nzdlm2tFFMSegOr?=
 =?us-ascii?Q?4qEA2nkBCYlYFvq9jgth9f5mmAgUE9+AtZi0t2OZ65Ld4+z5e2yz47aihfoD?=
 =?us-ascii?Q?MUNLO1EO1beqgeOY9YDAZoJ6TuOJKzSHp6FHxdOLV1mBJSQD4X8sTfBLg1Iv?=
 =?us-ascii?Q?vR24F9Zm+XUggWpMt59TYx6b5zJgePSH0LYikm3fQyMYATS1rCmokVTen104?=
 =?us-ascii?Q?5OFPKqJr5Pmj3f9JsS/TIzkse46wWCneLuoF+UOJhqyKmOf7X8gpG+XRArDo?=
 =?us-ascii?Q?MdEz5GWDec1gd7vhR+Ia7BvE9X18mxBSoZ6qRkGRr6nPGJuH09FuP4H4hI9C?=
 =?us-ascii?Q?SBvkACDoynipyGyTwuB7PTIWf9VoasAxmmrb6thOhmD0smhWARvEHMNiLinT?=
 =?us-ascii?Q?sHyDI5RYydhiKtRjGYVXGo9+ChuCQ/cS50dECv0PkpMIM0AnUykhE0AOjrii?=
 =?us-ascii?Q?YnKoFyIx14k2lrglKkqHgzVtgQVJLap1ptdH5/In0RvWSygVUpneVf885f7L?=
 =?us-ascii?Q?NN/9Z0CkKOoPQTFaObm2KaU5v1I/pI5dgTOd9VyJImjuOZRLHryDcuf0LqFq?=
 =?us-ascii?Q?QARNzcDaHR3etyIBrweNsHnO6InyicolCOR2iZX5amEieriC6sYCjFEpTZTT?=
 =?us-ascii?Q?Af36h3zZk7YzG5Jz5h8oVBSjWpNd3IDPGoKvJhYCY43USa1C7RXCjmnneBgb?=
 =?us-ascii?Q?oLulFvqjUyz6Pb8/PKaNeXwcSa7aCAIXrjzXm5kSsnpqdUytn/I1DYNC+JlT?=
 =?us-ascii?Q?ZspjiI7cKJvnHPcb1DE07xDNJuadq2sbg0hqGBEN3D+PNrhXDggIJY+ZXdAU?=
 =?us-ascii?Q?zCtCERFLW/VpQIKZ5m5zvyTB8f058THZ9xeHl+8O2Rca9D/7y9aMjjYV5Q7K?=
 =?us-ascii?Q?v/0irl6fqY4I9shurZOR1hIcRgliJ5taqrwRePIkqfvoDW2QF4dXpRjUDr3H?=
 =?us-ascii?Q?gHaBn17j+2SzOOpSJzAlkYNJGS/qMYh+KkxNdX8f0YYYelM1otziKfPBJ35K?=
 =?us-ascii?Q?bj9rTzBSw3bhwAV+yn3m/AwSQnuFGq611CGWiaDjP1lyNV3u9mnjXPwSwwoR?=
 =?us-ascii?Q?8oQI+oApog=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: r9UN7+Lqr40F3OyZpfBWSxi1fqmzzG2buVG6DffAvX8GbXBqhi5dO9cSVaTa2Zoo2I7b+liz1kJv5OuntJvS39UXo5jkEjUg9CM5iXoNDBZVNtNKY5K2yekuR+T7ug3yeHXtLm9Im2i3f3bu6ozYoEFof2wiXxavq+q0jsrw9SWgtY8YKm2frM5JyL6I/4h9mto/KUEYWQ7hAC7kTqxC9128yKRv015slQ6DJCrKSJdrYncrA5op//H6EzcYsSJeszkZWAlk3/qhcy8RUIqrIsr+EpLNz7PrD/yXmiypsFp3p7SGq7WzoPcpp1YpArIh+1WFt7HU4Z47h1cqdN2mSQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4cae8f-e556-44cf-5332-08df244971d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2026 08:03:17.0282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kAI9U0y1f9ajQ4Q6pMZDCyRDCOQD+PxzSx827wn4FvE86eOHc1y5e1Zd2Nc/sgglMTF8CtXtq5kwUWU2Bu83tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com

> Subject: [PATCH] drm/i915/scaler: Prune YUV420 modes against the max
> source width
>=20
> skl_scaler_mode_valid() compares the mode's hdisplay against the pipe sca=
ler
> maximum source height instead of the maximum source width, so single pipe
> YUV420 modes are pruned against the wrong limit.
>=20
> Commit 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
> intended to reject modes whose hdisplay exceeds the scaler horizontal sou=
rce

I think no need to mention  this commit since you already mention this in f=
ixes
Also=20
Cc: stable@vger.kernel.org

Otherwise LGTM,
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>

> limit, since pipe scaling does not support YUV420 for a source width abov=
e
> 4096. Comparing against max_h makes the check far too permissive from
> display 12 onwards, where max_h is 8192, and too strict on display 11, wh=
ere
> max_h is 4096 while the horizontal limit is 5120.
>=20
> Compare against max_w instead.
>=20
> Fixes: 3347b55f2c6c ("drm/i915/xe3lpd: Prune modes for YUV420")
> Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
> ---
>  drivers/gpu/drm/i915/display/skl_scaler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/skl_scaler.c
> b/drivers/gpu/drm/i915/display/skl_scaler.c
> index 7994b983d509..7e65c4fffbc0 100644
> --- a/drivers/gpu/drm/i915/display/skl_scaler.c
> +++ b/drivers/gpu/drm/i915/display/skl_scaler.c
> @@ -145,7 +145,7 @@ skl_scaler_mode_valid(struct intel_display *display,
>=20
>  	if (num_joined_pipes < 2 && output_format =3D=3D
> INTEL_OUTPUT_FORMAT_YCBCR420) {
>  		skl_scaler_max_src_size(display, &max_w, &max_h);
> -		if (mode->hdisplay > max_h)
> +		if (mode->hdisplay > max_w)
>  			return MODE_NO_420;
>  	}
>=20
> --
> 2.25.1

