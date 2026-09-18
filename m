Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F444A49B2;
	Fri, 18 Sep 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727664; cv=none; b=BIjG1tZZCKN6w1X0FaJlpTdtCNdM4KlQHQOxsZsHjbEDjG+SaRSPPMLMSIg40KIjTRbgXMqmVPlWfIhlH/yktvcxzOskPX5GUdDpZfuf7U9X7Ye9nBiEqaVhiLaN4Geg0tzpKHtDLXkEEPGyoZGaZ9v+FlR2BA27jO8ECAkbeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727664; c=relaxed/simple;
	bh=u6XsNCelDRkK9eb5s39wI4hiOut0FxwgdIFI24z4NgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kfxdC3dALcp+n0qaMhxWFMmzVuq9BkrgauUy1/pllXx3oAkpjq7iDvhV4uhPrfUYKtC6ojSfEb36cWfLH+hURzUTjYd+gIbQF7XuaLJ01X0cUk+AHcugYNlQzIMeJ5oV/2iRcXIxJgJsmZDNaVWCJ6hPyMp4hp8/EP+Nd7z7e8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Mdj+wLod; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Mdj+wLod"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=o+oZnGlHZIGMyCuHE5hh6qyYk862NKFKTYCCieZ2ADg=;
	b=Mdj+wLodmw30hc3o+5LCnBT1zwxAS4bhZq8B3ESj2ef5vZ9UbKE+ggW/FtnHtv
	VY8pQMpDfaMEhTDPVPrhX/3c6bRL5gZV8PhXP7Q/MIhO2xRJgSiYWVW4zUP+YC9V
	ox9SWy9QePhHw3+e86s3IcRL6vkJiKfVP0qdHLF0JTQR4=
Message-ID: <62d9f679-68dd-45bc-9754-9e0ae931d2af@126.com>
Date: Fri, 18 Sep 2026 18:32:53 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: do not cache the new TSO MSS before it
 reaches the DMA
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917124234.1348673-1-xiaolinkui@126.com>
 <aqwlUWN3rAXfcaWr@lore-qca>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <aqwlUWN3rAXfcaWr@lore-qca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDnNx9WE61q7PYEBg--.785S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr1DGFW7ZFWkZry5Ww15Jwb_yoWrKFy8pF
	WUAa90y395Jr4fZw4kCw40qa4rJay3tF4Yyw18Kr9xCw43tr9Ygry3KrW5Wa4Uur95Zr1S
	ka1qka47CF4DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqBfftmqtE1ckogAA3T

Hi Lorenzo,

thanks for the review.

On 2026/9/18 01:37, Lorenzo Bianconi wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> stmmac_tso_xmit() fills the MSS context descriptor and stores the new
>> MSS in tx_q->mss right away, but the descriptor only gets its OWN bit
>> much later, right before the frame is handed to the DMA. Every error
>> path in between - the dma_map_single() of the linear part and the
>> skb_frag_dma_map() of each fragment - returns with tx_q->mss already
>> updated while the MAC is still programmed with the previous MSS; the
>> abandoned context descriptor is later reclaimed by stmmac_tx_clean().
>>
>> The next skb carrying the same MSS then compares equal to the cached
>> value, so no context descriptor is emitted and the hardware segments
>> the TCP stream with a stale MSS, generating frames whose payload size
>> does not match what the stack accounted for.
>>
>> Only update tx_q->mss once the context descriptor has been given to the
>> DMA so that the cached value always describes what the hardware is
>> actually programmed with.
>>
>> Fixes: f748be531d70 ("stmmac: support new GMAC4")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index af2d38a2bb3d..a8f94cd6abb4 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -4563,7 +4563,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>>   			mss_desc = &tx_q->dma_tx[tx_q->cur_tx];
>>   
>>   		stmmac_set_mss(priv, mss_desc, mss);
>> -		tx_q->mss = mss;
>>   		tx_q->cur_tx = STMMAC_NEXT_ENTRY(tx_q->cur_tx,
>>   						priv->dma_conf.dma_tx_size);
>>   		WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]);
>> @@ -4714,6 +4713,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>>   		 */
>>   		dma_wmb();
>>   		stmmac_set_tx_owner(priv, mss_desc);
>> +		tx_q->mss = mss;
> 
> I think the issue is real. A couple of comments:
> - do you think we should run stmmac_release_tx_desc() on mss descritpr in order
>    to clean it up?
> - I guess we should use the same approach used for data descriptor and advance
>    tx_q->cur_tx when there are no other possible error condition. What do you
>    think?

I started from your second suggestion, because that is the one that 
makes the
error handling consistent: tx_q->cur_tx is no longer advanced while the
context descriptor is being filled, it moves past it together with the data
descriptors, exactly like stmmac_xmit() does. On failure the ring index is
therefore still where it was and there is nothing to unwind.

That in turn makes your first suggestion mandatory rather than optional.
stmmac_tx_clean() walks the ring until it reaches tx_q->cur_tx, and the
context descriptor now sits exactly at the slot cur_tx points to, so the
cleaner cannot reach it and a descriptor tagged with CTXT|TCMSSV would stay
in the ring until the slot is reused. The error paths release it explicitly
instead, using the same helper the cleaner uses for descriptors. OWN is 
never
granted on that descriptor on these paths, so zeroing des0-des3 cannot race
with the DMA engine.

Concretely, v2:

  - keeps tx_q->cur_tx untouched while the context descriptor is filled 
and lets
    it advance together with the data descriptors;

  - moves first_entry past the context slot, so the error_dma_unmap 
unwind loop
    does not call stmmac_free_tx_buffer() on a slot that has no skb 
attached, and
    is_last_segment = CIRC_CNT(tx_q->cur_tx, first_entry, ...) == 1 
keeps the
    correct value for single descriptor frames;

  - updates tx_q->mss only after stmmac_set_tx_owner(mss_desc);

  - releases the context descriptor at the common "error:" label, which 
covers
    both the dma_map_single() of the linear part and the 
skb_frag_dma_map() of
    every fragment.

Nothing else changes. first_tx is sampled before the context descriptor is
allocated, so the tx_packets accounting used by the coalescing logic is
unaffected, and stmmac_tso_get_num_desc() already counts the context 
descriptor,
so the stmmac_tx_avail() check is unchanged as well. The
WARN_ON(tx_q->tx_skbuff[tx_q->cur_tx]) that followed the old cur_tx 
update is
dropped: it checked the first data slot, which the WARN_ON on
tx_q->tx_skbuff[entry] right after the first_entry assignment already 
covers.

v2 follows in a moment.

Regards,
Linkui

> 
> Regards,
> Lorenzo
> 
>>   	}
>>   
>>   	if (netif_msg_pktdata(priv)) {
>> -- 
>> 2.25.1
>>
>>

