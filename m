Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843E4FC32F;
	Mon, 28 Sep 2026 20:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629049; cv=none; b=EQpvmiGaxE9n4NubUOxc16st2LZ4wvtUdcvrSXPJMg2yShrcZADxhKGQPVgGiXCi9VxeMuw59yiMThmRthT/3iTgAUOJflzUx4SM5mEibDpkHMXlkcahOVOYNCwj5vuTMVr4B454RG/OasdoDvBWY2vkJKncKL1MoqKvvxAlIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629049; c=relaxed/simple;
	bh=TT74p3cHstZBVa9P1I8B2IeGX50jmgT7WU1oUxuEDqg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDGs9ZK+ci6/LZGi83ioSmQbsiLEIL7wUNzpVScugyfM0Q5LuMyLcPiA780+gViz6CPgCp/ikqh7JZY0vNBup8tABL+oBd0b+jb+C8Dg2DM2m6Ixq9j4cqn99IKRLmWNV2uqX5LoNgXaEOxFTaoG4xKAy5FZrMx41OPbq906ubA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SxNyM8SK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SxNyM8SK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790629045;
	bh=TT74p3cHstZBVa9P1I8B2IeGX50jmgT7WU1oUxuEDqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SxNyM8SKWZTe0dRldz4qC1hMT/3dKboLLdi4ssezbYioaNCiDGoxeQkBlCpSzup4u
	 WbmXb7lQaqBVtibuvrFikD1CrPX6OGfztpYJku3Kv1tdUlsiBqPkWQcBWofj7ej7EG
	 fx2SuWj6YpnkIUrwzEuKbVOj6U6THPPfyZo7Ia0ln/z8l4k+a0sA+yFe9x84gPeLVg
	 sWz6jJdTwZHvB6fLZoBicy0OVEAX0q8zEdx+Hik7JTlKSlXWiyk5S42U8r4AsAD27y
	 WY8OdxOsnh/NJbohvYLsYJt9lDNAB6lLVhOkEHdpvTam7vELUxkBOanfD1n4Nik684
	 dXoyvVBEQtwmw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9C85217E0074;
	Mon, 28 Sep 2026 22:57:24 +0200 (CEST)
Message-ID: <7f06fbc16db2391baa1b0051943cfbafe961fa07.camel@collabora.com>
Subject: Re: [PATCH] media: chips-media: wave5: Balance runtime PM on
 encoder close errors
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Linmao Li <lilinmao@kylinos.cn>, Nas Chung <nas.chung@chipsnmedia.com>, 
 Jackson Lee <jackson.lee@chipsnmedia.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sebastian Fricke
	 <sebastian.fricke@collabora.com>, Hans Verkuil <hverkuil@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Mon, 28 Sep 2026 16:57:23 -0400
In-Reply-To: <20260717075714.1508938-1-lilinmao@kylinos.cn>
References: <20260717075714.1508938-1-lilinmao@kylinos.cn>
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
	protocol="application/pgp-signature"; boundary="=-o3oZO7blpYQnPuOg3/qP"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-o3oZO7blpYQnPuOg3/qP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le vendredi 17 juillet 2026 =C3=A0 15:57 +0800, Linmao Li a =C3=A9crit=C2=
=A0:
> wave5_vpu_enc_close() resumes the device before taking the hardware lock.
> Its three error paths call pm_runtime_resume_and_get() again instead of
> dropping that reference.  Each failure therefore increments the runtime P=
M
> usage count twice and can prevent the device from suspending afterward.
>=20
> Replace the extra resume calls with pm_runtime_put_sync() to balance the
> reference acquired on entry, matching the successful close path.  This
> aligns wave5_vpu_enc_close() with wave5_vpu_dec_close(), which already
> releases the reference on its error paths.
>=20
> Fixes: 2092b3833487 ("media: chips-media: wave5: Support runtime suspend/=
resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linmao Li <lilinmao@kylinos.cn>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

picked, ty.

> ---
>  .../platform/chips-media/wave5/wave5-vpuapi.c     | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index f77abd5e122a..4c1842f02c88 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -754,7 +754,7 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, u3=
2 *fail_res)
> =20
>  	ret =3D mutex_lock_interruptible(&vpu_dev->hw_lock);
>  	if (ret) {
> -		pm_runtime_resume_and_get(inst->dev->dev);
> +		pm_runtime_put_sync(inst->dev->dev);
>  		return ret;
>  	}
> =20
> @@ -762,16 +762,13 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, =
u32 *fail_res)
>  		ret =3D wave5_vpu_enc_finish_seq(inst, fail_res);
>  		if (ret < 0 && *fail_res !=3D WAVE5_SYSERR_VPU_STILL_RUNNING) {
>  			dev_warn(inst->dev->dev, "enc_finish_seq timed out\n");
> -			pm_runtime_resume_and_get(inst->dev->dev);
> -			mutex_unlock(&vpu_dev->hw_lock);
> -			return ret;
> +			goto unlock_and_return;
>  		}
> =20
>  		if (*fail_res =3D=3D WAVE5_SYSERR_VPU_STILL_RUNNING &&
>  		    retry++ >=3D MAX_FIRMWARE_CALL_RETRY) {
> -			pm_runtime_resume_and_get(inst->dev->dev);
> -			mutex_unlock(&vpu_dev->hw_lock);
> -			return -ETIMEDOUT;
> +			ret =3D -ETIMEDOUT;
> +			goto unlock_and_return;
>  		}
>  	} while (ret !=3D 0);
> =20
> @@ -787,10 +784,12 @@ int wave5_vpu_enc_close(struct vpu_instance *inst, =
u32 *fail_res)
>  	}
> =20
>  	wave5_vdi_free_dma_memory(vpu_dev, &p_enc_info->vb_task);
> +
> +unlock_and_return:
>  	mutex_unlock(&vpu_dev->hw_lock);
>  	pm_runtime_put_sync(inst->dev->dev);
> =20
> -	return 0;
> +	return ret;
>  }
> =20
>  int wave5_vpu_enc_register_frame_buffer(struct vpu_instance *inst, unsig=
ned int num,

--=-o3oZO7blpYQnPuOg3/qP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarrUswAKCRDZQZRRKWBy
9ObpAP9G1wVYQXoYtKAZSl9qDIN2cAllpelKU/dUPpwyU2D92AEAnf0IlCQAIR5H
UBamORFbCvqL2CXELoKDUNgLP6CbOgw=
=xgT3
-----END PGP SIGNATURE-----

--=-o3oZO7blpYQnPuOg3/qP--
