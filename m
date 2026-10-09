Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E5644F571;
	Fri,  9 Oct 2026 13:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553844; cv=none; b=WOiUINarfhGgG0vvDcSJMWIKVKj6ZuhxCNfKyOyqRtfX09EZ/KmNYN++TCfUvvX3UU0fpitgYEymfZE2qOlGnEtW11afzMkXr/u9wKwl8z9WGG/eT4739/MQy6vl3IoN010s9ce7cpHFch3q0dH59MKEEo9ueoAWNxwQXCET4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553844; c=relaxed/simple;
	bh=tdtww6O9RZvlk4Cb2qEeoL9t2+8iuYI08TrMttY4X/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=as1GGyjfEpii7qU/sOqosyZqixgeJMByWNoaEsSiP7t6xAH0M1UMJoj4KbagnHX2OfKWpRLVo5ZN2T15TaulqgoTNaCrwC+sYc3nS8qo7ylozfp/eoFfk7dDMTo+pqRxlLM/2VJwdb3BcOYb6JuUg1ooE6KzHiO1LhZ1QO8MCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.127])
	by APP-03 (Coremail) with SMTP id rQCowAC3wkAj8chqKp0nCg--.4618S2;
	Fri, 09 Oct 2026 21:50:28 +0800 (CST)
Message-ID: <f25629d4aa3c0132275b0a798e1491119fa8d502.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] drm/loongson: Handle buffer mapping failures when
 clearing a BO
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,  Christian Koenig
 <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, Matthew Auld
 <matthew.auld@intel.com>,  Matthew Brost <matthew.brost@intel.com>
Date: Fri, 09 Oct 2026 21:50:27 +0800
In-Reply-To: <20261003093415.902f89244043-2-archwse@gmail.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
	 <20261003093415.902f89244043-2-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAC3wkAj8chqKp0nCg--.4618S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw4xWF43Ww4kuFy8XF18Zrb_yoWrWr18pr
	ZxC3WjkrWDXrnrKrnrGFWkCa4Sk3WSgrWagFWUtas0gw1jyr1UXF15XFWDJrW7ZasrCr12
	9Fn3KanxW3WqvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j0fOwUUUUU=
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

=E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:34 +0000=EF=BC=8CEvanshenf=E5=86=
=99=E9=81=93=EF=BC=9A
> lsdc_bo_clear() ignores the return value from lsdc_bo_kmap() and
> writes
> to lbo->kptr unconditionally. When the first mapping of a newly
> allocated
> buffer fails, kptr is still NULL and the subsequent memset accesses
> it.
>=20
> Return the mapping error without touching the buffer and propagate it
> from lsdc_gem_object_create(). Install the GEM object functions
> before
> clearing so that drm_gem_object_put() can release the buffer
> correctly
> on failure. Do not add the failed object to the tracking list or
> return
> an uncleared buffer to the caller.
>=20
> Imported buffers still skip clearing, and successfully mapped buffers
> are cleared and unmapped as before.
>=20
> Tested on LS7A2000 with a one-shot range error in ttm_bo_kmap(). Its
> -EINVAL return reached userspace, the object was destroyed once, and
> no GEM handle was published. Normal create/map/zero/write/read/close
> cycles passed, with the tracked BO count and VRAM usage unchanged.
>=20
> AI assistance was used for the lifetime analysis, fix, fault-
> injection
> tools, build and test execution.
>=20
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_gem.c | 12 ++++++++----
> =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
> =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.h |=C2=A0 2 +-
> =C2=A03 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c
> b/drivers/gpu/drm/loongson/lsdc_gem.c
> index 2fb0348..9eba4e1 100644
> --- a/drivers/gpu/drm/loongson/lsdc_gem.c
> +++ b/drivers/gpu/drm/loongson/lsdc_gem.c
> @@ -157,14 +157,18 @@ struct drm_gem_object
> *lsdc_gem_object_create(struct drm_device *ddev,
> =C2=A0		return ERR_PTR(ret);
> =C2=A0	}
> =C2=A0
> +	gobj =3D &lbo->tbo.base;
> +	gobj->funcs =3D &lsdc_gem_object_funcs;
> +
> =C2=A0	if (!sg) {
> =C2=A0		/* VRAM is filled with random data */
> -		lsdc_bo_clear(lbo);
> +		ret =3D lsdc_bo_clear(lbo);
> +		if (ret) {
> +			drm_gem_object_put(gobj);
> +			return ERR_PTR(ret);
> +		}
> =C2=A0	}
> =C2=A0
> -	gobj =3D &lbo->tbo.base;
> -	gobj->funcs =3D &lsdc_gem_object_funcs;
> -
> =C2=A0	/* tracking the BOs we created */
> =C2=A0	mutex_lock(&ldev->gem.mutex);
> =C2=A0	list_add_tail(&lbo->list, &ldev->gem.objects);
> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
> b/drivers/gpu/drm/loongson/lsdc_ttm.c
> index 88536e2..7b30dea 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> @@ -388,9 +388,13 @@ void lsdc_bo_kunmap(struct lsdc_bo *lbo)
> =C2=A0	ttm_bo_kunmap(&lbo->kmap);
> =C2=A0}
> =C2=A0
> -void lsdc_bo_clear(struct lsdc_bo *lbo)
> +int lsdc_bo_clear(struct lsdc_bo *lbo)
> =C2=A0{
> -	lsdc_bo_kmap(lbo);
> +	int ret;
> +
> +	ret =3D lsdc_bo_kmap(lbo);
> +	if (ret)
> +		return ret;
> =C2=A0
> =C2=A0	if (lbo->is_iomem)
> =C2=A0		memset_io((void __iomem *)lbo->kptr, 0, lbo->size);
> @@ -398,6 +402,8 @@ void lsdc_bo_clear(struct lsdc_bo *lbo)
> =C2=A0		memset(lbo->kptr, 0, lbo->size);
> =C2=A0
> =C2=A0	lsdc_bo_kunmap(lbo);
> +
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0int lsdc_bo_evict_vram(struct drm_device *ddev)

Well I currently don't know whether the clearing is meaningful...

It seems that drm_gem_vram_helper doesn't do this.

Cc'ing TTM maintainers for an answer.

Thanks,
Icenowy

> diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.h
> b/drivers/gpu/drm/loongson/lsdc_ttm.h
> index 843e147..df47d9b 100644
> --- a/drivers/gpu/drm/loongson/lsdc_ttm.h
> +++ b/drivers/gpu/drm/loongson/lsdc_ttm.h
> @@ -89,7 +89,7 @@ size_t lsdc_bo_size(struct lsdc_bo *lbo);
> =C2=A0
> =C2=A0int lsdc_bo_kmap(struct lsdc_bo *lbo);
> =C2=A0void lsdc_bo_kunmap(struct lsdc_bo *lbo);
> -void lsdc_bo_clear(struct lsdc_bo *lbo);
> +int lsdc_bo_clear(struct lsdc_bo *lbo);
> =C2=A0
> =C2=A0int lsdc_bo_evict_vram(struct drm_device *ddev);
> =C2=A0

