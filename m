Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62D2DF6F4;
	Sun, 28 Jun 2026 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619001; cv=none; b=JR3voqqmOPICOMLcgEmb9ZUyLpM6Uk2ekeCMEpf71QddBSAwR15ne0k3q2QhFBVsTMP5XpPdl9YVmcMEHpFnmbuoqvx+Y68U6I5uPFNqgrhLORHxq+Cg1x/spqVYGuLCfvYTc3updQL+IJrNF0ZQbMDY2NWuRlp4RHPVFYf6k5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619001; c=relaxed/simple;
	bh=vKtRwQF+7hIK/l0uYSsexdjIflByjXJfN0T01BVqn3I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GHUCjAPWeH1ySi7bn5XAQs4dFqmU8guvT636vcEYO/uZV6fUKHDA+Mttdl8IcdxXfqLYLGPx/nnmCKm4O7rPitELlFsQiVku8mxuH96hTjiKOH8ELx6PwGQm/Ckcc71ceikPWYiz0FO1k+xNl9Tc/54J/Q7WSnBybJdHYja238A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S9;
	Sun, 28 Jun 2026 11:56:25 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/nouveau: nvkm_chan_new_: multiple error paths
 return without   releasing acquired references
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626143953.48952-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:56:14 +0800
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>,
 nouveau@lists.freedesktop.org,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <93B2CF9E-410D-4F0A-B95F-9DCD67402A25@iscas.ac.cn>
References: <20260626143953.48952-1-vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGry5ur17XF17Jw45KFy8Xwb_yoW5Zr4xpF
	45WFyY9rWftrs3K3WIqr48Ka4Yy3yDKw4jk34UCw1SvrnxJry8CrWrCa1IvayrGrs7Gr45
	ZFsIvFZa9F15tr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07bnUDAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAMMA2pAioobPgAAsP



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:39=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> After allocating chan and acquiring references on cgrp, vmm, memory, =
and
>  chid, numerous subsequent error paths return ret directly without =
calling
>  kfree, nvkm_cgrp_unref, nvkm_vmm_unref, nvkm_memory_unref, or
>  nvkm_chid_put. Every error return after the initial allocations leaks =
one
>  or more acquired resources.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 06db7fded6de ("drm/nouveau/fifo: add new channel classes")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> .../gpu/drm/nouveau/nvkm/engine/fifo/chan.c   | 25 +++++++++++++------
> 1 file changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c =
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> index 418a8918bcb8..1bf595bafa9a 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/chan.c
> @@ -410,18 +410,18 @@ nvkm_chan_new_(const struct nvkm_chan_func =
*func, struct nvkm_runl *runl, int ru
> 			      &chan->inst);
> 	if (ret) {
> 		RUNL_DEBUG(runl, "inst %d", ret);
> -		return ret;
> +		goto done;
> 	}
>=20
> 	/* Initialise virtual address-space. */
> 	if (func->inst->vmm) {
> 		if (WARN_ON(vmm->mmu !=3D device->mmu))
> -			return -EINVAL;
> +			goto done;
>=20
> 		ret =3D nvkm_vmm_join(vmm, chan->inst->memory);
> 		if (ret) {
> 			RUNL_DEBUG(runl, "vmm %d", ret);
> -			return ret;
> +			goto done;
> 		}
>=20
> 		chan->vmm =3D nvkm_vmm_ref(vmm);
> @@ -432,7 +432,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, =
struct nvkm_runl *runl, int ru
> 		ret =3D nvkm_object_bind(&dmaobj->object, chan->inst, =
-16, &chan->push);
> 		if (ret) {
> 			RUNL_DEBUG(runl, "bind %d", ret);
> -			return ret;
> +			goto done;
> 		}
> 	}
>=20
> @@ -443,13 +443,13 @@ nvkm_chan_new_(const struct nvkm_chan_func =
*func, struct nvkm_runl *runl, int ru
> 			if (ouserd + chan->func->userd->size >=3D
> 				nvkm_memory_size(userd)) {
> 				RUNL_DEBUG(runl, "ouserd %llx", ouserd);
> -				return -EINVAL;
> +				goto done;
> 			}
>=20
> 			ret =3D nvkm_memory_kmap(userd, =
&chan->userd.mem);
> 			if (ret) {
> 				RUNL_DEBUG(runl, "userd %d", ret);
> -				return ret;
> +				goto done;
> 			}
>=20
> 			chan->userd.base =3D ouserd;
> @@ -461,7 +461,7 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, =
struct nvkm_runl *runl, int ru
>=20
> 	if (chan->id < 0) {
> 		RUNL_ERROR(runl, "!chids");
> -		return -ENOSPC;
> +		goto done;
> 	}
>=20
> 	if (cgrp->id < 0)
> @@ -475,8 +475,17 @@ nvkm_chan_new_(const struct nvkm_chan_func *func, =
struct nvkm_runl *runl, int ru
> 	ret =3D chan->func->ramfc->write(chan, offset, length, devm, =
priv);
> 	if (ret) {
> 		RUNL_DEBUG(runl, "ramfc %d", ret);
> -		return ret;
> +		goto done;
> 	}
>=20
> 	return 0;
> +
> +done:
> +	if (chan->id >=3D 0)
> +		nvkm_chid_put(runl->chid, chan->id, &chan->cgrp->lock);
> +	nvkm_memory_unref(&chan->userd.mem);
> +	nvkm_vmm_unref(&chan->vmm);
> +	nvkm_cgrp_unref(&chan->cgrp);
> +	*pchan =3D NULL;
> +	return ret;
> }
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

