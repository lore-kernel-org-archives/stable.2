Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8A2931D1;
	Mon, 28 Sep 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598815; cv=none; b=Rqt4MrGmlbGcrB09RGBojIC7aMOJJd5h7truxISGnT7UBuO9h24LnLLmNCKMH0LjJYPsIL/jEYRTRHrn1Vpkvi3MyK3/TU+/DklHrxiPzi1PG9hZB+cw0vKL762ws7al6VuRhAgMYZxTyPRzf5UsUNkxWVu3I1eSE6b//dOeO6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598815; c=relaxed/simple;
	bh=R+JPwCZXOqxIJ97ZMlwQIS/8ge6qhpo5e4Q7C5QxnZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WtDRKGB0MT1F7qNh4f7TEBCGLpTiXcWsqG5ajQ/LazxEQMY0754UZ/af85lqkYYP6FuRu+K8y/NrQotczUz3G6mCHoGEpm4HVo1LDvPfcN8pl58KK08QMEinLUWQXIeglcPnhvdo4bTbyxO4fWYZL3fvqRICDgBygzEG+MenOBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=n1Ukvfpz; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="n1Ukvfpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aCQ+H0c+wVftlMBVRbtm3uG4VWV5k7egRAeD7StXg4Y=;
	b=n1Ukvfpz6YJb1tXnfP6VyeZouJ/gQl9yilQdCaZ2yCKmna6ZXRzvSjRhuRtH4O
	b2UzA6Z4sTBjxVHzO+2D9c6UuYN7wNYlPDTxq/dfrhWCpGa3KtHXzx+jbuoV6kIU
	Umv9UeC7wgfOCGR1B7e7i0lIgXhRJ+8WBlGm791iBx7DY=
Message-ID: <9ae72d05-dd76-42d6-ae29-b49cfddf85e9@126.com>
Date: Mon, 28 Sep 2026 20:32:00 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: stmmac: do not cache the new TSO MSS before
 it reaches the DMA
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org,
 lorenzo.bianconi@oss.qualcomm.com
References: <20260922124408.645496-1-xiaolinkui@126.com>
 <179016759614.2160803.12192059495158802876@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <179016759614.2160803.12192059495158802876@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PikvCgD3n_5AXrpq+9lyAg--.58147S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF48tFWkWw47uw47Kr1UAwb_yoW5WF15pa
	y3Kwn0kr1DGFWSqF4xCw40ya4rZw4rtFy5Ar98KrW5Aws8WryIgrW3Ka4Y9Fy7Cw4kX34Y
	yr4Yg3sxZFWDZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UuCJQUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqALwx2q6XkJr0AAA3q

 > [Medium] Can this new write position re-publish a stale non-zero
 > tx_q->mss after a concurrent TX channel reset has invalidated it?

Agreed, and v4 no longer moves the store: the value is now dropped on the
paths that never hand the context descriptor to the DMA, which is what the
commit message was claiming in the first place.

Two things are worth separating though.

The interleaving itself is not introduced by the patch.
stmmac_tx_err() is called from the DMA interrupt handler without any
serialisation against ndo_start_xmit(), so a reset can land anywhere
inside stmmac_tso_xmit(), and a reset that lands before the early
"tx_q->mss = mss" -- anywhere between the entry of the function and that
store, which includes stmmac_tso_get_num_desc() and the availability check
-- leaves a non-zero cache for the channel that was just re-initialised
with the old placement as well. So it is not true that "with the old
placement a later reset always won"; what the patch did is widen that
window by roughly the length of the mapping section holding the two
dma_map_single()/skb_frag_dma_map() calls, and that is what the new
placement has to answer for. Which it now does not: v4 keeps the store
where it was and invalidates the cache on the error paths instead. Zero is
what stmmac_reset_tx_queue() leaves behind, so it cannot republish
anything even if the reset lands in between, and the next TSO frame
programs the context descriptor again.

Second, in that interleaving the cached MSS is not the only thing left out
of step: the transmit path keeps running from its local first_entry, writes
tx_q->cur_tx = entry and lets stmmac_flush_tx_descriptors() push the tail,
while stmmac_init_tx_chan() has pointed the channel back at tx_q->dma_tx_phy
-- the software ring state and the hardware no longer agree, which is what
the reset is supposed to establish. Fixing that means the reset must stop
racing ndo_start_xmit() altogether, and it cannot be a lock taken in the
handler: the interrupted transmit path already holds the queue's
_xmit_lock, so the handler would be waiting for the context it interrupted.
That needs the channel reset moved out of hard IRQ context, and I would
rather send it as a separate change than fold it into a -net fix for the
ring wedge.

v4 therefore:

   1. drops tx_q->mss on the error paths of stmmac_tso_xmit() (new),
   2. keeps filling the context descriptor at the slot tx_q->cur_tx points
      to and releasing it explicitly on those paths (unchanged from v3),
   3. leaves the store ahead of the mappings, so the patch no longer changes
      the timing with respect to your interleaving at all.

The subject changed accordingly: the patch no longer moves the store, it
invalidates the cached value. Code changed, so the Acked-by from Lorenzo
Bianconi is not carried over.

pw-bot: cr

