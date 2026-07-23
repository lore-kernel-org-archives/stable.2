Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE311263C8C;
	Thu, 23 Jul 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784798659; cv=fail; b=ItdZbMT6SEXXVA7TgrZrgAKdWWEXOK+/YX1oPiKTNYGgd9Nxts6Ry3/GJ+6xUkpAJBWD5IPth15CYmqJcC8T7eyGHJ6ehWff2dJ6TjhxWP6Mx8Hhpy1OM5Nt31SqSW5eom3RiAQvDI7X3zlO5/xJ7ozi49DqdMoskQS3r6MTjNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784798659; c=relaxed/simple;
	bh=GtALPSlNmWcJliDeSOScMxYoTe7drcVF+MLFLFGAX50=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JJ+1rKswMHBWxcoul5o0VcvoD7ohTexUYRqYkP8VM8zmqINN4h5mERgmrAWTtTPVLGm69lIVxiTBYN0Q1a3BVS0MSomUfFXsgvzC66JK8+mx/VAxAczHn5I3sobhQFltOJuOM9OaaXq8oe8GbbR0U6Xh2ABJ6Dx2cjiYrRwmAO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHJuqX4E; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHJuqX4E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784798658; x=1816334658;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GtALPSlNmWcJliDeSOScMxYoTe7drcVF+MLFLFGAX50=;
  b=CHJuqX4EKBtkIZt4PjHg5aGb6MUj1Xj0HK78zQxrFWkvujlkmVuIFYrf
   9x8mRshdnYMmLIqZWdFaStkI8TFO3mG3cNVpj/O4ZwOc9Vf8f+vmHUKbB
   Zc253l9BGdyj9tgfyNDRNEp3g4TEKSxeLgCFcXtQwJ2y/qptM4cg8bVPh
   q2Et+AbcPba0qK9r4dLYc2bMv06FuBrt4aO6cZN4VjJQhdvP/1gF56+PK
   xzSXsboq/ud+/uRAxNvZE/JyavY9QIv+yYNXds4varM4sVJugDkeIV5hS
   cYQXWv9CkzHg++zjt2j2c83YCdt8KePXYRg0vy1eEZmJF0uQrhzHGJP42
   Q==;
X-CSE-ConnectionGUID: vnTI+jPlQOyxlScJh1aSZw==
X-CSE-MsgGUID: 0MwXfPZFRzam+cGT5SbOiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="102994663"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="102994663"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:24:17 -0700
X-CSE-ConnectionGUID: 91gHqLDZReK2GQ45NGx7hQ==
X-CSE-MsgGUID: Kq+3XgOGQqahxCuRGmKpuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; 
   d="scan'208";a="254008696"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 02:23:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 02:23:53 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 02:23:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqEnKFZ0HJqYHBnj+5kYk8J9fRQOn7h1jZh6FECK8OS7T7FcVdB1SuV3jvF3vQVAgzXa9A1ASmCC4N7vDGTq9cP5bmqtLoBQmH7zVFhxgaXJQfgYNapPqR/h6ZlBFEJFLZyhunwL09W7RKy4iAqwwranrxpbDNP/jeF72xGbHTFK3Y+IkAjyeFIIvNX+TLmEe1gkUI9snUjs3QK+N5tvb8iTcyLtFd5Mc2WO3+XmfUihFrJo9M5NcgHe1SU8dJp6S0UllbTyIkLf/V1olYrYQfKlFu+Pv/RcPITm0LGyATlfJ7mFV1qrH6tCmLzL0QxZMYEW0fI8rN+wscQw1BKUnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0oXOcwzDs0Il6a4p/N+5/+y1EDaIUOGTPW9VFVwzr8=;
 b=qJ+xcm2pkzghgm/GeEO7H9AFMpmqEzt/JuF0KHUIZbxZ7o/LxOuwefLlMc+9HidWTZ5d9KRm69RJRLBVzv8ThXBcMhczw3CkkMC/sGvj1Dp8Qsqdyv7FMbc72ZA1WI+Bn91BHO+3jMcNFXM5qKEzm7K84KZ41p60rpi0Bb99p/iuhufjQE3lVzY10K324Xjtprl1K55IR05kf8B5dtvC2rxswz3LB8UVCMfFFA2UNJ4BC4yegUhZrqtHCCiDKmFBwHEgtJy3Q4kCeq3Is5+IcEQ4llZ/2fQo6Gm7BmkKF7iaPViImSs+Aa20R9H8sWji7+GtYvYiOYh96HO74i1ueg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by SA3PR11MB7628.namprd11.prod.outlook.com (2603:10b6:806:312::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 09:23:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 09:23:46 +0000
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
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/2] iavf: fix ASQ command
 buffer leak on init failure
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/2] iavf: fix ASQ command
 buffer leak on init failure
Thread-Index: AQHdFDPSXhG+ZbcaQ0m5jX6wE+MRWrZ64W9Q
Date: Thu, 23 Jul 2026 09:23:46 +0000
Message-ID: <IA3PR11MB89869EF82E36C967CB0FEE21E5C02@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260715082548.56687-1-xuanqiang.luo@linux.dev>
 <20260715082548.56687-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715082548.56687-2-xuanqiang.luo@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|SA3PR11MB7628:EE_
x-ms-office365-filtering-correlation-id: d12ac913-9746-46cd-a52c-08dee89c18c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|921020|38070700021|6133799003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: AxJYy2Y2Kl5OcOMnK4x7UyhaJlP0XwFdDOgxbhCIy1mOWZK1EkPDgVr58Jdd7UUw5VXgAxDULTvptX1bbAPYXpfKdOYzhkyo2Rhr+iMAa1INd/e5vrTQAIR6VyXdXszrfgcBGB/WrSCpKPwyiy+/kXOGX32ox0S2Ha9zpUUwdHA7T1aOejXj51iY/06uyLK6tmtqyxayriJHpOq+ASLWIjR0M9VXJRV8HEj9vnXdZxNVYsfEVsZ8C2HFq5aF1D8Os9WmDOdTd5fas89WvWaZE02ixDT7boij8cja9UXXOt25iil3RwU3xWEJigr92G6gBMEmmPmduRktxFYUdJz9W8CgOUyplFp7wYo/1duT+7I47lOB4I+k+pqb9zCsylhXnyLvsrqyzN/o6B0D52Rh0wyJRF7Q4dlDrSFRHod5B1VbUA5XAqVmOzwE3TLQsmuLcrpM0/UPeVUVB7sPlRD+1r6vgc60vXYt4rHpJQaU7knpuIHfp6dOVpD4aUs3WT3aHrP2+VRlaulhHxXFtVhgUvSVOmeB5h8Aerafaz0VciNJIffm/5zA+8kn5CQXW3r2dShmb+nZXbbwbl23mVLAp0vTe4ABXg4zF1nrMBP4O/VUDxXMa9S/z8L7vvvZbzUbCPo240Kq5psC0JYLcI2HU3mJqPBsRUIvkk2WYO26iQEWx4WxnAfjGxdlMYoGsCVBqQwYjJTdC0bZtgazUpRN+cRB5WNRVpPJ79cxnzw8hlpXVbMB8kVcD96Ij4n1g7YR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(921020)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tI8rCQxuBD/tBR6iiQ3dyKWCYflFl4kwJwnOZ+utRf6/hJLlYJ2aeXDXYPnx?=
 =?us-ascii?Q?0+CY4cjIBGMzMlU4LnDHoM1zt/WW8vNHj6Vrf4irsCUxS80xfkXJuNHV2Gzy?=
 =?us-ascii?Q?dt0mQt9gO75621eSs8qg2i2tCZuyDSppEBDQK76BO/Ecu5Nibg4O6SUI08W5?=
 =?us-ascii?Q?68Px6BZ84oNpkF07vSg77aGTeVBgp9zZ6d7e2TUUYEk4wDOHzif42qiflk5V?=
 =?us-ascii?Q?2qWWpHeaE28jC6fwP24jPqZSWWnH0ms20Zzosvu9Ynk7j6AN1lxzaySP4E3Q?=
 =?us-ascii?Q?is7prCB4V3DnG1RSASYhCLM+TP4Vlk6plBTIC6bvfTylTHa41iiAGrT0aCTu?=
 =?us-ascii?Q?3N/9Yy7gHkGbnl4nRbOiHO0gXdA8XJHI1G3VzNrM8ywpFdEGGiK8k8pbijlo?=
 =?us-ascii?Q?ljcQEdH3QbZRbgZDzElc9N45OIG9HCWjgOya7qL3MeaZem3Ppikl0Y9jlVzJ?=
 =?us-ascii?Q?w322Weoijz/RqZNGHmalwGCpBaV6kxDec6CaPDlk8wxCW6GZIvzg9CCF+sp8?=
 =?us-ascii?Q?THRO1Z4SlRxuRbyUdAY/KvXwn4rJ1oTVOok9pOh3yML2sZkg6fTXb5KV1lAy?=
 =?us-ascii?Q?esp5gQ7EbgApQ9F+a9jUBjlSbvs8EBdPvC5aKucPfKqcJbE3s+8zr5RPMaph?=
 =?us-ascii?Q?aAX02aUtKYEeUBGK4NemBwXgZWwppG85AYL5asJOUXEbJUAxDNlhKu8IjCfK?=
 =?us-ascii?Q?GVjQXILKUqd3w5ccgsT9t3OIhJAF1w69RYBmrKEi/Qiie3dK1tBbhGbtSnuN?=
 =?us-ascii?Q?z5Ul4C8g3LAEO9Cmn7tLqwnRFXaWNLMGnBHAckAiZ9+RgLqM0fdDskYZqnj1?=
 =?us-ascii?Q?pB4/jcAE24474r+spMLeoATggnI2p1X9wrS7L8nolUn+1Mrtc7wAGWkRGMSX?=
 =?us-ascii?Q?YwPWFwGQvj24iD8p/4SswBDroAunoHd69/MrYzlJmvF3wsFRfXrhd9eg3KS3?=
 =?us-ascii?Q?YUaPQYkkOG46l8wr0PN5PbWqgyaQSonCakJjYPHLul1W+9CtYdv8kjsha5LE?=
 =?us-ascii?Q?cVRMdZ/WjS7v+v//e5sey2J94qeE1o8GMTqdnR3+myc0IZllYoSccj3J6j67?=
 =?us-ascii?Q?8nY69FAv5ImAL4O1wy4c+9LRBbqqJLdRxC0fco5bm6bSUpPe/w0F4QXCsh/X?=
 =?us-ascii?Q?/hIE0PpNvRGG8hISRaudismrSwQBh767jr4XaAlICk1RI0vhpFsIz/92FzZ+?=
 =?us-ascii?Q?9Hd+t9hLsL4/PjsVwQxxb7X2PlTE0V3Ny3fygiXmQIj/oKyPLEd0jASID/WF?=
 =?us-ascii?Q?zb5jS0oG7o1aqhk2NqB/5L4/gXs0F/9k5Vea9kuzYinv3FOTI4JdMAssBdiN?=
 =?us-ascii?Q?yC8pgxRp93PTcaTGjOvZhzHEYaeSFSsy1q5hTKAJ0U3tXwFkDMvSk0fEy+Ik?=
 =?us-ascii?Q?z3mZB8PHuioJlrdH3/jnPiMmqomOfVqC2CEiEKQGkI5NCH4mwDqOYP48mSGA?=
 =?us-ascii?Q?1ZoEXZ7zPq/ld+AVvVzbT89KwM5+yWEmCunZ2f38M5xb6/FywkPONr4G91R2?=
 =?us-ascii?Q?llLYRYjhOHKr6IEHdjbR9YjAUdD/7cKfxiO0a210pRikbWLwSWcXnIkNfqj2?=
 =?us-ascii?Q?0KhWYzWuTPjfEQ5KNvVAMqr2UnJn0INLR0EsSL3X3xONak2yp1Vf9KrWo6Zn?=
 =?us-ascii?Q?GLjrRKIwkBvu7W7p0ktcTaB9Rw2I6e6IoDzORQWexx78phpTA44TbRheuRFp?=
 =?us-ascii?Q?/lHhA0moXnaNwEJd3hDmiDCF2U9MT5I3S9ff7oFhhHpwJBJBreB0A97F13HP?=
 =?us-ascii?Q?L2GuDu7QfuKl1rWIc0KvqFJ3P3jl8jM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: hhii9nclc3pHh7ZdBd5jQKhfi/MKgfWTSsucVcIn3P7fr0NfmelF5sIMk18J64qAjn/kAzMWymAbK6ygZXFTVlTeh9zTa4TtVX32K8atmePIpQFjAUbm4Qn8DjfaB97ybGAHxjiUKtQnEe4/iqVPuI/AYzh8vcdidjHXfzgxYIT0IQEREGfituDavDcwC167kbjscC2ZKulSSbn7AgaLnZnKDP8gfoR2uV+94W0cV9uymEBGKV6y70s4CQL7nZhDr6ndieKqZ9omfBps5WmEj/omR4cqbTb4+wfz63993D/ZTsdCvtBVNwYtYJF/4CbOD8oYPYzewnpjHZHWJe+VvA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12ac913-9746-46cd-a52c-08dee89c18c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2026 09:23:46.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GuP49k3ODSDd1WRctgTLMQW+bw8Ws2gF65FPCd4D7ag6Y4chD4EwtkWb/qD+iLmTuUnXDuZpylKpM2wT+EtRhk13yOflTiVaXZU7QWvUB7w=
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
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/2] iavf: fix ASQ
> command buffer leak on init failure
>=20
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>=20
> iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining
> ASQ resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs()
> fails, the unwind path elides cmd_buf while freeing the other
> allocations.
>=20
> The ASQ count is not set until initialization succeeds, so the
> shutdown path cannot reclaim the buffer. Free cmd_buf in the common
> unwind path.
>=20
> Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> index 6937b7dd44cbb..40f76f9507f4b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> @@ -60,6 +60,7 @@ static enum iavf_status
> iavf_alloc_adminq_arq_ring(struct iavf_hw *hw)
>   **/
>  static void iavf_free_adminq_asq(struct iavf_hw *hw)  {
> +	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
>  	iavf_free_dma_mem(hw, &hw->aq.asq.desc_buf);  }
>=20
> --
> 2.43.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
