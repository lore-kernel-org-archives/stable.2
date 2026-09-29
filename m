Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAC23164C7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715661; cv=none; b=kxoVrA75FVqMHrPa4VnW656y8+rZyd05QUBOlihxvuYPqUaJMWKQTjJb5UOu6RO4wtAAw6NDXKjKVu95wjQv/cvvfD1Pto8RjqY7ICv990ISzeq0b634VnzyKlR5yHEj5pZIV3/zX8OXCtCPsOP733fQ5emqa+h9eAVyOYq1kcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715661; c=relaxed/simple;
	bh=UoQrgOIT9pT4CzAhwaqrqGXRM6nIVCOsWizitR0s6Lw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q2SNCY3xXvgfIdESJfaoPjreTtkjW+WxTV1Cysm7XXM+M4NGGQ9GaLyjx9i1HS4IVH2lX1vyjEJgKFZSL/YkaB43Irt7cB4EiXP5F1Fnpb2W075av7UxVRg/YOMA9lPbz/0ygrY/W31Uikbr0krCBadqA7xA6Sn4rLdCPvDGReg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=F6haQvth; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="F6haQvth"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78564313adaso1372692137.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790715658; x=1791320458; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6WFXVZDT0yfhcBTuFPg21aJm8jhlblvZ+mRIY0J9dPY=;
        b=F6haQvthqtouYa7WksLEtpww5oRxVMFjh0nSB1bndfTjKVZ4dZ3gr7aI8zLWNcV5lt
         1hi2zzRwKsjQ/jTXheREet4B5NnFpo5n26wyITm+Su6zcUqU6L2rfRY9UUrUzq3dpdmq
         9qkp8mO7uj1vLIUtQfZ4I7btlbotc1+CXLTspVD7/Y5mk59u1z0nDEqufmWKR8WirMuR
         9nDUS719+BG0YBnH42dm6VMaDl3JegbA4UsZiMmvQHkqwwUnfudUEV+n1KD9KZYORiOv
         kcfLYoU6a+C8Us9Q/Vdfe/8SfDD5lCRE7KK5hWOjbkOE2TCmgLTinOBvXG1NXtODOu+r
         jW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715658; x=1791320458;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WFXVZDT0yfhcBTuFPg21aJm8jhlblvZ+mRIY0J9dPY=;
        b=2sDj8p9zGcVTQ6D4r4EbOpraIPoKjGF26Sgiei6vQJtsLSA8L2ox6aBnr6IZxnmoZx
         ixNvD9hugOb5M3e0QwYal5+dQIZ0QZ5GHHV+6NAG5tWimXOhY52tkXsdP0ys+43lYiRV
         BsclqXtpP4g57c71fwaQunx18T421D95wEeXy9Z+1se38rtMjJyPqPrCSKcm7P+Gqpz5
         lfarkbhDIRhrRJU/5ykBpK+UObAMcapUKzX+wfUoKilsKUjEaaDkaRfvxDkjpZDyZmih
         WNwSUigUvalO8vV2EPDvGFV+lvqXyw8afpsct98O0eMVo5tLLNo+r4E3XNoPp3Trwj6w
         bWCA==
X-Forwarded-Encrypted: i=1; AKwUvBy4ZXcqXIinwfXiQ6yOgUbeRbIV3O9i1rAyhoYP8dDIhzserDweCdoRMsInadSKrJanlcXTAFY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKMwKOl/XZ4irHdVO9d7WBBK1MgZldtPm/w5NjpQuVPcqA3WHFD
	yLE+vS99yBZnsUxGPC6uQ2CD1uIqkikI+33dS7Bg76OdlWElzfWbJaeR82eEFJLZbAQ=
X-Gm-Gg: AYBFou3KupmJYptVLzfDRdepGM+e7Y/xNmEs4ysIJlJ0JGVdAMD9fG4gxAa6gLbzJM2
	G3qtDfIoIuJdIkm9Nv6rP7QpYZgMwC0JnhROhAePuyH3YNpWGYbXHeY7zDCZ29MFPTT7Oj5YYV+
	A9VGlCeslun/jOOqgnynkVD4cUq8j9aErLp+622hstd5A4IRJXnbBzDBuy9Q/jNKtnsdrjROhyL
	tEgwJLonrwNlvRnHUE4jcbFDbkNFu7zdRl7gljqNRH5f2p8qJdnd0avK4iqeCPc4mow13bbNFJi
	B3S0hWvQO1s5dQ9fE2xoSra6Wjm344CDA5R+iIJu0FvYJi0BvqGm7MDMBsBi8QzQIpaZUbDqO6I
	4BO/wbzMqvLwU9PXzM5o6/EmaqAX1Bo0CKRSQxUBzzR2ImXvr9WwD+lmmoI9GNcn5AJKpEDq8oc
	IwiLcnVqeB+lPGay5R+DCGQM5FUyeJhbx6Wlxx+m1Y4oLbshUFdaThfDYB/Ht1lLTbVb5gFgn9q
	CChnmqRLLctsg==
X-Received: by 2002:a05:6102:2d02:b0:7aa:1b48:ca3f with SMTP id ada2fe7eead31-7bc39333beamr267682137.3.1790715658269;
        Tue, 29 Sep 2026 14:00:58 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d4e778bf23sm1128224e0c.3.2026.09.29.14.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:00:55 -0700 (PDT)
Message-ID: <2e3c6c4eb72d79ef8b995d6ae62a6424685ec281.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mtk-jpeg: Fix runtime PM leak in
 mtk_jpegdec_worker()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Wentao Liang <vulab@iscas.ac.cn>, angelogioacchino.delregno@collabora.com
Cc: bin.liu@mediatek.com, hverkuil@kernel.org, irui.wang@mediatek.com, 
	kyrie.wu@mediatek.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 mchehab@kernel.org, 	stable@vger.kernel.org
Date: Tue, 29 Sep 2026 17:00:54 -0400
In-Reply-To: <20260917100247.2145872-1-vulab@iscas.ac.cn>
References: <20260917100247.2145872-1-vulab@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="=-LdOO8KXcg0f7Ano5ixCQ"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-LdOO8KXcg0f7Ano5ixCQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 17 septembre 2026 =C3=A0 10:02 +0000, Wentao Liang a =C3=A9crit=C2=
=A0:
> pm_runtime_get_sync() leaves the device's runtime PM usage count
> incremented even when it fails.  mtk_jpegdec_worker() jumps to
> dec_end on that failure, which does not call pm_runtime_put(), so
> the reference taken by the failed resume is leaked.
>=20
> Use pm_runtime_resume_and_get() instead, which drops the reference
> again when resuming the device fails.
>=20
> Fixes: dedc21500334 ("media: mtk-jpegdec: add jpeg decode worker interfac=
e")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drive=
rs/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 8c684756d5fc..ed1d5858c942 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1732,7 +1732,7 @@ static void mtk_jpegdec_worker(struct work_struct *=
work)
>  	jpeg_dst_buf->frame_num =3D ctx->total_frame_num;
> =20
>  	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
> -	ret =3D pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
> +	ret =3D pm_runtime_resume_and_get(comp_jpeg[hw_id]->dev);
>  	if (ret < 0) {
>  		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
>  			__func__, __LINE__);

--=-LdOO8KXcg0f7Ano5ixCQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarwnBgAKCRDZQZRRKWBy
9JxRAQCaqpvPcMxkU8M6x7Jg8iRFYx/F7tQzZ4yTAJ0dpC4WDAEAkMVIPHkUqYox
NeqJq4h74JpK7UjBvsNaj7x4tjst7QM=
=Fvo3
-----END PGP SIGNATURE-----

--=-LdOO8KXcg0f7Ano5ixCQ--
