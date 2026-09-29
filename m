Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D49395AD3;
	Tue, 29 Sep 2026 07:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665565; cv=fail; b=BrPbCwIjNe8LbLrik2+JyiU7gy7yvxtxGyr4x4XN2VddSA3dm6tM1+DAcYkHOZSuCNYLieUZo5PrKbL1BrCpMLmcs4KsTeue101UX1wiKKkgqSkSkxyBnp5BPqtuRPlP5lDjwKXKk+688qATFEtIpYo7DHT7fHA0Kh/W/EakQ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665565; c=relaxed/simple;
	bh=uSmVN5T/eWDAZDSJp8gbDnE0GaPykH6pvJRRgLM01+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmh7+djo5bijeQCf7S/JaBS7E3v1dxS/miGlRFJd6jx05gwuaPg+LwSoojE0dD4uuhIVLDI8pJcGGlJQzxDybkm4J2ZmzKFP8rlo1zPtd+7WfTpmvVB2GXciesPnitKss6AdgrxngIQ3phWmr+CCV9DS4JA67BWs5YEs67+kcOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h2v/upRL; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h2v/upRL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790665563; x=1822201563;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uSmVN5T/eWDAZDSJp8gbDnE0GaPykH6pvJRRgLM01+4=;
  b=h2v/upRLXPRGR+/Wk5W1bvqdD/ARfVMEFvQ7oH+qvIMeYPeZzeIBW6CZ
   j+hEr0rzhZyKJs56ujSmCsJIOlnRKoqytdjKBeOshNhAbnY/4zI5oKzg7
   lo/poBZsUnTa3H4XMswlbrRFgSFIXVkmPVi0CrX1z7G+J4Xd8iRX0YgEs
   iAM8IujCMK+t18n0uRDr5E1NXGxcyl07klIYD4hxjO8jLIV6yzitc9euO
   Z3ib1U7R63PQBrq8mG2XiRLUPr3iepIbqrBFyAwu2E9e/nk7G4NtLlrPc
   nFLVBKeC1mSZ1VAv4ZSt8JkLodBUN8rWBhaKYHxkmDTPBsqpQG4yzCFF8
   Q==;
X-CSE-ConnectionGUID: cawcdjGRSs+CtBiQPp8caQ==
X-CSE-MsgGUID: zHYpfs6JSyigLSPGoOurWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90506010"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90506010"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:06:03 -0700
X-CSE-ConnectionGUID: xOHc1UF6Rc2JoSWRjUB7uQ==
X-CSE-MsgGUID: H1gM2MRhQs6t4b2pLHZYPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="313233171"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 00:06:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:06:02 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 00:06:02 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.49) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 00:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJFrdt+ksSHObiGGlvm+4/jWGWer5llz9BF3Ak2dBiGDM60StSMVl9GLeLHGzJs9RyvhtRtqSt2xQMpSLyHsjIkDPzIEsTimXMY+TeGN8QXE9Qoc+8y63RyO0rUYh1U8XTwOM7joIy+NEj4GqGOYTnArbgq1qxoyhx2YaIJAgiO0Gsv6JycLa8xAPHkJwxfLrkLgmuVoeBCnk5Mag9mevwghI6Lt4a4PErIcYfZPqJiH3A4lWgr36ulaHpaOYAesr5EK82pFWGlOMZihOlQIxZQxBGvwNGAJcZI8E9vBOmrB21YS0jF5gGKNzYWj/dgE917xByFqnHkwFK3A2Tm5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QiXQWTzal2TQsxYZt24mhvX31R5Vm65qsBG5yz2cIWA=;
 b=pOAo0dpPQdVRQhMBGiiLppB0hHGPDxt00lyQX+gk9N/4Kk4Gwc/V1NVwd6uTH3zBm4f8eVaDOAnLs+09uTPcysFvd68APs+XhaxT8pPxfPMAtPhXhVMyVoEut6gXOPHz2zRfm7R3/d4NGbx2Gdf5IXOnWglR6YKZhm6/VXnvUB1N76RaTDochIQLl4PctUzAyYKhfxFIEXvF/kF4m7skf9zzhL/XNtno3fXS3htl1sDDWnWM3G/TpmRQLn1AxIaykefBOrnORjemXXXO02+bbQ/I8isVf3qe0/qArgjQd5IcqCpubQM3Ia/By8TWLOnUalFSxfgAUhRqFtqJmCQT1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:05:59 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:05:58 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: "Craig I. Hagan" <hagan@amazon.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Fabio Sabai
	<sabfabio@amazon.com>, Matt Vollrath <tactii@gmail.com>
Subject: RE: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
Thread-Topic: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff exit
Thread-Index: AQHdT406ttcyAnMXPE6zqcyOO8pjAbblIsaA
Date: Tue, 29 Sep 2026 07:05:58 +0000
Message-ID: <IA3PR11MB898645A3712F13CE8E6F0B3CE58C2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <b6db5335-cb5c-4a91-b823-1a114fce75a1@gmail.com>
 <20260928210552.13266-1-hagan@amazon.com>
In-Reply-To: <20260928210552.13266-1-hagan@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|LV8PR11MB8511:EE_
x-ms-office365-filtering-correlation-id: 43e896b9-5ebb-476d-3c97-08df1df81d29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|4143699003|10067099003|11063799006|56012099006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: tmLPyv4pWr5pf/okURl+JnfvggWXub6+YMD99ecRkPhJ377uQo15LyM1NpqXat2xB9Kbkg7kP92QQsI83bqea7UhJAJ11FqvGoim+dVSbYhF9M1SwzguWtJizjXOk43UqlSEAKe1reZF8iLAKqCxb7tTFUR7b1mb+bparSmi1v+/rSc1GJnkZ+R/kEi6qYgdg5nvKN6rYBZpy0fmy4jbrkWuznC4kj9ftJG4FD2uweFDXBSUvXgE+lAeam3BzIOvZtjvvT0Iyz+uwUp76V+TV/N+7+SH2vh1N0WJcQON33llY7FY4dZHdJ1pCm2Upgg9zsJY9sXrakspPjoO1+BYQY4SVoE8/NNbXAnK5ImXswerztrcYOK3OpURH2g5tb+aJ7th24BLNxj/6rQ0jjQU1x4VUdWsWCRwi2NIdCSMLvMjr9vubwQOQNDPbYvm2z//uMJr5Y/RIjrZsC9TkaER/JCSpCmCR99uhnlHnh0AkoiEIvfwKAkioUYGXLBHctP70V/0Q6z4SAhTSVyn26NAQsS3i3/tp/Gu34rLdZzpidHJSQHWPk/7z1gkmcxtP40br66FbzAHcjA/9My8QVeN8tNcoU6/DHviOUODw+NrdQsgIEPniQ01yflgjEga3QpCnAn0tQAPh7aoMRKlbAzJ1RkB5zngJDOLopB8cWo2uO3+sZ5ObjdwDwOBr9lNaA46
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(4143699003)(10067099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?clkNQcb6NLfRIPH4uUdtuqq3S/dDlDHHADTKqqZdofYOwXkJomia+tqs4aGV?=
 =?us-ascii?Q?rVAuZrBVPY0lphrfYuUv8Qf3ZIPJwEev5ODTo0MGD0Zw+zQx1j0MU5ABoFSd?=
 =?us-ascii?Q?zlLuqldsbH7Kd5ATjuL7e+TWc4gfHwGXa1T9yZqiqoejwtuzMxXqRTrO5O/f?=
 =?us-ascii?Q?6OrkLhHav8s5h38GAPk5m02WmqjQipWyRayFkxp3LsngcifNVG5WhnbM0riE?=
 =?us-ascii?Q?Y2NK1d7cSRl7mnjFnprXzKumDB3OF3K6UTdXxXgVii+aH1KH7Ya2ejoXdWJZ?=
 =?us-ascii?Q?EeTMPSeULuhERPJVrXXHz6Xb4gPDn+/RbK+vlZMszHt3jo3tW0RLAIvJzE8j?=
 =?us-ascii?Q?0tuh5e0B7tkRqnzfSVaMhRdm8oNCASlQInLNRkgWjVGNV1vVKuVKp+5V6d0C?=
 =?us-ascii?Q?i6242ETRkIaL5egO1DnvHSijRM2owWmxXSjVd/kbJw2LeMKYiWWacmoPTw/1?=
 =?us-ascii?Q?Q7O2cmqtMa3rPCi76345ebqc7Gf7CahPP0lXVs1BxfSNQDTTuhAg5DZ7Fk9U?=
 =?us-ascii?Q?IwDUUacfwAJsB8VEOlvup/OXFmfx2Sk6Hjm2faOycp5PA9QZcJrpHNXJubm3?=
 =?us-ascii?Q?VpgGxpa26B+g3ltzTXQ3AuxVaIz0bEKobZ+zlU8ORVQd/KroUxuq15UJthOF?=
 =?us-ascii?Q?tzyP9nZ826StsAqwDY1Y1sueXeHfSEppnxM82LYk94bYtLx7UZAxrarl7Pce?=
 =?us-ascii?Q?spDi8CpWD3xSBx+eyXN/h7gntL7CE0eF6qjs5j0oQWF4L5v47P0Q/6lEe2em?=
 =?us-ascii?Q?tg47JXozth9EEvZJt81Cy4CUj5Gn2p4mu3/fJh0di9xFccSawAwIUe1sYQK+?=
 =?us-ascii?Q?xEoVExHMktfQAC3Zv/T4NDmT7jg8YHo4uzhxDNX4q89bv+rnP0JcgxI92lsk?=
 =?us-ascii?Q?jgz4IMAH4XbzLS0PgLC/+Y+Un0x6s6kAVT6Jia/HvcsnN3WOa+jXlfE9uIh/?=
 =?us-ascii?Q?LYSLzfnOgslNqCXR3G6Lya57oAv9STsL5r78vBUns7TvE7eR6nJQAmK5kMnI?=
 =?us-ascii?Q?ibtsfCY+rNeiRJi3OGd2g0NYsL/vh92pgxfiQCqDaT55qTAo/KUGNk9eURZC?=
 =?us-ascii?Q?t0ti6C94TUbrfxbKXkEUvxbkyR+FT34dFGxhjAPrC8fJJK0mfDjp5No3TWeY?=
 =?us-ascii?Q?uj1oKJewMcXw7aOtX0LXAvRH/sHsHpuD+dSlHaAQ6z5I1H83Vm/PS/vxV7wM?=
 =?us-ascii?Q?StW0zHYxtYIUj5/TZAlrdf9nTY3jL0JOxuVcvEx3soh92OHr9DzWaGfrqIVg?=
 =?us-ascii?Q?tmraafJ/F4tT/oq8LadMSN5rUAYij0oG90zdSxcBgzJpHeLqp0auuHdPWudu?=
 =?us-ascii?Q?ZPql8K+kyKiNDyI6t2L5540XOrdnSAVj0v2XeF7t1cgK+rec8qkTmbcnG6mL?=
 =?us-ascii?Q?mVwp+BeaKdZHVenzjds5cZHs/FO4l87pzF6M/n5lsUU49ldKZRRpeBKyVFkw?=
 =?us-ascii?Q?j9Hn/h7BlJ2LQ8LmoGXuymBRLrlSGF+I67cNF8w/on0NBnV5+raVDabs+m10?=
 =?us-ascii?Q?TrGjXiBp+kkA1y9n3igO3MmsTivzEDF8RGavo4CHPpCdbMYKiaz/QJaq6SKf?=
 =?us-ascii?Q?+lUaWQ2zUbi0sCPNklAxFiYF0bIYywFCk5c2wJeB3uyFhV28B6QFiXo+F9yg?=
 =?us-ascii?Q?qpW701zqa18F3p1D6s6+pRwMJiXpSOdV5a7BisXT2kR7Ued1hiUDfo8b/BLk?=
 =?us-ascii?Q?8oo4oK7JEhobisxaYbtZYjUiBHVbKPZfIQcLXyh0Wx8eH9e74GCsK4cYYcCw?=
 =?us-ascii?Q?n3bwTPMU/eJ+nggtSUiejCNftWvU/J4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: PZC9PzztxjXGHqiFrdoI3y5iuvfjS+07sNKov66u1HFdxiTrJWdPLJcjs6XkzTNYZBrPYif8IIYV3QaQcz2VGhWk+H9HMAHCf7tPxvgy/d1Rdc41iaiyYxTX0jJ+mEgo/GWpSq/FjcfmmPBnQoQdUNsbOz+virMWtMWKvCdhRu/WpKiRwtuiZSa6ySilmSaIKKd6bZ+QOa1g5njFizu8Yl/v3ITqvMBMMdcPtAN55cOiMHmUNAq60F/OerDSvD2FF2SOhE6kG+8dYEhf5WyKIat2trOCYIFPgLLUIRTqW2BMaPoldUyMMqgfZ+6q/nDO7HwAFa1QGD33NC0IbTYZLg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e896b9-5ebb-476d-3c97-08df1df81d29
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 07:05:58.7608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBNh4A9L9JS3gIlBhKkKQrK7pztB8ujLBunRYkcKV226N2J/x1ez3HfPyaFHph8fEADYHM9ebev3rfxz4EmTQVGQ0U7zZdHboX7lxrcNLVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Craig I. Hagan <hagan@amazon.com>
> Sent: Monday, September 28, 2026 11:06 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S . Miller
> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Fabio Sabai
> <sabfabio@amazon.com>; Matt Vollrath <tactii@gmail.com>
> Subject: [PATCH iwl-net v3] e1000e: restore jumbo config after DMoff
> exit
>=20
> On an I219 (pch_spt+) at jumbo MTU, after a link partner reset (e.g. a
> switch reboot) the interface can come back up unable to pass traffic
> until it is manually reset. Observed on I219-LM (8086:15b7) at MTU
> 9000.
>=20
> When the MAC exits the DMoff state on link-up, the watchdog resets
> only the PHY. A bare PHY reset does not re-run the jumbo-frame
> workaround (e1000_lv_jumbo_workaround_ich8lan), so the jumbo
> configuration is left unapplied and traffic stalls. This was seen with
> NIC runtime PM disabled; if runtime PM were enabled, the device should
> go through a full reset on resume, avoiding this issue.
>=20
> Request a full reset (FLAG_RESTART_NOW) instead of the bare PHY reset
> when the MAC exits DMoff, so the normal reset path re-applies the
> jumbo-frame configuration.
>=20
> Fixes: def4ec6dce39 ("e1000e: PCIm function state support")
> Cc: stable@vger.kernel.org
> Reported-by: Fabio Sabai <sabfabio@amazon.com>
> Closes: https://github.com/systemd/systemd/issues/25925
> Suggested-by: Matt Vollrath <tactii@gmail.com>
> Reviewed-by: Matt Vollrath <tactii@gmail.com>
> Tested-by: Matt Vollrath <tactii@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Craig I. Hagan <hagan@amazon.com>
> ---
> v3: Correct the Fixes: tag to def4ec6dce39 ("e1000e: PCIm function
>     state support"), which introduced the DMoff-exit bare PHY reset;
>     2e7256f12cdb only added a pre-condition. This lets stable reach
>     the affected trees (v5.3+, including 5.4/5.10). Add Reviewed-by/
>     Tested-by from Matt Vollrath.
> v2: Rework per review: request a full reset on DMoff exit so the
>     jumbo-frame workaround is re-applied (root cause identified by
>     Matt Vollrath); drop the diagnostic e_info. v1:
>     https://lore.kernel.org/netdev/20260923235832.473-1-
> hagan@amazon.com/
>=20
>  drivers/net/ethernet/intel/e1000e/netdev.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 844f31ab3..df7da86a8 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -5264,9 +5264,11 @@ static void e1000_watchdog_task(struct
> work_struct *work)
>  					usleep_range(10000, 20000);
>  					pcim_state =3D er32(STATUS);
>=20
> -					/* Checking if MAC exited DMoff
> state */
> -					if (!(pcim_state &
> E1000_STATUS_PCIM_STATE))
> -						e1000_phy_hw_reset(&adapter-
> >hw);
> +					/* MAC exited DMoff; do a full
> reset. */
> +					if (!(pcim_state &
> E1000_STATUS_PCIM_STATE)) {
> +						adapter->flags |=3D
> FLAG_RESTART_NOW;
> +						goto link_up;
> +					}
>  				}
>  			}
>=20
> --
> 2.47.3

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

