Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CA40B112;
	Wed,  7 Oct 2026 06:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791355895; cv=none; b=ksQLXRENqtrl66Vainxxba2aTw9cMgmVvuDTEFAa3I79sWe8KvVwxqeO4QRMbyCA+Gu6p6ejwS998DeMqlkU2BbG5hVUN7FYSk/lCYlL7d18ruSETOT0en2Z6Mkhka/BHtuc8xvXRACdZPq9iLRSHSQEr+ZHhxUgl83p6tcgGA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791355895; c=relaxed/simple;
	bh=KfHGF8Eh/o6TnDUuA44CBHtFbaVHKAS5slJ9Lv1puP4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=XSVdOcPo5uucf8cTSaDKC4mTvfSapSM6BacAKxg22r6chdWShd7OfdoD29JJ3Eb/3wfOq3aD3Xjf7eAwbCrYdKmUhIcOosefQKRtMLPxWkPBWjc9GSZ8K6J8FM1gqLehql0NEHY7saqkOUvI4FcVmwG5gc2beQqM99DpbvPxKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8EB0A423AD;
	Wed, 07 Oct 2026 08:51:22 +0200 (CEST)
Date: Wed, 07 Oct 2026 08:51:17 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small
 packets
To: Bernhard Schmidt <berni@debian.org>, Salvatore Bonaccorso
	<carnil@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Eric Dumazet
	<edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Michael Chan <michael.chan@broadcom.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, Stefan Fleischmann <sfle@kth.se>,
	stable@vger.kernel.org
References: <20261005023812.130639-1-edumazet@kernel.org>
	<asOHdc6HMSVrS9z9@eldamar.lan> <asOzkZIrKusyF1d0@fliwatuet.svr02.mucip.net>
In-Reply-To: <asOzkZIrKusyF1d0@fliwatuet.svr02.mucip.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1791355804.90wql0jw19.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791355880511

On October 5, 2026 4:26 pm, Bernhard Schmidt wrote:
> On 05/10/26 01:18 PM, Salvatore Bonaccorso wrote:
>> Hi,
>>=20
>> On Mon, Oct 05, 2026 at 04:38:12AM +0200, Eric Dumazet wrote:
>> > Stefan Fleischmann reported Intel IOMMU DMA Read faults on BCM57412
>> > NetXtreme-E NICs when transmitting packets on VLAN/macvlan interfaces:
>> >=20
>> >   DMAR: [DMA Read NO_PASID] Request device [18:00.0] fault addr 0xfc49=
9000
>> >         [fault reason 0x06] PTE Read access is not set
>> >   bnxt_en 0000:18:00.0 eno1np0: Abandoning msg {0xb4 0x41a} len: 0 due=
 to firmware status: 0x2000001
>> >   ...
>> >   NETDEV WATCHDOG: eno1np0 (bnxt_en): transmit queue 0 timed out
>> >=20
>> > The fault address (0xfc499000) is on an exact 4KB page boundary,
>> > pointing to a DMA read buffer overrun.
>> >=20
>> > In bnxt_start_xmit(), packets smaller than BNXT_MIN_PKT_SIZE (52 bytes=
),
>> > such as 42-byte untagged ARP frames, are padded:
>> >=20
>> >     if (length < BNXT_MIN_PKT_SIZE) {
>> >         pad =3D BNXT_MIN_PKT_SIZE - length;
>> >         if (skb_pad(skb, pad))
>> >             goto tx_kick_pending;
>> >         length =3D BNXT_MIN_PKT_SIZE;
>> >     }
>> >=20
>> >     mapping =3D dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVI=
CE);
>> >     ...
>> >     dma_unmap_len_set(tx_buf, len, len);
>> >=20
>> > However, 'len' was initialized earlier to skb_headlen(skb) (e.g. 42 by=
tes)
>> > and is left unadjusted after padding. Consequently, dma_map_single() a=
nd
>> > dma_unmap_len_set() map and track only 42 bytes.
>> >=20
>> > Later, the hardware TX buffer descriptor is programmed with the padded=
 length:
>> >=20
>> >     txbd->tx_bd_len_flags_type =3D
>> >         cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
>> >                     TX_BD_FLAGS_PACKET_END);
>> >=20
>> > The NIC DMA engine is thus instructed to read 52 bytes from a region w=
here
>> > only 42 bytes were DMA-mapped. If skb->data ends near the boundary of =
a 4KB
>> > page (within 'pad' bytes of the next page), the hardware DMA read over=
runs
>> > into the unmapped adjacent page, triggering an IOMMU fault.
>> >=20
>> > This issue was exposed after commit 447cbe95ebb9 ("vlan: fix skb_under=
_panic
>> > and races when toggling HW VLAN offload") because reserving extra VLAN
>> > headroom rounded LL_RESERVED_SPACE from 48 up to 64 bytes, shifting sk=
b->data
>> > offsets and potentially causing small frames to land right against pag=
e
>> > boundaries.
>> >=20
>> > Fix this by using skb_put_padto(skb, BNXT_MIN_PKT_SIZE) in the normal_=
tx
>> > path. This ensures skb->len and skb_headlen(skb) reflect the padded si=
ze so
>> > that dma_map_single() maps the full buffer and the descriptor length i=
s
>> > consistent. This also removes the temporary 'pad' variable and masking=
 logic.
>> >=20
>> > Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
>> > Cc: stable@vger.kernel.org
>> > Reported-by: Stefan Fleischmann <sfle@kth.se>
>> > Closes: https://lore.kernel.org/netdev/20261004122616.56714cbd@nargoth=
rond/
>> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > ---
>> > Cc: Michael Chan <michael.chan@broadcom.com>
>> > Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>
>> > Cc: Andrew Lunn <andrew+netdev@lunn.ch>
>> > ---
>> >  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 19 +++++++------------
>> >  1 file changed, 7 insertions(+), 12 deletions(-)
>> >=20
>> > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/e=
thernet/broadcom/bnxt/bnxt.c
>> > index d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b=
449982b791e8acc831 100644
>> > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> > @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff =
*skb, struct net_device *dev)
>> >  	struct netdev_queue *txq;
>> >  	int i;
>> >  	dma_addr_t mapping;
>> > -	unsigned int length, pad =3D 0;
>> > +	unsigned int length;
>> >  	u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>> >  	struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>> >  	struct pci_dev *pdev =3D bp->pdev;
>> > @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buf=
f *skb, struct net_device *dev)
>> >  	}
>> > =20
>> >  normal_tx:
>> > -	if (length < BNXT_MIN_PKT_SIZE) {
>> > -		pad =3D BNXT_MIN_PKT_SIZE - length;
>> > -		if (skb_pad(skb, pad))
>> > -			/* SKB already freed. */
>> > -			goto tx_kick_pending;
>> > -		length =3D BNXT_MIN_PKT_SIZE;
>> > +	if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
>> > +		/* SKB already freed. */
>> > +		goto tx_kick_pending;
>> >  	}
>> > -
>> > +	length =3D skb->len;
>> > +	len =3D skb_headlen(skb);
>> >  	mapping =3D dma_map_single(&pdev->dev, skb->data, len, DMA_TO_DEVICE=
);
>> > =20
>> >  	if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
>> > @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=
 *skb, struct net_device *dev)
>> >  		txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags);
>> >  	}
>> > =20
>> > -	flags &=3D ~TX_BD_LEN;
>> > -	txbd->tx_bd_len_flags_type =3D
>> > -		cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
>> > -			    TX_BD_FLAGS_PACKET_END);
>> > +	txbd->tx_bd_len_flags_type |=3D cpu_to_le32(TX_BD_FLAGS_PACKET_END);
>> > =20
>> >  	netdev_tx_sent_queue(txq, skb->len);
>> > =20
>> > --=20
>> > 2.53.0
>>=20
>> FWIW, got as well reported in Debian for an update in the 6.12.y
>> series: https://bugs.debian.org/1149564 , in case you would like to
>> add a further Link/Closes reference. Bernhard Schmidt is testing the
>> patch as well on top of 6.12.111 (what we have right now in Debian)
>> and looks promissing: https://bugs.debian.org/1149564#89 .
>>=20
>> Berhard, want to report back a Tested-by from you?
>=20
> Looks good. Machine has been stable with that patch applied to 6.12
>=20
> Tested-by: Bernhard Schmidt <berni@debian.org>
>=20
> Bernhard

Our users' testing (on top of 7.0.14 with 7.1.x and 7.2.x stable patches
mostly added on top) came back positive as well. Since I don't have
access to the hardware myself, and can neither reproduce nor rest, not
sending a T-b..

