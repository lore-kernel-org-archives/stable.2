Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912448;
	b=2MwUJuKVgmbr5zFqlWEpgyoqvlMrihPTjgOFRKQqwHT/3Mfxb5B2lkfeOMG3vSdpfcT/
	 9Cv4E02ETCnojlHfKoxRrz2iXwrXnetmMlHVYN16FbVi55dlQ/cYL9gU7S05YaEtYxnqQ
	 4wlrfWRxqatIIwAKfP3y7XMRgJ/ocuANBFR5DcdiIsMVpWbTiPM0rODHNoWlQbERrt5JJ
	 OvFgRJPBB0X3kERE8rKEVQZrnu8QSdlvj4ZTlwQiXQcdP8QmgNPiiElSO4CGjHx/G71Rf
	 H8xEIcB+kYCn6ODKflHCWdK/9QwfhKzqhJ6C3lzziPPeLtjuFZ/QVO0q4BA7n8i/arA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912448;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=YBKmbqPHd9dciBG/l12S0j8gBmCDAFZtJHVY9b6Md6o=;
	b=AnRSabhR0UMpkwKtgOaSfZO5SraCVCjNTYccIGUcyf0Jm38ydu95le9pGphBpHYkAlRr
	 CfzNlVcBA2i0gcHs5zh7+uA5i3VjOFJChphqSPsDq5UBSAe1NgKQdFKezmVSSTb0+I6H/
	 M6N0VzqE60Crx5vkzgJUZPu3yb4QchfFzuVJezL6oM2VG7IKbBe6EzQPjlLE7xWKygfSo
	 jQt2yzQAgievpCOd9PqXDRKCdnwoo1uAOXIpqxPMLyCD04iytvAS5+jpj4uYN4xiXV/fd
	 zgS4FOa2Y7Czk7HarSQ/OKpkFL323xKVQYGsOF3EssPINHI4zTq+tlMMEHR7zukpzaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pisu.la;
	spf=pass smtp.mailfrom=pisu.la;
	dkim=pass header.d=pisu.la header.i=@pisu.la header.a=rsa-sha256 header.s=protonmail2 header.b=y+Hf6QJS;
	arc=none smtp.remote-ip=185.70.43.98
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC287606A336;
	Tue, 17 Nov 2026 10:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC287606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pisu.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pisu.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pisu.la header.i=@pisu.la header.a=rsa-sha256 header.s=protonmail2 header.b=y+Hf6QJS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pisu.la;
	s=protonmail2; t=1794912446; x=1795171646;
	bh=YBKmbqPHd9dciBG/l12S0j8gBmCDAFZtJHVY9b6Md6o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=y+Hf6QJSsnUUmNt78D7aLS1rYdcpl6bh9IfJEsHfTVsGrf7wLu+giGghmW4pnqr+e
	 9NPzoPmJRZEWsahT9z5TR5+VIVij4ZJyCVcFB2o+XKPOLfPcJvbVg16RJOKSF3hiQ2
	 13mAxxuM0QipmbkiRV5WBMgiOpm4SMlawmRFz2SkhQSs2VXqTc0HXHLdVbR4zqo/hU
	 0tONrnnw33gV7l5UHgYB5+4wq05vk+xXGYo0gcy0txAdgkGAz8QAej0r7HDe+1RVWL
	 GfqVKRIB8tIAl2o+Fi/blQjofsh4Ebs29l+PqhKPMARIhR0SEMrs0SyYwuv+63leXD
	 6AoqI3J8R//Aw==
Date: Tue, 17 Nov 2026 10:47:22 +0000
To: toke@toke.dk
From: =?utf-8?Q?Miko=C5=82aj_Pisula?= <mikolaj@pisu.la>
Cc: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, mikolaj@pisu.la, stable@vger.kernel.org
Subject: Re: Re: [PATCH] wifi: ath9k_htc: fix use-after-free of tx cleanup timer after failed start
Message-ID: <20261117104719.34130-1-mikolaj@pisu.la>
In-Reply-To: <179491123717.208602.16662402283759581420.b4-review@b4>
References: <20261116162702.15393-1-mikolaj@pisu.la> <179491123717.208602.16662402283759581420.b4-review@b4>
Feedback-ID: 197744389:user:proton
X-Pm-Message-ID: 3df049974ba54763bb9e06ce2b77560c7733d9f2
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

Hi Toke,

> The Fixes tag is wrong - this was introduced with the commit that moved t=
he code
> (which indeed didn't react to the ret value before):

> Fixes: 1057b7503908 ("ath9k_htc: Unify target capability updating")

I've sent a v2 patch with an updated "Fixes" tag:
https://lore.kernel.org/linux-wireless/20261117103918.33701-1-mikolaj@pisu.=
la/

Miko=C5=82aj

