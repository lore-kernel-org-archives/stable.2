Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011009.outbound.protection.outlook.com [52.101.57.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2964384233
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786639705; cv=fail; b=UAF2sVnpPhgLs4YiCa4EXg/RUyF5PTwrNCirRMpIpmXYDxH3w3itaPJAjQwZq7Em40xdnJztKdEPOhZNrFpaU7M3rkX6KIhUvfMM+G/Ea7afqeaYj56TJYX0NWUBt4nRAy4TrB2jiwuECrQ5LA9QLGslSEfQS7rtTf8t3gB4mfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786639705; c=relaxed/simple;
	bh=x/nccJ1hQmzd5GnoXDDMr8CGs2zwaRctaxS6f+pOFPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y8xW/Z1dva9jZSr5GsgnS/DPSkT/Fq8CAyood1B7fuvNM9UoH54rlSpg9Yzw5UIEoFhEtcX+za1l3BVqT7wddGWSF1V2stZItZywj9SO2tGp0JMd8hZsFzfMUxf5P/WDSo0rVm5hEjSuPc0/V+6z/maspTD8llFJ61m5eCg/JMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sHHL9XhC; arc=fail smtp.client-ip=52.101.57.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sHHL9XhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnjTGYOb15GGE5pdhjMaaG9/Jp/4NbJdS1fOItg14gI/x+DsynBQytmWn6C2FL4x1ecUHztmKtfhzds3SZ8SbskpJLvyky2cOlWcp93aZ0DnZ0LTYecoE8q0sASDhaiVypf1tokVrcVxMnO2Vo+9rzZCBtbqGG77cj9p7upW5m8WUgS99d8inwjo8kfI25h/hrS2P07zrmVNGK4g0Pe+2xAPTMX6biugzXcAU2AyKFjuhli6AUequpUcLvkW8hqIkQ0sv37PEG69YMjqAIokDm1/ksTpZP0vA+g2cE+J9Ubi5iMreudMOmWgN/jFYDt5z94CRTaXgFVHgIrMMsc56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ITSBlW/znnZSQdmYhyRt28mei75fL17TfFZnz9EzFo=;
 b=YOL0ItxhLXzHW4YcCSOfT7UssyL5hXE4Z22tCrpduRPZ7u13yuC0/YDoRLQJdqfSrK3DYDPlxnsA4nJsmCpE9IdHSGOs4KcpgXr4p/UtMzzlkRtdHxuMbUmUJ2qaSBkh8Y99hOYeFXUgCZbMuf0LtAx3G/zMNH/6o4SxQWfuhNv6ZL88gSBKMl8qsFFY7St5qWa8zCR2TLE69V/9JOvXyK2L6oa+j0yBUCfMGKDIN//9LwUsIXm8Vqs5jcEE05bFM9Ze6OVp9rnLM9s60avpf641yVMf/rUbGecTWwm1qU5L4nIyIxjpRDljyzbfZ6eWiEIdifW8T3Wls0kkMv76NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ITSBlW/znnZSQdmYhyRt28mei75fL17TfFZnz9EzFo=;
 b=sHHL9XhCNNuC2J8BrYkyYdbWJPj1MOdIoinbRCopHQHCR4amoF5JAJtTMd4uUX79DnTGuUHYBMulmJHPGKBJdksNX+kuDhi+AcvDiAQkuftNxAvgdZcGLUqNgLdJWo/apuzVtHEPv1gGdkTdh26XPLnEMAf6Wn6jLvZWux4cWlM=
Received: from CH3PR12MB7572.namprd12.prod.outlook.com (2603:10b6:610:144::17)
 by LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:48:21 +0000
Received: from CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82]) by CH3PR12MB7572.namprd12.prod.outlook.com
 ([fe80::709d:234b:b2b:ba82%3]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:48:21 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Wu, David" <David.Wu3@amd.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Deucher, Alexander"
	<Alexander.Deucher@amd.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v3] drm/amdgpu/vcn: fix integer overflow in dec_msg buffer
 count check
Thread-Topic: [PATCH v3] drm/amdgpu/vcn: fix integer overflow in dec_msg
 buffer count check
Thread-Index: AQHdKbPeiWuJI4yhL0KmpKQvdYDeF7acM2Xw
Date: Thu, 13 Aug 2026 16:48:20 +0000
Message-ID:
 <CH3PR12MB7572ECE0A9E077D2B3825B04E5DB2@CH3PR12MB7572.namprd12.prod.outlook.com>
References: <20260811170653.2092673-1-David.Wu3@amd.com>
In-Reply-To: <20260811170653.2092673-1-David.Wu3@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-13T16:47:17.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7572:EE_|LV2PR12MB5894:EE_
x-ms-office365-filtering-correlation-id: 3dd64ca1-f0e7-4c60-b015-08def95aaedd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|42112799006|23010399003|11063799006|38070700021|10067099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 BsNtFgaoi6QyyM1stORhNncyHV1tNgYOiy5JlPwXRYMw0D87yF9JKmGclChHWb6+JkHI+q903tAnevAceYHW1fEUxVtMTiUZlPFdpjqfYDAPJRQqB5H3y6eKU2MioEtox9qjvNyfT9Uh5b8vXx1GD3wrtnO9SmyQ1eZbxDn/AK1r3SqFxxwWS17aFma/rzXFbTeCBz7biZOOgw61JXqY5y050AAkH0JqRUMYIVFg62SSoiC2DBMAz/Nc48AVvQ30ECtEjgXVEfnKRf0AHDBWtj0U76HrJGdfsIrUC64g1uPzhM2MKyDJMONV1RVGOyK8xMdBrQU+jQWlw92pFzNG0zBy9xq+Gui+FoQWEZA9VD1Y3QpDoE9ft4SwyVDqhgMHs5XQMKGsNU3r6okbzrZXsMZ2H8cBXvGdlznawujQA0GF+h9Egfq9Kqn4pElMxCMRu0yyQ+BJ4s5tEyPp6Z2m8oROel3Srz2yV69v13TBzSRzR3iuDX3cEpeG9xLvZBr3nqeNY3zoifLMZjVBZ7iVRCYPost6xPJciIwAcFhhrELQOkDJ58HgkS6t0pcS1oUwwFAfhe2eKaNNqAszowm+a2ag9CUZ6/SjcAzNq5uruHBTRMQKy8Rcnto113yZHKctY2RbBLEf7Z/3apQRgrN9UWyDTKaz1lO/ofDscKfVsYpH0OCkCPgK9HObCXr41dgmcsR0PHClPCNr7hg/KUW6+CcuSNS1yA+iX2drascz5OA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7572.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(42112799006)(23010399003)(11063799006)(38070700021)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jgOQDpA+TzRV51ZsscA9K+tHibRtqMqL3B1R2U2pqysKeSAbIjhRQm07h4OP?=
 =?us-ascii?Q?r1j8tTxI2rcwvF6jLCrcV2mL1poBtMRg1JEGAkQNL4DUnR0rnAYrbPGCd/06?=
 =?us-ascii?Q?WtHQW1SJNvKafbX+UtWoyujXThAU6DyQZQ4Gd/pclpuqGUICEIOsxBT85ZpD?=
 =?us-ascii?Q?tfYgsxKTwQKfhvxh0+jMA3w+RNwOQGoE42iDhUfNqMFb1TAeJY79IurDMgD0?=
 =?us-ascii?Q?zHUR4Mu12bnHsNFVUmqbZ/uGjEFJamj4xTiioFhgFM6Vr3qSjwF81WvdOMO4?=
 =?us-ascii?Q?6mlJlurr6La9nbfdFsfaZKlkJq8ej8IZJPd06sSC1kY29V3ACeuY/LNeyCGx?=
 =?us-ascii?Q?z4bFqSCMJ16K58QVjvD7pY6nQouqf+JyOps9GegrlUl/s/c7K2bmml07QXLn?=
 =?us-ascii?Q?e9oQwEcrweJhcsJN1flqPQuS5y7obseh5mm4fztUfDOoyRS2zwdD43pq1447?=
 =?us-ascii?Q?QTKBNFU9wkjTTZ6DClRmmmoXNi2R9KGHOnf8bi1mp2QrpwKTVuMHcsRAeAlH?=
 =?us-ascii?Q?obb1tGIOWPH2Xq9S7aFFFyLt8FMM0oL2vbEMpK3ZUPm8NeNGK9jCOQWTtfHt?=
 =?us-ascii?Q?Q1QplLGVjAy5qUjPZQG83ed1WpR/qZcbZPtDCUKWZ5uYciDbv1m34krT6mGb?=
 =?us-ascii?Q?w5Zy2vTTZSNZbCwsprf5Epzrm8rChllXUFrxkYkvjeeztAqqOsBU7japzOhs?=
 =?us-ascii?Q?ycaon+acuxzY8Q8bc5DxZi7VzVLx5LoLyPeJePUluuCDcVB1KvsCTX1wdBup?=
 =?us-ascii?Q?DhG/OSfe8+APkEnfhDSJ9XJnUQRxKal/Jz9OLC01AOXKdJs7le2yGFrLtA20?=
 =?us-ascii?Q?U/y81scJ+63fRIZ6Uq7hiyb1xW5K3obbCsqe1HRkQa4KkrbGASi1uNBeCYNj?=
 =?us-ascii?Q?FUVevFcWPmUwX5FqscrgDVuxu/qeOGortTxqokUxCXlBC53SY7I3IVc59OyM?=
 =?us-ascii?Q?spP6K5s2sGEPJ3hmiFtjqD33zwsIKHLkHEWpukSIcgY5oGi4nEEJy+YgBRsI?=
 =?us-ascii?Q?sf27qg2klOeDFmYuEuwicOLj6fBqieXOGOcKhY9mK0z6u7rBxKlAa03PQ7cS?=
 =?us-ascii?Q?Yzkbpja/r74fL1qbHed8aIqK9b2p+oMsRtNopXXzWZG2rdLn1YsNJ4yY36NZ?=
 =?us-ascii?Q?nIO9RkJ2UH7GQ9oFBKhNLZZIwXmBuJu7CJ/ouMs2n1FjdFJEOYds5skCjlBp?=
 =?us-ascii?Q?tkVjWiWtXRd11pIg8VnyEMSxQxlH5Viw7O+uoNycZy3uQRxI2B/e/qKPz35I?=
 =?us-ascii?Q?FQa4So4Y4eJ+4swDr88iLICZu/LSIy95r1LNpsHJiJPWjPtt4xm797wey5lc?=
 =?us-ascii?Q?iqqAcriKzF6hajSDp/gbrP4sHt1lSh4OxcIj3/ZpiUXqxcE3I6448Hpll5po?=
 =?us-ascii?Q?kMv0Tts9Y7RsoxTapvqcEBwxDBIGzpMoRA2KNquIgeoPvnZTwtbTw06WBkjT?=
 =?us-ascii?Q?Is028s7ZXXhMYMsrGHYou05JD7RzEDOoB3ysiEdb8N/7ZuI2Qhbc5gjQFt3s?=
 =?us-ascii?Q?HGSI0sOBK1ZvuZG/EIYl4ZjacKtyUkvLmZuAcOqMIS1dcodfQCyIFCvllUvb?=
 =?us-ascii?Q?SfHWRdxUyVE6wPEvEX0NSKAAn34Lqqmi4CdM13IhfrM9xx9b5gZt45xXcnCi?=
 =?us-ascii?Q?ZWBVCv3Of+p/bkpdknUGnpuhi96rO57jNarwa9gEt/jiC0mULJ9ly2LQtK1/?=
 =?us-ascii?Q?XAHUjfv6uJ+Q+G+luRcSarrZg2pFcj3vyg6EHmtiKb1/CkMX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7572.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd64ca1-f0e7-4c60-b015-08def95aaedd
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 16:48:20.8641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4w6btv19osmT9Oq6kBS6fH0hEfRJHVQATZw+y+tyKjDgJjCL/NTwR4YSWFCt81T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894

AMD General

Reviewed-by: Leo Liu <leo.liu@amd.com>


> -----Original Message-----
> From: Wu, David <David.Wu3@amd.com>
> Sent: Tuesday, August 11, 2026 1:07 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Liu, Leo <Leo.Liu@amd.com>; stable@vger.kernel.org
> Subject: [PATCH v3] drm/amdgpu/vcn: fix integer overflow in dec_msg buffe=
r
> count check
>
> if supplied msg[2] in the header is too large, 4 times of this unsigned 3=
2 bit value
> will overflow and the test could pass.
>
> v3: Using two-helper form is heavier than needed.
>     Since len_dw is a plain u32, a division-based test is
>     overflow-free by construction.
>
> Fixes: b193019860d6 ("drm/amdgpu/vcn3: Prevent OOB reads when parsing dec
> msg")
> Fixes: 0a78f2bac142 ("drm/amdgpu/vcn4: Prevent OOB reads when parsing dec
> msg")
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 8 ++++++--
> drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 ++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> index 81bba3ec2a93..686f5f758cb1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1964,8 +1964,12 @@ static int vcn_v3_0_dec_msg(struct
> amdgpu_cs_parser *p, struct amdgpu_job *job,
>       len_dw =3D msg[1] / 4;
>       num_buffers =3D msg[2];
>
> -     /* Verify that all indices fit within the claimed length. Each inde=
x is 4
> DWORDs */
> -     if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +     /* Verify that all indices fit within the claimed length.
> +      * There are 6 dwords in the header before the first buffer.
> +      * Each buffer has 4 dwords. Extra dwords will be ignored
> +      * at the end of the last buffer.
> +      */
> +     if (len_dw < 6 || num_buffers > (len_dw - 6) / 4) {
>               DRM_ERROR("VCN message has too many buffers!\n");
>               r =3D -EINVAL;
>               goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> index 0cce78b205a8..6f0a51c436db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1880,8 +1880,12 @@ static int vcn_v4_0_dec_msg(struct
> amdgpu_cs_parser *p, struct amdgpu_job *job,
>       len_dw =3D msg[1] / 4;
>       num_buffers =3D msg[2];
>
> -     /* Verify that all indices fit within the claimed length. Each inde=
x is 4
> DWORDs */
> -     if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +     /* Verify that all indices fit within the claimed length.
> +      * There are 6 dwords in the header before the first buffer.
> +      * Each buffer has 4 dwords. Extra dwords will be ignored
> +      * at the end of the last buffer.
> +      */
> +     if (len_dw < 6 || num_buffers > (len_dw - 6) / 4) {
>               DRM_ERROR("VCN message has too many buffers!\n");
>               r =3D -EINVAL;
>               goto out;
> --
> 2.43.0

