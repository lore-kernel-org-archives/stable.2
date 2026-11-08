Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794171281;
	b=w6D9XKOIRI47dNUBzGYb4EuBpv395C3kIxxgQLhZVIubTEZMKj0R0MA+e27+j3X2fWuH
	 TnnJ2MFsVWlFGHrVOJwmbJTQZ5PM8AF/4DO8EgBA8E8gW2iGoF/4ubzC1/TJ9Q7CyJVgU
	 deLD6WbxVw9hr1C4t7fP4SpPhJ23Kk5/UapeyPH/udtd9Ix9v2H1K1UrO1E0FXeK/bVnp
	 b5g8jU+Ecpe2M3eJA2IZgIAv5oPerEgHIGKShOfTbYbrr8MTxpqJHXHtCCT4ShrJB44TK
	 ZAmPAYOSyP5SfIIQqjTQWvfhaQDVPESn67BP1Tn9sU3qejUoHoPs9N9MtwbDBot7FAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171281;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AGFdlabeqEb35qWp8FLEWRPggysLe3Q3O4790UcL76Q=;
	b=orphgcXWTnKrBPMsssOWUI2VemRP4uVsK1FIsLkQeUkcupbOBLSfdp+YsG/JQOUKPBfA
	 05eJEiWg+tAaxH1Daz66xE2CXx2dIOgS9NDay5+BbJD8p4su/hgNB4sx7gPKXbgyF9Rpc
	 swFPrdKkPKY+gcYRvbQu0QvesPFDrQ75rslHp3bpPhxRAEkNhTELzgFMmLom4eqg/yApL
	 okQCixHgsGz/2yosEhnKp1/1pAHIPkhni4ejLb0sSkQU2UTTOW4+k45rhMWaB6SvxbFDh
	 G/AEGmbpfBdC9fSl1jkxByqWBJ37SRBom/luP1loTyzw1LzGC4uhh9jAxtuKm1yDysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=Vn3pYSmQ;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA20E606A31C;
	Sun,  8 Nov 2026 20:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA20E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=Vn3pYSmQ
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 5961380A2A;
	Sun, 08 Nov 2026 21:54:32 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cvJPPhnADycg; Sun,  8 Nov 2026 21:54:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1794171271; bh=InPWc+RU9xrIYZPwWZph+YHnci8PesbBzJmr4nqrB88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vn3pYSmQqEceRkJZKJj1Zo+LO6hy43qE3j4/jglkyH619+BHAdg40gyz7ds5O9HDW
	 EhRFI44zAkB5p4GRzMrCV8I7JHl+RyePjPkZ+O9uRojHoH9nsX+fRI5H/hR9QTQ/Wc
	 9jAC/lp3VSx3yDd2wuXhC5s3j3ORjBgzifSgmCHqXQAzH2KQvAYKN6C/DpM62eUCZs
	 jDRx0cPPsa0YrnC87jc2iBYWvNUI2/BXCm79T7p/zVU8ADJwvVviqvFhIy8yhkl1/Y
	 AoYT59awzvh8dB8PAydkEjKXo1uZxlOF5DGQJnWZDkb7p5H2ZWP0ntyZzJhS/r4yFl
	 hV/czRNTYQHIQ==
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
Subject: Re: [PATCH wireless 1/2] wifi: mt76: npu: return rx slots to the NPU only after refilling them
Date: Sun,  8 Nov 2026 20:53:48 +0000
Message-ID: <20261108205350.2956138-1-fmaurer@disroot.org>
In-Reply-To: <au3igPTxdz3i64SO@lore-desk>
References: <cover.1793927986.git.fmaurer@disroot.org> <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org> <au3igPTxdz3i64SO@lore-desk>
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

On Fri, Nov 06, 2026 at 03:21:52PM +0100, Lorenzo Bianconi wrote:
>> +	Q_WRITE(q, dma_idx, (q->head + 1) % q->ndesc);
>
> why are you writing q->head here?

Once the ring is full, (q->head + 1) % q->ndesc == q->tail, so the
value is the same as today. Only the timing changes: the slots go back
to the NPU after they have a new buffer, not before.

The +1 assumes the NPU completes slots only up to dma_idx - 2. Every
slot it can still complete then lies between its own position and
q->head - 1. The host has not consumed those yet, so they still have a
buffer. If the refill fails, the same value is written again and the
ring stalls instead of handing back an empty slot. A debug patch that
cleared DONE after each consumed slot saw no slot completed early in
60 minutes of rx load, though I can't tell how often the NPU reached
that slot. Can you confirm this is how the NPU treats dma_idx?

>> +	if (nframes > q->queued)
>> +		return NULL;
>
> can this really occur?

I have not seen it. The slot at q->head is never cleared while the ring
is full: it is the one kept free, consumed in the previous round, so it
still has DONE set. If the NPU has completed the first slots of a frame
up to q->head - 1, the count reaches past q->queued and the next DONE
check finds that stale bit. A page pool failure makes the stale region
larger.

> I got your time, and I agree this is an issue we need to fix but I guess we
> should avoid a double loop. What about the patch below? (just compiled and not
> tested).

Keeping the partial frame in q->rx_head is nicer, and it lets the slots
of a half-received frame be refilled early. Comments inline.

> +	if (!nframes) {
> +		nframes = FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK,
> +				    desc[q->tail].info);
> +		nframes = max_t(int, nframes, 1);
> +	}

PKT_COUNT is read before DONE of this slot, see my reply to 2/2. Once
q->pending keeps the count across polls, a stale count of 1 would
stick. On top of your patch, something like (not compiled):

	if (!nframes) {
		u32 ctrl = READ_ONCE(desc[q->tail].ctrl);

		if (!q->queued || !FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, ctrl))
			return -EBUSY;

		/* PKT_COUNT is only valid once the first slot is complete */
		dma_rmb();
		nframes = FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK,
				    desc[q->tail].info);
		nframes = max_t(int, nframes, 1);
	}

> +	while (nframes > 0) {
> +		struct mt76_queue_entry *e = &q->entry[q->tail];
>  		int len = FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK,
> -				    desc[index].ctrl);
> +				    desc[q->tail].ctrl);
[...]
> +		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[q->tail].ctrl))
> +			return -EBUSY;

Three things here:

- ctrl is loaded twice, so len can come from before the slot was
  completed.
- Nothing stops the loop at q->queued == 0, so it can take the stale
  slot at q->head, whose buffer already belongs to an skb, and
  q->queued goes negative.
- q->pending is never set, so after -EBUSY the next poll reads
  PKT_COUNT from desc[q->tail].info, which is now a later slot of the
  same frame.

So:

		u32 ctrl = READ_ONCE(desc[q->tail].ctrl);
		int len;

		if (!q->queued || !FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, ctrl)) {
			q->pending = nframes;
			return -EBUSY;
		}

		dma_rmb();
		len = FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK, ctrl);

[...]
>  	Q_WRITE(q, dma_idx, q->tail);

This still hands the slots back before mt76_npu_fill_rx_queue() refills
them, so the oops is still there. It needs to stay at the end of the
refill as in my patch. With your structure that also lets a frame that
runs into the free slot finish, since the NPU gets new slots after
every poll.

I can fold this into a v2, test it on the W1700K for 60 minutes under
rx load, this time with a counter for misframed frames, and send it
with the results. Since the structure is yours, I'd add
Co-developed-by and your Signed-off-by if that's fine with you. If
you'd rather post it yourself, I'll test yours instead.

Thanks,
Florian
