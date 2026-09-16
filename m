Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DB54F0557;
	Wed, 16 Sep 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568921; cv=fail; b=evapq5+N1ounDEVGzrtH5qVynTZJb7ZyxI+0nfrUP/R9VF4s4s/qbCBk33qnCUnXoq4151g5Cu3cFsP+XZenU9pdjnZdBwb4DA1X4DP1OOCODlSxYWvfgiwTd6hX5SgCy1knAbyqFYx64P8ZxZpyGP8t3KqCM6i7imAbqKW2u1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568921; c=relaxed/simple;
	bh=OwBNtYrbqWIVKPlfOx6eywRlYbeL/dRWrcB8dC8jQvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YwGZSQ0EQzKLzlVcDRrQb1T3iFKTjD9kRYCBQQDwUnNl6K1UR25chEuXl95rwturj6Mo1fQVAJwVxzxgGmy/Nu/h2CXFwnuxOholninrOKWsjrELPL6hlF82R+iNmP20PFWUM5/LYFZbOuOXkd9wya4Kl/SQ1cU854fYXDxyZ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p76PQuwL; arc=fail smtp.client-ip=52.101.193.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p76PQuwL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDMUaJU8RGL2cBOAoDWpd8Djgw2aRNti98aQqvwIz5XVQsnxRmDVjvVaZVHTfG7QOTGF7n+M+H7Thn0fn3qacwu7nhWjzAIU547gbnEzU6MkV/ncuDdodFYnbd5rzjtja/KJ2o5FGdlXQ2X/u6zvC1KJ0fKKgCB6Tl0nv/SUy6PL82yHKUXsMfDtwEis/DMce4KAR0LxsMd5pa2tATX59xYYlIk/6fTpm3afuIZ1BoOVEpwZ0xAq+hcpiR8SRws0OnxRahloQyjMGC+KiBelEpGV1lKe3quUJPpFZ/WYdI4zlkgYvtU17kEoiPL2EMzhqTZ1XLV1Z1P3vwvvz007ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l3Wm0T9bNpYeRr8Y06EmJGk6mRLocXvC11zet2Dl4xg=;
 b=i0UNQAaYVqnpbWNic/SarvgieY3tUi//z49ZSqUMtNJd7kloENsTYGHYuebESjtIOb+BMie0sl23xGP/Pd8mOs0XTCUyx1tdjRoh0YbHRxD7ZndEDK4gQOdcVpSd1tE8fxwFssqEIoONut3XiYybbAJggBR7wqr/GXja8+Lp6//XVC+rx8WytxYeSv+cjnWLao0CETxW+19GDweyGvu8+zhQcHvSSjeu+K/T162V0SiZpbIqR9hFwzVOOYvsuPDbpZBKnOn8fo7WlfMv80xYggHZ3uubf4DCoQjUcCXWwHN1RDpyODXJULkbuRMR5vjn53nnTuqosl4jRgdtyGiNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l3Wm0T9bNpYeRr8Y06EmJGk6mRLocXvC11zet2Dl4xg=;
 b=p76PQuwLf8AAe5cedACIadN5pS7GZERjoMnskvaIrXy7XcaN3z5sZjHS72siOZpDb6KEgPcfwbGA4vmsZZ4h3e5sp8pdsptofNoEo7FqfjR04EYFjvF3D+NmSzRNJ3JG6MRXOub/Lmpy9/bDxicCN0QDpy2bOcYVon42obeVedA=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:28:35 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:28:35 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Francis, David" <David.Francis@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix GEM object leak in amdgpu_gem_op_ioctl()
Thread-Topic: [PATCH] drm/amdgpu: Fix GEM object leak in amdgpu_gem_op_ioctl()
Thread-Index: AQHdRcEt/Dfsyy9EpkqRNIF3qHMLM7bRQ69w
Date: Wed, 16 Sep 2026 14:28:35 +0000
Message-ID:
 <BN9PR12MB51461760A35CFA6E56D55B5CF7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916095233.2009025-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916095233.2009025-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-16T14:28:15.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB8118:EE_
x-ms-office365-filtering-correlation-id: 6eb5a7ff-f511-48b7-aa0c-08df13feca9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|18002099003|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 Nh5KkzhjmSV6itkQwFvegOUw2dGSipG7XbCDbRcf1zv52b9uYmRKuBTj4rrKn15NJA4B8HpXSX2wdKzyOJW4BZdt7sbUZt7C16TH3EiTwB21t17D6b4cfLDixnQsb5kaCZIJjzOBBLsXaq+tFDjyIEZtnEQSvWEIYTIwAx6FHRbIfXunjxkLVfkJ5kxhN8HfPI0ewIDDF/lksJpqIVW/bh2Jm1ex5aId2Mz+FZ8HN8rjA7JZtRqZosVMLujWkSKcQANAspM8Tm13sgxYU8CwSh4VAbcenBv4kx77AR4hR6MPIBErLTfv+i+KSzwyQT+uQHO7O+PEQ8Zz8FAS5Aizm1jNPztJkM+XeR/J8y+pbCIsP0y1B8WVFlWKf8RNw88UcgPzg2sKfYrBDtrltavGT8hVvQki9aUYiBcj0QXXeb2Iq/or+z3Z6fPUIfBNKtJyA4Wdaz+tfcc9CbQ0hdvKOSu4OCvS00ra+jU1Jyb7Ug1B6K4N88tgHm4h19gKH+52g/QZK+23X4mzVsJu3n8CksSrAOOGGKpObWbNdt5bGqMZo+e5onW5AzWtbC3uTLtvyetg5V9DnPw/rbSRLeukbyGr7ZUq0hJO8u3srBffM8Wrc2CDx0QnNjrf1jJUTF4pVLPMitMW84p2kWwDHla7iGljjDeQ+wagPiUJkf/6ScVUCGd76AJq4Zs6CwssEZ8L0ltJbtQxnQLvajR/ag5ojL2gl5/4EjxSWqiYtUJRimU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(18002099003)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7fQIRiiuH8WIxHsd0aHsJ6pprmBLOMaZc32qiW776CTbjStVlGWj/8Q1MRnH?=
 =?us-ascii?Q?CwRxWRcES0z/mITSg2WPFT/xHaMURP8xk5NGRei3gUB4fBPKcSdEXqw49ioF?=
 =?us-ascii?Q?wH7fQCxkZcU/Z7ha2S6ttVp1LNpBtAkvzW3plS8alqJSWJ16l7anYY0a5soE?=
 =?us-ascii?Q?30Q10YBk8vrZKL/t9SpTEHVwl9Us2p0/ioIYVxSo2lrHz1zAxxtAK5A8Wb32?=
 =?us-ascii?Q?9vwaaIrPJHqv4rBw8TpRtx43yndj5vMvpxI15OphYoYTya8AOLaxZBsNHn14?=
 =?us-ascii?Q?XQ7dHbrWG6rJ2i7ZLmMs46E5pA1xOxZVVcb/mOWuEbyN0SM8bJuBkYdxxxa0?=
 =?us-ascii?Q?AX2XjXlnTtMhNhD32cMTcbEz0XClnPMUK4uCZZfpz/xMqAb//h3AGEJ4z+8Z?=
 =?us-ascii?Q?Te4KC02euL5GHACghKQoYBV2EjAgIqqTcovZrmCN0x+Es5FvvlimBQjAiQ8c?=
 =?us-ascii?Q?6EkXE4VyRhhdBoAECm71wrc677CeN5ArxhjyJJXNJCBmkLYI0JLlHq7Oig2l?=
 =?us-ascii?Q?otNm+NPVLPEGTZwK0n3jVWomMO6xc4l1QWwzT9REiMH3eqJ+8lhU5ADEu5xF?=
 =?us-ascii?Q?4qfoBgXFeC4C3i5tnfi2tDx72M6JLc5mhJWERMsyfqRp06PgBVP4GkMuSaRa?=
 =?us-ascii?Q?vtnjR/uXXpM/R+P8np8hTaWsA/EmEz30AoH2kfK+Ct9rY2TrxGhCEuExUIKM?=
 =?us-ascii?Q?P8gEFve4y8JFbtxcqtU8bo7iyOaiExoKJozTRRRdZnj733Jd+Jqyu2zb6Rac?=
 =?us-ascii?Q?Z0pqXtYSO9PEb/TMz+H+vlXzB8Nn2+/prwYPvvAngx+ONG5YA/7fBzEDcEGk?=
 =?us-ascii?Q?Dc4L0zIt2EG1NHqtDz++r9ag0dxzgmCN/9Yd1DbG6rQvgM+otwmboWMhD/lO?=
 =?us-ascii?Q?eeuOSMOa0P+zvAbas+I2eUEdu3Fcrkg3DU8PBZC8AmCk6Hw0qTKde+oi4MfW?=
 =?us-ascii?Q?SbSzBSPMaK1ftBowN/T8ZzuF3SOZvrfTuGWxJy8oz054nQXYIEMfXvoliZ1k?=
 =?us-ascii?Q?EmwmACW+IT9aE78TtrrPL38F4VSDge8nL9qysgzrBhIq5SJ65DZbZ9fG2T6t?=
 =?us-ascii?Q?t6WSFdoiSnIw49PlOgSK1qe0ydLPvlsPd6JTZiSpWf4LLm/PXBsgLDy/7iH8?=
 =?us-ascii?Q?0ppLlL7N/CfPaENyw9jSexlkrr31mb02T3XlAVbfkG5S1ZIFur7KwmZCbyFk?=
 =?us-ascii?Q?lMm+Xj2JFxrrBoBrRw3MYBYNkwNnT2io1Te+KKJC+iAZoHuOdmMse5UsniGK?=
 =?us-ascii?Q?P8T0OS+bn13V6Kl7ifeahTjyc1uq807ZYOGpgQt52WGoZfwTRhzJMWbLwJHo?=
 =?us-ascii?Q?lLK4r7x6l7eygs16X8hWXb4/gJaxOq9KafYUpcEjJgOxIzN/r2El14WM22xs?=
 =?us-ascii?Q?2QzmWGHlcnp6UgPeWOUwqw/fOcLSl5KxmkelF5q6+VSh1/0ZL3xePCx8s7BU?=
 =?us-ascii?Q?hiY5MBXBnQskzPr/mT5HLtpwA/UaGhnca4O07BORudCbqXU+j5T/Q0LgMgot?=
 =?us-ascii?Q?ENFBgD+EmJ9EGXnXCQSTj11FYtDO/zfJlO0cvh42BOkW1AgelIlrmEom0myX?=
 =?us-ascii?Q?laEYLNLuhCdL2kW7M4L92jrALx2fQXdIwaMvzGOr1PaaVHi0dpTY2kcRhwbK?=
 =?us-ascii?Q?lt1s2G9qoXz6R4Wupm8ipKlHU6ApJ4ocUCUD1/Bkl7n3HdcDWK2+7mEinprI?=
 =?us-ascii?Q?A/6Cz3S2dINPym4tcvjCh7BHas3vZTso53vRc2hufk2uZvsM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb5a7ff-f511-48b7-aa0c-08df13feca9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:28:35.1878
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wgeh+aJIY6JMJGjYvAfGlD/63eJ3K1P+8ZQ1a8fhmBcrKXZXpYFF4Yr2hBCV5sKO35ydtuXgz3AVsy6V9sZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

Public

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:53 AM
> To: Francis, David <David.Francis@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; simona@ffwll.ch; Wentao Liang <vulab@iscas.ac.cn>=
;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix GEM object leak in
> amdgpu_gem_op_ioctl()
>
> In the AMDGPU_GEM_OP_GET_MAPPING_INFO case,
> amdgpu_gem_op_ioctl() takes a reference to the GEM object with
> drm_gem_object_lookup() and holds the buffer object locked through
> drm_exec.  When the allocation of the mapping array fails, the function
> returns -ENOMEM directly, leaving the exec locks held and leaking the GEM
> object reference returned by drm_gem_object_lookup().
>
> Jump to the out_exec label instead so that drm_exec_fini() and
> drm_gem_object_put() release the locks and the GEM object reference.
>
> Fixes: 4d82724f7f2b ("drm/amdgpu: Add mapping info option for GEM_OP
> ioctl")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>


This was already fixed.

Thanks,

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 123d4a09114d..06dd2e8a5b47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -1094,8 +1094,10 @@ int amdgpu_gem_op_ioctl(struct drm_device
> *dev, void *data,
>                * be retried.
>                */
>               vm_entries =3D kvcalloc(args->num_entries,
> sizeof(*vm_entries), GFP_KERNEL);
> -             if (!vm_entries)
> -                     return -ENOMEM;
> +             if (!vm_entries) {
> +                     r =3D -ENOMEM;
> +                     goto out_exec;
> +             }
>
>               amdgpu_vm_bo_va_for_each_valid_mapping(bo_va,
> mapping) {
>                       if (num_mappings < args->num_entries) {
> --
> 2.34.1

