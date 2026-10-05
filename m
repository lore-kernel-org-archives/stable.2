Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C24455611;
	Mon,  5 Oct 2026 09:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193457; cv=none; b=sNUCbGpYggnmKnbrlUYxRh2Tv5Tx3TorhhC5+b0mnazs1PlBDZ31TdqzyGadvO0SVTSyzOT0tm1yC3DAysjU9IK/VjjbleYhxjPlzqt3A/a0G3+Wlp7pYsRZis+QGjY/yGyzNZlhLPc/5uqyPuoaCP/NyFU/ePXJ6ej/bFeIfKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193457; c=relaxed/simple;
	bh=GtNUkrjiyoR3HoJ+MKNfmUoiGx8WdpZWdDBCuQbciUs=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:MIME-Version:
	 Message-Id:Content-Type; b=j3zZf0c5cuOtofK3WhSwC+KJTOTL+iq2pQg1GI5Ld0vYAsR1PZ1Vr4zZ8ggELp63SL4lT8lUfHbci0QkvbjcDJq3F5WjZLgeIfE/gMrhUTmC/e0cUFKjy0oqeNSjFV9EZgG9AY1zzrtpa9hPbU/iLkhaz/YDpRxWnm5wi7jl//g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id F257947BD2;
	Mon, 05 Oct 2026 11:44:07 +0200 (CEST)
Date: Mon, 05 Oct 2026 11:44:04 +0200
From: Fabian =?iso-8859-1?q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Subject: Re: [REGRESSION] Commit 447cbe95ebb9 causes IOMMU DMA faults on
 macvlan/vlan with bnxt_en
To: Eric Dumazet <edumazet@kernel.org>, Michael Chan
	<michael.chan@broadcom.com>
Cc: Joe Damato <joe@dama.to>, netdev@vger.kernel.org, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, regressions@lists.linux.dev, Stefan Fleischmann
	<sfle@kth.se>, stable@vger.kernel.org
References: <20261004122616.56714cbd@nargothrond>
	<f0c52ecb-b85d-4a53-8329-a8d2fd5d72b8@kernel.org>
	<20261004163532.3134dd41@nargothrond> <20261004192902.3ab3b7f3@nargothrond>
	<919dcfaa-005f-4bfd-8889-39acda5f7a92@kernel.org>
	<854f3985-a4ab-4014-b18d-9fead61602e1@kernel.org>
	<CACKFLine2gKepH57mg5j2YYWsX-qU8-EfJfnqWiYUEhpXL1F9Q@mail.gmail.com>
	<ef6eb827-71a6-40a6-a4b7-8e514ab595d3@kernel.org>
In-Reply-To: <ef6eb827-71a6-40a6-a4b7-8e514ab595d3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: astroid/0.17.0 (https://github.com/astroidmail/astroid)
Message-Id: <1791193344.w5j2m55mib.astroid@yuna.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1791193447309

On October 5, 2026 3:59 am, Eric Dumazet wrote:
>=20
>=20
> On 10/5/26 00:29, Michael Chan wrote:
>>=20
>> I think skb->len is not updated with the padded length here.  So the
>> HW will drop the packet seeing that the length is too short.  There is
>> another skb_put_padto() that might work better?
>=20
> +1 Exactly, thanks!

FWIW, we suspect we have quite a few users running into this since
importing upstream changes from 7.2.2-7.2.5.

Will report back once we've provided those users with a kernel with the
below diff.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c=20
> b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index=20
> d7728d0c5b6e63ee72de9dea54426bb4c8b7a9fc..7ea27e81e88c5ca82a453b449982b79=
1e8acc831=20
> 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -486,7 +486,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=20
> *skb, struct net_device *dev)
>          struct netdev_queue *txq;
>          int i;
>          dma_addr_t mapping;
> -       unsigned int length, pad =3D 0;
> +       unsigned int length;
>          u32 len, free_size, vlan_tag_flags, cfa_action, flags;
>          struct bnxt_ptp_cfg *ptp =3D bp->ptp_cfg;
>          struct pci_dev *pdev =3D bp->pdev;
> @@ -672,14 +672,12 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=20
> *skb, struct net_device *dev)
>          }
>=20
>   normal_tx:
> -       if (length < BNXT_MIN_PKT_SIZE) {
> -               pad =3D BNXT_MIN_PKT_SIZE - length;
> -               if (skb_pad(skb, pad))
> -                       /* SKB already freed. */
> -                       goto tx_kick_pending;
> -               length =3D BNXT_MIN_PKT_SIZE;
> +       if (skb_put_padto(skb, BNXT_MIN_PKT_SIZE)) {
> +               /* SKB already freed. */
> +               goto tx_kick_pending;
>          }
> -
> +       length =3D skb->len;
> +       len =3D skb_headlen(skb);
>          mapping =3D dma_map_single(&pdev->dev, skb->data, len,=20
> DMA_TO_DEVICE);
>=20
>          if (unlikely(dma_mapping_error(&pdev->dev, mapping)))
> @@ -759,10 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff=20
> *skb, struct net_device *dev)
>                  txbd->tx_bd_len_flags_type =3D cpu_to_le32(flags);
>          }
>=20
> -       flags &=3D ~TX_BD_LEN;
> -       txbd->tx_bd_len_flags_type =3D
> -               cpu_to_le32(((len + pad) << TX_BD_LEN_SHIFT) | flags |
> -                           TX_BD_FLAGS_PACKET_END);
> +       txbd->tx_bd_len_flags_type |=3D cpu_to_le32(TX_BD_FLAGS_PACKET_EN=
D);
>=20
>          netdev_tx_sent_queue(txq, skb->len);
>=20
>=20
>=20
>=20
>=20

