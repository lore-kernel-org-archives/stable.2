Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795739904;
	b=m1i0WOkvYToJRFrRGKC1ahLwY3X4eXDUVkMPL+lnl2KmSSK9leo0XaRNwUdKT3WC//kt
	 vs41CXaroa2fiY43d6u9A/Vcus+cg/iD6kRoy58pbq/GpsH3UG3i3RoB3Mlnl5ijDS3Kh
	 gKt8BOKX5gs+CoKMSIx3a8HAqwaXspgIz918gTn1/VI7MoSPg0htOBPP55kVixkyX6ouo
	 3rjH0jVzbC3jp9X/62CQzg2e81/5mXS6EvTCcRXHogxX07/TYXimljTxf7ionPN9vLXlc
	 RN4j3KSZa/6DTygqUjOC3KR9n1h8+JlozjSZ++BZu7P2w374Ca82u6GSoYopbiIpESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795739904;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=NSNeTFAHajnH3lsZhDsqezSosTqMwG/XUFvhuxmBbAM=;
	b=3iTv2a1d9Pd/PONpdmQ7ONxBXDcYiACXb5CPBxTnvgzjJzexNH+sXf8rJMCA7BTz+UFj
	 tPOzh59eYw+UZlSxlraCueO40dR1Pp/uMhVTUojkr2R5f4EBCpkgA57jeQd4/2BukPUfx
	 90f88lG165VnrT0g6mWraIL8G9MNIPLdzPDwQlDhWD/Z0ZBt6ZGSUcgHqshiUPcnn9+eW
	 quwwne8fho0aGxzP1pyCM7azTxy1vBj3fCb+yZl2x7o9uXyf1YMZ8pEwdpRoenYOo46jK
	 GazU4P1khCJxDxBbA5NASRnk2I5DJEOflA55f0oMCVx5mejWRyMoLyITSCWkF6XmlUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VQHsY1TW;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4770D606A31C;
	Fri, 27 Nov 2026 00:38:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4770D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=VQHsY1TW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795739902;
	bh=NSNeTFAHajnH3lsZhDsqezSosTqMwG/XUFvhuxmBbAM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VQHsY1TWAoWdpnxvBo3YGm409VVTESvzc8ndoiSDyPeDFFisnPM/e++4m9HRPhHX+
	 NpyN+BXu92+bMd2jZbUD7wSOVXwR+cpZfCqw21CC1tUMJNaTP6ZjZ0rK04/4u9y/5t
	 UCeR2Z06FJGv6v+HE3t/Y8VV4sj/naex25gH6hh4XXwlATOEDQkBAWMF8yBJEw0M8D
	 9t6AEDVgI4HPHGv+DuQVYCrYJvSQaI738Dz66tdjoySnENq9ATNovseRpaSFWnAEo7
	 6zmP0FPX4iPDX4EAhRERbywEmEVMXDLUvMBTYWuc9JbR5/nU9lq3heBNsmZxPV8HVf
	 CIP1NaqU+GENw==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DB8CE17E0CF4;
	Fri, 27 Nov 2026 01:38:20 +0100 (CET)
Message-ID: <cda5e670c88c79ff47651e182d1743bf5f90cd48.camel@collabora.com>
Subject: Re: [PATCH v2 2/9] media: chips-media: wave5: drop the
 consumed-byte tally on OUTPUT streamoff
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: "Jackson.lee" <jackson.lee@chipsnmedia.com>, mchehab@kernel.org, 
	hverkuil-cisco@xs4all.nl, bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lafley.kim@chipsnmedia.com, b-brnich@ti.com, hverkuil@xs4all.nl, 
	nas.chung@chipsnmedia.com, stable@vger.kernel.org
Date: Thu, 26 Nov 2026 19:38:19 -0500
In-Reply-To: <20261109052853.110-3-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
	 <20261109052853.110-3-jackson.lee@chipsnmedia.com>
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
	protocol="application/pgp-signature"; boundary="=-whAig/LySk3K4glCBC74"
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

--=-whAig/LySk3K4glCBC74
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lundi 09 novembre 2026 =C3=A0 14:28 +0900, Jackson.lee a =C3=A9crit=C2=
=A0:
> From: Jackson Lee <jackson.lee@chipsnmedia.com>
>=20
> remaining_consumed_bytes is never cleared. On a seek the OUTPUT buffers
> it accounts for are returned with VB2_BUF_STATE_ERROR, but the tally
> survives and is credited to the first buffers queued afterwards, which
> are then completed before the VPU has read them.
>=20
> Clear it where last_rd_ptr is already being rebased.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Cc: stable@vger.kernel.org
> Tested-by: Brandon Brnich <b-brnich@ti.com>
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

--=-whAig/LySk3K4glCBC74
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCawjQ+wAKCRDZQZRRKWBy
9MuPAQDgVdWNmyTh/c52113LTyyokfFYVkCxqYf1WMfKV4FW1gEAtb2jIbVTDEMy
01bzHuJ4cM2Xjuq2rpJqxd/wTUUHkg0=
=LRbP
-----END PGP SIGNATURE-----

--=-whAig/LySk3K4glCBC74--
