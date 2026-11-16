Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.21.23.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846475;
	b=H/loGALb/2jsCRWwS1pGZmpX/tqhXZNQjKbE+H2Yj+GgbTARXdyGJi1vpasHhhbCCuMH
	 3iqPeclSWqQzK6yyd3MrO9HGv9tLem7+1AhBdunHWqkUTESFH8ZqerWKxvvqDVEagONcF
	 x/DLajN08Ck5M/Xeoaj5cgvdOW2omZS+/rmZbo9ogBKpPw7XA7XPME7rZtjzcUqZpYrA9
	 QbR3tL6V4gsCHIJtuin+N6iMHdPEHLRZTGl+bmzP6veXOaIrBZ3rzXBIf/kqQQKj3P+Mb
	 vZF7RDXjheN+pdoBleDcPUCA/kuKSq6vCOXDApeXnq5aO34CruCilEAsA1KBtGT4ISQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846475;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:From:
	 To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2jBU5o2bkTGSmlvbTbsB7gQEFSTPAxXPYXkt03I97h4=;
	b=WE8tt7jTEHz1O3t62xIimkJkhn9bfmjKatS9ZlTBX0r82yex/W9cHA6L4/nmyPItxlRu
	 mWOOdKCu6apFQ5CO8F7RXaM7sEMxy0C1Q2YdpfxeKEAdkAsVE32e1fEWQsXPaytrMQ1aw
	 JHE7ry7mLKKVZPVei/XtG4q+tmrWp5MnCaIUYTfl9y3J+s5aD+WJi5Z+PURdI82wVNOKL
	 doPpq/qoHOMzEvHNuhQmTfUoLLyrwd16QxeMsKv3WC/HBfjlWG/oIVNmkCaKh5zfvXNYx
	 WPi9AOkVbAhrtwGaX/AsSwdGCFnerapMQaAD+1wJdb9qrJvWp+uMdhsBZMPMV0dvpRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=disroot.org;
	spf=pass smtp.mailfrom=disroot.org;
	dkim=pass header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=DrWFQCUZ;
	arc=none smtp.remote-ip=178.21.23.139
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F03606A336;
	Mon, 16 Nov 2026 16:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30F03606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=disroot.org header.i=@disroot.org header.a=rsa-sha256 header.s=mail header.b=DrWFQCUZ
Received: from mail01.layka.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4F2AB808EB;
	Mon, 16 Nov 2026 17:27:52 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uKkmEh0y6lrv; Mon, 16 Nov 2026 17:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1794846471; bh=pILPvvNhNcniZXqO6U9udmiLgiJvcbsp+5tCyQ0iSDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DrWFQCUZtaM/iwRuaQiyr0audWq+nwMBikIk9hjfhc8zvqlsmr5sOZUR+ALOuaS6f
	 YCFfsHpYfBNb97a7NKH7ZKk9hkikOSwaZHMB8VtAtRItfaoq3+FAW1UjZhTycOymFU
	 spBSaoGaTVD+hfjKzgyXVi1Iw0OCHcAEO7mHjsYhSkV+XYhvn+AYsKfStrKLP0mMNB
	 6P3ue0rEov+GFGGOadzAJG6jds2PdK5RZzJgMPxnRCyK6r7SMpb8/f/Ty1a/8yOnij
	 Y1wXXAbGmjcs0JRhzfqspv5NP+AXvven9xq0VvVv68qmCgs+6isCdbEVJ9C/4GmHAj
	 PlcuEhlhWL5+w==
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
Date: Mon, 16 Nov 2026 16:27:38 +0000
Message-ID: <20261116162741.2438098-1-fmaurer@disroot.org>
In-Reply-To: <avrdu8qr9L2sEuTz@lore-desk>
References: <cover.1793927986.git.fmaurer@disroot.org> <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org> <au3igPTxdz3i64SO@lore-desk> <20261108205350.2956138-1-fmaurer@disroot.org> <avGnv8Jr7BAiQhG1@lore-desk> <avrdu8qr9L2sEuTz@lore-desk>
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

On Mon, Nov 09, 2026 at 12:00:15PM +0100, Lorenzo Bianconi wrote:
> q->head and q->tail are not the same when we have refilled the queue
> with new buffers. Moreover, I think if mt76_npu_fill_rx_queue() fails
> [...] it is not correct to use q->head for dma_idx

You're right, q->tail it is. In my tests I could not tell your version
and mine apart, so nothing speaks for head + 1.

> Can you please check the updated patch below?

Sorry for the delay. I tested it on the W1700K (kernel 6.18.55, mt76
467ae2e3) and it works: no oops, no rx stall.

What I ran: your diff as posted, plus read-only counters that write
nothing to the descriptors. Load was 62 minutes of iperf3 from an
ath11k mesh peer at 113-259 Mbit/s, with four busy loops at nice -20
on the W1700K for 3 s every 18 s. In that time:

- 61.9 M frames on MT_RXQ_NPU1, 1.88 M on MT_RXQ_NPU0, of which 227781
  span two slots
- no oops, no page_pool warning
- no descriptor that changed between consume and refill
- no refill failure, no skb failure, no tx-free parse error

Tested-by: Florian Maurer <fmaurer@disroot.org>

I found another issue of the NPU while testing, so this took me some
time as well:
In one minute, 226 multi-slot frames in a row did not end on the slot
with LAST. Slots of the rx ring go missing under this kind of load (I
suspect the NPU drops them), and counting slots by PKT_COUNT then
assembles the following frames one slot off, in your version and in
mine. I think tx-free events are lost the same way.
I will post it as a separate [BUG] report in the next days.

Optional: in my tree I made the poll report the budget as used when
the skb allocation fails, so napi polls again instead of waiting for
an interrupt. It never triggered here.

Please post your patch with the Tested-by. My 2/2 can be dropped.

Thanks,
Florian
