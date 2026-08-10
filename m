Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC52931CB;
	Mon, 10 Aug 2026 00:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786323227; cv=fail; b=RO29RS4tKBm09aIY4QpryF4lAuC7bR4gt0Zkx49MGcB3gRaWsLFuoOs3ZB3G9mUzsmsMFNRsrjeIsiOxW2sgdCNdv8UM3KN+tH6RlDFRwz+vjXVnp/ByENv6zd04Jp/WTKBQWk1gd6VzlFmkRv9X2dv5MpRSUd1tjwsA3vyv1co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786323227; c=relaxed/simple;
	bh=9XtK6vyFoEL1NQTC1cZuJ1mG5z/mRROM2Po8XjtfGso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NjTpxTYS6JU3agJOP+8zpTBc1PajX/vagI4+Xd9bZ1cG7+0TLVPr9AuCXR8D2AFNC/NB/tZoj/eCRDEaZJ6w+V22UqUlmgmOeNUeMrcnXHEnkNIYjc0F6adFiPj0eH10Ewdge03YMBR6yDvUGNo5bsG1THSN7oUFrXuZlO4GOs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUtzqkB3; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUtzqkB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786323224; x=1817859224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9XtK6vyFoEL1NQTC1cZuJ1mG5z/mRROM2Po8XjtfGso=;
  b=LUtzqkB31uL2oQcccS5i0/hczT6XncyZTAK6jEXdsLZMgB9KFaEfgVVh
   ztqtgywKCYFFWl6mXqYQVLqDhr7O1vUMO6Lbs9VI2mn6vo08j4lwRxwrS
   zPewezlPY98rA2h0s/5KO/pCS331EqB8YLTDsJvIAreTVphhY3sKiuGwG
   wghl58dcnd/ScHOgbWU6KJ3acJggy3lHTZOIJdanYpNA5E3Q1HimMpbpf
   MzVGH61rNqNnEPjKAb9IM4ywVRUWtQq5DR4zdtowE6YIb3JDYIV5gI5TJ
   oVmgkQDxxqlUe2qio2045xsvKG0WE1ClvNnJaxVfwG8qL0KPqmBvulhpa
   g==;
X-CSE-ConnectionGUID: QRw1CpsMQw2hdCgbtp1jzw==
X-CSE-MsgGUID: hxL6BaULTPOXZckX2NDBBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="109623689"
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="109623689"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 17:53:44 -0700
X-CSE-ConnectionGUID: tL2H0CToR8elw7ZOpzqUEQ==
X-CSE-MsgGUID: YQ5pTX4yRPW77Yp+ryvPCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,214,1779174000"; 
   d="scan'208";a="267149214"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 17:53:44 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 17:53:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Sun, 9 Aug 2026 17:53:43 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sun, 9 Aug 2026 17:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQvEuEJSZl0yp0K2wRC4jJtj7cCpfqPWLiX1yN/t3F3soSN5x8JKBbqssDDcUr94hzF+GKSza3Fr3a7eroFRnvbFJX5usWNPin/r1MHKIxHKrFkdGPDAs/QaEUcM8ellUE1qDHKgo3V7qBfSL4vRse2v59YkR+OeOGQOopoXFtq48Hp/uX/FNbTiYGwnsM4XTR0nH0LyHfptXPbe+BKCH/YA/2Ek9mMC+pYjdZezVTfYLvemshGhA29FYacAs5nqKYK22/hYDvDI1Qd02TGgWa/oPG/nkyU5fLvewdOSbdYI8Kb/oW3p/s0trxDoygDUFIBgNLkr7/r8Av2lQPlHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AkfrJNCrjgnYnQIH5//dvTXoAnBLeOUq4eHkiW+RJrY=;
 b=fq1QrwrZnvFZdHXwWSsy7o3zXD+keoIPoc+x3gKYpGJAw6Iy4FSlCAmY21ysUVPbZ4G2tHq+/EUXeaVqMoXwc9MCOD/3NaWII6VHAwZqFbuAbcZOBzP2/cg/Crta8rlXxzeGjZMsApfR7bmgNx3HJYwYCmb15cb27q/mkq7UgIKSjFCQVPTlB06aKhd35daca5sA0CiIVH3OkIR7+J6K+m1wTqaG50JID530TNgqoyJehmfxUp2i84Q8jdLRi9C05C8cDAqrtTg1Phas2+memcyFZ084VYWKQDE0zI+PIsG/zt2jAirs+ZjIlS1+nFWLwffmO9h9TKg93yMVLLRKCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6098.namprd11.prod.outlook.com (2603:10b6:208:3d6::20)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 00:53:34 +0000
Received: from IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799]) by IA1PR11MB6098.namprd11.prod.outlook.com
 ([fe80::b1d9:3282:7e31:3799%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 00:53:34 +0000
From: "Xu, Even" <even.xu@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, "Sun, Xinpeng"
	<xinpeng.sun@intel.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
	<bentiss@kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Danny D.
	<d3z.the.dev@gmail.com>, Abhishek Tamboli <abhishektamboli9@gmail.com>, "Mark
 Pearson" <mpearson-lenovo@squebb.ca>, Srinivas Pandruvada
	<srinivas.pandruvada@linux.intel.com>, "linux-input@vger.kernel.org"
	<linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend
 cleanup during teardown
Thread-Topic: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend
 cleanup during teardown
Thread-Index: AQHdJ0kqaX7MU3yHH0OdgUrmzIGUH7aWdrZQ
Date: Mon, 10 Aug 2026 00:53:34 +0000
Message-ID: <IA1PR11MB60985BDE3A634ED205A72CD4F4DE2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260808151736.2934050-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808151736.2934050-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6098:EE_|PH8PR11MB6609:EE_
x-ms-office365-filtering-correlation-id: 2febc298-4fa3-48f3-03b0-08def679ce79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003|921020|38070700021;
x-microsoft-antispam-message-info: kHIfGvNjsClrwT9qB7OwuCAfzo0IFEZ6Yk9orT0u5OT1AEuz/K77hsUy9bG34AbU3FBSk3hsyziCag9o5H93FYkICabqqCSWp65FxudGXidD53KREH4imzy5DJQa2FFROlwGHIdxIqKuVH4fjrVwUNB7PFT/yq424xwCgUfcnVgma+RytYiSWw8UrsnIdo4nCP6ySF2oAL3cj20xKC1CRjOjQjfMUdS8GA7Zfv0yXeO7+sl9VnLaPRStnzW/iobJqdnwy7bBPMf56GN3o9uNqlLn2VreGbm+G09POgPzHICUjLh/KePu3x01m9lwN/nCvRkvxyLzYXAeqrWw1YjQrXeycedlZL4RIv98gJ1i0GJ596UrYsHYWIRTGIwVtw5BvuNo8kWxJQOhNZaQ1y8/54J3tGWOeiekWfnr9mPbKdIS6+TFHw/KE//+pgdA1Wx/rhRRmdUxWQVGijp6pfj1UlY8r//f5o0cG9GWKhO0/0D2HwTtJxAMCknl4QyG/2u3DVR2eVEXxHD6LIWaHgmn1ob5AqxgP2AAPzj2FIvynVfxhWJn/irkVQcQ0crmehlW0UK+mZZRVAMicngRi8nkU3RPXxD+P9mqmBZ3P4s5T4gRsBinMauDQgifY0/uybtgN6Y34I/OssMYUbFUE2EIlNjQ88euRu0TuirKzZppDJVmwZXeXY5qm1jQELdiVnGS0lOA+qstMV1X7z7urOKScWgZ2bSr7zxjm0kDd8JbzpYaZgvTYOrrR4s+FJWlNqaR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6098.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1IoAQwrA0jKwQULMUy6QXxypNhWfl3BXU4x+8g1JKnaWzeTbg0Y98teNOPqw?=
 =?us-ascii?Q?RZBykvaZIC1Cbj6hupfKT2wv/08ObmmJ6c8RkJuzLuTMxXiRhAIBGOcgeiB/?=
 =?us-ascii?Q?0+tV8eIZ0WK17iapHP5LJoaT1OgG2Aw1GIQdrWr0nS5ga1jPS76JPlpDheek?=
 =?us-ascii?Q?LJ2lBo+/6KnQYqYcFsYM0O8cjBGoBDEwb1EZmMitzTfNv4clD8MdpvhCBuXI?=
 =?us-ascii?Q?dhUeugDoJnnuNAtaRlJ3fa5GlcVRGqbPUW1k+QlND6WDRw1EspDkttdXyZUj?=
 =?us-ascii?Q?YETIYQWB19GNCdQ3+pxPON7W9czLl3KA27kWHW7RiiUJnXibkGDflArE+JCA?=
 =?us-ascii?Q?OxwB5AXU9kl5Mca7GxCDJRJ4VRCB6TJ0teO5+O0ZdyLH/xRkeNQ3DRM4VFaE?=
 =?us-ascii?Q?D19Vs8IssUJ/3pvOYhUFdTgMT+9gtJ9wETt19ABoQEFAszrhmxZJLkDyej+k?=
 =?us-ascii?Q?3b4eulrm99Q/bb0gB+h8QVhYG/AUNzNGvEUoz2By+Ow1zY1ilWfaR5+Z5gQT?=
 =?us-ascii?Q?9w7VjJlAN/uZ8+GYa5rJZoUNsYOMBsgWl4Asr7RgM9DjnGUgkPtEh+s1Sxnj?=
 =?us-ascii?Q?1/8h+9/nRUU7p9EaVVVEE3KbsIV4nOPMHpsdPpXwA7tlv1y+LbdOTJxgBVNS?=
 =?us-ascii?Q?fEGJzmMJbFx9O8QS8sa6TxpIUeY4D45FNxnYmK+rmcAXpwAvoKHgDsrCGWAZ?=
 =?us-ascii?Q?PM7YjuFoAMa2S8AWqX6qn9Xjj8b2YP/BGLtIYRGYAdrpCTvl2UtXsA3Jq7qV?=
 =?us-ascii?Q?PQv+5P36DgznjV2B8LazsTTuBzMcj6nLNxqPJgH0zFtAGBoKfqFbkhZSYeP+?=
 =?us-ascii?Q?E3y/4GMlpLuowBZ10fzEBxbGnVg1JF2ptGsrBcPoEnZl3yTF8/ySB1xlDCfM?=
 =?us-ascii?Q?hJi5m1gDxzpv41B+VvnJ2r+5t7Ocnmdr+QnYKrgl0+rx7fyaqZAKDQERlDx0?=
 =?us-ascii?Q?srEOV6NbDCVFMDi/C/VdXkuOeXO5zJJXPoy1tatBuBLWuV7xnEj2fxBhfmzX?=
 =?us-ascii?Q?zdvGjY5mvdvN6rApfd37qxdtW16c7QC69Ac2i/B7tdp7CqhVwGetPHihQtxt?=
 =?us-ascii?Q?Q/HI/kKNRfJAVzZVOpdEPEMoPIBEVB/3Vt/6hbqhown7UpCY7JoSOjZke5lv?=
 =?us-ascii?Q?cCQ7km0/6WUOidSV5DJXcC2gzVR71qyyqSBjq1sAp5/UFfhqR6IErM0JhUly?=
 =?us-ascii?Q?qdXuOpEYaC+0CH4p6Tbiw7/6umlJtfSbZTBxf9CzzNHFd/MNmnFdvqk9P6T4?=
 =?us-ascii?Q?XmZDEsuVc4WYMWfw9bzMY+/MtR1fJE3g7GRKgXIlb3sL/zLt0kAO4cgX24SJ?=
 =?us-ascii?Q?JTRF5XvFxq6BAuTLmGxDccgv6UuSk+r5HYIcx0WqEGOU1SFUhVT2pGITIB5P?=
 =?us-ascii?Q?NWbO+092NhdBralP9Su2MtwszqMcq+JrfueNFDf7Sysh2q0PIFUZ4aX58MER?=
 =?us-ascii?Q?xracac7CzAyeVevuFnYWUCtoMceRhzs/eAiabGuXeJ9WEqsWOnGNG3CPsCjo?=
 =?us-ascii?Q?n3RwvfZ5R8vbeSFlNTphFdbjy/dQM2/ApsgVKDOxnIv8CO2GvCuF7NzcuN4y?=
 =?us-ascii?Q?FiCIi/9D5Ancom3kssVsJWA8KfbZF6hiutpeGgVHkpxiozC3xGArRFjl1KET?=
 =?us-ascii?Q?0mgSuJTspwtwytVSWI86wKVh+bI7kydSeLHfTzLh/zC+6K58YC/MH2S01Z4F?=
 =?us-ascii?Q?XQAKs1k7r8yzvm5qHCpeev5X+cAZbV3obUO4Ae7gYJEd5yST?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HfGSnIfp1R1pnJEEOPuqNEQQvUvmHZ3LRkjdAJD8JnstXxWvMfRAPjKJCoglC/kICJCPFKCqmR46Ki8O+fMpSCfgmgPGUriuOJu4THepQCQI0Nxl1UtUxRpkuBmLhgtEc4R03R4g46r+DS2xlniw2basz3+akVh3qUG+EgPT36tLdmokQD0vDY8pEkSKBhUU4UP/Pa0WkMZykip2An39QqwpguHyPpgIoiW0ImVr7Scprw27RelW5xGAVZlLTcuMU7fidTKaBCyS0GooGCEnvKb5hdLXch46eNy8gBskzEJi+hl+zd9Yx0aWWqyrbbs6GxRLvY4SFCFAn/PeP7Ig7w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6098.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2febc298-4fa3-48f3-03b0-08def679ce79
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 00:53:34.8595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVY1ecSygVW06C7JVYX0R0qmZflz9FuxIwcfmuRNCRi9nH2dlZfeHIKhzZcAeanXi5D20HDIzXLoIo2vgXhe/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Guangshuo Li <lgs201920130244@gmail.com>
> Sent: Saturday, August 8, 2026 11:18 PM
> To: Xu, Even <even.xu@intel.com>; Sun, Xinpeng <xinpeng.sun@intel.com>; J=
iri
> Kosina <jikos@kernel.org>; Benjamin Tissoires <bentiss@kernel.org>; Sakar=
i Ailus
> <sakari.ailus@linux.intel.com>; Danny D. <d3z.the.dev@gmail.com>; Guangsh=
uo
> Li <lgs201920130244@gmail.com>; Abhishek Tamboli
> <abhishektamboli9@gmail.com>; Mark Pearson <mpearson-lenovo@squebb.ca>;
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH] HID: intel-thc-hid: intel-quickspi: fix autosuspend clea=
nup during
> teardown
>=20
> quickspi_probe() calls pm_runtime_use_autosuspend(), but
> quickspi_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
>=20
> If the autosuspend delay is set to a negative value while autosuspend is =
enabled,
> the runtime PM core increments usage_count to prevent runtime suspend.
> Without calling pm_runtime_dont_use_autosuspend() during teardown, this
> reference is not dropped.
>=20
> The documentation for pm_runtime_use_autosuspend() also notes that it is
> important to undo it with pm_runtime_dont_use_autosuspend() at driver exi=
t
> time, unless runtime PM was initially enabled with devm_pm_runtime_enable=
().
>=20
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver remo=
ve
> path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 6912aaf3fd24 ("HID: intel-thc-hid: intel-quickspi: Add PM implemen=
tation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> index 4ae2e1718b30..3c87519aca84 100644
> --- a/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> +++ b/drivers/hid/intel-thc-hid/intel-quickspi/pci-quickspi.c
> @@ -713,6 +713,7 @@ static void quickspi_remove(struct pci_dev *pdev)
>  	quickspi_hid_remove(qsdev);
>  	quickspi_dma_deinit(qsdev);
>=20
> +	pm_runtime_dont_use_autosuspend(qsdev->dev);

Reviewed-by: Even Xu <even.xu@intel.com>

>  	pm_runtime_get_noresume(qsdev->dev);
>=20
>  	quickspi_dev_deinit(qsdev);
> --
> 2.43.0

