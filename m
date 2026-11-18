Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031370;
	b=Rrx4kBLl8ofKsWaTzeM8XTKi6XmVb8HCbdWc+1VVrTnmj683U4Bc//CUkNlmuKvum/vE
	 fmNrLk8qnLHK+V+5B7JiLYdYkUrdYbni2MBTn1nWkH7uaWWnJ8FnrnDS50LAJFiHeKhQw
	 lJ9MV7Zt1x4n0Y5LLmqA42vEc6ku3scpiIzu16fjNVfdYsnWGZ2VlqR1eW+LtDJGdAanw
	 ge8xZmrPborRvveEBi7eDfPIl9V6qHLn7lZvd/DmEt0zScbd2VMOKyZa5UCn2MTkie0Dk
	 ACrJ9rMAF2i/U0BzqTPDTctvqPExJZqEK6RppSx2agBme7MM6L8CHNqnlOxSuOUZWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=begQ9EMChlypyub//lxO47pq8KY9nrGwe5BuP1Bsh/I=;
	b=OoffuSEIliHYEvjqEmDC8VcS+u7O2RE5e0izsHjbKUNWY810kLs1kcXdf9t/ekWHCnUi
	 RxW+xQa/8/rLhU8DkDjsZkm2L3QeSHS5v3Vq07MEiWCfAbuyiX4QT6qeJL18eRcVvAOwL
	 Bow2toDN3p3W5GKZsZ4lJzZEYDyzHwhRtO851dFYUGKhckTWMAsn7nMRYSGRYrrvdvzOb
	 fd4BoFjtCAhk8jEz/GlB//MEOv/3JgQh+DCUUrQrrfBbZTlTy80vmjrFNy77gtnvDClH3
	 WAEFqsjk1KmMrsBxJpDJIrgIgKC7kYz46hgNUb2Aa9gQtzpSVDCYE/K6bDp1tw1oHWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=chromium.org;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pOPRD+JY;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB20606A332
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 19:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECB20606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pOPRD+JY
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc751eddf25so1128369a12.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795031369; x=1795636169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=begQ9EMChlypyub//lxO47pq8KY9nrGwe5BuP1Bsh/I=;
        b=pOPRD+JYIRGb+YJnsxHVLvoe689lNK/6EBCmEEAIjFWPYMvgT5x6zL8DqMbEzS0k9h
         ytC+KaJHZLC8/wbYqTxiihwCj2lP4eu+XWy03hHS2x+34xYiFpV0zkRsLrCTR0LJIlc0
         4QFi0sOkVH8qJZCIqi6nH12HxQz3q3wdC/+qS1YrYsN7Vf0lZ3P3YrlpnM1S6yDustMZ
         baRcfizOT2kchZJJlK6qJ4bEe1yQE96gLqc2kppP8KOcczrwPVIB55PmdJ0rCPqkTqKh
         wbVP7YDYOT7rrCuWIQfUtPspmd7lxicyzG6O5NNVfe71LRkElGJckOvpt+SQSf0M2EpT
         mp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031369; x=1795636169;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=begQ9EMChlypyub//lxO47pq8KY9nrGwe5BuP1Bsh/I=;
        b=ucnaoEL7sPqIG3lNoX2SD5ROebPPKJw+r991UZuI6qr5ycROom29kmtel7G1/1sxdD
         JguZLJ1EO2jWOKDRMSb5DrlChmkO2xx6ltq/sQSPsXf3zsdJ1k6lxDcOx0zWHVha3J+5
         IGvvgaFHgB/dW0aUgY/Gf4HvD0Ba4BVYLXurXtksRT4jy6b1RfvlxICXgUqEzDtPyES9
         D+XTmDV8Hx4WTJw/oLzrmtTVj6fMJ8wT32MbBRz52YJFafJvxQ3dnzoX6aUhu3Q6+xHN
         qRrVz9ZHSkTGGmkxAC1GIwU+2v6QL7KSaIuRCxDNKy+lZtOsF1ylsV9aNqxVWUmFjHZ4
         EQlA==
X-Forwarded-Encrypted: i=1; AL+hErEAK/EOpvkppFDaj3hmhQioUWCTpbSioY/tlKMwDHYTc8f4PPavp68tC550O3cbDt5dWf4EASg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xTDFgyYZai1ObQUe+MztbK5j0g9NbWaVUDVOED1Xd343hGRSq
	FxGsvxsdBgOL/8NC9PhET/sZS6aFrNbR8+573XZvK011x0Z4gQIWKx3lxoSKTNXJkw==
X-Gm-Gg: AYBFou2SODMIgHwOMjszOolhGM3Ptx3fMqvG12M9iLMxDGXFKHtDPxms2MvH3cXIM+m
	3zG8Jjnbfl59QIZFGByg7/UEbohMKtB2MrbtxZsbRaKlMYY6vNeLa++bUPp847ImpJj8H8qt7Dn
	tb2quikXedhs/rNHobcU/s0qODcF4XYee/rs7iD9Y4QF6S8vlyPc6ksHNXjYbuq9G4oTWc57u7l
	tdwfeCxIyDU+Pcg+I7gLMc8Zp+c9mTUcIZPSC/EGi/p1nCl+T/HbhW3A7KKgOYUrTA6eLg/LknZ
	OqkSYTybriwGoMiOcUmZmwz8APZnJBsXWTUdnpNCovs+Z18DJOFvG1Jo1zPnUnrLdtLUWcdMUq2
	DnShbshVuWOyLDMwYdNzgYuGTY5+DuaIg6gtKEvMqDofRN6M5IS10x1atOQPkKpRB4uQVHX9KXJ
	p8FO2pGq4PM+stMJVAAUuhgb+zV+KRdQK5GLRmejEXAWctm9edN9nVi4+OpVC6EJg1oyJ+37pC3
	jgQwGWpY9XllD6cXJRAV2J7BrBW6zE/csZJgsSNv78Ojj0B+7D2y/IHBBRFcEBqkCjMePmACtHh
	bDIZ+bXArqzTp9jan3EISSlKC3DuGSrGCYHkOuq+yPKTyk+5Sp8ZsfDIiLMoTfAQw98slLHyAG2
	zGbmT9OVE8mdMtr0MlsxqsexgN+Xr+yus2qaCa1aVwYZxj2c5FGzQHWon1MvyuRmc/g6GV4ZMaX
	JNWtvOQaYpjn1y
X-Received: by 2002:a05:6a21:7111:b0:3e2:9f41:9f63 with SMTP id adf61e73a8af0-3fe86fcbc67mr4347212637.1.1795031368444;
        Wed, 18 Nov 2026 11:49:28 -0800 (PST)
Received: from google.com (196.126.197.35.bc.googleusercontent.com. [35.197.126.196])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c5ca7aa28esm1692268b3a.17.2026.11.18.11.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:49:27 -0800 (PST)
Sender: Benson Leung <bleung@google.com>
Date: Wed, 18 Nov 2026 11:49:24 -0800
From: Benson Leung <bleung@chromium.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: wilco_ec: Reject out-of-bounds property
 length
Message-ID: <av4BREfkXS_6DWkY@google.com>
References: <20261118101555.3467162-1-maoyixie.tju@gmail.com>
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
	protocol="application/pgp-signature"; boundary="0+/jFHw+uzl8JT2D"
Content-Disposition: inline
In-Reply-To: <20261118101555.3467162-1-maoyixie.tju@gmail.com>


--0+/jFHw+uzl8JT2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maoyi,


On Wed, Nov 18, 2026 at 06:15:55PM +0800, Maoyi Xie wrote:
> wilco_ec_get_property() copies rs.length bytes from rs.data into
> prop_msg->data without checking rs.length, which comes from the EC.
> Both buffers hold WILCO_EC_PROPERTY_MAX_SIZE (4) bytes, so a larger
> length reads past rs on the stack and writes past the caller's message.
>=20
> Return -EBADMSG for such a length, as the file does for other bad
> responses.
>=20
> Found with a CodeQL-based static analysis tool that we are developing.
> I used an LLM to help write this patch and a userspace harness. The
> harness runs the unmodified properties.c against a model of the EC
> under AddressSanitizer. It reports the copy for lengths 5 to 255, and
> nothing with this patch. Not tested on hardware, only compile-tested
> with W=3D1.
>=20
> Fixes: 0c0b7ea23aed ("platform/chrome: wilco_ec: Add property helper libr=
ary")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>A

Reviewed-by: Benson Leung <bleung@chromium.org>

Thanks,
Benson

> ---
>  drivers/platform/chrome/wilco_ec/properties.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/plat=
form/chrome/wilco_ec/properties.c
> index 9951c8db04da065..4ca7e874804c28e 100644
> --- a/drivers/platform/chrome/wilco_ec/properties.c
> +++ b/drivers/platform/chrome/wilco_ec/properties.c
> @@ -70,6 +70,8 @@ int wilco_ec_get_property(struct wilco_ec_device *ec,
>  	ret =3D send_property_msg(ec, &rq, &rs);
>  	if (ret < 0)
>  		return ret;
> +	if (rs.length > WILCO_EC_PROPERTY_MAX_SIZE)
> +		return -EBADMSG;
> =20
>  	prop_msg->length =3D rs.length;
>  	memcpy(prop_msg->data, rs.data, rs.length);
>=20
> base-commit: 7e1392a42ea288d70a266f6553fe06f57f8647ea
> --=20
> 2.34.1
>=20

--0+/jFHw+uzl8JT2D
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCav4BRAAKCRBzbaomhzOw
wlEkAP0YtE3meJcfIV7SsU4KrV51INSVwLD3S2Ab1AIQPT0mUwEA1r1aiWdk5IZW
rKBNkqBRXuxitQ00OlnfA9TFU5KdbQw=
=LwpG
-----END PGP SIGNATURE-----

--0+/jFHw+uzl8JT2D--
