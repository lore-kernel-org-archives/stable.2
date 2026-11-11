Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794414317;
	b=ET3GmrgfBCQZUUGTAqs0FghwjKi4W6z8s0Cnlk62VNvio3ECtdrTN3gXJnopdVc0O+Fd
	 n6bqZ3YxEHSU2lI1UyIKurgkr4vjkLRxLW9GvtG+S3m/OudlufyBzef3K3zeHkZgR7Qe8
	 GZTArDEx7bgriuBaxKFI3Fr6ceWj5+bkdg6ToMSG0R1Qh2Vug7ZoVpVKmjJakxuslG6sW
	 +A8iAjRwiNu4hya4IKo34aQnBd3Cq5Lx5hX/f6Kkp7iSe4WgknMEB6ITvNboxTnntVxy+
	 RWaIInorhetHcco4jprcyGNdrDv74EXnsjW1jUY2nSyK/QOpN1wdih9ebE+r8ktfpjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414317;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=I+z4nd9qQ0iMp7JKMqS4X3TtPZm1M+rNEyVbQO7QWLs=;
	b=ZIUBsOvQJwFwGw/fkzXNL6Ei9Yvl9MuTuwXqb42KggQJMLOIEZdbDo3O1cLZrXUJO2xU
	 jBOC43iAEJkcDaunFekLViD32SONJU1jRWLelozJNtMoMbF36nZpdUCiWOcUhNWvDs3lo
	 ogNFbKP9VnPm0Z6qmMhNnXdxIe/Fp1C678Ofdne4hQq+LsZFxm0gs2N6FLUZWugFfPxOs
	 UeCZARyxrB7aRAgxGodQFp95GYDexYYjBJO77CZNOXvFFDBwr3Lq3cFUw6bxklTqFdOxQ
	 90CcPwSReSjmkmFMhvKrNMXiDRZ2UYg4dH0djpcaOilu93e19ru0TOdnSs/JVSMw5Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h8L3z00Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.68
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEF606A33E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4CEF606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=h8L3z00Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcBCGsMfozHhHaDWj52PtNK/wVPH3uL930RRMEpGVuzyFSaXD5VS7piDtarblDlZcbH/IVmiWO623Qz54aTicpfzqGhYjNsOCkGbybQQf3cET47U0DR2PJpTr0SrqlD4/roxo0aXzAouvmSNJ3yIF3Q7BM442pQehU8tL53UO4dQDl795QknYZN2qjgBs9dAxya9FQJ6panar9LvOcboud2UZaHOuM7kW9QxPXp3TyywxP3rOruxtMkni7ck9fkUzi5gTdnFl8b4ESHvtTwNa4fMAvHQfWZu7bdBDq1+wyQx+dpINh3IvPE0WN6CNwQ+rIxZe7azarn3loBA0ofgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+z4nd9qQ0iMp7JKMqS4X3TtPZm1M+rNEyVbQO7QWLs=;
 b=MtMrh3nxoBKeh7oiigCiHzMGk1fkUHOJb8sExrR5UuxUcaQL6ADa4zPuCf4DWnzsYO99sTqQ6NhYN/d4R4AuYiSjXkATDlP3YBEgwqp8YNRh9ii1iKibtmRR1ZI7qkMQa1s3csxhmEEILRwb00WMc8pgpWENE91XP5bc39KHGYbEDDnLydZOknM9Bnxnw3dpJz9InVC+w+6sgG0TaF9xNsGXM/zAGLkEHzCMERTIMqJ5pqsSvPU4MOGdVTwp8JGdIvKoQZrodg0jloPM6AynaQxK7MzidcwqQwve0+2bezTovWkNfnK5yjfQt7pdwKrmlvZPppXfak9sFMKSmNx+DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+z4nd9qQ0iMp7JKMqS4X3TtPZm1M+rNEyVbQO7QWLs=;
 b=h8L3z00ZTSD8OvA+MWfLpQpBIeym0NLYCDDGLGU0lEwBWq3H+CqgxulyHG+VZltCdp3WtkzrBUqEHAhANDOH5AvXeKmrPkqMqoZgrSG1VZmJ7KzipOqZkXnGTn7BOSHCimX+8MiemyUOF//eRiZujUe02AwTOyBIGNEdXK3UGGQ=
Received: from PH7PR12MB6812.namprd12.prod.outlook.com (2603:10b6:510:1b6::15)
 by LV2PR12MB5824.namprd12.prod.outlook.com (2603:10b6:408:176::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 16:25:11 +0000
Received: from PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069]) by PH7PR12MB6812.namprd12.prod.outlook.com
 ([fe80::a6a8:1bde:c3fb:1069%4]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 16:25:11 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Sasha Levin <sashal@kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kazlauskas,
 Nicholas" <Nicholas.Kazlauskas@amd.com>, "Rodrigo.Siqueira@amd.com"
	<Rodrigo.Siqueira@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, Wang
 Jiang <jiangwang@kylinos.cn>
Subject: RE: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Thread-Topic: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on DCE
Thread-Index: AQHdbQToOOTaBc4iQUe5amwWOc+oOrcfz96AgAlIOXA=
Date: Wed, 11 Nov 2026 16:25:10 +0000
Message-ID:
 <PH7PR12MB68126E767A5D04C4948DA93BF7712@PH7PR12MB6812.namprd12.prod.outlook.com>
References: None<20261105090543.930342-1-jiangwang@kylinos.cn>
 <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
In-Reply-To: <2026-11-05-1-daily-reply-0008-dce-post-update@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-11-11T16:24:10.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB6812:EE_|LV2PR12MB5824:EE_
x-ms-office365-filtering-correlation-id: 8d4992e7-a071-4bcc-aa14-08df40105b92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|38070700021|56012099006|4143699003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261021135927099003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 COp6BI4zGQaOId/IKG4KZZGHaTamhUXteIdEi6PUduLFzfOTINZhue/pXi30DYxfq0ysyLBLLh0f7ebkaZ6kgXFA5GGmomVbjCwgKCKH5Cp0vXu7WrH8nr23gwt7mUKpWjEaqH/lX390Q1KXtwhLks0jNv7bBVI7MdSa0cHP/2S9M/LTJ+UyQNkhlttBBkN/cA6p00A5eHa+y/SSnFjJUfPiF1w0N7TUocM/zb2dXUjQ1j2O+R3Ve0fSOu+oBwZKCOcObZKbgaAZh0BrA4Zoh8g+puNqdJRAh+b9jkmHUVPmE+HXZt1m2d9hJUugAtWyChKknpakqod45R/94oJHOrJ3HXJd00Qv36+ypRR4yfy5BAz6GV8hNnGLAeAb1uTSMGMtMtB4Bq8pQ2UhHa1NOakOtRQLTqgp69GK15Qvg8Ni4T/TLPBTfN81tPgsnL0ArMglyO8G0nZBcg37c7jdycPsTUlftxlbEHLmoX59sO8CAgQVYBT7troTOkJRsFIMlnKckts0dJJK52AixUJE+yqtY5LJueyi/1TK+znJN8RfD9+5F/Sm4wYBd4zR8qxA8GsWKQ4fBuGW9GDPbUfYr5W9s68pbr2JCjhHgwWFl2wCAEv6fH2BOLJtlRvqjhNPum+kUe5LS8Wtdy7wK62RQUQ3acHHLWAuIMhhP0BFFZaQ1BtYO9sUPG39tLawUg9EvLUVLCVHEVxgeq1hzu7r1nqABrNeKvlSdXm/YN+G5IM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6812.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(38070700021)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021135927099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+wGaqXHdKw9My57HXFXyAb+OBbaoHs7TIsoxE45XIfsErCir1fzCHYjsBCDv?=
 =?us-ascii?Q?+dmFmZ6mAL3wBeO7v9XbgncgJizGHBcUFxoGU+GYRNgb7ABzWCgBsg3c6UDU?=
 =?us-ascii?Q?lzPblUO/Y5KxNL21aWI9dB2QRVli21eg62c94gPI0jjQJj4B6H8cKJnLKXwG?=
 =?us-ascii?Q?C16Sf9SaSOHAUizN/y31Ml1DbkWLf24XvKlw3brFuVu0MAjDGn0VHwjqch5e?=
 =?us-ascii?Q?mG7zze7v1+5kSTTTGPf9JDRvTlN9EFFHrsTTDQyxwShVtUIsoBd5OWa39E2u?=
 =?us-ascii?Q?jbsNNPKoau7/X7QC5ip5LPUItlqhV5sSOxjOOto4bCcfFYnuhjmscOEAARPt?=
 =?us-ascii?Q?OQTaUNtBe7PJpU0m/nIqkDgnZXIAqfDBQtWqkQ0KH25P2YBIw+213kEg6scR?=
 =?us-ascii?Q?7FSbZg9QIuQMthgIYshjGwUWtfigJI7bp6v+Eo7rfxdISwbQVDNaD2of/CHP?=
 =?us-ascii?Q?+G3tmXHnVIsrUTvZCkg3StSC67V+/kf5KUvoFSzoWo7Ufh/EDYVNfNkTyNT9?=
 =?us-ascii?Q?YdnN9drv4VVKnKKs6J9UT4zRjKF3y7VT1yXroOMq7tymzD0TslkdYcp1gJYB?=
 =?us-ascii?Q?/4E59CvjidgVBPkmPG6lioQnYjYKxa6aEE9EwwhhYrcFXEE5yfAUTpD5EPm/?=
 =?us-ascii?Q?gQK1VwJ0F90k1s93lCKeSgsIVu0i4pcdPlknB7M4SBQVLbJGmMNeb1gwoyR2?=
 =?us-ascii?Q?a4phkS15HoYfRNaQUIc1CPDXJDr/10xAg7QPmXtr1rrIr+OSq3dGmOnwHiFI?=
 =?us-ascii?Q?Wq7/8728HxeJ3/XCmfx9MzmEHR+K2XuCDUmlNFpZmduCCHDo5/9mAuMfTSS4?=
 =?us-ascii?Q?GqyAkbkftmiEz3UxQzECg12EHo1Nw3EfLDhbTsWaZY6/2qTb29B0FMsy6ZGS?=
 =?us-ascii?Q?G8+aQ1dGDQTiDveTsdgcQuL/fMuPyuNvdFA9NPIneyK45/cyMWZ2oG6xANxm?=
 =?us-ascii?Q?tSkaXOE9jHZuNSwMjuNwk32+OF7HWkOjFnaeG0LH+Nw8d92mvlHfWjWKmmNB?=
 =?us-ascii?Q?SjCQ7JcQxl6xV7mt5HeFIbe3bP2lcLxY3SMBWd8WxLUFPMeEcZb7gFFzST04?=
 =?us-ascii?Q?iGUxqsWfG4DURgRUSLxn7h/8V2Q984nDLaDQSGKvkegMEZxPTA4KQlqOo4th?=
 =?us-ascii?Q?0CrqJF65hDui1m0KTe6zMTN6QBVo5oaV5jd79VIAfJFBgtYcP7YBNEQ6Faxz?=
 =?us-ascii?Q?C90AMU9/UAnfcDqgEF5N+DtuHSpk36WA1OjTQTjOAbnZ72NOeSASSUTHsZiy?=
 =?us-ascii?Q?9tHLASp5trdPqBxoxwpMtDB0O9nek8n+ysNrqgsLjZCUPd+nQ9t7ByaAtjU8?=
 =?us-ascii?Q?1Umu+eKc3WlGaWTkAwuFp1wq6sBCNz5ki7NLF27YcLEkTRmEhkzGPx0ex9av?=
 =?us-ascii?Q?Y0pRBOWZ6RtHQnMNSFMcAs8Qxuz+EGv0u9QQkI9d7noYc02PDLnx67A5DQ4+?=
 =?us-ascii?Q?lFYGqt8PMByT/Hpq4cYHUrNNJ35eH/35GVyF3MM5PrvDl6cvGNGsou/F+PlG?=
 =?us-ascii?Q?HJa1OUmR9GukkzAEW4Zt3AxAVqCoF6S3zURYsdO+b+8jMUMbAqYs5r18j5VT?=
 =?us-ascii?Q?vtt1otM3p/ZbkNDMKg/PP1TjDu0SCm7bc/IpDnYvrHVeNrPeOfWDrU7MGiPw?=
 =?us-ascii?Q?mpq1ISJDTY1CbabFcAPUcRRI8z16zOVYvaOadjQGnaxIU25kdZ6e2AM66agm?=
 =?us-ascii?Q?WVDr80HnMNMvAh6s8bM/iEEXMbe/NxaD8XW9j0yXqzEV05v9?=
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
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6812.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4992e7-a071-4bcc-aa14-08df40105b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 16:25:10.9509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BwnUabdMz4w/EntqFdXWgW6fs4plJzTAk/jBoBc+D+XgGtZa5nqmp8Nz7cK1ro5CPVBg8d6BWCqgE05KouHeZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5824

Public

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Thursday, November 5, 2026 1:39 PM
> To: stable@vger.kernel.org
> Cc: Sasha Levin <sashal@kernel.org>; gregkh@linuxfoundation.org; amd-
> gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Kazlauskas, Nicholas
> <Nicholas.Kazlauskas@amd.com>; Rodrigo.Siqueira@amd.com; Wentland,
> Harry <Harry.Wentland@amd.com>; Wang Jiang <jiangwang@kylinos.cn>
> Subject: Re: [PATCH 5.15] drm/amd/display: skip pre-flip post_update on D=
CE
>
> > Restrict the pre-update call to DCN, matching mainline behaviour.  The
> > full mainline rework does not backport cleanly; this is the minimal
> > equivalent for 5.15.y.
>
> This is a stable-only fix with no mainline equivalent, so I need an ack f=
rom the
> AMD display maintainers before I can queue it for 5.15.
>
> Alex, Nicholas, could you take a look?

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> --
> Thanks,
> Sasha
