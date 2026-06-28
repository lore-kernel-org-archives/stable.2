Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3D235C183;
	Sun, 28 Jun 2026 04:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619456; cv=none; b=hkTvtI++qjeO3QotUYPYBtdjEkQ1W7p978aS/bCuKn+qI011OSzEDtEx7MF6+pD86UDmb88mH4ldqStCLPRCxrnibAsgoJ2dkO2s+HoMDCtWo+Sz8nmTk/D2JeflssXOiR4IcmQojMsa+iRTw2oZ8w/ADG3g1DyY2FG3AWCcYLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619456; c=relaxed/simple;
	bh=xdtIl5SI2DJxSIzQjG9MD27yWJeAViVMkGJTZmbPxI0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RD/PzSwQhS3Ml/4EJSneDvVja9CBDwnYwyLey2eIZJ/rYc2SbkN+pbdFI6hGs/wXwoGZF3QQcbfv1I/RqbatSEszO2uDIsUfoHlc9n+8gBYFLUmLEWAGiZbefIGQVH42362dGEiRG/vILikdliI+wDEilluvvAKBf9m3xVfuEkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S16;
	Sun, 28 Jun 2026 12:04:03 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/nouveau: nvkm_ucgrp_new: nvkm_cgrp_new failure
 leaks ucgrp   object and engine reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626144717.49109-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:52 +0800
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
Message-Id: <F9C8BF2D-C97E-49FE-B652-CDE97A93F615@iscas.ac.cn>
References: <20260626144717.49109-1-vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S16
X-Coremail-Antispam: 1UD129KBjvJXoW7trWUXFyrWr47ury5Xr4kCrg_yoW8Xw4Dpr
	4fJw1SyrZ8AF48Ka1xAa18uFySv3s0vFyFkas0y343Zrn8ZrWDArWFv3s0qFyrZrWfGw45
	tr4ktFZaqw1YvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
	jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
	8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2
	z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2
	IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07j0OJ5UUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAIMA2pAiooeMAAAsF



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:47=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> nvkm_object_ctor initializes ucgrp with an embedded kref and =
increments
>  the engine's reference count. When nvkm_cgrp_new subsequently fails, =
the
>  function jumps to done without calling nvkm_object_del to release =
ucgrp.
>  The caller ignores *pobject on error, so the ucgrp object and its =
engine
>  reference are permanently leaked.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 06db7fded6de ("drm/nouveau/fifo: add new channel classes")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c =
b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> index dfa3c7dbdf34..7d11b92f946b 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/fifo/ucgrp.c
> @@ -113,8 +113,10 @@ nvkm_ucgrp_new(struct nvkm_fifo *fifo, const =
struct nvkm_oclass *oclass, void *a
> 	*pobject =3D &ucgrp->object;
>=20
> 	ret =3D nvkm_cgrp_new(runl, args->v0.name, vmm, true, =
&ucgrp->cgrp);
> -	if (ret)
> +	if (ret) {
> +		nvkm_object_del(pobject);
> 		goto done;
> +	}
>=20
> 	/* Return channel group info to caller. */
> 	args->v0.cgid =3D ucgrp->cgrp->id;
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang=

