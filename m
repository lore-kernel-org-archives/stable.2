Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F639EF0C;
	Wed, 16 Sep 2026 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565154; cv=fail; b=jakSl/kN35CEbBruKtuVqt+UkW1UA4L3zEhj86GWmMFjU3CPSe0Z3Dz8GGh0T7pC65OmsIt+MW39kHba4V/YhlmGvi5oWlZQ2xONEnr3f6QbUjzgzdZmCeHPyFZeEvzPpEeEWNRXoUDBXCRy9GB+U73g8KJbLEnzRsZ58k/V0LI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565154; c=relaxed/simple;
	bh=P3GZnsIqGJt/Q9jqWsO1mRVfTjIxTFkI2wwtbDLa31M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLcwDtCg3+wHaorXGzGYHHUyhuCjjrUf/ouEL2UR95IrAyuOIDUNxuBA2vBt81GCiZkcISFNb8BdnIU6EDGQ6IhpTWaCNxTIAKjR8asyJYcRsxYDimsDmGm241apVdGshsHNILZnSv8+wYcnYG9DmDdakHM3v5XyCcHDvH9qHLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMsrTnwd; arc=fail smtp.client-ip=52.101.46.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMsrTnwd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jck8gIlCJsBGNedDW7i8HZ795bXRBUk+SODmKhizGwGWUOa3m7TCa4ukOI7NVoubiXhH6AVwy9NzIlVKislXrnN2kbW+oFdTPzRDyYAm4fsI0c9YhwBLYGUpAAIVKxXlPw5VglRsJWh39CN4ymYoVOYieUDSZlsxkWQokiTok0DcoQa676mFjB3NUl88TIn8VakdXFVuzgo2ElWn1QaM114WSn1AQ+f9syPuSE4zHfcR6qU1bABh2QbsrXhLNsSN9I36kOdArTcxrjAxhhNeM4CzJGbi/0vXlTSdYRrXnohoQmW83yAM6heYRW6Wxn7qUPkIE6PAv+knvtsGQezmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3GZnsIqGJt/Q9jqWsO1mRVfTjIxTFkI2wwtbDLa31M=;
 b=g3sPOZv1JTAiLMM3YGprqf+P+0xCbu439RwZdyx1p8tJBelpqSe8A1kA/R7IVVjo28jQEwZaxf4ox2WBSbmQdan4yBXR9WL6hFE1a6IK4hgk0+/vPNZOC67+cHqJmGmiykuzUkXRBS4Z3HVvTqFB+XEDvgbtT05AhjvK4qr53IMLggJ8EFyjSzX86XYdaligrXzWftdj1Vgs6Bnod+dcUD4eNxilGQS7Ab1eCeXOOUyKkONvxzkIqipnFGK9jHhmUCrMh2h/yiA4kEtpmYGq8NHm3hGo8Em2Vz9fCWYoSY72oHZexn1mNu9MRZ90FXCPIzR0J0d4+sTxIE8nYzStvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3GZnsIqGJt/Q9jqWsO1mRVfTjIxTFkI2wwtbDLa31M=;
 b=uMsrTnwddXbRj94HscuN9wSuWTju+UEf3oZjJrSkMcZa1utu3tr0UqbMgqDaAjOe8Xdjg5CCnmdPm5nlS+JtiAZMWdCcTuTZqzGB7Ms0hhJBHlHlMfqrvPGSF5h9gsAfNd7uYTqJC+bDt5F4+fYt6+LvOkN2ZYeJs4BFzFF8cMFOQBGcqooEiT9Lhqa8ft39tregfVF7gugiwMk2ei7I/lH2IExBXefXr7wXQMAkDbictaHQUkeXdSKdFjM9tZBSMVtA39yVakGcYJWkLSLkXae8A3A6eoAZqyd3Q7bYreufWTHgR1fPmw2lVXWd9UGFFy8CPAe0hOppgLZg+dxGnA==
Received: from PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:25:44 +0000
Received: from PH7PR12MB8593.namprd12.prod.outlook.com
 ([fe80::9c70:35c0:f8b2:8f77]) by PH7PR12MB8593.namprd12.prod.outlook.com
 ([fe80::9c70:35c0:f8b2:8f77%6]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 13:25:44 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Sasha Levin <sashal@kernel.org>
CC: Wentao Guan <guanwentao@uniontech.com>, Jason Gunthorpe <jgg@nvidia.com>,
	"will@kernel.org" <will@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during
 devm teardown
Thread-Topic: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations during
 devm teardown
Thread-Index: AQHdQPFkFkV9WGtWYEGMTOjALaeTo7bJ9r6AgAT0HoCAAP1YAIABU4gg
Date: Wed, 16 Sep 2026 13:25:44 +0000
Message-ID:
 <PH7PR12MB85931FD4E700A0619EF619F2ABB92@PH7PR12MB8593.namprd12.prod.outlook.com>
References: <aqR/n+VtlgpjJrAV@nvidia.com>
 <daily-reply-0001-re-arm-smmu-v3-devm-teardown-6-18@kernel.org>
 <aql76pp8QQ2XIVcW@nvidia.com>
In-Reply-To: <aql76pp8QQ2XIVcW@nvidia.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8593:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: cfe188a6-d069-4891-fe93-08df13f60302
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|22082099003|4143699003|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info:
 VGjh85y0zWQ2BD0mbtJdiH31FmuyNeVZt0m70raRCcedLLBKUAIIsXUaxGh/F169lYqYPVtfkoLx0IqD4cWTIn/i0GdJxWFROa6TSSVr66UR13cg7K78Xozuv07oya3nNHzQKcAcQKhzzn4m95RzqEKjOO12WoPSYmnbwg2VimGBLNQq7HRDN9P17P2Y5NYQ1U+0AJactShdbWSfoN2dcSVySXsqhAl8nzHn3CVehGyjHW8Yb+kC/Rl5iGcuTvPyzxbrWRh/L6obGEtcDyhhK9N4B7EsuTPjxVr7diqRBfjqvY7GxD0opBU9JWsIHkkOt7bEwK0JM/TD/4TurjuddbSOuNwvtP/Pg5NBXKybroHejzX0req+2DdXnPKzTV19H0FskEBWwt8MwPQ7Em4qpdhD/aYu4XCy8YnPN+2gUiQqvlNkzphw0Bi8eLt+snKcpe+NMVcS2AHQmClTIkXr/ZQ48tknRlUeKoijaKk0JNfpcMu8UAvvBABUUirt73N/CSPWhrFKfse76+KV2MZMR51sSc+Azk/mr+hm4I5+kgUknmGngdfUvUUOG9Ff5PgKVoLCzkbvaJ6WGtoj1agfgsaSgXBiQvV+IftnKXe18BfU9kgkwG4wbCGaIl0b/TFphLGCGrsvhzokl2g7TrIVE0GXjAPgG70HluwxrR7R1PpXwDskXHIVOycTo3UB8GTLoT2KwM/givcCa9sv4WT/OKzAkXrDlZhsGgkqk+5FWWo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8593.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(22082099003)(4143699003)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DJjTwxTsuRG9/O9pFRYDYvHLgQjX9bOUL9oFUnGIdNSwAfbtZqiun5ur0uDK?=
 =?us-ascii?Q?8cEvWYlhQ7dPBqKrPj/T+iqi66bk5olQ2o++ocqNp5NihGIoUuuUew20CI0p?=
 =?us-ascii?Q?IysHeMtJttuOBL8X3SDocLLf2AO2KrkSky7R3WcrD0x5TrMK8Guga+DBFZgI?=
 =?us-ascii?Q?mGYUdmjm/9pTQ8cF+R2qPeh/42nJD09JJpKSQNOlzyR7CXDRjmURHvVjT6XB?=
 =?us-ascii?Q?rY1+SdwAfLRKClhDxjMNl7IUd0tydLoOTLBGtZ0n3hF7kQLzoA0PmqtUlwk0?=
 =?us-ascii?Q?n6S3Acpre5yu4nJcYZWVVELMOtN3Wv5xZ486n7u8hBSIHp1eHaYNJSO9qVvk?=
 =?us-ascii?Q?BhyJ2Oyh/6/lVhbpFE8/5kNZKZUCJu3Moz2wF0w/MpozdFLVkM9qnMEjwWDq?=
 =?us-ascii?Q?bftmKB9FHqqLF2uxKQ4Fy7Zr1obqZ19X6fZT854LRw2VPwLZkcckL2/7nDPn?=
 =?us-ascii?Q?4PUD3EDewlzEZb0DgbCLdTgU3339NBSJ1e7pD6lPzcBOYof2BvHZnt2guWRf?=
 =?us-ascii?Q?+RAYCBzzkbainENjNbibfiErOh6uSj5IC3GXKMphKgs3uiafb4gN53+TnU29?=
 =?us-ascii?Q?IZNdoPY+wioKe36/ngUjjq+nqkvmKXE4/Cln52G7MpjHTqeu/g6DMisFP2FM?=
 =?us-ascii?Q?Crzw01JXZxCy7+1yIScK+CtllVa02C7SeYz64l9aG4MmOmrQDQgX+g+OhC1M?=
 =?us-ascii?Q?G0tzMRypVPKqDVe44rb3/lX+qT5qm110fpfPduVsTMPIy7bqzkYLfuz4uZm1?=
 =?us-ascii?Q?S+wF1SX50c370BrZeEk2mRbwSP0uTG4DpK7J0s3HEKpXj7Sn7g93RrHXWzug?=
 =?us-ascii?Q?29RHOxQ+Ykq0ce1z7qn8QLLQCHSvCC28UNdnPRyUyvLDbLu4Kg5lKMgH8ONT?=
 =?us-ascii?Q?MwEXox7mn4Tb3KDT9FXIX7oOccfs13iGZzz3Ix1nzKUQnkbeQFMGRX/K2qYl?=
 =?us-ascii?Q?gBgwPXbibqs0gyF2gPdNWyc3auZaU9tTG7SjfzSXFIhlocEkaT2DyMBpZrBM?=
 =?us-ascii?Q?YcwvW9xFOVeLWylIx0o2TetIueAINGaIuxTMywOsHGffX01OXAGVKxheAtFK?=
 =?us-ascii?Q?8Z1GLCUEYr4Xyw/nvBUBsDlVqjziNBCBGVLAyQ8dwJRCmKH5gE9GkrjckpB+?=
 =?us-ascii?Q?RP107hb7XUTwR3BXhqymboWknYKUogJ0HATrQdcZXRudvOixDnVAMUOLMG7+?=
 =?us-ascii?Q?mq6UmtzSbUgARfc4Yi0yrwR6aYR+Hd4Uc30gXlUKE7LLc0Izm/0o5A1NELc/?=
 =?us-ascii?Q?RmkXEjbzLxWNa3OivwP6rIEe8+B6QPSMSQdUSRCbZ+zXu2b0aJUaz+Z7m66q?=
 =?us-ascii?Q?OczGGIEuskx8dranLekhh2Bb9iBDnyaWk01XE7ikGgN5PJXGbeY2Ryoz4PGg?=
 =?us-ascii?Q?W9Qh25ifnvcb5R9QioOcLsjGFrjOiJtoLUycmUG1V7HBdsCUONBaQcfsYQ/w?=
 =?us-ascii?Q?UsUQsRXU8PMFO0b2XLduOP9vGs/dsN56k9TpxZBKo/rA2Rz0PVYlLagMhp7v?=
 =?us-ascii?Q?yEObXqMJ+XRrmXge47Bq+yih4S1MfPqzDSFbzMLyRkZ13cju82OcEBVuPfEe?=
 =?us-ascii?Q?6fSkibjkcIoAR6uz4FZqbVyaJwMwG4CkzPeeH+EPOxfZgp27YEB163PRsl6f?=
 =?us-ascii?Q?B6f8cUaW6Hpo6z2RzH/eBqxz8pRmA2OVY5CpYw18VsXBNg5pZ15g6PN9rUeG?=
 =?us-ascii?Q?cvoLUVBn6VmiCavjg1XcXysin1axt97pHOVZ1sgnN+4e1/5UVAFITJ9m1+L8?=
 =?us-ascii?Q?OeIvZV/0aw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8593.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe188a6-d069-4891-fe93-08df13f60302
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 13:25:44.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSOn5fK68d2coQhrIBY/E5kXWH/fwfsdqV9vaDYa54ojll12QmkAlxn1CLRCGm9hwXB+oFFgS59RI9DUli3yVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922



> -----Original Message-----
> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: 15 September 2026 18:10
> To: Sasha Levin <sashal@kernel.org>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>
> Cc: Wentao Guan <guanwentao@uniontech.com>; Jason Gunthorpe
> <jgg@nvidia.com>; will@kernel.org; linux-arm-kernel@lists.infradead.org;
> iommu@lists.linux.dev; stable@vger.kernel.org; linux-kernel@vger.kernel.o=
rg
> Subject: Re: [PATCH 7.2.y] iommu/arm-smmu-v3: Disable implementations
> during devm teardown
>=20
> On Mon, Sep 14, 2026 at 10:03:17PM -0400, Sasha Levin wrote:
> > > Patch itself looks good to me for v7.2 stable and v6.8 longterm.
> >
> > Queued for 6.18, thanks.
> >
> > > But v6.12 longterm might need some extra fix, Sasha?
> >
> > It does, but a different one. 6.12 has the devm teardown conversion
> > and never got 9ff145a25c5c ("iommu/tegra241-cmdqv: Fix CMD_SYNC
> > use-after-free on
> > teardown") at all, so what it is missing is that commit rather than
> > this ordering fixup. It does not apply to 6.12 as-is either, because
> > the
> > tegra241_cmdqv_destroy_vintf_user() hunk has no counterpart there.
> >
> > Could one of you send an adapted 6.12.y version with that hunk dropped?
>=20
> Shameer, would you mind helping backport your patch onto 6.12.y?

Sure, I will take a look.

Thanks,
Shameer
