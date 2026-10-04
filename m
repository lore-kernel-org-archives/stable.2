Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8547D471;
	Sun,  4 Oct 2026 21:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791148291; cv=none; b=NmpA7Lrpo0L1e160jHrrX6KHAE/ebcXrTniZT8i/fm9DHh+dbpo2bEMzG8+gh3O23hZqEUURjRWTUmSYc47mmVqxnoA4/8+5JLvjl9T3+9Zmn8J9zWhPoz7OtKOfuimdV/zB72hNtyH2M0Zhw+uX09Ju9rQXcSgXTxOkLJWtRTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791148291; c=relaxed/simple;
	bh=DZhEdq8mFasWzol8qqfkAUZbYB48NdumR1ZAdNHnZV8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Mywayrd9f0R7XAv9nQVeK7GHEeldff9rzwa6TzV7wzhrjLBV75/5lAdAY5j55SMFvrjmmFoBB6Q2Fw/hr2PlvL+1oNSYs7lL4QxPMpa/3c4K+K1zY9eSUE5V6Q8ztlzZk1YtcdXuxKH+Qgl4h47KM4TQYX2B6Rm+yHJ8GM3t6X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Go6zVW0C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Go6zVW0C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CED1F000FF;
	Sun,  4 Oct 2026 21:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791148289;
	bh=IrUsNEXqFQwzlpkitoF/PRUCcL6ofop0HTFSPBkuJB0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Go6zVW0CspluWyyF3H75sbYYEQLuEhLl5Iet66jfCWAZUB2CpVDrWu8nyUj0xbBAX
	 /hHuxVABuO6PyL4RYzjjbZ97DFtX96bCQeCJgDGKGlwi8+2KesGLCavZEPoeQZZiz1
	 i6qNdehSO0rBxbB13C3fi02zdUEwxEveodWvNmrBAOBGqSfmEW9ipuhwEGVEV5RxwX
	 RMx2UGUAUy1Jq4sl9GxcS/FUe4lEqhq+ikFEWfTHAfhfJPHQyqwhZms+jYJ6EPgSCZ
	 pX1pPG4l5b5UwUKALIZPOQoUfSV/Za7fFx7mrIQnMaRU7/QyqzkCynqqUqh2sa6B++
	 oHb78fq4KImuA==
Message-ID: <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
Date: Sun, 4 Oct 2026 23:11:26 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
From: Eric Dumazet <edumazet@kernel.org>
To: Stefan Fleischmann <sfle@kth.se>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, regressions@lists.linux.dev,
 Joe Damato <joe@dama.to>
References: <20261004122616.56714cbd@nargothrond>
 <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
 <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
Content-Language: en-US
In-Reply-To: <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/4/26 22:52, Eric Dumazet wrote:
> 
> 
> On 10/4/26 19:29, Stefan Fleischmann wrote:
>> On Sun, 4 Oct 2026 16:35:32 +0200
>> Stefan Fleischmann <sfle@kth.se> wrote:
>>
>>> On Sun, 4 Oct 2026 13:46:08 +0200
>>> Eric Dumazet <edumazet@kernel.org> wrote:
>>>
>>>
>>>>
>>>> Notice that 0xfc499000 is on an exact 4KB page boundary. This points
>>>> to a DMA read overrun where the Broadcom DMA engine reads past the
>>>> end of a buffer mapped in page 0xfc498xxx into the adjacent unmapped
>>>> page 0xfc499000.
>>>>
>>>> Have you tried a recent net kernel ?
>>>
>>> Hi Eric,
>>>
>>> that might be a bit tricky. We use ZFS on this server and the version
>>> we have installed only supports up to kernel 7.2.
>>
>> Scratch that, I noticed that this even happens with none of the LXC
>> containers running. So I tested with the main branch from
>>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
>>   (commit 6dc989ea46b9)
>>
>> Same issue.
> 
> Okay, this must be a bnxt issue, that has been hidden years because of 
> some skb->data headroom/offset.
> 
> LL_RESERVED_SPACE() has been increased from 48 to 64. So perhaps small 
> packets are now crossing a page boundary (which should be fine)
> 
> I see one bug in the skb_pad() vicinity. Could you try:
> 
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ 
> ethernet/broadcom/bnxt/bnxt.c
> index 
> d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..f9feeb4471a8cf310788ef8d00b68a1508a7e78e 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -678,6 +678,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff 
> *skb, struct net_device *dev)
>                          /* SKB already freed. */
>                          goto tx_kick_pending;
>                  length = BNXT_MIN_PKT_SIZE;
> +               len += pad;
>          }
> 
>          mapping = dma_map_single(&pdev->dev, skb->data, len, 
> DMA_TO_DEVICE);

A more polished patch would be this one.

bnxt_start_xmit() needs an audit I think :/

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 
d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..48e544544754b04cff891bda5bc86cc370e0aa0b 
100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
         struct netdev_queue *txq;
         int i;
         dma_addr_t mapping;
-       unsigned int length, pad = 0;
+       unsigned int length;
         u32 len, free_size, vlan_tag_flags, cfa_action, flags;
         struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
         struct pci_dev *pdev = bp->pdev;
@@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
         }

  normal_tx:
-       if (length < BNXT_MIN_PKT_SIZE) {
-               pad = BNXT_MIN_PKT_SIZE - length;
-               if (skb_pad(skb, pad))
-                       /* SKB already freed. */
-                       goto tx_kick_pending;
-               length = BNXT_MIN_PKT_SIZE;
+       if (skb_padto(skb, BNXT_MIN_PKT_SIZE)) {
+               /* SKB already freed. */
+               goto tx_kick_pending;
         }
-
+       length = skb->len;
+       len = skb_headlen(skb);
         mapping = dma_map_single(&pdev->dev, skb->data, len, 
DMA_TO_DEVICE);

         if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
@@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff 
*skb, struct net_device *dev)
                 txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
         }

-       flags &= ~TX_BD_LEN;
-       txbd->tx_bd_len_flags_type =
-               cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
-                           TX_BD_FLAGS_PACKET_END);
+       txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);

         netdev_tx_sent_queue(txq, skb->len);



