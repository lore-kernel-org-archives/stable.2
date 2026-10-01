Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2B47ACE8;
	Thu,  1 Oct 2026 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880839; cv=none; b=jvQApq1fDsInpW0rENKIgbzMPn9KZNZYI90/zyCyOWnCILu0tQrtXMLPTawuFgyeJ7C1nTbXgpP5w9v3J9/nLyh9iciyV5u7l/6PAGAnSBiIfkKIjeWbIkm0+86d4KraEd3Qcuk4Ig45mFIFyXW9F6W4Tyqf76+3ZnWhtrosk8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880839; c=relaxed/simple;
	bh=UMyV8reDO5sWnz9GACUZmMEbdNu3kJvYPc9kOo95qWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EG3DQstXhYpasQ4cwwDfPVnnnpTJBg3Pb0ikMk38vk+LdNY0R2g6TtFSE/Xp5lxyJnGL2hwXOWNN2V3ESvi8yFYI1LQIyU0+PexlEH+xFuB/Zv8shm8H24uyM6zPOJoe9rq9pkTwD0BsIQqdi+81c/N2HYocSYqPr9BLuIbNkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=buRkqu3z; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="buRkqu3z"
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 35197240078;
	Thu,  1 Oct 2026 18:53:44 +0000 (UTC)
Received: from [192.168.100.159] (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 3D81D13C2B0;
	Thu,  1 Oct 2026 11:53:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3D81D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1790880823;
	bh=UMyV8reDO5sWnz9GACUZmMEbdNu3kJvYPc9kOo95qWU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=buRkqu3z/nmODagpzW9n4bC5PSMuyG1L1nnClis5ffYXGgdE2TQIz29HD5DNtSSrz
	 oiu2/248+ZNoBmy5Chph1DIhKindkqJyCjuTxxciHNrExAjprEcyC27zdF+QZDDhQK
	 SbF+UG0/Wpdu7PUT/kTrTUaKURr8CsdXc2bmERlk=
Message-ID: <3c8de083-510c-302a-c053-2208a71ce688@candelatech.com>
Date: Thu, 1 Oct 2026 11:53:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH wireless] wifi: mt76: connac3: check headroom before
 pushing EHT radiotap TLVs
Content-Language: en-US
To: Chris Kelly <hoopyfrood42@gmail.com>, linux-wireless@vger.kernel.org
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
 shayne.chen@mediatek.com, sean.wang@mediatek.com, deren.wu@mediatek.com,
 mingyen.hsieh@mediatek.com, lucid_duck@justthetip.ca, stable@vger.kernel.org
References: <20261001184529.502048-1-hoopyfrood42@gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20261001184529.502048-1-hoopyfrood42@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1790880826-b99dRdgfoXhI
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;at1;1790880826;b99dRdgfoXhI;<greearb@candelatech.com>;8e79c67b7c8bcdd2d6d47d6128113a80
X-PPE-TRUSTED: V=1;DIR=OUT;

On 10/1/26 11:45, Chris Kelly wrote:
> mt76_connac3_mac_decode_eht_radiotap() pushes the EHT and U-SIG radiotap
> TLVs, 64 bytes, in front of the frame without checking that the skb has
> room for them. It may not: the rx skb is built over the buffer with
> nothing reserved -- mt76u_build_rx_skb() with MT_DRV_RX_DMA_HDR on USB,
> mt76_dma_rx_process() with a zero buf_offset on PCIe -- so the only
> headroom is the RX descriptor that mt7925_mac_fill_rx() pulls. A
> descriptor carrying the P-RXV (group 3) but no C-RXV (group 5) leaves 48
> bytes: the EHT TLV takes all of them and the U-SIG push runs past
> skb->head.

Can you also increase the headroom when monitor mode is active so that it
can report the data?

Thanks,
Ben

> 
> Seen once on an MT7925 USB adapter in monitor mode, hopping channels:
> 
>    skbuff: skb_under_panic: text:ffffffffc16f4a3c len:164 put:16 head:ffff8d4132ca3000 data:ffff8d4132ca2ff0 tail:0x94 end:0xec0 dev:<NULL>
>    kernel BUG at net/core/skbuff.c:214!
>    RIP: 0010:skb_panic+0x59/0x5b
>    Call Trace:
>     skb_push.cold+0x14/0x14
>     mt76_connac3_mac_radiotap_push_tlv+0x1c/0x80 [mt76_connac_lib]
>     mt76_connac3_mac_decode_eht_radiotap+0x7a/0x1d0 [mt76_connac_lib]
>     mt7925_queue_rx_skb+0x686/0xde0 [mt7925_common]
>     mt76u_process_rx_entry+0x2eb/0x330 [mt76_usb]
>     mt76u_rx_worker+0xeb/0x2b0 [mt76_usb]
> 
> Leave the EHT fields out of the radiotap header when there is no room
> for them; the frame is still delivered with the rest.
> 
> Fixes: 97d7ab9f51ec ("wifi: mt76: mt7925: add EHT radiotap support in monitor mode")
> Cc: stable@vger.kernel.org
> Tested-by: Devin Wittmayer <lucid_duck@justthetip.ca>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Chris Kelly <hoopyfrood42@gmail.com>
> ---
>   drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> index 651fcd4..0ed8ee7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac3_mac.c
> @@ -210,6 +210,17 @@ void mt76_connac3_mac_decode_eht_radiotap(struct sk_buff *skb, __le32 *rxv,
>   		      "Should push tlv at the top of mac hdr"))
>   		return;
>   
> +	/* The TLVs are pushed in front of the frame, into its headroom. The
> +	 * skb is built over the rx buffer with nothing reserved, on USB and
> +	 * PCIe alike, so that headroom is only the RX descriptor just pulled:
> +	 * 48 bytes with the P-RXV and no C-RXV, less than the 64 the EHT and
> +	 * U-SIG TLVs take, and skb_push() past skb->head is a kernel BUG.
> +	 * Leave the EHT fields out then.
> +	 */
> +	if (skb_headroom(skb) < 2 * sizeof(struct ieee80211_radiotap_tlv) +
> +				sizeof(*eht) + sizeof(u32) + sizeof(*usig))
> +		return;
> +
>   	eht = mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOTAP_EHT,
>   						 sizeof(*eht) + sizeof(u32));
>   	usig = mt76_connac3_mac_radiotap_push_tlv(skb, IEEE80211_RADIOTAP_EHT_USIG,

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


