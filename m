Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7982D37CD37;
	Mon, 15 Jun 2026 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524811; cv=fail; b=KjKoSXZEtgvcLqfctAkM6PhqFh5gpdF/5ywQ6dXUJEroBq80Arw0UDPUYPmhzATWnUWyZKBc++EU7hSdOyysu8JQA+NSnMMcLTFf+dXsyRp5btpPrSYACafFAU5F36+r1VJJUMe+PtmFNPd47ImYJurg+s0Lj5U2sDkEXFTzPeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524811; c=relaxed/simple;
	bh=X6OEDYa4KInAxRbaA3tIaNUoTPoz3UGaw/WqPY+rwME=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gElTDmJ5uAQXrKWyp+hYIW8VBDwY6xIAULKh7LA3+2AC4u08MU0Q3hhUSAKQyzH69X8epTYbqJHHErb5cndtHTR78Y6azm9ZaRew07Y7YNVYlCl++vMxarJOelFOY8Cb9Hv3tf5pWxrdEAOZkBJjr+AmX/3fVLOj9LUwTqjH5Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIeJ/fTm; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIeJ/fTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781524810; x=1813060810;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=X6OEDYa4KInAxRbaA3tIaNUoTPoz3UGaw/WqPY+rwME=;
  b=PIeJ/fTmaLu1kIrElQtqFbLGXNZUcBKVC/5CYLdZQLlR+ekoq7h0m3bh
   R8+PJ8bqHs0BCIq9TmQuJDPr8D9e1llwumFZkgEnPugeaadThw9sbYu5L
   gfbfTW6bY986iApTnxHXF2nj6Pyyue+XbFYdL/3TRdexDIjM+we/N586S
   S/RGL2pmedzHzVXmOq9H9DOZvsttglkjyfAinyiH/4NZ/ppyFlu01Gn07
   pnFxDvjgG62ZRJKAiST6ZqI8XO8X/S1d7+SO3JvKozIk1VjW2yt+WgJA3
   GAJK1NplwNX4FFiUHPk13X61QwQrTtfNkQXI08/qj9CLcF9jq/zxocUEh
   Q==;
X-CSE-ConnectionGUID: yvV+sLePQOqQcVQLRQHHfQ==
X-CSE-MsgGUID: BCZ+HHP9SOu3gh0DOa+0jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11817"; a="82246826"
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="82246826"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 05:00:09 -0700
X-CSE-ConnectionGUID: ObGh+DHoSJio4uxPdpA9GQ==
X-CSE-MsgGUID: 8EphysPwQZWnFsqE6rCwsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,206,1774335600"; 
   d="scan'208";a="243091070"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 05:00:08 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 05:00:08 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 15 Jun 2026 05:00:08 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.46) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 15 Jun 2026 05:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2A4C4MXnuSAd8Z0M2j3WZlgxLGMQxot4OdHLCxGeK7yvW5MzWZIPr60xf0qC9QSiMImRW58LCulUy2vfTVlXIW+MufWfasq6+TgrJ9BhRWu+92wc7LKd1o2csTNkWSkWA+Ah8ddRWC6lM+XvokiCxF2CSKvj5G2u3b9rSXM1EhZuJM1dhO3QfNJB2CzQXlPHO56LwWUx41iaaBIiEqocidzJYg2N6pcFPu4r3j9kP8IzGE9fisvpdsqvxM/jrVlAE5x8AxmvlWbdT2vF21fwwM9+PXv5GxuKxB5R88Zgh3nFiRDCzp+MoNP30kStDVFIRfLeeyp2gETnBjIodL54Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EDj3Tu2oqAAXLo/yx/QcAM0jXGaUaQv6E3bX6RFqCo=;
 b=eR14jh5guLaQFNZdCtRxB8Voe6C6so8N+1G1hvZeWfA7lgruXd9Snp/x1jP4E9dz2encUqIV3QrQBeKsaTnIPN6PGe5qTj+3wZ0qOmD09EGpvCUivyqvlbeupnHtNjOuLtsslC/68fvojPdejMPfXsAJxnoqmTyzUFcaICaJdtvcFwZivJ2UlBtJvDZUgTeg4+nwBJFVE64Lw7paoZzTPvgDF3UCrZTGhS0xCVOCFXGSTzqmR7zfpWRdSaI0aRqKkccYpb161IbuwsX+WhYgqL/RPonyWKUSLcZvD3XIiaqL9cewB3QAESwb53X/5hR8NtG3KMqtOUjgJDKj6iQMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 12:00:00 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:00:00 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Dawei Feng <dawei.feng@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "marcin.szycik@linux.intel.com"
	<marcin.szycik@linux.intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "zilin@seu.edu.cn" <zilin@seu.edu.cn>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
Thread-Topic: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
 ice_lbtest_prepare_rings()
Thread-Index: AQHc+b3VGSuMNTsboEqIfmSNMe8rubY/iW7w
Date: Mon, 15 Jun 2026 12:00:00 +0000
Message-ID: <IA3PR11MB89861DEDD0C74E75AD9E3579E5E62@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
In-Reply-To: <20260611161204.605962-1-dawei.feng@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS7PR11MB7858:EE_
x-ms-office365-filtering-correlation-id: 60a8601b-4abb-47bb-3d8f-08decad5a06d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|23010399003|7416014|1800799024|6133799003|56012099006|11063799006|38070700021|22082099003|18002099003;
x-microsoft-antispam-message-info: KIFIA/2dimDsQLPvM8p4rhgu+dPhv8IyFI1uZrK50BaCy/bjrveZ3vPHM37lpy1WuATt8q96PcfIxgW6Y73/6DhQmJaVV34Q8Upcu0HUltXdtFXpncGPBT4i33lT3Vp5JWMF9+AXJQkNREi+jvOuooGoEos2bYnx1JjROaYIPygs3hANTqqEpc7n0L5L8XZlmSYSfFsdzSQByTLXIOKFsdvoyAp/Ck1HZ6t2MJV/OrnhJjkO65bk13bGte/9s59YFNgSYurwKBMzuI31sVeLSYi6EuXYCYvLR0WHTqkMeEoG0A7FOXjdiMWF0f1S1tpsUVco+17rjGvoeJhauqGvFfCMjeOFU62LBG9e/qqW6zG/Ux1aWeRAtCM4w5GM/NiRz92FcNQkZWbprnAf9Vz3WVOi6mP5+rFbjsoZFUlm7j6baYW6hsawuPPE0qcIGQbwaZMVI92jyFatb4CXydw326IRYxdfob/SCxeQhhxz+VXdeiJiwtwU/y+rGNvgqpnY4vOcH5H9NjUyjfxU9P+qLrk7qfdCwl4nqIEOLNAZanEljsUcquHKNT8lWO09e2nFJmDmlxDyPixoIvlBlzwtD3YmWqSLlnE7HfC87YsG7peYRylTQ+8kovIfCdHQPvrXTSeBvrOjdbsALrQ5EkKya1sgRnhmesJnIceFdxM8rr5wuX3EO4XyGMNXF6FQ/SKvq5bOsp9mUC9ObHZ7y4zwvK5ePPMzvJOQbr7z6TAAECJW39DX5JhxM/7oP6HC8N0R
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(38070700021)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PDlliZYikd0woxjj92oZRFoghwrXYEdzeegzOg7+3Mt0cdWMPXv9ALIgHOEl?=
 =?us-ascii?Q?MVMCHh6iuDr0Z7gCLaXz6Kx7ihl5VUntGCc9L9UP8aapJmYBxf9UOxON8YWC?=
 =?us-ascii?Q?rxotPMhiOPVcq2vbPXXo5JXMt5I6dYnQQtvCNvv2fOcKv00sHIHnKXMiwNEp?=
 =?us-ascii?Q?Q5ebzuxgk5hfphzbONEBBTEdF21ZTXchLj6890sodIepUZC9iW1M1gfiqAex?=
 =?us-ascii?Q?LqMR87cqaHgFz+W56TBWrosaz9UZtLdG9vKpq2TPI9Xbrg9rCwbYBHMVpOFC?=
 =?us-ascii?Q?HPCSL3nxIOcOPaN7Ol0vsIVoI65ygAYqngT7+mgkf6ChVQkx2I3Fz6iHfDPG?=
 =?us-ascii?Q?P8JiTAy78NG21v4PVlqMdc/WbwwNaQt5Lvo6O4xpEZWoY7wpwZJUdd4C32eu?=
 =?us-ascii?Q?zjYRFMnZ3JP8Qj96dIhPsWStX1kLxplfzXUw6+b4tj7ahdflqNA40IeFecj2?=
 =?us-ascii?Q?ykpUqga3m0mqvvFjVA4MEdxwXgcUYmHNjroQy0wJVz4Xw+ciu0gTSSouuZuG?=
 =?us-ascii?Q?lpcdjXsoSIv1fSS7aF3fieNc+BlehSEQMbeeSmhOJPYj6cryGp+xsuTQOk7f?=
 =?us-ascii?Q?jo088+8rSwt8wRQsL3jT/1iWtfjw41BuPpcFCb+mgwD5QrmE+wT9W6rNMjCh?=
 =?us-ascii?Q?TnyHPXwwIjY5Kw8mhUnbR4A2KvDdywVgqVhAtY3Gv+GmOXUDdr/YMMht+nE0?=
 =?us-ascii?Q?ukov+0q0m+xclsBfXhOxDbb22Jw8yc+/TZyV9+AJt4SjU8E2xXg7MRh60r0x?=
 =?us-ascii?Q?lKEFnfP2E16tYvcI48qdBMCRJrHF+poAVqIxH8yGmJb/GsCIHRK842OnTi0W?=
 =?us-ascii?Q?1Jv14rAzuDjSb/amUBbSYc+h6xF2X/d6T9MZg3v/S8vUnN21HpcD/PvhfyWH?=
 =?us-ascii?Q?jl/CpVxv1qV9e5meVwJrdqoQ4FCrS8fZgZ0LWSCd+MH1OvN0bJCQ/bibIecg?=
 =?us-ascii?Q?CX4/2gH7LxkcerGgAzrPayDtTtZLptCZp4oQL0isdHPyGbFFkJIR6O0gwM2Q?=
 =?us-ascii?Q?2+cQtC1gOaPmExx1QQIXNimnsVsmtu9vDtmCuXzKJ0A53wz093ZA3Yrtf36R?=
 =?us-ascii?Q?9+qm5mSoGrVTGxBL7XY85TMn9B9KDwqzvKJ6Ip07EH73yLEcbiothO83DFOQ?=
 =?us-ascii?Q?wUefT9SSk2OoWMoakSFi0ejz9O8oEysUFwVx88zkAk3vU+JGVuvyx8Ccb7FS?=
 =?us-ascii?Q?97gbTCSKGFHg1uAu5DmgkS7Qz5abQtmgILcUPH2jH7C76M/oODk2KguMVDQ9?=
 =?us-ascii?Q?JQOwtbT5aG0JU6GpHOejeBvUlS9Q8PZij9vFGGhQuaKlIPtzfRBSz57ug4EX?=
 =?us-ascii?Q?iTMDi2m8u8U85Etw7FGbl2tXWvzrwm1/691ApKDenx9dPePFIstJwubqBRf2?=
 =?us-ascii?Q?OUjkVOT1B2avVNDmz5Z11o3e88ranBcI+JIiLQS5vLErVrmsX0fePTGeoEa4?=
 =?us-ascii?Q?CbWt7vyFk1ORPOKI1g8vK4HJ9SvhXpZpxMOI3ngEfQyZ1gnOfUWLb9qoqJ3D?=
 =?us-ascii?Q?5x27wCt7GmfipWmK2KsA45vBbfI0rsiSqktyaSyBmpf9tSQuzjeNh4hqkaUl?=
 =?us-ascii?Q?DzlWxD1vpQGoN19zHY/SBIYMVLROniq4gCn7AeKve9MRZeouY1rAjDCH/0RB?=
 =?us-ascii?Q?rC9DPGHqaqkwrRPraRAd9vmDm3UQjjkojk38MU7HZwxkaN3ZG3DT2dgjjQdp?=
 =?us-ascii?Q?TA34Fm5ehkqcqWqgjEYgUweXB+JB0MCRFhTsHZjwcTqeR47f6l/dB04VAuhU?=
 =?us-ascii?Q?5RiZ5/FLFDcVwodskelfv3EEMtig+0E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TrxsxSpo/Qs6hhaH2Jbl+jKOBf9y4KYt3fwubCIa+BU/BkBqLMzU7kO1kFc4WEAoqaadboHkj0FwA8tJSbM2YcFvApofKu64r2NvH25TngA+Wm5a8hqoMr6u6aDIBwn6r1l3y8BQtytfkc9NJsabYnTGt96dO7CrdIHquBobQ3lXsEyOpajKSLvNt7JILdzrm6i3V+etTqlYLp2EpM7NUfB+BMWN8CgMXnEoOvh1Tw2D4mQrBdPswoWrjwl7V9CSfCT0VKUAsOlw1mFEwGPrZoTIiuDJvpfHQTlYAGkWK61kxsX0Af6dgYEiAxb540wu3DSfGY+xLxv2s5hG4gO5OA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a8601b-4abb-47bb-3d8f-08decad5a06d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 12:00:00.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CJCDVJi+PldaTmH2lbojJIBoFTZjHSph7WlazOVEqorKZ9Ozgy+xSdHYK4j65UYDhCF1mdwM2PFFYxd/Rcm7B74lZTwLaZOXmsE8mmldWYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Dawei Feng
> Sent: Thursday, June 11, 2026 6:12 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> Cc: Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; marcin.szycik@linux.intel.com; intel-wired-
> lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; zilin@seu.edu.cn; Dawei Feng
> <dawei.feng@seu.edu.cn>; stable@vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net v2] ice: fix memory leak in
> ice_lbtest_prepare_rings()
>=20
> ice_lbtest_prepare_rings() frees Rx rings only when
> ice_vsi_start_all_rx_rings() fails. If ice_vsi_setup_rx_rings() fails
> after allocating some descriptors, or if ice_vsi_cfg_lan() fails after
> the Rx rings were prepared, the function reaches the Tx cleanup path
> without releasing the initialized Rx resources.
>=20
> Fix this by adding separate unwind paths for Rx setup failure and LAN
> configuration failure. The Rx setup failure path releases the
> partially prepared Rx rings before freeing Tx rings, while later
> failures first undo the LAN Tx configuration and then release the Rx
> rings in reverse setup order.
>=20
> The bug was first flagged by an experimental analysis tool we are
> developing for kernel memory-management bugs while analyzing v6.13-
> rc1. The tool is still under development and is not yet publicly
> available. Manual inspection confirms that the bug is still present in
> v7.1-rc5.
>=20
> An x86_64 allyesconfig build showed no new warnings. As we do not have
> an Intel E800 Series adapter available to run the ethtool offline
> loopback selftest, no runtime testing was able to be performed.
>=20
> Fixes: 0e674aeb0b77 ("ice: Add handler for ethtool selftest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> Signed-off-by: Dawei Feng <dawei.feng@seu.edu.cn>
> ---
> Changes in v2:
> - Fix cleanup order
>=20
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index f28416a707d7..10a4abc66974 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -1069,18 +1069,18 @@ static int ice_lbtest_prepare_rings(struct
> ice_vsi *vsi)
>=20
>  	status =3D ice_vsi_cfg_lan(vsi);
>  	if (status)
> -		goto err_setup_rx_ring;
> +		goto err_cfg_lan;
>=20
>  	status =3D ice_vsi_start_all_rx_rings(vsi);
>  	if (status)
> -		goto err_start_rx_ring;
> +		goto err_cfg_lan;
>=20
>  	return 0;
>=20
> -err_start_rx_ring:
> -	ice_vsi_free_rx_rings(vsi);
> -err_setup_rx_ring:
> +err_cfg_lan:
>  	ice_vsi_stop_lan_tx_rings(vsi, ICE_NO_RESET, 0);
> +err_setup_rx_ring:
> +	ice_vsi_free_rx_rings(vsi);
>  err_setup_tx_ring:
>  	ice_vsi_free_tx_rings(vsi);
>=20
> --
> 2.34.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
