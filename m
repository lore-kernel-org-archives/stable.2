Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B143DA2C;
	Tue,  8 Sep 2026 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864782; cv=none; b=aDfz+wnuiXeFgcASY44n8kkFZ6U5eg6VLCG0grI37PodsO7QWR3D0EGkbHMJKICeMb/mohc/RI+vd9Q3/6tZulv2oNM+JtviyPiOSvlvEREfY1NWag904QsyTV9yqYGZDb/PXVF09LFnJ3Xs7l6vUxnBuLddnik8TmrMfUM9is0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864782; c=relaxed/simple;
	bh=aoV1fH6ZTCW7LAfNKfuUHvS36wapbIrsxxRkUY+U2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BX5enclXXkMbK8fSGYsOYIXg4zKlpXX8p2QovGupbXx6Jo8nq9tirKE7q9ZFz+1kFh7Kj2e1iMNcl8z/vm+6ioN+cl4SSsvnEtng0lPeBKW35d5DTW7eS7X0Iok4IUpHlNOPwrtATEi5MK8Ubgv0fFzkB4xDSAtfio70dcxTFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=KAQsciz0; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="KAQsciz0"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1269811DBE5;
	Tue, 08 Sep 2026 12:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1788864765;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=Qm+/RmSsjqDSftrpb2Fdvmu04WuqU6msZ94XRN/Z0m0=;
	b=KAQsciz0rHTUA8g2LH0r0l+PxwVd9Htz9ANOG2gGJVJZmtPLPa2bnBukwX1wiICmjmEa8z
	zsb0cOQ7FfSFia/BTyCdiCrnX8FBXMNoGFyDywzBRXO+2ZehxB2wgID5Rx0tO053uHIYaX
	0a6aeOe/UaET4ztukUmw0D+G9/rG6v8GMKYRSkmFefCmPNNbudmjtIqdjWegFyVHEEa9qU
	ssQjW7bzENSxEpVkMMU4G1YfYDDOCFBiJvYSo18i/Z+q4joS/cwKlnTxThEnhW+5fMaA1/
	W5BfRqZxwdRHW2kYBDwvpRgFoBs3QqZNh/ln+x23Uqf1K/QmIJB3wIZwhlyYNA==
Date: Tue, 8 Sep 2026 12:52:41 +0200
From: Pavel Machek <pavel@nabladev.com>
To: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: yoshihiro.shimoda.uh@renesas.com, vkoul@kernel.org,
	neil.armstrong@linaro.org, geert+renesas@glider.be,
	magnus.damm@gmail.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org, Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH v5] phy: renesas: rcar-gen3-usb2: Avoid long delay in
 atomic context
Message-ID: <ap_o-T5GGMFGYZ4v@duo.ucw.cz>
References: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AG7eLZ6YP0P+pQxb"
Content-Disposition: inline
In-Reply-To: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>
X-Last-TLS-Session-Version: TLSv1.3


--AG7eLZ6YP0P+pQxb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> To address this, release the spin lock before sleeping for 20 ms as
> required by the HW manual and reacquire it afterwards. To avoid other
> threads entering the critical section and configuring the HW while the
> software is waiting for the OTG initialization to complete, introduce the
> otg_initializing variable alongside the otg_init_done wait
> queue. Any

This is quite complex. How is this solved in mainline?

> To avoid failures when multiple PHYs call struct
> phy_ops::rcar_gen3_phy_usb2_init() simultaneously, and the PHY responsible
> for initializing the OTG either fails or deinit quiqly and another PHY
> takes over the PHY init role), the code waiting for the
> channel->otg_init_done wait queue retries up to NUM_OF_PHYS times.

And more complexity.

Example of the code is quoted below, and we are returning EBUSY to
userspace if it tries to change role at the wrong time. Not great.

As far as I understand, the initialization on needs to be done
once. Instead of exposing /sys interfaces before hardware is ready,
and then doing complex dance when /sys is accessed, could we
initialize hardware in rcar_gen3_phy_usb2_probe or something?

Looking at the code:

        /* If current and new mode is the same, this returns the error */
        if (cur_mode =3D=3D new_mode)
                return -EINVAL;

this should probably just return success? (EINVAL is certainly wrong
error code here.)

Best regards,
								Pavel

> +++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
> @@ -392,26 +408,58 @@ static ssize_t role_store(struct device *dev, struc=
t device_attribute *attr,
>  	struct rcar_gen3_chan *ch =3D dev_get_drvdata(dev);
>  	bool is_b_device;
>  	enum phy_mode cur_mode, new_mode;
> +	int retries =3D NUM_OF_PHYS;
> +	unsigned long flags;
> +	int ret =3D -EIO;
> =20
> -	guard(spinlock_irqsave)(&ch->lock);
> +	spin_lock_irqsave(&ch->lock, flags);
> =20
> -	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
> -		return -EIO;
> +	if (!ch->is_otg_channel)
> +		goto unlock;
> +
> +	while (retries-- && ch->otg_initializing) {
> +		spin_unlock_irqrestore(&ch->lock, flags);
> +
> +		ret =3D wait_event_timeout(ch->otg_init_done, !ch->otg_initializing,
> +					 USB2_OTG_INIT_TIMEOUT);
> +		ret =3D ret ? 0 : -ETIMEDOUT;
> +		if (ret && !retries)
> +			goto exit;
> +
> +		spin_lock_irqsave(&ch->lock, flags);
> +	}
> +
> +	/* If another thread started a new initialization just return -EBUSY. */
> +	if (ch->otg_initializing) {
> +		ret =3D -EBUSY;
> +		goto unlock;
=2E..
> @@ -1007,6 +1226,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform=
_device *pdev)
>  		return ret;
> =20
>  	spin_lock_init(&channel->lock);
> +	init_waitqueue_head(&channel->otg_init_done);
>  	for (i =3D 0; i < NUM_OF_PHYS; i++) {
>  		channel->rphys[i].phy =3D devm_phy_create(dev, NULL,
>  							channel->phy_data->phy_usb2_ops);



--AG7eLZ6YP0P+pQxb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCap/o+QAKCRAw5/Bqldv6
8hBeAJ9DOdo6XuAz5OO4jIKpmONe8cgcKACeNVF5TPhlbIEtTN9b7mWO2f+b4IU=
=QxD/
-----END PGP SIGNATURE-----

--AG7eLZ6YP0P+pQxb--
