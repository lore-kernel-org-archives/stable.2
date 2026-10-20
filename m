Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792480510;
	b=eXV4BYAMLzCFxwG5LGCmP12rIN0ithCpIVs3jwF899OwVzL09WOOl5x3jsl1WTFlOP31
	 cDkUwRQ1qZOLZ+k3ZAFyN3p7IATZGmRAxD3lfDJmS8bgVbJ56BjtC6ihrhlrowN3Gj1rb
	 jRIJOor2bbkUIOsjav7wsvsidhuf712py9NdsUvSZC73N49MQdLF7UO0AgNhySu/HC+Ip
	 0+sO6qady5watugtkL+AFlNR4FQ2UywiVU6+hrw5qpgCKSa38auoJ2eKzTyQVVi6C7L7k
	 ACi9m6iH8GuJqy0y0HCZJDWJYw3G7KGH1+UPt1kbQtjIB+kZfTlvno9fA9pPuUuOL+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792480510;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=8qJ+236X35WWHedIHQYsh13JEKsfxvWm1C4JdQxQx1U=;
	b=LnV/vyWVOFPRB8uEHoMxBwBqQau0sCLLR4kSR4QORxs0yHel1z8E5DJbBFCty9e3ow63
	 KzIkw8BaX3nySJeAc36x1XJ6aIQ8f5Vk+dj+C5ANFre1LgwIpg0bx0D7ob+h+fR2LiZs5
	 KZ4ELtlNHgDmaXQ2SC73JumuRnK4/njykgvfb9/VCar109a+jUP6cJCX+jw6RpNeQ8KcW
	 T/IBX8+M+tE9kCW5VAZKqjmI2m9l9bHVgT9OUDL3HpUAk+ujlu2/aHVHwuEUMEnVJHtgT
	 3jCb26rYZMmTVpLtRf6HnaTE443nc6/kdNMvGRp0tVdHIqEdKgLVuCsEycx/Di+HO9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Z1CUrt7q;
	arc=none smtp.remote-ip=80.241.56.171
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875D0606A320;
	Tue, 20 Oct 2026 07:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 875D0606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Z1CUrt7q
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4j83Zq1xB7zMlTn;
	Tue, 20 Oct 2026 09:14:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1792480499; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8qJ+236X35WWHedIHQYsh13JEKsfxvWm1C4JdQxQx1U=;
	b=Z1CUrt7q7MwvZ8dUbjjJzSwLqgG0+MMdavDVSHGKCKLvOh5GUmMfZlyDzmSqV0wOoagcoG
	PZ7dNAeE4UyjEWI5TeT8dNAJ8vac4qiHjmFqyHPQ6+B7U3ixLrqSfB7lgolXGBuBHdH5in
	8cxsxKpi04ouY1bGxNt/BMKIH8EMtGSyhPg+9qlPPFGlV/at7u0IdGU4labAE2CynqjFZb
	zqAD+Ez7JQFT0u8RRGgpTDNqB/5HRVX0BBynqO9Eiiu04EifRF56PTzzdXGJkgQyt8jMgG
	kyseEMOvFLEYgMmSm/Vf8mfV4p2sWl3i1OuG6wWLudj71D/mM73EEt6BVfCfQQ==
Message-ID: <d54ba24b0a4748b5c00052d4542460ea014aa50d.camel@mailbox.org>
Subject: Re: [PATCH v3 1/2] drm/drm_crtc: ensure dma_fence_ops remain valid
 during device unbind
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann	 <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter	 <simona@ffwll.ch>, Sumit Semwal
 <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=	
 <christian.koenig@amd.com>, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Philipp Stanner
 <phasta@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>, Sean Paul
 <seanpaul@chromium.org>, Gustavo Padovan	 <gustavo.padovan@collabora.co.uk>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, Peter Griffin	
 <peter.griffin@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>, Juan
 Yescas <jyescas@google.com>, kernel-team@android.com, Simona Vetter
 <simona.vetter@ffwll.ch>, 	stable@vger.kernel.org
Date: Tue, 20 Oct 2026 09:14:52 +0200
In-Reply-To: <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
References: <20260721-linux-drm_crtc_fix2-v3-0-afa8c71506e6@linaro.org>
	 <20260721-linux-drm_crtc_fix2-v3-1-afa8c71506e6@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: 4b68047e6459096626d
X-MBO-RS-META: naagxkni7kndisi999ybz1cz134p1967

On Tue, 2026-07-21 at 09:21 +0100, Andr=C3=A9 Draszik wrote:
>=20

[=E2=80=A6]

>=20
>=20
> ---
> v3:
> - Philipp: update kerneldoc, add Fixes:
>=20
> v2: new patch
> ---
> =C2=A0drivers/gpu/drm/drm_crtc.c | 15 ++++++++++++---
> =C2=A01 file changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
> index 63ead8ba6756..e8e80c936852 100644
> --- a/drivers/gpu/drm/drm_crtc.c
> +++ b/drivers/gpu/drm/drm_crtc.c
> @@ -493,14 +493,23 @@ EXPORT_SYMBOL(__drmm_crtc_alloc_with_planes);
> =C2=A0 * drm_crtc_cleanup - Clean up the core crtc usage
> =C2=A0 * @crtc: CRTC to cleanup
> =C2=A0 *
> - * This function cleans up @crtc and removes it from the DRM mode settin=
g
> - * core. Note that the function does *not* free the crtc structure itsel=
f,
> - * this is the responsibility of the caller.
> + * This function cleans up @crtc and removes it from the DRM mode settin=
g core,
> + * after first waiting an RCU grace period to ensure @crtc->dev can safe=
ly be
> + * dereferenced by our dma_fence_ops.
> + *
> + * Note that the function does *not* free the crtc structure itself, thi=
s is the
> + * responsibility of the caller.
> =C2=A0 */
> =C2=A0void drm_crtc_cleanup(struct drm_crtc *crtc)
> =C2=A0{
> =C2=A0	struct drm_device *dev =3D crtc->dev;
> =C2=A0
> +	/* Ensure our dma_fence_ops remain valid for an RCU grace period after
> +	 * the fence is signaled. This is necessary because our dma_fence_ops
> +	 * dereference crtc->dev.
> +	 */
> +	synchronize_rcu();
> +
> =C2=A0	/* Note that the crtc_list is considered to be static; should we
> =C2=A0	 * remove the drm_crtc at runtime we would have to decrement all
> =C2=A0	 * the indices on the drm_crtc after us in the crtc_list.


Seems we forgot [1] this patch. Sorry about that.

This fix also looks fine to me (for now) since it's what the dma_fence
contract currently demands.

I'm a bit nervous about a synchronize_rcu() being in every cleanup
path, but I suspect it's the most reasonable thing to do now.

Let's wait a day or two to see if anyone has fundamental objections.
Could someone with some CRTC knowledge give it an R-b? Otherwise I'd
push it this week.


Regards,
Philipp


[1]=C2=A0https://lore.kernel.org/dri-devel/73fc12734386c9bebc9cf6d3cea4c5f8=
e125255e.camel@mailbox.org/T/#thttps://lore.kernel.org/dri-devel/73fc127343=
86c9bebc9cf6d3cea4c5f8e125255e.camel@mailbox.org/T/#t
