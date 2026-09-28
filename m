Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4376923ED60;
	Mon, 28 Sep 2026 15:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608704; cv=fail; b=HPzltfOPdvlgTcZCTb6lMR9Wsvw3yprWRgaSufDRoi3KZdGWhEZxKVP+TXcDPnKvNc53yXpN+0Q4rzLBood8UMSkCeeqOc2kzkIQj3n9xEP+SAp50H7szHmdnc3vTMhUjt0lDqmMeTfcmSf6i6Ax2zdjwNoWhqCNiZsBb9ZV2qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608704; c=relaxed/simple;
	bh=b4fdJ9eVWFkbAA+/z/eIZZy8Dfc36pEHSbb7+P2PLZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wd/qANxCuuDe1aW9ZQrvwWo9SFgtUfTLhYU4Nj4tkWuyBY3K+ErP5uYaow0M3YsBVo+gBWm3vT/2FdYlPhJsCHdvbfe43bwNdOX+nOKV/JO7EwcP+Sqa84QTLxD6lPPglQ24TSChO0CA215tvKwswLUPS7RDTFOL/uHl2hSlPfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXyNMLh+; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXyNMLh+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790608704; x=1822144704;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b4fdJ9eVWFkbAA+/z/eIZZy8Dfc36pEHSbb7+P2PLZc=;
  b=OXyNMLh+QvdWiPLMM0fWMoGiZ4lYrgPeUl32BiAr2Z5dOGi4ntVWGtz0
   wqF9Ur/4Q321+fOupOfN0IpTVFDLwVobT29prY6DZKJX9TXdYyGnAWjI1
   O34gqooICJF3R4DZZw4IWLXwzkf2PNKwFlQY61WSGYJH1F97Zb3Bv6s7B
   KIeSACsW/rvyrvccqY4OEFe9+mZMmyF4hIobk17sNe86zqnoqYEFDJsOT
   lTrnclpDsrInmatvlg0bofGMPESUkiR15vHVnorVowsykGAzXTPWbDjVG
   Rzog1pYXoo2pRkTyDe3FTUHxsJjnfa7QFHcL7luQn9yFf8yCTuNqmt0fD
   w==;
X-CSE-ConnectionGUID: pfVCRVTKRmi/Law6OQqYpw==
X-CSE-MsgGUID: hd5bDBvwRSemdozFO0eHSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="94024319"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="94024319"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:17:32 -0700
X-CSE-ConnectionGUID: b8MsBZ3zQQyLeNh9OrDMoA==
X-CSE-MsgGUID: fL5NM39NRxukLrpP0f8gRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="271561045"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:17:30 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:17:29 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:17:29 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.47) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:17:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdVsnpYH/aL44DqpHs54fjd6dj2zHa6vIl6x0oXHI5E58+HmpPEm3889AhPzaDwihSeHMIexySHg45R9GWP+IKTsowt6KI9IUdPf+xbh5qGMMvqgZbdXwQsKdhNdnu3+xRUVtcY2VEJFrR1EwAwgH2ZYpYphY24un99zXITC1Jk1XIhneMEOtaNwFN/kHdqrpGMLeIUvnJCuTOyiosRkj6noD4xCl3QCn5oOxy/oFRuvuZ+WLXCWnN2kGXMjNek1BnQ3knEJvo7Yk8MOFiHRF4OMcpGnAe7EBDd/sElmUsR1I0n1y00GQwN6IT80ZR3M8artyIeWnMp6UChvua8pZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toJALZbuefAKkF7nkzK1NB43OyATf/ZvVYH2me3Bj9c=;
 b=KqjJoy9QXpuu6+8Obst8AoIxDTXI7+6CCMrZr+NeXyhPkp5QXdame3Lq4/GvQKFjKI/ZYFa4Q4Ysr1kc7ZMcIUczYCzrNxk66Iy1i40mQHG97Vrdrmlgr463lpEWGw+y3ykQw2WihDJ590jGpnNHp7EKELRT4QsAwXG6J+LSMlU4bZYMwwNj4vdtXq+/RBSwWe+MmrZz7NCleyDdU2p0Dnz+fnso79BOFAVKd25q8QPRyo0FUkapByvf3Hs/ZWK1FbT6KDd2+EdciBoC4utQCaLOHl6EiCq7Ej+ZJNPPP0pzdBz2rB124s1jgvmEjWOlVlqxDxpaRg9/SReBk3yx/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6915.namprd11.prod.outlook.com (2603:10b6:930:59::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 28 Sep
 2026 15:17:25 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:17:25 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com"
	<syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net v5] net: e1000: fix warning in iounmap on probe
 failure
Thread-Topic: [PATCH net v5] net: e1000: fix warning in iounmap on probe
 failure
Thread-Index: AQHdT0ZRj/A2rI609UOaWzEb3jLPUrbkGlCw
Date: Mon, 28 Sep 2026 15:17:25 +0000
Message-ID: <IA3PR11MB8986AB716593140A604B0EA4E58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928123814.2605-1-nsvatoslav515@gmail.com>
In-Reply-To: <20260928123814.2605-1-nsvatoslav515@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6915:EE_
x-ms-office365-filtering-correlation-id: 9e7b38e1-f88e-4c9a-7014-08df1d739a42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|10067099003|56012099006|6133799003|22082099003|18002099003|11063799006|38070700021|921020;
x-microsoft-antispam-message-info: ZGR4XPM4Qn2FasTiONbIIOoTWV7WWQ6GEXfezGABd+laVQDkzXY6zQR1XIzR28+xTt2YT7Dw2JLIuWm9urs1KNx4mxa4uZRnr/2Hq6bwMH4rKZBIohi81aeGCYtbGhSS+8oGjrJeoQCbjcjbyfSYOrOWLmzeJqTQ6ycs/LOAAFcul4/cpjXAuUf8PoVVV7lhGv/yePGK0TnfGZz4pWwtVDK+nfYsAboljdLuL3fogqMabkE2o+iGFnwg3kjjH3oi18KULfbxNpr/26TuvHT3f+8+JmgOzljNlpqpeQ58CU5KFoGfhBJ8611N+Kuk+3u8dj8np1RirM4kIh1uqNomCb0t4VTFpXWmg/RHYspH5P7E9gtQF2LAfTkeKvl7S4IVhgceyIQuEntQ1+vG8GJoHxxHgceWB1OnCg8rrH51SdNNG9pItMGAOBoR6zTCi/daZrlBCDwgjabXJbcTovZWmPZJW7DetDUtVfaJl6vCf4fJWNN68wqSQ71RNEbMbnfflbSL48YuXtDS8Zm0EadaC2URYkIw+/cWVVMIYJpfz8LprTDuXac3Hhli08UsIViPvp1lBCuKZACH0sXEH/pnUl7iHmXxWNQIeTXI6HCE2x2XWT57KkVho39MUuy5DdlHX1+fWRjkJXzPtrfTbuC4AINVwGNDQ6bYHrpO0UDtYXLXwBEUoCZKbK4xKdHYl4IO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tv2SBK70zg2o1LYZ1h48KEZ/My/pSMxxbN1yDZO1txg5ktiXvCT4oywpmYWu?=
 =?us-ascii?Q?Ge0gXakxO7OgxE549Okub51z+6RCwi8d6FIv6Ag+YFW84s+3h/1DuzloH0TV?=
 =?us-ascii?Q?ADLj9SiSotzwGVO6hi9VKiy6qSwhWI64kJP1tqp66UqJL+HFwPtf65YNTKNN?=
 =?us-ascii?Q?HG9iZ4j0NvcNtZGW9aC3CRTrfu9WZDEJhLnQwye3qd1Nuqk39V3bjbi4dIyu?=
 =?us-ascii?Q?s9j+a1P7fCH8tIJPiGcX8mgtYLCYPwZJAKvltemVeJO2+DL0GE67w0sOgsd7?=
 =?us-ascii?Q?v2PchEi26J8WnFHjXzqHs8yoR60Zu1GknocqPS7ii4dmeWRLCTXdehXVyrlG?=
 =?us-ascii?Q?hz3vv7Efg0XVvmm4DXYUBwqsYvdgdAT+LRT9J5nLdhmsW5D4jtkN4lLXFZRL?=
 =?us-ascii?Q?UEXBzfe8jh5E91F3sdbHTQnxhNwIjShc/Ju3JdYO5VtD2iy2X4kyzHEOJFf2?=
 =?us-ascii?Q?+pTRm6h1oryx0WUzhDuynb+9GhOVV1Pum45DmjyBijL24w2/KZMldzjpy1tx?=
 =?us-ascii?Q?y9V22ReXmu2Y8PdauocxKqSLVMWVT/Gy7uzI1yTr1bC6kGtEvngtIEYzMq6j?=
 =?us-ascii?Q?mTJh019EFb8bAp8iGznarQDEki9rK7zM4xRahEKL/uddIP2Mtfp0kfv3wGyj?=
 =?us-ascii?Q?nMBkERF7QAhvvf8VBtT11AosoUfG0tU8icpUxiK3jrmg33YtwR7sS9mY3Iic?=
 =?us-ascii?Q?YOKNrDxMDM+tz+nEcdTMRDshtHuIikGvXouCgDi4FF/GVsPLxIP0N2xdm3Wl?=
 =?us-ascii?Q?NlNIi+EsHzj3ZyUM0RoOE2QxcgNDOPBtc4sBOuOLjKpN7mj8t8BGS8AYtVCq?=
 =?us-ascii?Q?Fx3prRw6qs3lPcv21s0sEwDidqub2jpDGyjYu01/ySdWJ70E7/TL8tBE5P+L?=
 =?us-ascii?Q?L+Gy4jEXRuZAV17sY9UV4bLJGGmDenxtvk0c12gBOhVGyz4ND093nbRqvc5B?=
 =?us-ascii?Q?UQ5r1pTLnHOKu3fjr4krTVi2NJpA4UMKIrNeJ4iXorYN9kJf7KJ4jOstyFEq?=
 =?us-ascii?Q?55XnzKipGLF2+5JaI7mR2ArSCqq1tOpFml1wehrpbjFvck/tY+85h4Pa97nl?=
 =?us-ascii?Q?W5a+NFDlYqKBWkP4LMhx8W5ikXLmqGM8zDw3V/MmBIAuM1IvmD5fAUADS6Vz?=
 =?us-ascii?Q?lh5QiYO3hI/mXR+FJg7SVXTku5azXW7Tt1Zm4QVP9qTbW5klevMUW22pxoyk?=
 =?us-ascii?Q?BJXt3lGXR0WzktF+T9pLyxOQc23QCOQQjEr6VO+pHLIZmrNMPNFZ/CnixuOi?=
 =?us-ascii?Q?15IKcvbJF0DLuHwoHX0WuuXFMksVKa/7v5Ag/QHKnm7Al02U+6I+5Dxp/ASZ?=
 =?us-ascii?Q?JE1MRDY0UjQ/EMk6rVtDFPiFsb6m0U0s5xqwc4MvnuIAmLkNu9T943yeCk9r?=
 =?us-ascii?Q?KmbgAPKG1w00wwOS7dyum0yDAx5QsrwsXtHuyBN7InWk6Dt+VTMwdzClNmP0?=
 =?us-ascii?Q?mYjb5m3rCi78ef5UiQeGeFHobNuS/VZ52cHX2dyz/HvqIg8WxX030/6ccJOI?=
 =?us-ascii?Q?6jAM8sgXQcNmW6wrirm4A+Ry/wCU7xcii8ZHpNnbGeOsJXkL+KpF1NmEO9ku?=
 =?us-ascii?Q?IiLbYUh6BL3vpYQv/xkLc2aZyaKoK2KrQk1NpgDG+oC+jMKSNF5hsy0JDHIJ?=
 =?us-ascii?Q?P/7i/QIUR6/e1OWGsSECqgUA8MlIZcYEmR+CAgLdhgIT9Gdwuv6VNNwsEjVM?=
 =?us-ascii?Q?egJfURK/TEi90POpK8X038J3nDmtJZc0Cmrzi+a2gauUC5bWfTCI9L/w85SJ?=
 =?us-ascii?Q?QFqazcGtWmLS7qe32YAm7y3UkoDruf4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5uPhy4CRJEm7RZC0fpTVRNkPQTl9Zdh2yF9+i2mjaGfVixgaQVwK8sYrVEA6alxiW9cNC5thrsE1bXfVz7h479aO/rfJ506er3RSxQ5uH22TqmwKP1cqXcxT6HwvREZG337lc4Iyf1eQbECzhW3l59n4jvK9JOZr/qsu/biBO80UF7yaRXtjO6mluM+A5vOdjttbgTwZvdS71/vR64QXKXUqh8GSCqIOBfT6b0r02FE3F2ET/eiUSA1AjlIwbBvkUjcdxBCjDo99SSb7u4VvRMxMBZ2ISmtwD/pvQW1njAGoJfc2LqOyEFKPrcRpRSxmNgNkFeHWBmi/dO7lRg6HBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e7b38e1-f88e-4c9a-7014-08df1d739a42
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:17:25.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ii4tKquMHcWM60Ev1BwwjOpBUY1tjgdkB3O+E/JQFUHL/2jaOL/+UsL6vgR+35qpOvdbAjOX5BzOBBwGKDMAzEcjwuvZm2Yi+eAIARy4UF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6915
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> Sent: Monday, September 28, 2026 2:38 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Svyatoslav Nikolenko
> <nsvatoslav515@gmail.com>;
> syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com;
> stable@vger.kernel.org
> Subject: [PATCH net v5] net: e1000: fix warning in iounmap on probe
> failure
>=20
> In e1000_probe(), the error unwinding path at err_sw_init
> unconditionally calls iounmap(hw->ce4100_gbe_mdio_base_virt). On non-
> CE4100 hardware,
> hw->ce4100_gbe_mdio_base_virt remains NULL.
> Passing NULL to iounmap() triggers a WARN_ON_ONCE on x86
> architectures.
> Furthermore, on CE4100 hardware, if probe fails before or during MDIO
> mapping, ce4100_gbe_mdio_base_virt is also NULL.
>=20
> Fix this by adding a NULL pointer check before calling iounmap() on
> hw->ce4100_gbe_mdio_base_virt. iounmap(hw->hw_addr) remains
> hw->unconditional
> because every code path reaching err_sw_init occurs after hw->hw_addr
> has been successfully mapped.
>=20
> Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dca1ef9e2e234b8d3599b
> Fixes: 13acde8fffc0 ("e1000: cleanup CE4100 MDIO registers access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
> ---
> v5:
>   - Updated commit message and changelog to accurately describe the
> NULL pointer
>     check implemented in the diff.
>   - Fixed subject string in the Fixes: tag to match commit
> 13acde8fffc0.
> v4:
>   - Actually include the code changes (v3 was sent un-staged by
> mistake)
> v3:
>   - Switched from pointer null-checks to checking hw->mac_type =3D=3D
> e1000_ce4100
>   - Removed redundant check for hw->hw_addr since it cannot be NULL
> here
>   - Added missing Cc: stable tag and Closes tag
> v2:
>   - Expanded commit message to answer reviewer questions (reproduction
> details)
>   - Added appropriate Fixes tags
>=20
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c
> b/drivers/net/ethernet/intel/e1000/e1000_main.c
> index d7f5c6f16142..d7e279b739b8 100644
> --- a/drivers/net/ethernet/intel/e1000/e1000_main.c
> +++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
> @@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  	kfree(adapter->rx_ring);
>  err_dma:
>  err_sw_init:
> -	iounmap(hw->ce4100_gbe_mdio_base_virt);
> +	if (hw->ce4100_gbe_mdio_base_virt)
> +		iounmap(hw->ce4100_gbe_mdio_base_virt);
>  	iounmap(hw->hw_addr);
>  err_ioremap:
>  	disable_dev =3D !test_and_set_bit(__E1000_DISABLED, &adapter-
> >flags);
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

