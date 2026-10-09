Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207923164BA;
	Fri,  9 Oct 2026 08:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535343; cv=none; b=Q1uFqe3NPsKF7Nz5fEMmRi1Jh8hfyMJMlu7j6Wcr82z5eUkleflnVnpJpBON+nG1iIncnPYpHFXydEZBK/AL7wkHKYPiZJOJRbBM8CgFiZ2NQyC0D56L+aLZTDtLZl04z7N4cQ0wWYkjniKdoJtc4rzZB9dNPee8+DLxGEAUCvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535343; c=relaxed/simple;
	bh=s0wkazD8y1MriCKEPtZ8Ynq3jBxYHcj87UMhdmxtU80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=psNeRs0o45OaNGNVr5jdSAHYz3/gPgy+dynH8dk/b6UrKif6PTAGaJYyHJEBWpMZQ2tKUor2CxYAkCYPSe6EoQF2LwFFXwI3+vHEsnLVZvwBg4oGn1QaCOLhIKe6tR02pp08nYH5bURHF7N72rgKQI0y0Q45QsNAloE7+pjgkg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.127])
	by APP-03 (Coremail) with SMTP id rQCowABHTTvmqMhqCJAgCg--.257S2;
	Fri, 09 Oct 2026 16:42:14 +0800 (CST)
Message-ID: <dce8506787ff72b5a9fac15571d4c59624348430.camel@iscas.ac.cn>
Subject: Re: [PATCH 1/2] drm/loongson: Fix double free on BO initialization
 failure
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 09 Oct 2026 16:42:14 +0800
In-Reply-To: <20261003093415.e64386de1e64-1-archwse@gmail.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowABHTTvmqMhqCJAgCg--.257S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rurWrJF1UJF47Zr1kKrg_yoW8tr13pa
	nxGa47trykJws29rnrA3WrCa40kayfWrW8uF45GwnxWr1Ykw1kCF93ua4jgF17XFy7CF1a
	vanxGan3XF1qk3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU7YFADUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

=E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:34 +0000=EF=BC=8CEvanshenf=E5=86=
=99=E9=81=93=EF=BC=9A
> If ttm_bo_init_validate() fails, it drops the buffer object's
> reference
> and cleans it up through the supplied destroy callback.
> lsdc_bo_destroy()
> releases the GEM object and frees the enclosing lsdc_bo, so freeing
> it
> again in lsdc_bo_create() causes a double free on a synchronous
> failure
> path.
>=20
> Let TTM own the cleanup after initialization has started and return
> the
> error directly. Keep the explicit free on drm_gem_object_init()
> failure,
> which occurs before ownership is passed to TTM.
>=20
> Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for
> one
> selected dumb-buffer creation. The error reached userspace, the
> destroy
> callback ran once, and no handle was published or tracked BO
> retained.
> Normal buffer creation, zeroing, mapping, readback and release
> passed.
>=20
> AI assistance was used for the ownership analysis, fix, fault-
> injection
> tools, build and test execution.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
> =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
> b/drivers/gpu/drm/loongson/lsdc_ttm.c
> index d7441d9..88536e2 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device
> *ddev,
> =C2=A0
> =C2=A0	ret =3D ttm_bo_init_validate(bdev, tbo, bo_type, &lbo-
> >placement, 0,
> =C2=A0				=C2=A0=C2=A0 false, sg, resv,
> lsdc_bo_destroy);
> -	if (ret) {
> -		kfree(lbo);
> +	if (ret)
> =C2=A0		return ERR_PTR(ret);

It looks like this fix is valid, ttm_bo_init_reserved() (called by
ttm_bo_init_validate() ) will do a ttm_bo_put() operation when failure,
which leads to calling the destroy callback.

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Thanks,
Icenowy

> -	}
> =C2=A0
> =C2=A0	return lbo;
> =C2=A0}
>=20
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

