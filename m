Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ACC4AE118
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788441991; cv=none; b=JLJSGKkdVTCJmyo81fwH0fD1tEA+9G7AKINX+ahjOov6ju7LtzX4oqGbzZD37vNBlViD4q8k10HFwgz40p/S8ELFXj14vW/Vq3M/05EZ+9UNLUExS+Pog+jiY92Ucs+/aOOpmxuo5E1qUB+hc/K+4BwiNr9Mw5uGauhFm7/LBfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788441991; c=relaxed/simple;
	bh=2sGaRaD9tcOAiHz4nfLu6kmM1/iqHwdSgzsUdahOT28=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V6P5IakVlO/AK/3/KeWKvs78rLtCV7Ee87pQpeseCYBAYMa8SCRJ0G5gbBWNsEH9r6H7pOrpcBWpUWqsCj0aEQizB7zrq7L5UBvrrO7S/UwzCI/lqc+74TckUY2yA1VHxL2LReTByRkLXsclM6ledX2CNz0UmMv15xHzZMpJqEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=MxjPNGo1; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="MxjPNGo1"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9387752a4d0so216083585a.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 06:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1788441977; x=1789046777; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FS5+rJblKYEfHvwn3uJ9BzAl/oWa4dPgbHxuamJmb0s=;
        b=MxjPNGo1LdRgdYV+wCc+qpF+TwdYZ+BMOKtdEBD05NjLImmQyiQzr7UtOWeKwWjbav
         MQwnComODjgz5opbe1+//rHQbv7ZWT/cXGtrAURLXPDkVfsY9bA1ZFQ7uCO/7KrL0tCU
         H+kufLTBaOaUzPdHji409XO+A10I0rwrl79iUmu5QAgPzmkxYpqW/zqxcdCIkNXUbOc9
         UKoiFXKryU4R6tkGE3a5S4IF8R8xhzsiuXSEdejT6Ulhz+ZBj5yZP2zzm6Rp0LqAp4oA
         e/kyHff/ttUnL1WRYdhQr0EjU6y8JIVOT4k/CcbnsGtAcsaiWLH73plKFg2BIanyqzqG
         WSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788441977; x=1789046777;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FS5+rJblKYEfHvwn3uJ9BzAl/oWa4dPgbHxuamJmb0s=;
        b=Vmg/kqIw1YVMM0zFhmjOm0903zsEuxb1gf2F2YtMPrGjUo3RZPm8+xeSu7kxjtRQ2I
         tc8dvXvNM5ewROvJnS97E/joxXlUrcMWiKr4pT8b8BtZWbYOWg54PL/hcvqv5YiBRwSG
         IUflcKLHtAU2N5biz+650nswx4anmsfHg161IklKWVWVQdZg/qSCQMQaEo38BlNL/nXA
         hmJfLIX8jvnf5bFwIA/dzx+c5yclUcJQIEhvCa9O0f2Dv7tMf3Ggk7dwj2PRk+/a59mi
         qdJhbanVHRBehKVCpa0sx/1H5wRIvQh3JWG2lc41RC/63LKE04oomy5fFulwdBDDTteu
         CzKQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2rRKWlO4xJ23VMcWk6j2k2+BGBg8qe7f1AVwXlTbMt1zP02Vl4od9vLBoagHW6ZjNSrrDi40=@vger.kernel.org
X-Gm-Message-State: AFuF++nv54iYrv90ZshkjfZKl1PN3pzuDlbopy6z/e2gRjJjHfW+fO39
	PDyquHvkJiTANwtmW6V7dT80uK2ZI++Jg/DTZ/7+SYfUQhrbfnHOL3dfRFQMOr80Heo=
X-Gm-Gg: AYBFou1XDGBUauN2+/kwVFDvB22W30jSNAxzcPoaWBwDHbjBfhonOa5FEPD1MPwEzzQ
	EJZOXaSnH9E10phpGtA6kIhs+KQnTwWuo5pECBdpTVp8a94cUYEUp10/T2s5QthiilqKOnI+L1y
	iPkQcxZbwmemc90cDCGlpDA0UR+6ZdkXZwzt5fQQyuVl7EpgSeIi5liIbQF5Q2tNC2ewnJXyhhA
	bA7NH2hWynfFTAml1fy7VfemF1HtCVcTurkm5lc7B71xAcraiMUBd7R1yke4evp8RWAfff7Q2n2
	IXVvrZ+j6o7aitNOHMJOfwWJSSseT/LOFfJLuBWPo1SkNjEaHB7rqY9rc4HQW8qD7KU48d/4tzk
	kQvWhEWu1XqoVeFsVLf8MHJMytLBIpJmLoxNU9hg+tga72OMKivOM1J2UOGziGzqmzfMwHVQYpz
	P6PLkGp1+xHiZJYJOzE+kqXTZXo20QR99B5740VuBsbyYoBPA5koU35lKMcFrdtZU2
X-Received: by 2002:a05:620a:4387:b0:937:2e9f:70a8 with SMTP id af79cd13be357-9396e48bd68mr677603885a.39.1788441976610;
        Thu, 03 Sep 2026 06:26:16 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e221::c41? ([2606:6d00:15:e221::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9395f1539f0sm486856785a.10.2026.09.03.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:26:15 -0700 (PDT)
Message-ID: <e7aef28efd9860e80b8be8865dd04268ee2fd786.camel@ndufresne.ca>
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
Date: Thu, 03 Sep 2026 09:26:13 -0400
In-Reply-To: <20260902112230.452176-1-hnkz.64@gmail.com>
References: <20260902112230.452176-1-hnkz.64@gmail.com>
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
	protocol="application/pgp-signature"; boundary="=-9FOa56BBGzqoLxtHjz2i"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-9FOa56BBGzqoLxtHjz2i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mercredi 02 septembre 2026 =C3=A0 20:22 +0900, Kazuki Hanai a =C3=A9crit=
=C2=A0:
> v4l2_m2m_job_finish() publishes job completion and wakes waiters
> before it returns. A concurrent file release can therefore finish
> v4l2_m2m_ctx_release() and free the context while the single-core IRQ
> handler continues with its tail.
>=20
> Both handlers only need the device for the matching runtime PM put.
> Use the IRQ-owned jpeg pointer instead of dereferencing ctx after
> completion has been published. This preserves the get/put pairing and
> removes the post-completion context access.
>=20
> Fixes: 45f13a57d813 ("media: platform: Add jpeg enc feature")
> Fixes: 5827e4b14ee7 ("media: platform: Improve power on and power off flo=
w")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5
> Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index d147ec4830811..9010e7b1108fa 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1574,7 +1574,7 @@ static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpe=
g_dev *jpeg)
>  	v4l2_m2m_buf_done(src_buf, buf_state);
>  	v4l2_m2m_buf_done(dst_buf, buf_state);
>  	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> -	pm_runtime_put(ctx->jpeg->dev);
> +	pm_runtime_put(jpeg->dev);
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -1855,7 +1855,7 @@ static irqreturn_t mtk_jpeg_dec_irq(int irq, void *=
priv)
>  	v4l2_m2m_buf_done(src_buf, buf_state);
>  	v4l2_m2m_buf_done(dst_buf, buf_state);
>  	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
> -	pm_runtime_put(ctx->jpeg->dev);
> +	pm_runtime_put(jpeg->dev);
>  	return IRQ_HANDLED;
>  }
> =20

--=-9FOa56BBGzqoLxtHjz2i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCapl1dQAKCRDZQZRRKWBy
9DhIAP9oMCJ3+qbEiROH2krc0Am+crQeWpa/pbhLHgt1o6oPXAD/WXV6nBJA6ZC+
UGQHbSlMl2Vy9ERh3f8kD3KvuG+zCwE=
=FjHo
-----END PGP SIGNATURE-----

--=-9FOa56BBGzqoLxtHjz2i--
