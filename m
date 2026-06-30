Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA043EA942;
	Tue, 30 Jun 2026 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813732; cv=fail; b=CXbc+8RlEkEnjj22pJpYHCdNZ+ILG44lzoSj7c7u7CBH8FQHtrn7VkjXS5KyJI00LZqkZDjZofP0Llh9DzpapJA3s5FBjyUcYORgKtBfdRut0PsddWRF6RuDEi236ixyyeVWrvwBftkv0TvTYArD1OLLYTP8T42CeFow/oNV1Os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813732; c=relaxed/simple;
	bh=Ff9so0lxApF2DLc06fDueuGnJWMt+H59zF0R/Y8etro=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZdGoIJhBPmAL8rcYYA0+rZ+yWUDQzKu/h10wCiOAKzLYsclGApPITJ7wZQGaYJOXFfqYxncSimOpmyZhWK9zKYUsSNfcHuLHYdXCZu/Erdb1BpY3tatVAtZj6MDr9Citodv4Weu0gZ8exPgeSGR6BUjOkD3Z57q+IwvravGF3Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VvMGFE0Z; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VvMGFE0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782813730; x=1814349730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ff9so0lxApF2DLc06fDueuGnJWMt+H59zF0R/Y8etro=;
  b=VvMGFE0ZidFbL7nYYMLMSBtwAPZjrNDKKa0hM89VsysI6AY6yaP0Ir1g
   zyRqEWmyrYmGO0MlWq/H8z5r65geUi10MX9Qn3Tv8NG677beM8W6dqbAN
   wHeh3pnw3GLiYBrHxlaTZEJpDzbd94Nvxkh/UHw7ky6uL731YAiuG4WGd
   FWNr8Va1EZh4iu7OtYWjNO2ZMrYdFbTnkZ5L0OfzTRERIb5xESgLNL2so
   L/ppQxG7EBNXB2TLjqmOaQGkt71emTuQB3gjIX2vG5WFNg7otB/RKQbmr
   anxISCctqwP4erRwQPl+6KUB0yZfov7iXQ5DB2Caj5nP9sGm+oZ6O+TdT
   g==;
X-CSE-ConnectionGUID: 6gpHAVSaSeyHkLRQllTYSA==
X-CSE-MsgGUID: qOBr5164QjCRYMQlPOLMkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="101066966"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="101066966"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:02:09 -0700
X-CSE-ConnectionGUID: jBaEgPwkSkC5IkY8brRYwQ==
X-CSE-MsgGUID: TBo7UgXYRZCVcUCzuAZKnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="256613603"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 03:02:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 03:02:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 03:02:09 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.54) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 03:02:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=byKHbWk7Bvc/32nKbk/on6cNh9QosEJJsEoZj8RkZzbfqt9quHKCEiSNGzcbHCCqc9LOP9E8LdRZL9f90wGTlkpdMttWVHd/lOovhinBlnOp5gWV23DS9di/Wz7Fp7/TVgk7RjTOeYU7v1OqQDa/rNnsNvORHNhSREuU+Q+zoAHRJAYoSPywzDE/FZ8t8A3FrAjyJTuAj0RS8wKRwuRYrKym4VMaaClJMv3v2oz/J1kP1sHwVwodWj6Q0wxwjM+4DCPeM0Rgx2fjN7+7cZgoBmStUtwH1iEodZZ2L+p1uGE3WR86q6rSMQXcfWP/DydqiWKZ1dZAjfQgOnxTSQ81Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAZAgg/tig0b00XegCLwDqtnNNeGA/XoYn54TiOVJZI=;
 b=BypoF4u6LtcJQ172KlZ+v/X+DrS5VoSoqwSJbX5VQKiH3Scv1JDCVwDliliJxjDJ5Dpn60zpo1c3w79kqJbq/ewfqVESmik8PH69HFmh/4CK2wy5EDcqnjR/mY+dOGDbSktPfApJMQb8CiDxgDkBS+e273wrIMhPbjwuj+6C9eRxc4ODspf3H7RLxwCQwpwIGyDw11fhy9emyAS1Jmf7ytuNFXUBo257C1pC+77mJqrOcGwh0MTQHR7Pmv3bWY6yF5ihL919K2WpfhYuUMTfFQldqi2r13FtouZixLp+XKjKYPF2Ji+kIaSGIV4T+0zAPRYq3y5pqq3ZS9QXrNO6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8562.namprd11.prod.outlook.com (2603:10b6:610:1b8::13)
 by SA1PR11MB6824.namprd11.prod.outlook.com (2603:10b6:806:29e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 10:02:06 +0000
Received: from CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484]) by CH3PR11MB8562.namprd11.prod.outlook.com
 ([fe80::ea76:e083:b8bf:7484%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:02:05 +0000
From: "Andrysiak, Jakub" <jakub.andrysiak@intel.com>
To: David Carlier <devnexen@gmail.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
 idpf_idc_vdev_mtu_event
Thread-Topic: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
 idpf_idc_vdev_mtu_event
Thread-Index: AQHc48/ZSGDpviE1x0KjcDa8q74ZLLZXJzjg
Date: Tue, 30 Jun 2026 10:02:05 +0000
Message-ID: <CH3PR11MB856221E7E8A0F6EFE5BBBBA6E6F72@CH3PR11MB8562.namprd11.prod.outlook.com>
References: <20260514183019.49527-1-devnexen@gmail.com>
In-Reply-To: <20260514183019.49527-1-devnexen@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8562:EE_|SA1PR11MB6824:EE_
x-ms-office365-filtering-correlation-id: ef3c6864-a140-430e-4b61-08ded68ea3d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|18002099003|38070700021|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: BiBzTwT4548IHlwPBKZHZosAMAmmFrAHs7yEi/zkC4gc+dmkehygMA5vxupKc1Sn1BRhvwz9Zywc1K3U3PxZb/VtOPFsNLyVpRuE9tU2EMKqS4HdefaHJvp8O3uwLJa5RHm+JDx3rOGgF/PKUpkJ2e/QorhAeeyBRgmc8R2gqJu9cMRSUQV0TL6Ra+06TjVhgzdnHF+whbCs9yYGneFL9Z8W4l93jOvzv2/P8Pf8UP97O+hrnWbzPEUZ7vlt9eumqG6GUgPfa1CPDQ9I4ad4gEhKquEM8YnqAACUgBifxVKmapBM7sJeV0lGhOM8ckuM+jdKdu5A38LNeBgv650mxLxwCdh7y9OGkMWmEvIONlXP3sxsuSDRbOuTumFN4+c9QbAGUTXRpX3+pv5Kq4uWEe8yMJIA8m9ohsUQ3H/6WKHuMIABKyYHlOibsaUyHBS+rqe1S76P0devfotwslvnfpnRlz1Gu02k9q9ZO1P8DMBLa1JhaHF5lgpvLzAIYTqqH2T/j9p0zqLGreaGz3ODqBGhR/VWnENWaiv1Tf831hghR3tHZZKxUsc/It/YUld4GCpxuFBPnRnkw4X6/tmph/Y4t1ofT6iGcIaF2KcAx7nEgXomvw5tsQGeT3DrJtYHtUlv+eD1jXZtE188nSkCywSKrCyTRgVhsHiNAsxTaEdS6cv3Xk8poC72KIfYvDODTJOG8sWSDsN/zpTmUpF6rpxjJ9ZWJeplFSG/gqYWWGc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8562.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(38070700021)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tiXiHGpTc8XIgCmxCRaMDdjaZbB86Zucw+Yr+/rlR+0AUDmtC3/FTAOjuFH3?=
 =?us-ascii?Q?Z+PWUPudBjC4h9HxHDVSNjg7IjxifzX/43sI8pYuIFW6vTHX8udvAt2NG/pg?=
 =?us-ascii?Q?PKEclN9sMQr9Y+8QA823Tf/540QB2/aqwOF2IqPdUSwJjuIOtbGM53CLClKg?=
 =?us-ascii?Q?AkmME9dq93jKZdZHSkV1fojD49OpQV35OGlnaPtUz2ufpWCChVWiUdYMk6En?=
 =?us-ascii?Q?csHi+7NsvUmnapwvRXVExlS9x/R+e3k2CmeSJ63nRKKFA1cKMCtKDZLtd84k?=
 =?us-ascii?Q?9RYeeEWZVpw/QFSG4jLqGYsOeIduEniYdDOJprBM3/67o6GV1cosgb5Sst97?=
 =?us-ascii?Q?K5IOICU/xZcdWWpslA59DF0hqmJeOUFmXuYifIolZVQhltdmGBHS+i+qfXLC?=
 =?us-ascii?Q?0F/QQKZIDf7cTwHr/LD2D6YANfFZd7/ZYsm/9dJg4mmitKflIYrRygMUwbx/?=
 =?us-ascii?Q?WFoLCauz1gZUzVjRv0kohfkgnlP+Oq0qk75KrKX/vc0qhP2zyIJJKNVVxabl?=
 =?us-ascii?Q?T2NqeWPlPSHjJOixSKx4e9V90G/1A3uGNI9za+v2Jx0ok4lTkU5g3nThfvJ6?=
 =?us-ascii?Q?xSciwcdEELaNV0HUSgVG1h59DPsMsMmO+YKYuZeBf1fCx25duwtFWRTM+kDh?=
 =?us-ascii?Q?iomCwHmdbfdH0tkeumW+dVpNvKFbJaJeVBinhv17gsiSuhoFC0hG3gw1tL1L?=
 =?us-ascii?Q?UBNpcXOnCh4F4B4vcTjbnDBD2z3KPBDc2zpAzbCWEzzWFlN1AmgwWmDMwG4U?=
 =?us-ascii?Q?ZeVCKu/RYONtmxEEC+FhKZW/B4++cD7P5k4WaAiK5wZNYOeyZJJuX0LHJpyW?=
 =?us-ascii?Q?9lPQaa/hdehl3C1qsahOWNOSjpkU2bexHXENnysehjLbr8yacU+71D8+B9sz?=
 =?us-ascii?Q?6QKnmHNczVDoMQz2RUAtZtCcj1BWjWPc3UZkNUhtQOJEMzhvQWpKfxLWJbRO?=
 =?us-ascii?Q?/p+Vp3VQ2pNcW6pPGl3EtRGZlvR6kNZV+feaWxkbya2rHhQUTYPFunRCQt/T?=
 =?us-ascii?Q?YTYzNyHSUMmVUB91N8zAs+xXryFQo/BZMysOENWn19OW14/rpVup+/EHhliZ?=
 =?us-ascii?Q?FOQtDoDXvit63q40w5J5GKg0cmqepWRz1nZn5vqlbYNlh72E6Zz9Xr7Im3FJ?=
 =?us-ascii?Q?BM91nChRkUzJl4sWi1ZJmzU2skrIdj4EGml0gjLEqkX6TPdy9jYPGA7fnQr1?=
 =?us-ascii?Q?Qvsmj5MiviKwR35r9XyRlpXNx5hKBHnh7lt8+R9nW9Ph0jYTbXgs3LJKwipx?=
 =?us-ascii?Q?yyPea+uReapHRSN2PH+EQMiA0CJsMSewsLXsLDGUVu23ub7olem71/lqYGtq?=
 =?us-ascii?Q?X4m7HQHJZq+aN7tItg0hN5zjcZGfY1AKSxdyQQU78qV0IoCuCz3K+4gzJKLX?=
 =?us-ascii?Q?NMgvnqu6AW3ZlyebPeJlIqkv3hO8vi9nLOS5CKG38riPNeh/DmcTOm5Sed72?=
 =?us-ascii?Q?UsH557mbqjeUUHGkgd/DU7pBArk3owZMCQPy8m1ciU2YUz1IwdMLevdnUZjp?=
 =?us-ascii?Q?OghXD1uzsPpDW5lpB/ea+9LW/FxCpwAVFsSxn/BWcH1j3Dy4doGnzIUQBTxw?=
 =?us-ascii?Q?y6LCrXdwxLlEBA55XOZ5E7Y559nz46l1SISfK2S6vXXuAjCUJXEWfMMD30xp?=
 =?us-ascii?Q?Xw1xArsojwOqwue9oIgAphdFfeU+cVHxY1lq9WTONaSc8tRbgdd3hUBkmWKH?=
 =?us-ascii?Q?cGFCmt5/LG/kR3ZbJwGVyLpK4YjQsNcKC/aAOcteLZSKKb5p0Do+Pb+kEphl?=
 =?us-ascii?Q?VmCLMVtuTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GUsIHvb41C3LnlGFkLgysZqHqimYpBd7QQMfPvUTIBXjZJ5Px9W1mnESGdrjoWnLZsL4wN40j/VWBx2+F6+PP6AEIZfJmQDLhTW7tpRhlmYMvLIlUh+Ok4sw/wog4hQ3tqH7mXmfYe5ErQQxpV6KYU39XEqXXmMireADmPl0HbH5guWDIfsRLRN0kP1nnCBZaYAFxuzy1O+9uYieSGMb/bPSIbcdQdIqsYRvbB45ygRs2WXikO2fe64Vf4CdOzCOKJ0xqGFhPOO0jUdvXxoHeneNid0rZRNiwTO3p/HTCS/6PJ8ojGPUjaosOXIRZHpF1R8UdTN49nIV0HiABn9GJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8562.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef3c6864-a140-430e-4b61-08ded68ea3d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 10:02:05.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSTBJvpD9BTcVRV2F7sBQApzyPDZRGgVefItxbXD9Aompkqzw/TwuyHroCPxFXI4IpGEZLDnrQ15Vf4ypu7gM8+vFioMJJqSc2JrWFd0FGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6824
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> David Carlier
> Sent: Thursday, May 14, 2026 8:30 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>
> Cc: andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> horms@kernel.org; intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; stable@vger.kernel.org; David Carlier
> <devnexen@gmail.com>
> Subject: [Intel-wired-lan] [PATCH net v2] idpf: handle NULL adev in
> idpf_idc_vdev_mtu_event
>=20
> idpf_idc_vport_dev_ctrl(adapter, false) clears vport->vdev_info->adev to =
NULL
> but keeps vport->vdev_info itself. An MTU change after that calls
> idpf_idc_vdev_mtu_event(), which dereferences vdev_info->adev for
> device_lock() before reaching the (!adev || ...) check.
>=20
> Cache vdev_info->adev once with READ_ONCE() and bail out if NULL before
> locking. Use the cached pointer on both the lock and unlock paths so the
> unlock matches the device actually acquired and cannot re-fetch a NULL sl=
ot.
>=20
> Fixes: ed6e1c8796a4 ("idpf: implement IDC vport aux driver MTU change
> handler")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2: cache vdev_info->adev with READ_ONCE() to avoid double-fetch and
>     use the cached pointer on the unlock path (Alok Tiwari)
> ---
>  drivers/net/ethernet/intel/idpf/idpf_idc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> index b7d6b08fc89e..9f764135507c 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_idc.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_idc.c
> @@ -162,9 +162,12 @@ void idpf_idc_vdev_mtu_event(struct
> iidc_rdma_vport_dev_info *vdev_info,
>=20
>  	set_bit(event_type, event.type);
>=20
> -	device_lock(&vdev_info->adev->dev);
> -	adev =3D vdev_info->adev;
> -	if (!adev || !adev->dev.driver)
> +	adev =3D READ_ONCE(vdev_info->adev);
> +	if (!adev)
> +		return;
> +
> +	device_lock(&adev->dev);
> +	if (!adev->dev.driver)
>  		goto unlock;
>  	iadrv =3D container_of(adev->dev.driver,
>  			     struct iidc_rdma_vport_auxiliary_drv, @@ -172,7
> +175,7 @@ void idpf_idc_vdev_mtu_event(struct iidc_rdma_vport_dev_info
> *vdev_info,
>  	if (iadrv->event_handler)
>  		iadrv->event_handler(vdev_info, &event);
>  unlock:
> -	device_unlock(&vdev_info->adev->dev);
> +	device_unlock(&adev->dev);
>  }
>=20
>  /**
> --
> 2.53.0

Tested-by: Jakub Andrysiak <jakub.andrysiak@intel.com>

