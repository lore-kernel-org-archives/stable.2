Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BB14A49A1;
	Mon,  5 Oct 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210421; cv=none; b=BgvA4/2m1XWnZ5A65EE6IDD53fIEJxxluDUX/cjpxpxPFm4CIWm0Fjw472AGrgbf3foxZX5cBaUNXQt1S1SWPn6UgrGXx1/NYsn4g5rtEl5JIez9h6soD1H/DRYBtcKeGhJd0MCqxs7236vcVF9rmQoM7GruxiEVuDFQr1KS13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210421; c=relaxed/simple;
	bh=0yyC+ESpXKhGW9JyND6IpPYZrDmnBMh6jvBVKCFXGOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkO41OmfnLbRzQSLi6ga37A9QpGpx7PkMeKNMbGwbyP/tjCaSL1ASjJbq27CaPhxky+N9oV9wrL0WQzvz1w3jwCMCFoMS9Lv/AXv65AuX6G5Tw6D8Tb6MrkNRDmU2HVHM8boMli3BUiFPmBWGsfTvtELgbyrQAvrZ+ulZaaFyLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=CvvsrQ5z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="CvvsrQ5z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AuAjci21RomupAGSpd5pEqjhHbtI6CVTBIMXgTXsE9o=; b=CvvsrQ5zbwL1RXN83SqMLxsemp
	ptp0r7SEpnBs9NyahkiZyaTtOQSXqPjdu9q/3wuPu/b/90k32HnUlBEGcyCUeP54weCHBmyYU2kzo
	08S/GWdCPbkak0lyM8zEU7vHEt5Uc9vYWIE5Tk13h+BLHusXrMGAL0/Ucjo4NNn6AIjL5Q4QaDfUv
	BtSpT7A4KZtQzB8wsIzj7hJuwYibblQCdpReRf+I/ZaKWTZzfXg64c7fDk1Z33HaXDNGhon6s3w3K
	sSVPghPpbkBlME9R9/v+8Rgx/v2ojRLBnLonFqfTDaAp8ahziqRb+MKDOlCfeJC+8O35pbFQrGeeK
	5gj1n5MQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <berni@debian.org>)
	id 1xDje9-003G3Q-00;
	Mon, 05 Oct 2026 14:26:29 +0000
Received: from localhost (mail.svr02.mucip.net [127.0.0.1])
	by mailout.mucip.net (Postfix) with ESMTP id 4AC1B7299;
	Mon, 05 Oct 2026 16:26:27 +0200 (CEST)
Received: from mailout.mucip.net ([127.0.0.1])
 by localhost (mail.svr02.mucip.net [127.0.0.1]) (amavis, port 10125)
 with ESMTP id frvvpiVYRALC; Mon,  5 Oct 2026 16:26:27 +0200 (CEST)
Received: from fliwatuet.svr02.mucip.net (fliwatuet.birkenwald.de [IPv6:2001:1b10:1000:0:5054:ff:fe67:68e8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	by mailout.mucip.net (Postfix) with ESMTPSA id 220D52236;
	Mon, 05 Oct 2026 16:26:27 +0200 (CEST)
Date: Mon, 5 Oct 2026 16:26:25 +0200
From: Bernhard Schmidt <berni@debian.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Eric Dumazet <edumazet@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	stable@vger.kernel.org, Stefan Fleischmann <sfle@kth.se>,
	Eric Dumazet <edumazet@google.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small
 packets
Message-ID: <asOzkZIrKusyF1d0@fliwatuet.svr02.mucip.net>
References: <20261005023812.130639-1-edumazet@kernel.org>
 <asOHdc6HMSVrS9z9@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asOHdc6HMSVrS9z9@eldamar.lan>
X-Debian-User: berni

On 05/10/26 01:18 PM, Salvatore Bonaccorso wrote:
> Hi,
> 
> On Mon, Oct 05, 2026 at 04:38:12AM +0200, Eric Dumazet wrote:
> > Stefan Fleischmann reported Intel IOMMU DMA Read faults on BCM57412
> > NetXtreme-E NICs when transmitting packets on VLAN/macvlan interfaces:
> > 
> >   DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc499000
> >         [fault reason 0x06] PTE Read access is not set
> >   bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due to firmware status: 0x2000001
> >   ...
> >   NETDEV WATCHDOG: eno1np0 (bnxt_en): transmit queue 0 timed out
> > 
> > The fault address (0xfc499000) is on an exact 4KB page boundary,
> > pointing to a DMA read buffer overrun.
> > 
> > In bnxt_start_xmit(), packets smaller than BNXT_MIN_PKT_SIZE (52 bytes),
> > such as 42-byte untagged ARP frames, are padded:
> > 
> >     if (length < BNXT_MIN_PKT_SIZE) {
> >         pad = BNXT_MIN_PKT_SIZE - length;
> >         if (skb_pad(skb, pad))
> >             goto tx_kick_pending;
> >         length = BNXT_MIN_PKT_SIZE;
> >     }
> > 
> >     mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
> >     ...
> >     dma_unmap_len_set(tx_buf, len, len);
> > 
> > However, 'len' was initialized earlier to skb_headlen(skb) (e.g. 42 bytes)
> > and is left unadjusted after padding. Consequently, dma_map_single() and
> > dma_unmap_len_set() map and track only 42 bytes.
> > 
> > Later, the hardware TX buffer descriptor is programmed with the padded length:
> > 
> >     txbd->tx_bd_len_flags_type =
> >         cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> >                     TX_BD_FLAGS_PACKET_END);
> > 
> > The NIC DMA engine is thus instructed to read 52 bytes from a region where
> > only 42 bytes were DMA-mapped. If skb->data ends near the boundary of a 4KB
> > page (within 'pad' bytes of the next page), the hardware DMA read overruns
> > into the unmapped adjacent page, triggering an IOMMU fault.
> > 
> > This issue was exposed after commit 447cbe95ebb9 ("vlan: fix skb_under_panic
> > and races when toggling HW VLAN offload") because reserving extra VLAN
> > headroom rounded LL_RESERVED_SPACE from 48 up to 64 bytes, shifting skb->data
> > offsets and potentially causing small frames to land right against page
> > boundaries.
> > 
> > Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the normal_tx
> > path. This ensures skb->len and skb_headlen(skb) reflect the padded size so
> > that dma_map_single() maps the full buffer and the descriptor length is
> > consistent. This also removes the temporary 'pad' variable and masking logic.
> > 
> > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Fleischmann <sfle@kth.se>
> > Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargothrond/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> > Cc: Michael Chan <michael.chan@broadcom.com>
> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> > ---
> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++------------
> >  1 file changed, 7 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b449982b791e8acc831 100644
> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	struct netdev_queue *txq;
> >  	int i;
> >  	dma_addr_t mapping;
> > -	unsigned int length, pad = 0;
> > +	unsigned int length;
> >  	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
> >  	struct bnxt_ptp_cfg *ptp = bp->ptp_cfg;
> >  	struct pci_dev *pdev = bp->pdev;
> > @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  	}
> >  
> >  normal_tx:
> > -	if (length < BNXT_MIN_PKT_SIZE) {
> > -		pad = BNXT_MIN_PKT_SIZE - length;
> > -		if (skb_pad(skb, pad))
> > -			/* SKB already freed. */
> > -			goto tx_kick_pending;
> > -		length = BNXT_MIN_PKT_SIZE;
> > +	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> > +		/* SKB already freed. */
> > +		goto tx_kick_pending;
> >  	}
> > -
> > +	length = skb->len;
> > +	len = skb_headlen(skb);
> >  	mapping = dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE);
> >  
> >  	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
> > @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
> >  		txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
> >  	}
> >  
> > -	flags &= ~TX_BD_LEN;
> > -	txbd->tx_bd_len_flags_type =
> > -		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> > -			    TX_BD_FLAGS_PACKET_END);
> > +	txbd->tx_bd_len_flags_type |= cpu_to_le32(TX_BD_FLAGS_PACKET_END);
> >  
> >  	netdev_tx_sent_queue(txq, skb->len);
> >  
> > -- 
> > 2.53.0
> 
> FWIW, got as well reported in Debian for an update in the 6.12.y
> series: https://bugs.debian.org/1149564 , in case you would like to
> add a further Link/Closes reference. Bernhard Schmidt is testing the
> patch as well on top of 6.12.111 (what we have right now in Debian)
> and looks promissing: https://bugs.debian.org/1149564#89 .
> 
> Berhard, want to report back a Tested-by from you?

Looks good. Machine has been stable with that patch applied to 6.12

Tested-by: Bernhard Schmidt <berni@debian.org>

Bernhard
