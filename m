Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013046.outbound.protection.outlook.com [40.93.196.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A894851990E;
	Wed, 16 Sep 2026 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568985; cv=fail; b=T/iCIzM2/cbB6MqYZPiBYY215Pw1oXIkn1oY1XEE5/CWptj/b9P8PBQyQT38VWZ0O5IhRn0Er+d2IZrhVFqKVulUIu5h5mm1XLNztZf2pz8sj2O/g5+erLDxZL9teKBtDsQ5Lx7cGlqKigLphCNwNFlJy0sWJY8niE9rZGcIJ7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568985; c=relaxed/simple;
	bh=M0VePsdEQicKEwCxNzlhKkzx6eYBBXq4qYxMuU3kRkI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y7mMc+mG8eaX/E0vn7pxfWmgbBgK6tsyr9tUWdgACOTEx0rQbKdmtlJSKnb+T62CTz0vYLURX1Y/yppqMOW2inpMS9/RxM91q0GZof1SMm5giP9ulZCS/7N1PLBnpr2LAWffCJ9iYKajCtu8WgPmgCEzFSWlx0GjeKyi4veY8v8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ObXN2McV; arc=fail smtp.client-ip=40.93.196.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ObXN2McV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rUhT9EMFlH6Cc12cC4MyTYvkBoMPdHWfr27jyEOX5S4IgyEnSUdv2gAZydPCl/i+BO/bszzEoGzR+ZMTew4jo8vYkYb6g+UGyWvuyW2m4dYlQkXkQIqzcz0LOJ9flROCOejgHjIrrBy8qAwFQA7CaUgD/hTtdF+I+4N96OrqfRzRCZ6QeFouW+IkNRPNurk3mqG0dzc7BfelYhHOrjiikPaGELlH6fSOorkUphLDDkm6ev95T5OcZoTF7SNbg1RmHIzDniZ5gYeR119ktJ8Vp+QXU6MKUpGRXRSKI9dGbO7ZW23EbcMIri1gd/lpzhV7lgA2VKjduXi9Kd2NOd1czQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4zEalgEREq5XU92hM+YGd0X+5CxdkwjtccFzVKS6Us=;
 b=dsmum2ieUXdM+kGQF5sj/KhxdKuDKC8TfALXQ2gFabrApV72w1OxilNaNHMJW00tuBxpKRy9UtSZUTUGZ1Y0FGZBUP6QtlNcjo4OQNXFYNX9L8R3JtzCXj6zN1CrQTeIxHSe41mnZdKOkCncGXtUXXD5aXmMbfl4IrDr7XNxU6augTnonprsjWSE2XutRwgw3M1xKm/JIHze9F1sw6o2zpNVk2a2kzsOz5Hz4aVVaMSiOWLZ7yVCjOwpylCpeYCXk7xixUiJ4ngYtlrRNEOs4COlN8bsJLfTs6KW3yz5rmIFfwMpe+1XdywN1vNZppdF9gMF3gdMBbnO93gF2x1h1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4zEalgEREq5XU92hM+YGd0X+5CxdkwjtccFzVKS6Us=;
 b=ObXN2McVxWSY+oe1XmFQPbirxtzT16ByDI5r5Ze5T4EhFv1Rf7zu/TxdkQKA27ZMw6HJHGR0emBGs+3G7F3ds+FLYKEYs1SJyR2R2Z3kvCRqIa3CP0QC/Ba7YZoKnYnX2ZZ3Hs1LkyPGkWYBeqIQNN7pg6kzsOXV4AI1rkV4B6k=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:29:39 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:29:39 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Li, Dennis" <Dennis.Li@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Liu, Monk" <Monk.Liu@amd.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_debugfs_test_ib_show()
Thread-Topic: [PATCH] drm/amdgpu: Fix runtime PM leak in
 amdgpu_debugfs_test_ib_show()
Thread-Index: AQHdRcHzYXA+WAdsrkmGdH2RzRd5gLbRRBAw
Date: Wed, 16 Sep 2026 14:29:39 +0000
Message-ID:
 <BN9PR12MB514673757DBF50F06E8F8E9EF7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916095805.2011304-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916095805.2011304-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T14:29:32.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB8118:EE_
x-ms-office365-filtering-correlation-id: 378cf1dc-2d61-4ba4-0864-08df13fef104
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|18002099003|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 t+e7n1mBQipU6KhCAeeuzhQzBKs7DYEwzXETnZwNHWiCnjxBs/d+FGFBcox7VdvnE96s54e5yPTAEHzD1qZkXUmarS+vw+sBuUdHuc235HadG6/aQJzdpDMR5NU0W2areWdf5L3I2/1XnDYEI+OoE8bs1Kh07bYE4gc19djS+Sf8zzQlTVJV4lshEJ/23taSFFASZ2cVCaTepi+t+iBpVYBDoEi7NAonfd39LT+ZgKbr7ajxhjWkkRy1rcXLJwfLVKzbJqlwiBOEWcYpNIPVuuIgPo+1ZIIXQa+OLjPPd4iknI9OawCLZSG5e7+B3VnAPGKNFLsY/rUmijDap0EeH0wiziVBN7N1ZodGZtr0oPH579/boX4oFfumFz65WGL6wQZ0lo3QIvmhdHEv8zwm4HRkacIR7Vy0JJwaxL8rLiKL+Ec0oOhF+rwcNH+FVTeohVcPJOAPKL16UJ8enXnayyZ2+pCK0kEuhiH+5nADqLuADV0OES9A9SEpiLDWO0A+84rq8xUjHe2bOxBv5mGx0Vfip2wAFiNhCWkuJY9QuPlT2x19cfbJTvIaOrk94v7qBYBFOUrjTDfeWQh6ypn/5sAz7q+pMJ/uP57ULqwG6cfk8De64XqkFDB1NpLx9hz3LgAetaBOGoaCQ+DkA4Pf51QMKf/LEZVa9DDzI31i6yoltmXreAWXbQx/uCUjj8iwq/Nb0pyPb6iJS1AITI+xQ2wZbQBYGefwMTX+ZFzBftI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(18002099003)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jjiyaC1nuBRF7T3N3Ix22ggQrZYO9uOVLpsRRs1nhbHc3SkfyqLj60gdHnM7?=
 =?us-ascii?Q?F8nYxtcE0j33lVvkK3LAoa1nkcn9p9rCX4o8HRb6fRhjdAuj6djNXmBD9rbc?=
 =?us-ascii?Q?9QFR45es3Ur5awUbpaQXYM46MCOM+07ZZzFw3vMi0mqKIPkoe9kc30YOpC1W?=
 =?us-ascii?Q?4tq5nIDIenfsbClwYYn0QH1ZQU9OF58jy8TFvFrPiQ18FodSkhjquWLvpXgK?=
 =?us-ascii?Q?+OtEkK3MyJe/NAYAYm1o9ZE9um8DdaUs0fKrOAufqyIo7zjC1d3A7ez9DOrz?=
 =?us-ascii?Q?JN5ZUVR1Zt9AmdnCnQn9uwSMlOjQaZQRT6dNKvWDiHDDV58811denIQsenj6?=
 =?us-ascii?Q?tenAXsC+E3U5+PXD8TEpjGYONvK8E+djmOLAMTFAfhRXGM0jhruhhNL1sfDu?=
 =?us-ascii?Q?h6yNUY0R4bBwNLFRVr7yrLjEjA/VAlqB/ZwKJ3LF2MyO8s8XMXsvDXqz3/Y7?=
 =?us-ascii?Q?u3B3bsjN/+Ua7TzFUU8wNyVw/SeokQgDUQSWn7HqNRJVaJ+bKxVNwrqu9gxk?=
 =?us-ascii?Q?ApLzvJ4hdn2Fh337wEVX8ftKgK65nVRBB1JR9M7TzwNxuMKMJKLwqQO1fsuY?=
 =?us-ascii?Q?DwDO9ibcg7N5DrWgCs6I74gOkNEqbRjaRyLt/TJVuDSa+Oe7bxKrU4BYWZx4?=
 =?us-ascii?Q?evfxdHvLL9768E8pVc8ARtXqkkMbIgHiNUlo09hHYJKYKz+tR9TmwfRHD9pl?=
 =?us-ascii?Q?eeDYefggdbTX0aI6zGFFs7J3pQUt94OZpfkUBGyv0p6r7HvZk0ZWfn6yRoqi?=
 =?us-ascii?Q?b6ul4OPFOeH5+FduMBjO+Nrc2MKwb+hCRuhSgQkP1RWEYwJuY6T5NaEf+dLG?=
 =?us-ascii?Q?p6zwtqh/bXIRqEyAeRHWZIGrB3g8TEgoO+B7V3KYN5d7ku4lCCFr5pDRGh2Y?=
 =?us-ascii?Q?GxKUUL05mqqyavR+MbWIhZ7ADGGP0bELd/eSGAkzw8raryiKj5eCroLYjQJI?=
 =?us-ascii?Q?v2PWQzLji80xOzG6cVP9oYsCjos+LR86yn8JecFnxakwajUhZjMTtFI9Kn3E?=
 =?us-ascii?Q?a+5GQHEkNg3qc6u61RiQj52hMPFeLBdCZFFzcI4RImTU+Mkn4mj1k0+rEwgV?=
 =?us-ascii?Q?Mg9txchMfP50gEJM177Yydvbkb+X16IozU6OMDiYXCpoNSwEYck5ehuObm7b?=
 =?us-ascii?Q?2wK4EZnO60Pk8STTTRVXkUvEjfwNPI1AVm6FSu/LzjPkqQNixlZjhmz8j31T?=
 =?us-ascii?Q?P2/QRf6sjjSUgKu1dhenLMzneMZ80kszBaEg84J/5gxlDab0oy3XYYxOUEc0?=
 =?us-ascii?Q?rOYvpExLFHgk39/8U7ILuRzUBTFPC39hx2mreLzxyrLDyxlB42LKBQh8L6zW?=
 =?us-ascii?Q?rn70eQhcjWFvPC7wqJ+vat9mt+DLt1ygqm2SshF7ysWzpknzWygPm/z4RhJ0?=
 =?us-ascii?Q?AT93iJ1jQ10adXBr+qzd5zkqXOhNWVf9vvEDNmZ4j3UISMVoe5jcKpAumXRN?=
 =?us-ascii?Q?NuupcbreIEQnnOmEbN37ZfpYXGP/ZKG8WQugqxrzT2Jlk0Tf+NfY7ksvcnEP?=
 =?us-ascii?Q?8FFw0d8nKzJV1FbMizkLgQc/MjTXl/fP0C2I34MPoorf4C5fmg5MAQ54hyv0?=
 =?us-ascii?Q?w8ZW4FnV6S9bqLl/gWLyZUsIhQ6beRdM1j0RhLB6QXGzhsDT9QG4RkRT7BQP?=
 =?us-ascii?Q?qNGIeAvSTbEhZm5YeM4zTUe3GWM0N8xI97tt/oxwi0u5U+TjWpSh2hvBFVST?=
 =?us-ascii?Q?9F835xEDrBQbqSbwNaJkHjKNfRNw/lmgvYscluSgBZIYJJas?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 378cf1dc-2d61-4ba4-0864-08df13fef104
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:29:39.5969
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JIrT9XabVnIvDTy509A/uQ9lij7jJ0EtvaGxiL/LATPbC/i1MIwl4L5TbS/9uZz6dcFkpwlcoF9RfWxSh37UDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

AMD General

Applied.  Thanks!

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:58 AM
> To: Li, Dennis <Dennis.Li@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; Liu, Monk <Monk.Liu@amd.com>; simona@ffwll.ch;
> Wentao Liang <vulab@iscas.ac.cn>; stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix runtime PM leak in
> amdgpu_debugfs_test_ib_show()
>
> amdgpu_debugfs_test_ib_show() resumes the device with
> pm_runtime_get_sync() before taking the reset domain semaphore with
> down_write_killable().  If the write lock acquisition is interrupted, the=
 function
> returns without calling pm_runtime_put_autosuspend(), leaking the runtime
> PM reference acquired for the device and keeping the GPU awake.
>
> Drop the runtime PM reference on the interrupted down_write_killable() er=
ror
> path before returning.
>
> Fixes: 6049db43d6dd ("drm/amdgpu: change reset lock from mutex to
> rw_semaphore")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 092fd3309099..adc0252f6400 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1764,8 +1764,10 @@ static int amdgpu_debugfs_test_ib_show(struct
> seq_file *m, void *unused)
>
>       /* Avoid accidently unparking the sched thread during GPU reset */
>       r =3D down_write_killable(&adev->reset_domain->sem);
> -     if (r)
> +     if (r) {
> +             pm_runtime_put_autosuspend(dev->dev);
>               return r;
> +     }
>
>       /* hold on the scheduler */
>       for (i =3D 0; i < AMDGPU_MAX_RINGS; i++) {
> --
> 2.34.1

