Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795635880;
	b=tLnG9EiTuk4WGD/DjhUPXgFlZmmgZYm0QSqUwLRjuMjihqkyXqi9pr5Na7ni1yJuRKo1
	 oJyzp6nIT3CvBYBdHDJ02MfDVvSfQ8ZapYxTs1vmV8OVgBqlzwvPVIi9wjDTCdBxQBJ6k
	 HYREck6134dKpeXRk0LsQxpZma5xa/BrMMxY/NK/j31Q+50YfNTnXg8DR4pS4vPAF3p2H
	 sUkYuuabklEYYMgh+wa8Jyy3973ZnrBrZHl9mHpI4ALGYsYZdwgxVZ/ZXzDjH3yNErNOY
	 UiQQCyG/dK03DjBryfaigc+BC+Q2PBcJsDgmIlq51SDNZy+koN3Y8rrWbpafWMfSgCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795635880;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+ypIl6O4RFwCdH9fMD25g4AZ0LJ/xXTxEjxVlFOHiqM=;
	b=xrItV1ICy5DEYH/0drXlufpvBHDEQ9B2/XysBJ2dg+LLcElJs7sLqbc4nsdKqk3rtwoI
	 ue31lvseof2x6QLNPzYERADD6WpgdfOrC2jdspKoTS+jf2qJRirRSEbgGWzf4wDqlIAg3
	 CuaMNi5dvpy5gWWlOysh7k9koxL6IJbEqpCx5C1dXEzGyqQUZ4lWppVP1BDStOLjtw9bO
	 tF/B5+L38JyBwBWfaxFY5RbUt+od+riyn3Ziz74B2X6Dwk1VJAwi3UoDRaDl6OxR2Wv4C
	 Lm3u5MCp4tyH2XCQUrY1oLiM7iQMD1m5IDALOUR3/+rt9u0f4swxMbrvq8pezPOaHkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=oOVmEWsn;
	arc=none smtp.remote-ip=109.224.244.17
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA82606A31E;
	Wed, 25 Nov 2026 19:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEA82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=oOVmEWsn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795635876; x=1795895076;
	bh=+ypIl6O4RFwCdH9fMD25g4AZ0LJ/xXTxEjxVlFOHiqM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=oOVmEWsnmrPId/aQtxQQJWEnQC/YoVHCJIECkVFYljefMn1djcYp5bsG3P6kXeCSV
	 7oAe+ZYa4vrdKpeFAmeKTOrsO6yh8mqJThs4dUOj38F5VxcC75AmwvXSOJxnfL6njR
	 jAwjjb3KuwyFp2hg9TjT/o+KFC+3FKDkS7akGPgVkERpgNi/oKnJOOG6JZL6iOZw1y
	 LgjfCTwQWuApTCvw4Nbra6u2zYTcD4dlqoYqmx3cmBtNLF1giVGx0Wshd9VDwtG2K+
	 NcJFWJ3QPZLUvkzRlUBoxD/Opm4JTCduzN4FlW1wP7azLOiMraPjWA2NQtcvEkIbig
	 JZbp7ImL3EGOw==
Date: Wed, 25 Nov 2026 19:44:29 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, achill@achill.org, sr@sladewatkins.com
Subject: Re: [PATCH 7.3 0000/1005] 7.3.7-rc1 review
Message-ID: <20261125194417.55783-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 72914e73506db7fc547786334e45b19e065eeee6
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Built with Ubuntu's config (Rust off) and booted on a Surface Pro 11
(Lunar Lake).

With 0005/1005, the SoundWire ghost RT1320 quirk, the sof-soundwire card
registers with one RT1320 and the speaker plays; on 7.3.6-rc2 there was
no card. Ten s2idle cycles: no suspend failures, Bluetooth (btintel_pcie)
up and scanning after each resume, and the speaker still plays after
them. No WARNING at boot.

Tested-by: Sergey Lebedev <lsa.uz@pm.me> # Surface Pro 11

