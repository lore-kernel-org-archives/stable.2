Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC8F4BB5BD;
	Thu, 17 Sep 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638068; cv=fail; b=uF9w0YOj8LtTu7uXbegsUIoqMzFECLduBFzXSW3/UY/CJY/ru2ew2AtFAZTP0uPMcNhF0hNw/F9mI3MWzwcBYfSPM3WoInx+iyuI1IXRmCWsUxoVVnxW9VA+nwfrLjQgo+mCEc3qUzkCLFtjESjm6zWb9PrThTZVLYaWPbSg9UA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638068; c=relaxed/simple;
	bh=UATV5hj7DJlzLI+KHx3ICf7BLtKhC+1TFHPbSa9rTXY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cuMj9a4pK6W5tO1ECCedDeMXM7E8i3V5aI9HSZNOBUNE1ueORROQYgnvdtUEhuxxqTMdhI4RANYapjOnaIsbnbEsZ/8UxPGR/5Y46/nrKSdD7GKuX5S91WyIAx/nBJ7FudterrIuSCnRfSc+8Y/gXO0VQONAd26+mJzA7HD7Kag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qnv4DBO7; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qnv4DBO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789638042; x=1821174042;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UATV5hj7DJlzLI+KHx3ICf7BLtKhC+1TFHPbSa9rTXY=;
  b=Qnv4DBO7vhZoa56TgCMlpEPnwpI9FCRLc1pLMjqdt9W90c1QI039CwDC
   TDVg2UV15PzyKTMnzxXzA8lEkNFXIqOpTFFvq2V818IQXSJf5ZDf3jsSy
   2CNQyWZJDVmYWv1iJ1/C3rAMTcMRq4pHyKALAfGcysMXio/VqYsG9s0Fp
   vMYX2kfBclXBj2VzaBsf6CDtO96PCUAmhauU9h+4BhkGywnDqWkz6wNxp
   qE9tIqci8YWkVlz654GH5Uw7U5+evVQhoOTtWYN5L7GAZxcS02y7fOA8J
   PQ/rgXF87mDje6rbBShlgnIcLBX5mKCT2vZCiN01fHevrB7Z30iEkgezo
   A==;
X-CSE-ConnectionGUID: 2ehhmRJ7QjGf4SawQKiV0A==
X-CSE-MsgGUID: NNSEIm6XRiyLG4UgrMJ84A==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="77607077"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="77607077"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:40:38 -0700
X-CSE-ConnectionGUID: hFaXvbZQS4Gbgb8b5OZz1A==
X-CSE-MsgGUID: Z6QhVWrcSEa+Ws0JmSlA3Q==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 02:40:38 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:40:37 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 02:40:37 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 02:40:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/TkQvuIi/1HYpM5D72JVQfGVkbGLr+h6zaqQg6ruO86IYYY0A5k1/1nkSi//ZjyvCXUUN2PHxfflLv0x3xesIDnQzzJcCiXEBgSBTIN8cDEf88RsA1dLvRKeOVnsxusER5oJT7gWsQpnIBDGbha66lFNiVgpw0Vf8Fj74IpY/BqmtK8kP2cRNMo37fWVvAGJFfbo6Xm67zOdRn45LBN7BJGjSrAMetMGULIdnhmapwUMfpNQ0vvDsdvfTlCYWmvmHTFLtPqpzIhKxzag5YTWh+EHdiHjQCCmj2CA5cuLshIyRwLbHzR24lwdSqMF90GKtyKmtEvfvd9lBoaQq8mbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMc3FckKLVIWezD/TfySXl9oA5Mm3fFsvSJ0MvpghZs=;
 b=g5sYz0Tx6hGqn57qLQELWrMsNlEqK2GiYvNeeRlEiHWxbz3IfqSzAABlkPwf4eu1nhZszmV3dhHvMJ5R25zvPGmY5OCxt4vUbhmoMP2FFxICLORtuD4DKGZnxgdtkmUS2IDuk7JAjuIA4JDlPOufnV24SNPxKNUiu3ewfJBzd1TzF9tJdUuNKT1vH4y7rIdUSk9eqmweO3q0IorCZ+qAz/k8JTdI9iSQJzbRMwjm+4nGWrfTreXdrSp8q8uWUPr9pqR3arvByFxmEnPPV0n76SoxbKh7FJqiJ4WTmqSt8AL8fy/THsg/c2xV1lPw1v4uq2cZzJNn/Cp6Ml0626wsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DSWPR11MB9798.namprd11.prod.outlook.com (2603:10b6:8:3c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:40:35 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 09:40:35 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter
 when register_netdev() fails
Thread-Topic: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter
 when register_netdev() fails
Thread-Index: AQHdRd9Quz6p/IvJo0SyWu+Mg5XzYrbShWGA
Date: Thu, 17 Sep 2026 09:40:35 +0000
Message-ID: <IA3PR11MB8986193C242880AF4F66A18BE5B82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260916132740.1001797-1-xiaolinkui@126.com>
In-Reply-To: <20260916132740.1001797-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DSWPR11MB9798:EE_
x-ms-office365-filtering-correlation-id: 3eebf644-bb99-4e6e-4134-08df149fb9a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|22082099003|18002099003|921020|38070700021|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: yrc/a5eMQpKwnrMXr5LI+jDJ4odBYJa7VaCLwYwlwttE1pKIqWPLoeomI85r5o+HDCqXmeZXxbbD4d/X7rRgIMdElwYYyzxgjzNgn4ZTobAEubZ0ZA0DQyUWYJeV5vPiB3ftR47P6rcTQaf1tw5JsrQQegy5NOwJaqGKwJBP7QdFp5bBZqOIYzngqxE5uYsdC+0uOwOQyIgAWdOQg/u9CezHOausHvGKqo/Xc3YKfgdeTqjIPd14PboDimQDvmVmun6ptV3czVfC1KNe/Zo6l5bXZLKNc0QhkpntgkfDOmRI6jHbRNbzOQ0x08REZdJD7G4XXR7+Irm7bZkY94f3DXNMTdxkJGoK1eGGrERIpVqK41QBdjP2MePJ2mabadVskXSgjgPIBe7Ggarp//Xpsq3biXY/xG5M9TY4+ZMcWpOoHHvprK9rbJVmqpkevbq7ETXeAkX2E3b7nflCO46he6c+4Va0p12Aa/gCS7NTmR6BPwSme6NjHPP4tkldBoJSg5bZjQFKF9A7O4H4u4qcmRL7pbreKaLZgAeROje+DUTw7cNRQNHTEp9Ii8rgy3GVQNHD/3W5WJCTOqjGT5a8Iq0skU8cqZ9xKNUKVufcFrZfsHCCT9DGnnqgYd7x12TfiHsDiDEqNC4j8NWAkq9PnqhiW9MaOA83eFPGsou1ksHKjKGG73IpBCrYD5MJjcDCghaJIFd+1H0fLdRKnsNo6+CXEcxU1pIx5REALwQSBaaCjLKli/j/9mYBftFGaC+1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(22082099003)(18002099003)(921020)(38070700021)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sj4JjXkXvpW8N+IzgNJB/HDlQFQYm0n2+3JPRfX0jQv4hbqzVB8LoeXo8M1f?=
 =?us-ascii?Q?L4eRHjjfCkQ01Vdm1Nes7SbH1tmEANw7WeGUihiQgw4wFlCPjlh5/grmZddE?=
 =?us-ascii?Q?foTmr/Qok+dvMMPGBQag/yj15u2OM5bUay89f9tDCu10UqR7N7dfhF+KeoHQ?=
 =?us-ascii?Q?2BeC9OUDBqioRXFPcNEhOkBITWLHufwbFWdk34PIPfGUvzdYjNpB7jPBGhzs?=
 =?us-ascii?Q?pgtHIgyibLQ8PY22QlNGwcYnw11d3mqy2KS18V9gcgS0NGWlfKnLCDaRbAdv?=
 =?us-ascii?Q?gNktjKB6hhadQtCSztyxVhyJ17QlwQAf1gZ/FNGp+iYH7FAiUOM1C60d4B11?=
 =?us-ascii?Q?aVtaYe0JW2+fcfd4QQ27sHyR07poiLu6dF0xNnI4cFiu6xQjxPhPUVEjJLRc?=
 =?us-ascii?Q?z9a4PMQX4D5sZc5e7+1W/t0uX12CHvfSa8hSHqT2N77E6+JMinn5W/APHDWl?=
 =?us-ascii?Q?/P0bfAqlFKotXIVqrMqBq0TBCJ5ByxSIfwE6ne4xAx8SCnPCiqFsqVgcVygY?=
 =?us-ascii?Q?BgRdjfaQiuKqXGUFgl4e0lCuhVWlg9Rrt+5OGsoDEZxnHg52Wz0k3KIE52cp?=
 =?us-ascii?Q?7Ent3zxzXZ1wQUKAbnvUNYbpVfslm62sYh2adOnjox8P5mALW2uT4Uj6ghNe?=
 =?us-ascii?Q?ZwkAabM6ut6Ouv6FfPiOCT/PIkVB9iEx7DM8W6Dy6FABTYTCz+1Enj7Pmb+C?=
 =?us-ascii?Q?Rvezwsg+d+tVNj4z8J36x0QT4dfCsvYTi/UAu3c1+KpKKMmRHa+FuFlxChwV?=
 =?us-ascii?Q?UbfrHvQehaFnJxsgx5u8uILrS3oWMmT0fVpZMRl+w7kUAscN8Y8pdUAud7Mq?=
 =?us-ascii?Q?0HRigM/5aVcVSSXWtB6sQLX/OPODH+6omJHiDPPypGaLVruZuCGLkIqaS21A?=
 =?us-ascii?Q?LiikGBxoO4GYhbwZK0N+iABRnZsvezK+6eWGWiRntScPjg/1qXWh5A7Oi2Lu?=
 =?us-ascii?Q?zWRF0/TYqrYMzpMvU4Ber/7Mok2FrWe+MqIhumCqugZP37NsaYHvgZVSBF/b?=
 =?us-ascii?Q?SulcekUhWBN77L6kPxV6nxG8E0RQJdP9DAIDAmnVHigFpwahLGsPRjjSLt3D?=
 =?us-ascii?Q?nkpnyY2z+PztR0t6OUtpTUu82EQkZfYhdQxPkGBMNucY1c0o4cG2azLhpc+7?=
 =?us-ascii?Q?4PpqOCHPooG+rcmYdv6gimoi/Smq+VywE4y7RWRlEo1+v5oVo71+8podM0Mg?=
 =?us-ascii?Q?wKkHg57GtcrsEfiNOozu9t1G9S8/Xiky+sJzkguhbv7P3FR4JnsXKkUtVPtk?=
 =?us-ascii?Q?wZQCU0N3iNNJxIXPLOrdmOlpRajVj2C17wRsPUAwv35YMYiVM7k8shV051Dt?=
 =?us-ascii?Q?b8qNDqUPqOwir3Kp1r4wwJQoYnVcXOxt4/CQ2R9fSqtd8q6QRH9nOHdypixk?=
 =?us-ascii?Q?48YGLVgInPn5qCPZefbak8TICyoa010Y0iNGEXulL92pF7qWHRRdTtq2jsFa?=
 =?us-ascii?Q?9pSe4fUzrLZ1EW2vbOYz3i7gZ+xHXIQQ35DmaXoLmzeZREZHb6+I82ktiTOi?=
 =?us-ascii?Q?z8uFcKhaKZbkdSg/svkGGXlmLXBC+/ywj8/BrXgk+Ug/mn13ZdKv9d4AIZ4I?=
 =?us-ascii?Q?iWraPksqKThupesQthg5NjFvz7JhtmW4Q7GSTWKZSTfKAQAAjTgVmCannhGO?=
 =?us-ascii?Q?vEcFIEpGvqRmT+TWpzQaS4bS7Y+ExJOYswrmhX415SeZcYgJc2IijsjiIUgR?=
 =?us-ascii?Q?LT+ZHp4ApawiKj3gB10A8TvgLAx1cEVlgV9wwb8BBcTLE8uC+tpxzJRkCOWU?=
 =?us-ascii?Q?ZFr9aRVjCmCisXbEeQ8Lto3jz+upbaI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xAoKvOaPad5huF9DpyAfq2cmSPZ+dpczxfYazSLMTw87M9rBR1hih7nVKZQwrGUznPoRBZNICfyHQPNyRll85WMAKaRtHqS/ExxhBWViRc1/jz/4m/Huii60BXobKpzoHhKOSsOG9wxE1n/4QTSWoX3jH7ShwnMPYI/K7KXEmzpyuDJIF4axC54v1pn0wBLxTw3j9nZ8vRFkjHiXvBwef6vFTizqsySHB67Eqadab3LnNLMXnmLGEoBlcbW74CvMAELFkYxVQU/cLUl2+tO6yMCIZxS2BT0XwB64mF0KgGDQ7Px15oqIEKNeuTZJ3hJKugvrN6jBNMEc3mfbZ9+fkQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eebf644-bb99-4e6e-4134-08df149fb9a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2026 09:40:35.6218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DZbFZrhcAwr+KaG0O3zrA4gUe6910a8bT18QoV9PjaGwLywIcGJ7yue+1zb4XTm/qEm9UTL7abmHKKaOeezl+kc3OzpUz42ZV/TFtUhn9YM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR11MB9798
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Linkui Xiao <xiaolinkui@126.com>
> Sent: Wednesday, September 16, 2026 3:28 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; andrew+netdev@lunn.ch;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; Linkui Xiao <xiaolinkui@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net] igb: unregister the i2c adapter
> when register_netdev() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> igb_probe() sets up the bit-banging i2c adapter with igb_init_i2c()
> before it registers the netdev, but the err_register path only zeroes
> adapter->i2c_adap instead of unregistering the adapter. On i350 parts,
> where igb_init_i2c() really registers the bus, the adapter is
> therefore still registered when free_netdev() releases the memory that
> embeds it.
> The i2c core keeps pointing at the freed adapter, so any later access
> to that bus dereferences freed memory, and the adapter number is
> leaked.
>=20
> Call igb_remove_i2c() instead, the same way igb_remove() tears the bus
> down. Move the helper next to igb_init_i2c() so that it is in scope
> for igb_probe(). i2c_del_adapter() returns early for an adapter that
> was never registered, so the parts without i2c support are unaffected.
>=20
> Fixes: 441fc6fdb47a ("igb: Add i2c interface to igb.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c
> b/drivers/net/ethernet/intel/igb/igb_main.c
> index d4a897a8c82c..f965ca144f42 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3190,6 +3190,16 @@ static s32 igb_init_i2c(struct igb_adapter
> *adapter)
>  	return status;
>  }
>=20
> +/**
> + *  igb_remove_i2c - Cleanup  I2C interface
> + *  @adapter: pointer to adapter structure  **/ static void
> +igb_remove_i2c(struct igb_adapter *adapter) {
> +	/* free the adapter bus structure */
> +	i2c_del_adapter(&adapter->i2c_adap);
> +}
> +
>  /**
>   *  igb_probe - Device Initialization Routine
>   *  @pdev: PCI device information struct @@ -3657,7 +3667,7 @@ static
> int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>=20
>  err_register:
>  	igb_release_hw_control(adapter);
> -	memset(&adapter->i2c_adap, 0, sizeof(adapter->i2c_adap));
> +	igb_remove_i2c(adapter);
>  err_eeprom:
>  	if (!igb_check_reset_block(hw))
>  		igb_reset_phy(hw);
> @@ -3849,16 +3859,6 @@ static int igb_enable_sriov(struct pci_dev
> *pdev, int num_vfs, bool reinit)  }
>=20
>  #endif
> -/**
> - *  igb_remove_i2c - Cleanup  I2C interface
> - *  @adapter: pointer to adapter structure
> - **/
> -static void igb_remove_i2c(struct igb_adapter *adapter) -{
> -	/* free the adapter bus structure */
> -	i2c_del_adapter(&adapter->i2c_adap);
> -}
> -
>  /**
>   *  igb_remove - Device Removal Routine
>   *  @pdev: PCI device information struct
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

