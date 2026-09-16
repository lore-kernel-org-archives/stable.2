Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FF4E66A7;
	Wed, 16 Sep 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554843; cv=fail; b=YImSh6i/sWptPK3qHoKBjC4IfVIE86cTOsKf1J2yXCPFV1rJqff2ztF2wDQMzb/qlSyCnTcIKOh9jOaqyjYrD1QjJ0eaFEdeu+hqtIYOeFNxpVpw8mAAF65abCrmLqo3NaJZRRVVSW5sohSiOy7C9ltdGYpy0fX/of8eahIzx80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554843; c=relaxed/simple;
	bh=XGb9OccIOxQr8Z9kxRNI/bVNR4M6hE7Cdb1wVK3k6Sg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lOTpY6QIWR5aapn2C8iv9YrIUbhLn93QMvwN/A50ZussJLbY1jr2J6J9kwNhji/TXv3IbXMU8WEd1eE4MZBzfc5H45D90kaGSIGi2ZsZ1VX3ZDZ/r3spuMjWlgD0kILJq10xUtIZuHTMaMwuKQaMH3uUVeMJmuAUhtajSj9sLyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WipH0xKX; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WipH0xKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789554830; x=1821090830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XGb9OccIOxQr8Z9kxRNI/bVNR4M6hE7Cdb1wVK3k6Sg=;
  b=WipH0xKXynz/khs5iR4nGCJbSgxUOjz5yuhmVej+Hk9buiNLxphcRpdi
   i/qlrTU2/zdekGRKGgSIo7a8SL/Y4xjk/J8hR1SM+vs6wwUHNnWAZ3coo
   sW0FHivZuYs0QseQfizacuf5iJbs7eS9SDvX8i1xmzrXyYFJ9v1HXoqmk
   jXP16DGHl08oot4QEorfMdThk6F1l6s10Io01ftNqJ8J0vByTJFiBcLav
   B+urSwFt40XWgr8yoYYeQZGar5FoLwaI0SaMl4B8JnGOIRSG1NQT4mZ5O
   NXmm5VuTlL5ja0El32rp8zl/ZGxFNTpsOHh34CDglyxW4ppd9+yjFJ9Iw
   g==;
X-CSE-ConnectionGUID: lWH6jx8gTLqN6CV88R+ZJQ==
X-CSE-MsgGUID: Y/zEDOZYSLyG/HVbJQA/Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89972669"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="89972669"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:33:46 -0700
X-CSE-ConnectionGUID: EY2pzqCYShefgioaikF+RA==
X-CSE-MsgGUID: WeGV7ymJQ9a25YBKHDVZPw==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 03:33:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 03:33:45 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 16 Sep 2026 03:33:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.12) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 16 Sep 2026 03:33:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huXCPs6HoPkbdkW6Jo2dAqF9hmxz8oZLsWVHxAMIvolrC33/fo2fnrp4yv0aeGGQB11EF4RfJy00hpM19qd5TyFFKxo3RB8RjvAlqHdD3sc7sPbTs03ISLfKaSbl7wjOulrS/Xuc0xOnhep7B5oyWvX3025R5z1/MyTwRwGXuKTaVjJir9my+euTbOw7t87rc00XqhxQ+DJj6wAmxI/ggJG71GNm/c2J+GmTfG4tJy6dkfZSEKxDsPUnpAiWArkurrtzJvZKH5I+BXiLgxfnevYxadcxvelRRxr+/dw8qAkCXns1wC/skw6i+yvG+X9Or+sH9GSbZubfFnMuBttPvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQ4qn0t7+V9jJKC+upXe/wp4L00QB9MWQFavaCiD1jo=;
 b=tJkrEcT4KUZomeIG1m4FXlJS7n1R6akDmrznNkU2q8BrtXLQROnD9Bsu3/lolBeRZ57Tjg+AYnvwHpKOIz67q/cNgtnpI7JB8yVH7KoHj/Y0tIv71dqtTDRBSIG4hDJ0faMAKirTwQHazGZ3svB5fspF3PikieAZiNJA1cBw8ar761W99lzEtSREX36SupOjQEFqQIgIIVPtRc7Sm6LGcCtUzN7OTuBUUkAPB0FDYWf2O9qwe2LK2n1aZGO6KJ5Qv5+x4Ia4tJZc+0lMTB7JjC498dUE49CzlD+8ZWlqdI1ZK6z5A7Z7vZiXsvX3r/ufvMNOWUn9jnwmdi2XenWpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by IA3PR11MB9422.namprd11.prod.outlook.com (2603:10b6:208:57e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:33:41 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 10:33:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>, "Keller, Jacob E"
	<jacob.e.keller@intel.com>, Jijie Shao <shaojijie@huawei.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
	<u.kleine-koenig@baylibre.com>, Ruoyu Wang <ruoyuw560@gmail.com>, "Jakub
 Raczynski" <j.raczynski@samsung.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] net: sungem: disable PCI device on remove
Thread-Topic: [PATCH] net: sungem: disable PCI device on remove
Thread-Index: AQHdRaOcMZDefrI7fkuZVXTpmUJ/l7bQ/Oug
Date: Wed, 16 Sep 2026 10:33:40 +0000
Message-ID: <IA3PR11MB8986AAE7C62816D4C14ABDC8E5B92@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260916055913.2910349-1-lgs201920130244@gmail.com>
In-Reply-To: <20260916055913.2910349-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|IA3PR11MB9422:EE_
x-ms-office365-filtering-correlation-id: 8ccef5ff-4dc2-4895-78ed-08df13ddf9d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|38070700021|921020|11063799006|56012099006|10067099003|5023799004|18002099003|22082099003;
x-microsoft-antispam-message-info: qwTb3VObX5SP7vtpUF0SISpzM2Qw45to0YFfoBNLPa1UQBoSuQLd+OsTpW4k4FNRXXqxC6SZ5YcoFyg+Eblr1p9eojBXeCndCiJEwngJPCSTnBsGCMtWKb9Q9bc3IQzuTG8Ekxl5hjcvCprn+BGk5Yge+FEgLC316PvqtxPpSUgcsfA+HpGglXkG3aU5I2YMCenrDOAlCx5GSL4HipZg30RhWjYbs2pVncbFwx4lzVK7fqEqNY+k0I/xwieLm4aG14+Lt5z9t+0YcDC73fTnwK0nzQDQ1g4HqgAPGKwD5gJ2cWHHoNMW6dnHRnbwkJBzJdSMNfXh/NLcHc6/hXKYl4Gz8hO/IeDPmoUFXfoQnxodJteenWPCQbhTNWCNLleZEzcZCgwDvBOdMcY1tWL2zTboGsdhu87qkSYjPJhG8eOippSx09ef24e1i+zfA2fbLCzA/LHCeNEyXc6GVedQ2DD+4cXrSj0cxsO5l2XYrMoyPyPPBoD7o1/ny1UT6MvLGwvdKmMlGdGLXcMWrBNO40doMZ/DPMip/XNRmxYsnpVKOifiEoKXC6evm/DUaKSVWbLzuZUm8f3tSWRH10X5SuddGsBWt/kODT7PFSJSxP+JdtfX5F8Riv+QzxpppfnWTndK9dDqxIyXUpwkNSBZLpKsRM1ua4TyfeiS9iDQjJrgtCTj2tYsizPvizs7QS5COM97s/GlAPn7TCVWI23VlT2agD7M2jFEC1zPVOA+Ccq6DG3GXtNCJ1ayOLwiL7Ev
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(38070700021)(921020)(11063799006)(56012099006)(10067099003)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LrH4HLPXDvW/a6b5nvufqliU1lvjEXNsX5hdn55nW4+HK+gm9Q7/4J16JN?=
 =?iso-8859-1?Q?ItgfXhZOJhD7p8pOAjMpD/1+GMyF8yKIyCObNmLyM+IfdjDQjOqyxA+xSe?=
 =?iso-8859-1?Q?3zMnv8/nIV36/gebPc+BvbFedyLGg8UhSKmDKjNppu6kBvTH13ljrUR+Wq?=
 =?iso-8859-1?Q?9YkR2wKjBeHSIOdTG55QT1JBZMf5Ltb/WsHSoPEa+eVoCKVZH76CDPlDJ7?=
 =?iso-8859-1?Q?BJC2YaZBXUw4jM+iYG/B9nJDS4lmcuACpo0t5PmHIjOd1JcqDPqDER0zqx?=
 =?iso-8859-1?Q?CQJpdLj9OTdPkShEAQIJLYGUYhKKBMLxZQ+nLzt6A6p5LWflkP/KkYhSme?=
 =?iso-8859-1?Q?ML2sL9kOYyfsnSOlXXAOh/c4m2Ky6JjlMJ5wN5pQvcFE8NCB1R+h1EVMrM?=
 =?iso-8859-1?Q?iE0AnKQL3XwczXemwPauP96uz6bzSooCeRsKpdf76a9woesljnFxd4FVX3?=
 =?iso-8859-1?Q?mHIZuYp+iixKlvvC69fRwsRJi9zZbiYgs2dcG68BIyIBTTySJ+fhulER+8?=
 =?iso-8859-1?Q?bxka62DtJU9DjkLIII4SxQLcRr3gUfCKUIeCkBCxthkJ6a/sd8aM4jR9TY?=
 =?iso-8859-1?Q?IdPr23EFEJ7qPxGl4SvsVZd7Djtur/xJ+p9yTgfR6Lz00EtpGsjysu0koZ?=
 =?iso-8859-1?Q?uzEVytLpDiqf7wTLgmHSn1y0bmIO2qh0oWHsJ4VddD1/iDE601ttiedeaN?=
 =?iso-8859-1?Q?DUwQNXdwJI9OwnCDDHxTn7FIIgNvZMgAZg97sor+SGJpYgfQJ8oAA0AAqO?=
 =?iso-8859-1?Q?+/gy/Hb0xxqDCgGkv7eyEU4yYFSwptpF7coaiBcxRjT1szPo8MZNdU6Nef?=
 =?iso-8859-1?Q?mSgOICUSl44UIVgdGc/53Yi1Qjx0ZzpOBcpjoqsxb222/+D8wJtd03Af3Y?=
 =?iso-8859-1?Q?qReITuu2Iou5b242x/vgYGv8mY/P+2duCKZ8amN97MFqVGxdU3eUJqgt2Q?=
 =?iso-8859-1?Q?5nKzQylvW/bkgI8jcqoAC70yaediQBxmURa1hka9cTB6VkiX+U8J3nf4k4?=
 =?iso-8859-1?Q?F/ZVN1t42J43tmakfR3/IA9DBAmgBA/q3NLgwty0g4mygO4BgRztscpwEN?=
 =?iso-8859-1?Q?Gsio5N91nSqfcANnH10ElkeC2XVjJXllG/JUg02z80kFzqsI0ZDB7jNSQD?=
 =?iso-8859-1?Q?2Gj6i7I1QROBR/NQIv7NzlTq1Bxn4ao+Bq0/y/SfaazMaV2yd6tf0M0C6Y?=
 =?iso-8859-1?Q?T7t/7q9D0edrkMLaEDhIeLrBzLmdekLBeRiwg3b8CuosRQ/PaJuqCq7OY0?=
 =?iso-8859-1?Q?GI/q+s0HFloarXyPCKBv4E8NwYG0R+taJLPOHzU2yv+GVENK1lAb4u/A5q?=
 =?iso-8859-1?Q?FdS86sbxAL0kWL+BW9BgEXSq7d0flIUA6xJmbXKTnhq2rfQ1DjAMzGzm+Q?=
 =?iso-8859-1?Q?La0zi2Ezy44j9tVbc7HRd7a4N8+qjsybW46KUqTpHZLHp4IqOJHkrsdG5v?=
 =?iso-8859-1?Q?ZXR1zLbKHefGcntryc4F8AAKk9jbRGbpeEJJZ6fvuwQN+2MC4YqZQb+q42?=
 =?iso-8859-1?Q?Ud/Hw8qUEtXkEpzg5XJQ+uwTAJ+MdkFL2J8YiatsQHnSNXCIhElZCcSDz/?=
 =?iso-8859-1?Q?65dCdcQj8U0Ex3r3jX0iEvmjH8phKOorbGN/SvtbR0R7KCpjiGFRlxW1eh?=
 =?iso-8859-1?Q?jsjtTrtnvK5hB+v5J6oPdWX1ej7rxsPrM4vQm4YFBjEIFbbR1sJTWpsDIr?=
 =?iso-8859-1?Q?m3BrnTXo7mxXjzJMAqFyfSmyNFq8kjqIJwiWXEQrwgQBYdZbT/loexphBe?=
 =?iso-8859-1?Q?8sBqDkdn4j/p0tJJ5liTy6E3nUmn+Ji8TQB8Dpnfa0o9Y6LpmMg1bNxCTb?=
 =?iso-8859-1?Q?49978Fum1rjZGEJKfkcN9BBGUGkJbig=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: SHRV7NDsZZzB1aGZ/Cacok4YHaVwfWI8Fn0L20WGhq5V6E9YD2/UtStw93Df3yxqHCMTvJqw+SNTU81hB8ZMKr6djkR7zZg6yilaW9lZFcyJ5ZIXmrlvVrIiymtZt3K/K/sJGi/JOggMGD1UBQM6Gi6Ajba8S25vl3SOVGKbX40pgPNidpyVMgiXlCC3yi2BlE510CdCjvpR/GDE/9jccOKxWl7R/fVDD1PZloFIBv9YqX+5WPe1dUuTvTLsNmXsrFwmVqYVF8a02ATzNrSZx/24CGbVDEV7n4Y8qAw1wXf9y3T3PyXrRGsDI5fIam30c0kqswoLg2X5+IiU6r+rfg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccef5ff-4dc2-4895-78ed-08df13ddf9d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 10:33:40.9618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QKcqrJpYZVBZjklDRBQ6SpvlvXlE4JO214BGqplNyuXaBikqMccuXBLRCbbVKq7E/xU+njwIXFVO5pCLVAlvYZAsRG+1qb8JkfxbOR4VvMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9422
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Guangshuo Li <lgs201920130244@gmail.com>
> Sent: Wednesday, September 16, 2026 7:59 AM
> To: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Petr
> Machata <petrm@nvidia.com>; Loktionov, Aleksandr
> <aleksandr.loktionov@intel.com>; Keller, Jacob E
> <jacob.e.keller@intel.com>; Jijie Shao <shaojijie@huawei.com>; Uwe
> Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@baylibre.com>; Ruoyu
> Wang <ruoyuw560@gmail.com>; Guangshuo Li <lgs201920130244@gmail.com>;
> Jakub Raczynski <j.raczynski@samsung.com>; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Subject: [PATCH] net: sungem: disable PCI device on remove
>=20
> gem_init_one() enables the PCI device with pci_enable_device().
>=20
> The probe failure path balances this operation with
> pci_disable_device(). However, after a successful probe,
> gem_remove_one() releases the PCI resources and netdev without
> disabling the PCI device.
>=20
> Call pci_disable_device() during removal to balance the successful
> pci_enable_device() call.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/net/ethernet/sun/sungem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/sun/sungem.c
> b/drivers/net/ethernet/sun/sungem.c
> index dc5638d105db..6abf4d292802 100644
> --- a/drivers/net/ethernet/sun/sungem.c
> +++ b/drivers/net/ethernet/sun/sungem.c
> @@ -2806,6 +2806,7 @@ static void gem_remove_one(struct pci_dev *pdev)
>  		iounmap(gp->regs);
>  		pci_release_regions(pdev);
>  		free_netdev(dev);
> +		pci_disable_device(pdev);
>  	}
>  }
>=20
> --
> 2.43.0

The fix is correct, but please resend targeting the net tree, and document =
testing.
Please also clarify the practical impact supporting the stable backport req=
uest.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
