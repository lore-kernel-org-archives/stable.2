Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172909;
	b=b3XvCF5OKUkom/X7eevvTxYpm/iLCenxxbBSv+4cwkB2AbDqSkqG7HW950LjcF8S0jBI
	 nz/G2qoBPpW5Xo5HfdjMa229zt4WQxb4XmOD5paiNp6AHeO0pzwyAHCu3SwXPWCXYjUi9
	 7ZiGfOxUwRHa3EdGFiHmCrAo4wtIQP/bbiUK+DQfrqLkASWxfpf6GvH7NGL2KF0dKAnMB
	 Jk+33VdzRUWtOH08584wvyjvdY2h+dP5LguA9N+pSzm5fJbV9so3CuYGcvEtrooInz/nH
	 al/hD2RIiKT5cNXk99bBFmamqfnnZB/E37BC1Vu3Xq+DHs7/iSQZsiqpUHbLELThe1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172909;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dy1FrLRP5sHlIb/uR6GwETHa25cqzjt6QkibR1Iv5QM=;
	b=DCOLX5rLMaRbnei1fAfkdWQ8y+A1O1jRVJ8cVXlbmvnGIXqQLF6QndF42chuYYz6Sr/g
	 kp3DotLN/ScuWNfaEXsQ89/S+h4aHftM+lQG6e8DYL67nHZ+KpJS0Vl0e5tjYs2iDcP2J
	 lxFJGcL6wVRQ356PSw1EuLJalSmkm+bK0OK6w5uQTRrxO9i40fDk8BhO6TYMQ3eiv8q9s
	 cQMJSZSg3kh+8+jhyR6NDjBvXlJUeGzGs2EEg/UFiNI3eybMo2d4AHCZgPxbFQOS/Gvlu
	 8/LuarqeuWcTaC2Ht/8XH/OH//e7pZNta5Em77le703T62Qm8jN7lW5hyEeDMMJnsOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=OhfDEB0y;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8441A606A31C;
	Sun,  8 Nov 2026 21:21:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8441A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=OhfDEB0y
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 228CA80792;
	Sun, 08 Nov 2026 22:21:46 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XMlTVqmvejJs; Sun,  8 Nov 2026 22:21:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1794172905; bh=Dy1FrLRP5sHlIb/uR6GwETHa25cqzjt6QkibR1Iv5QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OhfDEB0yUJDK5+n7O16lNXc668YG5pqs+r5A/f1JNDqBD4UmQbrIN06xKVTtQ6rn8
	 HylnYr2PetuxHS2wlDNJvhvMHmMpTwUV0jrtUslPItzGLSPcr9AAqeS3PglYwrFGd5
	 GepyeDYwir+ttnEqPkveKenJ6dNBC+OxGT2kYqx7dOWuc9Rgee/LQYs1NjRj6okkjL
	 LcA0wF94j39WrVqruzyuyMO0V1u/YI4ea39G5IUTrWNQ1q/grZ6PUCks/eab52oIw9
	 tkMP3ZfdgAhpwYRNHQ9ITQYwwLaRDhicMPZEqMBX3yfbUH0N35Dkl7cLCnA00bevBF
	 L7fDktzz6NKWA==
From: Florian Maurer <fmaurer@disroot.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Florian Maurer <fmaurer@disroot.org>,
	Felix Fietkau <nbd@nbd.name>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH wireless 2/2] wifi: mt76: npu: read the rx slot count after the first slot is complete
Date: Sun,  8 Nov 2026 21:21:29 +0000
Message-ID: <20261108212130.3028297-1-fmaurer@disroot.org>
In-Reply-To: <au3jnOD5ZOJR0mvb@lore-desk>
References: <cover.1793927986.git.fmaurer@disroot.org> <653d93b3c35975cd13dd6b33d76ea6517b55be91.1793927986.git.fmaurer@disroot.org> <au3jnOD5ZOJR0mvb@lore-desk>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Nov 06, 2026 at 03:26:36PM +0100, Lorenzo Bianconi wrote:
> Relying on the patch I shared for 1/2, I guess this is no more a problem since
> we will just delay the skb allocation. Agree or am I missing something?

I think the race is still there. It is in the order of the two
descriptor reads, not in the skb allocation: your version still reads
PKT_COUNT from desc[q->tail].info first and checks DONE of that slot
afterwards. If the NPU completes the slot between the two reads, the
count is the 0 left by the memset in the refill, max_t() turns it into
1, and the DONE check then passes. A two-slot frame is delivered as one
slot, and its second slot is taken as the start of the next frame.

That matches what I saw on the W1700K: with patch 1 alone, 2-4 bogus
tx-free events per 30 minutes, each 2792 bytes over two slots
(1000 + 1792), i.e. the last slot of one frame plus the first slot of
the next. With patch 2, the same debug counter saw none in 60 minutes.

It gets worse once q->pending keeps the count across polls, as long as
the count is still read before DONE: a poll nearly always ends on a
first slot that is not done yet, so the frame that starts the next poll
would usually be stored with a count of 1. Checking DONE of the first
slot, then dma_rmb(), then reading PKT_COUNT avoids both. I sketched
it in my reply to 1/2:

https://lore.kernel.org/linux-wireless/20261108205350.2956138-1-fmaurer@disroot.org/

and v2 would carry it as one patch on top of your structure.

Thanks,
Florian
