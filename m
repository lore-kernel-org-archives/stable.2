Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E36239E60;
	Thu, 16 Jul 2026 02:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784168325; cv=none; b=dq1+9Q6UFPxpM+siIvfpWaWsnqChM9GSoGh2aUOHHgd4eDA17lQ+jUr7nlyyKC9CwP6V/YWbsPZanFQeshN4hT7GIyxZuPd9yVcimokSr4r/JZdhRh6CiqdqTQ3/HzSvjZIpuwLNk/o9EsIZ3IthKOf0L3bTzGGe+g1u/jdrp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784168325; c=relaxed/simple;
	bh=0tN3fsdOyOXADAa71JQW1wyf9KWDjDUYNGo4frp4W5M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H7JHG0i9A0eFgYzIFe2JBf2ocu3cl20SjLzt6hbl76qYLTPhIPa1CMD3WExAacZEusMzDWBo2yn2PR9wJ0UUVvT5aB8bduVzWoct6nmoGHYa/kQcqTe1mKWBoY8zHTvndTSLygVOJO/ugqhTN/SDJHZis2kb0qjnegAV2jbpti4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NRaXYnFz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NRaXYnFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784168322;
	bh=0tN3fsdOyOXADAa71JQW1wyf9KWDjDUYNGo4frp4W5M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=NRaXYnFz3UXh+33+4YmuVWEtMd07YuSTEV8B4SM5HnsztzznhbRO2S6HaD21kEP1O
	 BhVJ4tmaOp+hyhaRQMdaCBRv2jfrbge4Gs0WHjpGCjjU+cvuPiC6njx4Y6zbYNjkHR
	 6PGlGD335+8MU07cUaEE/d5on+DesEr6zl0BIqYCRhfFSAzLr8ftGjsqSyhPt+NhLw
	 325Lu0gh7kDjHK/HOe7id2HjXcNqTaFfuCSvRCVBivT3gmJnvx5TPkw6TMWWfY3d5o
	 27xUrY7GAxHP9olT/RjeIZsnbGrw3ZR2XKkBflpYdLomR8IwBqgXzXwDKPnUhxnCz2
	 jX+gEghASHI4g==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BC24F17E0B89;
	Thu, 16 Jul 2026 04:18:40 +0200 (CEST)
Message-ID: <664e794362bc4123c7e20a51f50de4f4d0fe639c.camel@collabora.com>
Subject: Re: [PATCH v1 7/7] media: chips-media: wave5: Resume device before
 setting EOS flag
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Wed, 15 Jul 2026 22:18:39 -0400
In-Reply-To: <20260626012232.111-8-jackson.lee@chipsnmedia.com>
References: <20260626012232.111-1-jackson.lee@chipsnmedia.com>
	 <20260626012232.111-8-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-ZxYyIobvz8GoqpPU9/2D"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-ZxYyIobvz8GoqpPU9/2D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 26 juin 2026 =C3=A0 10:22 +0900, Jackson.lee a =C3=A9crit=C2=A0=
:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> Setting the EOS flag talks to the firmware via send_firmware_command(),
> which accesses VPU registers. Both the STREAMOFF path
> (wave5_vpu_dec_job_abort()) and the V4L2_DEC_CMD_STOP path
> (wave5_vpu_dec_stop()) can run while the device is runtime suspended, so
> those register accesses hit powered-down hardware and the SoC raises an
> asynchronous SError, panicking the kernel:
>=20
> =C2=A0 SError Interrupt on CPU3, code 0x00000000bf000000 -- SError
> =C2=A0=C2=A0 send_firmware_command+0x2c/0x160 [wave5]
> =C2=A0=C2=A0 wave5_vpu_dec_set_bitstream_flag+0x6c/0x80 [wave5]
> =C2=A0=C2=A0 wave5_vpu_dec_update_bitstream_buffer+0x80/0xec [wave5]
> =C2=A0=C2=A0 wave5_vpu_dec_job_abort+0x44/0xa0 [wave5]
> =C2=A0=C2=A0 v4l2_m2m_cancel_job+0x110/0x19c [v4l2_mem2mem]
> =C2=A0=C2=A0 v4l2_m2m_streamoff+0x24/0x140 [v4l2_mem2mem]
>=20
> Resume the device with pm_runtime_resume_and_get() around the EOS
> firmware command and release it with pm_runtime_put_autosuspend(),
> matching the runtime PM handling already done in
> wave5_vpu_dec_device_run().
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
> =C2=A0.../chips-media/wave5/wave5-vpu-dec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 19 +++++++++++++++++++
> =C2=A01 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index 1817b83c5884..6564cf3ec739 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -823,7 +823,15 @@ static int wave5_vpu_dec_stop(struct vpu_instance *i=
nst)
> =C2=A0		 * calls do not block on a mutex while inside this spinlock.
> =C2=A0		 */
> =C2=A0		spin_unlock_irqrestore(&inst->state_spinlock, flags);
> +		/*
> +		 * V4L2_DEC_CMD_STOP can arrive while the device is runtime
> +		 * suspended (e.g. on pipeline teardown). Setting the EOS
> flag
> +		 * accesses VPU registers via send_firmware_command(), so the
> +		 * device must be resumed first to avoid an asynchronous
> SError.
> +		 */
> +		pm_runtime_resume_and_get(inst->dev->dev);

I'll take this one, as it improves things a lot, but please follow-up with
fixing all the missing return value heck for pm_runtime_resume_and_get().

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> =C2=A0		ret =3D wave5_vpu_dec_set_eos_on_firmware(inst);
> +		pm_runtime_put_autosuspend(inst->dev->dev);
> =C2=A0		if (ret)
> =C2=A0			return ret;
> =C2=A0
> @@ -1797,11 +1805,22 @@ static void wave5_vpu_dec_job_abort(void *priv)
> =C2=A0	if (ret)
> =C2=A0		return;
> =C2=A0
> +	/*
> +	 * job_abort() runs from the STREAMOFF path and may be called while
> the
> +	 * device is runtime suspended. Setting the EOS flag talks to the
> +	 * firmware (send_firmware_command() accesses VPU registers), so the
> +	 * device must be resumed first; otherwise the register access faults
> +	 * with an asynchronous SError.
> +	 */
> +	pm_runtime_resume_and_get(inst->dev->dev);
> +
> =C2=A0	ret =3D wave5_vpu_dec_set_eos_on_firmware(inst);
> =C2=A0	if (ret)
> =C2=A0		dev_warn(inst->dev->dev,
> =C2=A0			 "Setting EOS for the bitstream, fail: %d\n", ret);
> =C2=A0
> +	pm_runtime_put_autosuspend(inst->dev->dev);
> +
> =C2=A0	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
> =C2=A0}
> =C2=A0

--=-ZxYyIobvz8GoqpPU9/2D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCalg/fwAKCRDZQZRRKWBy
9EqgAQCZox+YMrC69p3YdzQug3yWVeDLkPLw+rNr6NKZVhJKhQD4my8o2advnZe1
cAEJISWYts7UVKJvILvrdfKcVso2Cw==
=ov1x
-----END PGP SIGNATURE-----

--=-ZxYyIobvz8GoqpPU9/2D--
