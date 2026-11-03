Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793696674;
	b=0HvVT2l5YzLnQzmkICf+MQjCP95RdHXKiHOtK0Nnwy7kxbwab+k7my1AN/nNAARGexa0
	 EXy/kn2WsN/1Sr/DOoypXPGAr99Bk+DlTSUR7I292NYuZoF3u3zD5xXqf8rcgmQPvs1RL
	 65I71xs6sETrneaKpa4Rpp6odtoprkiD5+D5SfnGllUQqoHgkUtHx9FuBLS4/yV/v3efX
	 wLLNNs34AzyB0DSij0ywQAl7aK671iA06101yB9aRwYhFEtqH2qeE1BDEBI4HrMuLIBfp
	 Atnd8H0O5uw0KbXa3puffcml2SRikVS+vO2q1RC5WibkzmywPaDkZOCczfSd8pd8fFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793696674;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Uyv+Mc5d9d1gCJCyssw8BshM15Hv025jfZyc5jx49Bo=;
	b=0nQlaSfCDUQaMwLjN9NJuQmLelGoIkV9FtLt8BEze2TBFKO6HnnGIeGODgBpQunzlGHv
	 PVNYLEWo1nkmxIGoPTH18fIT06s1JW4SDVCkOamuzQXeNxB+PMl0L5P0bzXOzooPDasOA
	 PMHGMU1V37aQ87nwIFU03mOC9uuNr9kWlGKQyOzCDjqkhUBGybbHhDggCh3wxYuGgGOAH
	 AhbkkCtUmlok01v277vQ6wv2qd1bsBowlGA3/8SO2p40cExAq3tvXaed26oNtxgtkvwhC
	 E9oESKopmLi/IIdu40BhpFf5RHg/9QYY3KI9N7Qob+AgfE7DY5ERYvQg/9gRWkv76nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=dRgz4HUv;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A967A606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A967A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=dRgz4HUv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=Uyv+
	Mc5d9d1gCJCyssw8BshM15Hv025jfZyc5jx49Bo=; b=dRgz4HUvWa1NktTmMP7G
	/lyCdZIMnsCBeSR9X7GPgUXYjS44XP1ojzhQbML2eqiAKTIJRvooKNiiKKFrQTxq
	XxrBMzJHHPTX9kcVsOvpf0ZR1QJwrONIdHGYDDSkMBeM/8jfn7zWxAl3oPZDenLW
	N3L3/zl8f+wGNpWx7rJclM7cBsSLBmriAGL5/XmT0NpNt1joO+bJ2C1lvUhJu6VO
	Qb4DIGZSRkMF+fy07btxTN5kl9I0hOh13FMCP7jsSBZkqqXX8vewmwP8+VkxRQ28
	yG2h/G6XQefREoLck4e/6dHNQRjEEADjI/l2W3QfBQREK2GDfgl40f3LAcw9I7Uq
	7w==
Received: (qmail 214200 invoked from network); 3 Nov 2026 10:04:22 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 3 Nov 2026 10:04:22 +0100
X-UD-Smtp-Session: l3s3148p1@I1NYjFtfbsI+ZpL9
Date: Tue, 3 Nov 2026 11:04:21 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: peda@lysator.liu.se, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] i2c: mux: demux-pinctrl: Release pinctrl handles on
 deactivation
Message-ID: <aumjke-mSGP8WVl1@shikoro>
References: <20261103082905.1167633-1-vulab@iscas.ac.cn>
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
	protocol="application/pgp-signature"; boundary="8CkNpLJWHo1/LwAO"
Content-Disposition: inline
In-Reply-To: <20261103082905.1167633-1-vulab@iscas.ac.cn>

--8CkNpLJWHo1/LwAO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026 at 08:29:05AM +0000, Wentao Liang wrote:
> Each master activation calls devm_pinctrl_get() against the parent I2C
> controller device. Switching or removing the demux only releases the
> adapter reference, so the pinctrl reference and its devres entry persist
> until the parent controller is removed. Repeated switches accumulate
> these entries. Activation failures after obtaining the handle retain it
> too.
>=20
> Use pinctrl_get() and keep the handle with the active channel. Release
> it when activation fails or the channel is deactivated, before dropping
> the parent adapter reference and reverting the device-tree changeset.
> Keep the no-pinctrl case working by storing NULL when get returns
> -ENODEV.
>=20
> Fixes: 50a5ba876908 ("i2c: mux: demux-pinctrl: add driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

To get a better picture, how did you test this?


--8CkNpLJWHo1/LwAO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmrpo5EACgkQFA3kzBSg
Kbad/A//WCwjjBQrxpHVXSeJWb+Xs49uCukN1xzEiEoagUqDhjukYpVsmstAY4lm
jzOEVsDQo5aN3U0uNOQU/o7RwkXREGj+9ZhjqcG5hHN0XsELI3XZXzNQQdd4Otf3
fkyZsuebaUAondP8tRBvQpJCqVuVkUU19Cr3be6b6UInimkzrmMxfNJNdQMDZeT9
83xsGz1ajtlYPBt6y0zJfpoyXlAcFtZ7J0QwnRlXQyr3l+voDSA6p3epj6pNpiFF
vj/ASfXXGmXNPopIzBEQwL4GG5qQZ7H/+o+w6dbaDfOBac2ZqZHbyVYDj0YeGIhi
z/3aCV6Vh3BXw7x5+2Zff7OYVRalL/80c153S9T0ZHWqsrOBZZR5zYRUK6afLl7V
wLI+P5MaOSvHSgriMD2tgXH1yzMTgk/GWF81IOcEptbbfz8sB0aeAjGFd2+lagEL
4jIFAMgmiqwQSdIrFjGhWj0nMzU0LAx9+Ofjkv2kVsuK+bJpKIMDKonbQbx4BDTn
f/NJdXnf584+kJnLxVSP4fCH9Z2Dn0KNPlPZd04jLVZmiwkFK46sqUf9QB9AWW8V
reflwo19HV9xtoakJ+dQkXSESXThAgw7THGAlbFmWXuSF5QkHtaYmV4iXlSRrnwH
LDK6vkUFsZXsgbePvP7Nsvxt7poFiY6/i/YE76n9wJ3ZVoXth2U=
=79Zl
-----END PGP SIGNATURE-----

--8CkNpLJWHo1/LwAO--
