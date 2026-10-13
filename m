Received: from mail.bues.ch (bues.ch [116.203.120.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77968525A97;
	Tue, 13 Oct 2026 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.120.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912220; cv=none; b=Aw0q7u2eSejLo4yOiqB08XTZOPsMkhwwehiEAHpI6mv+SFzS1msAMLoYxJgol4ilLzpT9gH5AxzlGMDD+Sje4xmVEQFECLDi12tJIzUqzkfgIKIlFKClaEfHaa1yPqenXdeVfZHfc6FkVr/+mdwhbHToTWaHx4FkGAEkrTVsEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912220; c=relaxed/simple;
	bh=A/YI76f2RyrA7/hLcB14W6hV19Hnp2ZlmyAwRTM3yzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv9EktGlzZ+DyOC4scY6jXeas0m+WM9mFYA5UwGSO7tjC5REI2C/POK4lrxIITf/o2icSvzPuB4WSk2gQiIf8lV0xGz+bIbztiu5CRYIYvway2/IS7RPGTGprf334L3Ub/A6sdk3xAKxiCqYPBUgiQa23h9pFJhE0cN+RT+Zrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b=jfARWGMy; arc=none smtp.client-ip=116.203.120.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bues.ch header.i=@bues.ch header.b="jfARWGMy"
Date: Tue, 13 Oct 2026 19:16:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bues.ch; s=main;
	t=1791911850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d9g6jP4qEhtT1uBeR2i4sCcfvskcoKc3UCgUipUHDac=;
	b=jfARWGMyO3/9I1xZ3a3fKDwhPFIhvfdWSgUu/pKPzYVXxl51dNTSqJgM88jUtcWtPjp5dV
	VeEwjvlC1KJMJMLbVrPzDJfrDvTR7kP/xOAvugimAtLLSgloV5R9reI7zrik/fsC9rkcHb
	VS6s6g75gp+MnoeF/GYqX8JYCoyzTm9W4ChOFCTtCwSZZEBo5KVy4niPX1x8eBtdH/IePn
	YH4aCMTe485sfjHhuwh09q+Oy86NzCJi8xQ9FIiqtZLl53NjTbBQVsQ/tqe53kiupg/aS9
	dr8UZiOBfZpdlAXRHwpMCEfFLdGRs3Y8DxdbHm9CLobDrLo4F0ZAc39xd/ai5g==
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Andreas Wendleder <gonsolo@gmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
 linux-kernel@vger.kernel.org, johannes@sipsolutions.net,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: b43: fix use-after-free in b43_bcma_remove()
Message-ID: <20261013191631.3bd9e1e9@barney>
In-Reply-To: <20261013000124.48605-1-gonsolo@gmail.com>
References: <20261013000124.48605-1-gonsolo@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NXc4D1nqH6VOP7oBQwhClrB";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/NXc4D1nqH6VOP7oBQwhClrB
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 02:01:24 +0200
Andreas Wendleder <gonsolo@gmail.com> wrote:

> --- a/drivers/net/wireless/broadcom/b43/main.c
> +++ b/drivers/net/wireless/broadcom/b43/main.c
> @@ -5677,6 +5677,7 @@ static void b43_bcma_remove(struct bcma_device *cor=
e)
>  {
>  	struct b43_wldev *wldev =3D bcma_get_drvdata(core);
>  	struct b43_wl *wl =3D wldev->wl;
> +	struct b43_bus_dev *dev =3D wldev->dev;
> =20
>  	/* We must cancel any work here before unregistering from ieee80211,
>  	 * as the ieee80211 unreg will destroy the workqueue. */
> @@ -5691,14 +5692,14 @@ static void b43_bcma_remove(struct bcma_device *c=
ore)
>  		ieee80211_unregister_hw(wl->hw);
>  	}
> =20
> -	b43_one_core_detach(wldev->dev);
> +	b43_one_core_detach(dev);
> =20
>  	/* Unregister HW RNG driver */
>  	b43_rng_exit(wl);
> =20
>  	b43_leds_unregister(wl);
>  	ieee80211_free_hw(wl->hw);
> -	kfree(wldev->dev);
> +	kfree(dev);
>  }
> =20
>  static struct bcma_driver b43_bcma_driver =3D {

Reviewed-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/NXc4D1nqH6VOP7oBQwhClrB
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmrOZ28ACgkQ9TK+HZCN
iw6IdBAAqyTllSEWsIjkZbp2nGNOSl5JkyQWh2Id2BFGB9EKVAEJHvumWsraKdiA
HdMD4jp+smiu5mzva0jjwctzVfI2NnS3xExX/eeaPUVY9liWtU6wzV/nn5OG7uJ+
WWe8VjRs8+K65JF39rYpTSnnFuGLeqEX5psIpNL31w6PxalJlrdhCk1VKrOx3fzI
XTeC14I//1yxkDJRSTl8FLJS/2i76xmGtWCaKSTaSY+ZM4540AYR++TGJza4zEIr
IMr+fdXZLn+edr9SiRQeOqgTzIPE5iXeBIGOQ8UVT1wKSilO0vcsxRtrD36Rf5k1
rogSpx5brVtaugQZ7tZ2lKzx5gVm+5wyWpf9lGRKtkEhkOb+DfogAp7xlVV/h8Mc
z3J+h6U8/cYVw7H1imXd8Qa25SAAaNJE2JGbnpOoz2RFWBJWHGzhxSKs2sq4KFEH
OX6LcUzoD23cORbYiInLM9zIRXAaEP11i5eAI4hZiT9Q16TdeYiS1LzCkjilaM7n
YyOn6CYOAbdJCki/U5DpFsFFuDFZbFljA4Ab/dwfz13+2qFsIFPZ+wnJd1L6+971
oOKldm702D8KaDW6XYRY64U2nTSaNFgSY8lq+90yjGHTgE812vPkhcylPfNwUoGS
NfzlmON3PB1cBhf4j+Z48hxHYy2FH3+ehom16r/MYpZCO4PsoK8=
=elc1
-----END PGP SIGNATURE-----

--Sig_/NXc4D1nqH6VOP7oBQwhClrB--
