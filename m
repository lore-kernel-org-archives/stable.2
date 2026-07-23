Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B3F3B42E0;
	Thu, 23 Jul 2026 09:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798680; cv=fail; b=dpi32a1kbZHuYa7SAbN7o1KHRmPeqPbL8qNCcsfFQxPv/F4jyCzDlUt7JHnAXGYeTRqEoDmWt90s5cqc0FrkGMxbf8pK/P1tDv+J7a7J/osDciBNBhdkzqB7GuuGj3p5ozGvpkW/umX7zXD51nyPiEOuZYUk4dp53byQCtmtq7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798680; c=relaxed/simple;
	bh=L5FB+pbaTs+PEAoOHb6rIid3Pl6bts0wBM6HoCatBak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cZUgkL/M94GopQa3T2dlRZ0v0sQd13NMhs8JK8Mfp4cWKxwum5Tq8IG7mfCvYGtYBpVFrgeVyG+DSWiupGwCfDDF/k8u+92aJzIriJ6cvS/h1oXZXEIwVDoDJqVZe2I8yTWkoOstb3LJEOG9U1FHqwbFwZjKEId9Z6cpCvRVEBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WMcGlK5K; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WMcGlK5K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798679; x=1816334679;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L5FB+pbaTs+PEAoOHb6rIid3Pl6bts0wBM6HoCatBak=;
  b=WMcGlK5KGjdh5rcOKwQ5fstqUSenLJlt+oR8Iu258/bXX8bNN8lKsk8q
   NiDx5mmMbVzGCwm6thePv+VHFfLCGBqRIadqGmmPdJIUKrQl9n1L2G2d2
   u8ClTXFfc4CoiytsDOUWNdpNE95pZ137HtIiP1ZvZKYsUFxtLYKIeb8Yi
   hhDHsVHBw1OtGjApX6qw/uYDFw62MXSmcPwU8/uo1RSd66orHFzUERNBn
   05rW2Y0exbFWz2lhlR54idOmomk9kkJiVtCX4qX1R7U6CuuLZlOK8bpnO
   a8ymRgUZ6s0J5M2jLFcmEGymvAB/i8z5sjgDYBbDRp9DaEgfZyMtzWFx/
   g==;
X-CSE-ConnectionGUID: pYtHykkRR4KLXOuxMgJjgw==
X-CSE-MsgGUID: jbqIKVDeS76lPHUELQr1eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89342608"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="89342608"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:24:38 -0700
X-CSE-ConnectionGUID: MnS9rHVLRumGa1yAXakZnw==
X-CSE-MsgGUID: M1GWqXMcS1CO7YmwcsJthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="262667037"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:24:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:24:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:24:38 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.30) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:24:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAS23JnIJ7KXeX8eWsS3zJwhm5L8DNXz/viZKrBokj85/VmN8M8AxruRM3yZlgOKAcrGDjitqCdBl1kSa6QEZRe+BIPHVLvIXRnxSRMqslj43EcYkeIZz9lXFpGBbgpX59sSQ9s4Igar8QFyd1pg/ac70d+dA15nnURCsP5QfnYC3O8uCQ8hbQrdAJ7F/CygItyjO5NEcs8DgAQY/WVXnP/5abgYSqyn+4Y42rJZt23dB1KV4wz5Z/L3IABkoLyxSu78Q5ks95FrqnmqZLhHkSE30bS4QfW2DP+ocp6DzxWxVwj3hvt2T5MlokdWsNefurHsd5vzd+/I0GwDyFmBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRSy33IhJyOnjXx+VcmTQv7rQyQDjqXm40YXlcwGCLE=;
 b=zFfUAXgKB90LoK8UT1XCl6A4fgFWX2n/XbguYCx5U4DCdham9cKOalHrxCHCedlKdaGJGAMVOitOzkG/64YsJ2yQVQFXpRArTaCXyHeJZzsVCWOO5pekB978pObZcru4nQhY5NFtxmlCZiSFR3+HmiyzdWHY7+0/U3T1L7sRxlPPF0TRGA56IYQYlIdQYCnJAJlSbeHz/c5r6SF5oNRQOThWEeCKOBFL7K2OBuJuiuP8K45fDz0b2UgVtfPQrltVg4N8XOrrx+CgvpZFNtEZJHowWNHNp14eECXFjhuOQ9JRsSo0R7Ps4xZmO5c+7yprYr05IE3b1Flko9d1R+gWvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:24:27 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:24:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "xuanqiang.luo@linux.dev" <xuanqiang.luo@linux.dev>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Jagielski, Dariusz"
	<dariusz.jagielski@intel.com>, "Jagielski, Jedrzej"
	<jedrzej.jagielski@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Mitch Williams
	<mitch.a.williams@intel.com>, Greg Rose <gregory.v.rose@intel.com>, "Sudheer
 Mogilappagari" <sudheer.mogilappagari@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 2/2] iavf: fix QoS
 capabilities memory leak
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 2/2] iavf: fix QoS
 capabilities memory leak
Thread-Index: AQHdFDPXNh51Nm7MBEGyOpzxF+dlnLZ64Z8A
Date: Thu, 23 Jul 2026 09:24:27 +0000
Message-ID: <IA3PR11MB8986ABFE9F2E962D976A0A8EE5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
 <20260715082548.56687-3-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-3-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: 8533a52d-7b91-43a1-2be5-08dee89c318b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: XSc2ucca0/DMIYlxdYz08toNQc+7Y+9wMWpY4mqO8pgN5U1mytrDXKXTN0F/bZPAb/iVhcQon0EcXwcSygYlJEsX8mSjglnkEI8QFQbpE5DHZdYewh1dk2k0ZBv48VaaiGdbDqhfkIc/APyW4LTWonxpIl31PL00k+/upRaIOPfBLvHxqGqZWqpQEvmrdBgmCDzSLIbnUV5k3+RjVFROFy0NpavOD+H/Vp0I8KT4ZhzDSWPyHnC+PNGQMqVk0BMzGCxhYvBSXiYpXt3H3kfnfXHAm4gQCkKlIlgd6+0R+KKxhzR9Mb4AoldlekocE5etCcuOidAB3tPqoknzslLYOgHz23La45Ezft0QCR1Wa/881sC/HZ3TM4H01pdsnmSU91J4sDGoZvqVgC0uzeGUM2pI11nmL5ADg5AZIELl3z1hD0ldSm7I4UhlcWQj8gGDLL1xfsL7Cj7Fsnqs2BUhrvvgcaK20/vmvBdLRC2kZdwrOQ3ye2QhnyPRnzMV7ViHlLyO0jJx8Dxae1scUWcMHCZd/rIEwcDWz5zB/DAFQhkqoir9Uh1h/btdD3SB26cxTOB7yE4iDIwOQysBAw+jctfUx6gOCy8SIiIJ2Y2Ya1/Wu0JIU9wBpI09Z346zI6uxjkjoDZlmNxykFWK1NfOCSNbjcK1pwm8dL7clA/0YwtKtONmfAQ+PuxM+MHIk+M+u29E1GidgqCL9mkZCmU1LQK+Z7e59tM4TIOqgcKQV1Tth3OeHp54CsrgyrD+aHW3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vsu63wSQ5e8qtOiLg/3EX8J2vb2UTTnuJVcLIKaDpC+TxiPwbYQFe3Lkkp28?=
 =?us-ascii?Q?Z3kxFTYU0G8mMSKLINgUUC0pizttuRRUSUJWKboNB2/P0MCSA2yOH1dBbmhz?=
 =?us-ascii?Q?NrjdjFkWVUc5cUw0qJVrhXEZypxAFINzlOPsTR/bhdDpNKH2tOI8Y+KvVKHd?=
 =?us-ascii?Q?bSysyZ4vv8Hqq4deG/6nNBWvm0tlhBEFWFXeM03w4oFja3kKSJbtR/OJAlpY?=
 =?us-ascii?Q?x32vHQ1fgrRORtfpRtz/vknPbiX+FEG4zDTtBvTxRfgUYMe+kwYrydkIkflT?=
 =?us-ascii?Q?oInIY7nMsc7knzIY+KistPdHcZQibn3HmBfmqvwBbJtKcDtDA/q9BitkN2hw?=
 =?us-ascii?Q?pF0NwF220351pJiBQBZLzQli3SmFs0NF699Y02le8bgHkD6pDzm1HmoteF7b?=
 =?us-ascii?Q?XyfYREGzecBApEs7+HW2TG/hOqKN/xDwDruKbu0YtKGYEzgRfz3YeMYQ7MYk?=
 =?us-ascii?Q?+7U3P+uZcBU23Uw6zXMnkMJYnE4dg+tDlcLg5TfJ8/jnRd8Hq4gyrWQQ4s9m?=
 =?us-ascii?Q?6MrjX6NzEHd/Z1k8P2nLwls/OFR/+z7TW+dFY64B0D/BeWZZVrW/AvZ/42eb?=
 =?us-ascii?Q?uHDIwS7GL9Qg0uKTdsD/jGmXgkB8f1VnZA0Ino//aey9uItwPGC2zx3Bte59?=
 =?us-ascii?Q?xMBSwdm+iz4KE3Ven2XAAu9fLSP7v+USVFkpNWtAIkxA8QSy9k6IMBJG1Wlt?=
 =?us-ascii?Q?/HcT7fygiVR/S/6PgyN3+gjRkEcuB/fUB6ENn0w1g1HA5MtAqRMcWkvIGLtR?=
 =?us-ascii?Q?rVTcsovWaSvUCkHtfABIumLY07L2gkunI9Oj7RTZxsTFEH9c98azL/2y1okh?=
 =?us-ascii?Q?QIYsaepctDL613sJYl+mzThjeH4yawg+JT9M/qcz98yM9zVctp5KwL4KoTUS?=
 =?us-ascii?Q?N0JGcgC051Zk3vIpUazzyPSENSja5ISz744i2dpnNf0Y+0pdNVN1fMNB18fZ?=
 =?us-ascii?Q?DB+dmaTzgInbJnb+dtWgcoUzlVJwAVZ3J1e5dh+ivaJExyFWCtq2I6qhiYLB?=
 =?us-ascii?Q?fOHk5D46cGdU+phpgkQs75won3Jkz1ysFwOOZy5v74L+SiV4du+M7L9sxzkt?=
 =?us-ascii?Q?RKnirjDwL6mkCXAwJFvHudZH9NIRYl8d0t0v/AVmWpqxUM3HodyR52UDpJ5L?=
 =?us-ascii?Q?cr174fERTvD8fIix9S1Ifrbczjx6LpLWE8dqN+ORb1Erv3Q0EPnwBXsZ+POf?=
 =?us-ascii?Q?AffV3uCu3sutgMIneNVJjyycFmaSt5vh7jLqS9ZSooWJF7eRYFEA0T2bpqO1?=
 =?us-ascii?Q?DiigA+/EOQFzihilgRonNtoayyim1dj52vO06cXfawzOS1dBK1NR5RH04jcK?=
 =?us-ascii?Q?88kikYR0bUglSAVLb4XQidXvBTnHKOe2RFj3IirSFPvPo16rlXyAeAjeqxrH?=
 =?us-ascii?Q?D+HCCi0y25eiVT8zdcFq1ABdujw2FuMcJWtq0tfIyfp4uH9AeBVnqOar2Ppw?=
 =?us-ascii?Q?rOy4cEd4EyvKfGAAkPpUhylsbdDkI3hLM2KBp6Dh69PtDB4yqunIgfB37kor?=
 =?us-ascii?Q?PompiZzpyQzRuqnSwXHruBQb6SmyuoUce+7lfTOLs86AU2hRn/q90tRyr153?=
 =?us-ascii?Q?GNjO+JtYEcAtXNi8A6KAZGkMTFijrbAgRlOabN2NIWVBB8mQGJtkSltZnynf?=
 =?us-ascii?Q?Wel1wvFTyp3abridrQN66gyamRWWeFLUFsZKQ94B87VvM+Gv7TjqqHR7posE?=
 =?us-ascii?Q?rcgNAgWDDbuauEnvfJwF/CLz/gZmyx0Ei25kZc4rhcWiJThky+3VPfxJPUFk?=
 =?us-ascii?Q?kmTxqr27NKqSt1jTS58NbZOw74HlOVw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TKb+pme5wXpOcnhpi/gNyvSwqe20hjTiJlVNzFg6EkYstx7YyiGUB/AS6EP7P9s8ruRmhRMfeiw6MAlw5AOrmYizOj8oNyKAy0xNbw46cIHav/1kV1t1GBVpmYaTqM3tGbIpmVNrpvv97gqL64D0/C2JyYbd6H8MF2cmwvj2tFXe6wVELw+KYRT7crUsf38m7Ru7TPY3w+Osl3JaNxWkPnEGGoqiF5pF5el/DFKf76QM2dnejvkr8XtepJF5Qj9c+h57SOw0qVJPIfoMUReTV7sJiBJ7UGcEScaV9FD5DVGbJBvlF99b4MyVSie1fnPK4gha1V30E5r19Sxz+U3JMw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8533a52d-7b91-43a1-2be5-08dee89c318b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:24:27.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cjGz9lwcmp3AJClTbPp3n/BZeXL1b2F2ywjjGpZM3clkYyYvkmadUj4Aexeb/cvvfEgWJn7KUtHjLFfBBn1tyYJiWjanb2J04P6uM4hl2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7628
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of xuanqiang.luo@linux.dev
> Sent: Wednesday, July 15, 2026 10:26 AM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>; Jagielski; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>; intel-wired-
> lan@lists.osuosl.org
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; Mitch Williams
> <mitch.a.williams@intel.com>; Greg Rose <gregory.v.rose@intel.com>;
> Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>;
> netdev@vger.kernel.org; Xuanqiang Luo <luoxuanqiang@kylinos.cn>;
> stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 2/2] iavf: fix QoS
> capabilities memory leak
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
> allocates adapter->qos_caps during probe, but iavf_remove() does not
> free it. This leaks the allocation whenever an iavf device is removed.
>=20
> Free adapter->qos_caps in iavf_remove().
>=20
> Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c
> b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 29b8403a066bc..c7f69a9040588 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -5589,6 +5589,7 @@ static void iavf_remove(struct pci_dev *pdev)
>  	iounmap(hw->hw_addr);
>  	pci_release_regions(pdev);
>  	kfree(adapter->vf_res);
> +	kfree(adapter->qos_caps);
>  	spin_lock_bh(&adapter->mac_vlan_list_lock);
>  	/* If we got removed before an up/down sequence, we've got a
> filter
>  	 * hanging out there that we need to get rid of.
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
