Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A535E1AE;
	Sun, 28 Jun 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782619440; cv=none; b=ZvCK4Wq3NSHOArGdKvytBNTPAN3y3j/ThKYFO8xFOfYMBWbyEiO6goTJECovtEP/Wwg/uGeJiNYJ72RH9MoeyRvo4akaauifFqtH443O13yfZYc47KjHp4/HzAlDAKel8yKo32EAlQqeqkHZEv3T9pKqRHhhWb7iq673+zjBOI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782619440; c=relaxed/simple;
	bh=pDMjo9YQoWcXz8SDenf9wYgyoJiRfJXxoxqfFtslASo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=uDz3tMgIecnc6+DZbmVYR1+OqSmrUmdFw8pkKLLU4fuk6fGbBiQw9k13BJboS/2M9WEZu/ka5UTJwkCmBaznXZo1cx2cVHhhIXUCklkMQGHy+quslTACGGdRE3afefTapj9WVTuiHzaiOhk686HwUuciZ7iyHToD3oqfbO3eObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowAD3j8h4nEBq+V6qAw--.55335S14;
	Sun, 28 Jun 2026 12:03:45 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/vc4: vc4_cl_lookup_bos: fix NULL pointer
 dereference on   drm_gem_objects_lookup failure
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626145655.49508-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 12:03:34 +0800
Cc: Maira Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Andre Almeida <andrealmeid@igalia.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3DCCCFB-ABE8-437A-B95F-3A8A26C99AE5@iscas.ac.cn>
References: <20260626145655.49508-1-vulab@iscas.ac.cn>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowAD3j8h4nEBq+V6qAw--.55335S14
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4rXw4kGr1rCFW8AFWrKrg_yoW8XFyDpr
	srtryIyFy8JF4xtanxXF4kWa4Yka15tFWkCFn093yfur4rta45Kr98ua45XFyUAFWxtF1I
	qr1DKa9a9F4jyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm2b7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
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
	xhVjvjDU0xZFpf9x07j0lksUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwAMA2pAixEdWgAAs-



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:56=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> When drm_gem_objects_lookup fails, it sets *objs_out to NULL, leaving
>  exec->bo as NULL. The fail_put_bo error handler unconditionally =
iterates
>  over exec->bo[i] without checking for NULL, causing a NULL pointer
>  dereference.
>=20
> Add a NULL check for exec->bo before accessing its entries in the
>  fail_put_bo error path.
>=20
> Cc: stable@vger.kernel.org
> Fixes: ba3f6db4afee ("drm/vc4: replace obj lookup steps with =
drm_gem_objects_lookup")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/vc4/vc4_gem.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c =
b/drivers/gpu/drm/vc4/vc4_gem.c
> index ab3c6d5d4eb4..f79c0171e43e 100644
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -724,10 +724,12 @@ vc4_cl_lookup_bos(struct drm_device *dev,
>=20
> fail_put_bo:
> 	/* Release any reference to acquired objects. */
> -	for (i =3D 0; i < exec->bo_count && exec->bo[i]; i++)
> -		drm_gem_object_put(exec->bo[i]);
> +	if (exec->bo) {
> +		for (i =3D 0; i < exec->bo_count && exec->bo[i]; i++)
> +			drm_gem_object_put(exec->bo[i]);
>=20
> -	kvfree(exec->bo);
> +		kvfree(exec->bo);
> +	}
> 	exec->bo =3D NULL;
> 	return ret;
> }
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

