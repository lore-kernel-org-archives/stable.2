Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632892;
	b=uWvJDaiVXr4rm3VOczR3YZmH4oIIxA5uloz0xqOH/YKp1UG0w8bxHgyRZzyX+Q+oQvW1
	 1b0oTyv08QBSoweuC4ExCuX9cU0JT4GzhJZb6X2BW9YnS519JqcbmVr3Ico0ujv9uXOFD
	 05wvorkH+/9K9PFHJAIDe3nVxk+P8YKEuYorh9t6so3zqZo5lGNixffEOvQd/YRFYVxjf
	 33wmI3XQg8pNbk06+7DFP1fwhvXms5YYMoMjWa0yU6n4lzAyxmJVFrPaIecjJ80BWS+FZ
	 mI8KA5SNvK/Bw01oEJkL6VCV7CNb4oPSFVXCdpRbfuF4JHfjNNnt5Zr3YzFLZCtnE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632892;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Autocrypt:Organization:Content-Type:
	 User-Agent:MIME-Version;
	bh=Ar1uWTj3IJ9tEnHxn97KponzoGGyMBUmz+xZ4dUR9+c=;
	b=MVbT/jKI8NX/m66Vw7g+JZ/iYT1VssQTRGHsLVr0WL08CRjWwLpNvPeG2jP8x4fbr2oz
	 Rmh5I0nphjOk2iUM2UX3W5xdpOjklk+pOU/QnO94cOzi9OIdksKKxuu4n3oZ1NsdcFZ/d
	 CWBSZHmFVH4sIiPy1NUqq7ET92VlCZHcsP5nI3/pRJIx6Frocx6QZ8dNMT3JS9Mo9VGpR
	 vbUogLIZUa/WGcOUvN5NnPGZWrS/CJ5nMu0yIHk1ed00F3xTIm38TzJzdCsg19EnG7Aia
	 4DSA9TRRDUKKQgtxUUV7K8ymSanjKHW3XigPDg+ZNvyXxhwSdYJonm21NsLBnyUywvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P6WLKQUF;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B76070C8B;
	Mon,  2 Nov 2026 15:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8B76070C8B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=P6WLKQUF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793632884;
	bh=Ar1uWTj3IJ9tEnHxn97KponzoGGyMBUmz+xZ4dUR9+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=P6WLKQUFiubdMDE0OEw1poZ6yEA4wkfMqqhvYPHCAAmlMNL+ctJOISpnAkne2oTKe
	 4AudCORZvnveIWShv5rOYfq1hG3s66mEc8ESXvREckIHK3RR6dxlnqpyrma43bfm6d
	 KgWGXnIRg1479oYEq82uad35CqqRXQZKyaHujEoUnwZX/anoqcxlAHyX6DOuyPIINz
	 /DZQr55svI9G9pmzFQfC3ruwNw+nPsW8cWVWe2dPVt+rHaRzx0GpEhtIz7lJqnVtzy
	 50X/ewlusJVTQxlE3uiR/DwkC+5l0zTjIdkzCPQ3mhxVksz9koofPR7/wFaGzR1ggi
	 SBPALVcGjeLSA==
Received: from [100.64.0.214] (unknown [100.64.0.214])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DCCA17E038E;
	Mon, 02 Nov 2026 16:21:22 +0100 (CET)
Message-ID: <8aafdbbf04a0d939c6b4d7d5577d97bb58d1c439.camel@collabora.com>
Subject: Re: [PATCH] media: rkvdec: Do not keep the clocks enabled from probe
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Igor Velkov <iav@iav.lv>, Detlev Casanova
 <detlev.casanova@collabora.com>,  Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, Mauro Carvalho Chehab	
 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Diederik de Haas	
 <diederik@cknow-tech.com>, Jonas Karlman <jonas@kwiboo.se>, Francesco
 Saverio Pavone <pavone.lawyer@gmail.com>, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, 	linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, 	stable@vger.kernel.org
Date: Mon, 02 Nov 2026 10:21:20 -0500
In-Reply-To: <20261030-rkvdec-runtime-pm-clocks-nicolas-reply-1@iav.lv>
References: <20261030-rkvdec-runtime-pm-clocks-v1-1-fb2c5b629e79@iav.lv>
	 <76e2e993fa5a8fd054bad97505907d3c4e88e11c.camel@collabora.com>
	 <20261030-rkvdec-runtime-pm-clocks-nicolas-reply-1@iav.lv>
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
	protocol="application/pgp-signature"; boundary="=-Hy9+b3DoQgbhz4pK6YIj"
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-Hy9+b3DoQgbhz4pK6YIj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le vendredi 30 octobre 2026 =C3=A0 20:05 +0200, Igor Velkov a =C3=A9crit=C2=
=A0:
> On Fri, 30 Oct 2026 08:49:03 -0400, Nicolas Dufresne wrote:
> > So if CONFIG_PM is not set, the initial resume will never occur, and fi=
rst mmio
> > access will likely hang the CPU. We need a clean pattern to handle this=
, and
> > perhaps review other similar drivers while at it.
>=20
> PM=3Dn only happens with COMPILE_TEST: ARCH_ROCKCHIP selects PM on arm64 =
and
> arm. rkvdec had the same gap until 6a846f7d72c7; rga and rkisp1 have it t=
oday.
> v2 keeps the clocks enabled from probe when PM is off, as etnaviv and v3d=
 do:
> https://lore.kernel.org/r/20261030-rkvdec-runtime-pm-clocks-v2-1-8ff510a2=
31de@iav.lv
> rga and rkisp1 as separate patches?

Thanks for v2, and yes, best to send0 independent patches per driver assumi=
ng
you have time to do so.

regards,
Nicolas

>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

--=-Hy9+b3DoQgbhz4pK6YIj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCauiqcAAKCRDZQZRRKWBy
9KSfAP9Nfn/3c2GIjb7SxlVxK+rFOQ/ctwy9o9h5pMp7BSlPvwEA8+Vc93Ax4Ube
2Xd1IZcCaTchUxJf8yNfTlcW8z70FA4=
=wPZr
-----END PGP SIGNATURE-----

--=-Hy9+b3DoQgbhz4pK6YIj--
