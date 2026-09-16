Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35E529403;
	Wed, 16 Sep 2026 14:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569070; cv=fail; b=S2XC++DtyIGZ6xnMf57f7q2ET1W0blZxUZJ/WjG5unfvJnZuWWkBDizjMvZIptSziJUEg8xERqFRam+UgN7q39jyz3mJ3Pe1EPdgdF1o1Maa0QsbBpgP+tEr4mlSf+o8qiyRuA4fGSMYy2T7tCtk/iJe1NNZ8so/SM+Lj4jbCG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569070; c=relaxed/simple;
	bh=IF1GEOxpS97fliTjKATbOeOufN+dyqtN6eXNdz0nye4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U3lJEkaRwD81WMAWVz57//7Skbpy7rpiD7voTvcipBpkHYrYL5CPfDEI/AHZpH9Z2GzxVoJNo10TnKdwUiGIvOl3RYiQWL56zheq8Z6q110m7jlZtW9xmTcqr7gJnTvlp8Qy02DNgOjR3g9wHemxYjjY2TRG74RE3Y+b77gGlYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nH5ysxxj; arc=fail smtp.client-ip=40.107.209.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nH5ysxxj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhJ3ryT2BErgmJQ9qKNnYcG9azAcWRZM+upkO9oGfoTFZ0R9VGTcdcqOphLs643v3RF/JKW1vmlOTqSZ6JxWRpsscKsHTc5ARmitqiovt668TQ4UshmSW7swXkeUb6BpVZjT3pMSqWyjXkMyx9bf/SdTtbjhiyy2lNEd471RsbZn2UiektftYvjfZe1noAB9nIJSECZKYalcvW23InnFseo5Ef1W/ifA1SkByc51QEEbGzB2tPbwp8/XjGDc9Q3o6iyAwTeg863vecV0xVdxt3RHtleuysVB68PuZEy2kAaohL83XlcqDgpBxFK0XR8ChTZ33DnK4789KEGiZHcyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9in0OEwxuHb/w73mziFLaOmx3EanchllhaQsIk/5vY=;
 b=buR/tT4aCzUc3WCKNKS1MsFLJYvTCsXRj0rTvwHPvFEg6J3Y62z5mNJeE8mQNEm3rs2GufGvtwziWd4QJNPQLOPeUNYaOBqvBIqLPZb2mhXy+MJNLY/BWKUwWz1o78TA0M+2cAdyUvT674O6jb1Ir6om3fmVM7aq3MAfEG7wRZY4mfaZQu2Rud495nnG7lmoGq6rnk0lVCGtE3YuqxQvsj0XA6GmthdIi4COQ/kO0nJM99gaPzBt9WiI2A0WMlZrj8drxWBl/DmS0oGGMxh5kPJcaLNdeJe18K8ArQBJgM1cBPqOw5K2odAQ/FK0ui5W0CtXHIa6hukT8iNIHZm38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9in0OEwxuHb/w73mziFLaOmx3EanchllhaQsIk/5vY=;
 b=nH5ysxxjK/hI9kDS3D0ccusPtuuxHFzJt1GToj1SMsTSXz0uaP044gtBrAPyX698GhPG8mTmYB0tQLLSYgLOaCYq5sdZ50uGffNkytOeA3wOQ6qgPflkfokHFM/nn0XsEiLuBlbN1QOlCD7mS5P7Z+rNQkLv7uSF3dARdup9R8yeRQN7QuRr9HoOV3wxi7kOH9svkH+Chbu2vnbTbPackR5L0EXWPuKORuV3l+Bgct5wmqYjr7qWy/VJqzL0k5tItPdNf4FrBR0Dat/uaBCpGwGyGYBk4y0cZolxr+lFJ2TmJ5VunL6cR8XsXumQdAObB5ed2ixsApv0rqJlGEj1WA==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by MW4PR12MB6731.namprd12.prod.outlook.com (2603:10b6:303:1eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:31:00 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 14:31:00 +0000
From: Leo Zhuo <qzhuo@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "bp@alien8.de" <bp@alien8.de>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Leo Zhuo
	<qzhuo@nvidia.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/i10nm: Fix mdev reference leak in
 i10nm_get_ddr_munits()
Thread-Topic: [PATCH] EDAC/i10nm: Fix mdev reference leak in
 i10nm_get_ddr_munits()
Thread-Index: AQHdRbyPjeU5CR4qxkmN7Gkq0B8GarbRRAGQ
Date: Wed, 16 Sep 2026 14:31:00 +0000
Message-ID:
 <CY8PR12MB72900C28C2AEC0A56092DE92D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20260916091251.1997522-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916091251.1997522-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|MW4PR12MB6731:EE_
x-ms-office365-filtering-correlation-id: 09a59f52-7248-497a-9645-08df13ff2104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info:
 MSiinoqN0HNA+iM2Shb8TGIrHETZlG25Xk4MRCVi+Cdg0D9xWjVjZBypErKZhBYvvL6ENJWXABbSjsBoi6eHa8EJHglgtXURe5ZPfkjn1Dml0uzjfV+L9k4vASUkBXeygB/t97gDeRUutKHTgvYUxIYnadGzsbjvetJNwmcYmDQyZA6himLVs9+obWFW2oRjgYWIm/LevXO8fpnYUheo0osMbVVwr+ata0L+uxMacfD0dnukkzv+//0IBZZqACgUKytmFdpVGK6Pa0bcx0fcWFrMN+3kl11T8BB+Zf0x08PDAq0gBOB8SPSYamGyElRbwaS3cQTmmu1poVLsxSJVjQmP9R4yON1FYljfvaUqj9ESis7AdstQKgNRa3JNFV3tiVMegeV5MrAfJjBrT54HAfBR93LrVioXX5WH4bnUXGr/mCpJNlHgSe4YkHFDepNLFtTtTKuUJDO/m1he96XPQME37Izo1NP/VelR1KDB67/H8P2JhgDhagImFD+bUSIuF5FbU6MsJo/9wK9nv3vbepypfGILq0SFD9KdgBag2g/mwRhinxVGL1D1+5YKutRipRI0WuMDKUZ0umDgXbyHX6OkeEMcMlQhxACLQm3aKMeqSfiv7y8OV0oHWFjFDVUO4MJ+hSTEZj9DQ9fmiDpYeTrjajAJHb+lTbU4m6HqGRlR7kfhNs7x0Di5tQiBCfRhCRpXaXTUHtnpgvdeR68Df81JArFR8XjrPoyZAXYfCJ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qd1kdB58unxwb8TkkH+Lo7NKzm/P3tlrGMt/5JXAbROGwVXbDEeOBdSSEKHy?=
 =?us-ascii?Q?mopGTjOa12FF/DMhz8wuC9rUvvF3KCKe3/ufJgIBNVOdjBfWOQP37XGDPm1o?=
 =?us-ascii?Q?ODAmB834bRYGbaBXDlKHfR4Yx7dBhda6aPtlB1HuLFJ49eDGYGOaQfWOfr06?=
 =?us-ascii?Q?IWhcsYOmmQDt97tqZ2YZi/Z31GQesSbLsNdPFca9rAbNKuLSbeAHt3betIqm?=
 =?us-ascii?Q?/hw4ydqnM5cg9NjmtMikcvarpIyiHwxRkYf7YR25EoWJm9NNlMl1xDTGS2ve?=
 =?us-ascii?Q?fAcrrzi+X59Rg6PYnAE4RgHmAf/3F7oIAHfaa+KxTgM3UwVj+DOu7DjdlPTb?=
 =?us-ascii?Q?FBXyh1jv26aFqPy5p/ii5f6CGyJ6XjZ2jYv5f6Eg/fr2jcqasylRr8I9xfmy?=
 =?us-ascii?Q?Puiu06JHkD0wrL+zUEX4v6FK2GT3vMZtT+EYO79G260VaylVBpqXaW1Jjjtn?=
 =?us-ascii?Q?AkLv0OWwy0+OY2cs0QskS9TXLtovWtU/1tt4H/mMr7e+15AaZUQ25t8nvYJe?=
 =?us-ascii?Q?E1dDsyRSAekrcCt1cM8CJYoDCOi+t8objzrKkI29BuR51/3RczUE4AzohxrJ?=
 =?us-ascii?Q?PmgkLsloFMaYMsGmbcRbY4BBbKagVo6ajUOy0uL6scn2yL6VUZvDj0UmKsPj?=
 =?us-ascii?Q?0p2z/oyij/UTvkZT1BYEMP4aucjWzAGBAIvTnbKnjldWGADxEdMFao5wHMFM?=
 =?us-ascii?Q?pB/9M/rpWBDejx++rIF2FGsQyLmTQYRqflvadqn8crhy1raVE+67Fx5xsgKr?=
 =?us-ascii?Q?f144XeEpAZSsSHgXIC8XkWDMjxADGqKCj6b4CbxwGoyX6FGsm6qI73hJX0bi?=
 =?us-ascii?Q?2j9lNuhbAgNleFeC2pSmmhgynTF5Z+HTM0icH67gIfOWDUsbGnwWnzMTt/6l?=
 =?us-ascii?Q?Kbe7dn6vAEZWQ5MVSchznD7FpB6yG+jyqQjhCP/fUhwkU2pQwoB9xw16ouqW?=
 =?us-ascii?Q?xcsBbo1AFv3i9OS8dmn6hhIjSmkFbrE3mOgckLN1ciNyHI3eiWlR2ryYX3hl?=
 =?us-ascii?Q?qscK6BTanvAUTp//+LiQSd2Qp0v7nWJ65hlcccdJL2lE2sHJtrN5y2/YhCBZ?=
 =?us-ascii?Q?1SQ0UNnqFn/Z7WNYRocc/yrOuz/k0uMruTAGR2JmSXF3T7welWAWE1DNRycX?=
 =?us-ascii?Q?Ac67kmVgsus+5nHIqfIbfLJJLlEcJsJshz0N4e3wrCy/ROZo6OTzVTgCC+Ko?=
 =?us-ascii?Q?WHWYl2DPLc4Vxrq9Jj8qhttzAQj1UBD772Gb9aAY8gc/vWGNIuF1AmwaYf8a?=
 =?us-ascii?Q?W9XKagc1KPKzA/9+SW9RtB7hPiCidS/hYjN//gkCHajjznqltzo0LD2I6hhV?=
 =?us-ascii?Q?kCrUMLF0WXCiGUXUSiTs9Hn+p2l2MZIhk5Dydpzb88Quf39Dlfo2zChNyiya?=
 =?us-ascii?Q?4P15uyjyFua414nNPQfYpSZQ8bhl/VVZZvbbQ2YWE1ao+QTRFVzhA4vWTut8?=
 =?us-ascii?Q?+FU+eFgFekK/zdchbXQB4A6RZE2EnZboiGcSf+pUAfiCkGx0x9777bwxohBB?=
 =?us-ascii?Q?QWqSanCjejaCNijKoaSLhL/UfO6fm5U6SKrP8HhqJaXbfuyKjQisDDtjOhTn?=
 =?us-ascii?Q?ahwMF1yo/LwXkuW5J8h0675hMdih302nI/z7pvriHECp68v+OAya4VrNYPCm?=
 =?us-ascii?Q?8v8hkRypnZl+XqJNlgqCx4fhoc17zmSvmkvRFJNAvK9hmA2cJ1tos974r3Wz?=
 =?us-ascii?Q?8ho24b0HiCMV4czc1orCQ+SZfOq0fjlR1Gw32tCgdDNwURlh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7290.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a59f52-7248-497a-9645-08df13ff2104
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:31:00.0862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyOqPXi8q0t3UJoyz+YqyOOmP5Ul9LcY4vTbxm+3YpElEb5e4GkvDoeRDxWAqPJuBM7kpI3M8eE6rDO8sSxHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6731

> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:13 PM
> To: bp@alien8.de
> Cc: linux-edac@vger.kernel.org; linux-kernel@vger.kernel.org;
> qiuxu.zhuo@intel.com; tony.luck@intel.com; Wentao Liang <vulab@iscas.ac.c=
n>;
> stable@vger.kernel.org
> Subject: [PATCH] EDAC/i10nm: Fix mdev reference leak in i10nm_get_ddr_mun=
its()
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> In i10nm_get_ddr_munits(), get_ddr_munit() returns a PCI device with its =
reference
> count incremented.  If ioremap() fails to map the MMIO space of the memor=
y
> controller, the function returns -ENODEV without putting the reference he=
ld by
> mdev, leaking it.
>=20
> Put the device reference before returning on the ioremap failure path.
>=20
> Fixes: c545f5e41225 ("EDAC/i10nm: Skip the absent memory controllers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

LGTM,

  Reviewed-by: Qiuxu Zhuo <qzhuo@nvidia.com>

[...]
