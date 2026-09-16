Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012020.outbound.protection.outlook.com [40.107.200.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1E51355F;
	Wed, 16 Sep 2026 14:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568962; cv=fail; b=hf3UOycjfEpIzdKWc2krV14stReZqUH5AbEqHO3eAmTJdXtZ0E2tqPennUC9A0rI6IKINhZhLD2ES4EMGEhHyBpIBsmcOih6/rSEoUY/HIlX30U9ktF5RaaU+8gIrMFHBgX8LHVePqNf3P5A+Ob9ExP+PMdo4BwSF27RV+hjPQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568962; c=relaxed/simple;
	bh=TCVabakr1Bjqc+3hyAiz2uPI+d9dffOtZ2UplHkByVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YC6aoKdVd9rkjycG2Uv8Khw6Hin8nsNqR6UA8nNQH0UI8ZG6fp2SF6EwGat+kePH+kwtLAz6nexXS4EKRCbRi1NX1BlVX1/N8f+Xvq4EVWmV9rqJr6PYS0jhBYQlXBpq040iA+OuxZv2G+Yu5HARtN34lYonyVwy4UiuhtyrvU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mllwAiSY; arc=fail smtp.client-ip=40.107.200.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mllwAiSY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRnPBGRkEmQUivuEd0xMR9uFURVOzxL5lRBTmkLIjq4JfjK8Sdgx0K1ruYeONQqO6XM2OCclHhV0hWvfiTyanuk6zDuqtZdWTIr36TNt6A9fBs+sLEwEzlP3dqPJ+8biIvLvP+GgJNj8JJ4up/1RkihKz4VIXDbeqbajP53SVlb7q1ZMU80rWqi9uquR1WaLeifv0EUHjfJzt/4eJCoDy/+BHyTo6ESVcPLeuDRDeNym6rYgYO+zeJaGjv6YK4pP0Qr14Hynw5V4D7rkkFhY880BDXzjpO1nzfuVQD8Gz6N4F0eDRQr0coUMliARNpD37wRof+soTUve+goebNNTog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4mmPKu1fOv6GWJTdo8mTkE2svHvsEbSqZrv8XZ1YNc=;
 b=mMI2elEpoo2Oq7vD20xIJ1IVBv2nlO6YeCVNnUfBxQkQ4hUyFlR0r8hopSqdC6SuvUxmWtBXnQ5j33EiX+izzffodw6QtowIRvnDJJfOt0Yr+lEd3WIkStlucT6fB/gy5yHLFwJrxyIecP+nRnujYakr4yeBTJsLN1vQc6y2He+o+X/WTSTaDOG1N9sB9fJGw2UOiNNbKi8+f0HCvu7Aw2o6oa8PNrmq4gHefDLKPznpjub23GnGmvhMN4DVwVKNCmKF/KMtf89Pm/rlPwg/TD1LluKHQXJnwqQg2ed0qaV1C+v10a5dyqDAkOmsw1XeKjhgJNSLDih6fitBaA2wxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4mmPKu1fOv6GWJTdo8mTkE2svHvsEbSqZrv8XZ1YNc=;
 b=mllwAiSYEYn/08hwNehVY9dCZTznvPLVumpNPTLRi+n6vQIGj20k0bA+GD6tuyB7WhKywTQHVRv2KskBQ6lawIkK+NmbN8xTybP86Difo9UgpiOQwDvVFvkCovMa3sYcxSMisEbAZolfsaoepZzmeEtdmiAsctjGi0qv9RItXCM=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB8118.namprd12.prod.outlook.com (2603:10b6:806:333::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 14:29:18 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%3]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 14:29:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Wentao Liang <vulab@iscas.ac.cn>, "Yu, Lang" <Lang.Yu@amd.com>
CC: "airlied@gmail.com" <airlied@gmail.com>, "amd-gfx@lists.freedesktop.org"
	<amd-gfx@lists.freedesktop.org>, "Koenig, Christian"
	<Christian.Koenig@amd.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "simona@ffwll.ch" <simona@ffwll.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] drm/amdgpu: Fix last_update fence leak in
 amdgpu_vm_init()
Thread-Topic: [PATCH] drm/amdgpu: Fix last_update fence leak in
 amdgpu_vm_init()
Thread-Index: AQHdRcGakw7VzVBN40SHt09S0Flvc7bRQ+pg
Date: Wed, 16 Sep 2026 14:29:17 +0000
Message-ID:
 <BN9PR12MB5146339F87DC020C291A54EBF7B92@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260916095536.2010601-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916095536.2010601-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-16T14:29:00.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB8118:EE_
x-ms-office365-filtering-correlation-id: c8dea6ab-2018-4a7b-4c9d-08df13fee416
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|56012099006|18002099003|11063799006|22082099003|10067099003;
x-microsoft-antispam-message-info:
 DxdM16i8Q5Wy4OFTiONM9rgYumhO4wfcJsyyfHiZ/8tjVpYuasC9xIoIXws/s1+iY0UpnDIs6s8Ce/SINweXaBIP2FdAXJRfSxUN+cY1MR4LURwSBuqboOdXvGtT/WfxNjo6MTArAUbC/KHMllyMER6y7IMjpU2spEoJxRr8ZLtywgEcPzb9b7Vf0JW1oMGq8HUgHGyQAUefC17AdwqexXklQ8IInkuySQP1yHpVsOGf+9TD8xdVxw6kX56KxC1xTbUT4o8avJ6er5NAl0a+KNmwCJL+TJzP6xKdOVKzOKRZiiVQMZlVAHijy+Bt7bTjwQVNxY9q0rc0P8fZidWBxVzOY9amro7f2PGGClTBC0rIeHB3+62qonBAOZlfTOMfxf08BIDFPMFNMUKrxJpndD2x8/s/B2QoE8VmScquichZsLGybjETrft6Zjoir6b+jAKg7yS9ro/YnpaEcjQgT0RCw/AGlaCMiCUDd++rCr3JeQpJfPy4jxhXx74ZPhSvHnLFo03WcG3P+USoy0TEtPEPE1O7QFdsUY8ThZn8V7LFv78FGnWXXrLB6AYhu4hkTAMRK7/ca4J9kcfJAvrvmtckQzud4YyPv9USulr1hn3EyZ4C72he7VkxO4ElXlnATXTMKP3AEMs83zCqbT8ZZBuJAvN51HtWzdtrmBBjGmRqt4yRpYENsVkpZZruN56a5EB4oxSQVzKCh30hBZF8M1c3BSX3wEzyTMYKnPZk3nA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(56012099006)(18002099003)(11063799006)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CCrrfRl5TCKur7Pxtqc1mdFIgG1KbMSOmrSEDHOS4PHmVjLLRAA1RXh1LhUL?=
 =?us-ascii?Q?cg3i2AT/HpOTd2uQRNRWQKpqCeEZHw/f7kdpam1kXlg7RbnVm5IjhE6+9NHn?=
 =?us-ascii?Q?ASzDVJKC1ZNj5darJW975e8YcAa8+TqGkp6vdxfjQ4/NUKGtKZ6mR/NYRZZZ?=
 =?us-ascii?Q?IDo0p1TMz9IFUYmlDXXV0T6Ja+Dhkh/aKTcG9lnvmRTvfP73wGsM46jqMSld?=
 =?us-ascii?Q?TedB8J2nBzm7Y1Qd6Kjdw7Xjr5jJjIwB+tQgeRmnsWsEb5Mzaq4HQ3Pbv8qP?=
 =?us-ascii?Q?3SE9tpsQ8hShdj53/uzHXTI8sftmsbzJ7yep22xO2Rm+8FpT2vGhAu+l+LhR?=
 =?us-ascii?Q?r2YWqBVIWBjdeqabfzaqw5JmfjlJoF0Lp0QhpucgrxsJopv9u+NrrgVQuHHe?=
 =?us-ascii?Q?hD2HhCjJmKyRD7u0kDrHBvFjb5+34oecfv4Q6OiCyzJYos1K+/39CZF1afA7?=
 =?us-ascii?Q?B3ims9vJSRGkTMTyPQtSjzQP6NBWkB1kEjN8HoZapMuv2pOZGGAswVTa/f+w?=
 =?us-ascii?Q?vT2mz41Jtqr5anzPQMj+6bu5L065AUEkWDTe3MVnNjgnlj2/TZxIY0E01pqo?=
 =?us-ascii?Q?Y4KRDF6PRGXnuUT30YCK8F96LQmBHhSytSncs1+TSB4+DfcYe1xlaGiJpgcs?=
 =?us-ascii?Q?EUoUnDiCu8a0OZlw2EOEGszV8VIXosVnSyQKj7gf4WO8Axfa/vQBz+8ZCkbM?=
 =?us-ascii?Q?M67C5d2vhqq+f6hzrf9t8ud8wS8KFAuhP1X/czkWp6fgur3+puCLJSVz1LCl?=
 =?us-ascii?Q?dL4QjaNc/PzzVS6XRhYdkQL1qlI9GkEixBGe4ekhcQ96Z6s0Od9GwVoC804e?=
 =?us-ascii?Q?GLtRJdwUwm0PcIW09xVIbxZlaptYcl3EHGDtd0h5Buovu9MoVo1fkFEpsTfI?=
 =?us-ascii?Q?8hSOExsDIYRppGSPFLhYhu5ihGzraEI8QQT4fqiQ/eiDyk9fHwAyadnNamli?=
 =?us-ascii?Q?SccYt3iJvkX9JwZ/Q6XP5LC9TBkbIc6C00M0RKuYAuXrRZNS3Rn7D+B0OwXA?=
 =?us-ascii?Q?di5VoKwY4LVosTWwt6FSAwJi4qQuA5vzMXJSVs0nnzrns7qxPbZlOQP5pF9i?=
 =?us-ascii?Q?ILj9PfJG8+Ic2PfeohUcM+gQgnisPqSGGlImBTbJb8WZ0coWZ3TkhZBeeYtd?=
 =?us-ascii?Q?cwnZsPllYYu51g+SMfgofEXjtgN7yxtLamaZSnkDVxgFEdkgzOEIlWkre7cL?=
 =?us-ascii?Q?/9gAtQyTaT7TAl0kmJcrZsyGHFiLyGA/VD9Sk/7i5BZsmkLkf6LkMIl4nETO?=
 =?us-ascii?Q?c8i83dHAu2YnyXTCk/U4xSEIKmuGa2fvGJkszPG8PA3KcB1OQe6sZX6rjdB0?=
 =?us-ascii?Q?ZRd8YGfZx56auVFCekqKRMkLuEF2SfwSSeSUHpf2ZfnK5uBvoZ8awkSksNvZ?=
 =?us-ascii?Q?LBy9TYsfFpIUbEUUb94gkzCzDm2USMda0wY8IReBpccJISDgUhuAxd21/9/c?=
 =?us-ascii?Q?ZzSDm/S1XehnzZet0L1GMUj+I0g6di8ERbRyL7mywyZ+zpMQBdQ1VUjcdakz?=
 =?us-ascii?Q?T2MCnMBsmWzvHeEB+ILNW6T+sFZPFdenGfYpWg2oICx9arMfAYWZ8tk3PdSj?=
 =?us-ascii?Q?X7ECSoDnHymfVlaDpAVR7iVh41P/o+BmvHjHmynWsnSOZYb75gaLJKVR00jm?=
 =?us-ascii?Q?0DhJYdFCF1mSf22TQiwK/Ii43rZK+FHFntttdfGIeWMTiUui3tVryzv6pCpH?=
 =?us-ascii?Q?ZPWvxwie+ep7bxegn4F/qPA7ew0oA6uucPgQTa06NbVR6Qvz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dea6ab-2018-4a7b-4c9d-08df13fee416
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 14:29:17.8854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gMoHujbqlSy4w0Y4oDZH8dMRIAeirlh151UCYWzOwib842wgjvBdQ7xR4C3koOnT15vxArr6zILtAQDVvArA/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8118

AMD General

Applied.  Thanks!

> -----Original Message-----
> From: Wentao Liang <vulab@iscas.ac.cn>
> Sent: Wednesday, September 16, 2026 5:56 AM
> To: Yu, Lang <Lang.Yu@amd.com>
> Cc: airlied@gmail.com; Deucher, Alexander <Alexander.Deucher@amd.com>;
> amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; dri-devel@lists.freedesktop.org; linux-
> kernel@vger.kernel.org; simona@ffwll.ch; Wentao Liang <vulab@iscas.ac.cn>=
;
> stable@vger.kernel.org
> Subject: [PATCH] drm/amdgpu: Fix last_update fence leak in
> amdgpu_vm_init()
>
> amdgpu_vm_init() initializes vm->last_update, vm->last_unlocked and
> vm->last_tlb_flush with references to the stub fence taken via
> dma_fence_get_stub().  The error label at the end of the function release=
s the
> last_unlocked and last_tlb_flush references with dma_fence_put(), but the
> reference stored in vm->last_update is never dropped, so whenever the pag=
e
> table root creation, the reservation of the root BO or the PASID registra=
tion
> fails, the stub fence reference leaks.
>
> Drop the vm->last_update reference together with the other stub fence
> references on the error path.
>
> Fixes: 187916e6ed9d ("drm/amdgpu: install stub fence into potential unuse=
d
> fence pointers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index fccd758b6699..494197ac20e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2693,6 +2693,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm,
>       amdgpu_bo_unref(&root_bo);
>
>  error_free_delayed:
> +     dma_fence_put(vm->last_update);
>       dma_fence_put(vm->last_tlb_flush);
>       dma_fence_put(vm->last_unlocked);
>       ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
> --
> 2.34.1

