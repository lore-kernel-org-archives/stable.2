Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437536;
	b=aT+SsGAONAue1LF9RKlIX3UaqJjDq5NQ3X5imqJytVLC9e6KCezNZiE9DSZbVJD3tGQ7
	 u4CWRxUcKrgn19xTsF8Q1JaTlzrgTFiWYuMiZzqB6W3TKdvEHbNkXgCGDKI1CXfp4hjNh
	 i96EE7BLvQhVBEKBDZMerJB3MbHbGPZmc1Rvg4373lmlR+3syT1r3whVXThUJ0YASa/zF
	 J2vqQKYE0xzi6xVEUvOwCBbd5LYQmpwvMA4WNfTwU7gI617rWKIWe4UCpq1+vZkCYOzvt
	 C146olLlCdQ3xNlxGMWqrK4p/93hLcuKlPZRryVN/Qp41+7rjvSVnYuxK320EKEe34w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437536;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5ePkrAFhVGr4mAotZVdcNeWakBR6sHFcUDUhmY4lFi4=;
	b=LCj2L7kAGKz1x+OU1OsPpG7KYLP8OWtWu6Bv4ANe8HGoHMkyhUtrivqQ35aQBb5mKpAx
	 mJ7luJskMIaO9u/nDmWpcqH2IbZyWpgVvjzs9gduTZR6Y71spSqLxop2Lmw9f4QNUsnNf
	 L08rF3svmeeFtyO41/QnSJYPFfrHSOVyDYKmKJsOqhK1yXtcxdHtnMh66+po1fTKGXVjL
	 fdz/B/H04FD10PBWQOwTDP2sMkjV7yd2eI03fZMgAfRmzuuSUAotf3ByvNlZ8WgpEOhag
	 OwinmJ7i2fmK8HGNaKANr6JBgSbL0waMWlQkB5gYv8/8Cc0xCKznveFcFaWOUT3pr9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8803606A325;
	Mon, 19 Oct 2026 19:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8803606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Nerijus =?utf-8?B?QmVuZMW+acWrbmFz?= <nerijus.bendziunas@gmail.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, "John W .
 Linville" <linville@tuxdriver.com>, Simon Wunderlich
 <sw@simonwunderlich.de>, Oleksij Rempel <linux@rempel-privat.de>, Kalle
 Valo <kvalo@kernel.org>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH ath-next v4 5/8] wifi: ath9k: clear the PHY error filter
 when a spectral scan is disabled
In-Reply-To: <20260916173429.403889-6-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
 <20260916173429.403889-6-nerijus.bendziunas@gmail.com>
Date: Mon, 19 Oct 2026 21:18:54 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871p9lwlb5.fsf@toke.dk>
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

Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com> writes:

> Triggering a spectral scan sets the PHY error bits in AR_RX_FILTER and
> AR_PHY_ERR and sets AR_RXCFG_ZLFDMA; disabling it clears none of them.
> ath9k_htc carries the hardware bits into every later filter update, so
> an idle device keeps forwarding every PHY error as a zero-length frame.
>
> Clear all three when the scan is disabled, unless radar detection is
> enabled and needs the same bits. AR_RXCFG_ZLFDMA must go too, or the
> frames keep coming.
>
> Fixes: e93d083f42a1 ("ath9k: add spectral scan feature")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nerijus Bend=C5=BEi=C5=ABnas <nerijus.bendziunas@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
