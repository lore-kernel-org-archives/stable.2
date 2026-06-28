Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996982C15BB;
	Sun, 28 Jun 2026 03:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782618985; cv=none; b=DqNewBU+15+Bv9kEV+X7wvOaPRdK8bAJg7o3gNFxMAyZYC1Puda9JJPSgEzPfK5LdOJRFUiIiIzcVnkK8uo53JoZqSo0pSGmi6RoVSYyPOSEzA4p+4Cun3qA0vRx3GDtYlXHlHJRvjnrfE/AwI3gmenVGeThtLB2rK/C4xaos6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782618985; c=relaxed/simple;
	bh=raZmtM0TIxFLHq71q24EKQcptdNMiIodaVJVqcXAnZ8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lh1KHNeqod0/MjFn1W6NxLcvfA6Kg/G+pcm7/blLWWwer7rs6/uMHekH7Arn3PImlTg/polq9RP/EvZisyuPM1Puy0E9n6YTmfxvB4oddYJdLeW1XIFPANOeFsWIuqsw+3SCAS4/iF780y1TPiI//HTMYAAoWZ1i7Pv0kbKkA14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [117.182.74.7])
	by APP-01 (Coremail) with SMTP id qwCowADXfdYKm0BqqCuqAw--.7249S8;
	Sun, 28 Jun 2026 11:56:10 +0800 (CST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.8\))
Subject: Re: [PATCH] fix: drm/nouveau: validate_init: break paths after
 drm_gem_object_lookup   leak GEM reference
From: WenTao Liang <vulab@iscas.ac.cn>
In-Reply-To: <20260626142631.48578-1-vulab@iscas.ac.cn>
Date: Sun, 28 Jun 2026 11:55:59 +0800
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
Message-Id: <5B889F03-AAEF-4576-AD51-8B75FBE2E985@iscas.ac.cn>
References: <20260626142631.48578-1-vulab@iscas.ac.cn>
To: Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org
X-Mailer: Apple Mail (2.3826.700.81.1.8)
X-CM-TRANSID:qwCowADXfdYKm0BqqCuqAw--.7249S8
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47tFW8XF45CF1UtFy3CFg_yoW8WFyxpr
	ZxKF1jvrZ8tw47Kr4IyF1UA3WS9a9YgrW8GF9ay34F9r1fAFyxXry5GwnxXryftr43G3yY
	qw1DtasaqFWYyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQMA2pAiNkecgAAsF



> 2026=E5=B9=B46=E6=9C=8826=E6=97=A5 22:26=EF=BC=8CWenTao Liang =
<vulab@iscas.ac.cn> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> drm_gem_object_lookup acquires a GEM object reference at the start of
>  each loop iteration. Two break paths (ttm_bo_reserve failure =
non-EDEADLK
>  and "vma not found") exit the loop without adding the gem to any =
cleanup
>  list and without calling drm_gem_object_put, causing a GEM object
>  reference leak.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9242829a87e9 ("drm/nouveau: Keep only a single list for =
validation.")
> Fixes: 19ca10d82e33 ("drm/nouveau/gem: lookup VMAs for buffers =
referenced by pushbuf ioctl")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
> ---
> drivers/gpu/drm/nouveau/nouveau_gem.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c =
b/drivers/gpu/drm/nouveau/nouveau_gem.c
> index 20dba02d6175..c654256f4081 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_gem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
> @@ -513,6 +513,7 @@ validate_init(struct nouveau_channel *chan, struct =
drm_file *file_priv,
> 			if (unlikely(ret)) {
> 				if (ret !=3D -ERESTARTSYS)
> 					NV_PRINTK(err, cli, "fail =
reserve\n");
> +				drm_gem_object_put(gem);
> 				break;
> 			}
> 		}
> @@ -523,6 +524,7 @@ validate_init(struct nouveau_channel *chan, struct =
drm_file *file_priv,
> 			if (!vma) {
> 				NV_PRINTK(err, cli, "vma not found!\n");
> 				ret =3D -EINVAL;
> +				drm_gem_object_put(gem);
> 				break;
> 			}
>=20
> --=20
> 2.39.5 (Apple Git-154)

Please ignore this patch. I will resend a proper version after
learning the kernel submission process.

Apologies for the noise.

Best regards,
WenTao Liang

