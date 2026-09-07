Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C0137106E
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 05:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788758212; cv=fail; b=rJy3rPSRer7u+NXxYFVof+ChwQqEYYRi5HCBTAPv1G0B5rmqbWFJqlog6sUKqoIgGVDF19S1SuetZEywiK27+JT/GCEfw+/4nefjBEqlyy/WAotreh2f9UNLCWcZFx/oDwE2GooR/GdQZGLOlT8Z5uqAjgD4zSEgDp6o39kPJoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788758212; c=relaxed/simple;
	bh=dr+z3uryLwZh/Mz8Wr/8obEWpD1GgNvO4afx48F8WcU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrEKSJsZGsintLLEMsWhRi9gX2DCU5WDVHK+xshPxs5H0SvXfGjGAjEM0yprkP5syRCz99zmq8qIlmwrXcKCUurB+HmO85NdWfdaOKlfju1Xe1yFzB7eW1ttjwSxKoEFdxbLGrx7QdRzAf1bNdb3WnWKL6JDCj2sQ0gp7Fz2IYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VBlf/s5p; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VBlf/s5p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788758210; x=1820294210;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dr+z3uryLwZh/Mz8Wr/8obEWpD1GgNvO4afx48F8WcU=;
  b=VBlf/s5pacoeoWljP7WcR6TjVthCYdXnOlQRq42AobrBxhzXpbFIDX/f
   3BQgAldzcFNpyBwQABt2Q2nA2pD8KC4yf9cGyir1I6m7GD7NIqYGvYpnI
   0m3FnqmPf3Clv7M4O1CbJBCluvFKgD+C94tkwWZJdrMtdy/Tl7v0p8pGT
   Qha7HxLueoZDsLDZ6dJJpxQIzLMGB2oNOM14liVIVUN85UEEyI5zLrJNG
   RKSgR+0Ys61jjGzFxIFAMRiAir0ppoKUlqslU043MyL920B/OOfVD98Lt
   t3nvd4acGF4sMqNA+yU8rVvgw6/t0FsIL2TpVDJ7eL72x1noKdxE0SX5G
   g==;
X-CSE-ConnectionGUID: 0OhaIcAzTAa1MZVvvaUWCA==
X-CSE-MsgGUID: S0ENnxouQ2SBiV65Tr0aFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="89363784"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="89363784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 22:16:49 -0700
X-CSE-ConnectionGUID: 4UtlKfafS2i4pqYGMXGJ2A==
X-CSE-MsgGUID: xS3PP/gXTm2Y0hMwiAA92A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268030477"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 22:16:49 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 22:16:49 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 6 Sep 2026 22:16:49 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 6 Sep 2026 22:16:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0+EdEuweD8kzKwbf9UacreRDG/+r4BFtjGBg64GqZ+bzOy7RKhcRrhoM5ifJo0bxTKB1x6VYLzAeI3rqWGUGTJ9avNPIwUZUEiikvVHMgTW95C+AwrmDB0D/mhv3PDs/PIHkTmdl/wr/wi6LRZOLTeqCotmqitg40LjjiNcjqJdMEG4JQsoDqYT0MaOrEqn56DBruN9KryeGal98OSjzuerTNpg0muYWedsPfGBR7kY3InS/vbY2xbwcf4UhiGpukbEJrGjY/E6oWu6DCvXu7cmkWCOgvKLgFJIG/CPYhk3uV0GX7Ou8LH5jsqSTiYojBd9ZFsMbhZt9wXPTb9UGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXSJCp75kVTz4BRuNX/4073TdIAEzUKOEvg/g8HlWGY=;
 b=edXWoRsRV8y11JnedTsEz2di0MohXZdLWQSZSoUrrIsZbU65XPSi5RRoXPsEkm45AqqxWASAcw1c8poBdaxp2Qc7Ll/9bhxw6+XNhqAS43vpPeLUxbFr2W5eaQTABNjn8+GHUlgnt+Bvamj4RWscU7rekQuznEOuHYHNZ9rHggYh/MaF4cWIg0ogYv5EPA9cBliHyqK+NcVBnWBnihMykanxWDGFdQjwXxhVSU8vDoF/GzvUzoFeSdcKbGTvYGjx4PUIgZZ8N29O+IOo791fhNV9AYW6aQVWkJgBE0A3swhJOg2DEQZ+UbsSCiz7fkvQ85kvxjwN7m8h4u+DyFwYWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6887.namprd11.prod.outlook.com (2603:10b6:303:225::16)
 by CH3PR11MB8702.namprd11.prod.outlook.com (2603:10b6:610:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 05:16:42 +0000
Received: from MW4PR11MB6887.namprd11.prod.outlook.com
 ([fe80::91f5:637d:7c4a:6494]) by MW4PR11MB6887.namprd11.prod.outlook.com
 ([fe80::91f5:637d:7c4a:6494%5]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 05:16:42 +0000
From: "Garg, Nemesa" <nemesa.garg@intel.com>
To: "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
CC: "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"ville.syrjala@linux.intel.com" <ville.syrjala@linux.intel.com>,
	"annoycc@gmail.com" <annoycc@gmail.com>, "Nautiyal, Ankit K"
	<ankit.k.nautiyal@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion
 Plus 14-ew1
Thread-Topic: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion
 Plus 14-ew1
Thread-Index: AQHdPn29VVbJrCIGKkuF2fxiNWpTg7bCkopg
Date: Mon, 7 Sep 2026 05:16:41 +0000
Message-ID: <MW4PR11MB6887DEBC313E13C43433B0BAE3B22@MW4PR11MB6887.namprd11.prod.outlook.com>
References: <20260907034555.2753846-1-ankit.k.nautiyal@intel.com>
In-Reply-To: <20260907034555.2753846-1-ankit.k.nautiyal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6887:EE_|CH3PR11MB8702:EE_
x-ms-office365-filtering-correlation-id: 754e291f-f318-43ed-3221-08df0c9f33e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|10067099003|56012099006|11063799006|18002099003|22082099003|3023799007;
x-microsoft-antispam-message-info: a/R2DP6VI9djP69Ca7oH2VheNpe2fAMsAtXAVVhlBdnQ/Bws7QCBeu5figeh58DIvZFuboyHYi0xTYui8TJ8x4H2W6wmplUqs390owf6CudhWUmMbLzZb6uzxFqxx5IBYumJBKuBxE89iYtHVa9ty6BReGja3oesHVKqvgTZl/6pXO0EsusCQFeBgst5p53RVO/bit8yDJWw6ENzLrdGl8nFGEdsMUJwtxwGcnSq9rhn4GL8BjWr3azB6snhIi5fLM5p8obnjbAzGCI5OQ3utTnhBUQgqXzNOK0M7D2kQaHmQCGjlCUo/41zigW9fm0aFYohVKDJ6tVCvJqf7L9PH5U3y4yBLgmI34A5gy5t/wAwb7jfzBhCONle8KocE59Ty/YnwIJIEIqORcwq/VlxrWlqlcZhhgv6A8rBTo3mLUEs/d1eAalCceWsjfPFp5ERbZe1oOyNR5T7/jNcJoJ6kycBIw/bmVxIADoZNukpk0szC+/oWLH7viJFuwOhkGg9gjyhWLY8f0mEqIoZ80AFupWTfVJtNaXgtB6FqUDvy2gs04tEgq6+gZwnuknWXRr56fOzwQgb7OCuIqHJO1qDiFiB2ARrk2A2N4O1MD20Z9kBnLkjdNZbNuPl/i3BMNrnhrCCToycemmlFNlla9P7J2KXzmm0XR6VKyEzwej8z4g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB6887.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u9qKa9j0baU2dhufKD+F7euWBmWiaI55ciHZEhrzFcdzv5HTzX0VNP3iSGEq?=
 =?us-ascii?Q?FDNjeJfkiOQChsKRiuIO5fy6l5FZGZ+MBT/g92VQu3Sm7thFQBacGJ69Tv4l?=
 =?us-ascii?Q?8ONdd7uipbwAr8iB6u7xpwMgvxsaBzuCha8wKRe7QuEM4KVL6G7JLpikIMVe?=
 =?us-ascii?Q?Y8Emr/ViRNmnW0Rg9A16p/v+kBoMrO3+zKooZtGVnFNc1tCcimTtehCFbHbJ?=
 =?us-ascii?Q?74c+ILkMSTDORIhza+CJnaZ1oi2HLCVFpRbQ0YLMP5QqcOg8f8cH6acvVw0L?=
 =?us-ascii?Q?m+d/0QzBkNCfyYhxizfV0h1sv4tiC8LYJ0KoG09Rh1nqYwPCnFBWMWvDuma0?=
 =?us-ascii?Q?Au2DMbr4jvrVFGei/pdQEiBgDo8wcu4HHbp9tnwOjVr3iK+FLdTQS01ncqz6?=
 =?us-ascii?Q?uegmmSwpRkaUnpzw9gwTdiu+maqWNF0D343yKhu1j7Zw1RjcNCKEL9gWEf7o?=
 =?us-ascii?Q?1RA530z2GHkOO2c4zxmVZbsAlNdc8TdH6AIUD5haA6GBChaexvuK+lwi2Erp?=
 =?us-ascii?Q?AabCDLGkaI6kTkHuaSWbeaUquRyvXXJ6XUsnfbHPl3pK7P+ePiTTsK6RZomG?=
 =?us-ascii?Q?j2oxlqj0YUBxROFFzSE7VeJJbyEdcZtW6ryEYqcq3HfY6fQUPIV33mLAPU+C?=
 =?us-ascii?Q?0teq5jGnZdCIn5o2dqIfy7ciU+mpbiRMEaCmHGGgMw4Xcq505yTkkSd+W6Ai?=
 =?us-ascii?Q?EF/3UIypncj7vRRNaRMSGVqDqSs+7znVGj2TYP408LaSLED/fe59TJwjq6A/?=
 =?us-ascii?Q?Z0CoXnvHe82RPZSnRaPO9Dq325i5fA9EXu7pr8FzBvAddT3G2FEJjfsHOXKc?=
 =?us-ascii?Q?uaXZOjFFqZygXcIhwYliJEsatR/n7UBvrNapDOJxR5PczGANEAyuh3L2yPwt?=
 =?us-ascii?Q?nS+K+APfyQ8Yi7WXmaBWI5XHFgWivbvSeyFga1qD4SqIJiiWca9+YRuaD5+U?=
 =?us-ascii?Q?7TA2KXZFyfT2Cv9AYEleLDpmd6pDydhCP71RFufWEXOmef2NddLQmTZs30Zl?=
 =?us-ascii?Q?EalocSlqosGnBft996IPzlnSGkVOkNe5t6T0MUFoMTNq/fuEryedifSEmi54?=
 =?us-ascii?Q?VdnEswNuvm7fzgkKWheJ6+8C2o73uRdqgW0dmW9TOE6Ad2CV5GyPiMGFRZ7W?=
 =?us-ascii?Q?ae40E2bb+q3BfYlKheEkvI+LDM85Hjj84N+euHG6HlXuS26944ZknOy4dlPK?=
 =?us-ascii?Q?XLZ/c/hIe3rsptSx0yPcfqk/49/0Y4Zk975g685UJ/532ZEG4JbaTWb73zpv?=
 =?us-ascii?Q?7NFYfkEt0NWZJHw+wdxhdb3EpLWLxtks8sfAkdQLuEn8SABzFczjsXrfmJbQ?=
 =?us-ascii?Q?1X5YxLqJNtncbo+5FwEO+GaHH1x/2p6dI7IJTfDLyWVfxNoj2j52jmXHuNy5?=
 =?us-ascii?Q?RqlXPCyQZG5CdlNGCW70DVjciSK6hnHdR7wHYsmz8DF1QhQdx77i80et5d5u?=
 =?us-ascii?Q?JvjFJw6iBFZ0a5FkaOtFf4RIKiVv5m27vblKp00b6FehlA9UyxHw4du814L+?=
 =?us-ascii?Q?PqhtKT82wR5H10V9RL+uSsJgRvWkTQ6vfOItnijjBYQpst0W2V2I+5krmxP+?=
 =?us-ascii?Q?hnfluOEHr36R24NNKsLtv+mALPxS0vzxi0k4fjkcQ045kp5tclsW/AnuMwIL?=
 =?us-ascii?Q?/vcDLffeyip+3ZWuZAGoEGwJb1atRYSuFBdIrA4CEsahmWZQL2oba6EKbK0m?=
 =?us-ascii?Q?VtS3NEMAPnp3sL0Yp3VY/kVZ8NO0QKPpA6PhzPsq13YM9Za5hH4bCqvkiOnz?=
 =?us-ascii?Q?PkZnUKaZRA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Gi/IhBfPDZBE3eoD1LvLZk0b6uQyiZCvJyIwiBwRl/mUodeVfPrYlmnkm49GLT5iCY2byO38VFWIE1RmdAVSbu5CMuLTDZQBIJmHzrsEgrM2AdNrYEsLA68zjKo6lRKXMwJg+WLN6bXfGTT5KvEDmS4UjnjqRoufNL1PaxG/hPNvbqSzCxi+5hTd2IDqWxD1A4DRSJagQW2bRDPkW1HbkAIs/9CWDzmrewGaEzHS+FL5RnCY1Z798lbuOPw0urLz1qQ9kv8UalUsCZJhRzbVcxgt0N/VISiqWau2mW4Yao9KREX4iNpZUQzSN00jMgnxNqmHvndb5d7Nf+NFVwpx5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6887.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 754e291f-f318-43ed-3221-08df0c9f33e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2026 05:16:41.9560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7/wzDxAark/KHP7kZPZJ6ioOfeuQoB5MxFy8hjLANi4/B765YT5o6Cv36URlYz1P+1BHw4eOxLE8SyZGrFt4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8702
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of An=
kit
> Nautiyal
> Sent: Monday, September 7, 2026 9:16 AM
> To: intel-gfx@lists.freedesktop.org; intel-xe@lists.freedesktop.org
> Cc: jani.nikula@linux.intel.com; ville.syrjala@linux.intel.com;
> annoycc@gmail.com; Nautiyal, Ankit K <ankit.k.nautiyal@intel.com>;
> stable@vger.kernel.org
> Subject: [PATCH] drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion P=
lus
> 14-ew1
>=20
> The eDP panel on the HP Pavilion Plus Laptop 14-ew1xxx advertises HBR3
> while leaving the TPS4 support bit clear. The output however flickers, on=
ce
> link is trained with HBR3.
>=20
> Until commit 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink
> doesn't support TPS4"") such sinks were capped at HBR2 by the TPS4 check
> which incidentally kept this panel stable. That check was reverted becaus=
e
> other panels legitimately need HBR3 without advertising TPS4, and the per=
-
> machine QUIRK_EDP_LIMIT_RATE_HBR2 was introduced to handle the
> affected machines instead.
>=20
> Add the machine to the list of devices that need the
> QUIRK_EDP_LIMIT_RATE_HBR2.
>=20
> Fixes: 8c9006283e4b ("Revert "drm/i915/dp: Reject HBR3 when sink doesn't
> support TPS4"")
> Reported-by: Annoy Cc <annoycc@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16743
> Cc: <stable@vger.kernel.org> # v6.18+
> Tested-by: Annoy Cc <annoycc@gmail.com>
> Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
> ---
>  drivers/gpu/drm/i915/display/intel_quirks.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c
> b/drivers/gpu/drm/i915/display/intel_quirks.c
> index 33245f44c0d5..7d7db774d8c7 100644
> --- a/drivers/gpu/drm/i915/display/intel_quirks.c
> +++ b/drivers/gpu/drm/i915/display/intel_quirks.c
> @@ -257,6 +257,9 @@ static struct intel_quirk intel_quirks[] =3D {
>  	/* Dell XPS 13 7390 2-in-1 */
>  	{ 0x8a52, 0x1028, 0x08b0, quirk_edp_limit_rate_hbr2 },
>=20
> +	/* HP Pavilion Plus Laptop 14-ew1xxx */
> +	{ 0x7d55, 0x103c, 0x8c31, quirk_edp_limit_rate_hbr2 },
> +
LGTM,
Reviewed-by: Nemesa Garg <nemesa.garg@intel.com>

>  	/* Xiaomi Book Pro 14 2026 */
>  	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },  };
> --
> 2.50.1

