Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B12381C4;
	Sun, 11 Oct 2026 14:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791728183; cv=fail; b=DwIXzerWYX8UR+GvlrzMwzskBG32YtnMaEQnEqJm6hJu/F2YORuhEJrF3pAeS9McjM2hmw1FguDWmccDjVtzuvJ3zSVHJ4BS7wgOzmV403U/Qrt1nsCJXIJHC1EnR/rNrVwbpoY6+Ij0k/6rtmAWY460Vuiv0cDBrM+OiqRmNwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791728183; c=relaxed/simple;
	bh=+Z+fTU2Wn72LL0bisIDUd8gPc1RkIejq7Z6hl6KNO54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ueagm9AsWRCkBroS9RaQq7QGzwIdZ34o0theiiqd1CbIlHjUdVAks6vlZZDhtTLbL+MEdW2LRCTcXpLZd3hyw2zLBPaquROIcPuguruy8QidP3nu4sjpEDRaSa/yVvT/aT9fDA+AuLcHFul7aok4/PqwmSHJRbnwKvfwfhJxxJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjIVGXQM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjIVGXQM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791728181; x=1823264181;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+Z+fTU2Wn72LL0bisIDUd8gPc1RkIejq7Z6hl6KNO54=;
  b=jjIVGXQMfKEbm7qCadBwhm2hUPennEzJDB3Bi0Z6pd6qkfqgvMlvOnF0
   0WOCkOZk7HUkqn3BIiskWlzttFZHzUmaAi3l6PjdMDjWWoOxPj4OljC23
   fxqnxRn0Gnbb5CNGqNRUETActIOUxXFMKWJ7t6b16i79tDcacUUn7HLJP
   zZxbjkIzSHjPwjohiKMfqQPSVhgHJnRgAgMs9J65Ecep7JPLuVRWk7BJU
   OGGlVqXQMRqmbN0AwhwwEUImSdjJ6SNR9tbu6Jk9v9Hzj2sN7+OLmJ3f9
   EmDhZO+322zIXBJJ3+SuqiBjsHQ4oHW+Ah70bpXitu7mAzWnTeLWzV1+e
   Q==;
X-CSE-ConnectionGUID: V/kOXQOkSyGgHNuKKUycHg==
X-CSE-MsgGUID: 2/EfDmvkTYy25cv98HGEPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="336513"
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="336513"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 07:16:21 -0700
X-CSE-ConnectionGUID: NWOXoAl/Ta6T9kzgY7o68w==
X-CSE-MsgGUID: aAsU2DZqTRmZG7sjIZfgUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,151,1787036400"; 
   d="scan'208";a="669391"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2026 07:16:19 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:16:18 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 11 Oct 2026 07:16:18 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.2) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 11 Oct 2026 07:16:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxOnACD3keATWZMhnUY4+gqegJPlGsXP2vhkLuqiEdor1xOj5xKlOrq6bDHMad+0EsGUuWAfh9LW0jAuFQ0nPJ69CykkH8RycsOvfR39U3JyO04LIo7Ww2vzMa33SgOaJsK7En2mKuCaZSh6+mOEG0yfWVvdz5XkPaXjGx9PcMNL4wuuVYP2w68HoldQx+s1QAVNvQGoaoSRxvDsW2Cje8JWGk1JRUSl5kqi3kV8RibMbX91oWKbaxU9Xr749qH0E6SxflKuTeeGlyT+kzDCI9xSdDk5b5RghD1sfiIjGh5ddgdDdYlPXYD0fsE8SEUn55BS9xG222Wt6diGi1WTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxWJ67Zg33T5TSNoufTqcI1XUEAIJd3/Y/AwAAEn1UI=;
 b=qyhZ7suiAzturxvP6o6VSzkfr4meoSr2liRqj0nCuI9QEAqJaO5jISDn+lW+nfgW3AWM1hyJgc/y8lLT3jIvqw+Zjg+xia6+TnAgiljr2GN+cU6mOnc8PSnxXeYDfh1eRrOVZPFcavW0vWzk8TAkp9WQVwPMaqFyDWVd82BtGZ2hmQihxPPCdC8tT1HMM94bDXILryTP5zhhVLWYSFNWrr8I+rGGwgmvW5YpXqQo9HgVgSe1Cl4kBNvoS+Dzud34BUSXAPTXZ5lK99Z0mpohN6urK73NYuxuImXS6SPIdxeEZGwgYtOlF4UX9gHq3Y2pEbfWOzC3JO7tpepgk9QmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by DS7PR11MB7691.namprd11.prod.outlook.com (2603:10b6:8:e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sun, 11 Oct
 2026 14:16:09 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0496.015; Sun, 11 Oct 2026
 14:16:08 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Kubalewski, Arkadiusz"
	<arkadiusz.kubalewski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without
 the SMA clock mux
Thread-Topic: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without
 the SMA clock mux
Thread-Index: AQHdRtdS6j9ATnG3uU6RLsVoN0+82bb4iDCg
Date: Sun, 11 Oct 2026 14:16:08 +0000
Message-ID: <LV1PR11MB8790D21B00CAF612C0E0B92B90902@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20260917190258.3239282-1-poros@redhat.com>
 <20260917190258.3239282-2-poros@redhat.com>
In-Reply-To: <20260917190258.3239282-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|DS7PR11MB7691:EE_
x-ms-office365-filtering-correlation-id: b1462d2b-25ab-4c57-bd9b-08df27a23218
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|6133799003|22082099003|18002099003|10067099003|38070700021|261009223027099003|4143699003|11063799006|5023799004|56012099006;
x-microsoft-antispam-message-info: 9kIE6uSD/lGPhygfwsjGeHzXAMj0O4vqPvuaE+potGhlQ07xQYM//G18s8KmThD3/6b2ebrLPvf3VDXkKeaVAd4wAfdyFu5o74QRKVvl2v6iTSzqQIBkwE+SNptGYoFYqgfQT6BedE8Xmp7UG6M8P0PFlkdfTGW4x85+SR6oam/7/4ZcKXX3lELYpP+Kby+3C/qBqhMDtNiGMWQFnE1tvcehqKh8uPs6KfFXgGEUV29MUPqv4HA/YGOZVX0cRjgHWLLmhKySoFXbJ2Ro1TMe+2Ak+E0ijKqf8wXjQe3N8Q6f+jFNfrZcdqIy9Pww2F90OdALHCsidH+S4b/E4Ym5v8kPECY5PsCck0nzzvdQ/+AXbAamU2q2EAZOiwqtysPYGB2KXMKgIUOUYddsKOjq/frf5lxskpDhKNufvseUAJGCcHS/7pLdgPLCYqetfr7MkkfaBUwNEtcrlHMGanBI+cTKzOxOVf1pnjc94KiTlwr5gehKAbNGp+X4XVUULTiT/pHGH4fPNc7l1Vqow+HtcRJvdGnVhak730ysB4gjX4CugJqTJsa/AnEh4PF8Xa+h7wxSdl2uw66T6qni6dDBBsOaB4ilCuROpByw4UcgA77dcEMc/xQkTMoIKSMem0qhlYAdmVdwQUNQtKwscf/UY/POOcEH5eGXhT6H405Pyw78JrBjpMO6AJ1FEdollFatNWGVt8USsW+oE2wBfxDJcXljZJoy42TEzm5TKgE6LQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(38070700021)(261009223027099003)(4143699003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WfNquru5GMD6xlG5XVkj66xypj9TJq5AD7az6GhOlyZn3PSWwlkI2/V5Tsjs?=
 =?us-ascii?Q?3MNEV0E66HtaB24bG/HR46O70ZndrAVrdqwKwcPl4nrrSp9NhYAnZv/LmXyw?=
 =?us-ascii?Q?3i2DjM7YFaQ7VOIyaXsd4p4hyhjdmk4QaBJ3rDvWVva+oDO6eDTq1lIHRMID?=
 =?us-ascii?Q?+YvJIPQZESJEXGIoIpvY7z8g2VzBno0TCKw+fyJGh2qukfdagqDjgEukn3zZ?=
 =?us-ascii?Q?EMay1OJBsSEZWwzPjc1pdVIaJfFuN62puyq5AApFzC9p4F95nt44ZJI+ps//?=
 =?us-ascii?Q?o56ivrb1WYBax0hArSlYvpCJKz4RVFuMV8tNwkqhffwadbgjjQE+kW5Aeh9K?=
 =?us-ascii?Q?fLHxKw9ChVcz2Ikpe5EJi21ZESsPMrQmSxnL+7B9ldHU4yADlHEeO1rQf/Gx?=
 =?us-ascii?Q?/0F2oScJv7gAiiQvJLBdddR7cexhERxYHw/sErfvZ/4eRZY6Fm8svW0BYQnR?=
 =?us-ascii?Q?AIUS7ftDOCxS4PpMIBO0FctWTzGevsf/DZhkYACsUpaakerUtGxAoqbP0qwt?=
 =?us-ascii?Q?VyqdFCLmCaPw1J8Q46FAkTfKiQpaSRTK4dcP8P5bQT37LKvP0Pc3ANTP8mL2?=
 =?us-ascii?Q?MucUjxLDwsHHmvNY3hM87lDXiPlBHENCcltquY/1JnBVBqOgQ9u8bflA1gll?=
 =?us-ascii?Q?2VjoPNC+gSQpmjPQYOV6IgKNgoFU1SBK3DwyfuR4bpJoQatjvJ6f/swatEJp?=
 =?us-ascii?Q?hfRDuX5Iv5FlGhLpzrEDMbj0Js1cJPTtTZ+PwdR2jJu8HMiWh5VSRap4Jo6v?=
 =?us-ascii?Q?nPNhpCP8aGsjTaA0xyD734LCJMaXZ/FTdrOCQX56+ynEDLeQY83d5jC+c70B?=
 =?us-ascii?Q?t4Dw5otNQJ+YdFZzLPb8zHU/9w20plUyNK27HgAF0uXp6QnnG02MWIddswnM?=
 =?us-ascii?Q?ByNxJTOw1R/rwew5/fcipkpDPHVlkm3J0zC5CM2F2vPZUw92AErkBHzk3Snm?=
 =?us-ascii?Q?L1VdcYqnkJ5cUZGhsbRCrl/62WKsx6YGmSgH6XgaLlwgxkaSmbTLA12KRQOp?=
 =?us-ascii?Q?fKLJY5ucR48R8bXO95qog0xI2eBs0BiMSGladjAxuLDa06Fceow6jTsivxEW?=
 =?us-ascii?Q?ncfDxh4FciAGjPw3xlQQTpKceiXqcB29EsLOr9l/OEOYwk2zO/E5Th4hp5Rh?=
 =?us-ascii?Q?8KLcN9B815J2OuWXzQVn2MG6Q4oCG/MObQmytoi4/KCWyhsgGMSehFtQ6u+S?=
 =?us-ascii?Q?ArH4lnI1BjZzd10wuF96d/41ZbyXVNAltu2o6pLjcFws+KgxtbagHWqbntvu?=
 =?us-ascii?Q?T2oSxcbBNo1wpLD3aZ0Jqle+6uwKUeBS8Q3AA9oKZher3/nvomNWVw+SDrg6?=
 =?us-ascii?Q?pMgO0BtVFig6Ov98TZSpobArNBOjjIHXmBWRfR+n781vkh3uSSbK29zNL2YA?=
 =?us-ascii?Q?rShdmysuwn8Z7XLFldBmUePvSnw5Jj6S6Ldc1mROUUHaRiwUzqvf+Cpp1sy1?=
 =?us-ascii?Q?T/6GYi4E8IyqgxqzCQIgQvZnrl/tycVSE9Fo5x+oYFazzCfSmNVoy4yCEUco?=
 =?us-ascii?Q?zvh/jwxn2CeDe3OPqvBt2pM4yX+M/IP7+E6vSedlmAL4MiSVKfHMOohdRmzs?=
 =?us-ascii?Q?gfZRXNTpPzLD5FcTFI9e+jwNmDINh9BygHltVTiNTTRjrF/Avl5qAWCLqaPH?=
 =?us-ascii?Q?E2APmXsDoNubgmhsWwbse2L9O/8sHbPIpuiFPIuuZBjCq11nAJoIWLNUSPIf?=
 =?us-ascii?Q?ENpCFi+mZFyBpnfCNgGYJpEZixkMMjn2DZZA07pMQeck2yloDw383H5xwGmV?=
 =?us-ascii?Q?w2V2keu1Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FDA/e5cs5zxgJNFrI+qHuOrLAvujBc2BS6ZKZ4irSys0AwZWRzirNPkX5TScJSWplGyqWaIl2ihHQdC2M/RPUo3FIPd0C32IFftRx2uYHPebF/6RHwXP69T0NABoKoyRRXofeg1XjunKnG1MHOON0Ye8I1Mgm8Oo9kCvOHSRVZYcmuUDGhaHXVr8DO1VUiCMyJJn9Xeg0jHOe3Dy/FK1k0uLMJfGfSUSTpZeA7kcobsAOHkyMxM1cMAGe/Lm4ipObWUCQhXFDgq6+B4Kn2T1NqogywkZ6pzOBkaB0Yt8UhhD+D0N3k955HjGhMZs9BBINb3nY/qmN6f/lKrgNcKR3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1462d2b-25ab-4c57-bd9b-08df27a23218
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2026 14:16:08.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EixbnGQqrovPKPU/b8ZTcYduaGkCk/2vCntz1Cd1Pd7kQBuUXtJA1/eG509/lx23+XWML9RB9v7RJ0zfKqlUZZlcgrWCI4g6YX45p1t1CT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7691
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Thursday, September 17, 2026 12:03 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; stable@vger.kernel.org; Nguyen, Anthon=
y L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@i=
ntel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; > David S. Miller <davem@da=
vemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kern=
el.org>; Paolo Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; =
Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>; intel-wired-lan@lis=
ts.osuosl.org; linux-kernel@vger.kernel.org
> Subject: [PATCH iwl-net 1/2] ice: fix DPLL registration on boards without=
 the SMA clock mux
>=20
> The SMA and U.FL connectors of an E810-C timing board are routed by a
> PCA9575 GPIO expander, and ice_dpll_init_info_sw_pins() reaches it throug=
h ice_read_sma_ctrl(). On a board that carries a CGU but no such expander t=
he netlist lookup fails with -ENXIO, which aborts
> ice_dpll_init_info() and with it the whole DPLL registration:
>=20
>   ice 0000:cc:00.0: ice_dpll_init_info - fail: d->inputs:...
>   ice 0000:cc:00.0: DPLLs init failure err:-6
>=20
> Userspace loses the EEC and PPS devices, every CGU pin and the recovered =
clock pin.
>=20
> The netlist describes the mux with a clock mux node, which
> ice_init_feature_support() already turns into ICE_F_SMA_CTRL. Key the sof=
tware controlled pins on that flag. Without the mux the SMA wrappers stay i=
nputs, the state the mux path programs at init anyway, and > do not adverti=
se DIRECTION_CAN_CHANGE. The U.FL pins are the other leg of the mux, so the=
y are hidden, and the outgoing CGU pins stay visible as
> REF-SMA1 and REF-SMA2/U.FL2.
>=20
> The layout is not exotic, the E810_C827_SyncE_SFP_SEC configuration in In=
tel's 4.80 NVM package has no clock mux node either. Such boards worked unt=
il the SMA and U.FL redesign moved the expander access > into the DPLL init=
 path.
>=20
> Fixes: 2dd5d03c77e2 ("ice: redesign dpll sma/u.fl pins control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dpll.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
