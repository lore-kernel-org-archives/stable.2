Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F05111B2;
	Wed, 16 Sep 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569638; cv=fail; b=jE7K2K5exyqVZ0dKbrQdYJUHsRM4etIew1votzUBO656kqpQYpquJP0u27gSAn8zRzn8oxujwDlastNAZBZwJxSx1ShJmaAJy2l9Pk1bMGDV92E1ne8+U/KTMNBpzAsendP7MmfkDe1q1hK8GqoUa6FuxtK+/TJt0SJX+r3SHe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569638; c=relaxed/simple;
	bh=VnmlzaGEyKIqBfpdtKfz+bSuLo+N8fgWUWwUR8/SBnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=svKRv8FkFJKyV3xbrhzICNWPKXTPEAhxiOD3eF/voNieaOwvGaKsjFxhGIW9G4xEeB1iiye8jqruToHnukYG5MG24PrSFGNWosJy+RM0lmdNcddnPQkUBlAWQYjfAJwyledIjIOOzBliWTz3sfJ3OE+x/GDR2h3pNs0uNrsUSwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SVWvUm06; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SVWvUm06"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upWgmXiaHCiwqjVbH6YD5U83bkkXLaj1k0Zc2L4KJeSVqFFSp+z/WdgI6X5ffdf+p/lK7os+t0pxPjjw++iOid8Ton1OycstK/NVMmgy8J/LR8hAIU472MSwyvUJSyXmfJFKFGaWv7SQ4Voha+go5eui9Wt7wYjtjLWU4p2Pp5SRkI6xko6dUrZD0arsGcvXbOC7REspi2tTti9kawMHmGAWCo2+MIeHaXXNJcEYInX2wIcsacLRO/+MsDAlhn2hqRNsooDfPU5ohWcYuUoD/nhB0aA4z1a4Tkob9SxTxw16vX7eQCbzhC5KlMwc7eqTYqUC7t3OmCXiysf2QdnG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVMIyfCKj3CM/PNMm8uS66lJNu/Lnjo3I2TEV/QGzUQ=;
 b=YYnqnSgljcM+3XiVk4XK4UyA7LO4Sf5qfesQN+F+ay+BCS1ywHCSUCSaNMKlDnvB5VsreXEH9Jx6Pjd2bjUARdH8Q6+JHn0zuo/Da0aSNMpWJUA8oRjvgh9cpEsoKoOPWqLZNQcHFutYAVAEazRZJ7MFBxZ0lfrbKFbV4WPhXqC1RCjOxCn+tjIAQ8qRx0aiaVzx1dgBw5UJLUSHb72sEZNcxxm0FDfKquRxGGB8Vm+ZTzv4+lzeEC1ioa0fI7rQs3I4f5/C2MwLOAxTMonba/9gkUHE3wBAlQ+FlGv9O+MKsL3besOSAniNBD/r8aJIlx0pu8re+kD8HzHC8bkSJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVMIyfCKj3CM/PNMm8uS66lJNu/Lnjo3I2TEV/QGzUQ=;
 b=SVWvUm06XbIqxE1XvILXRPL33TXkyj+GeTzJSTN++5ffNfiGZTxNnY8kIJQ9nG+6wQGHzT/hKVF6SMcFK4UIu6VUNpZUHMOXE8T5Y01JsdMDHhuNtTUtdanSQCo7hT42/AHHXcUmSxJgi92KQKIVofWFBSjw3Ip0bbm+vMO/ku9RED6/Ue7juveU/QTQtxSpPQ+HWk5kua4qjOC+sVd4ct4iXgBY5QxYS3dl4eVHn0TVp/cpPs3gihWMqdlLEEWHxLX7/VbUsZX25kE01rHPdZWBGe5Gfv3/6joTzxvCohYsV15iYB7p3DtkXXlNIYo9NKnZ3YBgnrP9Aa47vjgYNA==
Received: from CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13)
 by CH2PR12MB4213.namprd12.prod.outlook.com (2603:10b6:610:a4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:40:29 +0000
Received: from CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc]) by CY8PR12MB7290.namprd12.prod.outlook.com
 ([fe80::a8ce:7b9b:3e72:d1cc%5]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 14:40:29 +0000
From: Leo Zhuo <qzhuo@nvidia.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "aris@redhat.com" <aris@redhat.com>
CC: "bp@alien8.de" <bp@alien8.de>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	Leo Zhuo <qzhuo@nvidia.com>, "tony.luck@intel.com" <tony.luck@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
 broadwell_mci_bind_devs()
Thread-Topic: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
 broadwell_mci_bind_devs()
Thread-Index: AQHdRbyvnYLZfaHSNkmBKoChwGaW0rbRRrrQ
Date: Wed, 16 Sep 2026 14:40:28 +0000
Message-ID:
 <CY8PR12MB7290BB10F55300D62978A584D1B92@CY8PR12MB7290.namprd12.prod.outlook.com>
References: <20260916091721.1999379-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916091721.1999379-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7290:EE_|CH2PR12MB4213:EE_
x-ms-office365-filtering-correlation-id: 3728acaf-09c9-4970-7726-08df1400741d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info:
 4GfgeJtqq4YU1crTSBNpyaP29+UmUMe3Tccx7dSMfxXweyjftqm4Prjh4SZee5a3wf/QttWgTtF43SDDgXUML7T5jJ7D1vrRR1HAsMf40h5OuJgntu32cfpnv5kvVS162qks3Pg0c4cvXAJy+p59trR/8WfLBkbdKXgaEWAAp1uj4ctKcOFBdFx6628SIbb3ivgthH36ozcNQD8r4OGgrzcTVkIpqNM9s3kY5FjIXD2Xoe7kqU1rtaX9eCuzM2Phl2TLjlTA7GBGHblBbwSHBRPboINeeDYF+N4j0MeNzn1Xppk79pGUEMoEeFrOxPzOfAvHrDo1zCZbJxTf6BRb/r0Lbv9lTPWpIOin8FCuCtgLQIl6jco+i+b2qBEhfJ1v0R8Di0HdJdhU8NYcvvP8Kj6elMclcdEZ+bfI9ttqUm07bmXMB2u9pkrgNpp8rq+7dSbfOIvAn0aL/keWYgFDLEJTTbLcxDGGpjZHkaK/Gn9zpqUWKaBYwstSxtxevgrG47P9D92f6QSBWTdW7fEuWbsx0oBeSeyL/R9dqLQgtuX2S2xxH3hbZwqqICgzz9qerG6JZpNNG8Wvvw8dCbc9miHlLH1UbKFIbzTH+v6aH39vXkrk+YZJ2BmoUDUnF1sKd1yurDSgNSfkrMcO99+m/w26E+X+1XMx5hbY1rS3kdXbHq6iUBY4FM7IF7tKMCSdq2Grlf9qZqyzGkfjz3ajw0yHUxd9vxXTsTVTMVTP/NU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7290.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Rt2xFzb32C6Ni0UMgYM6eBTZyXCoT7V+ad3uefQD7dwwKW32rHjvXlO4192q?=
 =?us-ascii?Q?lUVcoZUc61/oEyDy9FK4EXTR2iy8Ssec2YyVQb3DkNCwBBE7LlOG3mF0u/qY?=
 =?us-ascii?Q?qkwIhlkgIunoULk2q9HAPgmAxWZQ6Oqm5EKOqQOFV6kbL8I2YaxKTyL0bQ6D?=
 =?us-ascii?Q?F0xyOW9uBx6WiRwLf5+WtyDqg0CCdSwLAYETzjIGKrm72UACgygCzGLz9t3Q?=
 =?us-ascii?Q?kWWF431l6hSTVcEliubfId3thrS7x8XO/owuO2sAyzB1WhjwzKlrPSnLzgc+?=
 =?us-ascii?Q?rTsT88GY/RVq8RreGQXiDbh5xagGW68MtIXFBOG9PHv+VJW4TCYengE05i7Z?=
 =?us-ascii?Q?O589euuAzihsZM2Gx3oho0Aqm1Q2VKgbG4l84AMBYsoQzixkwv+3nRpq7ffp?=
 =?us-ascii?Q?s0BjtRaDyrOntprp/tuly0A4udXSW0/Up4MDo/haMGVZ5CHbog/9R6Zg9kZU?=
 =?us-ascii?Q?x+wX7yTm/WpPKCRxzYTk9Quo3ph7ZQ2xmN2P5pQX/avhOJkZKfndhqTmuSey?=
 =?us-ascii?Q?/O1jYbJYBdqVD8kx+mNYdFgSmLH9XcA5LUALRwdwQC9wnRBsQWpl5u+BprFQ?=
 =?us-ascii?Q?NjXeeq+OzIglARe8Jko4nIXJl0YmFC/z+eCP1HJqH8By0ObFfsfJxJdd22Rw?=
 =?us-ascii?Q?mcUTJJttSkkIdbwmp2PVDfszjTWM7vS5WzdqJ65Al7c8aCAxSG1l7UZ7xgWO?=
 =?us-ascii?Q?qTUDa+GZhYKSXKuRvCGwnCICQ9+tHfBPSGr3JFJB/g2mU3oDJeg+PYB5Rzmc?=
 =?us-ascii?Q?rSp7zvri3Xk7AAcs7lbJX3aWnWT2Z6pWe8K9hnerMMCmYvDdxQPxoPEQ0rGE?=
 =?us-ascii?Q?Jn0o5Du022F9t5vm2qHSI5Vj5drkCulS//4HvuYr0zxEhZY4qtFt5fW2hmPd?=
 =?us-ascii?Q?67+bIAjRiHupmdZFgwUy9dK8pdgWDjcetFnM+lPkZOhakv9jBMeWRxnzpzoP?=
 =?us-ascii?Q?pATgxbNNK2CxgNhi2yPIKc/PJxdVOl8pV+/nVluJn0+Ce3EM3Ts+5Fg/4Uks?=
 =?us-ascii?Q?Upn6cTWHEbAv049OXy22QtnCjeXCYkrwMvIkqjnsHAyJPe5/ka4N+m/3bZEc?=
 =?us-ascii?Q?DihHIvZhviA2749MqdZ7jusE+FyTXXX+jbkcWKF+Hd7xODuDPXFwUVUGtL0t?=
 =?us-ascii?Q?bC82nQrBWf7qWYmhWt1o+pBG1kacSHNdfAYEpUP/FlRwKvrDOTtzOV3Uz0Hb?=
 =?us-ascii?Q?4zYbuC8Iu2wj2PGSs9Dw3xfbAEoT/skWuDOHT67kQ5dcxo6X+ZkUrdEob4cC?=
 =?us-ascii?Q?fx3dL9M+KBbnjwGoBRwHwalzdRqdKhz1MTZdH9/nn9sOZIJxcf57WtMmpuA9?=
 =?us-ascii?Q?jWV1J/YnQnFRDaboTUSQVJbqEyfhC7hw6N+Du5YLZB8gFweEjT7SgMhFWF7R?=
 =?us-ascii?Q?N3POkntG/Fs/QQkzsQVKIVu6uIKgRY/wmDeychDvdsXd+oBbhI9Ut5bGaQvL?=
 =?us-ascii?Q?McB7bCTgz05IfY1NnxKxCoOW+q/CzZ/HfqHnlFxu6sd6Bkte3PcMPbauNKDq?=
 =?us-ascii?Q?VEYW19YfaLn5QSft7v7XTZTDiUcrt9+rG7e4FgKYUSAui6KgByPNkyAKebUr?=
 =?us-ascii?Q?KeE010yxZUbw1OLfYxMEbSZDSJynhdyVkTSXtMidHnnBr9n24iatUNV3+FF0?=
 =?us-ascii?Q?RUmGCFT8P8z3niFOXNbV8T1Hd7HHqoPXrhQwA0OsHNk7cf833LnSsso1/cC6?=
 =?us-ascii?Q?qAOwdwSI/Es1fCU0s3F/ZxZQEVfmj1kAeinGiRG1tCf/2nE6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3728acaf-09c9-4970-7726-08df1400741d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:40:28.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0J9kz0/l723cZxl5bvUCKie+Lusm+R6N1KzAbNf/Znel48ElECosZrZHEUsWRGl+q7K/LyNrJBvbwixfTFIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4213

> From: Wentao Liang <vulab@iscas.ac.cn>
> [...]
> Subject: [PATCH] EDAC/sb_edac: Fix pci_vtd reference leak in
> broadwell_mci_bind_devs()
>=20
>=20
> In broadwell_mci_bind_devs(), a reference to the VT-d device is taken wit=
h
> pci_get_device() and stored in pvt->info.pci_vtd.  If one of the required=
 devices is
> missing, the function returns -ENODEV without putting that reference, and=
 the
> caller frees the mem_ctl_info along with its private data, leaking the re=
ference.
>=20
> Put the device reference before returning on the error path.
>=20
> Fixes: 1f39581a9a7a ("sb_edac: Add support for Broadwell-DE processor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/edac/sb_edac.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c index
> 5075c703e19e..7ec29e50f5d7 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -2929,6 +2929,8 @@ static int broadwell_mci_bind_devs(struct mem_ctl_i=
nfo
> *mci,
>         return 0;
>=20
>  enodev:
> +       pci_dev_put(pvt->info.pci_vtd);
> +       pvt->info.pci_vtd =3D NULL;

See comments:=20
https://lore.kernel.org/all/CY8PR12MB72909C59B4374AB917E1D99DD1B92@CY8PR12M=
B7290.namprd12.prod.outlook.com/
