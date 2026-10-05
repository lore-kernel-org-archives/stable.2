Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB361E1024;
	Mon,  5 Oct 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791165591; cv=none; b=AAP/IsKShn2XbTBFUSeEFU24HR3V8VqNcL2upBCZ+l8WdGEA4vJy3LBJ43wkBY/cfColRFfC2vGryvUy9jKFdUKJwO4bbpomvIMqppH636YR8+gMlfblXV4gAO1Q8DwdMMtq0tflApb3577TMbC2tjsk9NzWuQytfpcIdifJreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791165591; c=relaxed/simple;
	bh=m4ZvolLG6qXEeC2MaKCZsOhrBUC22dM9MDJUioMDoLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lThnGFlWySRoFsECfCKbLNjmgf0WJSunMrkSCPjIumuwJBcTPn/LjSp0RtLtWZwR7PEbaN0rZFBseNM6WDu8mRf5gyWqywsHaoGJ4YAcnaaIvnbDWAI0OzmsZMZuYM1kcMsDMcpS5trAk6vcLqc7TBU9U8wEQ4E8CompaTjLqK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP+Z+vID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP+Z+vID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DAE1F000FF;
	Mon,  5 Oct 2026 01:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791165590;
	bh=S81Jkyg53tg9Cb4q3mlJUK/brQT/ZeM6KyvV+SZhmMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IP+Z+vIDh0fjbBBLkEXSpVGySknaJjmRwwenRBdGiFNjmF4I7J7mAtUNQkrH3dG2W
	 JyTsORHyphpGcpN3uvvrc3bOR6MdrMUzcA/Wpx0EDM2B0cP2OKTyn0GKv1zvbmhpZ5
	 dNwlKtPKzHaZixPespkHqzqvZQUHRTFb/OYqgS2WPm1kXKqRmF6HJfZzJPPkcGwEoV
	 0eEYF+C9/5fTcOAyT2Xr9zLo2yf5MIXYfCbuBW/DNkCiNt2AT94y3BL+9TAdvgXaWc
	 RSFtiMsRfHjiLv0njcM/7rPXUnfE3Jq0wDfdDKtPnb4NQdISXnh5fbyd2sOBFnOtaT
	 QXfJ7+Gsj9RZw==
Message-ID: <ef6eb827-71a6-40a6-a4b7-8e514ab595d3@kernel.org>
Date: Mon, 5 Oct 2026 03:59:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Michael Chan <michael.chan@broadcom.com>
Cc: Stefan Fleischmann <sfle@kth.se>, netdev@vger.kernel.org,
 stable@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 regressions@lists.linux.dev, Joe Damato <joe@dama.to>
References: <20261004122616.56714cbd@nargothrond>
 <f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
 <20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
 <919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
 <854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
 <CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
Content-Language: en-US
From: Eric Dumazet <edumazet@kernel.org>
In-Reply-To: <CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/5/26 00:29, Michael Chan wrote:
> 
> I think skb->len is not updated with the padded length here.  So the
> HW will drop the packet seeing that the length is too short.  There is
> another skb_put_padto() that might work better?

+1 Exactly, thanks!

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c 
b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 
d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b449982b791e8acc831 
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
+       if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
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


