Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85FB4322F3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737379; cv=fail; b=SddzIvT+xCw+mbNuixz1+m8Y1rtOvlDFM2pWcClUgFViPO0JIZzJtlN4DwsMd0pfAKMbRYYTjMDPdJ9AXc0MpZAuTarkRTf8pBjCsw1oV028pIzZawr/kk/Af6gd/DUp+3V2Idu88v4NHn2/OseEdZ1ehaR7tdySd8iaMwP6GQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737379; c=relaxed/simple;
	bh=o7VikIl9zkMohzNP46+WGKfDrzq4AbkaHF1obhMx12Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s0XvWG9thjtAx2eKOsK80SqLF+Ixkuc480Mg1ZN0anLKw/XeFMBn/fJu10AUmjeBfeOLNWzHpyXyHowKSiSvZXNppvU6xqlBXl3es5ywx3VJMeb+CuO6Cdxh5KkyLHPItocvoISTV4Dh1g0fO291bstq4IyBM3ZzICth5g1OA4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nErvYZzN; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nErvYZzN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784737377; x=1816273377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o7VikIl9zkMohzNP46+WGKfDrzq4AbkaHF1obhMx12Q=;
  b=nErvYZzNn7Bs9BM/rhhmO2JJ7uRacZoyHpbC/CHILr34JMtXSn1JJHXx
   g8WAKsBJbRoXVyDSDEAtLon6P3IVTfeq/Bx/LmpIi4uGu8UrIKlDNYP9g
   8F2CDuZy/ISMTCEFpis1kOjCQqo5ntFkIcMJCnyZIypJZa0IrQp/ZnBsI
   KalOFUvogtiWGsMvVR6zJROQw0urro00nFXJD7YvwGv2uDW24US6xtO/v
   jagA6oxWSFanZ4//SC8PB/PxCqXuWdby4M4H0OWTDbrLbyX2ivKJGvgBo
   bqgiSOz65jRiBZWxnDakumiA0Cp9zCf0Q31UffvAtr28qrXpRp89y0Pxo
   w==;
X-CSE-ConnectionGUID: M48BVkKjSUCxBFbkYcWGZQ==
X-CSE-MsgGUID: zD//X+SvTXiBAj7Y8HeQ9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89056002"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="89056002"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:22:56 -0700
X-CSE-ConnectionGUID: 0u+ejk/LS6mx4OFl/tR+3g==
X-CSE-MsgGUID: Frm5fSXTQF6syX+Ou40Ipw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="251828118"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 09:22:56 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:22:56 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 09:22:56 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 09:22:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh6Yy7MevRUHu0jHyYQYZsRA+i/pTbehKkP5vC7+jDBjNspU0FrIwzdII7tF7bvI0uboMje75JkcBwjdax9WUCrFNsxE9mdlkzZAVq8OwdBShNvkzaRpQ5ciDTLshX1zN6lEdSVbU6Ua3NHmJzcVPznZSRbHuXv80UkoBRm3D6u30hxQqQj0Yrudsc0rXRn3dnC2NLU+SC7B7iUe7X47RJWwhqpddKRg2nmryYozbXZluAHpfOkQ92nBph0da6IytNyrsiznhVMLybddHnNsmTjmc9cCqXE2ljtHw/KEq24Q9uL2DVoL+j+Zv7DMt5145nEgIIEWmwjs8N+GTl72CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPgnAhN1sgRPoQ3IVI7nx1Kv2RjYIbI6WTwtQnHQPEA=;
 b=Vl5O2wpd/20XqBSz98EYMA8s/coINHj77t41hFl2zt+OoONGWlCFYOM+wev3UyH4untYnc4h41BeInODXqcjcLuornBrZCAQnvWeL+LB2QC+Np99jT2YJm5cdqnR71vtvewF8BwGOPQajNE2QScikR9SSbrAy+nOLxghT9teUhtJ+xswkysMOqmzj3cPnjuLE9oloRFCzdgDt+tm/Z83AR/6kP8v/ucW4gVWHtHP2qGK9M9bvL4057h3iIvqkXHwWAZJ94JZgO/4H7W5Du2p1aF3x4EUyaWptgNNc7NzV9YA4GLBXj9FLvSFQQHT0ibETru4vH/Om5pkXLkqR/LCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by DS7PR11MB6077.namprd11.prod.outlook.com
 (2603:10b6:8:87::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 16:22:47 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::6d3c:5451:b5d4:3ea6%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:22:47 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: John Foushee <johnfoushee@gmail.com>, "intel-gfx@lists.freedesktop.org"
	<intel-gfx@lists.freedesktop.org>
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "Jani
 Nikula" <jani.nikula@linux.intel.com>, "Vivi, Rodrigo"
	<rodrigo.vivi@intel.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
Thread-Topic: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX
 brightness panels
Thread-Index: AQHdGfGE/GbQvAcko0WXMVfVY37/6bZ5uEaA
Date: Wed, 22 Jul 2026 16:22:46 +0000
Message-ID: <DS4PPFE901A304F30C76A6DDF48BDAAE920E3C12@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20260722154802.3760046-1-johnfoushee@gmail.com>
In-Reply-To: <20260722154802.3760046-1-johnfoushee@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|DS7PR11MB6077:EE_
x-ms-office365-filtering-correlation-id: e22768ae-062e-482b-b4a0-08dee80d7795
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006|38070700021|10067099003|6133799003;
x-microsoft-antispam-message-info: 0Vy7CcCVW/N0HWmrkV/eU0PmLIshU9Y7lRg6lqmZDz8FaZ1v0OUtmQns8+1Uae2y0F1c8aiDS5U1DtLfYaEI/Xa7GiQS/mlLxCn6+x8ZTqnwOffDP6XAmHqnIZXag1qJLV0236p/zLNnP0GZYCPNplYXezcj19AJwjbFrXWX3l5boYVc9aqHRaVX4tWH/EeyPqVu7wF0OS8mXj03iWoPgO1Ml1C+SwngRsSJb38LwHlwMtwqlHbh87DxGyXKgPBypS3wfWLolia+k7VPHQr+gffmgYDK0Yxgru2n2I7Jqbt0/48yEx+mpuN1u0MIbovjTVnwa8xertb3jEut9XlYx1ZlnXk/PYNOdY64OSpqJuYYeQeopm+Ejzfl+R/BwT8QiMGnr0tv4DksCaT8qxvO8eaVV+C0vDYEbRrnkh+7TmPRUNQ4fpnNBKdBZ7KM/v1A9iR/soebeUYWEsZk9wzzUY++xkYFlBL19wzi2CNYO1JQUq7gmMycxlTSi6BBJSCimvTp69YlH0XUQeYjHRE7lbVmVBboxq8QdVq8TXxOPUaY9VxK/8BG6OQcK2qLZ3eiQiooYuS5Y1HMpw2RjQjUUu7MxY3Ttv5OHaD0g/ceqod1I/vKlFilaj2IjNmOIYLhrHHaAax+EPZfcLhxiNZ1ejNgKm6SCtDgig4VQ7Rm9iQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFE901A304F.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021)(10067099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OXLX+W+OUpNJurBsxyJ13IVeR4B/gEhgOBlsWiHnsYVD0/pkGV9OvGenxhLD?=
 =?us-ascii?Q?rriPs+ZAporQsUb/qAkBawI+R6my1eXtmEHLaVqB4gb420BL5Qo9zrK2j4kx?=
 =?us-ascii?Q?FkMxLU9y23cakxY/1VbMqB2AzU6o+OnpRokIvSSAZ5J0kNMFG1Zztxr/Z1oI?=
 =?us-ascii?Q?uK1hi+2yzU7ofdbMGJ61ThUDGBdaQIqpc1FFpFtFiquf5/qLZrNcowR7fMqE?=
 =?us-ascii?Q?xFuhaudczR3NNjFPiyXxBuDySlePHKbKpHiezINr4GZF9N/4yYIkGgabTxHg?=
 =?us-ascii?Q?kCoHmzIe2JZMHJvvmB6SYnUIHUWklWmGNcGpWsNWJ/jZHUwLNXfJXi3TMmTX?=
 =?us-ascii?Q?5hVmvlZV6Rs884lIpHMTDbxFOE3Doih7sjrfcjUIqw4XgJYP7PYfi3751IV2?=
 =?us-ascii?Q?nTexgAy9vH27JYVMY2B4ff1b4eCkkNTRWtOU/f63aN1FbZ4QhLjnjBEsh4tp?=
 =?us-ascii?Q?Bnfz3fGVSIpCNt+wqzyPOhgLudUSiyhbgkVjGBOTYqyjeK5X9WD1j3vAOEPK?=
 =?us-ascii?Q?2fSIZH8dvIhf4fkwLv5hF/ne4rrbw4mXA1LZWmUmBIO8xbzGVb4boQ32x87E?=
 =?us-ascii?Q?0QZTE1XMgSjzQtceXwHPNuSmW17/fOQeGj4EfDE05faMKnivzJ6XlE0S723R?=
 =?us-ascii?Q?1k1MoBcoR9z9YHygdYzWMo53683LiKy6VZ33oFrEM/9yepmmDpXz3mAeJUDP?=
 =?us-ascii?Q?/n9x88CczPCh7kBss3Qos/TSeuQ7tBmWEpIvzFDVafo/MnjCP2tMQo4I+Lt4?=
 =?us-ascii?Q?K0BJljoRJL32KR1qkN4eArlz9H1lwOwNutOiqzY0+vAaqx9ZrQAg8U6/6QYl?=
 =?us-ascii?Q?bzjyGEQCSmPKSMJhUrSCgyyCnlL3MDc0UJ2DZGaC+/H7AezJ7SM5A/cK1a1d?=
 =?us-ascii?Q?E3UxI+Vjpi9QEonAnyt1f3iRtv8KkBWiizNoW1vrn+0KSmJVE5AmxieJ+Vdo?=
 =?us-ascii?Q?ARe+cXiYkU78B9UDrF3TjU/ioglejv26WSaJLpJWzfc1Mz9PnWzDNKiHpLsc?=
 =?us-ascii?Q?tYTOtC33xdftGrmgn4dHI9jkqPGH+tgsiz0fBjR/AHQsYek9p1SiTEIggXGD?=
 =?us-ascii?Q?0AtKQQZrgeywkELENL1XmqnjE11YJ2o8DzHk3fg9u2rkqbzqDt0NrF+VLxbC?=
 =?us-ascii?Q?oLGZ7CF6njdAWuA7357aTZVUkReoc+jwG/h6q3yFAeGch/j8xqdnk/nJLtVr?=
 =?us-ascii?Q?c+yGMZF8Fona7U5vKuzPhE9q3Ngi4DLMvONBvzX8c81gBCfknziCnKcOU6pa?=
 =?us-ascii?Q?OEpU3fE8m8WN9FVpMe/G8efM3rz9WyINkauiG/szObPMAKVK28fKNtaksRFw?=
 =?us-ascii?Q?OFpvvDOg0Zbba/Zwgd56xY1kuij4+lp1VfoH3ZgToHHaiGHKnt0hY3hhpNvB?=
 =?us-ascii?Q?BdLVpp2dkQo44Gky0pOaJs9pW9vn/9max6OE9vUxWVxSv/jHXRNdsqS+fOxm?=
 =?us-ascii?Q?LCs7LL4O3BvO1cN9HSBLPOwVc7zFJMzbaW1r5kBfgQlYtQRZeZOjoUy+1fGm?=
 =?us-ascii?Q?lzHLy30omicQusPz+CrWscJ5uSdUrGb8e8m/dacwh3XkEH9B7NIHqbaVVuaa?=
 =?us-ascii?Q?OU1wJF78Doyw3MU4Fo2iRKWePbW96/8D8aAXd0l7A2iCTbNen26TI+ufzrvq?=
 =?us-ascii?Q?1yvSnB0cytPg+/LGSCdxQ7MOwkSTd1msNl7s4J1mb7meVKoWJ8yYq1bRWBNn?=
 =?us-ascii?Q?//2xxKyB5VrJFyAdOghlkmgYE07xELIDO69EiCSPAXZcvW7u1U1d1LIRTTnI?=
 =?us-ascii?Q?1Ql8NT6Ubg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mpsdWdSuFOsE2NnyF+6Ff7EEcUkSV2VoIlBvL5ZmGqCCbc24nGG4PLH+/WmD0LesMtXFW18F7bGqxkjJq4VTeQlXUqlpnLMMTnRzFaoYNqcTjEtrz484aaCrbqU50nTcHsj4CkOi+ZuE5htHmwuecGEe81La8qHowxSBpabR4FBc0/qSWuV61DLPNtFP5TxzNiqUP9FJP8lh2a4SB521ZU2HYHizGoBQEfJMJ3KNrjZtkYXm3DUmgqBNoUrr83gZOxZZd9asgIJQO24YNjEdQkaTt8L69yYIJ2+EjlvcwVpe9+twfSl8Y2vZqPNB5ahwNzccGmO8hi4VAkPjwHUs5w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e22768ae-062e-482b-b4a0-08dee80d7795
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 16:22:46.8931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4L9JxV0wbVPlD8pARWTwBlCFzO1CcUMob6NekR/GmD+Q2I6h/DFqla5dsAgwHIsl04j2BxI1OrR0gMNUE6B+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com


> Subject: [PATCH] drm/i915/backlight: allow hybrid pin-enable + AUX bright=
ness
> panels
>=20
> Commit 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible che=
ck
> condition") restricted the VESA backlight path to fully AUX-based panels
> (enable and adjustment both via AUX), on the grounds that the hybrid
> configurations are not currently supported.
>=20
> The hybrid pin-enable + AUX-adjustment configuration is however already
> handled: intel_dp_aux_vesa_enable_backlight() falls back to the PWM funcs
> for enable when info.aux_enable is unset, and
> drm_edp_backlight_init() supports aux_set without aux_enable.
>=20
> At least one panel requires this configuration to work at all: the Tianma
> Y156ZAN02.0 in the Google Pixel Slate (nocturne) advertises
> DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP but not
> DP_EDP_BACKLIGHT_AUX_ENABLE_CAP (DP_EDP_GENERAL_CAP_1 =3D 0xfb,
> DP_EDP_BACKLIGHT_ADJUSTMENT_CAP =3D 0xff). The panel ignores the PWM
> pin for brightness adjustment, and resets its AUX brightness register
> (DP_EDP_BACKLIGHT_BRIGHTNESS_MSB/LSB) to 0 whenever panel power is
> cycled. With the PWM backlight funcs selected, the panel comes back black
> after every suspend/resume or DPMS off/on cycle while all driver-visible =
state
> (link training, PPS, PWM duty) looks healthy.
> Firmware rewrites the register at boot, which masks the problem until the=
 first
> runtime panel power cycle.
>=20
> Allow the hybrid configuration by requiring only AUX brightness adjustmen=
t
> capability; backlight enable keeps using the pin/PWM path via the existin=
g
> fallback.
>=20
> Tested on the Google Pixel Slate (KBL-Y) on 7.1.4: i915 now selects the V=
ESA
> AUX backlight interface, the panel's AUX brightness register is restored =
across
> suspend/resume, and brightness control works over the full range where it
> previously had no effect.
>=20
> Fixes: 102d44b3a8fa ("drm/i915/backlight: Fix VESA backlight possible che=
ck
> condition")
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/16679
> Cc: stable@vger.kernel.org
> Cc: Suraj Kandpal <suraj.kandpal@intel.com>
> Signed-off-by: John Foushee <johnfoushee@gmail.com>

Hi John this fix has been already floated, reviewed and merged some days ag=
o to drm-intel-next.

https://patchwork.freedesktop.org/series/170522/

Regards,
Suraj Kandpal

> ---
>  .../gpu/drm/i915/display/intel_dp_aux_backlight.c    | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> index 7a6c07f..a5c03c3 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_aux_backlight.c
> @@ -616,11 +616,15 @@ check_if_vesa_backlight_possible(struct intel_dp
> *intel_dp)
>  	u8 bit_min, bit_max;
>=20
>  	/*
> -	 * Since we only support Fully AUX Based VESA Backlight interface make
> sure
> -	 * backlight enable is possible via AUX along with backlight adjustment
> +	 * Brightness adjustment must be possible via AUX. Backlight *enable*
> +	 * may come either via AUX (DP_EDP_BACKLIGHT_AUX_ENABLE_CAP)
> or via the
> +	 * BL_ENABLE pin, which the VESA backlight code already supports by
> +	 * falling back to the PWM funcs for enable when aux_enable is not set.
> +	 * Some panels (e.g. Tianma Y156ZAN02.0 in the Google Pixel Slate)
> +	 * support only that hybrid configuration and ignore the PWM pin for
> +	 * brightness adjustment.
>  	 */
> -	if (!(intel_dp->edp_dpcd[1] & DP_EDP_BACKLIGHT_AUX_ENABLE_CAP
> &&
> -	      intel_dp->edp_dpcd[2] &
> DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
> +	if (!(intel_dp->edp_dpcd[2] &
> +DP_EDP_BACKLIGHT_BRIGHTNESS_AUX_SET_CAP))
>  		return false;
>=20
>  	ret =3D drm_dp_dpcd_read_byte(&intel_dp->aux,
> DP_EDP_PWMGEN_BIT_COUNT_CAP_MIN, &bit_min);
> --
> 2.47.3

