Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DEA477E53;
	Wed, 16 Sep 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568886; cv=fail; b=L38i1HrYAtMD6kJ7PtgF7irhQwB+/JMJPp1u3W1yug+CGYo/XYgffUL4mXem29v2cCDb200z0sCQLlxpkEH1aaNP1zZXJHYCNxhk/wVHrxw3v2bLdOVFj7awguKYNpvcYc6eSWbXC8WfIYBkhW/wP8QfUzgJC2NPIPAz0tqeJOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568886; c=relaxed/simple;
	bh=Sa33Q26ILqqPa2ZsMCmO2D4HqUolyfnGc4cfXYcD6L8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QK2+9SyYvvuHOL/bdMm93QEyDe8HzclqoyCE/kw+yMnJoTazHmGIafQZLWKKIOo6OG6g3ejvecIkP5c0wN2wFZvK6JndRCJN8cKt4L5XURlq6eu4U36jrKWZ32YJO8yigRJ5cQtQQ68FfdMEbOThRWwE+1IOoPKl7PK5VLcEngU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=scj5O4aT; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="scj5O4aT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=REKlSMpwJcdyXu+gQWeDHuO4Uip0YvzqiT1MoMK7qBVSzet15xZ7PmU+t2oxcUMfuQa+kLE+Sey5ONTE4Nt/4XrcevK5MmSfXo3Pn2NhwDWpIVhGZbUWQa5PT2Pj+QwcMu9TcJbUqfjH4T3+sAky3hryTF18Iwft7wxp3CCpwuHc/JUEzchvv8awUUjIa+IkEk2iJxfjVdj4JOa8rNbCu9V8+34l70lqS1DlQAscn05JzCLwr+F/Y69Zm/5AqSUyyhBSydw5krCNndyKVGarcC08jAm3G5ZI8MhtPmMmEfRpcurBjgatVeE288S/eQUfxd0nKcn5DnN5nqjEQxbfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7QM/F5qNHdrXtzkZdxhQ5rCU7HsC6L5SaASQRLN+XA=;
 b=jJ95MNOOlcmXhyAHInboswPG9xOSHYwycCBP7eULNmpFs7v6zWihaD/jfjRK4IhAS3rP1bMsbNM/n5OdljxLPCoYL/CUjQvLrp0zDnjnqUkXH8QF4GDdmyPKWCLSpeaurgOGB9m5687OEEvL4oEWBKU6USV+EERlsR1p9aRfrtbyAMynXsErL/5f5YbCaU8VG1e7wgLIo07Zt4GBqnT8dvxPEcz1+oggLWIBOViZ/YK9rbEhJokOxrGJZeKpy481AUUc5/+ar7mcMlsY/6ALGAbJW5mdVlzxGBEkJwJQArlRcamCBz+LBfmAutmwjMsv5/ibm/KXYPbbHL2lPdGQpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7QM/F5qNHdrXtzkZdxhQ5rCU7HsC6L5SaASQRLN+XA=;
 b=scj5O4aTK6rzMsV/bW/2hqty39UENgmXRZSzlBELw0/wd1QnPruUFx5jeHYfmaHZrHIZ/v0DlBAekhLPdPHuPxZSeT3pfiBTC0MlWvOXEwBbz64gf2Z8yXHYggulmSPDOjmpfYsRpiDRf6GzqS0ID7qFI4jIiF5UMg2WzEnwRmg=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DSWPR12MB999128.namprd12.prod.outlook.com (2603:10b6:8:36c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 14:28:02 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:28:02 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Lakha, Bhawanpreet"
	<Bhawanpreet.Lakha@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "Wentland, Harry"
	<Harry.Wentland@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Kazlauskas, Nicholas"
	<Nicholas.Kazlauskas@amd.com>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"siqueira@igalia.com" <siqueira@igalia.com>, "Li, Sun peng (Leo)"
	<Sunpeng.Li@amd.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amd/display: Fix dc stream excess put in
 dm_update_crtc_state()
Thread-Topic: [PATCH] drm/amd/display: Fix dc stream excess put in
 dm_update_crtc_state()
Thread-Index: AQHdRcDSHXpjyJePuEWcdKywClNlPLbRQ5RQ
Date: Wed, 16 Sep 2026 14:28:02 +0000
Message-ID:
 <BN9PR12MB5146BD09E340949F8E5EBCA7F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916094956.2008436-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916094956.2008436-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T14:27:52.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DSWPR12MB999128:EE_
x-ms-office365-filtering-correlation-id: 4951327c-8737-4be2-7dca-08df13feb717
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|38070700021|10067099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 hfct4iLqWOgN3J4WxK2P6GKB/huwLS2s/VdDFJHPaWUlWpWo2DQb5yaT6NFb1I2DKHCaw98m8RQzOSmMgZJrdRrla4uz6NE/0xId3QQ755UeWjFAS61bzUZZoxqu+Zk2YMGMO0PlttXiHMCzzqKg/E+8FASN2LuPNcCJQ8Ibu0XsfGpwUYWUu97NaP6rFDXUFhbxos0REDLN2CdUWIouyiV5qDmXn9b0POWpVVMsRt9ctekL7MwmkEQBDwvE4x5TSnCC++RTew4rwEH3IsIVUlSd+98g+fbzpSdpiR4LFPJCY0d5Xq/ybm/qL7MnSVZ3oRT6d8IaWfPT9AYm94Wv3RPxXIJujwGqi0VCDWds3GRhdNkE59z+oQ5SEtrOolGcwbYfPInJJDE1uXOBxWn5eOIVShoaL6Zk9oAgViAqVwCjFXcqlPMVLt6nydYA5PYuh+rRF9mh58zI1Ako52AElK+aSv+4rW3Vkm6J/vh8UAkZwjoGkZo01PoLWqF99O0tbdx7UZMg2rpZxgsx0clWE2Lf62AWfLPA+BzUqPIlH5creRtfVwz6jzhWyOvig0953Ec52Dsjd6ijGL17gm5yYntGzufAtnX1FCEDRHOd0K+jzpL+56QVHWo/mh5b/oMmveMwc+6ymWuEL3aWo/SkBTh5qefo69iqcpccEaKWqbcGLxblaQnCQpGc0U09BsxZecTtdJgzs2Kn8+s3g3Hj5TqkRdB/EvFQVqpA7PZmm9I=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(38070700021)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qn+ovyOng5p7shxEnuQvRdpg6H4R+aPeIojN9ErwdfcwfK46yC95jZIW+2Ux?=
 =?us-ascii?Q?73KgKq/Roi42Dn6RejF8eIgCDqYNQPFFjSzRxJ6vxw5IvKZVdocLpgrMHWvj?=
 =?us-ascii?Q?6xJ+EiSoNM9GpxUUAZQHxHoQnPkcDrv/CfVupUUrRWSJLoAunJW9w2eHX/IE?=
 =?us-ascii?Q?tvZ7jgnXajbfdmaQYG1D8bji8JecAFfKB5USyUKXdNuHUGILKv46i/6YMj9T?=
 =?us-ascii?Q?d5uLnx3jAoaa/xAlqIpM7ert8UjyyEHY2qVjJcpaA1cb3kMeVIJtzvoSXxDv?=
 =?us-ascii?Q?yslKE4YzHJiXLY3a8FHBxqIb6WMGsuKNDyq5WBQcgoFjhRNgf+jB2IPkX4et?=
 =?us-ascii?Q?9MgLZH37eJbjBtC9zTSv1ewMViXcUL7ZDfi8aQ/AuB8AppA36/nF1/5GYkqU?=
 =?us-ascii?Q?uH6gvr8HJg6FpSL43tev3GaXhtXQNtYjWa2HrXLDbJlR7AegVHPN+12NwPdu?=
 =?us-ascii?Q?hgDKL0XN0JQx3Rn3ePW73qa+MpvuiE+H5r2kOQ4Fh3D8yyBDU6/OqrRUmNsN?=
 =?us-ascii?Q?neeTOZX8rN6rFnpbleO8vkdQtijrNIDEP43zPmTBrCU2DOJZtAEkafokNPbC?=
 =?us-ascii?Q?VXl2F6iUAMtThb+r/4IyoIc0Qpg1HKcG+lzL9HNhsqToVw2vnOB+WGJSAZ+Y?=
 =?us-ascii?Q?lgto0/A6b1pt2n6T19bUlFpvTS1FE7KFoOgIinTiBWqBLabJy7X3Ag8+mhrd?=
 =?us-ascii?Q?cRLnx6Bx8OV3Diq9C0GioSjE2wCbQfPhF5IiILOZBEF/TQ/bjCtIbFzQZwcQ?=
 =?us-ascii?Q?/zuJdRcyrtgP8AQf3hpoG7BKoRUtAUJ31cwJXpzH6gb8JmUNRdxzADNUXWZu?=
 =?us-ascii?Q?34dzNUJbTQ69iUdO9XoOxzUUA4vCKwS/VcZ8h0pECMfzzL7ob3/Qf5zDsxSe?=
 =?us-ascii?Q?XzF7Jls2TS4dZdbDH6lD6H3s5mhWUMTQ+6hz9WaoGBMn1pozn7RQc5kHPY5h?=
 =?us-ascii?Q?ZdAc/1R4g8lDI2+KZK7lUVtFMKevjo9gWe40Lv47dvp2GPeqHILkJ7FI2ZuM?=
 =?us-ascii?Q?gl5p9bi5vaDHcmRdebz02aUwbgY1drgQqDeQw2xVjofBiiPZTsjhnHn2/WSH?=
 =?us-ascii?Q?HoU+mcLiOstJybYvwjlqce7VVz1hZN8OSuxgfeuPOs3+ha8ifiEUqh3efGSA?=
 =?us-ascii?Q?GTMrOMjD91OudxLtm6IuLrEWDVeJs+mlEQrbm2vSl/ACoeCVO7UUc9p4+iNc?=
 =?us-ascii?Q?8W2X9bcXnsWry+QjGHjiEh4ix5Ndt80h9qAwAgD9g4cgJAz9Py3iFKJVSEWz?=
 =?us-ascii?Q?fHe1b32E4zb9uUq373Xzt/ffSCei4CyfzMzLsLt0RahmaPFpFtQmBkCN3F8c?=
 =?us-ascii?Q?H4XIhm+Sx6rVmEdIhL+XzxXr3uDpiBEkJyNrA6Sv9A4PFeZ80UMByBOUlmGU?=
 =?us-ascii?Q?cOTGLf1TnIl+3+WxbVwbIK1wLgMNunsLWSDfSHxDXVNL0QOspWRQEkxsc635?=
 =?us-ascii?Q?t1XjNlSgzCf76QrnVMnKj9k2MgVbqajny6piy95ljUyIdPLTPtEp/m79vGrL?=
 =?us-ascii?Q?rjprKGY8V3Fy3p6SxEeLYx8Ja69AtDwKybauwjAOSMeKShELR0KEFpqMMXFc?=
 =?us-ascii?Q?hdSZ0uAuqF5aT0ut5j3883pjwE5DoaivKLH0Kg2dXDGCyH1Ye65XRVpylXqT?=
 =?us-ascii?Q?V3zg62oray1Nb+TIa0MYHsa56MmQaU7oGYqPV4rBc7eUoUa+C4oHkKh/Wdkc?=
 =?us-ascii?Q?yedZHjXjm8pP8mUfB8Z7RtntIfTIa2TILvxSwPRA5EmZ+SD0?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4951327c-8737-4be2-7dca-08df13feb717
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:28:02.3865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bw43NyLgqdBG8UTH3j8o32aLWrus5gVKI0WI8hNMPfJTEoETX7Z6glHHZHq4mHAzrD4c4vFR9/oLgK3xVOoOMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999128

Public

Applied.  Thanks!

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:50 AM
> To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; Wentland,
> Harry <Harry.Wentland@amd.com>; linux-kernel@vger.kernel.org; Kazlauskas,
> Nicholas <Nicholas.Kazlauskas@amd.com>; simona@ffwll.ch;
> siqueira@igalia.com; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Wentao
> Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] drm/amd/display: Fix dc stream excess put in
> dm_update_crtc_state()
>
> In dm_update_crtc_state(), when a modeset is required the newly created
> stream is stored in dm_new_crtc_state->stream and an extra reference is
> taken with dc_stream_retain().  The reference returned by
> create_validate_stream_for_sink() is released as an extra reference at th=
e
> skip_modeset label, leaving the stream owned by the new CRTC state.
>
> If amdgpu_dm_check_crtc_color_mgmt() fails afterwards, the code jumps to
> the fail label which releases new_stream again.  Since the extra referenc=
e was
> already released at skip_modeset, this drops the reference owned by
> dm_new_crtc_state->stream and the stream is released while the atomic sta=
te
> still points to it, leading to a premature free of the dc stream.
>
> Set new_stream to NULL after releasing the extra reference at the
> skip_modeset label so that a later goto fail cannot release the reference=
 owned
> by the new CRTC state.
>
> Fixes: 7cd4b70091a5 ("drm/amd/display: Rework CRTC color management")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5fc5d5608506..28300a3e757a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -11706,8 +11706,10 @@ static int dm_update_crtc_state(struct
> amdgpu_display_manager *dm,
>
>  skip_modeset:
>       /* Release extra reference */
> -     if (new_stream)
> +     if (new_stream) {
>               dc_stream_release(new_stream);
> +             new_stream =3D NULL;
> +     }
>
>       /*
>        * We want to do dc stream updates that do not require a
> --
> 2.34.1

