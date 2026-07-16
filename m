Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F4B22301;
	Thu, 16 Jul 2026 00:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784160655; cv=none; b=NUcNtRydzOubKS8anibI9x4KWhBqAUWl0DMvFuxe3omhiaVns4REDiM+mlXMMsCLb8NEMmO9WK/AvxL3t0lLiMx+U4t8y/vA/b+i2W/IaZYILMfBwHixDUkCLfS5L72SC7gEhE1dUrSNs/CUWSpgrw5n2rjdj8DUjIkUfWCWWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784160655; c=relaxed/simple;
	bh=L6wzWtyvgyok8KVvz9Zy5mkqvkgLWLzGSf4BynH8hsA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MHLw+QO4CAU+4c1WkCUwVyowPzXuIN4z5n6rebYk8kAVJbP2owgwfUMpwaKdjIwf8OmLfo2Tao+ERtC/rBVcgs4nT7Y8mcWCl1V7Fe9yONJn0GPhrdRVOKL459EtXxmGN8ckOVWNNAXBlM/+ZR+3qnnxsRnyUfYRNaydaSEBna0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qej1PAxX; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qej1PAxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784160651;
	bh=L6wzWtyvgyok8KVvz9Zy5mkqvkgLWLzGSf4BynH8hsA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=qej1PAxXwUEHHwB2sL10F5Sk0AxcW/t6ZkTX+1ZWRNw44sbZaLF7zVlgWxlvFI3aB
	 0XjSSxu6aWkYFRbBWLPDBNTDiY6VAPejanoggfArp4UTaJLIEdzyzPJFBogLDDKqAD
	 vUesX3/OkQ7aP5tMThMrCdAlBaAIH9WTnU/Tfijzr5ex8gqViZyWnjLZfAiA9oFiVS
	 NVrCuUWNpOJ1Gf1RHK8seDoi65iawP4uwT1nhQeoI+7CMzQeQj057weCH+QJ20eucZ
	 xfuFzhnTBkVsI7LMT5MY2kpQznkEXpgHddc6iDFKf7AWnOeT/NQgnqIheQFCKHdOZg
	 zwbLgy64vdycA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 19CF517E0D7E;
	Thu, 16 Jul 2026 02:10:49 +0200 (CEST)
Message-ID: <c0aa1f673f13704e05fd564904c5cf28a2dba9e6.camel@collabora.com>
Subject: Re: [PATCH] media: mtk-jpeg: only init/cancel work for multi-core
 variants
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Bin Liu <bin.liu@mediatek.com>,
  Mauro Carvalho Chehab	 <mchehab@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Fan Wu <fanwu01@zju.edu.cn>,
 Hans Verkuil	 <hverkuil+cisco@kernel.org>, irui wang
 <irui.wang@mediatek.com>, kyrie wu	 <kyrie.wu@mediatek.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	stable@vger.kernel.org
Date: Wed, 15 Jul 2026 20:10:47 -0400
In-Reply-To: <20260601073218.1281840-1-zhengxingda@iscas.ac.cn>
References: <20260601073218.1281840-1-zhengxingda@iscas.ac.cn>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
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
Organization: Collabora Canada
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-WdvxyDtEJGKYSORbsIFW"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-WdvxyDtEJGKYSORbsIFW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le lundi 01 juin 2026 =C3=A0 15:32 +0800, Icenowy Zheng a =C3=A9crit=C2=A0:
> Single-core variants of this hardware do not use the work at all, and
> the worker function is set to NULL, which leads to warnings when
> cancelling the work in release callback.
>=20
> Skip the work init/cancel code when the JPEG hardware isn't multi-core.

Thanks for sending this patch, thought this specific issue has alrady been =
fixed
upstream, see commit b1845a227fda37b2fe5327df3ca0015d7e290235

Nicolas

>=20
> Cc: stable@vger.kernel.org
> Fixes: 34c519feef3e ("media: mtk-jpeg: fix use-after-free in release path=
 due
> to uncancelled work")
> Fixes: d40e95274925 ("media: mtk-jpeg: reconstructs the initialization mo=
de of
> worker")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
> =C2=A0drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c | 6 ++++--
> =C2=A01 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> index 8c684756d5fc2..83e54a7ef49c0 100644
> --- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> +++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
> @@ -1160,7 +1160,8 @@ static int mtk_jpeg_open(struct file *file)
> =C2=A0		goto free;
> =C2=A0	}
> =C2=A0
> -	INIT_WORK(&ctx->jpeg_work, jpeg->variant->jpeg_worker);
> +	if (jpeg->variant->multi_core)
> +		INIT_WORK(&ctx->jpeg_work, jpeg->variant->jpeg_worker);
> =C2=A0	INIT_LIST_HEAD(&ctx->dst_done_queue);
> =C2=A0	spin_lock_init(&ctx->done_queue_lock);
> =C2=A0	v4l2_fh_init(&ctx->fh, vfd);
> @@ -1202,7 +1203,8 @@ static int mtk_jpeg_release(struct file *file)
> =C2=A0	struct mtk_jpeg_dev *jpeg =3D video_drvdata(file);
> =C2=A0	struct mtk_jpeg_ctx *ctx =3D mtk_jpeg_file_to_ctx(file);
> =C2=A0
> -	cancel_work_sync(&ctx->jpeg_work);
> +	if (jpeg->variant->multi_core)
> +		cancel_work_sync(&ctx->jpeg_work);
> =C2=A0	mutex_lock(&jpeg->lock);
> =C2=A0	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> =C2=A0	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);

--=-WdvxyDtEJGKYSORbsIFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalghiAAKCRDZQZRRKWBy
9Ho1AQCHwVea3BvJBHkB/HKCykfk5eoLVVPni4hAFnB/JkpttQEAsS7hLarWfHxC
6c0nnvMsKvuEjLpd/7icUUQYJzRJKAA=
=/DUp
-----END PGP SIGNATURE-----

--=-WdvxyDtEJGKYSORbsIFW--
