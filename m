Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795740856;
	b=4fA1puS/qsym6RmrEPVCRSh3q4dU4GSoxrzTZpT4DMajCokIh9G9e2o6XksYP+YLA9nw
	 J8mdyksShRs2iRcYgNcqfiIkzmXYmleqhq90pM7INX9T6O8D9CuupvZDYgSs1s3FkW0KE
	 xakD3BonHuGn7OuLshf103pjdzsLjJOpzZn8M2buOc4w7Fs6qLDaqj9UCABOPlvSGWTVi
	 Z76uldhrB7v+KzoevGqw6J+iK1xW8xs6Mx7H1K+y5q9cIAeJxkCkcNgdPoT9zowA/vAW4
	 kLp5GxNgHV01pVj57AJiFWKHO2j2GIy5wTlAqIobVAnBksFhWGOvv+LxGJdXH77E0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795740856;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=nSGdVhd2ZiTBtmXtGjLSgMbCST5by9CvVRzOAxDbcww=;
	b=PTWxv6ZuFueD1TSIa7+aujEutRbQf2b2dHjUiDbaaTfqIU2ahacN0ZEO6LydT1gzenNI
	 AFlSHsMoNFZ0iVlxPWRQmZMqWhGzpF4m2HUhM2ImRRWjrho6SFQGq/X4hfldzZGm4jMVr
	 PPb60qeLvZY0uEJ2c8dhrPDGdtdINeWuYCJMzCYOX9H4ipw8e8jugmbShqOT1mesAr1FN
	 RgSAFUwufWV23/CVyYvv5dERWfR4Kt1ikkE6zEkTMtDrfON63tHc/DzVwxlqMYAUnYJMH
	 2RRm/3F3rWfMYYJE65dfQHQdAY0I6AB0rWYN3jDHRw9s67/AxqzjszFpiUe2wlSJs1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="JRlrS2/3";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D9A606A31C;
	Fri, 27 Nov 2026 00:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=JRlrS2/3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795740854;
	bh=nSGdVhd2ZiTBtmXtGjLSgMbCST5by9CvVRzOAxDbcww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=JRlrS2/3ChBdrYhROYpQujwD2OGt63Nb+mjYEuPr/SAyKSUeMhVtVs0tL3tM01otY
	 mOM/5nzxR8zOKR1FLRHNNFlhAbMsxpg+dkvnWy7CF2oMSqWlOe1SUz48WDwHxT4v+0
	 te5E30givQVI+WE3Kw8KFhMFLXM+jgQkRN62rTlUdly/mvSKP1MJfLsK+HJ8UNkbAp
	 g993iINvlRq+RXOntKCGcWHwkD/R13lS2K2s//3XgFHBYTpP9XnG2SQlSeEcf4z7JR
	 z9fcoqnJhrCNuYKoIWwKdd4ZiGqTRNHrnuGSqU+Am/ACw462880HKJTYgGKjCq9J7z
	 Gw+w/HCMwpA7A==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AED6317E05F2;
	Fri, 27 Nov 2026 01:54:12 +0100 (CET)
Message-ID: <cdaa64c5c6aab0852670a15513e95baae42174c3.camel@collabora.com>
Subject: Re: [PATCH v2 4/9] media: chips-media: wave5: ack the interrupt
 after dispatching it
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 19:54:10 -0500
In-Reply-To: <20261109052853.110-5-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-5-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-4TLiSzZFoUFbhOqy1bE6"
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

--=-4TLiSzZFoUFbhOqy1bE6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> W5_RET_QUEUE_CMD_DONE_INST is written by both the driver and the VPU:
> the VPU sets the bit of every instance whose command completed, and the
> driver clears the bits it has consumed. The driver does that as a
> read-modify-write over a snapshot taken at the top of the handler, so
> any bit the VPU adds in between is erased.
>=20
> The firmware does not update that register, for any reason, until the
> host acknowledges the interrupt through W5_VPU_VINT_REASON_CLR and
> W5_VPU_VINT_CLEAR, so leaving the interrupt unacknowledged for the whole
> dispatch is what keeps the register still. Acknowledging first opened
> the race instead: the firmware could rewrite the register, and the
> write-back then dropped the instance it had just added. That instance is
> never reported again -- its queue count stays non-zero and no further
> completion arrives, so it stops decoding for good while the others keep
> running.
>=20
> Move both acknowledge writes past the dispatch loop. The re-read of
> W5_VPU_VINT_REASON that tried to narrow the window is no longer needed.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Tested-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-4TLiSzZFoUFbhOqy1bE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjUsgAKCRDZQZRRKWBy
9LJeAQDmDznB2A8veFi8n6JaivMsugmoKDDGiulJ2G/S95NN4wD/RiSSPFR7Aj2h
m0z8jcXJdhO1GoL5+Iy+aogJN58JGAI=
=5Qw3
-----END PGP SIGNATURE-----

--=-4TLiSzZFoUFbhOqy1bE6--
