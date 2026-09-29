Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFE82BE655
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 21:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790715681; cv=none; b=FiY7FbnE3iZ93vNun5WPrij6IN/FVBpqYRJ4SHuUDhgxgTWNfw1TBlTcnwDxltPV2rIzVPUS766873dV0B+HYCY0yI3m/6+Y8qOMVckLKe6vFpwEd5au1iM1DMOXk0nv42hITO+25/qvR7R+JmG98KctcYLIozwDtEfQX15b56c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790715681; c=relaxed/simple;
	bh=2+ejL0YZjI8InY0H8ZJcRERvW4tbYvlDaxnKFDKpqyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uEQFHEkq1UcNsdTGbxdonULdVZB2wfME8E3E9SzlRWxj62ySOqSZ5i51eOiNV6jEuEmJNASyticDzy9wZQQ6aOhHho+emswF7tHWdp3GDL4oy2LNYNvP56YJvk7DVIBfWc/oIfw6gH10CpHuUHDozciooPjzbFQfqFMY48ZghPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=01rQEZem; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="01rQEZem"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccf4f65037so2465838e0c.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790715678; x=1791320478; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YQOfsK+HlKeVCf8Z4OdzeQNNGZLvLEYB73B+IGrPM8Q=;
        b=01rQEZemfUJg+3qt0rigGhhQqFf/xLI4VumTIP9BDt6uzvbnuFLDEOxHSO45v22ry5
         mrU2aAhScNzE0ZaK43VBPtqMmMsmf3PDHAecdtoOLmYmbvV7ZVkWZpLTOpC7rHEvvK6B
         FUTwM7vuLSB3E/wCy0FqZeSMuocfB1i7P5wKCNU2hi/U+JQ4LChxeJqI5lpGFiMgtIeT
         DT1UgiV4ghL+2LWpGKxrSYUgxN1SeW0ikejSNrt663U+6cHQ81UQnds62RWV1NHmgHIz
         4R+OSW4n7QoAhZFvw0EnxQ0RXGOpcp96x6NwuVikJv35+fh7an7yqJM2+gO8FT6Hbi3f
         QuPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790715678; x=1791320478;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YQOfsK+HlKeVCf8Z4OdzeQNNGZLvLEYB73B+IGrPM8Q=;
        b=ct+I23t8SQ91rgDex4jG5BKm8srukkaqsD9M0uZczEIXu06sBa6PRSBsLL9IfgfD2V
         etK2lt18QVfzOYxX4bQseDsohZh7/KG2p281vY/6JgIz+kgo2/qAklWfNPSa+KXaoopq
         LYC+MYZ4qc9LdSLoaw4X5LX2c0nqF15T9XYMft9y2EURgaxPA9dVx/MjXlC0N6zGxQYR
         iahuXXgab5XWDWw1cmQjxQlEoIOS9tjQsBlzkOzpLupV7cc4bCtLM3AKfuJOqkw8BUZD
         Fv3g2Mo71MsGQyr7jsR1CFdg67cm5P9pc3ZpEGYUCQIuE/MCVVa5zqPfWvkWkiooH9W4
         6KkQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqruJoceCJHXnIArhsVNVk9xNkkllQL3HIXaRrgU6FxpYSpAuNSCuPXoJ/HqAxVaWDqeeNohY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSrykvXNo3Dopqxg0H0193mSAlgnNPtZvU75NCzLDM06HlB89k
	aMflyHD6t48DSawY4KsssOTnchlYVDmtfFj8wjWh5yvltMHmRjucJ6tjsejHhMJ7RVI=
X-Gm-Gg: AYBFou3MWGAGA6+D7evq/mvmphALAKsrxjigw+kjFwJsymPdVOwdH+v58dhR3fbpkDm
	g2RfBtkrXyeaNHvDq+tMJZ1YvWoYX8rue1HcYUAXMpgb6NRyMEcnP+xv/M22BL+e1r3mjCBJPjN
	Qn48+tVqfL3N77WnzhVHf4j27Qo15qvVXWR5rK3jRnRjk4dQhL6PBTxIndgMNpes8XEYt9lIbah
	PGD74DyeYXepBjpP8/nObpUZ0OnmpdSz2yM/IjKJeP5IXtzjdI55xdfH5ZpPJdJ946oA1Wa9xh5
	vMOwneD9xKMJBLfNL2TQoOxJqLBeWmrNXjqmGuz6sZh3ej3mO3IBokIeXa2efheqxxYD8cUhyU0
	EKNEMnuv0HpsTpmzHp4KhhHMMhLv2N4tize/M2d2cyuFBuPkccSJP/HDrhjIdc9Ox6ZkvcM4go5
	dEs79eoPo9kEjD6FIsUltF8/XOoBFs2aQzsQuWp1ve4tW0bMyzwruMCNxK9oQCJDsR4p8PiBboE
	UrEYcjER54juIUIy7SvtQyJ
X-Received: by 2002:a05:6122:1c05:b0:5c9:ae70:e784 with SMTP id 71dfb90a1353d-5d5131cdd4cmr304268e0c.3.1790715678096;
        Tue, 29 Sep 2026 14:01:18 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d4e778bafasm1226873e0c.5.2026.09.29.14.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 14:01:17 -0700 (PDT)
Message-ID: <dd1d9010ad1a3ee11fc38923dfa1252992c2b245.camel@ndufresne.ca>
Subject: Re: [PATCH] media: mtk-jpeg: Fix runtime PM leak in
 mtk_jpegdec_worker()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Wentao Liang <vulab@iscas.ac.cn>, angelogioacchino.delregno@collabora.com
Cc: bin.liu@mediatek.com, hverkuil@kernel.org, irui.wang@mediatek.com, 
	kyrie.wu@mediatek.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 mchehab@kernel.org, 	stable@vger.kernel.org
Date: Tue, 29 Sep 2026 17:01:16 -0400
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
	protocol="application/pgp-signature"; boundary="=-OaQi5nvPKDU3qCHl6JAX"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-OaQi5nvPKDU3qCHl6JAX
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

--=-OaQi5nvPKDU3qCHl6JAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarwnHAAKCRDZQZRRKWBy
9E83APwLk0zeKWzQOIGJYqNZSVuM65LfwP9mlNJVQ/ss2bY3FAD9EhLs8d7/vbqz
J2u9T+/yffmnP0xvF8G43YoE4lnGZQg=
=AlR/
-----END PGP SIGNATURE-----

--=-OaQi5nvPKDU3qCHl6JAX--
