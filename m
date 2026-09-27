Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F993AA9F4
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790486122; cv=none; b=Rgg153bcpY5Tj1Hp6/ihHC5fu8G6D8VEckzGATeXDlqxzQpa+aitp3cmk8yCA2I6HHufzTeEW6kUVAWRCc7hqupmmU3vHEGarHCaRlkoPgIpGEz02VWhNZCJwYC7oUxZhuabxmTdMd7oJi3Bj3IPJc1s6ejOzjlNfcw006siJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790486122; c=relaxed/simple;
	bh=Mj6a9MgdGCqWYAQGPhRA9sgl7Qe9WwUI4ge989Hfa88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOZ1e4/GjPOeZ+T90oTCgPM2H5BEJ/YiZimTRVBd+tUSyYH9MuAyPKSM0gmI02SgqsULNPOUYt/aopYlZh0zMc23FeEK+P2Pucp9Qbj10GtcQmDliCw0Z8b9cTtMmX2QlmioGwrp3m92uHSMV+F0iCr+Woi25zi0/8MfIF2l10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtbCbEAL; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtbCbEAL"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-8804b59404aso834276b3a.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 22:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790486120; x=1791090920; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OjKSfukDZvlY1eXjlV/PoddSyojDKst8RtQu8NrZS7I=;
        b=OtbCbEALZGSTOiKY8BVEckLUD9ldbK5dm0D6aa1cI8I730FdFdac2alwxRhh1HRViV
         n+dtNgfbhS32jt0q9eWBN1IDQMMSVtDChdhx+EUPOdVJfeu3oLExKxGDY0SfAOn4YzYO
         kAVraD65UwfYXeB+lagYMhT6HMyGBZaJFyZ184/Giu4NA0JESZoqWl6LR0vdvSxVUJiq
         Sg2QkGJjqWxLbt6BwejAAoInbSp25n2CTW5XMLW/mvKGxFaWjbnFG3UYojN7Pi5FusK9
         /9pt9Obi8op9riSFp11xFxT4SvUEySRU/44Duh5F05BsNTYBW+jk0UhDq0mfHxHCssHM
         /gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790486120; x=1791090920;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OjKSfukDZvlY1eXjlV/PoddSyojDKst8RtQu8NrZS7I=;
        b=0mLIgg89s9Sm3vKL6HmOVYxR4sZoztS2QvA9e1ntyzRNzZiE1g9mtVdBQwM9oEDxE6
         iJ/LDFszPyXQB5yXc1T+vDbHCSyH3OTxI5mVlORCRux67tmM00Q+EpzfeXtnbAiu1eth
         9STYACLckik6U0v43mPkIUA+iAXk2I7KvFF+MXz5dm2mQGF7ht8v0OE5Bhjx99F6dMph
         dzQiweZXJQz3LgvQ9hEtImM285aAKOhDFIpSuYuKgPbCvoOB4qN71jQVXYveHj64B+em
         /mj2VJjR/TxQmLXASWiur7/cJ+vu9Fuw6f8InFXgTprewLVPU+2Gj31ATDbWBlkdjNzB
         R6/g==
X-Forwarded-Encrypted: i=1; AKwUvBwPDDsA98QYt/H2bCXwQ1ED3eBRnzwp3YaUvFI9acuEabysRmpm4ZliBDkgd5JpInq2sbuOy+w=@vger.kernel.org
X-Gm-Message-State: AFuF++l+cENXh/fCKxKweUhtz3kv7tjk+DkZbkPN7LkBUJX8qkcj2uPj
	M5cC35X2mHk9tl6brOLguCj495cBwGP9fmsxCtl+N9aNYhrvHk4HQWpv
X-Gm-Gg: AYBFou2wB2DDhNMryzfvBGZmaBFV0dJQVASoOEQyZji9tLlNZLvrexXfQHDxCgpGxny
	kbp8wuzT0AHj6r2LoK5vbHOWVivGoyYbfcZnOlYWoxLvj1ww1/YM0dpmm1Nkj1PWe8jsaIzYzOe
	+0S4KVy9dmQY/JAv2Ikb+O4CFoPNVQFw9Hxfz1G5BnJiC1KfkxB/SJaoSckg0IAIgUfxz86N9EB
	t86RmQAUY6pGc3XbukapjZaTxge2sT8HG6IAqDEDQUexE3iljtJxK8Es5nyP5oGZzbz1LRuXZTT
	auc15VD5Edb3hC+mmnjvVY4WrxElD3NdJ/bAZKCs68DLaDk0lWa/7wBbFtaBtxDDCuzfuUKhVs1
	hEsxDaFEraiHkVLsZEnXEaRXH7liI39WsKjlI5FbMUeMzWl68MXHWcSrdFpBljsu74OEseJKFCf
	Fm26SNrQy6S6CXvb8cbB+g1hKNL8br0sE/+pBK5FthHnSyYR7u10lNbFbxvFzVJe7vpdbLng==
X-Received: by 2002:a05:6a00:464e:b0:881:e266:c3d4 with SMTP id d2e1a72fcca58-881e266c980mr1869862b3a.25.1790486119873;
        Sat, 26 Sep 2026 22:15:19 -0700 (PDT)
Received: from gmail.com ([2a03:2880:7ff:4::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87feaf852d7sm2718078b3a.42.2026.09.26.22.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 22:15:17 -0700 (PDT)
Date: Sat, 26 Sep 2026 22:14:55 -0700
From: Narcisa Vasile <narcisav.kernel@gmail.com>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: reserve RX buffer headroom to fix
 forwarding performance
Message-ID: <arimAGRnmHEAviqi@gmail.com>
References: <20260923144500.4073380-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923144500.4073380-1-hamzamahfooz@linux.microsoft.com>

On Wed, Sep 23, 2026 at 10:45:00AM -0400, Hamza Mahfooz wrote:
> Commit 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers
> instead of full pages to improve memory efficiency.") started handing
> out RX buffers with zero headroom so that two buffers fit into one page
> at the default MTU.
> 
> The MANA TX path, however, stores the per scatter-gather entry DMA
> mappings in `struct mana_skb_head` at skb->head, and mana_start_xmit()
> therefore calls skb_cow_head(skb, MANA_HEADROOM). The port advertises
> this requirement as ndev->needed_headroom = MANA_HEADROOM.
> 
> As a result every packet that is received and then forwarded out of a
> MANA port fails the skb_cow() in ip_forward() and gets reallocated and
> copied by pskb_expand_head(). This is invisible to a plain RX or TX
> workload, but it puts a full skb reallocation plus memcpy on the hot
> path of every single forwarded packet, which is exactly what a
> router/NVA workload does.
> 
> Restore the headroom. Note that reserving MANA_HEADROOM (232) is not
> enough: ip_forward() asks for LL_RESERVED_SPACE(dev), which rounds
> hard_header_len + needed_headroom up to HH_DATA_MOD and is 256 bytes on
> ethernet. Use LL_RESERVED_SPACE() directly so the value keeps tracking
> both constants.
> 
> At the default MTU on a 4K page this means a buffer no longer fits twice
> into a page (SKB_DATA_ALIGN(1500 + MANA_RXBUF_PAD + 256) = 2112), so the
> frag-vs-single decision is now made by computing the real buffer size
> instead of comparing the MTU against PAGE_SIZE / 2. The page_pool
> fragment path is still used wherever at least two buffers genuinely fit,
> e.g. on 16K and 64K page sizes.
> 
> Measured on an Azure VM with a MANA NIC acting as a forwarding NVA (UDP,
> 1400 byte payload, 4 streams, 8 Gbps offered, only the forwarding
> node's kernel differs), 8 runs each, median:
> 
>                   forwarded pps    throughput
>   before              272,830       3.06 Gbps
>   after               390,560       4.37 Gbps   (+43%)
> 
> perf on the forwarding node, same workload:
> 
>                   memset_orig   __pi_memcpy   pskb_expand_head
>   before             10.07%         3.96%         present
>   after               0.94%         0.64%         gone
> 
> Cc: stable@vger.kernel.org
> Fixes: 730ff06d3f5c ("net: mana: Use page pool fragments for RX buffers instead of full pages to improve memory efficiency.")
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 58 ++++++++++++++-----
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 591fb4191d90d..e3f3b33ba9062 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -758,6 +758,36 @@ static void *mana_get_rxbuf_pre(struct mana_rxq *rxq, dma_addr_t *da)
>  	return va;
>  }
>  
> +/* RX buffers must be allocated with enough headroom for the TX path:
> + * mana_start_xmit() stores the SGE DMA mappings in struct mana_skb_head at
> + * skb->head, which is why the port advertises ndev->needed_headroom =
> + * MANA_HEADROOM.
> + *
> + * An skb that is forwarded out of a MANA port has to satisfy
> + * skb_cow(skb, LL_RESERVED_SPACE(dev) + ...) in ip_forward(), so reserve
> + * LL_RESERVED_SPACE() here rather than just MANA_HEADROOM - it rounds
> + * hard_header_len + needed_headroom up to HH_DATA_MOD and is therefore
> + * larger. Reserving less makes every forwarded packet get reallocated and
> + * copied by pskb_expand_head().
> + */

nit: maybe trim this comment to make it easier to read. For example, 
"Reserve enough headroom to satisfy the skb_cow() call in ip_forward()
and avoid reallocation."

> +static u32 mana_get_rxbuf_headroom(struct mana_port_context *apc)
> +{
> +	u32 headroom = LL_RESERVED_SPACE(apc->ndev);
> +
> +	if (mana_xdp_get(apc))
> +		return max_t(u32, headroom, XDP_PACKET_HEADROOM);
> +
This implies that the headroom could now be greater than XDP_PACKET_HEADROOM,
in XDP case. Should we then use the actual headroom value, instead
of assuming XDP_PACKET_HEADROOM, in mana_run_xdp() when preparing the buffer:

  line 94:	xdp_prepare_buff(xdp, buf_va, XDP_PACKET_HEADROOM, pkt_len, true);

Does MANA_XDP_MTU_MAX need to be updated?

> +	return headroom;
> +}
> +
