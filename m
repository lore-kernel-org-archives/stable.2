Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259399;
	b=ZPvyGYqt5o0yev5s8g4xacK0U/9W8TrjnsRepzZd8ffSNd7eZGrbY1+wZJhXZSb4W4JJ
	 +/yuMHD35kYfYA+2HGUp45mkZcmtWaCe0UeZFb03tKs/ijiEskAGubSBVQKr5SzFunHoH
	 tnDdZsdTAh8PRSum3t7nYjNnR7NW2d1Ewr10WMwOSKv2INMl9WeNNEVasZpkggh0iyPUK
	 nzYCGa9XXS3nMRAvKOXWZTUoxs7NVAfE9LsQb4eGRMQ9JyxrAOaiMxSzIAuwQjJtsgDi2
	 O7pJn2y2l2Thl2UVGcQJcHiFct3zt2Yd031QT1B9KDJRa0KJIBR+HORQXhUONpyDOTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259399;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+kUTd224F4w2WVRCX29Wbt8/OcYpKrZOIe0kcjayeIo=;
	b=plNbDbmkjhphRWA7jd6lRxcsYOmH8LOME30n6vRKNKedgpB1RBCrOejk+ErxJy4BDRyj
	 9WpLZMKrvpuv2rvag0LU35AOPbIgJ1+RQ5T94dMwfZ0kcDFtwBhbmEMISJrAq9S3v1EIE
	 t3n65GTyPTRyb7BZOUkCJqZauAJ69tKnrqB6VkGtH2w2o1GmfQHESK+lX+Yr8SgZwF5xT
	 WrGvGQ2LvHhZe0fDZh7LTNaQlUYn/kL08lQ6GtJmehzjt9a5dYo+KH589ZAvJrS6jyT+8
	 VsfPwOLyQWSlOTjPxqea54PzgbpT5ttwxugim8m3ss0wKb29n5H7/PrO+5wGcMBdVZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVqjpXl3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC301606A31C;
	Mon,  9 Nov 2026 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVqjpXl3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969901F008A1;
	Mon,  9 Nov 2026 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259398;
	bh=+kUTd224F4w2WVRCX29Wbt8/OcYpKrZOIe0kcjayeIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nVqjpXl3jELyOGYz8QbtC9ZmJjl+dXzZ0Nfjtwg2s+48CfxcodVzNgRjxDGMX+HJ4
	 zZPk79N9QUVB43OeJhBO2LOmq06RNAy/ZzZuhj3qyTEkTs+k3Hm6PUnuPBwUY3hq5x
	 ftt88gv/tSP0PlpMIXbRAH9IQDEuV0G/Y98Zq8DW69iLNVDbRkUMpCH53Wwzb9fMk8
	 P1TvlqzvOZdTULh13FTwnHlA3lD7Hkk7hVJ2g0UZ6B3YoFoy8JPCgcCXxKbxfebTtp
	 eUN9eQXZVT5Cp50jDKrmzPbW31kYKxmsVBTobYAOEBLixE1pA+jWUGl9GBOf3TiKcO
	 j+R8thQJBIgHQ==
Subject: Re: [PATCH net] virtio_net: check RX buffer length before DMA sync
From: netdev-bot+sashiko@kernel.org
To: vladimir@dfb.sh
Cc: netdev@vger.kernel.org, mst@redhat.com, jasowangio@gmail.com,
 eperezma@redhat.com, xuanzhuo@linux.alibaba.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 vishs@meta.com, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, nikolai@kalinidze.me
Date: Mon, 09 Nov 2026 21:23:17 +0000
Message-ID: <179425939711.994134.2719389056327615125@kernel.org>
In-Reply-To: <20261108-b4-virtionet-rxlen-v1-1-0078c5ab7e14@dfb.sh>
References: <20261108-b4-virtionet-rxlen-v1-1-0078c5ab7e14@dfb.sh>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes: tag and the changelog blame commit 24fbd3967f3f
  ("virtio_net: add page_pool support for buffer allocation") for…

--

virtio_net: check RX buffer length before DMA sync

This patch moves check_mergeable_len() ahead of
page_pool_dma_sync_for_cpu() in the mergeable fragment loops. It also
limits the head buffer sync in receive_buf() to the length of the buffer
that was posted. The goal is to stop a malicious device under SWIOTLB from
using an oversized used length to bounce its own bytes over neighbouring
page pool fragments.

> Since commit 24fbd3967f3f ("virtio_net: add page_pool support for
> buffer allocation"), an RX queue that uses the DMA API
> (rq->use_page_pool_dma, for example with VIRTIO_F_ACCESS_PLATFORM)
> syncs each received buffer with page_pool_dma_sync_for_cpu() using the
> length the device wrote to the used ring, and checks that length
> against the posted buffer only after the sync.

[ ... ]

> Fixes: 24fbd3967f3f ("virtio_net: add page_pool support for buffer allocation")
> Cc: stable@vger.kernel.org

[Severity: Medium]
Is 24fbd3967f3f the right commit for the Fixes: tag? The sync before the
length check seems to predate page_pool. That commit appears to have only
moved it into the per-site page_pool_dma_sync_for_cpu() calls.

In the parent of 24fbd3967f3f, every merge or small mode RX buffer goes
through virtnet_rq_get_buf(). It syncs using the raw used length:

drivers/net/virtio_net.c:virtnet_rq_get_buf() {
    ...
	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
	if (buf)
		virtnet_rq_unmap(rq, buf, *len);
    ...
}

drivers/net/virtio_net.c:virtnet_rq_unmap() {
    ...
	if (dma->need_sync && len) {
		offset = buf - (head + sizeof(*dma));

		virtqueue_map_sync_single_range_for_cpu(rq->vq, dma->addr,
							offset, len,
							DMA_FROM_DEVICE);
	}
    ...
}

This covers the head buffer through virtnet_receive_packets() ->
receive_buf(). It also covers the fragments in receive_mergeable(),
virtnet_build_xdp_buff_mrg(), xdp_linearize_page() and
mergeable_buf_free().

In every case the sync runs before check_mergeable_len() or the
GOOD_PACKET_LEN check in receive_small().

In virtnet_rq_alloc() the mapping covers the whole alloc_frag:

	dma->len = alloc_frag->size - sizeof(*dma);

So under SWIOTLB, wouldn't an oversized used length copy bytes chosen by
the device over the neighbouring RX buffers in the same frag? That looks
like the same primitive the changelog describes.

git blame points at 295525e29a5b ("virtio_net: merge dma operations when
filling mergeable buffers"). The path then became unconditional for merge
and small mode in fb22437c1ba3 ("virtio_net: rx remove premapped failover
code").

Kernels with fb22437c1ba3 but not 24fbd3967f3f seem to be just as
exposed. With only the 24fbd3967f3f tag, stable tooling would not pick
those trees up. This patch also cannot apply there, because the page_pool
code does not exist in them.

That also affects the note after the changelog:

> An alternative is one sync helper bounded by the posted length for all
> four call sites; we kept the per-site change to keep the net and
> stable backport small.

Should the Fixes: tag point at 295525e29a5b and/or fb22437c1ba3? It would
also help to say in the changelog that those trees need a separate fix,
for example limiting the sync in virtnet_rq_unmap() to the posted length.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261108-b4-virtionet-rxlen-v1-1-0078c5ab7e14%40dfb.sh
