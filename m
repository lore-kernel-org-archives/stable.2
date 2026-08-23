Received: from sonic313-19.consmr.mail.gq1.yahoo.com (sonic313-19.consmr.mail.gq1.yahoo.com [98.137.65.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B031F98E
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 15:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.65.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787500648; cv=none; b=My1ZG8OJv1JxWvf8IIAnaseCyckX/3rtvXVv9TgsxWHg6C7EjKzfaczNptEQzHqpKNEhSFU/p5EKgAzrxOIUDCMPqodsWGzfbGGG5YV6wC+I0l93Fbc7xlo2AWSZvE0Ka6IhhfBa6m30p2tAv1I323ruftetfdzf/YNQLgMQer0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787500648; c=relaxed/simple;
	bh=Rr3ulybYIClx7oNby0GriWr7lYgaff0dUJuFqZnUaPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJqJVrUhegUuud0lef3kHJDTu5LKpK+NxnhWcytrl+DYSIFO8DtFbR9HtzYpmbzTTlaQvEc7NgkuphikHqFzrTkvPUAQckBtAPMkwaFpcKRxwPkOhhxGwY8QBwuG2SnmLhZcsNQzJ8s0EldFeij0KaRhDEf6LdPo9Mer6v0YDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=tHdjaqAI; arc=none smtp.client-ip=98.137.65.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="tHdjaqAI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1787500639; bh=aJCbQOI+nUkkPRLhWVnfKoHM5dUJDvQLmz9+EL+DjA8=; h=Subject:From:To:Cc:Date:In-Reply-To:References:From:Subject:Reply-To; b=tHdjaqAIdFk6nXLdAbbsiuGqyEBmfmjd9j5aWerDaSu6hvF995YfLjGWpAuPMZCP+1Q9m6kliNw0EkOQZDEujxaU5wRBd9LDC8twfGYR+cixBhIRqSF7AUHbXgLrlSId5F7Bm78rcwYk1UPa3Qzuu49mmR682hj4ucNcoy3slFmZLDNR1llrqXvSgfY1hRx4ir2Ax6737zaRPb9r9+OTjuFJ0K2yZprH4TQsd4drG9pZlTp/85YUjEVq6BddAvoKYScmgWy6PUZuLU0iue6sReeNbotc1vNs4oF7+T4hrxWnGkJSMux1VIIKi+GSXKkt4M6aIY71wv5ZjY/vqi8/eg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1787500639; bh=1CTKZOd9rRGsMTY2UrIFE46uqQgLCwwhRPpWqGbBLp1=; h=X-Sonic-MF:Subject:From:To:Date:From:Subject; b=X24H8K+XefJhEYUBxv6VOTHjXL0C/LGZYwKlx5jaFsS3H3c31RLQI0ybbS496R8VmgjInplO/qMr4ulTOJI6sByzTCJXMeY0+y/+gVpzOUQN4QXZb0HP2AEz1xZQfA+0OkpYtD1oBN5SeufUfPQ2XTypo3BYg8uVXlvGojsDmu5+aGeW67z8oclEuP8bG7iU+14vMKfsOYO6ljDbWSXDTKB0iIiatpLIXt4s4WsayR14W2eFfcXoMqNQFYITgOYMytCyuLTk635i4Qrwarcp2bkc3T38YDNorsvhFb2P5C+zQlsCHX7mDXNSyYLps9tt1VlD+01dGwtE1Nj0X2xydw==
X-YMail-OSG: 1VCkFdwVM1nJGnDzn_lZ2njzh5BG9jPFjroJiZmfOkx7CTBgNSGhwZL3ZmAmqWA
 jBZzaCVGZ8zQkdaRsJhPNe_D_B.zkAa52Fui5q2Po_CLZfr3QnM2VM.I2RHH3RDmEN8gkk8bUHdr
 QA3plxB_FTxC953C0KJF9cTmNvO6E03Ug3IlXimyf8EdLhWgh.G30uvWbqfiCPKCl7UE0t6lL9uc
 64fxLkK7MIdRDMpQBZdrKqxOqZARpk8cIYF8niSAX2a77nUslwVUx9xb5uopW4thsjf8gWKMxCzs
 HkbwurAHqTRDXRTat7XuN6_Xpa5oBcbB.Xww7wCo9wUjnldxJJ2aG2N6G7TYiwQhjzD4wAB.MYem
 4vinP7xae_DecwOjgOhr8WutzCT48TZ.YBJ6daT6pYMJm_yn.smt.n42l3Gv4yFj6k5Kgv.akPjZ
 xFB.W.Qo7YTPTtGQCYA_dBSQ05lPf5tZcF3h9UifH3QMZBoVadrpsX.nM9JQwSqpkJ3sxYswWu4J
 K4A2bhY4yAOGBHjBaijCDw0e.LAcGFVji0dPoRFytMzdoztFNHzD4hn8yDBW3vOI8Fo43pkHSRNd
 mTpv0CIBp3wF7M7SJp8bgKzfCgIdMRuS4L8ewT4nGrfBCpOaMDb_eDTF68f0oU0ej4PMn057Fylq
 mJ2ENryfCSID6j4STyrMpuIn9M4HCD1N3Zm6xksKaAhlcWOxmx3E_H9FNWC4EbAohKxdjgzEW4rZ
 ifXldup.y92A2cQt_RE1ggvMR3kIFBS1G2QrZf.T0q74Q44N6CQaFnY51Ly3cdUBgEa8Kvmm3np9
 mqb5P7zsdWPamiTPdB.upAhIX4PwHwkVyIFV2QRV0WxJIIi7OVqCO3eCAWpwWaZT7gh9b0pcmbV7
 LpCKBoy96lKoLhKn4lFMy7oYfrka8A55rxOEvsxzIOWUkfXBm3XIdtmd3WXEg07u5jC5gX9aByTb
 jZWN2mGHxPFQH4v94wcSURhO5lL7WI_VDtqrPySYTxzfaKd_eHESDbnlN7Cjn3FqghJNOpCkRZug
 rBQgLcZ.AFfaIeSC0kGjjOqpmVt9AiOW3OEoE8jh6vUIgF2isBQ3mqQa6r7S1_2F8lM6wwCICaJx
 0.2kZGPYPh97fCnogYVOdDhJPIH36KHTcys7J908RUv.ckvSy385450vb6uKma1plbNhqNHJrqJS
 eJ7oqoqx2A7EmBKvGtaal2wodQagZ1KjCL08fTLw8VTKIe4Z8hTRfe7g1yxbsDn_nbyBVZtpgq1R
 qAETkiAknzhB_JKH3oWrXDde3likeVV7QBeZh47sSP1TAUxwtHne8ST6geZdwIPOVe7OqV1FR2pS
 jOQsu_G5A9QPHPTinV_5j2.CK6nMOBU2rouPNzgs4tsNzCZiuDhNGKQvHRN7VdR8uecof74iIARP
 iCSTQsBCKmagt1lY2zAbVhPmzdqqXIQ9IedVKUoSy9BPIypex_o6uSloz20F8wpNLJ4D_14Gy1TW
 R0zZcJlTgDKfomxdLDp8JerJfElUKMvF70AxqmFoyWNYU0a4l8fVLLQhVKktxP2MX6w4zzR_0Mbn
 XjkfhRawYX6jFKXS1fqoTaDpHdQybr5I93MkdYz9mNG2gFT.P1iMBBvbhvtUCAtxf3xN.xK2EeB7
 iPqvtNWXxUsOo8WBPst6BBCCVKSxLYGh_T2YPJUePrkrtTC3zVqMx_V.OQngjefOfAktre3i7Mr1
 oc2EmgtOfo7.HMI2wmqqhOFY4aLJk8nQ4uPU3OysyGTiViFw6TOa0gyyCeR2nOQ1jBIVK1ddOq_l
 S3cY7gnNHL7p8jGKjpnk19RWu5v0uSYgMTyZZGIWOt1QWp5BiISUrDjJEnDBybH.MJ9logpYDbJO
 ZqpnK2PuQMux51FThukX5CvvxoYJa4htz8XfEbJ009NYpOKrPRdOcaNd5bYvGcYSv3fIbqZBXFKS
 cwPLIYUmBmolN7eEhSwujN9bpNICZxSgAoO3hEsaj7nB2._WMWO_yiSNg6eDq0x2KYVbeNop9VA8
 98YT6GMgviMxhRqQJNqXk4NjH3PKeCvviNaik7cpSpCSa2rymhVUe01fzEjcAURWBhbIvpPE_P4D
 P4J8p19_z211wrGtlhF0KK9tn943URBlxugkAMEu2lxWhuNZTJaV1ceqq7VeS09mgciN17CLO8Fb
 ktLvhatDXfa9TK_rOyRCqtX_PM.x1teJHsCRKQw1THyyR3TDjX8Ig3qc2rQFHrQAY0H5dhpdsvs.
 02bZuRCSfQ_CfQrhj_NE5QEQo1hWZ6Fwi2GkXfHvsD9hXIe2xBjJEv1KMQargTk1Z9Bkl
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: d76d79b6-889c-4d01-8b8d-6df7a1256884
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.gq1.yahoo.com with HTTP; Sun, 23 Aug 2026 15:57:19 +0000
Received: by hermes--production-ir2-cddf86dcf-sz4c5 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 77cc39f50424f07286c5071a250ec21d;
          Sun, 23 Aug 2026 15:57:13 +0000 (UTC)
Message-ID: <a75ea18f7321a9713d606699f7d80872259c13fd.camel@aol.com>
Subject: Re: [PATCH] drm/gud: validate TV mode names before creating enum
 property
From: Ruben Wauters <rubenru09@aol.com>
To: Tao Yu <tao1.yu@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org,
 syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
Date: Sun, 23 Aug 2026 16:57:06 +0100
In-Reply-To: <20260819072835.4074130-1-tao1.yu@intel.com>
References: <20260819072835.4074130-1-tao1.yu@intel.com>
Autocrypt: addr=rubenru09@aol.com; prefer-encrypt=mutual;
 keydata=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
 eIvzsqg==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-BzUdVZxOLMgepOh8mfzZ"
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: WebService/1.1.26380 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol


--=-BzUdVZxOLMgepOh8mfzZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-08-19 at 15:28 +0800, Tao Yu wrote:
> The GUD protocol returns TV mode names as fixed-size
> GUD_CONNECTOR_TV_MODE_NAME_LEN entries and requires each name to be
> NUL-terminated.
>=20
> gud_connector_add_tv_mode() currently passes each fixed-size entry
> directly to drm_mode_create_tv_properties_legacy(), which eventually
> reaches drm_property_add_enum() and strlen(). If a device returns an
> entry without a terminating NUL byte, strlen() reads past the end of
> the slot and can run beyond the allocated buffer, triggering an
> out-of-bounds read.
>=20
> Validate that each returned TV mode name contains a NUL terminator
> within its fixed-size slot before passing it to the DRM property code.
> If a malformed entry is found, reject the device response with -EIO.

Hello, Thank you for the patch. An earlier patch that fixes this issue
has been merged, however, this does look like a better fix of the
issue, so I will apply this one over the other one, as this does not
truncate the data.
>=20
> This fixes the out-of-bounds read without changing the handling of
> valid devices, and avoids silently truncating malformed protocol data.
>=20
> Reported-by: syzbot+9ae8e7884e451eaed5b4@syzkaller.appspotmail.com
> Fixes: 40e1a70b4aed ("drm: Add GUD USB Display driver")
> Signed-off-by: Tao Yu <tao1.yu@intel.com>
Reviewed-by: Ruben Wauters <rubenru09@aol.com>
> ---
>  drivers/gpu/drm/gud/gud_connector.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gu=
d_connector.c
> index ea0cca58b7c89..8141c3a1e30ad 100644
> --- a/drivers/gpu/drm/gud/gud_connector.c
> +++ b/drivers/gpu/drm/gud/gud_connector.c
> @@ -396,8 +396,16 @@ static int gud_connector_add_tv_mode(struct gud_devi=
ce *gdrm, struct drm_connect
>  	}
> =20
>  	num_modes =3D ret / GUD_CONNECTOR_TV_MODE_NAME_LEN;
> -	for (i =3D 0; i < num_modes; i++)
> -		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +	for (i =3D 0; i < num_modes; i++) {
> +		char *mode =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
> +
> +		if (!memchr(mode, '\0', GUD_CONNECTOR_TV_MODE_NAME_LEN)) {
> +			ret =3D -EIO;
> +			goto free;
> +		}
> +
> +		modes[i] =3D mode;
> +	}
> =20
>  	ret =3D drm_mode_create_tv_properties_legacy(connector->dev, num_modes,=
 modes);
>  free:

--=-BzUdVZxOLMgepOh8mfzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEE3obNNdPQ9V5CQi2Y0n5QwFCuDOEFAmqLGFMbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJENJ+UMBQrgzh+BUP/0D/2OlETvV/w/F4uVzl
/ctw4ilsscGIMXHPtRPoE/B3XF5qavJg0vpB2SvXRbwFCxZ7COfl369a/osuLFzy
K/iArRyMYxuQ0LY0kNRlI6hrHYy01L5Ovfpak+Y9OmcXzJhXFFZkv8NbsKGwR0DF
wRGbDyfgPwY8wghjBrAJMfm+0/U8f73iSydMUq3TMcbX3hMCf8Mquylf3k3Cxjzk
kzMOuK3u1fGsVdPz8JiwgOJorNLiL41b0DHIWrxpJMhoNCigXZZij690lNx7bpUU
VQIP9IAtIaDVwEy/1Ej51ekV2V2ECWeZNAwoj53ja01xOtb3AJ/9RhnZUJ9nkDYz
ZUw2KxvGn7KutUHVJIxL+lAiaq2SnA48srBSndBPAZUzMz9Qk951inwqThCd2uXO
LzeLP2BOCfDRd1x+cvhYL7w4G6+/FTBkLiqAdAJZpGzYXxd+sqh1E0iQ17eFR1Bv
vE9NAFC57Ae+vMZ0qbAK3KQmoxlAFqLDIsuGWI4MZLrY+eR/I+4nl4/PrNWlBSND
QshONgc8zdoBBPDyZUROYFVkZX97OKWkk+w7EIJ5EGzVvaspvgpwBu1zkLTKCLBE
DvtM8xMsQpZCDurpXX3ut21lJa7GifFrAohNCwX5iSYhaQeRfKmIuUuuik9iuOjq
TjhqT+/zIbC633DQlpOJA5g0
=+o1y
-----END PGP SIGNATURE-----

--=-BzUdVZxOLMgepOh8mfzZ--
