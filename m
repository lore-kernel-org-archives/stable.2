Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111904;
	b=kIkKUzrOi0GJPI1RGXh1rTKLPGL7Ri3iR5IoyJkcU7UOMoSVDWMOpe3M9TNQ4vCqjEEK
	 K3ZShwvLfu08E9IktB8KKWcWqkeb2NH2FZ0pSIb9oOKHHAjsO1M95ZUuM2SmH1MGt2qtM
	 uasETiS6uA5ohPyb1Ad1KKvgPVN2QETkTmZJzs6qGg5pJtkNyCZjv2kgKJKt2WMxQFbRe
	 XuEirw9RfkCBljr7TgNcTS1MOdWn+Gwyv1U3fueXKXwFOT9xBf84kf7xAERff0mwViEYt
	 TxZRmKohZC6M5Pi6zxZp4H+5IP0RgjggRVCrOq3C1cFANDCBpi40x4dsJ/JemPwj2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111904;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Cookie;
	bh=ur/spN6PuM7UWZdfsxyHoNK39X1gZEM2nN2N8gbYIUM=;
	b=NLLu3VMebyzTIlTWoW0jZNpuFEqLeuo42NMXqt2c64x1eJP7UTKs/H3zwsdJNeGAgkKt
	 RY35dWgUka8H0z8/1w0w4uULQBx2PuJB75rj2PafFAUq+WUx+rwmLVFLj/Wj1Rxh0RsrY
	 IFgj6B1dnDIlT4DY36lgeMlY8WQLwEinRJKZ4VVQxP4BmESV6mm7ehYKT1tHMe4FCwD9d
	 ufZ0eBBf6XSVQJl/xOoiegpZ7jkhUWTFyk/+MHYxLi+CFq9PWr5lNR4cfUXwHY1W4kGk4
	 3urZy010Lesk/mvqYJiSLEc7f1zqmj9oQwqVS6GFNt0ZMx64Ty9ShZ2ONQQ6vLgD83w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhgZOz8W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DD8606A31A;
	Tue, 27 Oct 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhgZOz8W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACA71F01825;
	Tue, 27 Oct 2026 14:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111903;
	bh=ur/spN6PuM7UWZdfsxyHoNK39X1gZEM2nN2N8gbYIUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZhgZOz8Wxwc1l7dzYtNUCauwSrruFgX1WoJBg0B/R263eTohADGbcHNmt7M5wwpLQ
	 uJ150X4EwvtECOv8iHwr5uSkDUVDKoxgHSA2TfemlZZhSkWDdhxM7tGmr1WGRlPXdB
	 LmbFR5CNLckQNWWFRBX2PV2UX9/wHwMhMAJplhCI9XrQULezuyhRpKvcfI/NAwod71
	 T0kCcAy/62pur7Cqt2235CHgOZw4VVZVogoP87hMIzOyRxDWf4GUbOqG/pds4WmRfx
	 AU/vWkWIrQUG4hj5ZDn6kW6WB1H0j9ihgDYxjyqjYif6PVU3oGfkQDzkx42Gday4u9
	 fL8wWJ9aB4WFg==
Date: Tue, 27 Oct 2026 14:38:19 +0000
From: Mark Brown <broonie@kernel.org>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
	stable@vger.kernel.org, tiwai@suse.com, perex@perex.cz
Subject: Re: [PATCH v2 0/3] ASoC: hdac_hda: Fix module unbind/bind via sysfs
Message-ID: <50974cb8-83d5-491a-9a2c-52400b633e5c@sirena.org.uk>
References: <20261027125448.11018-1-peter.ujfalusi@linux.intel.com>
 <5b1ffe72-2e96-41f9-8c9d-1cefdac89ba9@sirena.org.uk>
 <e86902e0-ac9e-463b-ad43-a41437e77a9e@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3jmQifo/dY5OE/sQ"
Content-Disposition: inline
In-Reply-To: <e86902e0-ac9e-463b-ad43-a41437e77a9e@linux.intel.com>
X-Cookie: You will be surrounded by luxury.


--3jmQifo/dY5OE/sQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 04:25:00PM +0200, P=E9ter Ujfalusi wrote:
> On 27/10/2026 15:34, Mark Brown wrote:

> > Please send an incremental change, I already put this into CI.

> I don't see them in for-7.4, for-linus or for-next branches, the
> followup should have a Fixes tag to be backported alongside this patch.

CI means I am testing them (and other stuff), I don't want to have to
redo all the testing for a rebase.

> I can use the same commit id on the other had for this as well:
> Fixes: c3ec8ac82105 ("ASoC: hdac_hda: fix memleak on module unload")

That's probably fine.

--3jmQifo/dY5OE/sQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmrgt1oACgkQJNaLcl1U
h9D60Af/ZQ+WnKlOs4CArCRxix+E04HIwIN68eXNtVlebWYQUAYq9Qc+MtLUIS7U
Ye98BPN07DBfCm7KDuTLVNop/USmnpHegiym9CzdEa3+rL1gnC96nXEcEttcy62H
ABQ3wPUBf2N/2athOmH8rBiqed6o3YAbvSnp+fBRc32qaCPJpyfxrhzgLSMWhLpW
8+sWlN0hKzeZOpRgaI0uBqrU7NJ0Y2LN3AI0/T8OV/HDeIVC4QRog4pAto6eqs3f
nhFCoGZFzkM1Txdkc84UXeHLAHsHCmscVyyiTB0SaeTQ5mxpMm7vCAm5R59XQfwC
ET3ONJJNft8oMlE6mtcicrGKD0ZlJA==
=Fkvi
-----END PGP SIGNATURE-----

--3jmQifo/dY5OE/sQ--
