Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730015;
	b=B72yqRjPqXDy13Ohv6aGfvgClhSsqOJqxuAdg2pzMN+W5Qw5LZBgnbvjUZdj2AXFBYiu
	 T8qn+hVzV1Kls12X9YZGZcpk4Ba63SXtjBDdXVCNYRZC1GGIyApNoLD/iOaUzj51Zyfn+
	 0BbKx+W87BIV6wu1KWrPAaEQPk8gPcHSTvh6Qc0bcQ4NyIfCZypWg2WQZHjsN0nHNPMm4
	 XkKnyczhSrFKitSfT6yuYSc79n4Vo+OLcvahNjg3zRqDo8/6Ha2ntOOHeCp7v9cv6lGzo
	 FPu3PBrJGUOj+spJX5TcBJs7Dxrz4e+IX0M/LvTzAKUnH7lgr+1jCyTJUHbCOAmOmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 User-Agent:MIME-Version;
	bh=env9OD6WJ5uGqN3vphpmLPvAyZWACc9jYsEiViZZwfI=;
	b=NRva1WG3Vl33ne9MYz5yxTpmhCtyXi9PVOhdIN8+Iz/dtOetNrWttYadpojSHeghHsNF
	 7FSSw6pVfybuX6bHNvDWdrdbt8ak8GQtYuqRL8VU1nFANdQKz2fOQrT0OPv/xbz4GElOU
	 iyRGG2evpA1uhzmWMKS7QijtFQDokHUbPe5LWcW6gPjwEmIMIuGaAqgswm+DfGODu1mNI
	 0fAcwEsABstfrtK4AddMEeT9L2iW6se5loAyEkdh6maa0wKURUGZXQDsq8qA3oFMrkOPU
	 j88itOjMqFbHV9ALXXu6PsdnVAFDqXbD4zRCHceEyz5A5R8qI1+WY3as5863c6EN53Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ndufresne.ca;
	spf=pass smtp.mailfrom=ndufresne.ca;
	dkim=pass header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="HuAe/wTW";
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C765606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 21:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C765606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20260707.gappssmtp.com header.i=@ndufresne-ca.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=HuAe/wTW
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-94999a08973so683363585a.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 13:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20260707.gappssmtp.com; s=20260707; t=1795730014; x=1796334814; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=env9OD6WJ5uGqN3vphpmLPvAyZWACc9jYsEiViZZwfI=;
        b=HuAe/wTWSVBcTgkxqCs3FJVZTgk/EcI6TOIk/kQi88nOHPAz0IshwbNbEr9Us7ruS9
         oUhp8H+XFRHy66KiBCKv5x7c1t25JuGVrf/6gTpXoX/Q4yi8td24zb+qNt4vl+x8JF9j
         3TePrqRHUwd96jczTkAsWm2Sc2zluXhSr7i95q5wn4+m6CJ1OaMe3tfBOPWVU/GMp1/f
         yaqEplLMmytsHbZf9bChl1Te1JVAbwU1f6gs44bw89kfVDemUCWTSnBRBWgBxq4Dh9Vl
         vvCtLyecMfxLcxBGfFCNqqVrcDk7aLV2HDYFOUllwxc2aWPqsfEgKcRyr2ZFRNHT5WmC
         I5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795730014; x=1796334814;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=env9OD6WJ5uGqN3vphpmLPvAyZWACc9jYsEiViZZwfI=;
        b=cylAx7Q84TdC17vHmuFN47yZ8npGdIz3JbfB+GEmNmsAW00He0DEMzgyEXOfiRn+EK
         c0wGcWtMpQPGnvpY8P9vlN3JHfg0HuoSnFQR6tCC2zn6W3Xp9svKO3ElfomoLoMOjnGS
         Nvc5mtRXC64BaCQzdQnyKMjGtvGh14yVQKDuYxpX+xO0HyWFM4gTazjDRAxxoQWhz3C4
         HYz83IsWl19Lz8GZp+uiqpn/TMxzkyp6EBWPFhw05M+y7BQRXmEyskZoCLBK7xNZEWXA
         EQFxdo2EXBVaKUjIoUaqPKw6YF+iwS5DrYtd3ezCBGIWnBhD7A/Wa2Au/DWYsvhAxd1U
         Qbww==
X-Gm-Message-State: APuU4Z9WB30oXUHPurmU8L+o/7hfLO90N1WdfpC/lOnrJV9CajtsmLWV
	EVju2e+05L68yphyKk6LH1utFqLCF5/VWaDRhCccPdSyILtiFc8lCfUUkr79u5fyfLw=
X-Gm-Gg: AZFdTZd2Rfc1aR3IiXd3snEFmeIr0EJC5g1IEwn3w5TVSahKSEisH0CQ6glvW8G/Npz
	Ge4EwSNv8We3djltLzt3ZoZXNMZ6v2D7UCYAR4ZpslP5nDVQ2v8x4eAx6BvTJeqSqEGHG21kJa6
	q0TODBslIx3U3WAMssGcqTaARkxeZ6HOaK6wKs5X0Xpp6Xbub1TUhw4ruALEvG/MY/lnzRp53Gh
	QWLEQ0Q3+pybvOVnQ04EvIBc7r2litsERQeQwrxKesdM/NJncBEOScK1yVwi+PN3t/8GSJeVPxZ
	Sg873LX5XWakjooQATmJ2sPaCZJYGa4+eWFIiAJYvcunqhQSsl6e2dc3xt+PieYNKwqP06Nm7b/
	OU/jBdQb+BGOZJZ85TxyDqZbOAph4C6ITictK7f3XtMuEhg4G7dw64sxVFGS0zWbT8cLV9JWC7l
	lHdj+ulVZZJld9JAqZGcFSK4Z2JS1xIUgnRb6GZXkbX3GoMH63tj9unYehr1LwrpwF9N1ynIF5s
	7/fos1Ema+A5eKtn6lF7CgeJwE/P5cLwydZYNXKxrTRl8RUchdSCWjpdSnnLTPm98DRA2ah+jAd
	a2PeqqqTo57n+ELs6L2IYWs0T9q+AFy4Xr5P9YDKlKX+6KGQPiu0WpU=
X-Received: by 2002:a05:620a:6011:b0:93c:c1e8:6504 with SMTP id af79cd13be357-949ba9555e2mr3721601785a.23.1795730014488;
        Thu, 26 Nov 2026 13:53:34 -0800 (PST)
Received: from ?IPv6:2606:6d00:11:8ec9::c41? ([2606:6d00:11:8ec9::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb349db3sm1654907285a.7.2026.11.26.13.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:53:33 -0800 (PST)
Message-ID: <a7e72cdb67e7ab8578b9ce44a4817ba35d1f822b.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mediatek: vcodec: NUL-terminate debugfs input
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jiale Yao <yaojiale02@163.com>, Tiffany Lin <tiffany.lin@mediatek.com>, 
 Andrew-CT Chen <andrew-ct.chen@mediatek.com>, Yunfei Dong
 <yunfei.dong@mediatek.com>, Mauro Carvalho Chehab	 <mchehab@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Hans Verkuil
 <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Date: Thu, 26 Nov 2026 16:53:32 -0500
In-Reply-To: <20261029053024.2526059-1-yaojiale02@163.com>
References: <20261029053024.2526059-1-yaojiale02@163.com>
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
	protocol="application/pgp-signature"; boundary="=-DlJB1J9haeeqeVzf+bdm"
User-Agent: Evolution 3.62.1 (3.62.1-1.fc45) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

--=-DlJB1J9haeeqeVzf+bdm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 29 octobre 2026 =C3=A0 13:30 +0800, Jiale Yao a =C3=A9crit=C2=A0:
> mtk_vdec_dbgfs_write() allows userspace to overwrite every byte in the
> persistent debugfs buffer. The read handler later searches that buffer wi=
th
> strstr(), which can read past its end when no NUL remains.
>=20
> Reserve one byte and terminate the copied input at the updated file
> position before releasing the debugfs lock.
>=20
> Fixes: 5e488a4fd859 ("media: mediatek: vcodec: Add a debugfs file to get =
different useful information")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbg=
fs.c b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
> index 2da11521fc7b..8528534e41ef 100644
> --- a/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
> +++ b/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_dbgfs.c
> @@ -77,8 +77,11 @@ static ssize_t mtk_vdec_dbgfs_write(struct file *filp,=
 const char __user *ubuf,
>  =09struct mtk_vcodec_dbgfs *dbgfs =3D &vcodec_dev->dbgfs;
> =20
>  =09mutex_lock(&dbgfs->dbgfs_lock);
> -=09dbgfs->buf_size =3D simple_write_to_buffer(dbgfs->dbgfs_buf, sizeof(d=
bgfs->dbgfs_buf),
> +=09dbgfs->buf_size =3D simple_write_to_buffer(dbgfs->dbgfs_buf,
> +=09=09=09=09=09=09 sizeof(dbgfs->dbgfs_buf) - 1,
>  =09=09=09=09=09=09 ppos, ubuf, count);
> +=09if (dbgfs->buf_size > 0)
> +=09=09dbgfs->dbgfs_buf[*ppos] =3D '\0';
>  =09mutex_unlock(&dbgfs->dbgfs_lock);
>  =09if (dbgfs->buf_size > 0)
>  =09=09return count;

--=-DlJB1J9haeeqeVzf+bdm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawiqXAAKCRDZQZRRKWBy
9HvlAQC+KcPKwSaD7Ix8GCPtMRz0njYszGlIhj94VYNm0BjnnQEA8O7IpD79HTUk
JcUCeKPKDEyp+qT34NJFPS+wfxGcZwY=
=kTt2
-----END PGP SIGNATURE-----

--=-DlJB1J9haeeqeVzf+bdm--
