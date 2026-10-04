Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9E352030
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791111936; cv=none; b=rv1/dnPnVKQkdWAE9SPs1dI47y6FLmujCIhtGsBjF1+MNbFMdQ8/68+7qhPr+b2NCQHGXT3jNccZ3oY2sN7dLzhRNbG1ltwkWToi0HX6FH4Gnei/JiPbxNGAKq105K0ChLY+Q8w4K7Y8kju1bDd17lNY1pKwoq8g57WjWXeIydg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791111936; c=relaxed/simple;
	bh=pqU0AmLH7J2NewvDYsALCFE8C0uhZNes4u+zqrHAxe0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ENUzfJXokltpt3jKfC40txWK1tb/DDf32yIFnYquNFRlg+dU0cO8K7D+6Odn4rAFO15Z/sYRp17aUU0gyMVS9BkOBffcRZ3steAAUkZRuU6u3DBFm0J/rrJ5A3/wYAACzCGNS8MDJql5MylDH+HqwdV+mVC9bAGaH38XAdyH5Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=yTdfayOW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="yTdfayOW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so3520915e9.0
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1791111933; x=1791716733; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1gMc178loumsMJ2fyhcP0L7Qn5VoTNXOEWwEnxYnAdM=;
        b=yTdfayOWQ3zBdIqo/GqJotRigsGDXtWYbKQb4UDmdEM1/8uHY3feaNyMPhDFsmxgsy
         E4OVEIRmq0N1dBro3FC0s2+PFe/hznxvsB12oM/S8c9mRdDtmrhLPspf/8GBPlAF7jC8
         SphKsprLg76y3kMKXrKZ6MoYURGM9dmESWdPigAqvq7Sl/FFvxe2AvPdmQ0A06XjpqxZ
         Mj5cmhGvSNe4L2HwnWT8e5Lkbycfh+O3EKvsE9sGGnM9fUVANFUFmZDYw6E65NSZrx13
         ixKY2uZIrAZy06N+46STisgkBuJSCUoIEOyN9+yj65atz37UUDeoDO9NtiwgwQ//gZXt
         vmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791111933; x=1791716733;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1gMc178loumsMJ2fyhcP0L7Qn5VoTNXOEWwEnxYnAdM=;
        b=oVHYpyeFhwFRKfCJe4K0u1jTl8J8VmmQ7lAlHQwuwvfMTzrIa+UpuQYibwnOvDaOIX
         Stzqmj778uDC1iDsyeNbLQydmiM30AW5CoEPw34G+P+U+q4RQ3gxruK1qzPT+5I0OPFP
         Qv9Qv/tf8WSGCBiGlsXqSyp6a2G5yRaebrzYFscgyIqA6PHTFmbqKVxHbjgMlJiaKoXF
         PkRfZw0Z60nac9QSVn0LK6esXILEzCGTJL8utw68Le4WE4EHTGSXH2uXf3BaMlRoD2JB
         JnRNeYEsUY2bfE/d2KvZ660wAGn6A0EAoWA85oeinrygVhc2XP5oWGqxhvuqod0xth3F
         PxvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZMrJ+kuA8wjVVBLx3P8QLqOR8XfLIRkkj4iZSoQZKLwCydGecvjlC6GvIDJJUgjekCkgQaiU=@vger.kernel.org
X-Gm-Message-State: AFuF++kqpb1wqA1NdjTxfwvS0pCAhSBX9240uqWRCaJq26PwSy5o0v3k
	D8igbpR2ItW6V/gy3gGnHhxRTDF53rMJLYsHMJcm7EixTv23oQ3E9p18N1252QGzK4A=
X-Gm-Gg: AYBFou04QpZi+rXgk6W2bCDsB001q/bKGMHx3foTzR081skNvA7JX/WS4K/Q0TQnQQK
	A1gNm2VkRzTzCH0e16+djBolJDpub/vxPxqpssHWQA9l6v4e46S5AFxNQ0XYZtRCH7KOcdsJz72
	skxeSsAy2FFidb8H0jWSPrQBJehRgNVZJuUSmNotiCYfzGZSQ78+IJPfuIV8mb5OMFMuh8YDk3v
	rdCPJ5iBWf9fzMZxUJofTt7xWu1wkWWOMgmh7XCzMa1b1vibxV8zNGurXsb8uDm6T53mVW4rOiA
	c/MOfJFmiFD9UlmIJ4Bm7oFL7lVGSDFEvx87ccAHS/jE7kp0BTgAijAX4yftfETEe9pbQ32AN9b
	GB52SYapjOSfe7rmT1iRYp9r7jOBA4SVfMaoyRkc21NEhIY+4JsSPuuHq5G7ZzqYcvRyURrg2tN
	JS66LY8ZG+jkg+4e8tRVI1ys3dbaNsoN+x8yLxlP81WpHihu9YNwowcxwKbhjIQ/8OuON7svCo4
	HYlQuTGsBf5uVFtQWn1Jrh8ITkLz5awl5W5ZWbgHuSQX/adcb5DNWUcRC203rNzIbKwCjPKVoak
	RUYoYnlhpCbzazgJicuLvIzWGaaU1KL2ZsbZtSfP
X-Received: by 2002:a05:600c:548c:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-4a027534bd7mr125807085e9.5.1791111932983;
        Sun, 04 Oct 2026 04:05:32 -0700 (PDT)
Received: from ?IPv6:2001:1aeb:400:6f00:73f4:bfe7:a3e6:c16f? (2001-1aeb-400-6f00-73f4-bfe7-a3e6-c16f.ip6.tmcz.cz. [2001:1aeb:400:6f00:73f4:bfe7:a3e6:c16f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a03048abc9sm100142955e9.0.2026.10.04.04.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 04:05:31 -0700 (PDT)
Message-ID: <d166bd7190c1a71921a1eaff3359ffcd8b825afb.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: jpeg: Avoid context access after job
 finish
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Kazuki Hanai <hnkz.64@gmail.com>, Bin Liu <bin.liu@mediatek.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno	
 <angelogioacchino.delregno@collabora.com>, Hans Verkuil
 <hverkuil@kernel.org>,  Tomasz Figa <tfiga@chromium.org>, Xia Jiang
 <xia.jiang@mediatek.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Date: Sun, 04 Oct 2026 07:05:30 -0400
In-Reply-To: <e7aef28efd9860e80b8be8865dd04268ee2fd786.camel@ndufresne.ca>
References: <20260902112230.452176-1-hnkz.64@gmail.com>
	 <e7aef28efd9860e80b8be8865dd04268ee2fd786.camel@ndufresne.ca>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0J05pY29sYXMgRHVmcmVzbmUgPG5pY29sYXNAbmR1ZnJlc25lLmNhPoicBBMWCgBEAhsDBQsJCA
 cCAiICBhUKCQgLAgQWAgMBAh4HAheABQkJZfd1FiEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrjo
 CGQEACgkQ2UGUUSlgcvQlQwD/RjpU1SZYcKG6pnfnQ8ivgtTkGDRUJ8gP3fK7+XUjRNIA/iXfhXMN
 abIWxO2oCXKf3TdD7aQ4070KO6zSxIcxgNQFtDFOaWNvbGFzIER1ZnJlc25lIDxuaWNvbGFzLmR1Z
 nJlc25lQGNvbGxhYm9yYS5jb20+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4
 AWIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyyxgUJCWX3dQAKCRDZQZRRKWBy9ARJAP96pFmLffZ
 smBUpkyVBfFAf+zq6BJt769R0al3kHvUKdgD9G7KAHuioxD2v6SX7idpIazjzx8b8rfzwTWyOQWHC
 AAS0LU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAZ21haWwuY29tPoiZBBMWCgBBF
 iEE7w1SgRXEw8IaBG8S2UGUUSlgcvQFAmibrGYCGwMFCQll93UFCwkIBwICIgIGFQoJCAsCBBYCAw
 ECHgcCF4AACgkQ2UGUUSlgcvRObgD/YnQjfi4+L8f4fI7p1pPMTwRTcaRdy6aqkKEmKsCArzQBAK8
 bRLv9QjuqsE6oQZra/RB4widZPvphs78H0P6NmpIJ
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Xzpp1i9yhFiY86lHCQIK"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Xzpp1i9yhFiY86lHCQIK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 03 septembre 2026 =C3=A0 09:26 -0400, Nicolas Dufresne a =C3=A9cri=
t=C2=A0:
> Le mercredi 02 septembre 2026 =C3=A0 20:22 +0900, Kazuki Hanai a =C3=A9cr=
it=C2=A0:
> > v4l2_m2m_job_finish() publishes job completion and wakes waiters
> > before it returns. A concurrent file release can therefore finish
> > v4l2_m2m_ctx_release() and free the context while the single-core IRQ
> > handler continues with its tail.
> >=20
> > Both handlers only need the device for the matching runtime PM put.
> > Use the IRQ-owned jpeg pointer instead of dereferencing ctx after
> > completion has been published. This preserves the get/put pairing and
> > removes the post-completion context access.
> >=20
> > Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
> > Fixes: 5827e4b14ee7 ("media: platform: Improve power on and power off f=
low")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5
> > Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
>=20
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Also applied to my tree now, ty

>=20
> > ---
> >  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/dri=
vers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > index d147ec4830811..9010e7b1108fa 100644
> > --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> > @@ -1574,7 +1574,7 @@ static irqreturn_t mtk_jpeg_enc_done(struct mtk_j=
peg_dev *jpeg)
> >  	v4l2_m2m_buf_done(src_buf, buf_state);
> >  	v4l2_m2m_buf_done(dst_buf, buf_state);
> >  	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> > -	pm_runtime_put(ctx->jpeg->dev);
> > +	pm_runtime_put(jpeg->dev);
> >  	return IRQ_HANDLED;
> >  }
> > =20
> > @@ -1855,7 +1855,7 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void=
 *priv)
> >  	v4l2_m2m_buf_done(src_buf, buf_state);
> >  	v4l2_m2m_buf_done(dst_buf, buf_state);
> >  	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> > -	pm_runtime_put(ctx->jpeg->dev);
> > +	pm_runtime_put(jpeg->dev);
> >  	return IRQ_HANDLED;
> >  }
> > =20

--=-Xzpp1i9yhFiY86lHCQIK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCasIy+gAKCRDZQZRRKWBy
9O1/AP0Ub/AIchVgAs3Ts4yTOsB4mOEvnEYHlNzN5kVNk8UUrAEAtPaya56szHHG
qpbxCFdG4wfkrMMaiqEo5qcevW0q1QM=
=L2sR
-----END PGP SIGNATURE-----

--=-Xzpp1i9yhFiY86lHCQIK--
