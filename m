Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCDC3D566D;
	Fri,  9 Oct 2026 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534823; cv=none; b=DBxU6Dc/vMyj72GZhHPy9fVPegvwFapZLux6RM8+mH3SwgAe6pc/jpq8+1/iN23CsevCmsjTqyExmLWgiWZ9eVHlH4dVaj3J2awg8fH8YaY+NgnlFk5jx1QFZw+MICncc/efG/n+5VlCaLTNVScRjx6YS4OMDXSHRXoBC/HEZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534823; c=relaxed/simple;
	bh=iEgfPRR0mzp7ZxNXT7XTcFRbm4YcvtihiCygs6HGoWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ONT5ym5rSRCTunraY0Grv7dULNTvEAUd/t8/PySwO809w2Ln1q4Jjcfcgqx1FEgH5SJ20OFEcrLJQRmdk636MnBF9RLFidSy6Jv9o37vW7wwKRE4VtJL0JhuipaHML031w/ayDeuU4ILCSyplfxgAbHkmtR51dzDexWHJhfNsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.100.127])
	by APP-03 (Coremail) with SMTP id rQCowAD3AUDVpshqXmkgCg--.113S2;
	Fri, 09 Oct 2026 16:33:26 +0800 (CST)
Message-ID: <79d0e9e21b47551b73413b6938c403a5af5f6bb4.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>, kernel
 test robot <lkp@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Date: Fri, 09 Oct 2026 16:33:24 +0800
In-Reply-To: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:rQCowAD3AUDVpshqXmkgCg--.113S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw15Aw4kKw1xGry7tF48Xrb_yoW5GF18pF
	Z8t340kr4kJw4vvwsrCF1fXFWfuan3WFyxKFyDGw1jgr1Yyr1xZr4xCw4UWr47ZrZ7W342
	vFsIkFn8KF4vyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	c7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxU2wIDUUUUU
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

(Cc'ing drm-misc maintainers)

=E5=9C=A8 2026-10-03=E5=85=AD=E7=9A=84 09:00 +0000=EF=BC=8CEvanshenf=E5=86=
=99=E9=81=93=EF=BC=9A
> An asynchronous cursor update swaps the new framebuffer into the live
> plane state. However, the driver reads both old_fb and new_fb from
> the
> live state before this swap. When an enabled cursor changes buffers,
> the
> address-update condition is therefore false and the hardware
> continues
> scanning the previous buffer.
>=20
> Read new_fb from the new plane state before swapping the framebuffer
> references. This updates the hardware address when the framebuffer
> changes while retaining the existing behavior for cursor movement.
>=20
> Verified on a Loongson 3A5000 with LS7A2000 using 32x32 and 64x64
> legacy
> cursor updates. Callback counters and read-only register observations
> confirmed the asynchronous path, the stale address before the change,
> and the new address afterward. Same-framebuffer movement and cursor
> disable/re-enable also passed, with the primary framebuffer and mode
> unchanged.
>=20
> AI assistance was used to investigate the existing report, prepare
> the
> fix and test tools, run the build and hardware comparison, and draft
> this message.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/r/202311152357.4KFS0M8f-lkp@intel.com/
> Fixes: f39db26c5428 ("drm: Add kms driver for loongson display
> controller")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Evanshenf <archwse@gmail.com>
> ---
> =C2=A0drivers/gpu/drm/loongson/lsdc_plane.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c
> b/drivers/gpu/drm/loongson/lsdc_plane.c
> index bcc0ffa..7b9c65c 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -230,7 +230,7 @@ static void
> lsdc_cursor_plane_atomic_async_update(struct drm_plane *plane,
> =C2=A0
> =C2=A0	new_state =3D drm_atomic_get_new_plane_state(state, plane);
> =C2=A0
> -	new_fb =3D plane->state->fb;
> +	new_fb =3D new_state->fb;

This change looks okay, although I don't know whether the
atomic_async_update() hook should be implemented at all now.

```
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
```

However, please wait for further clarification of the function itself
from drm-misc maintainers.

Thanks,
Icenowy

> =C2=A0
> =C2=A0	plane->state->crtc_x =3D new_state->crtc_x;
> =C2=A0	plane->state->crtc_y =3D new_state->crtc_y;
>=20
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

