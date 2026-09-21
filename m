Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ABA2E4257;
	Mon, 21 Sep 2026 21:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027297; cv=fail; b=M41s8LEibRJHmhmsAUXw3Da2zTChNCJIDpPgRv3gsbnPslh638IZVFW+z+ymwvZUc+hQW06YL/kn3mMYWRYxwsmTA/ZzwY+ZJcRJBTCDkM4ue4HSWppkg5JrvqZVqpwfHSUMQqp8iIuif8f7/pWKltorOHuXfg26AelG6soBPtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027297; c=relaxed/simple;
	bh=jGwVd6sawiDZVO2mQmQNRYPRn/S/O5cIBCNwrh2VoJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e44tj0ZUXY8CiaHj4Mg6vMdmBXkPgXYPuU6oyiq83KTr6KN3jD3K9QXsXeUt5+D1qEn7PdEq7rvYfnpp6WAElcoFJxknYDEZGpZYI52aMMEPTWblGTRGihy19eJbE5LrS8wSVuNJa8/xm8speXnO1G6QsSzKEIh3xF+Z57x8lbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mf91jAtP; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mf91jAtP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=guvqv8wJaBUC/w1C8zfSE5hvu4HG14+7667kjhfE9NjT9u2yPetMhQbFE6xVeGDe3jmIXefWhYE3HI9vlJ4ynP5CG1F+HguIU396gbzDb0B2UKP1Jz7o2LrEVFwNX4nqiHHkVSBOuxXD3qHqsBtLNNC+QcA+og1KTTT2/AzBol+2oipr3RtaGuygmjGTv+JS1ovzwSQz/hrRDiLRM1Uk5KddfP+LaCnRK0xZcqHuoVPth7XjZ3z9D/iX/jGaFA3WBNA40S+zcfnlaWY9OfinPxxggpVV9BDP0EheuLJBuRij0mMXwow38xHBjDA0wZxgSa6ouXjGs2AomiuIxSaLgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Phl0XDoLnCKHedKQ5e8lTSRh/kF6vHKMJ+RpEkPHwo8=;
 b=WZonSwMCW0qpGx1evvbTLPFz7Tgf5uizdCf4/xSZyP8/l7jftBByCAgS6RaNFaSVYhxd2c0ZoqXgfO7L951UHCRcvIAVxlqDkEHkN0K3nunAB7WCuzyUWfgWS9qPaFav5COI3LP1Yt3vU2s2GvkH4W3F+nCgyYRSIGlXoWbK181Up/WUeSMUFiV66l3tTT6RNvZMOD2369inJKjm/H6aq0lsIu0sShIt69Uh0FiL2pOOaDdw0Qhto0rwu9tiEnhKTv7gxclbDzLtbETztzwpi7R7ENGkDkIr5jp/cLUWsD0sSIyPNYhAkIZdPLXiUQh6o2ZSBOukq0FQu2tc+pSATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Phl0XDoLnCKHedKQ5e8lTSRh/kF6vHKMJ+RpEkPHwo8=;
 b=mf91jAtPSS3hAODC9BPtQ4IK8Qkgf9NBIxkYEkN/vdEDcnaQ1GeG/zQYRzMNrWlKpqagqJ5e/gcyrEptKbo84ohBz+dX/uIeQxPcpJw+PlGwcxtb/edISgtUkh5/n8ERZ4apugmvA+TOIWc9SZFAXoS3rQoN+zGmQ87nwWn6wqA=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Mon, 21 Sep
 2026 21:48:12 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 21:48:12 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Theo Andersen Carton <andersen.theo@gmail.com>, "Koenig, Christian"
	<Christian.Koenig@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "simona@ffwll.ch"
	<simona@ffwll.ch>, "kai.heng.feng@canonical.com"
	<kai.heng.feng@canonical.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: skip the noirq suspend reset for a
 switcheroo-parked GPU
Thread-Topic: [PATCH] drm/amdgpu: skip the noirq suspend reset for a
 switcheroo-parked GPU
Thread-Index: AQHdRtjsJhAlU4pWWUSLFVt7JlfmK7bZl/Ug
Date: Mon, 21 Sep 2026 21:48:12 +0000
Message-ID:
 <BN9PR12MB5146F83D9193E17FA95CFE63F7842@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260917191512.38838-1-andersen.theo@gmail.com>
In-Reply-To: <20260917191512.38838-1-andersen.theo@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-21T21:48:04.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS0PR12MB8248:EE_
x-ms-office365-filtering-correlation-id: 2990785c-695b-43c2-ee8b-08df182a08ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|11063799006|22082099003|18002099003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 RLFwlqa3TohDUR01IHqDZEIS1d7KOY46ZfEY8RHnuMktLHsxnZbmI66Xl2sLFg2LEEj3/1J8/HnzAXUgzPXXjKHi8AIaPs7VuFj6btcqKbcH9VzhDwJdUBRgjHtJdjhztwWp4NT/5ioWRMMyjyyrA+w9Xn8kHqCx0tU+v5ZDRh0jAWW1zlfU9rMgtsP8B3Y6MLwaiX+2TUBtFeUK45G1DaUgsfOMAFbc1hLWr5ZeRxtS7HFrxryK/ju5MornfyXMUEBA0JHVKL/0hOEPSHRB+i/jY0QfXsq8BNZSTD/pe7TC4DjQ6PSYvAQLrtC0Ui2AWDLWp8EK+3w4ZI9ej60umcaftLOcR1nhS8D6tM4fNJS92eOQegDLrquRIYm8qNyiFo1l50XDxLBI/F+5VPuWUbvWY8YSv2v8wgy5Rx+TvNFiy2mR3TBCoJVA30avO81776Ae2nCJQPbQLn0CVx/Reajv+lbdNDbT8848pXmKX6zkJOpZHqrq8ommgIPgqREt2GqFcfrj8O5QKtLnRpQeNVj3XbGxaE2X0cG+n8ntxi8bFRWNP7i28GZRt1mlF0uiOv2jNa3dQvcmav1MWDsdCIOGU64qaTvs3a7+2SXlL6VwBUi1LZycswr7yTdsqPNP1y+k5urrTUTF9s0uyQTMHzRSeX6KCyplmBWWaeDWiajQ1ZsFWF+ot6IMfX5G++xtUef3fAJjfMnejReobdLVQ3sf6VpDSunx6ZQOsYv+FnI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BDpBHsAivHK5WA6uvvqnjEtxX4iM9j/4flNlsmVTzt+4YsIvsfLJm8yicenv?=
 =?us-ascii?Q?TiVEeP7Lph8gxRYmHsS71CYaWrZ+6vXhCJVzatO660bd1feDVXjFwRXsEUGb?=
 =?us-ascii?Q?6+Ggg+KV1RaxM/gcVQVaGSKi688YpSZqft+ejW1y+1NBcHbaRNs3d1PQ81RQ?=
 =?us-ascii?Q?Ys9ffOgK3+Utbqja541k3JCTta5014M78xiIsFxK0Q/ZlbvMw0LF5iMDsGjf?=
 =?us-ascii?Q?QiiOA2A0aI9deW+GPsdKeumWaNPq0gRNOT5PFxZvRcvTp8zCtC/fMyxdLbzy?=
 =?us-ascii?Q?R14SKjj8PYLZ5yFhI+56hqrPjhDYrGx/waL4QA3dKJ++ECNR9D5vgpo15cnw?=
 =?us-ascii?Q?1TIWub7rTE6LDwni7W4BSTeXj6pkvkHnOBcbZTRUFYO6Dz2muqEGmbrSWG3n?=
 =?us-ascii?Q?RhZuF7DY0b2m5AXa0mTFTVAj3DbKDKWhdgSuZlsO952QAnFLy8ZhJhmbLqwJ?=
 =?us-ascii?Q?W5iHb9P1RfaSaDdRpfXe5ogEanmNSYl/lfHc1RsAQBrUG7ZxllAInx6LhqhH?=
 =?us-ascii?Q?tn9W4WiDzNZQ78MiQ3KbdbJPaXzNJ/87eb9kMHkf/iJ+t19p5PGmTG+kUyT/?=
 =?us-ascii?Q?s/Tuxer4uz0+M2tcEL+BzEWut8XsrR1auMXu1+ngY5oFhdApTa2p6Ubu6b5W?=
 =?us-ascii?Q?hGNrtgLjE8zxdLta0qIu4fHf2Zt86ds99NLHu5ipWy97fqpl2WkjP6z9Z0dV?=
 =?us-ascii?Q?Af8C4SeO9uKiiu7t1lz4b6ngdwZV9/Cn5Kxb+zbk6dN5fk0zvq2BocJF4Rog?=
 =?us-ascii?Q?j9+nMU0AsTmr2Bp2V1ysQIwSNyQvJG22pCMye4bfro+YzJE9IIe/vdN6ZTku?=
 =?us-ascii?Q?wV1GlmlH7ugE+MtMGksSNUX/nO8dvkUosWxnjkmay3gfBZX/duq2QCf76Q4F?=
 =?us-ascii?Q?j5AL+Iw2ij77UrhYfJY/cWCBDr+2d7R+7nh9FKIgHzm8rYWS4yFFuneXjGRt?=
 =?us-ascii?Q?OyZZxZSjLJ3N9Pt4OXnp5xBD1JpINf2pZlwxjdQirru2cvEWoJhxT9kEIvP8?=
 =?us-ascii?Q?125nSeA9OCFzR1MZByLipL7xJ475WvKMCkSdnl6DBI/YP96Tx9jmpClWPdEr?=
 =?us-ascii?Q?GrAJ88Pys4a6wYm0HJYdZVG8NxrCYzLmkpv3lONjTpOQkmd8dzlLPfXyokgU?=
 =?us-ascii?Q?PwOmtR626yQEodeoAxoD1vNT49m01X7+yKtKKDQz6h2N8Jsi2Kk7b55RF5A/?=
 =?us-ascii?Q?kcZicc4w6J0ca6znLhLTiauzOfeVHtgahIKY/pKMJ5kxK/M8XBd+w6EJus5+?=
 =?us-ascii?Q?U/Mn1pqhnpe/EagNjC0TK68PhnnC2DYzqCrgxm1QqViLb8LerDb3Qw1vd/+X?=
 =?us-ascii?Q?r2d6Co042vvBeF8zbQxzo9H5v681T+cRjY5WP88AYbfO9Kuc1gZ454x+2fh+?=
 =?us-ascii?Q?kPxiS5vlTAK6DlsoXnO1WoJDwkoVp3vo28taPOxcUsA63xL/shnGOVruaQJW?=
 =?us-ascii?Q?7djdVDRdhmjwfWuKDlezFfk6DIv/lmXOIM+FKAhKc0sq4YAMTSLI7e9hU2dT?=
 =?us-ascii?Q?iMHTGI40ajqlskudVLH0pxX6yNOwfoXPDAOChxtkVT3iBvZ/ixSp+CuTrldH?=
 =?us-ascii?Q?RCsCfDA0iDaaM/+0gfd8jjWB7qpqzzeGDpoUwH/Uz1s0HRaKfxw8TS4uLSnz?=
 =?us-ascii?Q?hpcGBavRnlfvx/g/Di7U4rMjEmAma13v0cTtaFuSsKPzvyW/jMOiqzaJ9TkQ?=
 =?us-ascii?Q?TZP3qf3EU+LEgFbMxAtiPlCLjE1XXkqmdM4PPji3/zsPF/Dc?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2990785c-695b-43c2-ee8b-08df182a08ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 21:48:12.7182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kp0oZudeKUb0V1EWMpOsD2/FIraSpSYw2B1oudMgBh87mnyq3iPXn2HT4siMmZIVE95K4UEvGL2rwWlx+nPdaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248

Public

Applied.  Thanks!

> -----Original Message-----
> From: Theo Andersen Carton <andersen.theo@gmail.com>
> Sent: Thursday, September 17, 2026 3:15 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>
> Cc: airlied@gmail.com; simona@ffwll.ch; kai.heng.feng@canonical.com; amd-
> gfx@lists.freedesktop.org; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; Theo Andersen Carton <andersen.theo@gmail.com>;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: skip the noirq suspend reset for a switchero=
o-
> parked GPU
>
> amdgpu_pmops_suspend_noirq() resets the ASIC unconditionally. When the
> GPU has been parked by vga_switcheroo it has neither power nor a PCIe lin=
k,
> so the reset cannot reach it: pci_set_power_state() reports the device as
> inaccessible and amdgpu_asic_reset() returns -EINVAL. A failure there abo=
rts
> the entire noirq suspend phase, and with it the system suspend, so the
> machine cannot sleep at all while the GPU is switched off.
>
> amdgpu_device_prepare(), amdgpu_device_suspend() and
> amdgpu_device_resume() all bail out early on DRM_SWITCH_POWER_OFF.
> This callback was added later, for an unrelated reason, and did not inher=
it the
> check. nouveau guards every one of its PM callbacks the same way.
>
> Bail out the same way here. On a single-GPU system switch_power_state is
> never DRM_SWITCH_POWER_OFF, so this is a no-op there.
>
> Found on a MacBookPro11,5, where the Radeon is powered down through
> apple-gmux so that the internal panel can be driven by the iGPU instead.
> Every suspend failed in amdgpu_pmops_suspend_noirq() while the card was
> off; with this check a full S3 cycle completes.
>
> Fixes: 9e051720f9d3 ("drm/amdgpu: Ensure HDA function is suspended
> before ASIC reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Theo Andersen Carton <andersen.theo@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 5c33c19fd9bc..d9d794a7db96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2664,6 +2664,14 @@ static int amdgpu_pmops_suspend_noirq(struct
> device *dev)
>       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
>       int r;
>
> +     /*
> +      * A GPU parked by vga_switcheroo has no power and no PCIe link, so
> the
> +      * ASIC reset below would fail and abort the whole noirq suspend
> phase.
> +      * Bail out like amdgpu_device_prepare/suspend/resume() already do.
> +      */
> +     if (drm_dev->switch_power_state =3D=3D DRM_SWITCH_POWER_OFF)
> +             return 0;
> +
>       if (amdgpu_acpi_should_gpu_reset(adev)) {
>               amdgpu_device_lock_reset_domain(adev->reset_domain);
>               r =3D amdgpu_asic_reset(adev);
>
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713
> --
> 2.55.0

