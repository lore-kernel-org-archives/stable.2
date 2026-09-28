Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AC34BE426;
	Mon, 28 Sep 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608579; cv=fail; b=dOZOF5AuxjpABjjNZH7TxsIqgCrsgL9LJbYn15HOP9G6XmJcwi/5xMKJBmUs6ykkGIOla7oGtT3lZWMQu6uTf+DBdYPkpVK8iBz5KnmZC3vhD7+K8s2YG1MOt10IRPPJaiPYn87nNgDQpiI05KrDsaKKwLhPqdsFJ3QD/a5Zl3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608579; c=relaxed/simple;
	bh=6JxAISqXjtcZI00PwlbwH9U4tuMmoNocb3B18c5kVNU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WQMyeEdpMndUYcGoPqF0mewfMFLzJN9MIfYDSurqhWWDCCxG9JUBy2y6uVd1IFROirBQrWgefz7vogfBfX52m4Sw9wXPWsJE6Sc0kFVqL+Hy6CLVdsScYZcSnOu9pVwD1Jv3FS5ahdVR1hZ7wRZQwv4BAEImOtGG/vJhiuEbn4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ORxrwIn/; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ORxrwIn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790608577; x=1822144577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6JxAISqXjtcZI00PwlbwH9U4tuMmoNocb3B18c5kVNU=;
  b=ORxrwIn/l5nih6cEbT3qVlO29ze+xBfWNupTbRfuBLSpzc8BNdqel/ye
   WkCOFvbnT6z33tOOpWrRckwjy4dT7Cwkgfu7Lo8sGDj56CH5zW0GTrWym
   oY2kh1XUvFhvLuYSS9sUUcvxROIP5Rx5pHaUXadtvn8rjOb+kZMlyWaX6
   YluiFXsTwUOUSmwFzo7LddkMKumzp2JaVsxpRDgXexZ4XrjZ2F9EEE9YA
   dP/Cm9LEE8VGE5sSyzSCrZqc9adfi2O9rtKk7Kwol8DORQlDUpymxxuLo
   n2zCE43isQ1xzmVw1N7XRyV29pRPOHl2IBXmPJaupXZvm8dRuRRnxDHd7
   w==;
X-CSE-ConnectionGUID: 5hNUVehqRvKuy3/kdmsWxA==
X-CSE-MsgGUID: y0TNgt7NSuWnR73MA0QmoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90528105"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90528105"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:16:17 -0700
X-CSE-ConnectionGUID: ytJ4wWyWS32/a1rAxTfwGg==
X-CSE-MsgGUID: dChWqrxRS4mAsfhabOQY2Q==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 08:16:16 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:15 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 08:16:15 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 08:16:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnu+G+7twnCFkFjYxwd99xfNK0YyUpWz8bER+kqepIC9XJvIHZsUH3//Tk0Uk2oH9xtkSMPxF5HSSbyVPzEHX11UJZfnOBcZGFT5rZm3ynfGKFJo1i/UAK/hjlheCnr7EKyKPQ2SsGRFA+e9vKNfSNRhS88o3khLhPa7wUT0l4mXhixxYVxxrSnmLnRAh+XddM4n0YARA3E8ucVLSRdugAYyFU/RmUGpsy7uuibLDHV1AiCtC9h6M3Cqo6eCiOUwh6jvqhAgtigbuXjCh13t4femw+9uD7U3U+7SLErMziCnwaKGnEwIwWub4PwOMVfBLScNAL4w3z1DlFJehKNwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTQBzEkZqklHu0ZSi1yLWyF7ujK0+x6GXhNReNZW0fw=;
 b=gXxjFQNat+3V40s1befQ2RtnatJJ2f7kF0h1OpVPS7vWKE7I75/Rs2wfq7a5UdxSr6Dw8WIGKFhQG9PSZLuGEXE67LhrUcOPIJqIHFezIbG5VRIcOWusoEc07nocN3pgqIj63Gh1DFpRF0EHydRy22T7HswOH/9iPEc2YUfTDKtow1goKHtLNxYmVVONdzbCbJPEC2tENXAAcVwTnbzeUmIXqOduqoHlUy/Vv1JMHD9BGBiotaQmUlMRm0jtwzQ2GcOpuOLQ+ctrqeOCg3N2BaypFIGfhrdn0NgDhx/T2XsnNGO4sWL0nkcs+DS+N+Xp+/hboTsd5iQniEZt+ClCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CH3PR11MB8750.namprd11.prod.outlook.com (2603:10b6:610:1c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 15:16:12 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:16:12 +0000
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
Subject: RE: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Topic: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
 ice_start_vfs() fails
Thread-Index: AQHdTxY0a14Aw96pW0+uUnXMOywRbLbkGleQ
Date: Mon, 28 Sep 2026 15:16:12 +0000
Message-ID: <IA3PR11MB898646A1C8CA657FBC6ACB9EE58D2@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260928065306.1514795-1-xiaolinkui@126.com>
In-Reply-To: <20260928065306.1514795-1-xiaolinkui@126.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CH3PR11MB8750:EE_
x-ms-office365-filtering-correlation-id: 8e22b8c0-d809-4763-07af-08df1d736ec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|10067099003|11063799006|5023799004|921020|6133799003|56012099006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: SQ48Vkij00a+ZW9qfyRCdUNELBpHYRD0g52aGq7YNqJ/pwZsjf/yvL3ecp4szPi06JuSE/xYAJpnFb7DFZxEkdjIPEWPq9G/NTNbPdV5qsmRpAjV/T3aiK3JQxCnlieBWqrLu/IMIA9LiN81oOejkXWFiWxeD8+OVo46TzhOAF97A0E6sYvikUd42XIX+Achf/fZwsHWMsO6xbjK5l0OfNqNY5QGKEAriAaDwPG/OgBIzSJaqZ/weCepUGnVOtdtin6QZdJbh+fBq12HLD7mMwZZPzPf1+pgbdEhHgqXMeSjfM/vi8uamd7KAYSd2h5kGxsOxrfP8K/5/93dgibZcCwBmjNhEQeLNhLCcNMjvKpKFbAbw5uC5JFo9xuQPYUwP0RQoowYvb7jsfWniRKsDvEDZ4AoDVWippQIbH9EFnksHTmacoI639F5W1O4+JvP3h0xuWaPjV/y+z58dkafn0NUqB7oT4TYJ2XU7oZmvt0Xiui0NCVBrmjMenHlUaVPvysOznIAJDYGDD/ivpx/ibd+KvQJplgCEA/8n0yAYcQNSEUpld3b8Po6ST3WChyhFJh03+ch/iYGP7/iA26PjS8b64Q/Ny4UG+2/pLUJ6+Hl+YhlC+CMycLgqPPOFa+LJ/gLoPhLxlDs4jqeXpSLsbUP96FQlyC6FZ2bLIzIKbBulPOAZ++Hr4ojKEpMzpe2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(10067099003)(11063799006)(5023799004)(921020)(6133799003)(56012099006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YdePcX7uXhnDT2Mpol9PCitwXJII+0/jmZy9bQbQoryNij1pr4hoL7eWBbRy?=
 =?us-ascii?Q?3o/PRcwGTZyPBkXDzXvxLuyr+wFABf8XVDJ8B/XqW0CXZalcUh68+84Ra+ix?=
 =?us-ascii?Q?rqxLlmE4L4IlBQpKTAFsDMOyMJyMLqdyXh8VUUFryxsqJUY4pp9MAIM6oEVJ?=
 =?us-ascii?Q?j6Ff04DI8nQg+HI9b334ckiE9hQ1XKxINNmmiPqYwsj0XELoQIOsz6g9JsMN?=
 =?us-ascii?Q?f3OTq/kJVzD+V0woItiBnUKpPJbINpJO7hD0O41RMn1ftVgHzlCRdDTSR7M7?=
 =?us-ascii?Q?7UMZkUUM7nb9MiYvVyzg6Tof0Mk+SYWiTez4UTGAVmMFQKB7LHFK6bYqkGUd?=
 =?us-ascii?Q?q9mIdT/jkSWQe73ZJN68aFwk4CoQKumeB1S/EJqBs2Kz/cCSMxwvTRYDa+HI?=
 =?us-ascii?Q?AsW3K8hfkzWjMQ9mnWrmF1LLc0beVprx0uMd8XTdoL/HcvjhUYvpPCxkxZnP?=
 =?us-ascii?Q?qdTFhwcNQJSqhH35HndgwCcngQxcCNFwgVLL5Os8VuivzH4z4hK5ZEVSUJ9A?=
 =?us-ascii?Q?+wMIMPVXI9htK0TQ3QdNPhHGC7pUlEbEFcuuRy61MHhgjpoxXa8p6WlcebuZ?=
 =?us-ascii?Q?bGC8btrQK88HeRQWTWVggqYQ1Rj4vKfxu3bGxO3yGIcEbOU3+tTZLibBsAva?=
 =?us-ascii?Q?8lQod/BJkt8DsupiYdIztz+wDRflbyUa4CSc1poNAxWkhiApiWcf4PyBfgA4?=
 =?us-ascii?Q?+zA4hqa/aPXWJBXrFCuROXRRcYEjGIDkN8leZ1D6NWEz/Kdwe3++pz48dksa?=
 =?us-ascii?Q?GJWBb+C6MO6XOTx6M2MIrZzC3E1u1m1E54xHpf1mdHN3D5uYuokTaaBjB0Ms?=
 =?us-ascii?Q?dfqhYjrLKng2Qf9GfCjJAGpD0hTNdOJ4TFR3xWDeSlMvVkBm0SOY6tCAtPvp?=
 =?us-ascii?Q?L0MxSQH8nKcFukAfG1f5rrhwWL1CTL/R5YLGndhtoIDmk6GCy1PzoDAcaQDJ?=
 =?us-ascii?Q?JOp9peyegE97fkVUWhA3Fbp6qRUdRPnhRkNPxoPREoWaoyjKamWBCeBFzta+?=
 =?us-ascii?Q?EXrhkNFiKQURudK5EZwjbzR/z//fIZs6hDOG9I8ustEJmM3G87/bLyx5gdYl?=
 =?us-ascii?Q?k+fKTgb19gkPb+8ftATpN2BMdo3uKvPm5gffLUpD41WiyhE5J8FCAcfg8PZY?=
 =?us-ascii?Q?Wm697itmFGfYkzNo3gZeEg9ZKFL6IupnO3X4SIZsAzsB5xikzlUpNMwuQcRB?=
 =?us-ascii?Q?tAsGAB6qrJqmyBqAb1bVahxkbFoxWwNT44HVSdGGKEO0F7W0Q7s0MdMHws4a?=
 =?us-ascii?Q?mqmmNiV2ksoX8HD8OtSYBUS7XiClYYDrINgSVpqAbyJgSd9q2KiebQSeMFvI?=
 =?us-ascii?Q?o6WsZy/u/d87LnEYQOCBJcQG6aLnnTgdxjyYuya8rYGnNhhlXEoBhUlht02J?=
 =?us-ascii?Q?PldeQN1q8AFgeQk1G0IGZjHJelqzmkbDrV5HzbnfRd7RL0IWpkFEbBvjRC+E?=
 =?us-ascii?Q?izCPNZk5kaeeEm7IrMy+1pyA/dsY1Hv+3vFbo19SvOVM/ilUqkKmSYZAHkpm?=
 =?us-ascii?Q?OoG/XcgNk3b9pfaAXrIUCjT56TqkfCK5Zma/g1AuY0PsaHRzsAxEVp/k8xTW?=
 =?us-ascii?Q?bZkuGS5mpR9eK3b91NqhQ2ZsDacYmwGPkvIjyZvFq96JgYzpUbZ6Z1B50Xkb?=
 =?us-ascii?Q?zrRINqnNuToXLXuDV47Vx+YBzXG/gP2BY+GofUQwPMutbdSKmmUOYONxcsSB?=
 =?us-ascii?Q?55bwMZmsrAeg+BfUxxXzA7nGQCU5GYqMe5vSgst0mpMV180u2ff0ze8PoIhF?=
 =?us-ascii?Q?/XAG9zaKKJpThi68q5IS+WRwOH8lno8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: P+ZU6EMMnvGpHhu63T1seGTmGi6JFdPdCdE9UMDZgPlt/cHM7EKPtlpIWSAhG1lxKdoZ6FX1F+bpqA2ryEfcHr71+TMkkqJvNsFQTAzCX2FpTq6LNomlVP/G08G0NwLEz5FalVTfrEuud0WjroGLgBVcRZCAlLfguvcoZElQRcRzVqpq/eCByX/cSD+unrowaqhVq/DbjQX1mUsZwMt+BP9xUYpMRIJCDNUZg78BpQBY2GHkOrkhsK4rR+QlRCl+PvE77C22jwE/qnTq2j4FO/y7VP5V1F268TEiqUxi8nh/zpg31WwvGo4Fg4tKvX9E4EkttyYFVKFHnewPRGQWoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e22b8c0-d809-4763-07af-08df1d736ec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 15:16:12.6199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wP2AUS2DZzc/BU1DTRqv2fzv0+CRmDWqlCehfULkm1a1yKN7+pKuhrAYW1PebIp25Kp2bCnDyy85fJxknXNkroPGs8XY01dn6NVRG9ZvEYM=
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
> Subject: [PATCH iwl-net v2 1/2] ice: detach the VF representor when
> ice_start_vfs() fails
>=20
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>=20
> ice_start_vfs() attaches every VF it brings up to the eswitch with
> ice_eswitch_attach_vf(), but the teardown path only undoes the queue
> mappings and the VF VSI. Nothing calls ice_eswitch_detach_vf() for the
> VFs that were attached before the failure, and the caller,
> ice_ena_vfs(), goes straight to ice_free_vf_entries(), which drops its
> reference to every VF.
>=20
> The port representors created for those VFs therefore outlive the
> failed VF creation:
>=20
>   - the representor netdev stays registered and its devlink port stays
>     registered too. That port is embedded in struct ice_vf, so it ends
>     up pointing into the memory that ice_sriov_free_vf() releases;
>=20
>   - repr->vf keeps pointing at the freed struct ice_vf, and repr-
> >src_vsi
>     at the VF VSI that ice_vf_vsi_release() tore down. The leftover
>     netdev is still visible to the user, so even a plain
>     "ip -s link show" of it reaches ice_repr_get_stats64(), which
> calls
>     repr->ops.ready() -> ice_check_vf_ready_for_cfg(repr->vf) and then
>     reads repr->src_vsi through ice_update_eth_stats();
>=20
>   - the virtchnl ops of that VF, which ice_repr_add_vf() replaced with
>     ice_virtchnl_set_repr_ops(), are never handed back to
>     ice_virtchnl_set_dflt_ops();
>=20
>   - pf->eswitch.reprs never becomes empty, so ice_eswitch_detach()
> never
>     calls ice_eswitch_disable_switchdev(). pf->eswitch.is_running
> stays
>     true, with the bridge offloads and the devlink rate topology still
>     up, and ice_eswitch_release_env() is skipped, so the uplink VSI is
>     left in the switchdev configuration that ice_eswitch_setup_env()
>     gave it.
>=20
> Detach the representor in the teardown loop the way ice_free_vfs()
> does, ahead of ice_vf_vsi_release(), because ice_repr_rem_vf() and
> ice_eswitch_release_repr() both need repr->src_vsi to still be valid.
> Every VF the teardown loop walks completed ice_eswitch_attach_vf()
> successfully, and ice_eswitch_detach_vf() already returns early for a
> VF without a representor, so no extra condition is needed.
>=20
> Hold vf->cfg_lock across the teardown of each VF as well, like
> ice_free_vfs() does. The VFs unwound here are the ones that already
> reached set_bit(ICE_VF_STATE_INIT), which is exactly what
> ice_check_vf_ready_for_cfg() checks, so a host administrator can still
> run "ip link set dev <pf> vf N ..." and a VF can still send a mailbox
> message while the loop walks them. Both paths take cfg_lock and then
> run ice_reset_vf(), which gets to ice_eswitch_update_repr() and writes
> through the representor that is being freed, or reach
> ice_vc_process_vf_msg() reading vf->virtchnl_ops while
> ice_virtchnl_set_dflt_ops() hands them back.
>=20
> Fixes: fff292b47ac1 ("ice: add VF representors one by one")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
> v1:
> - Link: https://lore.kernel.org/netdev/20260921031616.3390259-1-
> xiaolinkui@126.com/
>=20
> Changes in v2:
> - Hold vf->cfg_lock across the teardown of each VF, the way
> ice_free_vfs()
>   does, so that a concurrent VF reconfiguration cannot walk through
> the
>   representor and the virtchnl ops that are being torn down.
>   (Sashiko AI review)
> - Patch 2/2 is new and returns the VF MSI-X window that the same
> failure path
>   reserves. That is a separate, pre-existing bug, so it is not folded
> in here.
>   (Sashiko AI review)
> - Not carrying over the Reviewed-by from Aleksandr Loktionov, as the
> code
>   changed after his review.
>=20
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index e04de0215596..95abc6704820 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -508,8 +508,13 @@ static int ice_start_vfs(struct ice_pf *pf)
>  		if (it_cnt =3D=3D 0)
>  			break;
>=20
> +		mutex_lock(&vf->cfg_lock);
> +
> +		ice_eswitch_detach_vf(pf, vf);
>  		ice_dis_vf_mappings(vf);
>  		ice_vf_vsi_release(vf);
> +		mutex_unlock(&vf->cfg_lock);
> +
>  		it_cnt--;
>  	}
>=20
> --
> 2.25.1

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>


