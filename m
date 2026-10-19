Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443908;
	b=egDF1u5qqCtT6VQTNlE5tvTc6OhITfLpIRomZyE1fwat6bf0KcCB2/V6ER3nVHunyd7f
	 CMJR0EFc3ZBkTBv3ZyUNYRIhywRP0axFNhcXMT9XcILy+Bhdp7p2FYg6OEte0oyymCWY+
	 ET10tcO2FaCIFXGcs2/qV8Fv95eZ4mnOoKZd79UXE3VHhshkgaQFhx94/1iPTd9g5JJz7
	 5GDHAAxDSN4zxe2p/+a6GoKxTXQcjdqdP9oF6YJTxzueS7YT+OI0wpBrA6XHxN6cUzGEE
	 lBImWdnLdmzTroShCyil9RiOUFGyc6eHZTbSq0cXYOn4X6eYHFBUD3m6CXeWu/GD/iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443908;
	h=DMARC-Filter:From:To:Cc:Subject:In-Reply-To:References:Date:
	 X-Clacks-Overhead:Message-ID:MIME-Version:Content-Type;
	bh=MAMTZ+go6zLwdnQjqi8PpY4WA7VuyI13uOFhcQaRL5I=;
	b=y1RhHkyKvc4fKRxwPfFgpzHQ+PVW8XW+XTqfuGWsNiH/kiJ3dP5MHBswHDWI/m+cDfSi
	 JvYJPwb50ogDxx9pKJtvlNC+MfLEGckrrIHam7Yf/MB3QpBa21znnC47LyE3SQinbZ5Za
	 XioFmvtUIwbWYqyPHa3S/igw1b7UdYaF3riLUXpWsiGe0IdvBDnwt15/8CYfJ9kkXsCIR
	 xPyV299DUfIfKqqrKG7F9fLuUYhlrTLNvvHCqsND2wBZhIdNooyYaUxODcOJIj/uaKOoX
	 OSS4okc1fxrWaRntRt073Mzpvdp5T5LYSmL7YQdaSLJ5B/vPYeEIcJyMce8Nsu3jKTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3E606A31B;
	Mon, 19 Oct 2026 21:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A3E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Evan Severson <eseverson@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: track PS-Poll responses in the BlockAck
 window
In-Reply-To: <20261014025734.2288693-1-eseverson@gmail.com>
References: <20261014025734.2288693-1-eseverson@gmail.com>
Date: Mon, 19 Oct 2026 23:05:04 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87ecdlv1tr.fsf@toke.dk>
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

Johannes, WDYT?

-Toke
