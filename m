Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753378;
	b=ghPIsCt+3lA87Gi4Sp7m4EjLmT8Awh+oXjTRkxUeRV1LDIpzfWG2y9uh1RkrwetsBNZV
	 q9cAOxi8i9mS+Ghb4tJHUIMlYW7vVMo1GlnAAZfYdhTya/8XBTpWzXrgvohaXde4RylpM
	 dNC1gpKr2ReQ+CvjHo0/EzTg/xsxlyCEfh/qbO+17v5bylvHD4h9SG5zAAdtE4m06er8Y
	 13C5cVY6deUQLIFhdPNiq9QhHHZQnSWljwcGcPOUfjgCH4nf6TKDCsqUKkVvo5rJeBMzv
	 hpH4Vuq6ckyKDjbJSnRfOchT7iq6dzunUAFJ+h/+leP4RBDGdITwPRv0a1xpEopX3CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753378;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:In-Reply-To:
	 References:X-Clacks-Overhead:Date:Message-ID:MIME-Version:
	 Content-Type;
	bh=jdVWysumPcjLQBhJ0UMvoUsZbgNuwjZsFmnCdFKmn04=;
	b=pRZP8HXQLAADrxxtnRY29/gQsU/QXiCO4+MKxgXBg5pyOzadGrJYe0mqmPUCcbeHe/tn
	 W4T5V+PMMIUyhP10yzXG3h3EUQxhoDYR9RaPnzWQNnIuYlLluG0sI9iSVKmAiUzQRWVoU
	 XUliefnRhcbA6S0DTVGazB42Z9svnelnaYNCrJZ/upazbWXvv6DuOeu4w6rOkhICguQPW
	 TpoWppxk3/oLo50lHifRrxQ2FnD6zAWVJIRWOjE0xPc3wozRB1WmkDllQIkvhRPwTpnrz
	 3mCXmFKBdjIlHOlArYnaAAxmM+6MRiN0IdZ8e4C47YpQWKaRoeMG0KwvA+LhsMKZMNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3krj1os;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE09606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3krj1os
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD261F01825;
	Fri, 23 Oct 2026 11:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792753377;
	bh=jdVWysumPcjLQBhJ0UMvoUsZbgNuwjZsFmnCdFKmn04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=D3krj1osEDG5rSFgUZOJz2r4S9JbYSP+pRqGbFTFlYvkRXSeFcEjfxCqqJVPz9l+X
	 KCqSuERfDpyNeYvL2NrFr3FK5T07CIItlPV3d0aXA2fdAVsywzLKvacSTtwRH8FYi+
	 AQBL3mk16PAuvzWCdQF3WIfaX2FPsCmuOvgPJ5iEFMx7r9Q3KuEgy2+ntgXth6LQ79
	 NM0L470hnyfk70M6IW2kK6Xgd625tqETvonhXuwDXXCPKvxsNAkr6tuxRstuqqWMyx
	 Ma4N1hytfvZcYKRgdwjHExfezRHRkHa1cCJYfSg9KtWsAvWQn6R7y3tRCyLh/ONQZD
	 TA+FiuLKMmZ6w==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 7877EAD996E; Fri, 23 Oct 2026 13:02:54 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Evan Severson <eseverson@gmail.com>, eseverson@gmail.com
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: track PS-Poll responses in the BlockAck
 window
In-Reply-To: <20261014022332.2223387-1-eseverson@gmail.com>
References: <20261014022332.2223387-1-eseverson@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 23 Oct 2026 13:02:54 +0200
Message-ID: <87bj8ksmqp.fsf@toke.dk>
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

Evan Severson <eseverson@gmail.com> writes:

> ath_tx_setup_buffer() takes a sequence number from the TID for every
> QoS data frame, but a frame only enters the BlockAck window when it
> carries IEEE80211_TX_CTL_AMPDU. Since commit 592234e941f1 ("wifi:
> mac80211: Fix iTXQ AMPDU fragmentation handling"), mac80211 sets that
> flag only when dequeuing from a TXQ. Frames that reach ath_tx_start()
> directly while a session is running, such as PS-Poll responses for a
> dozing station, now use up session sequence numbers without being
> tracked.
>
> Once seq_next is more than baw_size ahead of seq_start, every frame
> the TXQ hands out is outside the window. ath_tx_get_tid_subframe()
> puts it back on the retry queue and returns -EINPROGRESS on every
> attempt, nothing ever moves the window, and the AP stops sending
> unicast data to the station until the session is torn down or the
> station reassociates.
>
> Seen on a QCA9563 AP (OpenWrt) with a station that stayed in power
> save for several seconds under downlink load: the window was empty
> and seq_next was about 2170 ahead of seq_start. With this change, a
> 90 minute run saw a run of more than 3800 such frames and no stall.
>
> Flag unfragmented QoS data frames of an active session as A-MPDU where
> the sequence number is assigned, so they are tracked like any other
> session frame. Fragments stay unflagged, as mac80211 intends. A frame
> from ath_tx_start() cannot wait for the window, so if it is already
> outside it, send it untracked as before rather than set a bit beyond
> the window.
>
> A PS-Poll response is sent on the UAPSD queue, and ath_tx_start() held
> that queue's lock while it took the TID's sequence number. The sequence
> counter and the window belong to the lock of the TID's own queue, which
> the TXQ path holds when it adds to or advances the window, so take that
> lock for the TID work and the UAPSD queue's lock only to hand the frame
> to the hardware, as ath9k_release_buffered_frames() already does.
>
> Fixes: 592234e941f1 ("wifi: mac80211: Fix iTXQ AMPDU fragmentation handling")
> Cc: stable@vger.kernel.org
> Signed-off-by: Evan Severson <eseverson@gmail.com>
> ---
>
> Notes:
>     An alternative would be to restore IEEE80211_TX_CTL_AMPDU on
>     non-fragmented PS-Poll responses in mac80211, which would also cover
>     other drivers that track the BA window in software. Happy to rework it
>     that way if that's preferred.

Discussed this with Johannes, and we agreed it should be fine to
reinstate the flag in mac80211. I sent a patch to do this:

https://lore.kernel.org/r/20261023110052.650519-1-toke@toke.dk

could you please test it and check if it resolves your issue?

-Toke
