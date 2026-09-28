Received: from mail-vs2-f39.google.com (mail-vs2-f39.google.com [74.125.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF9F4EFFD1
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625895; cv=none; b=hT5TPk6Ig6I6wTm+HPa6+Z1MimiRuHdp63jJMVT7wIrUKMCuevZY7fSR+e1jq0kToJh7Kis3LQHvvIV85NddbRTKw7e7Xc+1nQsZ3wIvcLVCw3coU0sPI717Wg8XuZO6hTH57nPGmRDMQkQB9HtROANpy0RhjvUAeF2zxAHear8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625895; c=relaxed/simple;
	bh=yOjENVJL9xvgiOOJZMpJM3ymYzl+LvTtKFkStasdIKg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmmSwWyRrq9Er3YWCbiiKbGlpjwiCFsVhYZaH0YLdRZk+s5M2fyD6pOY8ZOJqneIaH/p6V0L/3ZXKxdac/dC0OtsFyXRYpWM4K8wqgIO7wSlUggYtD9yUPiZ/w6v+PaD9Wf9ourC1iR1d0tFONbgVtxY+AUWcSHiDSRhAotCAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b=i/wUOJM7; arc=none smtp.client-ip=74.125.227.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20251104.gappssmtp.com header.i=@ndufresne-ca.20251104.gappssmtp.com header.b="i/wUOJM7"
Received: by mail-vs2-f39.google.com with SMTP id 71dfb90a1353d-5ccfbaf6da8so775720e0c.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20251104.gappssmtp.com; s=20251104; t=1790625892; x=1791230692; darn=vger.kernel.org;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MsoV87yeXr60fju+8hmD+26UoHO5BdrlIPPQdE/tZxM=;
        b=i/wUOJM7HfUw91DIKFxoHPEfHoJ94RT7y5jRa1pW1JJPKq5wHL3rBzoSCIrmc3zJmp
         j/buXGjGuA3YX9qU365iDDWyu7ogzdtKJ8llV9CsyOMKDdGVzndirwSg7HM4uWzpe1kx
         t/C2IuDTCqnxpDATaUTX1uaYLmvYt3yAG1+GSdzBSSM+nTX2Gv1UUg0TORcDdDTA6UfE
         zVDpgS5gftzITpRF1kAJgJ4vQdhwCzf52oSA1s+KDO+oof2Yj4YCd8ippusYr9IeQm6R
         pK1iIyRb/LiH1JYWD+G2CvfIwo8BWSl2rc99NS3YKNvgfVEwxYT+1eNVmpMKiwjCb2pm
         wZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625892; x=1791230692;
        h=mime-version:user-agent:content-type:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MsoV87yeXr60fju+8hmD+26UoHO5BdrlIPPQdE/tZxM=;
        b=B+WCsjvbs5Karux5tWWdN2lMcwpmlW9tT5zWyczgDcyiZc/gbJDJp1IYKRd/sJL6wF
         eOoZtLSmb3kXxqKcT2Rc0obHY6Y9CSHiVrI4EKr+MvcbyncFnsC75rSoKYgv0pI+f+3z
         cZVZnZkG3J2Nmgwgxrui25MXoW3B7ID1zUcjH5goyFxy0fi+O1HCx3Ot67XFUsJMBbyK
         hJGEdILzR8dGOF3Xo2Ia5JE1N3CtnVpPYdE8zH4IEJIjh5g7TNMxAe2RYmg7XyBaSomV
         OHhqaT79OOEHdoKHyn4qdDeEdvka7f1xJx3vAEu78u4aV26cfVKQNWk/rmB1/3LvTCLD
         6ldQ==
X-Forwarded-Encrypted: i=1; AKwUvBySzCDTL1qMVJGIOydALgQaGg1Jq+d5SiV+mBYXkDSxtNOMbliifsYBMiPHM3sjfm/nxKhr1uk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+N1WB37Y+ESS4W2XQ74wHLdST0QvCy4PvyIlJgZXVQ1cO8RsJ
	TpgOvL8/p4E0d6lKhu2wRhuMt6GzZBoXeBJLfJA5gHN8mo8Oo2uQjQ+wUTdmEFhoJSM=
X-Gm-Gg: AYBFou1+DXO3WDThI1xkzy0SjPaRvQq9p1uH06zKbrHiZI0mmzEj7xHjG1ZJnzZ8gAV
	KYKjmHMY6Pu/62yc6RGNralOyypC9Zsxfs1m89bPB5mJLtv/vQ7hnS/tVGsPcp1SSek0ymgd7K7
	Wi5pQcFqH5snQmujznSOU71w1Nmu5KOcE3rSBOys99rpIp8xa5ug46YPmXsUY0BE+LYBKp1Lo4C
	gv+DmZEPWlwoDYcrdRL7APUxRE/FmIpdKsrHHyVNj56A7QBrMK6CPTIP03HCpizz1ybUMsRMqtV
	3hXqHeibrlZ6fol7Z47e8ev3nhWZmIgFbkJBSGxqcDAJGitdghIkWaftBv2p0eSaQAeoC6Rsql7
	jjrykYJF12AkRWQQhEAePqgDI6fR6G83oXIQCHgsLZg0zxJhq137rcvx1PZE4XyZ1jnPO3a99aq
	A+hjisY1uao4uXYDhrXhrfrAjtqMdVQRuWT/GMJFXebpwrJK0K0gd8enjSYh7T8g7YrfByDKZnw
	9ptXA/sjChvaNxu1z1gtR4HZA==
X-Received: by 2002:a05:6123:106:b0:5bd:b0a7:47e7 with SMTP id 71dfb90a1353d-5d1dc4e9fdbmr234642e0c.3.1790625891994;
        Mon, 28 Sep 2026 13:04:51 -0700 (PDT)
Received: from ?IPv6:2606:6d00:11:34bd::5ac? ([2606:6d00:11:34bd::5ac])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cde6b43916sm10681078e0c.18.2026.09.28.13.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:04:51 -0700 (PDT)
Message-ID: <db09880c3815c13ad6203ca8afef639044fb1bf8.camel@ndufresne.ca>
Subject: Re: [PATCH] media: sti: delta: use unaligned accessors for MJPEG
 SOF fields
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Hugues Fruchet
	 <hugues.fruchet@foss.st.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jianhao Xu
	 <jianhao.xu@seu.edu.cn>
Date: Mon, 28 Sep 2026 16:04:50 -0400
In-Reply-To: <20260701150610.1243552-1-runyu.xiao@seu.edu.cn>
References: <20260701150610.1243552-1-runyu.xiao@seu.edu.cn>
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
	protocol="application/pgp-signature"; boundary="=-RH6M3QBp5Jj6STSoN0OK"
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-RH6M3QBp5Jj6STSoN0OK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mercredi 01 juillet 2026 =C3=A0 23:06 +0800, Runyu Xiao a =C3=A9crit=C2=
=A0:
> delta_mjpeg_read_header() scans a compressed MJPEG access unit byte by
> byte and passes the bytes after an SOF marker to delta_mjpeg_read_sof().
> The SOF parser then reads 16-bit big-endian fields directly from that
> byte stream.
>=20
> The SOF payload is not an aligned object. The marker scan can find the
> payload at any byte position, and the SOF layout also puts frame_height
> and frame_width after a one-byte sample_precision field. Those fields
> therefore sit at odd offsets within the payload even when the payload
> base happens to be 2-byte aligned.
>=20
> Avoid casting the byte stream to __be16 pointers and use
> get_unaligned_be16() for the SOF length, height, and width fields.
>=20
> This issue was detected by our static analysis tool and confirmed by
> manual audit. A focused UBSAN alignment validation of the same typed
> load shape reported a misaligned __be16 access in delta_mjpeg_read_sof().
>=20
> Fixes: 433ff5b4a29b ("[media] st-delta: add mjpeg support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Picked, ty

> ---
>  drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c b/driv=
ers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
> index 90e5b2f72c82..849a5e118aec 100644
> --- a/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
> +++ b/drivers/media/platform/st/sti/delta/delta-mjpeg-hdr.c
> @@ -4,6 +4,7 @@
>   * Author: Hugues Fruchet <hugues.fruchet@st.com> for STMicroelectronics=
.
>   */
> =20
> +#include <linux/unaligned.h>
>  #include "delta.h"
>  #include "delta-mjpeg.h"
> =20
> @@ -48,13 +49,13 @@ static int delta_mjpeg_read_sof(struct delta_ctx *pct=
x,
>  		goto err_no_more;
> =20
>  	memset(header, 0, sizeof(*header));
> -	header->length           =3D be16_to_cpu(*(__be16 *)(data + offset));
> +	header->length           =3D get_unaligned_be16(data + offset);
>  	offset +=3D sizeof(u16);
>  	header->sample_precision =3D *(u8 *)(data + offset);
>  	offset +=3D sizeof(u8);
> -	header->frame_height     =3D be16_to_cpu(*(__be16 *)(data + offset));
> +	header->frame_height     =3D get_unaligned_be16(data + offset);
>  	offset +=3D sizeof(u16);
> -	header->frame_width      =3D be16_to_cpu(*(__be16 *)(data + offset));
> +	header->frame_width      =3D get_unaligned_be16(data + offset);
>  	offset +=3D sizeof(u16);
>  	header->nb_of_components =3D *(u8 *)(data + offset);
>  	offset +=3D sizeof(u8);

--=-RH6M3QBp5Jj6STSoN0OK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCarrIYgAKCRDZQZRRKWBy
9CzTAP95C0c9jxi5tINcny8Wd9Z81XjKqRrpHAaP+s55ceh/7wD/dTeRXGcxrTi9
9qBwzyT6NAbjEaeg9NnMZPWd79ig+QM=
=BKPA
-----END PGP SIGNATURE-----

--=-RH6M3QBp5Jj6STSoN0OK--
