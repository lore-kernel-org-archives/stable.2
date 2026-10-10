Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB5F3DC4CE;
	Sat, 10 Oct 2026 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791614342; cv=none; b=lZeEIvoNwjGRcYocxd/4gutM4qFbopjqcEpWyVQB2NrYSwOWotIbc0IaKc7LNNaIceAhN9fg/+uD9Waf9Cp9MzumA6PkFxc/Sv4QGXhIVxEoCUkEYxK+kwhpQ/7Dc2BA+JXVcd1G0546I8ilkPN7yuRTWmRkXbMwhtOv6CyRbnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791614342; c=relaxed/simple;
	bh=sbfm5i/deI8940dzfdbWaeuO9SzmcWaMp8G1ZCg3Bfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YUN03xDuvX3JrykwbJDeATEtHYI+I2fyzH2ldtZsGtpwU/0/RsVZYFYwfLJWgg60ZGrF4VBUkW7c2N7dmoDs4J1uczHv87iZJiAUnBs4J6L9slYBNoTDMoj3472Ad/6M+gc7sodfPRY2c9alwtQ1p0chWKj+da+r49kQEPTY654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.127])
	by APP-01 (Coremail) with SMTP id qwCowAD3ye1q3clq+e5uCg--.39007S2;
	Sat, 10 Oct 2026 14:38:35 +0800 (CST)
Message-ID: <58550960f484cc419d19e693b9efa5b03982cc22.camel@iscas.ac.cn>
Subject: Re: [PATCH 2/2] drm/loongson: Handle buffer mapping failures when
 clearing a BO
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Evanshenf
	 <archwse@gmail.com>, dri-devel@lists.freedesktop.org, Natalie Vock
	 <natalie.vock@gmx.de>, "Paneer Selvam, Arunpravin"
	 <Arunpravin.PaneerSelvam@amd.com>
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org, Huang Rui	
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, Matthew Brost	
 <matthew.brost@intel.com>
Date: Sat, 10 Oct 2026 14:38:34 +0800
In-Reply-To: <2b0d0a02-99a5-447a-8e3f-6154b2660425@amd.com>
References: <20261003093415.e64386de1e64-1-archwse@gmail.com>
	 <20261003093415.902f89244043-2-archwse@gmail.com>
	 <f25629d4aa3c0132275b0a798e1491119fa8d502.camel@iscas.ac.cn>
	 <2b0d0a02-99a5-447a-8e3f-6154b2660425@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:qwCowAD3ye1q3clq+e5uCg--.39007S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF45uw1fZrykXrW3ur4DJwb_yoW7Xr4rpr
	ZxAa4jkrWDXrnFkrnFqa4kC3WSka4Sgr17WFW5Ja4rW39Fyr1UWF15WFWDuF9rZF17Ar42
	vrn3Ganxu3Z0v37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUqiFxDUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

=E5=9C=A8 2026-10-09=E4=BA=94=E7=9A=84 16:14 +0200=EF=BC=8CChristian K=C3=
=B6nig=E5=86=99=E9=81=93=EF=BC=9A
> On 10/9/26 15:50, Icenowy Zheng wrote:
> > =E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:34 +0000=EF=BC=8CEvanshenf=E5=
=86=99=E9=81=93=EF=BC=9A
> > > lsdc_bo_clear() ignores the return value from lsdc_bo_kmap() and
> > > writes
> > > to lbo->kptr unconditionally. When the first mapping of a newly
> > > allocated
> > > buffer fails, kptr is still NULL and the subsequent memset
> > > accesses
> > > it.
> > >=20
> > > Return the mapping error without touching the buffer and
> > > propagate it
> > > from lsdc_gem_object_create(). Install the GEM object functions
> > > before
> > > clearing so that drm_gem_object_put() can release the buffer
> > > correctly
> > > on failure. Do not add the failed object to the tracking list or
> > > return
> > > an uncleared buffer to the caller.
> > >=20
> > > Imported buffers still skip clearing, and successfully mapped
> > > buffers
> > > are cleared and unmapped as before.
> > >=20
> > > Tested on LS7A2000 with a one-shot range error in ttm_bo_kmap().
> > > Its
> > > -EINVAL return reached userspace, the object was destroyed once,
> > > and
> > > no GEM handle was published. Normal
> > > create/map/zero/write/read/close
> > > cycles passed, with the tracked BO count and VRAM usage
> > > unchanged.
> > >=20
> > > AI assistance was used for the lifetime analysis, fix, fault-
> > > injection
> > > tools, build and test execution.
> > >=20
> > > Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> > > controller")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Evanshenf <archwse@gmail.com>

I'm going to accept this patch now.

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

Although I may prefer to remove the clearing routine in the future.

Thanks,
Icenowy

> > > ---
> > > =C2=A0drivers/gpu/drm/loongson/lsdc_gem.c | 12 ++++++++----
> > > =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.c | 10 ++++++++--
> > > =C2=A0drivers/gpu/drm/loongson/lsdc_ttm.h |=C2=A0 2 +-
> > > =C2=A03 files changed, 17 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/loongson/lsdc_gem.c
> > > b/drivers/gpu/drm/loongson/lsdc_gem.c
> > > index 2fb0348..9eba4e1 100644
> > > --- a/drivers/gpu/drm/loongson/lsdc_gem.c
> > > +++ b/drivers/gpu/drm/loongson/lsdc_gem.c
> > > @@ -157,14 +157,18 @@ struct drm_gem_object
> > > *lsdc_gem_object_create(struct drm_device *ddev,
> > > =C2=A0		return ERR_PTR(ret);
> > > =C2=A0	}
> > > =C2=A0
> > > +	gobj =3D &lbo->tbo.base;
> > > +	gobj->funcs =3D &lsdc_gem_object_funcs;
> > > +
> > > =C2=A0	if (!sg) {
> > > =C2=A0		/* VRAM is filled with random data */
> > > -		lsdc_bo_clear(lbo);
> > > +		ret =3D lsdc_bo_clear(lbo);
> > > +		if (ret) {
> > > +			drm_gem_object_put(gobj);
> > > +			return ERR_PTR(ret);
> > > +		}
> > > =C2=A0	}
> > > =C2=A0
> > > -	gobj =3D &lbo->tbo.base;
> > > -	gobj->funcs =3D &lsdc_gem_object_funcs;
> > > -
> > > =C2=A0	/* tracking the BOs we created */
> > > =C2=A0	mutex_lock(&ldev->gem.mutex);
> > > =C2=A0	list_add_tail(&lbo->list, &ldev->gem.objects);
> > > diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c
> > > b/drivers/gpu/drm/loongson/lsdc_ttm.c
> > > index 88536e2..7b30dea 100644
> > > --- a/drivers/gpu/drm/loongson/lsdc_ttm.c
> > > +++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
> > > @@ -388,9 +388,13 @@ void lsdc_bo_kunmap(struct lsdc_bo *lbo)
> > > =C2=A0	ttm_bo_kunmap(&lbo->kmap);
> > > =C2=A0}
> > > =C2=A0
> > > -void lsdc_bo_clear(struct lsdc_bo *lbo)
> > > +int lsdc_bo_clear(struct lsdc_bo *lbo)
> > > =C2=A0{
> > > -	lsdc_bo_kmap(lbo);
> > > +	int ret;
> > > +
> > > +	ret =3D lsdc_bo_kmap(lbo);
> > > +	if (ret)
> > > +		return ret;
> > > =C2=A0
> > > =C2=A0	if (lbo->is_iomem)
> > > =C2=A0		memset_io((void __iomem *)lbo->kptr, 0, lbo-
> > > >size);
> > > @@ -398,6 +402,8 @@ void lsdc_bo_clear(struct lsdc_bo *lbo)
> > > =C2=A0		memset(lbo->kptr, 0, lbo->size);
> > > =C2=A0
> > > =C2=A0	lsdc_bo_kunmap(lbo);
> > > +
> > > +	return 0;
> > > =C2=A0}
> > > =C2=A0
> > > =C2=A0int lsdc_bo_evict_vram(struct drm_device *ddev)
> >=20
> > Well I currently don't know whether the clearing is meaningful...
> >=20
> > It seems that drm_gem_vram_helper doesn't do this.
> >=20
> > Cc'ing TTM maintainers for an answer.
>=20
> Natalie and Arun are TTM maintainers now, but I will try to answer
> here as well.
>=20
> OpenGL doesn't necessarily require clearing of VRAM nor isolation of
> VRAM data between processes.
>=20
> So it is up to the driver if they want this or not. Classically a lot
> of drivers didn't clear VRAM allocations until explicitely asked.
>=20
> But if you clear the memory you should have proper error handling and
> a kmap/vmap can fail at any time for multiple reasons.
>=20
> Regards,
> Christian.
>=20
> >=20
> > Thanks,
> > Icenowy
> >=20
> > > diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.h
> > > b/drivers/gpu/drm/loongson/lsdc_ttm.h
> > > index 843e147..df47d9b 100644
> > > --- a/drivers/gpu/drm/loongson/lsdc_ttm.h
> > > +++ b/drivers/gpu/drm/loongson/lsdc_ttm.h
> > > @@ -89,7 +89,7 @@ size_t lsdc_bo_size(struct lsdc_bo *lbo);
> > > =C2=A0
> > > =C2=A0int lsdc_bo_kmap(struct lsdc_bo *lbo);
> > > =C2=A0void lsdc_bo_kunmap(struct lsdc_bo *lbo);
> > > -void lsdc_bo_clear(struct lsdc_bo *lbo);
> > > +int lsdc_bo_clear(struct lsdc_bo *lbo);
> > > =C2=A0
> > > =C2=A0int lsdc_bo_evict_vram(struct drm_device *ddev);
> > > =C2=A0
> >=20

