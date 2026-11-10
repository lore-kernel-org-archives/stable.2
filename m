Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794269825;
	b=4S6kcO3RAeV+HoYB0biRoNscCanKTXzqiwq/QrWhG3wGdlcKTQoGMEjR4x3eNyRx/Vh6
	 1vRQm9PJQqb7/lwgJ+sX19ZrKjesbn8adL15R66DZ4lQlcoDTW8BcEEY7LcXwIjfRzH40
	 MvRlazSij3u74Fnnj8/vyrpnw1rBhMnMBj/tCTvK2uhDZgpxKWd2B7F878VQ2T4H9fV1X
	 IPAThuXmH8d3cbTyHSuoXa+Fqilq3A4iIqO5Ym5WyRSNJc1udg34tAedGDiobnDav1wHu
	 4tnHenYkq0kAShWuQSV0CtqnXdnvN+0WKa7YJyuUBHyd/ISACSFd7ySQMdAnbQpJL2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794269825;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=S8fHLhX1Wopu8reB9mEZz+dFQmeZd2AuByljTQ8bzQI=;
	b=bba92cx7LHA9oUxGQsuDVd282JCJLmKC/oDyYYQL7yLQ1x8UKB1yFoHSPjcV7YjA6v+G
	 oQIEoUug/ttLMG7upvajEeK95W82lYvBeK57MRY+cgl6o/ahjx18r1NkUOCunU44ocNtn
	 KmOXa1la4T6/HYrbmE05/+yHbK9V+Lrhg8XeedyYETBoEzElGG95RxtePm3/cglRmBg88
	 g8zShBexW2ShAM0udr2J9inASgZkdRaqw00ZIovMJDgTcTXni9lYn0GPr+AsnL7+GVD7Q
	 FaoFYN94mTj/1wq8ks4z3B7ByUVGmpK4RYBbKZaAZUwlDFtYeemnRdWy1iyBzdGTaCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3NI7Z3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8C1606A32A;
	Tue, 10 Nov 2026 00:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K3NI7Z3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6B01F008A2;
	Tue, 10 Nov 2026 00:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794269825;
	bh=S8fHLhX1Wopu8reB9mEZz+dFQmeZd2AuByljTQ8bzQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K3NI7Z3iugPRvehaaEwOnCYy2EpfDl5XTk0ShVHPtwIgRV8M2m+jKWxridyP75nnS
	 ZLSvxFe9hEbAGD754Y2gFM5BDlzxM7/HFmJoHApbIgjxWIdxh3v+QVUoVPpa4F1uzJ
	 ASdrBi3vRPZd0q8gbwAwP8TwRNd4zgRowedCfpDfUjtK5U1ehoaVaQ8gz8/KQ1vYnL
	 VcOhPrDpQdk7jbGMx/7VfCIVSeoxI2zYmAtX3+dmVZYUjVq3tgpPnf4U66yMVA+4Oh
	 CfaEFFkG9UdtMc6QAyPrAgcIf32MByoR+Lp7K5ygG/5/yanhctQuN0H/+OkOjGpI6y
	 p5VaJDovNTGsg==
From: Jakub Kicinski <kuba@kernel.org>
To: lian@is.s.u-tokyo.ac.jp
Cc: Jakub Kicinski <kuba@kernel.org>,
	mst@redhat.com,
	jasowangio@gmail.com,
	eperezma@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	shina@is.s.u-tokyo.ac.jp,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] virtio_net: reject stats replies for queues outside the request
Date: Mon,  9 Nov 2026 16:17:00 -0800
Message-ID: <20261110001659.1654289-2-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102205550.4148064-1-lian@is.s.u-tokyo.ac.jp>
References: <20261102205550.4148064-1-lian@is.s.u-tokyo.ac.jp>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
virtio_net: reject stats replies for queues outside the request

With this patch, __virtnet_get_hw_stats() rejects a device statistics
reply if any record has a vq_index outside the range of queues in the
request. The control vq is the one exception. This stops the device from
steering writes in virtnet_fill_stats() past the end of the ethtool -S
output array or the on-stack struct netdev_queue_stats_tx.

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index dd2c41ef6fbe7..db56f984bb86a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c

[ ... ]

> @@ -4994,6 +4995,13 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
>  	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
>  		hdr = p;
>  		qid = le16_to_cpu(hdr->vq_index);

[Severity: High]
This isn't a bug introduced by this patch, but the new vq_index check only
limits where the driver writes. Can the device still steer the parse
through hdr->size?

The loop in __virtnet_get_hw_stats() advances by hdr->size, which comes
from the device. It only checks that each record starts below res_size.
It does not check that hdr->size is non-zero, or that it covers the header
plus the payload for hdr->type, or that the record ends inside the reply
buffer.

If hdr->size is 0 and vq_index is in range, p never advances. Will this
loop then spin forever? The loop has no cond_resched(), and on the
ethtool -S path it runs with rtnl held:

  virtnet_get_ethtool_stats()
    virtnet_get_hw_stats(vi, &ctx, -1)
      __virtnet_get_hw_stats()

If a short hdr->size puts a record near the end of the buffer, the found:
loop in virtnet_fill_stats() still reads the whole payload for the reply
type:

	v = (const __le64 *)(base + desc[i].offset);
	ctx->data[offset + i] = le64_to_cpu(*v);

Can that read past the end of the kmalloc'd reply and copy slab bytes into
the ethtool -S output? virtnet_fill_stats_qstat() does the same read for
the per-queue netlink stats.

The parser also has no way to know how much of the reply the device wrote.
virtnet_send_command_reply() throws away the used length:

	while (!virtqueue_get_buf(vi->cvq, &tmp) &&
	       !virtqueue_is_broken(vi->cvq)) {

and virtnet_get_hw_stats() allocates the reply with plain
kmalloc(res_size, GFP_KERNEL). If the reply is short, the leftover heap
bytes get parsed as records. Would they be reported as counters whenever a
stale vq_index happens to fall in [first_vq, last_vq]?

> +		/* The vqs of the queue pairs beyond curr_queue_pairs lie
> +		 * between last_vq and the control vq.
> +		 */
> +		if ((qid < first_vq || qid > last_vq) &&
> +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> +			return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but after this change a malformed reply
returns -EINVAL while a failed command still returns 0. Just above the
loop in __virtnet_get_hw_stats():

	if (!ok)
		return ok;

virtnet_send_command_reply() returns a bool. So when the device answers
with a status other than VIRTIO_NET_OK, or the kick fails, or the cvq is
broken, __virtnet_get_hw_stats() returns 0.

virtnet_get_ethtool_stats() only warns when the return value is non-zero:

	if (virtnet_get_hw_stats(vi, &ctx, -1))
		dev_warn(&vi->dev->dev, "Failed to get hw stats.\n");

As it stands, a rejected command is not reported, and ethtool -S shows zero
for every hardware counter. Should this path also return an errno?

> +
>  		virtnet_fill_stats(vi, qid, ctx, p, false, hdr->type);
>  	}

[ ... ]
-- 
pw-bot: cr
