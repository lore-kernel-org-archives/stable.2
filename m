Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793420801;
	b=INbYL0RC+EAWE6ojMuZunEX5V4Yl1k6iNTpzKcWwngUl1D9iemrOZ8GcEH38AFCaDVRU
	 FuZbSyjoHy2kb97DxPDabKg1JEB58LvoqVxWA3J5G+kEmMWsDpOBWT5H2NdXtikiRaMOP
	 IIACzENmMd9gNGj8IV8kwTB8DnUS50oeAj9DnPEoe/oo/Vukt+zqZRJuWvO5tu4eP/LTk
	 vbn7T3UZbaFr5qOO0Vjkq6a67Cli+FUMG6mRBzPM1VFLXZgzT5iVZ5MjcLguCRe43m24h
	 UTrqBZFVi0H/9tq4oxBBqjbVt2bPyiGLhn73hL/CUXQq8jPMba4nZ6TPR6SE3t8Z5nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793420801;
	h=DMARC-Filter:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:
	 X-CM-SenderInfo;
	bh=V21TV/zhZYZBx4vw4bMRfE5IzXMZMg0TRnefxN4ViKk=;
	b=bU3RUFeIg23/mmKCHjXS3zKRMOnv52UoLVfio43YUaeOf4CbNt2O0nAs9FH8rRnEn0oG
	 ebtO0UV73qWluLtLYO2ACbgHshXoIyYjEDFmDfjXxyIew2w0xZ6Lg1WgXg0v4D8Sf/Vry
	 TesJWV4f6AKNH7j0Os24tmg4O5Etj6ahg+jP1qoDpG2wr8NrmWmVZFUSmS5WgxRk5/7t8
	 ypuKstfzeNB8kVpi9NrbqVs3NrqbsUVRD3w6TfpMPBgh9qapfBSSLJa4q+MuyhbD1LUDU
	 m2XhR1WXCfEdRZVgKZAyPJ3imeQhHEgBltoY6SJnRnLanAdhpVEylOpmCeJR1NYa/IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B68F606A31C;
	Sat, 31 Oct 2026 04:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B68F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from edelgard.fodlan.icenowy.me (unknown [112.94.102.150])
	by APP-03 (Coremail) with SMTP id rQCowABHGpvybeVqSLsJAA--.7893S2;
	Sat, 31 Oct 2026 12:26:27 +0800 (CST)
Message-ID: <20933d0650fcead77cb14dc1d07e0b05f0ce2448.camel@iscas.ac.cn>
Subject: Re: [PATCH] drm/loongson: Fix framebuffer selection in async cursor
 updates
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
To: Evanshenf <archwse@gmail.com>, dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>, Qianhai Wu <wuqianhai@loongson.cn>, 
 Huacai Chen <chenhuacai@kernel.org>, Mingcong Bai <jeffbai@aosc.io>, Xi
 Ruoyao <xry111@xry111.site>, Sui Jingfeng <suijingfeng@loongson.cn>, kernel
 test robot <lkp@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sat, 31 Oct 2026 12:26:25 +0800
In-Reply-To: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
References: <20261003090006.4e29fdce9913-1-archwse@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:rQCowABHGpvybeVqSLsJAA--.7893S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4fCFy3urWUCrykGw1UGFg_yoW8Kr4DpF
	Z8t340krWkJw4vywsruF1fGFyfua1fWFyxKFyDGw1Fg34Yyr1Svry8u3yUWr47XrZrW34a
	vrsIkFn8KF4qv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU84v3UUUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/

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
>=20

Applied to drm-misc-fixes, Thanks for your contribution!

Icenowy

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
> =C2=A0
> =C2=A0	plane->state->crtc_x =3D new_state->crtc_x;
> =C2=A0	plane->state->crtc_y =3D new_state->crtc_y;
>=20
> base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643

