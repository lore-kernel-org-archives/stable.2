Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795686415;
	b=TQmdlMkv56M52CJ+RLHEpzUNPTLlQTmJXj91c3h86DNWpznqIP2OhWZ0274MlH7+zLXp
	 mMfi6bGE9m4+QE5pXZRIo7aRZwxLajc+3sAubp0QieN0zjjWEzkoT8TDl5Ru56X4z1OK4
	 VURjFqbe4qNMHLf3fokeu7z8rljyKr1zCGAyn3jeOOhRhgbNXRmKAiw8f4nPpLOiCD6Rx
	 yXv2rNXvzmj2HysQfpM9TEl3Z/VHTzX0jJ3HxSjtiMziverTJAByuBpxsFhV50HW5g6a0
	 ZMIyOp1K1aTRMhrQfYvjI2L0S+2gXZ+Fu20s+jXjauv3Ve+wYJUlSEbHb5E7+j1B/fQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795686415;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=MC4h41uEDaIRngWv7swOFD5Ize0oaW8izgbEnRz8qLI=;
	b=EJS3AxNKHodN2OQwXGYzCJCKhMnAspf9x60EKy3tWQdVixjgXanoPdL0zaEtL/mW8/0c
	 GeZC7nIuF0afIqKkDcbYmU/Fb5gH+dFvGWjXHd4QhXGgcoXY3F8apMBwCgZOmpFdjGkZo
	 8VQ6AdUAh2nCotnJ+OenQIxu4Dp0AvDUU/+6KExBWQWUwdOwqKMiSj7udcT1epl+jcKHP
	 XXfUEIgmh9wkZVLoolKbjMYq+3YPiNV4Ilma+P2powRstXpQ+eurzcUuga8NKNvGg2QGo
	 Ip5cMvlTExndvUKhj01yRXCZ4/hgOjyVnWJUoFDKPuIjDU7+BKF8gZY0tWWElqPRSyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cFqsoP72;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE99606A329;
	Thu, 26 Nov 2026 09:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE99606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=cFqsoP72
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 806BA2007F9;
	Thu, 26 Nov 2026 10:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795686412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC4h41uEDaIRngWv7swOFD5Ize0oaW8izgbEnRz8qLI=;
	b=cFqsoP72y639fqeuayd6tCXH5ELLMc6vJ9jmyXioQt+WK4/ZIQ3itbc3CxGZYW0j9erMJa
	1P+jjBhG1losB54bIuYqBj01/iGkyH6xwQptFsBHB0+1h3vYmPszDM77CR66ZuOF/WnbV9
	t6a7OpUgBp60MWx3GC/eR48/yTZW++5X/67TMb2uZW1ClAKzp03XCk+MvLmvsE2cHUStqk
	+hiqHsnoUOKB2cbUa918NDv1d4wQ3gJqFetHjKB2o9eHOK9PiV6byqtpL95tUJMJ2/0r+M
	IVBihPR+QBJgbftUKMclvsGdX0xdGw8oXiP7aUZVOdtVm5KeOxauBh6gTFMBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795686412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MC4h41uEDaIRngWv7swOFD5Ize0oaW8izgbEnRz8qLI=;
	b=f8FqESZTwfikt108tJpMPFoYGVChEq+yv+BU9tYjf4lFGW34Cqyj8Qb5nchlfzAwucm69a
	i7mxXyFVT6d5DyGMkPt8x368eMBtD1k6FNTYlVeyUJv0Bv18TEyuluxMGJnX2vWx6WvHH+
	7Q9KtY9JVHMOqhpt6+BXSpTTL/AL8LM/fsCXmkOHOEaV78/we/XUkFmmgxF8XSjYYmj5/M
	kzb8ZPJ+9oW18YOAFBY41smeuc8qCSngcQyegu4k/7KGeKsptCJhco5hHrhFKOsYse3N1N
	XxDIpUtIHt3tLdfZgsMs0wuYBSZqPqb0reFsWOehVMyzPtvwnaPaXpoML4vbpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795686412; a=rsa-sha256;
	cv=none;
	b=arGxwUgv5R4kYSmyGvImS3qy0zI7qAS/Z5G7RTl0nmE5zO8W5s4yHeCA/l5OW6WARsS4ej
	LGCp7TD0xMqPfDSNKPgO0iAkQKOE0xeHZLWRsqZXMM2GmDQ0RIZF6MhnRzzwC2QWAyr8vU
	5QImmXm3pK8p4195Zsc3B21L0tZmpsH0yFLXaHeNr67Y+QiKUNn9wNviUm70dayJRRGI+v
	dizZpdknVZwzF4z2//lHHE/P1w7nqJOr6CDM4irSY34L4YGECFBFW42eBwOyrXt0K9OFUL
	I4CFI2P06SIbfpNf7EC3rb2ipFLbHyAdZfhKCJDVGgXzcxko4N365dPrYJAqWA==
Message-ID: <41ab851c110a3391f1e202a80ac3e0fed913f4b1.camel@pengutronix.de>
Subject: Re: [PATCH] media: coda: Release firmware if code buffer allocation
 fails
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Yige Jiang <yigejiang86@gmail.com>, Mauro Carvalho Chehab
	 <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Date: Thu, 26 Nov 2026 10:46:52 +0100
In-Reply-To: <rc-b1-20261126-vc-161-779570fc1703@gmail.com>
References: <rc-b1-20261126-vc-161-779570fc1703@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Do, 2026-11-26 at 13:21 +0800, Yige Jiang wrote:
> coda_fw_callback() owns the firmware passed to it by
> request_firmware_nowait(). It normally releases the firmware after copyin=
g
> it into the BIT processor's code buffer. If allocating that buffer fails,
> the callback jumps to put_pm and skips release_firmware(), leaking the
> firmware and its associated resources.
>=20
> Release the firmware before jumping to put_pm, which drops the runtime PM
> reference taken in coda_probe().
>=20
> An AI coding assistant helped identify the leak during review of static
> analysis results and helped draft the fix and commit message.
>=20
> Fixes: 186b250a0725 ("[media] media: coda: Add driver for Coda video code=
c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---
> Based on linux-next next-20261109 (630059a5a632).
> Compile-tested: arm64 coda-common.o with GCC 14.2 and W=3D1,
> CONFIG_COMPILE_TEST=3Dy, CONFIG_ARCH_MXC=3Dy and CONFIG_VIDEO_CODA=3Dm.
> The baseline and patched object builds both produced 0 warnings.
> No hardware or runtime test was performed.
> The path needs the coherent DMA allocation of the code buffer to fail in =
the async firmware callback (OOM or fault injection).
>=20
>  drivers/media/platform/chips-media/coda/coda-common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/coda/coda-common.c b/driv=
ers/media/platform/chips-media/coda/coda-common.c
> index 3fe33c4..ca8f953 100644
> --- a/drivers/media/platform/chips-media/coda/coda-common.c
> +++ b/drivers/media/platform/chips-media/coda/coda-common.c
> @@ -3004,8 +3004,10 @@ static void coda_fw_callback(const struct firmware=
 *fw, void *context)
>  	/* allocate auxiliary per-device code buffer for the BIT processor */
>  	ret =3D coda_alloc_aux_buf(dev, &dev->codebuf, fw->size, "codebuf",
>  				 dev->debugfs_root);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		release_firmware(fw);
>  		goto put_pm;
> +	}
> =20
>  	coda_copy_firmware(dev, fw->data, fw->size);
>  	release_firmware(fw);
>=20
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
