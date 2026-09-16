Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010041.outbound.protection.outlook.com [52.101.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E686F52D2B1;
	Wed, 16 Sep 2026 14:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569121; cv=fail; b=OaE6qBNADECa51LBOZ4EOmLH0D5pY/RWUsJJJ2byT6z1TvwQnJxUqIl1qUP7LCHLksEC3olRPil2BcttUgav4PPD7anE/lh3oJOKPyAbQ+vmrXdVnZEkxCt8HWivUPQ8ZXvXdGdpiDK3x644R2zMNJ5jJu66AvFYAVZ8b0VkoSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569121; c=relaxed/simple;
	bh=9s0NqCdo5oLi4AsnNdVPdxDLs5JyKBCAwQYJA67byys=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=POAeXiG4eiik6fWUKp5q3Jg2yfBvihAoTmSRH09Ib9rdys5s2CZJ12BQnW7NiqXM7g7qz+O0cB2+k7DXdoTpeH0xPRIPv41j2IG0I9uzMjjtr8PCTY/f8jwkWjtb62OuPfC+qw1ONhaXMbK/NtAs7Z/tGc9SFm4KAY0zCVlCNZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N82IRspb; arc=fail smtp.client-ip=52.101.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N82IRspb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ymwmKrDpN2nKh5g83LCiTiCZ53o59aQxtxnwJrPUS5VgrG1gvJjjnDczhOBvTg570lme/tKTGc4lfH0p2HQsEXKUNGba4wMVU0WBMoWc6HyQ2GX95uPCaQwA+ndRPFrd+o5AkbzXL2twGdfxTD2AhjD0lFOF2H2VNoiGzdwoZa3Zb8hAPSpbzIMTEZ8Z8DFSRisEu153KW6t8v2PS9muyULBd8iQVUv2d/sG93yfrDSUucB4TEtkwUkZC2Sx+KSW85p0XM7VoJnfOePX2igEh61ZnDBoiC04JUo7glc0gQAJsqGdlQgK/b64xNdGwDUnIFyTDt7TEQL+vZ8XXtOk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxelOUoC46zFPtDKIdHkITI26kx4z4PpqeCjfdgiYIk=;
 b=EA8oAeze0m3cgBADtTo0iVoIEW6u1CttpWWad6ahbUuVTcuk0ljgs0tog91R7hehmtb9Uo6219EDOcNK3VbGJqpwnKjC8PrlWaZ698dv8tRL2yAInFjVnq0ELlMeatT1huTq16fPCDJJa3KBJ5GT4G759zDhiRvLGmf3yCLw3ptrtGkw03oAbZCcRmuQ4m9DknkGyb9g3s28/u5kXcjKueyBZLOH/C8/+L4s8w+irARp0rwvMyETjVzwvSTjK2DUPWzpH53nWcwpArMEqSG6nFgRfsE/15mOr/9iHV9YAJeFkSNaFoXliEfkiN6GLafLn/lJIwOyqk7HxqBVOWaqkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxelOUoC46zFPtDKIdHkITI26kx4z4PpqeCjfdgiYIk=;
 b=N82IRspbvy8VqllXtIyZEFpDRmOKoHQ56nxPQpFasudi1rcnGOWKqUMrsFbSKlsOCWK/WuSutFJr32thw7xE9PFC9tXd0kpPJRgDYqYurOkgT4DTXtVQQ97Ore6a/pK/BwOJjn7qh0FOV7zVHxzhQmQXzqtAeG0wZmGLhSbZruQ=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by MN0PR12MB5739.namprd12.prod.outlook.com (2603:10b6:208:372::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:31:49 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:31:49 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "airlied@gmail.com" <airlied@gmail.com>
CC: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"andrey.grodzovsky@amd.com" <andrey.grodzovsky@amd.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix vmid_wait fence leak in
 amdgpu_ring_init()
Thread-Topic: [PATCH] drm/amdgpu: Fix vmid_wait fence leak in
 amdgpu_ring_init()
Thread-Index: AQHdRcJ1L4hkNykmt0eBui5/npDryrbRRKgg
Date: Wed, 16 Sep 2026 14:31:49 +0000
Message-ID:
 <BN9PR12MB5146E89DBAC7095ED960BFA5F7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916100139.2012124-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916100139.2012124-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T14:31:41.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|MN0PR12MB5739:EE_
x-ms-office365-filtering-correlation-id: b6a90918-a0e2-4fb5-37c0-08df13ff3e9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|38070700021|6133799003|10067099003|22082099003|18002099003|5023799004|11063799006|56012099006;
x-microsoft-antispam-message-info:
 6aAXy0VvbpkD8HSmy2cUr5/j480FZGq3YpAVuhHlVuryD6RQARzItP0l9KfolkFA69lL+ILeQPaI87AP0s/DzHXvH6z90PiNXJsyyaAdbJxMDMdsOGpzjqXcCbVOFSYdlRdbysOFxS1HdEtL2SOigKtJWHduiIVtwm1GXwnbR6EJeEDVshvSS6HC9pLvNNYpugpFaFfZambdoiykd7zMe3gj1gdqFToJ/ZZ7XiVuRVBbxwigLT9mgf2/OK83yyU1PJmZQ1Q1UcbviYUEGblLHoo/1p0ARv2i8Ommpd3+c1XRkqtM/o5G5Xkh7SN2N3JUJQNKe4RVfAEfgW7flsBUu6ILr6ZjePyQ9XHlf2PKpMVgfP9qsog2UxMxXgYJAyamCL17w+s9vqv2Azwoq6iOGzAEhSYav4xWxLK1iHsHPUn6m/si9l8giqAa+aKx15F2YzIKadQi0HXsQzVJzZEQeCsXfn93Vv0OzQxckklGK2ExgNzzCe/ES0CJ7Ah4BELobBsaacyf5RIx/pPrCqgSkQV8xDT9izsTkJBbPvenMRyjbwg+vlu42oL/8j0FANp0RKk+k0Zl7uFYiIsRKnZsNB8mqI5l7rN++QCbQy1qYg1RosqE6UEjbGiqmWo/Gw9IGEResVl4qaoTb3Cp6byicRVv9+Uvb95Cyb66aRXZr21c3PA/07eABiFXHTy8ThMY1lqWCWz8YsK71CbYKxB8vPDAagGxaeRRDmkPrf9cAzU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(38070700021)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?op0HiNp3dWkPHhQMFEu4V9Ldv1b4PoqsxCYnl5CPzvtfNR4tjD70rKCv/XcG?=
 =?us-ascii?Q?KtQb4iwswSM9slSgB4bEgcISlCw7Qw9ONY3ayqmipuP/3WVz3+kcUMQmviLc?=
 =?us-ascii?Q?yim+FYPyjFDTte4jZFVEwmW+yS0mtItlgWBe2fjPsccZetJjuH+dRD99cL/i?=
 =?us-ascii?Q?PJtgIYCl6ywK57Xn13n71jsjPFnR4aRCRmBJNk/W0M029YKm5d4vqn11du8k?=
 =?us-ascii?Q?7hJwDuBOv+9GhDzr5Btfnt+474ggQhvgbAhG8FM8drNCQkCIoWvmf3ORPc6E?=
 =?us-ascii?Q?0FjkzSPX9gTRqpLExDLXdT9shd2ZLoJOURhM8foFtNmWm3wWd9yM8VY5kq4F?=
 =?us-ascii?Q?8nr/d+d0Hgnd8DMOc7ElzUHWcTD9cHdv03p6SofaOXxtr5Yx6W2QYXMLtLrr?=
 =?us-ascii?Q?hLx18wiTucvwJXYO/5WEk87TZmIjcblBPuXKhVOTFT1sk6olfB21gUpw/o7I?=
 =?us-ascii?Q?We5ArOVVYgva9usTY7DcIcvd7OFW1JbJoHfJ6A7OfQKpioKRCS5/JWCvKl+L?=
 =?us-ascii?Q?TLFni9atJs6GctuoVwX7/npjBwc3R4jvqhas+w3jCbTVwVIYKjvfAAr0ARuc?=
 =?us-ascii?Q?kzHEN2OGcTMZv2vvyqDEoAI/sWOnM1QmaaeDhyRnwItMTWBwzGEqYQ8POKEK?=
 =?us-ascii?Q?hG2eQRXR99/M5VcKZ7iuIR6Qn+8jzVn4NJQ9kCxy5CF8w4VrrQ65vWM+1mIv?=
 =?us-ascii?Q?b3kvVFvahkQnUUlMH8y37qkyh3E8uZ/Gs9T5XmbUHoEq5q69Vji++SEGwNXR?=
 =?us-ascii?Q?UGz65vyxbO0FbAY0Hzd528JqPpajEmQ5Dda7l6pRkmpGWduKARI1ylIKAiwH?=
 =?us-ascii?Q?KoKRIET/fm7yC6fzey3XiMVSpcVi2v0AYu5eIzN7REOF+DEBH8UNWqUeXRZz?=
 =?us-ascii?Q?1YTRFAkdgPL+jdPkg4cyAg3uZ9aR2NXfCLKXLa0pgwQ2PmWAOBfE7+v+jilW?=
 =?us-ascii?Q?pT5hHnt4hc+9AKkg3gOGlflpwAR3CZ4rHMc2KSfvrE5OtbNWlOkthR1ENw3I?=
 =?us-ascii?Q?iG4yHHqT+qRo4kS+2ItDvXF7x0Wb4jLb+lHdDrA++BBSbW+pcs/R4JhIJloW?=
 =?us-ascii?Q?M5xOHK5yPUQdrd+X8Q9Luh+Nw3BrfRRIyvn8F6d9HRTq5ktcf0+MHkmFes/I?=
 =?us-ascii?Q?Q+AX69Vung6PTDHov+Ys4kzpRuuMcU1JhTRaab5a/iAqA4TR9ke1EUCC/vED?=
 =?us-ascii?Q?pH0UwlpqpZzjbrIkpGjFOsYBeiD/yfiZ6vw7oj+z/psSKLoaOpPhq2eq6i93?=
 =?us-ascii?Q?SqELL+ZFsoIi8pvhUaAd+tiEJkDnmsoPx4ggyGIew+6qAfYbAoXMvna7kXIm?=
 =?us-ascii?Q?AUGHZsX78bFbUrz6pFcj6/EQqfNyvuB0m1KuoGOWK2sT3u7uX6fSTddGQ5To?=
 =?us-ascii?Q?A9foozqMVTgPHj1NqpAPwRLz/e+tleOLaRp86niVHa2Az+As/Dt07pPTP+Rn?=
 =?us-ascii?Q?cxauLi11m0ZnER0UKLRqm4YbVY52Q0ixI97o0kcopyoc6Zw3o8991H9tzZ4y?=
 =?us-ascii?Q?cvF3DXBf+Zvk+v9iOrhmuLU1eVUzLuAzSdW2R2w8MJZDwg8QrwRF/2zh+u0i?=
 =?us-ascii?Q?tkPOLoEEecTA7+bHcNbnKZo5A8hL414FKEyWeBSktZhrEBx0kjpDoOQ3PX4s?=
 =?us-ascii?Q?WbWHIxvHLDmiia6+ST4LkhZEnew2TexKHLGk/pyhEnaJSo8dy+jcYf0V7RDV?=
 =?us-ascii?Q?/8Pob2t5sCb3Sp1nAYr2ISUPjaKhhqALTu0rz1+JW8IVvlSk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a90918-a0e2-4fb5-37c0-08df13ff3e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:31:49.7766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzxIme/bNdA1uHZSb0ItkMZRWXuYZ1N7rF/oVT/36IRMSL0ess6GvOr1GZ5AUUkkk1KWlYDHSMHulJVnEBYclw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5739

AMD General

Applied.  Thanks!

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 6:02 AM
> To: airlied@gmail.com
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; andrey.grodzovsky@amd.com; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; simona@ffwll.ch; Wentao Liang <vulab@iscas.ac.cn>=
;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix vmid_wait fence leak in amdgpu_ring_init=
()
>
> amdgpu_ring_init() initializes ring->vmid_wait with a reference to the st=
ub
> fence taken via dma_fence_get_stub().  When a later step of the initializ=
ation
> fails, e.g. amdgpu_fence_driver_init_ring(), a writeback slot allocation =
or the
> ring buffer allocation, the function returns an error without releasing t=
he stub
> fence reference and the reference is leaked if the ring is torn down with=
out
> amdgpu_ring_fini().
>
> Move the stub fence assignment to the end of the initialization, right be=
fore
> the ring is registered with the GPU scheduler, where no further failure i=
s
> possible.  The stub fence is only consumed by command submission handling
> in amdgpu_ids.c once the ring is up and running, so nothing reads it duri=
ng the
> error-prone part of the initialization.
>
> Fixes: 48e9fbd1a284 ("drm/amdgpu: initialize the vmid_wait with the stub
> fence")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index d6bee5c30073..8c12c373ab7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -254,7 +254,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>               ring->adev =3D adev;
>               ring->num_hw_submission =3D sched_hw_submission;
>               ring->sched_score =3D sched_score;
> -             ring->vmid_wait =3D dma_fence_get_stub();
>
>               ring->idx =3D adev->num_rings++;
>               adev->rings[ring->idx] =3D ring;
> @@ -374,6 +373,7 @@ int amdgpu_ring_init(struct amdgpu_device *adev,
> struct amdgpu_ring *ring,
>
>       ring->max_dw =3D max_dw;
>       ring->hw_prio =3D hw_prio;
> +     ring->vmid_wait =3D dma_fence_get_stub();
>
>       if (!ring->no_scheduler && ring->funcs->type <
> AMDGPU_HW_IP_NUM) {
>               hw_ip =3D ring->funcs->type;
> --
> 2.34.1

