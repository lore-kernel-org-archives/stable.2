Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16821D6DB5
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 17:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114116; cv=none; b=WmiPVdsawzkii/Xe6oWs9QE6T2/wTRpftjIXVrgrHgIUEQ1NDn/jZYQVz824PI8nVIMkfuWzBxTsBix70m8a+2n7wZP8lJwQUf8D4AzSeEG6gC78r9IGw3fF4W5lWCDo0GjSmMTdRAJDYurtqHq0Ur4g+psZOq6JBXQIQTIY6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114116; c=relaxed/simple;
	bh=3FBv/EOGjeC0r39H/l8rvAlfT1jWGq5iy39JWbN5UhA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhCscvRRIrZaXskDA9Ro2o0a4OjFAOH5DKarFwmoUuQJLyr+B+bw4340YNKpJPzesJsvx81q1uVDXfQxVaaRcRLJDN9SBqfGbDcZgNroNz5G6trUHmMytoJLx3NPvVR4FIn7Kqdz8wSPBdioWKjMFanQL1arQxw+s+r0IMNH6ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=JBvTxIE3; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="JBvTxIE3"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-915aa0a9293so13935985a.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1781114113; x=1781718913; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TFzr6Ap8q6XOCl46PeL7Sqp+9/TMWSjPVAD+5M0vgVw=;
        b=JBvTxIE3XGk3vVPMH7Dt3U2BZAkpcceFDgS4rNeqtT+ZegZdCYH/4bn4zdfmI23A0W
         GcBhM1EhkLqTxC9B57meRh7KMJKq/PDQkPBq3TfdVxQrK8LyEzbPAHyVR0p0lxd5gfEd
         IMTPDqBtRLqgt/fZjUt+2fwcvAb4r/wrPg1EMsZxYJJ5YnkVjkYzutfQ4ngADrlJmiv2
         x8cGP3uKKK6vxfT54/3+F1PY/+nPtOcABwWKi7dZztFj9MKt0hUBcrsQWqwDKLut6BVt
         +vIVPGLUMGVs4nln/Z9RIQTzGiBWstJPa/YDgUUKLcHshWhEWZJWMou4gVduunKyrMg6
         /+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781114113; x=1781718913;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFzr6Ap8q6XOCl46PeL7Sqp+9/TMWSjPVAD+5M0vgVw=;
        b=qrDf9DRzgCppYo39PnGWbKvgV3H3ibRutk+oHXIjSMuL3RlYN4IMcgChcgMtIgrT7c
         8QVagCt+UabN48kkdxzKYs1dDqZoNmGaBQh7lnfuFV5sWqOtyDOufaAcfSnUMUpUsr2k
         eP4pH8/44d+c6NplaOuA7Qbjk/2W0fD+n/ZRs8k4KK+2tcWT0WplCA3dpqJqzd0EaX2o
         9ArU1zqc7l93oH10XHPx9iMA1flxiYLSqtW/8ivpgB8k8m4401kYvbQfqhdM16gaiyuI
         8QRv2i7koJJbNBKgKSL/49d82YPWjvw/LweYJ932QpXT+qgsyw4hqzAdOeozl+xP6+IK
         8uHg==
X-Forwarded-Encrypted: i=1; AFNElJ8FnMz4kX5rS+FwtISe+RrivhP6vIj4wInRd5r/933WJ3TPF4JqSjRgFA75372edBt4o3A0CwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkCARnjrcymJEtUn3Z3BIQ8OqcmyBzxVzBWUJws252H9xPCCeg
	QXi9iB04Sxv2y8gOpg5PgiCb8LIWAvweCiVFgmeQxYzuAZ+XY9uaGUGNvmityhB/bDk=
X-Gm-Gg: Acq92OHa3CXOOvbdHok9I86SgCPwbt6my3rmrXwjgnrwAqCfljAeITxhMxFw6Yig4SH
	MG5RAN61SW6Fj11IwtNRGXy2hkM7skI/8JmN89rNeWnxyuJXGiRPw8y0Au31k0yiAYQW/asXPj0
	BEotad/ljJ2lYKnTi+JHcHsOKl0iZ2MS03iy9bkqxwNxlRktde9MxbmNisaMPv8dIs3M9O19D7M
	x/+uurDSmyFtROVElxJJXguXzD9yWlPnhu0SXlQH8sR2i39yYvlw1JGog9YD14IRASWkGmgmQYj
	dXSqxnpokG9/DkLBguJcy6v89v+wWara5kEYsuiJGK7mB2HG32kF1U1mZjNAq+rvFKyvZMLw18d
	xezpwqt4xPE5ZVZCf49Z6OBxM9Y1fBOEztNPa28SCT1V6NM4JLEwjhjctAmiiWw4msejIgahXnN
	ODPxCtZmz8VBP7WAPg348AWFKvxLWJ8XnyGPPPhoDNghTaXvSkKsOsqr47CjhDT5cPdpxoaJ5jP
	yk7efE=
X-Received: by 2002:a05:620a:4625:b0:913:dcd2:f117 with SMTP id af79cd13be357-915ad2f40aamr3123760185a.24.1781114112689;
        Wed, 10 Jun 2026 10:55:12 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:e06b:3a7c:76ff:fea1:2ac0? ([2606:6d00:15:e06b:3a7c:76ff:fea1:2ac0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a21f871sm2515222585a.12.2026.06.10.10.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 10:55:11 -0700 (PDT)
Message-ID: <0e3b9cdb9d8bd692290dfabafb32d7faa5bd50f8.camel@ndufresne.ca>
Subject: Re: [PATCH v6 1/2] accel/rocket: Fix error path handling in
 rocket_job_run()
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: ZhaoJinming <zhaojinming@uniontech.com>, Tomeu Vizoso
	 <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Christian
 =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	stable@vger.kernel.org
Date: Wed, 10 Jun 2026 13:55:09 -0400
In-Reply-To: <20260610071045.3414828-1-zhaojinming@uniontech.com>
References: <20260610061915.1CA281F00893@smtp.kernel.org>
	 <20260610071045.3414828-1-zhaojinming@uniontech.com>
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
	protocol="application/pgp-signature"; boundary="=-Xq/WDBnnQBcMXRcBkujo"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-Xq/WDBnnQBcMXRcBkujo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 10 juin 2026 =C3=A0 15:10 +0800, ZhaoJinming a =C3=A9crit=C2=A0=
:
> In rocket_job_run(), after taking an extra fence reference for
> job->done_fence via dma_fence_get(), the error paths have three bugs:
>=20
> - The dma_fence reference held by job->done_fence is never released,
> =C2=A0 causing a reference leak.
> - pm_runtime_get_sync() increments the usage counter even on failure,
> =C2=A0 but the error path does not decrement it, leaking the runtime PM
> =C2=A0 reference and preventing the NPU from suspending.
> - A valid but unsignaled fence is returned to the DRM scheduler,
> =C2=A0 which triggers WARN("Fence ... released with pending signals!")
> =C2=A0 when the scheduler drops its reference.
>=20
> Fix by replacing pm_runtime_get_sync() with pm_runtime_resume_and_get()
> which auto-balances the usage counter on failure, releasing both fence
> references on error, and returning ERR_PTR(ret) instead of the
> unsignaled fence.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 0810d5ad88a1 ("accel/rocket: Add job submission IOCTL")
> Signed-off-by: ZhaoJinming <zhaojinming@uniontech.com>
> ---

This is a lot of versions within the same day. You should slow down a littl=
e so
a human can provide a review, and also document the differences in this sec=
tion,
after the ---, or using a cover letter.

Nicolas

> =C2=A0drivers/accel/rocket/rocket_job.c | 19 ++++++++++++++-----
> =C2=A01 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/accel/rocket/rocket_job.c
> b/drivers/accel/rocket/rocket_job.c
> index ac51bff39833..e8a073e22ac2 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -310,13 +310,22 @@ static struct dma_fence *rocket_job_run(struct
> drm_sched_job *sched_job)
> =C2=A0		dma_fence_put(job->done_fence);
> =C2=A0	job->done_fence =3D dma_fence_get(fence);
> =C2=A0
> -	ret =3D pm_runtime_get_sync(core->dev);
> -	if (ret < 0)
> -		return fence;
> +	ret =3D pm_runtime_resume_and_get(core->dev);
> +	if (ret < 0) {
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
> =C2=A0
> =C2=A0	ret =3D iommu_attach_group(job->domain->domain, core->iommu_group)=
;
> -	if (ret < 0)
> -		return fence;
> +	if (ret < 0) {
> +		pm_runtime_put(core->dev);
> +		dma_fence_put(job->done_fence);
> +		job->done_fence =3D NULL;
> +		dma_fence_put(fence);
> +		return ERR_PTR(ret);
> +	}
> =C2=A0
> =C2=A0	scoped_guard(mutex, &core->job_lock) {
> =C2=A0		core->in_flight_job =3D job;

--=-Xq/WDBnnQBcMXRcBkujo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaimk/QAKCRDZQZRRKWBy
9GXRAQCaqFjOga0b8AcWUWyj7n1hBiojgtP5sEJWopdr9ZDLTQD6A7XpFDMgyJa4
NJEu5ngUhgE6hDlNbS+w6OnOyC7oRQI=
=G0Lr
-----END PGP SIGNATURE-----

--=-Xq/WDBnnQBcMXRcBkujo--
