Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792657465;
	b=fmjPPek+PkIftReSolLt8beD2VBniF3GuWOyibo+oQfyGaaAxjWXnIpbdJoo3fooJKv+
	 g5sDCe2MQmedpxiDhPJhUursrcR1h9paQyWAK5I5sZSva9JlZviw0upwetkMUbiCwhCnU
	 zcYTt/3LAzIOnImoLK0J408CMfw9SxWaniLgNFSPLLgium4gji2hGjUEgYT7ISXh7t3Bt
	 TLCYj1MiByFoTYf1FFE6LhJNcR/JaAMxToBZggV8EGAHZ4BoTiDRBkeYr6JrLGt1VTcV7
	 AYOB4N7YILmdw2erG7DpffjMSL07487ktuJ9/reexTnSrE/AuqMrFa5Wh4CtyYpk+jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657465;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:
	 Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version;
	bh=+884JubjXlXMynukNsCRLxjX6Ct6GtLaA+gmpnTujNk=;
	b=cwPDS625VH4sTLe4VCAi2QR+ob68rJhuF3JVFlA7de4FYYx5wahb9qGhh03pZKDk1ZC0
	 esBSpxvg9dC+hAhY/qN1IIynPf7pu/ZPghFQKdhRucW/+8JMEeDkIIVGddr669hcBvL2k
	 BTcvQheXTo3KvL+zSSbyjx6RrVPrcHjJjUukHANtKG3jdr6qiRMXQu+9Ea0PYtZCce4jR
	 +tBCicAqTEUL5MUb3QxJTzcBgQj7KGpVPQcTGxH8Rtwb9gWZ2Jz2Dfg6fZKQe6393Th5P
	 hjYhebCQR4vLB+GtI/h2BwOX4AKvHa3B/enxl+ON920Oz5/Qg+5Xd2dhKYQFvacBJrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codeconstruct.com.au;
	spf=pass smtp.mailfrom=codeconstruct.com.au;
	dkim=pass header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I7ChGgiG;
	arc=none smtp.remote-ip=203.29.241.158
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9BC606A319;
	Thu, 22 Oct 2026 08:24:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9BC606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=I7ChGgiG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1792657460;
	bh=+884JubjXlXMynukNsCRLxjX6Ct6GtLaA+gmpnTujNk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I7ChGgiGN4jfCP+XXyck1s8WA/gUU8KScpvYXoTeVCb3y4ktOdcx+6BlQBzM6P6S0
	 APztRMSenw5GTaDz+ySOGBmK9bC+AGg/vL+oz4BRhYkMXGKs4hMpxu9UzDY+fERdc4
	 62SNIQvBZhwAaCbhwc93KLkOpL5/aQiUSeVHsq1+N95qWGd735sU2SM4QMG9Y+pdmk
	 rMLmPy6yocfQaoLg4y/EcUXxO12DguKtksZhJuB5DOzrh6WpNRnhgx8pqGtULykbBJ
	 ez6Li8HfEgScDbhzUJtYBgXhlvpsenxzWFWO+OlOAZp5X+LZdvUp72ouwwh9FMYbnl
	 2/mWKEQ3QipEQ==
Received: from [192.168.12.105] (unknown [144.6.157.237])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E24096C53B;
	Thu, 22 Oct 2026 16:24:19 +0800 (AWST)
Message-ID: <f8c47a860a37c36221a62f1afb0593bbd82e3501.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] mctp i2c: fix double free of midev on netdev
 register failure
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kenny Hsieh <kenny_hsieh@jabil.com>, "netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "davem@davemloft.net"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "stable@vger.kernel.org"	 <stable@vger.kernel.org>,
 "linux-kernel@vger.kernel.org"	 <linux-kernel@vger.kernel.org>
Date: Thu, 22 Oct 2026 16:24:19 +0800
In-Reply-To: <DM8PR02MB8087DCE3AE16D853D284FF2D8E652@DM8PR02MB8087.namprd02.prod.outlook.com>
References: <20261022031704.2295541-1-kenny_hsieh@jabil.com>
	 <51bf6b10b2fc1c5d6ed7234e61067869380eebad.camel@codeconstruct.com.au>
	 <DM8PR02MB8087DCE3AE16D853D284FF2D8E652@DM8PR02MB8087.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-10-22 at 07:22 +0000, Kenny Hsieh wrote:
>=20
> Agreed, that is cleaner than making the free idempotent. Here's what I'm
> planning, let me know if it looks right and I'll go ahead:
>=20
>   - in mctp_i2c_unregister(), deselect mcli->sel if it points at this
>     midev, before mctp_unregister_netdev(), so its dev_hold() doesn't
>     block the unregister.
>   - call mctp_i2c_midev_free() after mctp_unregister_netdev() and before
>     free_netdev(), and take the sel handling out of it since that now
>     happens earlier.
>   - leave the mctp_i2c_add_netdev() error path calling
>     mctp_i2c_midev_free() as it is, which then becomes the only free on
>     a failed register.
>   - delete mctp_i2c_ndo_uninit() and .ndo_uninit.

Yes, that looks good.

Cheers,
Matt
