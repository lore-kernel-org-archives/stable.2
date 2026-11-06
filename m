Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974915;
	b=WRLYBJH+gMmIS+ahgZdIWDb9h/8ySCsEyQUqk6sSTwgEhpStN2bA+5SBBra0exsANqR8
	 vgtnzKnkGyIr/O51mFfZwZ6/jBAeDWy+ZK3D+qyWRk6nEbaWLoX6E6CJof3fDV9vuv2VY
	 LOIo06QoKxq+s2A4YUmZN1AE2969PkX87U4tS/nWhgH73rPILxEMCbFJPkVTcA+sviHcK
	 kF3akdYz6qRxn0RTMGUQ3OWhQU47dMGVUt8+FU5hedAZpvEonKmer/iKL48U4wAKznAlH
	 zXBI38Lhp7Xg+yBybekLasDt9Wm+Q6Y1U7v3iGHI58BPCJn4ELTmQHdcK7Tdxxc9fBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974915;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4w1ffQwzkhuFO1YskUNSB+WHf1fs6R5DfzwqOkWXzDg=;
	b=HJcvn8f4WOJlXBGe9c8wLn4t8otffLfdPptB8/ngzI+jdbj1sQedkR7zWLs9lmAgqAeX
	 ogAc0vqsC/IJWLCuGlbt7v+SBSnuDG939LkLyWj4Zy+jdUp/7OD/d+WLElsZqO1xBbMcW
	 vnuUQX6LrXGvuUACWzB3WqiLotqVhxS2LnaWNU/+paWeEmaD3Fcv04gIi0Wy1QMgzScpm
	 kkiOl5PReVtQb39lrucTQRFvs3h8JBI93b/jgs6n5wqQJojN6L6Bp8v1VEysVh8bvdjfn
	 wOi+mbfWIfvct+NGEcDOcD1n77y9tYx8PJThITAf4U+Kek7rPHkaA/fJJHiriNfX62g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ih9nz3hB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE8F606A326;
	Fri,  6 Nov 2026 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ih9nz3hB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A611F008A4;
	Fri,  6 Nov 2026 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974915;
	bh=4w1ffQwzkhuFO1YskUNSB+WHf1fs6R5DfzwqOkWXzDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ih9nz3hBrnOj+a/u//x+Uv89KdGtdo6z0gcPLZBJVjvbXGuZfsbrpUKOXP61U2f8r
	 WsyXnXJnbC9CdsFV/DhjIOo+8LfeZjysNnDm+xCAphsxdwqZ8h/MvYc5zY8F3ODt+t
	 GnDxJwMmW1oDrgtGySIT9JKidKiTQEBNpHUak+hn8BxWDYNqqi5ZYfH/FinwcQe42W
	 IGCLxbClF9IHNG325x9F/XTUQ6DmyHG6pwfxzSLNVcc10axfS30WREAk98M68wUvmY
	 iR6VUbL3YrFFMZ5hnfZa7bbValkZnH5aWDVGboRLdY7njU5XmGCZnQX+MW9wCRImYV
	 LkKtdNu5Srfbw==
Date: Fri, 6 Nov 2026 15:21:52 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Florian Maurer <fmaurer@disroot.org>
Cc: Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH wireless 1/2] wifi: mt76: npu: return rx slots to the NPU
 only after refilling them
Message-ID: <au3igPTxdz3i64SO@lore-desk>
References: <cover.1793927986.git.fmaurer@disroot.org>
 <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hjdNWhN+M75PWH0l"
Content-Disposition: inline
In-Reply-To: <d6314f34e0965464207656d38a145490b6437aa5.1793927986.git.fmaurer@disroot.org>

--hjdNWhN+M75PWH0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76_npu_dequeue() writes the new tail to the dma_idx register of the
> NPU rx ring as soon as it has consumed a frame, while the slots are
> only refilled with new buffers by mt76_npu_rx_poll() after the whole
> NAPI budget. Until then, the descriptors of the released slots still
> point to the buffers that were passed up the stack, and on the first
> round of the ring the slot that was never filled points to address 0.
> If the NPU completes one of these slots, the host processes an entry
> without buffer, which crashes in dma_sync_single_for_cpu() under heavy
> rx load:
>=20
>   Unable to handle kernel paging request at virtual address ffffffff80000=
700
>   pc : dcache_inval_poc+0x28/0x58
>   lr : arch_sync_dma_for_cpu+0x28/0x38
>   Call trace:
>    dcache_inval_poc+0x28/0x58 (P)
>    __dma_sync_single_for_cpu+0xe4/0xf8
>    mt76_npu_rx_poll+0x184/0x390 [mt76]
>    __napi_poll+0x34/0x180
>=20
> Write dma_idx after refilling the ring instead, up to the slot kept
> free in front of the tail, which is the same value as before once the
> ring is full.
>=20
> Also check that all slots of a frame are queued and complete before
> building the skb. So far a frame whose later slots were not yet
> done was freed together with the buffers of its first slots, which
> were then used again on the next poll.
>=20
> Fixes: 7fb554b1b623 ("wifi: mt76: Introduce the NPU generic layer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florian Maurer <fmaurer@disroot.org>
> ---
>  drivers/net/wireless/mediatek/mt76/npu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wirel=
ess/mediatek/mt76/npu.c
> index c4c7c0af6321..6e503a4a890c 100644
> --- a/drivers/net/wireless/mediatek/mt76/npu.c
> +++ b/drivers/net/wireless/mediatek/mt76/npu.c
> @@ -40,6 +40,11 @@ int mt76_npu_fill_rx_queue(struct mt76_dev *dev, struc=
t mt76_queue *q)
>  		nframes++;
>  	}
> =20
> +	/* Hand the slots back to the NPU only once they have a new buffer,
> +	 * up to the one kept free in front of the tail.
> +	 */
> +	Q_WRITE(q, dma_idx, (q->head + 1) % q->ndesc);

why are you writing q->head here?

> +
>  	return nframes;
>  }
> =20
> @@ -69,17 +74,22 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_d=
ev *dev,
> =20
>  	nframes =3D FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
>  	nframes =3D max_t(int, nframes, 1);
> +	if (nframes > q->queued)
> +		return NULL;

can this really occur?

> +
> +	/* Only take the frame once all of its slots are complete */
> +	for (i =3D 0; i < nframes; i++) {
> +		int idx =3D (index + i) % q->ndesc;
> +
> +		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[idx].ctrl))
> +			return NULL;
> +	}

I got your time, and I agree this is an issue we need to fix but I guess we
should avoid a double loop. What about the patch below? (just compiled and =
not
tested).

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wirele=
ss/mediatek/mt76/mt76.h
index 2ade848fe3bb..9537c6d28e8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -249,6 +249,7 @@ struct mt76_queue {
 	int ndesc;
 	int queued;
 	int buf_size;
+	int pending;
 	bool stopped;
 	bool blocked;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/npu.c b/drivers/net/wireles=
s/mediatek/mt76/npu.c
index c4c7c0af6321..e2fc361a5248 100644
--- a/drivers/net/wireless/mediatek/mt76/npu.c
+++ b/drivers/net/wireless/mediatek/mt76/npu.c
@@ -56,61 +56,74 @@ void mt76_npu_queue_cleanup(struct mt76_dev *dev, struc=
t mt76_queue *q)
 		q->tail =3D (q->tail + 1) % q->ndesc;
 		q->queued--;
 	}
+	if (q->rx_head) {
+		dev_kfree_skb(q->rx_head);
+		q->rx_head =3D NULL;
+		q->pending =3D 0;
+	}
 	spin_unlock_bh(&q->lock);
 }
=20
-static struct sk_buff *mt76_npu_dequeue(struct mt76_dev *dev,
-					struct mt76_queue *q,
-					u32 *info)
+static int mt76_npu_rx_process_entry(struct napi_struct *napi)
 {
+	struct mt76_dev *dev =3D mt76_priv(napi->dev);
+	enum mt76_rxq_id qid =3D napi - dev->napi;
+	struct mt76_queue *q =3D &dev->q_rx[qid];
 	struct airoha_npu_rx_dma_desc *desc =3D (void *)q->desc;
-	int i, nframes, index =3D q->tail;
-	struct sk_buff *skb =3D NULL;
+	int nframes =3D q->pending;
+	u32 info =3D 0;
=20
-	nframes =3D FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK, desc[index].info);
-	nframes =3D max_t(int, nframes, 1);
+	if (!nframes) {
+		nframes =3D FIELD_GET(NPU_RX_DMA_PKT_COUNT_MASK,
+				    desc[q->tail].info);
+		nframes =3D max_t(int, nframes, 1);
+	}
=20
-	for (i =3D 0; i < nframes; i++) {
-		struct mt76_queue_entry *e =3D &q->entry[index];
+	while (nframes > 0) {
+		struct mt76_queue_entry *e =3D &q->entry[q->tail];
 		int len =3D FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK,
-				    desc[index].ctrl);
+				    desc[q->tail].ctrl);
=20
-		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl)) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
+		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[q->tail].ctrl))
+			return -EBUSY;
=20
 		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
 					e->dma_len[0],
 					page_pool_get_dma_dir(q->page_pool));
=20
-		if (!skb) {
-			skb =3D napi_build_skb(e->buf, q->buf_size);
-			if (!skb)
-				return NULL;
+		if (!q->rx_head) {
+			q->rx_head =3D napi_build_skb(e->buf, q->buf_size);
+			if (!q->rx_head)
+				return -ENOMEM;
=20
-			__skb_put(skb, len);
-			skb_reset_mac_header(skb);
-			skb_mark_for_recycle(skb);
+			__skb_put(q->rx_head, len);
+			skb_reset_mac_header(q->rx_head);
+			skb_mark_for_recycle(q->rx_head);
 		} else {
-			struct skb_shared_info *shinfo =3D skb_shinfo(skb);
+			struct skb_shared_info *shinfo =3D skb_shinfo(q->rx_head);
 			struct page *page =3D virt_to_head_page(e->buf);
 			int nr_frags =3D shinfo->nr_frags;
=20
 			if (nr_frags < ARRAY_SIZE(shinfo->frags))
-				skb_add_rx_frag(skb, nr_frags, page,
+				skb_add_rx_frag(q->rx_head, nr_frags, page,
 						e->buf - page_address(page),
 						len, q->buf_size);
 		}
=20
-		*info =3D desc[index].info;
-		index =3D (index + 1) % q->ndesc;
+		info =3D desc[q->tail].info;
+		q->tail =3D (q->tail + 1) % q->ndesc;
+		q->queued--;
+		nframes--;
 	}
-	q->tail =3D index;
-	q->queued -=3D i;
+
+	dev->drv->rx_skb(dev, qid, q->rx_head, &info);
+	mt76_rx_poll_complete(dev, qid, napi);
+	q->rx_head =3D NULL;
+	q->pending =3D 0;
+
 	Q_WRITE(q, dma_idx, q->tail);
=20
-	return skb;
+	return 0;
 }
=20
 void mt76_npu_check_ppe(struct mt76_dev *dev, struct sk_buff *skb,
@@ -155,18 +168,10 @@ static int mt76_npu_rx_poll(struct napi_struct *napi,=
 int budget)
 		goto out;
=20
 	while (done < budget) {
-		struct sk_buff *skb;
-		u32 info =3D 0;
-
-		skb =3D mt76_npu_dequeue(dev, &dev->q_rx[qid], &info);
-		if (!skb)
+		if (mt76_npu_rx_process_entry(napi))
 			break;
-
-		dev->drv->rx_skb(dev, qid, skb, &info);
-		mt76_rx_poll_complete(dev, qid, napi);
 		done++;
 	}
-
 	mt76_npu_fill_rx_queue(dev, &dev->q_rx[qid]);
 out:
 	if (done < budget && napi_complete(napi))

> =20
>  	for (i =3D 0; i < nframes; i++) {
>  		struct mt76_queue_entry *e =3D &q->entry[index];
>  		int len =3D FIELD_GET(NPU_RX_DMA_DESC_CUR_LEN_MASK,
>  				    desc[index].ctrl);
> =20
> -		if (!FIELD_GET(NPU_RX_DMA_DESC_DONE_MASK, desc[index].ctrl)) {
> -			dev_kfree_skb(skb);
> -			return NULL;
> -		}
> -
>  		dma_sync_single_for_cpu(dev->dma_dev, e->dma_addr[0],
>  					e->dma_len[0],
>  					page_pool_get_dma_dir(q->page_pool));
> @@ -108,7 +118,6 @@ static struct sk_buff *mt76_npu_dequeue(struct mt76_d=
ev *dev,
>  	}
>  	q->tail =3D index;
>  	q->queued -=3D i;
> -	Q_WRITE(q, dma_idx, q->tail);
> =20
>  	return skb;
>  }
> --=20
> 2.47.3
>=20

--hjdNWhN+M75PWH0l
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCau3igAAKCRA6cBh0uS2t
rMP1AQDQW0nTl/iyQ8yyF1Ax+5X6SSbWqZBQL0LBfZ7WKMc0IAD/Z5rKVUbRgYMq
xM8uGxYqPhvZ/cg9I3iGntIU2g0J8A8=
=BKBZ
-----END PGP SIGNATURE-----

--hjdNWhN+M75PWH0l--
