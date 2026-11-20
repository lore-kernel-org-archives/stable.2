Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795196479;
	b=tI1LMETmvC2YCgbBPP/MI16oMietg7BiMQZO21AmQpqXh+NfzqruadQksnP1TViCBqDI
	 M1FbKcqrKxIMaQ9QshsuMBq9xGzoX1blH4XyDAMDpfMJ2OxLFx0BecXLSSWqNPbR1cn7e
	 pDby3WXHGWxVnRFPFjLnMi1cLzutoe3Xir7C1Ut0OZ/KLrTSszfJCW12n+ynyYeM3YPVr
	 l7EWVA+RoYodRpm02OSVD1xq5qQXaez/9MtLmr133tELSlDOTGGynw4cQiAnVsew0cOi9
	 rMviXpdy/Hut7zmscihh6mVGK/egBwO2gXRfDRwkxoJGLqjUODhKmBc3rNpYkLKbTIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196479;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-slblob-mailprops:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:
	 X-MS-Exchange-CrossTenant-rms-persistedconsumerorg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CPLYPz4QtAqACrGQpfGQdBwyvjYgrPWuuc3UmqQmibI=;
	b=cMmLn6XsGJCoLumH+29DN7HH6QOgOQjSAxdGAkCTAFZrWbRfeZKDtlTf2SQmWUnUfo5q
	 q2RBiAisEtkOr2uV3+PS3Vx8MJFiXwcha02k1/9M5rYbiAaypZMCRJcYFROH51EIwaer7
	 wG8SEDxOj9e+utxEV3hRfdl5FoknlIOx0nB6Ah8VvLmGm5h7peVeedf12R4tr7Q4iHgO4
	 +AUB5iPZqeWu2TAzB5m5qJz7voC5NVTR9ECeOxkt9I0CjUd2zASerNH+RpsEw6+cQvdDL
	 NK+ZUwwIpXTstzAwzVvU/Sgv77N707ZQ3HhmenA1VwPNTHrPD+uevzryGPy7kFTk3Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FRid2cMH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.2.49
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9E60A6F43;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48A9E60A6F43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=FRid2cMH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdbLy4vvpqrJR5gSJ4Yh+8XTmeHs+HQLQxDmbn7ktTmsWNB4T9pAt2sd1fO4sWol4Fu9oOxqXDR8byy0MdCZBFLACRa0E6L9yqc5UEg3hgw/ZakysAIvOxJ1nLwcLKTAi8sMmFBEdxdG9JV58LRQXRIlnt36Ifyt6o2GO9s8640UW0QXQdfCQOVN1j+Pe3HlTGZ+oDfsGrhjmwDrebJvvJDWHhW9MnvUUV95XCCG5Cx865mJ7Zsd0ww4IUWpVO0M6dqjSDAIehivD/J+n+alxVNPgWoJueCSOLY0kH1ZGl9vvUgPyGf+y1tRV5508iWcernDMqkrHx18WzApVKQPhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPLYPz4QtAqACrGQpfGQdBwyvjYgrPWuuc3UmqQmibI=;
 b=CZfFq9vzX6omZzbedPHSgNIGRUqiSAf0i8DJaR+gdh5TZPYsTgvnnVjz783x6FJIpaBe68jmt6T73TWxh7YkoZhVHLz2VlnpmNSOpG8LsWs6aRsBDpdD0Syyes0p3rJnbU7422PeNw+KibKInS+wGX8VS4q4BTWHpY8sH5EQVv71RLC3bZgE/vj3h1KwvU7GejoNitRIr5AgM3VT9JYHzrEEQSxRDO9wB95qgc+Aw5/a1xk0RUggDbPozIOw1iFLFHB+SyRADNA6UsGSNqV9+9Iu6bmSHGbPJyIZ1FojjdkDOXPy8Fx+WTJlKgiUUPyicf4xY1kaXeRvE4UcQpWD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPLYPz4QtAqACrGQpfGQdBwyvjYgrPWuuc3UmqQmibI=;
 b=FRid2cMHutMIpZNdlAOQsBykTEFoMbXCDq7td6KRpDObqg4iq6MeaZ6ntNrIdj1XsOusffU//ICknKw20dlwpxgmQXILNLeMMUdi6N/gBlbC8dsC1VYDcPNruEf8pi+VJHOyB/lMuxq6ayFL4vV95w61SEXRg88bhtNQEqp6BOOICD5a4kU9inZs3ZxJ6KB6NekbqG6VAKQYhECgM/DK9EY3zeymolQAhjohc4n67gwClQNAzR1PMZVRDUmIIRIUZs15yhWjh6g3fL5Cx268kGVKsy6Do3/T1Pwtd268YZhUN3+07BqBP993TMkWZfEDSryqgMZ2Xzc410EuNqOsHQ==
Received: from MN2PR02MB6863.namprd02.prod.outlook.com (2603:10b6:208:1d7::20)
 by MN7PR02MB310162.namprd02.prod.outlook.com (2603:10b6:208:635::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 17:41:16 +0000
Received: from MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53]) by MN2PR02MB6863.namprd02.prod.outlook.com
 ([fe80::da67:fd0f:d96d:ac53%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 17:41:16 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Dexuan Cui <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"jakeo@microsoft.com" <jakeo@microsoft.com>, "saeedm@mellanox.com"
	<saeedm@mellanox.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "abhamidipati@microsoft.com"
	<abhamidipati@microsoft.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Don't use container_of() on non-vPCI buses in
 config block ops
Thread-Topic: [PATCH] PCI: hv: Don't use container_of() on non-vPCI buses in
 config block ops
Thread-Index: AQHn9rUsLTUIFzvGvhP1YJDkWhAeGLciMzHA
Date: Fri, 20 Nov 2026 17:41:15 +0000
Message-ID:
 <MN2PR02MB6863EA116937BB7CCA32E523D4782@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261119192937.570043-1-decui@microsoft.com>
In-Reply-To: <20261119192937.570043-1-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR02MB6863:EE_|MN7PR02MB310162:EE_
x-ms-office365-filtering-correlation-id: d41d6a30-16bd-4922-afca-08df472d7a4c
x-ms-exchange-slblob-mailprops:
 YfhX3sd/0TWTq462A1ci1xfPBdi3ebdldNybaXxwDD81sj3iZm1s90+kDBRaaVXEoNm+DIr2Dz56/KeMWfZXHHkd3tD12ZehSy99EfgDZNw9kGufawClCoYYRmP+gcEnX/mQ6KznDEJIRDfW4+QvfPLGobvsCF0VqpcBLMqmpXnds7mgSnzpEY2vped5XZAMKMV8NloBV6rvMEqTmTOZ2EuX4uX5tRaz1YY9j6KFB3+dbG/Bdujx4fFKt8vK5Um4BN+A9QUeS+WsqDBu9iWC0WwS4hm+FSmNH+dwSHN7YN5wMsFWbu/MG6GP6YFxsv4nGYPXOQp/K07OixPB6efnDu1rSEz7y558VBsXeBHo0MNsixfOiCZbZRNFdRpZYUlKhnYWxBuU2smvAiwXDS4EQBsUg9fXE/bD+3L+HJ1fFXthJ5Ys6owYJsyUoZZIdsaq7oYfdvY+GLFeq93XAdQVOufcXkHNxhON11UXwfQe56NCURcdF0Rjj9vXYKuLS3RRr/bTInMDtRgkE4AK4hQpquyQ4HB64NMOMngUIB2xtrcNu/5gCf5EfeVL2aN8pQFfVPq2sgnHbjoWOT5GmRkLlbwb6ZNRPABBFONe+qXmS3OUfjai8yA4fDKq878MS73czx2vNKHwrnI4pim9Pw1NvXp4WKNdfqH+y2kyCJL6mT7ase4Us7Bzho2pnVsB5ZMlyJYOws/kbXKtJ2YzGLFmjae1QYLNX3l63zL2plxjxjGQNRHSXOeFBL7GTInF3ogCCTdTH44dYszqqLBnar+R28/786cunXHYiqUBoebbudA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|37011999003|31061999003|41001999006|8060799015|8062599012|19110799012|15080799012|4140399003|12121999013|51005399006|24021099003|55001999006|13091999003|25010399006|440099028|3412199025|102099032|40105399003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?68IBUh8o3iIbqpdFsnR3pglWwXHO89sKSVgZGDdtk4L4ZdVu0UFaORxcZwC0?=
 =?us-ascii?Q?glLwhKWH2XdtFh5W5ppdTkJFHF/SfF3oLxVLfEX6wkSmFYIi4HGAmI1uUFMJ?=
 =?us-ascii?Q?PG/aa+ouFlcg4PYMhqev47YSSGRGjLY+cZtnZcM/yF0V/uFw3E/Vp2DiB/Ky?=
 =?us-ascii?Q?EIxGajJjYoimAcdts6eCPPQOVHl03i0phXeMopsOUcl7B0LWUFJeHY7MUBBY?=
 =?us-ascii?Q?M/5hAWH3ybZoRdhGzWvf/eeuiL6Pn1EA4/fWe1/tq4og8RcL7+grpberw+6j?=
 =?us-ascii?Q?FEhLHH30nmAE5WOWyfvt+ablHyT2ayAQmep1Ve4rzsl7zD0hLQYI/9Vu4iBS?=
 =?us-ascii?Q?0X90jH2Jifg05xQND+FWNnC7IaIn23QhDAIdhKS1b8Z6L5vRXcIqFMu5sk0g?=
 =?us-ascii?Q?3kyvIopqqkYeKLkvNlVJeCF34KXQahBiJM2vCFmtR9ZCkPBKCuwOQzBU7vAg?=
 =?us-ascii?Q?grQRHMxwLH7vH6l5IOHS7SLeDBErd0GQZa8MZZ+CkhHBjiODiZpaYuk2drcu?=
 =?us-ascii?Q?qN1A9Q3O6zpXJPles3DefMKaTck0FvuRkajxx63yVxH4EN1UjtrCG6mAEdsH?=
 =?us-ascii?Q?T/ZXjiLH9EpbXxRsXz6R8mBIhx6sFVzrj1y8H3AiSNcm6+b140Vgga+acjHh?=
 =?us-ascii?Q?5aFI4fVXfeK7CgLnslwxV1gGKbwF7AhHOpGgeT8hvki2DBkaO5Y40OqEPDvi?=
 =?us-ascii?Q?3fOVgY3vnSZWFjnWaDZBMloNvYvZNX4KOOFENdSxShuWZq6FY1Ll5QimlOqx?=
 =?us-ascii?Q?/JE/vabqrSOq+AHyHKXScmYLUUygzP6Lih/N61BBFdlkf6egzt10H0EPjD8u?=
 =?us-ascii?Q?jxuo6syRoyrpgTCf5eETfz6tkhQHehsNSURdNKtmCv1TLPmCJ42hNIzQbX6F?=
 =?us-ascii?Q?Es6FaNCjp2heGCpQODv74sySWjKca4L5a38ujsww0TJ5D+nyBepl7//0h0o1?=
 =?us-ascii?Q?IfsPKpjAeWftHW23HqoV8/LA3mTKuWyV97jHvTlCCE0+WThoDeu6X4bQDY92?=
 =?us-ascii?Q?8s9b/6hq1Oukwdu2H66HoJDcRUYnN4pYy7jWnhUva637P45SBIIQXiZxY1ua?=
 =?us-ascii?Q?wF2FbGJrkH95CCFOMoH0055JaSnbDoPpOJQibTIZyjhDkpgIoSg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MqYLOXZ9EkGXCve9LY/WOLEIcWBCj/IuIFBcdOvg7b+o4xDTLYkekVariOLi?=
 =?us-ascii?Q?xTIEr9f9wU8UNYn0Ohy6eFYGkQ+hOVaraMEQu1dNPweYh6UWNuQLHRAEJOYl?=
 =?us-ascii?Q?HV5/BNsjJpdR7DaKxHxQswyvoPbwZaHkL8O8w9rpJRYh4QMuQs8XE0Vl+/BZ?=
 =?us-ascii?Q?FD75f9Nx0OVjHl+JQmlsuRrB+/e61BYXqUdRd52zg27Qy/WbRN3VmC4HBmhK?=
 =?us-ascii?Q?TM2WaBp+dP0rTCU2iAZs3oPhlj8pcyMhO0XHA7oDG4EMFffF80uhL3cnmaWp?=
 =?us-ascii?Q?kcnfqd4SR6qIKD19QdLYxCoQfx2g25y24ZgR/xdJaKs8iRzg+YrPQo4YSz4y?=
 =?us-ascii?Q?0PxTxt3OPfXfX0BoRsML/O7YdYDCFigCrWDUI0KGFDfcd2ZcUrkuuNRwXqL/?=
 =?us-ascii?Q?AM6bNMOwiVVAnLo8yy+nh6i2xHC/ZizsUaCxwpPm+BLSq+KM+YDq3FO5ir5D?=
 =?us-ascii?Q?EJj1mH11dT7YhvIHY1IoBttOl+jR7PZbPAGuPdBSJ5Fk3m9nSB8hc4ZXtL3r?=
 =?us-ascii?Q?WJJwVSIK0sctYZQnMITGsbHrb2Lvn1f4HcWeazg1JvdIZe+JUG07ss/KQOkC?=
 =?us-ascii?Q?SQM9QxqIJxC1HD41HGgk/xbplxvnu9nY7J+5m6tztYlpne+io9xNoyvAVyLT?=
 =?us-ascii?Q?rC4nUXyYSwr8FM+VCiuHykskU1pYeFHumq4fTjJdkNdSz+X2B2ZM4pDsOuW/?=
 =?us-ascii?Q?HPOAi0uYBlpOnir9vi/9graQN+prKH4awyapXI5pPr23uRRoHRoccJqVTOdE?=
 =?us-ascii?Q?Kx9jhF4yjZWoDCpe7JP+OPI93sN3T0jMkznRgWcM+5AuGC4BZEuzmY0m9OFU?=
 =?us-ascii?Q?G8r/w4CcoIHbtozoo49LYaspf0k8JAU6nWHuUtmxRbXH7pJ3PtttZeaEn5XV?=
 =?us-ascii?Q?30FajE63G4ROJMtFbw7O9rLVs5fIarbDTYlpvMS2bCJlWqlUpOn+8P2LtnKJ?=
 =?us-ascii?Q?ubTsGmad4UovhM3FYEcH1PQNOjmMvGnf3ZjurrwoimtX5rVshCgVy533Ak3n?=
 =?us-ascii?Q?ZPoyPqdMToU/YBVOC7BslrcafSnUv0Q4qMW18XEiUXdTfD9urVQ1DOnL+7G5?=
 =?us-ascii?Q?9PdgOqIk1ueKSS4qeSRNrOXe9Fz44LMfzJL8AiHzjvV9Q/VeFKfoutnsMdNL?=
 =?us-ascii?Q?M86IBIhXgHZwM+uAkNT3C2W5aAH3SxTzyku5fb5ozv22FaEmaZ5Zx04/Wyba?=
 =?us-ascii?Q?s6V4j6utlhkkkXKq+i6HupTuYxlISRftDQ9Bfm+r8qIpGR0pna9eb0Tpg6bj?=
 =?us-ascii?Q?bM66TH/Bl1Qw+P1t6i/ZCUZ9aGpwWZ/P0ArQvLIRj0S5G07Ybvg4w8rhvemM?=
 =?us-ascii?Q?Mgv6ZOeuSxZse4fgof7dt3xtjNuMhGpntD8NY1Lun39wXcvPGiZgXVJbfIrE?=
 =?us-ascii?Q?eL3koJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR02MB6863.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d41d6a30-16bd-4922-afca-08df472d7a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2026 17:41:16.0682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN7PR02MB310162

From: Dexuan Cui <decui@microsoft.com> Sent: Thursday, November 19, 2026 11=
:30 AM
>=20
> From: Aditya Bhamidipati <abhamidipati@microsoft.com>
>=20
> hv_read_config_block(), hv_write_config_block() and
> hv_register_block_invalidate() are exported through hvpci_block_ops for
> mlx5_core, which calls them for its PCI function whenever it runs in a
> Hyper-V guest. They assume that pdev->bus->sysdata is embedded in a
> struct hv_pcibus_device and use container_of() on it.
>=20
> That only holds for buses created by pci-hyperv. A Hyper-V guest can also
> have PCI devices behind other host bridges, for example the ACPI-enumerat=
ed
> ECAM root ports used for ePCIe (emulated PCIe) device assignment on Azure=
.
> For such a device, container_of() yields a bogus hv_pcibus_device, and
> mlx5_core crashes on a ConnectX VF. On a 7.0-based kernel it crashes in
> get_pcichild_wslot(), called from hv_register_block_invalidate() while
> the VF probes. On a 7.3-based kernel the VHCA invalidate work sends a
> packet on a bogus channel; UBSAN flags the spinlock, and a paging fault
> follows:
>=20
>   UBSAN: array-index-out-of-bounds in kernel/locking/qspinlock.h:68:9
>   index 2129 is out of range for type 'long unsigned int [512]'
>   Workqueue: mlx5_hv_vhca mlx5_hv_vhca_invalidate_work [mlx5_core]
>   Call trace:
>    queued_spin_lock_slowpath+0x644/0x6e0
>    _raw_spin_lock_irqsave+0x98/0xf0
>    hv_ringbuffer_write+0x98/0x340
>    vmbus_sendpacket+0x9c/0x100
>    hv_read_config_block+0xf4/0x1b0
>    hyperv_read_cfg_blk+0x28/0x80
>    mlx5_hv_read_config+0x6c/0x130 [mlx5_core]
>    mlx5_hv_vhca_control_agent_invalidate+0x8c/0x280 [mlx5_core]
>    mlx5_hv_vhca_invalidate_work+0x88/0x120 [mlx5_core]
>    process_one_work+0x1dc/0x5b8
>=20
> Commit 0d5acba6331c ("Drivers: hv: vmbus: Export hv_vmbus_exists() and
> use it in pci-hyperv") fixed the same crash for guests without VMBus, by
> not installing the ops at all. These guests do have VMBus, and their NIC
> and OS disk are on vPCI buses, so the ops are installed and a per-device
> check is still needed.
>=20
> Treat the bus as a vPCI bus only if its ops are hv_pcifront_ops, and
> return -EOPNOTSUPP otherwise. mlx5_core ignores a failure to register the
> Hyper-V VHCA invalidate callback, so the VF probes normally.
>=20
> Tested on an Azure ARM64 VM with 8 ConnectX VFs behind ACPI ePCIe host
> bridges, with a 7.0- and a 7.3-based kernel: all 8 VFs probe and their IB
> ports go Active, and a test module confirms that all three ops
> return -EOPNOTSUPP for a device that is not on a vPCI bus.
>=20
> Fixes: e5d2f910cfec ("PCI: hv: Add a paravirtual backchannel in software"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Aditya Bhamidipati <abhamidipati@microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> It's based on the PCI tree's for-linus branch, and can also apply cleanly
> to v7.4-rc3, pci/next, hyperv-next and linux-next.
>=20
>  drivers/pci/controller/pci-hyperv.c | 36 +++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 824cf27e85e67..029d66a171216 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1451,6 +1451,21 @@ struct hv_read_config_compl {
>  	unsigned int bytes_returned;
>  };
>=20
> +/*
> + * The config block ops are exported through hvpci_block_ops and can be =
called
> + * for any PCI device, including devices behind a non-Hyper-V host bridg=
e
> + * (for example, ACPI-enumerated ePCIe roots). Only devices on a bus cre=
ated by
> + * this driver are backed by a struct hv_pcibus_device.
> + */
> +static struct hv_pcibus_device *hv_pci_dev_to_hbus(struct pci_dev *pdev)
> +{
> +	if (pdev->bus->ops !=3D &hv_pcifront_ops)
> +		return NULL;
> +
> +	return container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> +			    sysdata);
> +}

In addition to hv_read_config_block(), hv_write_config_block(), and
hv_register_block_invalidate(), there are two other functions in
pci-hyperv.c that do the same mapping of a struct pci_dev to a
struct hv_pcibus_device:

	hv_irq_retarget_interrupt()
	hv_compose_msi_msg()

Also, hv_pcifront_read_config() and hv_pcifront_write_config()
do the same thing, but starting with a struct pci_bus instead of
a struct pci_dev. Maybe hv_pci_dev_to_hbus() should become
hv_pci_bus_to_hbus(), and callers can pass pdev->bus as the
first argument if need be.

Finally, there's hv_pci_reset_device(), which currently does the
same sysdata container_of() trick, but based on the bridge. Even
so, the struct pci_dev as also available, so hv_pci_reset_device()
could use hv_pci_dev_to_hbus().

This a long way of saying that there's a consistency argument
for using hv_pci_dev_to_hbus() [or hv_pci_bus_to_hbus()]
throughout pci-hyperv.c instead of just on the hvpci_block_ops
functions.

Separately, it seems a bit fragile for this mapping to depend
on the sysdata memory being allocated as part of the struct
hv_pcibus_device (vs. a dynamic allocation, for example). Of
course, that's the current code, and it works. But I'm
trying to think through whether there's a better way to do
the mapping. Just my random musings and not something
that needs to be covered in this patch ....

Michael

> +
>  /**
>   * hv_pci_read_config_compl() - Invoked when a response packet
>   * for a read config block operation arrives.
> @@ -1500,9 +1515,7 @@ static int hv_read_config_block(struct pci_dev *pde=
v, void *buf,
>  				unsigned int len, unsigned int block_id,
>  				unsigned int *bytes_returned)
>  {
> -	struct hv_pcibus_device *hbus =3D
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus =3D hv_pci_dev_to_hbus(pdev);
>  	struct {
>  		struct pci_packet pkt;
>  		char buf[sizeof(struct pci_read_block)];
> @@ -1511,6 +1524,9 @@ static int hv_read_config_block(struct pci_dev *pde=
v, void *buf,
>  	struct pci_read_block *read_blk;
>  	int ret;
>=20
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
>=20
> @@ -1581,9 +1597,7 @@ static void hv_pci_write_config_compl(void *context=
, struct pci_response *resp,
>  static int hv_write_config_block(struct pci_dev *pdev, void *buf,
>  				unsigned int len, unsigned int block_id)
>  {
> -	struct hv_pcibus_device *hbus =3D
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus =3D hv_pci_dev_to_hbus(pdev);
>  	struct {
>  		struct pci_packet pkt;
>  		char buf[sizeof(struct pci_write_block)];
> @@ -1594,6 +1608,9 @@ static int hv_write_config_block(struct pci_dev *pd=
ev, void *buf,
>  	u32 pkt_size;
>  	int ret;
>=20
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	if (len =3D=3D 0 || len > HV_CONFIG_BLOCK_SIZE_MAX)
>  		return -EINVAL;
>=20
> @@ -1652,11 +1669,12 @@ static int hv_register_block_invalidate(struct pc=
i_dev *pdev, void *context,
>  					void (*block_invalidate)(void *context,
>  								 u64 block_mask))
>  {
> -	struct hv_pcibus_device *hbus =3D
> -		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> -			     sysdata);
> +	struct hv_pcibus_device *hbus =3D hv_pci_dev_to_hbus(pdev);
>  	struct hv_pci_dev *hpdev;
>=20
> +	if (!hbus)
> +		return -EOPNOTSUPP;
> +
>  	hpdev =3D get_pcichild_wslot(hbus, devfn_to_wslot(pdev->devfn));
>  	if (!hpdev)
>  		return -ENODEV;
>=20
> base-commit: e735de71a2d9403fa1e2d134d1e9aa0a24f4eaff
> --
> 2.55.0
>=20

