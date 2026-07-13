Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697639AD55;
	Mon, 13 Jul 2026 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957199; cv=none; b=XEkFSSQvGqRlbpe3GUsJtjbWGsk2O2ofkz8sQCpXL6bB48OUiOTcKoLjTOTtBLpeooEgr5oELN09w0zqxWjIcHiSWOxifB+cnRRa7DOqEc8/hiYVRYxZjHvn4bX3MAkXYi1Gz63lsgNw+GsbOik6GBRV/i5tEZcLz91CfkoEX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957199; c=relaxed/simple;
	bh=a3LFPgwajJPAscJ6DXC3qeheBeKNUzUizg5FsJLEH7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCbbdNSoijXu2Phm4k4DesEGfvlAcTlMCGX7VsepxC/tJx0f7RCfa8TakjUH52oZu/g9EhXuQ/+jCqRF0hkBhUeD6S5d/jVYOJEUgjbMXywup9S/r3UMh/uSkq/sK8BGXQpe6GmEA8MDhr3XYLQLhjtA8HxHy1VCi62sTfFH9ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=HhTFZJ70; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="HhTFZJ70"
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5DA7C28009D;
	Mon, 13 Jul 2026 15:39:48 +0000 (UTC)
Received: from [10.2.0.2] (unknown [159.26.103.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 95BF913C2B0;
	Mon, 13 Jul 2026 08:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 95BF913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1783957186;
	bh=a3LFPgwajJPAscJ6DXC3qeheBeKNUzUizg5FsJLEH7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HhTFZJ70lm7XN2Q4cUQlbZyuGC9n89gTiaNJNLAOjxw3KC2B37EOGV6HOdRQno0tj
	 4j6l6OR68GsWU+Wb50R4JBizJPIgRd3eHUx4x0zlzmzFRhzfp1NOijBKmRocXfZPUH
	 wW+fH7B/ez4mKTyuV4nOvAKd7Vovq1orP/LaW52Q=
Message-ID: <77f80b8f-7853-436d-a8e7-c0d0cbf4c7a9@candelatech.com>
Date: Mon, 13 Jul 2026 08:38:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7996: fix TX DMA mapping leak for ADDBA-req
 frames
To: Yang Liu <liu.y@nyu.edu>, nbd@nbd.name, lorenzo@kernel.org,
 ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
 linux-wireless@vger.kernel.org, stable@vger.kernel.org
References: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
Content-Language: en-US
From: Rory Little <roryl@candelatech.com>
In-Reply-To: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1783957189-icRjjv--gqMN
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1783957189;icRjjv--gqMN;<roryl@candelatech.com>;2588f62351a8b819464ea904fec4eea5
X-PPE-TRUSTED: V=1;DIR=OUT;

On 6/28/26 03:11, Yang Liu wrote:
> mt7996 hands the firmware a HW MAC-TXP for ADDBA-req action frames
> (MT_TXD7_MAC_TXD, set in mt7996_mac_write_txwi_80211()), but the chip is a
> FW-TXP device, so on TX completion mt76_connac_txp_skb_unmap() decodes
> the per-frame txp as a struct mt76_connac_fw_txp.  For a MAC-TXP the
> fw_txp.nbuf byte aliases the high byte of the TID word
> (MT_TXP1_TID_ADDBA, GENMASK(14, 12)), which is always zero, so the
> unmap loop runs zero times and buf[1] (the skb DMA mapping) is never
> unmapped. mt7996_tx_prepare_skb() also sets buf[1].skip_unmap
> unconditionally, so the generic mt76 DMA-ring cleanup skips it as well.
> 
> Each ADDBA req therefore leaks one TX DMA mapping, i.e. roughly one per
> (re)association.  When WED is enabled the mt76 DMA device bounces these
> mappings through the WED swiotlb pool, so under continuous client
> reconnect churn the pool is exhausted after ~1-2 days, after which DMA
> mapping fails for WED, the WiFi MCU and other on-SoC consumers.
> 
> Only set buf[1].skip_unmap on the FW-TXP path. For MAC-TXD frames
> leave it clear so mt76_dma_tx_cleanup_idx() unmaps buf[1]. The FW
> unmap is a no-op for these frames (nbuf reads 0), so there is no double
> free.
> 
> Fixes: cb6ebbdffef2 ("wifi: mt76: mt7996: support writing MAC TXD for
> AddBA Request")
> Cc:stable@vger.kernel.org
> Assisted-by: Claude-Code:claude-opus-4-8
> Signed-off-by: X<50459973+ly4096x@users.noreply.github.com>
> ---
> Tested on a Banana Pi R4 Pro (MT7988A, MT7996/BE14, WED enabled, 6.18.35):
> under a continuous client (re)association reproducer (~51 reassoc/min),
> /sys/kernel/debug/swiotlb/io_tlb_used grew ~25 slots/min before this
> patch (steady leak; pool exhaustion and the resulting DMA failures after
> ~1-2 days) and is flat after it, with no double free.


Hi, this patch worked for me; I am not seeing a DMA mapping leak after 
applying it.

> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
> @@ -1010,6 +1010,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
> void *txwi_ptr,
>       struct mt76_txwi_cache *t;
>       int id, i, pid, nbuf = tx_info->nbuf - 1;
>       bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
> +    bool mac_txd;
>       __le32 *ptr = (__le32 *)txwi_ptr;
>       u8 *txwi = (u8 *)txwi_ptr;
>       u8 link_id;
> @@ -1096,7 +1097,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
> void *txwi_ptr,
>       /* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
>        * req
>        */
> -    if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
> +    mac_txd = le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD;
> +    if (mac_txd) {
>           u32 val, mac_txp_size = sizeof(struct mt76_connac_hw_txp);
> 
>           ptr = (__le32 *)(txwi + MT_TXD_SIZE);
> @@ -1167,7 +1169,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev
> *mdev, void *txwi_ptr,
> 
>       /* pass partial skb header to fw */
>       tx_info->buf[1].len = MT_CT_PARSE_LEN;
> -    tx_info->buf[1].skip_unmap = true;
> +    /* MAC-TXD (ADDBA-req) frames use a HW MAC-TXP that the fw-txp
> +     * mt76_connac_txp_skb_unmap() path does not unmap; free buf[1] via the
> +     * DMA-ring cleanup for them instead.
> +     */
> +    tx_info->buf[1].skip_unmap = !mac_txd;
>       tx_info->nbuf = MT_CT_DMA_BUF_NUM;
> 
>       return 0;
> -- 2.53.0
> 

I am not sure if this is the right way to make the fix, though. Your 
unmap occurs during mt76_queue_tx_cleanup, which happens before we 
receive the txwi token back from FW. I am concerned that we could unmap 
the skb before FW has indicated to us via an explicit tx-free that it 
has finished with the frame, which occurs later in mt7996_txwi_free. My 
suggestion would be to replace the generic mt76_connac_txp_skb_unmap 
call with something mt7996 specific, which inspects the TXD to determine 
FW/HW TXP layout in order to unmap the frame.

static void
mt7996_txp_skb_unmap(struct mt7996_dev *dev, struct mt76_txwi_cache *t)
{
	struct mt76_connac_txp_common *txp;
	struct mt76_connac_txp_ptr *ptr;
	__le32 *txwi;
	u16 len;

	txp = mt76_connac_txwi_to_txp(&dev->mt76, t);
	txwi = (__le32 *)mt76_get_txwi_ptr(&dev->mt76, t);

	if (le32_to_cpu(txwi[7]) & MT_TXD7_MAC_TXD) {
		ptr = &txp->hw.ptr[0];
		len = le16_to_cpu(ptr->len0);
		dma_unmap_single(dev->mt76.dev, le32_to_cpu(ptr->buf0), len,
				 DMA_TO_DEVICE);
		MT76_COUNT_DMA_UNMAP(&dev->mt76, le32_to_cpu(ptr->buf0));
	} else {
		mt76_connac_txp_skb_unmap_fw(&dev->mt76, &txp->fw);
	}
}

I could be wrong, though, and the early unmap may be safe.

- Rory

