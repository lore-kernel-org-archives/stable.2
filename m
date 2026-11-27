Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740011;
	b=Ep0Yx/os+4R9E5nsPEhHW0jtUQtQpelpDq71upFVVmGilxXaR5iFbWaIuJV8xKWeLEyF
	 dqHdkYBPK36zeZU4TqYmGeVeiJlZ1aYKzkV09Esehqc0PDzoVmJyZZ3g17x5UpIpHaxdW
	 /qVQQomQXQK5qjkN1i7KpApraqewd8/KVYRFUaZss4pIWArtrxGBfHpTeKJvdZDPXcKFx
	 fFGuY0GED0zaH7CKYnaaoaHsrBQKKDVpGCF0BzN6MZ170Qeu+gkiLw0NeIj47+UZSJuRK
	 MDOtPm6vuqd0JH6/robUKPHdyUIT5GXeenx0OvRyL5NZF9j5RGQFyjpctb458sVTchw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740011;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=qDGcsI9cwSe1NCN9JUze8W39NbJXkrxxb93m0arv4GI=;
	b=5pcugKmTFehykojjTa4TSc1NliSIhBRadv0ajecTjXw6pEoXrRKRUUH7TBM4BaLfk6dq
	 U2jhM+n4jH3pNVp0PJVAzRuXBFFrW7n0QlP/JaEapsHoo4sMJZU+Plv0AGeka5ATrVLKd
	 mnfwptup6QchT5hWfZVO8cqe0ALfBQj6FSPDNtYy5XBJFBpxDd4EHdreILf0jBQ7d22EN
	 3zIqZFqn11NqA2+Vrn3yU27J3rA510Ey77/dEc7+HV35s8QzTWMT2Yd1aXVCSVx6SHV0h
	 7H7FTVoAKxs2xT2zC1ksSdXyIMIYhNXTrswnJmKDfqVdnP7crjA95jW/U0e90rpewuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="B/M1wagc";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D4606A31C;
	Fri, 27 Nov 2026 00:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=B/M1wagc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795740008;
	bh=0vibhXEZDr6Mf5zGGXS1k6O9dJ3qxJwNLHZX8asf4/w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=B/M1wagcbj/+KSFoYhEu1fSwxK1gpX/ttSgVYOFtDWV7g15O7M/eLjDpYyJxkYzrq
	 pYZW2Se/+u4pgt5CihCOtBKbGzaEEdmbRnBSqWGHGpwtwIpbGAFme8qwaIdQuHF9a1
	 uRrBugg+obM5KI+0xmAq5dCt+GZUTCdq3qqV6Y0/8kMGpW8/Nb9+1kPEv9b1blPa24
	 6pQpABo1lT4Nz6JRf+hC/M54sq2CeydMWpG7wsgQgj26FshIJCcDCCVbWt5Kaze+ta
	 oMFY4GQSgWLoGm+Zt65BlJRuOsfMSQ3AdaFYIqih+HiZH+G1JjUfNQsLbWQAcxxhG0
	 835NDddou+Ovw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 526C117E0CF4;
	Fri, 27 Nov 2026 01:40:07 +0100 (CET)
Message-ID: <0d3a53b6bb84695df113f6e512c5b77376baaa60.camel@collabora.com>
Subject: Re: [PATCH v2 3/9] media: chips-media: wave5: wait before retrying
 a refused flush
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 19:40:05 -0500
In-Reply-To: <20261109052853.110-4-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-4-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-yNbgW4nVzEb8X6C0Ebog"
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

--=-yNbgW4nVzEb8X6C0Ebog
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> wave5_vpu_flush_instance() repeats FLUSH until it is accepted but never
> waits between attempts, so the whole retry budget is spent in a few hundr=
ed
> microseconds - far less than a large frame takes to decode. A flush issue=
d
> while a picture is in flight is refused every time and gives up:
>=20
>   Flush of DECODER instance with id: 0 timed out!
>=20
> streamoff_output() then returns -ETIMEDOUT without resetting the ring
> buffer and the instance never decodes again.
>=20
> Sleep 1-2 ms between attempts, and only use dec_info when the call that
> filled it succeeded: otherwise index_frame_display would set a display fl=
ag
> on an arbitrary frame buffer. With a flushing seek every 500 ms the decod=
er
> stopped after 519 frames before this change and ran past 2072 with it.
>=20
> Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
> Fixes: a2c75e964e51 ("media: chips-media: wave5: Fix a hang after seeking=
")
> Cc: stable@vger.kernel.org
> Tested-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-yNbgW4nVzEb8X6C0Ebog
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjRZgAKCRDZQZRRKWBy
9KloAQC0Mvi30F7+DZEebvtSIRdH1MR5vmhIl235A1oNVat8bQEA+3a92T3xB+pj
TT7hD1KV0C/rkQ7JSZSTDaJv/2e/PQ4=
=taLU
-----END PGP SIGNATURE-----

--=-yNbgW4nVzEb8X6C0Ebog--
