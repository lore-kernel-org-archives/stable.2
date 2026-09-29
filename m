Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0359752B1F8;
	Tue, 29 Sep 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692811; cv=none; b=mt9t/fd3UOezss8wg2PEIqmNT34ivQVuktFIxQVDDVsYZ00FGHNZD44D6PMGuu/4GpZV0YtmTPfUskNVBqKRIVCx5roUVl54elVE7D4qM/oJSfImkRZaSNDSvEueSoQaDWQZuu/Mz5axUuRn06JsDmLZIexHxjMx0O24x3hprL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692811; c=relaxed/simple;
	bh=RseBDAPm9WJBaA9xPAOht0oHG8N8p4wSy6LBqjtIO1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnBhPqadOKBT6CZnVTvrQdSynx/4cMrp8iIfhZNKk6+/5QVpfcAms/TrOpH261+oyiC/xb8MFxmMUFR0TgyoJCC5BPWpywG+oO80HDkLXOxW2rkgvugUNxqDmuPjcnjb3YdbTBhbgWQ3E94eAV6NWYDv4qVJ9LcJv1JqUHf/yX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5yk8oY6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5yk8oY6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9691F000FF;
	Tue, 29 Sep 2026 14:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790692809;
	bh=RseBDAPm9WJBaA9xPAOht0oHG8N8p4wSy6LBqjtIO1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y5yk8oY6bXUEVL/xezuCmsHhsKSupQXB6VojJkTVy1sf1MiwI4EH0cDu55K99dNeS
	 N/a3378rwrgtZZvjoFmg+1bVoNt2pqtcj+Ssz8yTsNB7RcGjb7yoqxHV/m2s7HDLQq
	 bEtKyKiUOojjmRoFIXgJU51oqxN017W/HSITTkMJtFT9tSSxnf5Zis7sxGuZhTChf+
	 a02Fuk70zk/9mHPiZr2MMC95jNnD3/zpD1fnjxsXpNBX21XAI4p+SJCtmVFnyTxP6s
	 PrJK1pGgs1k42ILdV4R0fMaNScZOjyhUlE/QUeEsb2OFvUt40ENnAARMDofsW6Ps8i
	 abyS81L6whyaA==
Date: Tue, 29 Sep 2026 15:40:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Weibin Liu <liuwb@xiaopeng.com>
Cc: jth@kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] spi: ch341: handle transfers without a TX or RX buffer
Message-ID: <50aa0347-c729-436b-898f-7b6befcac9dc@sirena.org.uk>
References: <20260929081152.41753-1-liuwb@xiaopeng.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fhjYVmjfvW9SD6o4"
Content-Disposition: inline
In-Reply-To: <20260929081152.41753-1-liuwb@xiaopeng.com>
X-Cookie: 1 bulls, 3 cows.


--fhjYVmjfvW9SD6o4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 04:11:52PM +0800, Weibin Liu wrote:
> ch341_transfer_one() unconditionally copies from trans->tx_buf into the
> TX packet and hands trans->rx_buf to usb_bulk_msg() for the readback.
>=20
> The SPI core allows half-duplex transfers where either of the buffers
> is NULL, so a transfer without TX data crashes the kernel on the memcpy
> and a transfer without RX data makes usb_bulk_msg() store the received
> data at address 0.

=2E..

> Functionally verified in QEMU on x86_64: a CH341a adapter was emulated
> with gadgetfs + dummy_hcd (the emulated device echoes every SPI stream
> packet's payload back on the bulk IN endpoint). With this patch
> applied the probe completes, and tx-only, rx-only and full-duplex
> transfers issued through spidev succeed, with the full-duplex readback
> matching the sent payload, and without a splat. The emulator and the
> test program are local test tooling and are not part of this
> submission.

Are you sure the actual hardware supports half duplex and the fix isn't
to set _MUST_RX and _MUST_TX?

--fhjYVmjfvW9SD6o4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmq7zcQACgkQJNaLcl1U
h9CT4Qf9E2dBXoIBxFdG3E0wEQX6fzsSsAwWLNOly8H34dOPHdEv+qyLchnk8DHy
1G34WuhxxxXhRj3Zu8f6T2/anN3mLA98JwWuZGNDEB72luhipKkvY/ubkh4wO1Wu
wpaiDd3vFXxZyA+wDyXIWR5WMqxiUxCP1NT/NlOXveZesqa58O2Lb27vpVPzNaBa
Bypxf9zQJWjWYizUbQt5zcYZvCRt3JF/cRCfNYOGeEW0EeVFSdqa70AUm/3grcbZ
w6i75u2Ti5DVkALLI0Qir/m8HpxnlRIGQRHZi9PqXpbzD1McdnZ1450DaTJJ/zQe
ofVnThc6La9xsPg0yYmRbWmfqt9uWw==
=ou/z
-----END PGP SIGNATURE-----

--fhjYVmjfvW9SD6o4--
