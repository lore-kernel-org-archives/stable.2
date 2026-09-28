Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE254E5331;
	Mon, 28 Sep 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608611; cv=fail; b=KM3odbXvW43jvAF6b6vidkpliioXzIoZwVAfigagBNrPwJNs/1DUegEqEFxIE1xgGY8/6QnToMjHbK9Qr14eSb1y7K3NYyqesLV2G5CHhmekutqQY+naUw2LrqFjts0wwH52YhBnOJYzMLukduI0RKV8F2ltSDSkQ/ApoWFvQmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608611; c=relaxed/simple;
	bh=BfMT1NmMUJTI4N31gPu+EgbocxenWdesHGR/ZTLESYI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HlPYP21iYIg1e7NSSh9B/1v//x3rTIC2FxfWVDZDMFYodzR0vTrz0GMthVvQqfptBm+bMAdhRFNZ/n0EsDxAluf9Kvqywj2mIRRIGHveoQEIcIMNNCOSEpRi8Uty0nvj+mmCWISkTCa05F5+K4OU7R4kojN5KZHXsAMJ/3oEbeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UQF4GZXv; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UQF4GZXv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790608609; x=1822144609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BfMT1NmMUJTI4N31gPu+EgbocxenWdesHGR/ZTLESYI=;
  b=UQF4GZXvFOcV4knlhIZcXmvLIwJGCTAtuDHrNQTXc8UWq9sOG/goSi8y
   CpyKhMWfHBgBkkdWJRV8FTM09l/BEQeMNTbZovao90bRfv95W1i8iMjjg
   GHmkzy4oUD0o0fqEspzQNzrCiubXl9ssUVAus0Kez5oNHCvwVbOq1/SpO
   8a3xsK3xPAON/dpnc55BQQYz34JJePFKzTZSdDxtXjE2ag+drMJAvDyUa
   ycpnSBznm9LCwh4ioJZK3oxRpHuppnfF/LerXWeC5fzFr6/A0Q1+baQDX
   Maym6B6zmFtkCAp8FzSEhxvfzd/IrluboO3lFVaKX2Pn1CfJohExqswQO
   g==;
X-CSE-ConnectionGUID: HkDYr5Z/RkmFYJXr9cuaGQ==
X-CSE-MsgGUID: I404qv5BR7OYINg96FblrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90528150"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90528150"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:16:48 -0700
X-CSE-ConnectionGUID: HSufmVhOQMuqUATOZ/yHDw==
X-CSE-MsgGUID: ibKhAZj/QieWGv3xfSGVsA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:16:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:47 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:16:47 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.52) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWS6aaeGF7lwy/v1gUY5CrKKXxyUW0yLUvx3+9mPOHhK6ELUsgAk4OWF7odiozGfNYGcJY8cVJq+9y8Kajal0FVp7MIiuvXDIDD2HQvWwg9ekYWDgofEzwTAeP0eytYcm4PKJdWpULpr1Q9SbOwHKkxFw5hfslLp9LmFnkpsKI/QT3yAvhp4ysgasnGxicozIoHDLECT40OJ9OC/KPtViP/Ch06G1sjKQVj0Uf+u+kteNon/umnVrFcFInXbGLd+Xhhbe7vJ3KZxXTQ9wmIgCZlKUcuObIgAkw0SLZDGVN6RoBJl1GDVD38ZErx9JUyj/PG+WEZsaQ68FktPw3nncA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ma1WzQn7jci+ZvaffNtTEUxCreIehko0pLA8cPG4uNw=;
 b=wbFoJTgSpdDyAC8p/IhTab/Z+BEhkHKilqXgRNM2r8E7lKfc8Tvaao4IhUSmWA3iYhU7NccoZUMLD93rwe9bdMa41iT+56utlYEbzSM6nubCBj4fRyeNQfBBxU0APbbTitMvG2HL5Zv8DDnxV+UxZjPSXYJ52MVbVQIefmzryUtGY8QF+QYEF+AKqpaqZqg9kFU9OgIxBQqKlvh7vUeCYLvsdv9Dd43jvvTSszU1sjNDN6P+RbmNhoT4PN62TkPf0t4161Vqe7qc/1ejock1+Lp1qvLkVXoymae58+n6pFlQLlqc0/PvwsGe+zEii4ohhcopUinXV98nLRzbLFWZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:16:42 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:16:41 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Linkui Xiao <xiaolinkui@126.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linkui Xiao
	<xiaolinkui@kylinos.cn>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
Thread-Topic: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
 ice_start_vfs() fails
Thread-Index: AQHdTxZD7+FI3SBP2kSV/YhOu1gsCLbkGn5A
Date: Mon, 28 Sep 2026 15:16:41 +0000
Message-ID: <IA3PR11MB89864E0AB492B3E25EAC3A55E58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
 <20260928065306.1514795-2-xiaolinkui@126.com>
In-Reply-To: <20260928065306.1514795-2-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8750:EE_
x-ms-office365-filtering-correlation-id: d24bd456-ac2a-4b25-c864-08df1d738030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|11063799006|5023799004|921020|56012099006|18002099003|22082099003|4143699003|38070700021;
x-microsoft-antispam-message-info: XuAaHTcBkAvJ03GR2qcNVpnMqiodU1oZC2nmHKOHYofkplNDnCY/3qqTF5jRv7kd/jdJymPYhmf1rjILolSL7CZHU8ygl5esQ7VYLBcsXLB3jCFY4MyljvE3YPZAEgXa9HNTryE0CMp/Glgkh/XI8grHx+YaLgfq7IkfJDQUPi7k8FMKCe5cSONqZOCagxNIDTAPI8jHNbdp0h2lPaZNcgjH7FZ2uoOWhTMPee0xbBTFHJxm3QTr04mywUbP9pH6qyzn12E0QTG5gSp1nXkJEctrndZmwlpEgTU1KmXdSpDVfAm0NmNEQhlz6tCfQeFHjAVveruyl8aH6upp+i1DKUl4k1jKxA0ssFnNrsRQuBEfZgC54/Mgcpbr8J4yapkpPXgsilBQ7bZoSjHxRTxluY0ZKRVf0rJhQb+Czqp3Jl+zEiew0O2xZCcKI6UTebHvHUy9lZb9EM5mcY5XVur/kcyXZwRZodeCsu+ltuyTS2Y8bxIXw6+PMoeP+kSVJUR0wYOWm7uz+tEw2G8z5c004w5LCB9F/XFOgYUq0J1ob41KZ7NtKMtt76+uaLffv5bfqf4u+YFGuMyOehpLDd7MPdBGt4ZS3V+kOaD2BKFjRzW6yIWeYDJLV0pBdh4K/u9yc5QLjR2XXYhzuUm+vAHAeOHuAz6zDjpVppNyiXqcV626l5IYM2SiL3Nea5sboL+XwMOmZXxNgYsNNk3CxyfV44k25fpZANIcKzulWnVvBbS4xcMcu/FD7WTN7JsPwQSM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(11063799006)(5023799004)(921020)(56012099006)(18002099003)(22082099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LIbBtOOEvWth4+PextRjWcrK0mWvCzbbsnt14iuEHOQlGDLqMXHbGtAco9Oy?=
 =?us-ascii?Q?2GcRvKcgslPIEbbnKwqRrDLGfZtXQyfDPmCOTqIaNG/ktIBW6vmTH1hcwoND?=
 =?us-ascii?Q?aFoUOpCZvj60NI+8ekT2sSSV2nHkK03piiBBvHwZO4a14Wq5Hf818e1R/lMR?=
 =?us-ascii?Q?kQw5CkvmVkVWLGi/nGuij+6pgvH6eZXqCEzQBpFS6YMHvrWmvnWqol0IRUyC?=
 =?us-ascii?Q?lLLuGdKvhtCaaRQHbcGGVlokd28d0ddMHp0QUmPZBERnEfzE5J7x6jmXsjlY?=
 =?us-ascii?Q?ZZTuXxFYI1ButD5eieEwaMvxtFhvBVkCcZGHNM+6sk9CF79JzirvRj8biwGz?=
 =?us-ascii?Q?cpIZpwt1KSINdMlfK9YGKmHsr4+MzxTRc+QH1Os+Ff2/Q3S/3yapGYWVdQC4?=
 =?us-ascii?Q?DbdLCjrSRfMLucR7oUYzUVJf2qXElbAnutOaMQM5EKrhU0le6j98ImqjylYV?=
 =?us-ascii?Q?Umw0+3l/ph3bjtVmagXz5xCpWQGgrWhyUvDV3mhhz+3Umw7Y1OR/74CCeXKZ?=
 =?us-ascii?Q?wj6F8I57HaY+zPMuNXHhiMLq6rp5AfRN6polAydDK44ps7fxovP5zcJv05iN?=
 =?us-ascii?Q?GrhGy03BZSLWnYmgGoBz+g/ocgCt9RKywiFhmEHd9LoizNr7YMqOlM5U7RDk?=
 =?us-ascii?Q?EiJUSNoXBqTc7/kqemjNaTedn802wlmpLihD3CCLA3HxYV6SIvMyLt0QCdMd?=
 =?us-ascii?Q?tsWbRLc+PdXmZlduRcCKO/GN0p9aZV18kKLiRmwqE59s/KuC9pjKhRRRyszR?=
 =?us-ascii?Q?d/KeVj6fejiD241oFioKTbEFJSl26CakOlrejhSN0+xd7d7MTarC4rMheOVS?=
 =?us-ascii?Q?BZvum/M7pbGPaLGDaJoWdqfpF/vInulym6B6kbXvKZ0wawbPpDAt2uBLdoXB?=
 =?us-ascii?Q?A1WucB+6B0jYEDVXUv3cu5ifVvcebWjOB9fFBeIwiuzvOPHlURsow/fRorzl?=
 =?us-ascii?Q?QZnzRGyiJU1lXWfwQZBOLvf5HhsH52EiTNaff4akfSdcCmNMi7sgN43IaGwA?=
 =?us-ascii?Q?5tYCCfBA7d2OygUrZY2Hk2TVrlmAGFQmqcbfR+bXlZO0/zdTEmbxbg4Sv2Il?=
 =?us-ascii?Q?cfBeRw4x42eeN49UbdslIyDNRF/cAojQoPw6k6/qrtdz5Gsik76lAVeacruo?=
 =?us-ascii?Q?QBzjt3GnzWqvZxP6AAmhADFkGr/JsSQaMgIFE44PmEuUwnq2LwbHnd4AKtt6?=
 =?us-ascii?Q?iXpYu55jAz1KBn8D/5APj8mFi+oowP6bOM7wQDg2RGF8iUkgTXD7793Dj9Tv?=
 =?us-ascii?Q?QiBPaJPprTclHxYdZi9xNW0Ud6YYzwMekm5xGzXAnGByJfp6iMTGSraGr6Bh?=
 =?us-ascii?Q?PsNDkXiOXRmFoQJ/DWhqOQmWc+A3RAkFSJq8kmJrwSwDlQfJWLygzwNUMEBt?=
 =?us-ascii?Q?19sMrdAlWDTgABr96tacjP9KiFHdnrVL2A7911yYcqcwBHSRqIrQK7a8jk/k?=
 =?us-ascii?Q?hH8gOoQ7i3f6TGUeWIgRCt+4//wxIN8nGjCSqVu2GuU6Fhw+tJYZjyFTMEjf?=
 =?us-ascii?Q?jMstgmEfo9vdmpQC0ATeOrZuWfhAXuTAoPymLPqfFlzya6gn9uMSh2cUAHd/?=
 =?us-ascii?Q?xltSZB3STEOd0bzS7PgLzWFL6GlmNnLBhwD69OcFX3gRncxlHc1WHqkAn1Aw?=
 =?us-ascii?Q?qAW8aG4SDBZXtZeEz77+OYsmU9xkwg02apttvxJ/kf8nDDbXSfIhRJrVdy2G?=
 =?us-ascii?Q?nN8z0tVp8Tt2D9Ry16rGohU0aU/umL+Jwf/p5uTwkT73GmhGjVQQFzGbZ6ow?=
 =?us-ascii?Q?tOaunODxnN4TJtqg0Nj1xZLPZkDRbCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: lG+/9Fz/D3jiqNMjXVPYBmzi+QC0CDc7BxsirVUmGTO+q/nwMwM4yAPehynouL/uK1XFOTbYJo8SSnw5cWjHDz71dnSxBrjdRoY0unlIHRXyrvWjn5od5xeigtP7dNj3s6XqGYnmtj6qsiuBPctD4NeMgBzaKei67SFFTboTkKxL/HwE05GcIfnYDiSu7QeImB24YDgUG97A11eJ/p6Yzdtc4AcZnTgAvK0lsUW7WcjNtDot6z34MI79T/GRg7RnGJd2iwSf0i156c4d9FQJHBUa4//WGMv54Q2tqs/7+llw1LX4lwdgYAPepv4mAuc7BYP3k2dboCedmDFrumWqoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24bd456-ac2a-4b25-c864-08df1d738030
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:16:41.8500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r7z57VDbkDEZV1EeTfPg1v6/fHTlsNRbDa30vACTvUvjJ2KOi9ss3Ahh30XzS6rVZNfchslnZUcO+enWNsI7vthhoozq5FOuRofZWsOiRVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8750
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Monday, September 28, 2026 8:53 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [PATCH iwl-net v2 2/2] ice: release the VF MSI-X window when
> ice_start_vfs() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_init_vf_vsi_res() reserves the VF MSI-X window with
> ice_virt_get_irqs(), which does bitmap_set() on the PF-wide
> pf->virt_irq_tracker.bm, but nothing hands that window back when VF
> creation fails. ice_virt_free_irqs() is not called anywhere on this
> failure path: not from the release_vsi label of ice_init_vf_vsi_res(),
> not from the ice_eswitch_attach_vf() failure branch, and not from the
> teardown loop of ice_start_vfs(), which only undoes the queue mappings
> and the VF VSI. The caller does not help either, because
> err_unroll_vf_entries -> ice_free_vf_entries() -> ice_put_vf() ->
> ice_sriov_free_vf() only does mutex_destroy() and kfree_rcu().
>=20
> The tracker is allocated once per PF in ice_init_virt_irq_tracker()
> and freed only in ice_deinit_virt_irq_tracker(), and
> ice_set_per_vf_res() sizes the VFs from pf-
> >virt_irq_tracker.num_entries rather than from the number of free
> bits. So each failed "echo N > sriov_numvfs" leaks the window reserved
> for every VF that got as far as ice_init_vf_vsi_res(), and once the
> tracker is exhausted ice_virt_get_irqs() keeps returning -ENOENT,
> which means SR-IOV cannot be enabled again without reloading the
> driver. The hardware and the software bookkeeping also end up
> disagreeing, because ice_dis_vf_mappings() clears
> VPINT_ALLOC/VPINT_ALLOC_PCI and re-points GLINT_VECT2FUNC of exactly
> those vectors back at the PF.
>=20
> Return the window on the failure paths, in the order ice_free_vfs()
> uses: ice_virt_free_irqs() after ice_eswitch_detach_vf() in the
> teardown loop, and right after the VF VSI is released in the two
> branches that fail before the loop can reach that VF.
>=20
> The missing release is older than this change: the teardown loop has
> never returned the window. It turns into an accumulating leak because
> the tracker is now PF-wide and outlives a single SR-IOV enable.
>=20
> Fixes: a203163274a4 ("ice: simplify VF MSI-X managing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> Changes in v2:
> - New patch. Returns the VF MSI-X window that ice_init_vf_vsi_res()
> reserves
>   when ice_start_vfs() fails. The missing release is older than the
>   representor bug that patch 1/2 fixes, so it stays a separate patch.
>   (Sashiko AI review)
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index 95abc6704820..df84dbe12cba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -446,8 +446,10 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>  		return -ENOMEM;
>=20
>  	vsi =3D ice_vf_vsi_setup(vf);
> -	if (!vsi)
> -		return -ENOMEM;
> +	if (!vsi) {
> +		err =3D -ENOMEM;
> +		goto free_irqs;
> +	}
>=20
>  	err =3D ice_vf_init_host_cfg(vf, vsi);
>  	if (err)
> @@ -457,6 +459,9 @@ static int ice_init_vf_vsi_res(struct ice_vf *vf)
>=20
>  release_vsi:
>  	ice_vf_vsi_release(vf);
> +free_irqs:
> +	ice_virt_free_irqs(pf, vf->first_vector_idx, vf->num_msix);
> +
>  	return err;
>  }
>=20
> @@ -490,6 +495,8 @@ static int ice_start_vfs(struct ice_pf *pf)
>  				dev_err(ice_pf_to_dev(pf), "Failed to
> attach VF %d to eswitch, error %d",
>  					vf->vf_id, retval);
>  				ice_vf_vsi_release(vf);
> +				ice_virt_free_irqs(pf, vf-
> >first_vector_idx,
> +						   vf->num_msix);
>  				goto teardown;
>  			}
>  		}
> @@ -511,6 +518,7 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		mutex_lock(&vf->cfg_lock);
>=20
>  		ice_eswitch_detach_vf(pf, vf);
> +		ice_virt_free_irqs(pf, vf->first_vector_idx, vf-
> >num_msix);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
>  		mutex_unlock(&vf->cfg_lock);
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

