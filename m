Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E42C11FA;
	Wed, 16 Sep 2026 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519082; cv=none; b=qVbCcP787tShcIOWJtCJXpxOkaNv60/ptEYjtJ3D62/SrVP7zOg9mzdWzNb2Dxi71zaXPbr7DOtCf10vK1LjmP1Qv74LTcUf/wexc7O6gPgCEyWdGzQ5F/8olP5kGnBP2xCbA56gogQrUVZmtHc94B42gDNVnX9VBnZRvwnFkLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519082; c=relaxed/simple;
	bh=SiwQkzrVDQV01ATxvtgkke17srYjd2v+wZbwrFSMpLg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUxG/W5yRwhfiXD6XdDImU9s0a7LFEsZCtZ9dvOhf+H9/Md5CFU8lfd8iLsDiDt+4zEWL2DO4cuSTnFlw7SFS7f6L+XET3HRu1dIoHRL2TgQnxmtU+tE9VVk7BjFm/VrckSS8xXJex7Kj5/gB+mZdlHxJz/aoYQQhKX7fLANpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Rr6X7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Rr6X7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BDB1F000FF;
	Wed, 16 Sep 2026 00:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519075;
	bh=XTpmwRnvzOj8JJNAxlGAUdt8jPuIe+377jHtDnXTwqg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D7Rr6X7p8Q6RF0rF1IqN7DPQmg+3UP978dqQj1J5j0F/fs3LO9a+eH3lfzoanZUGf
	 5mzJaMq1JH+TvVbch2O6mGpOEq7F3qbSwqEQyGU6scD46s2oGYIjdHEQS/9BqQ5NBV
	 pGMA1xcxzeUC6gozfSUwHEhvdi+FEdpI99jtrnn4X4aCHWPXyOh6NPCilJ3JF4/4zc
	 c4Gl9bgWxGXiUjKONBUf1W3EAPyoWioa8/605queJ8n73QFzDMrA5k15YMszKK/o3L
	 npkc4ej9EeshrEOAF+fm8FtQWRt8lGs1fSli5wJsmzk1zGsNOA2iYb01+pZC/1FVAC
	 R4HSXoEVobNQg==
Subject: Re: [PATCH net 1/2] virtio_net: copy zerocopy frags in start_xmit
 without NAPI
From: netdev-bot+sashiko@kernel.org
To: willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 andrew+netdev@lunn.ch, willemb@google.com, kleaver@janestreet.com,
 doebel@amazon.de, stable@vger.kernel.org
Date: Wed, 16 Sep 2026 00:37:54 +0000
Message-ID: <178951907424.22033.18396065221753685013@kernel.org>
In-Reply-To: <20260914214229.1674102-2-willemdebruijn.kernel@gmail.com>
References: <20260914214229.1674102-2-willemdebruijn.kernel@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new drop path added to start_xmit()
  (drivers/net/virtio_net.c, the `if (!use_napi &&…

--

virtio_net: copy zerocopy frags in start_xmit without NAPI

For the !use_napi path, start_xmit() now calls skb_orphan_frags() before
the existing skb_orphan(), so zerocopy frags that do not set
SKBFL_DONT_ORPHAN (PACKET_TX_RING, vhost_net) are deep-copied instead of
staying pinned until the next transmit. On copy failure the skb is
dropped and tx_dropped is bumped.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index e34c52d059d39..1ce528c18f9e7 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3349,6 +3349,13 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	else
>  		virtqueue_disable_cb(sq->vq);
>  
> +	if (!use_napi &&
> +	    unlikely(skb_orphan_frags(skb, GFP_ATOMIC))) {
> +		DEV_STATS_INC(dev, tx_dropped);
> +		dev_kfree_skb_any(skb);
> +		return NETDEV_TX_OK;
> +	}
> +

[Severity: Medium]
Can this early return leave already-queued descriptors in the avail ring
with no doorbell?

In the !use_napi path the only notification in start_xmit() is at the end:

	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
			  !xmit_more || netif_xmit_stopped(txq);
	if (kick) {
		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {

Earlier skbs of a batch call xmit_skb() with xmit_more == true, publish
their descriptors and deliberately skip the notify, relying on the last
skb of the batch to ring the bell. dev_hard_start_xmit() decides that:

net/core/dev.c:dev_hard_start_xmit() {
	...
		rc = xmit_one(skb, dev, txq, next != NULL);
	...
}

so the final skb in the chain is the one with xmit_more == false.

If that final skb is a zerocopy skb without SKBFL_DONT_ORPHAN (an
AF_PACKET TX_RING sender, or vhost_net under nested virt) and
skb_copy_ubufs() fails its GFP_ATOMIC page allocation, the new block
returns NETDEV_TX_OK without reaching virtqueue_kick_prepare() /
virtqueue_notify(). Are the previously added frames then invisible to the
device until some unrelated later transmit on the same queue happens to
kick it?

Batching for this queue looks reachable without BQL: for a root qdisc
without TCQ_F_ONETXQUEUE on a multi-queue virtio-net device,
dequeue_skb() uses try_bulk_dequeue_skb_slow(), which chains up to 8 skbs
for the same txq. The BQL-driven try_bulk_dequeue_skb() path stays inert
here because the !use_napi path never calls __netdev_tx_sent_queue(), and
__free_old_xmit() accounts ORPHAN skbs into stats->packets, so
netdev_tx_completed_queue() is always fed zero bytes.

Would it work to fall through to the kick logic (or replicate it) before
dropping the skb? The pre-existing xmit_skb() failure return below has the
same shape, though it is annotated "This should not happen!", whereas this
new path turns a routine -ENOMEM under memory pressure into a
doorbell-skipping return.

>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914214229.1674102-1-willemdebruijn.kernel%40gmail.com
