Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD846AA80;
	Mon,  5 Oct 2026 10:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195811; cv=fail; b=RLJm2xlSVRZZcHkK9Z64HYcruW4N9FlesU/hD06fDuUKh3moGlAj2fjxJmuO/rN0UIcU1o8w9+ig+QV2ftWlZ80PqQJp/afLNwAGuyyASydyI+n/9X/P31swxjZfxh7e1YIs6OKZ/4RnRs0d3qv6RAOCKHmCF+conofiS/IeSqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195811; c=relaxed/simple;
	bh=vOlwj24zTY8n7CE1zE7YwVNRqjIbq0SAk2vEtmwD8cQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tLYJw6oI6gxcwKb12ojrdp1Pd4c5ZFX+1jpxS2rTVJMSB58q6ujGNJnWtg2JGc2Bs3znuQffqijRsC6lWc4bmzOLpgpNFB00jVXUzDoSI2bn8T8P7kdvFf5bU30jEqHwHVQtbQhxkVnQAoQamCHyaaKg+jJG3LsIo9P2nL9J2w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzTHodSP; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzTHodSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195808; x=1822731808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vOlwj24zTY8n7CE1zE7YwVNRqjIbq0SAk2vEtmwD8cQ=;
  b=OzTHodSP5jxp/0gQiuiBEK/XmqUHyq148fMmwziRTVHRsVVTswVmB8Yi
   tpWbuaUR2f4QVwLHvwi4mMpCaQmwPQYyq8YOlmPnS4hKmTAHLaKdpOh56
   GZLgAjFJqqAJ2+AdG557X3aknq6Duq57d4H2tHxOWYe7TR9D5ZlMQmD5t
   t66CGQEA2ZqcFENXYmi9O4FMaCGvIb3Tl95ZG3l+h/yS/hB+cVXhanbKu
   NHi+cH3xmnSy4F1NG7DJnpqeM3Znrq5yhdlrO6SC0dN/J9Vqoj2qTND0/
   T/QcH11jcMM8A08ieUeaZhQC8v7DL0IxblXMcCuOm7ioMXOEOsTXySfi1
   g==;
X-CSE-ConnectionGUID: 1nyPFBfqSS2k5GNQD5cJ9Q==
X-CSE-MsgGUID: Nsb07NzDRpujMA+l4DSp6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="79422529"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="79422529"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:23:27 -0700
X-CSE-ConnectionGUID: v2v2FowuSIeXBp6TDRB5gQ==
X-CSE-MsgGUID: Ld9oHf4WT1iGaog3XbpnCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="284671016"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:23:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:23:26 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:23:26 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq/L5Wego0roXp5gfsOF+FhJ5awFjACsu36S9E24S/pHveDucw/AK2hfKeeCfvoA0OUgtqbTIS7TXsS0IPH6YQI9JKEfquRq12Lf0cdIRofSIJ+s/IBmrraJz+MVWleo48/4z5+tdWXpDqMAPBeeTM0zn2p+nKQzBAcECT0RER0XmlsdIZ4y3HMvxITSOU+E2O7S8WX4fQ9sVzARgCAUjOq4ZOQWEveFm5N3imF3a2Wgi5OkrgfSBeUEoxwdKfeKxzwP/Oqi5cTQPtRZclpJmY1H38Wh7TIWgOMJqKrsXBeCHkPVPCHJ6ktSWJxFkEZ4dRVlDvFAGVIgIQVmJiQp+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3gvekisZ5Z6p48gYJJA86dt2I2BSAoe3O2TvZq4W7o=;
 b=RG2FEf2DXGexCyy7Hl7QGE68JWz9ul9KsQ4xZfcp2TUuZPGyNYosCCstp9/oW4pTA4qsPRzQ3/fufrSFpOb2gWFhvpLgXmBJIbbsDQ4h111+TgY84UUHzJcZeWchDVUogxPzAcDwsAglfRqoOU61D9EEycTuVtbgXGGnBXoKh/DozZK9BrPs2+zG5dH+ZenU+L5cIgr+mzE94/PzeLi8qssk5THhtn2mI405UXKPbrSG/KebHxoOy5s3fIEUq+fO2M6Wx6WuKzsdhbAtQixtxWht1glaYTbG17j9/hhSumE8UliPpR/CCuUrq0xQtvNqyyvJEfQQiHPPBrQ7ZcD8Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:23:24 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:23:24 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
CC: "Keller, Jacob E" <jacob.e.keller@intel.com>, "Vick, Matthew"
	<matthew.vick@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Jianhao Xu
	<jianhao.xu@seu.edu.cn>
Subject: RE: [PATCH net] net: fm10k: shut down the service timer during
 removal
Thread-Topic: [PATCH net] net: fm10k: shut down the service timer during
 removal
Thread-Index: AQHdU/XFce73W/9/rUCqjzVulyilULbuvyLw
Date: Mon, 5 Oct 2026 10:23:24 +0000
Message-ID: <IA3PR11MB8986DBECE39943F0CF68CCB8E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20261004114352.1232745-1-runyu.xiao@seu.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 5b48cf22-dd37-4de1-9628-08df22cab002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info: vL2RES5Jwpzp4alx9okjg2dTegyedlCXFnbyTti56xxTfWev/2pO4MB98iT+awFVRc+V2zhUcj5bRh+timTqcFX+gEm/J6X5YQr/i5canaHrzQVKu4NYa3os+NM0N/P1uoAQwL8j/fcwphA2e3cqJWEJy7QXsBWF1XbMlGVMJK3bWPiyqHf7HEOtz3MBf78K691jyWu7ym9C2/vsLFBjFPEjqopIfoUefIuVpVnyqd7VM22aJtP6llXrtw6uQO+kf3XtIeKX5X4Mf0P+IoiifJ0BlllhD9ESRGEh3QdwFTEn3WO0PyaXuZIAhEP11Smi+Bt5JyII+CGmf+q3w6f5hqY+WUiHIxBkvDd/DzrJecFZPho+rj2GkYo87d51j3+DdvTivsSJQLegKVGROWZ/uUK2udToLvNjJjtFCJ3WsKR0r9pGe0llKd9h9Kr14Xit23MsFTse4DpzybzMZYPa4fvTUDZcLKmgyQhWqT3ic0ehrPapPWYtQlLHZtjWTiIgpYufjGNVcpzRgNHkILKWMwEp9zcB40qxmjQl0wyaXWDbD/GBximXIq6pn+5hbPnNnSGZ/R5KIYt2/6HkUbrGRS1sd1nP76pYdo+ceevfYo2PuTl9g5f6711uu6TddajLnQZihIxd7GaYw4of/xQ8eidFMn1arkPh4JOaWGbg7LjDkEabv8tPoKrxPH6GuEd0VXzyOuRR1SKdNa/HvdUA6r3uBf0GWkvivKqreZ7mrH0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vtBm3VYASw4rp3N9Wri4vCWEPz59utVOFwoV6s94U3aS0KpOGiAfG4o3AYr1?=
 =?us-ascii?Q?4cSupVG/uOhm3sijre4DCR+iD4Qy4BZVBGMFigcHjtO+G0/ART9s0uDicnNX?=
 =?us-ascii?Q?pRdkH6NtOdNA8dWPTw6mY42QuEoaCW96iGT4m2UEg3MN165MNUMHq1eWh2w5?=
 =?us-ascii?Q?FWsabnB4vqWh6wYdMNkb7H4Swo1JhgiVjGTckw2u+XekR6aMRhcllyUcKDj9?=
 =?us-ascii?Q?ioWMbeprLQO1HV//45RM1t9h2FswGPlwaSVLKP3Hncm1GBGV61KvH8oNfhU+?=
 =?us-ascii?Q?Ojv0Te2aZoHHmivYg9l8i4/XRlsi2qosWPrAfR4Tp45idwsoIOzGUdwCY6m8?=
 =?us-ascii?Q?l40yuih4G6pwXZcZ8soippehyyH7V446Yc3fWdts9D2YaHdcitNCLc7eIft7?=
 =?us-ascii?Q?Zo8LkmuwVpfTs/2cS4ACSte2Ea94fvy8D/EnAYt09a9nIuVl72POTgklszr8?=
 =?us-ascii?Q?Wl44zVEUxVTCFrbyHPTGpr3WvgC25Xrf6bfkwfhCavbeoYG+OFv3DpD6+Sn4?=
 =?us-ascii?Q?JBqn67zmpNzdNGIU0X8V0zfpE7w3RZF/WZVxyOyfVw2fTWCfnckMshGz7Yww?=
 =?us-ascii?Q?i8aFyzrWBzcA5NW4Fp5vWKJvsUBYEcNmGvdp/1o0C6WYRsrnQ6yT4IQyyMuv?=
 =?us-ascii?Q?xTr/gI65AQ7LabFwB6kfqTmwA1j7gBy5PzXGvQvyrqkPx26NMSc+dtZwbKqR?=
 =?us-ascii?Q?pwBKR5G4yGNBJwyRYgsJl9AGWHN3jyXXslq3eJB3WDwtEMPPflOfe/23CaLM?=
 =?us-ascii?Q?QNSk1nftOkt90nmv4uNrWyHc+1hfqYtyu/7SYYkF9cgeKe5utJUwug0HlUay?=
 =?us-ascii?Q?6/ftS/WR4oWATGak120mq4bXXOQEBp6h8oXaxvyBWsladFSVTJDLw3FXgjXH?=
 =?us-ascii?Q?Nm/jI0h5z3wQu9/icqMquLcIr+wGaGPAngyz70tdBnM7EmrVxJsNuglyh98i?=
 =?us-ascii?Q?bs/glYg8aMfzy/ehj1jKpx10SnOeQMBtVP1SH7VMfqGYRJk21NJuXm2l1kMh?=
 =?us-ascii?Q?Av93X07yTkOyLY0PZDZ5oyKhgG6zk1ppx+XW9uc7snO17iNPX9QOxPACLnqb?=
 =?us-ascii?Q?qWb3hNIh8y5tFMiu7OC1dl4JT6HbugCe47djBOB1tlO4/pCmV9MRwVgT1E+c?=
 =?us-ascii?Q?kbm5aMP4hNuAOSd8Ao1EI/94tbeC52+IlX/6qDejJv40ELKpEghtr5Vc8mBA?=
 =?us-ascii?Q?8Y9O1ckuywvoMo/enXLNeT0Epu+cFXpiF5m+s5HCF2MOxSxSSKjyvUIBq9G/?=
 =?us-ascii?Q?Y8DLynk8I2QGy/Vhg6mu0XkwZJuPks/3OLoHcxg+06707ywtZgm5eSE4ONyV?=
 =?us-ascii?Q?X2t423Xk/X0XgXDiA02g4J64CayJfUK/n+BQlF5M+R9YHHCGBB3JcO0HcVFU?=
 =?us-ascii?Q?UXgt9OHQRVF6p9RNYz3zFH0cg0Csb0P20IHIkITpfsU3OMcB+kmY06v0HNwE?=
 =?us-ascii?Q?ACvciZVszSDwgf4y28YbTaL9k2zTo9aoXtKN4BHBL7+3tVpAeVdxU3HqFt5V?=
 =?us-ascii?Q?oPJObnf0PyMkNDr+BHlZcpyMWV2Ts0O8o2X/GrdcBnLvV+t0brjEh7bixhS4?=
 =?us-ascii?Q?ehOUzJB+rM/ZTfbJ2b8ZOhLURBNhaaxYeTP9hRPe8z8d2uamT2WpZ18l2G2o?=
 =?us-ascii?Q?VrWJhe478rkGn+8O40PDq441SKM7o2lVZ77QQhqyi5k8qXbUvCY+8if0FO4u?=
 =?us-ascii?Q?VuBX4NDJ9Y5CKOeyUft3SXRJdqOZ3cYJNV587QL2BaB03sTdHkKU76m8EVXs?=
 =?us-ascii?Q?MkXWorC1/lEQd6hf3TP8gHHtteJoMGs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rjOwMrUg3TRol0Y/Jo6RsCXUT6H2PwtRtTpNvb/aSQ1eXFv6L14s9WDFioXRN9S+T7FUf7WQXhgORXVPdFf8ug6u3KJHK622fAikE7s8qDQhydyBWJJlf6TCh5otDT0NoOThhs+wMRGvLeRKFicRkfDNsHj1fBBqd2EQVPNHrn8nB8MmDnm6MGcCZgCk9QIJxktV4HFW80Kha9XrytCAxhCBkd62LidQenShaxon4XsCRVSxUu+P0COU9YhEYlQBasUQLupceMIAyxNgk+POglXjpo7Hc5gKXQ+0BQfn5ZG4W3o5VDAdWx5X2WZ+99GLIJVTeOsfYjK7fOnazmK8Hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b48cf22-dd37-4de1-9628-08df22cab002
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:23:24.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZMWhLC0eHgY5ZqNh9qLmhHTntc/cBu7fufVtCtrMemb8FHR8KR42b7eItScE94c+Dfj3ePcYgQdDUhr7PTuJZaaEH32pEuuduM98GE3ZZo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Runyu Xiao <runyu.xiao@seu.edu.cn>
> Sent: Sunday, October 4, 2026 1:44 PM
> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> Przemyslaw <przemyslaw.kitszel@intel.com>
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>; Vick, Matthew
> <matthew.vick@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S
> . Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Runyu Xiao
> <runyu.xiao@seu.edu.cn>; Jianhao Xu <jianhao.xu@seu.edu.cn>
> Subject: [PATCH net] net: fm10k: shut down the service timer during
> removal
>=20
> The fm10k service timer rearms itself from its callback. During PCI
> removal, timer_delete_sync() waits for a running callback but does not
> prevent a callback or another service path from rearming the timer.
> This can leave the timer referencing the fm10k_intfc after
> free_netdev().
>=20
> Use timer_shutdown_sync() to permanently prevent rearming before
> teardown continues.
>=20
> The issue was identified by code inspection. No runtime reproduction
> or trace demonstrating the failure is available.
>=20
> The patch was not tested on real hardware. No hardware- or firmware-
> specific runtime result is available. Validation used source review
> and available build or emulation checks.
>=20
> Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index f5b4d0627..836664cfd 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -2245,7 +2245,7 @@ static void fm10k_remove(struct pci_dev *pdev)
>  	struct fm10k_intfc *interface =3D pci_get_drvdata(pdev);
>  	struct net_device *netdev =3D interface->netdev;
>=20
> -	timer_delete_sync(&interface->service_timer);
> +	timer_shutdown_sync(&interface->service_timer);
>=20
>  	fm10k_stop_service_event(interface);
>  	fm10k_stop_macvlan_task(interface);
> --
> 2.34.1


Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
