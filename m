Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721799;
	b=gmTInpmV6q66ob15Jz2C8Tzc+HF7C6OMJUFy5foXWnlrc2iF/Wr6wJaTtR/a1D3yvGB6
	 xr1ozSxIBR0RpZnAi1fEwCWD5eRkIdtz2+mFv6LXPt4VH7S5VA5FsuGN6Ri0i4GkCDshw
	 /XFZ6XauA1dkFWC0G3lXBoXlMEE3s4sLWITqOezruqCMzQBxUcIQ20Nanc3aCTZIH6YFL
	 dmVG/H6LOgS94B3UH8PdiBDBVxjsV1u3RUhi1qQDgQI0dd3iK06IuX3g0Yf/W5kyvEZDj
	 eHmW7qIp5SMyy1UgukRwUxvWZ5FqfdGH4r+hMBKZuyUhQnZdOdO8FfMYObmZsk6RWAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=rk/q4Jj7lVrhNw2rMbFmAGjXQkJt7MP/x4+rKDQwa5U=;
	b=EkHHOseA6rk7bJxXbYycDDhqIR2AMiz8rYS+7bV2Erg5CVNG5grI5XeXxU4wHy3AJcbA
	 X/Fpa+8PZ982HzPDINRB0yYq37hKYke2zo/5j0HLxzYMZHzgqoieLgWluw0p2TUk9Ky8O
	 smlOMmfNOJeuXQxxKixMD1EQIdfcBywovDByIzld8vqUpvtc5miEeibeV+wi4ExsFKZmu
	 7D99kY+5Mc0NHqW3HHjmaYiwDPfdQIF3SdvD/WlVOQQd3IwGgWRg8hTeAqRQ4K9UnzfTB
	 lCa6ct5gldwjnNfRi3HjCXObP85B64ZA0JRyvis2q8e4RFcOjkC0FR/OIdu9JZlxyig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKtjJVF3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF09606A327;
	Tue,  3 Nov 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKtjJVF3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381C41F00919;
	Tue,  3 Nov 2026 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721799;
	bh=rk/q4Jj7lVrhNw2rMbFmAGjXQkJt7MP/x4+rKDQwa5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=MKtjJVF3S87PSHcYjNkgzTrAeqm6OrMtJwCT5s9T/sYs066BaLjxMYdj/6j33x6De
	 WuToMC40DOZ7uBxBe8D0gMm0wGakVv9zT6DP2CNqufeJw7ZjR2XUJYLk77Cy0VlyLZ
	 3GvEJy8YLfHpPHREegsD7QyiVJdV4YkYeV0atQZI/m5lUW/eo+SnMBGyd67a1OdUj8
	 KmoNO5DW/LjE2ZnxbGgSDEZhpIzrTc0fp7psLoKoMysYEZmQwgrFHMmBhfsHIBaFpu
	 ZaNap+me0hIXuKHmBtmp5qRCyMtUJSzl2XVO4U4OAo6OPalB+32l97qgGX0dx8gY5m
	 G7UZymNnsy3UQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>,  Pasha Tatashin
 <pasha.tatashin@soleen.com>,  Pratyush Yadav <pratyush@kernel.org>,
  kexec@lists.infradead.org,  linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] liveupdate: check for duplicate session before growing
 block set
In-Reply-To: <20261103153928.716753-1-christian.aurichzm@gmail.com> (Christian
	Aurich Zanettini Martins's message of "Tue, 3 Nov 2026 12:39:28 -0300")
References: <20261103153928.716753-1-christian.aurichzm@gmail.com>
Date: Tue, 03 Nov 2026 17:03:16 +0100
Message-ID: <2vxz1p91nbqz.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Nov 03 2026, Christian Aurich Zanettini Martins wrote:

> luo_session_insert() grows the outgoing block set before checking for a
> duplicate session name. On -EEXIST the new block stays in the set.
>
> If the session count is an exact multiple of the per-block capacity (51
> with 4K pages), that block stays empty. It is serialized with count 0,
> which kho_block_set_restore() rejects in the next kernel:
>
>   luo: Block contains invalid entry count: 0
>   Kernel panic - not syncing: The incoming tree failed to initialize properly [-EINVAL], disabling live update
>
> Check for the duplicate before growing the block set, as
> luo_preserve_file() does with the token.
>
> Fixes: 2a441a14c2c0 ("liveupdate: Remove limit on the number of sessions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>

Reviewed-by: Pratyush Yadav (Google) <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav
