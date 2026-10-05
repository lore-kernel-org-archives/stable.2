Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4B4D37DA;
	Mon,  5 Oct 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221213; cv=none; b=NCAgRKiH0VXw9YiK6bpMKyP++BKjMwRNBZRsildjYiK+55hzrvJ371u3rQA5/hORs4SvAKoWIRM743aAjiZF9UyPzzTb0AmGgwoPrUKqof6FQGDAmt8eT9G6Uk81FiLpjOLJZ7SWEX1mu612dTPWZjg317Ne6dr82ctK2mPKAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221213; c=relaxed/simple;
	bh=4N6ZXnhILdTijI2h8epOSD16hDy6Wvib2qv1LLfxtQs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T2E5sMEMUirgSWnb8FITt58AmAqbN4nIqbkg+J25NhIsGEhNUGkBEBW63T5Stz4q2xilgM9qbQcC9LtRdviax+lapQ74XTFeaZYWfqlKqrZV2J4pTDNXFs/lc0AXtbyUu7Fnuorpk0TCPFbV6Rs8Xaza8OCUyngf+XzAkZzY2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmFZU1Gi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmFZU1Gi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125F81F00893;
	Mon,  5 Oct 2026 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791221212;
	bh=onMIxLXihhMQM6gkjGW37CW4bU2QGudgAP0OE2d6biQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NmFZU1GiD4qdh7OoYqQlu614OeDZBKAbMMgeNnZyWRXnG2eszHvpUAGIl4FNdGL/K
	 HjLYSjQYbVTAKPXd/8rsxi9NIEfT24QMNZJ0qJhlE67YHvdV/QlFQ0PPms1hF7ZdmD
	 8yVjTl/xxvYuOaJ6bIohpw7EiMYgUp9i/3nirgP5yyA6BZmjPCtf8FMCH4XG9BHrzR
	 8w55RvZXmk33GH/VczNtzD+tzFKD2CEZp4s+tdePLzHwSXDM174ZvCNs284ntCiEI3
	 Amw1IUnwK8Pop9NobBT8fK6qvQl8myhgn6+Zxuzgxgk4rkJE1wxN7+h68BqLq21sIi
	 L8mto4g2rl5ig==
Subject: Re: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a failed
 PM restore
From: netdev-bot+sashiko@kernel.org
To: jrmmhm.kernel@eldare.de
Cc: mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com,
 xuanzhuo@linux.alibaba.com, stefanha@redhat.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 05 Oct 2026 17:26:50 +0000
Message-ID: <179122121054.434549.15763347362425052652@kernel.org>
In-Reply-To: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
References: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] This patch makes only the RX/TX detach loops in
  virtio_vsock_vqs_del() (net/vmw_vsock/virtio_transport.c) tolerate a…
- [Low] The commit message says the change 'mirrors' virtio_rtc commit
  548d2208455f and that 'virtio_console carries the same stale-pointers-…

--

vsock/virtio: clear vqs[] to avoid a UAF on a failed PM restore

This patch clears vsock->vqs[] after del_vqs() in virtio_vsock_vqs_del().
It also clears the array when virtio_find_vqs() fails in
virtio_vsock_vqs_init(). The RX/TX detach loops are skipped when the vq
pointer is NULL, so a remove or freeze after a failed restore no longer
touches freed virtqueues.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 4f9aa9c4c3aa5..0553c0641fd28 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c

[ ... ]

> @@ -782,19 +789,30 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
>  	virtio_reset_device(vdev);
>  
>  	mutex_lock(&vsock->rx_lock);
> -	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> -		kfree_skb(skb);
> +	if (vsock->vqs[VSOCK_VQ_RX])
> +		while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> +			kfree_skb(skb);
>  	mutex_unlock(&vsock->rx_lock);

[ ... ]

>  	/* Delete virtqueues and flush outstanding callbacks if any */
>  	vdev->config->del_vqs(vdev);

[Severity: Medium]
The detach loops now handle NULL vqs, but del_vqs() still runs
unconditionally. Is a second del_vqs() safe on every transport?

On virtio-mmio, vm_del_vqs() always frees the IRQ:

drivers/virtio/virtio_mmio.c:vm_del_vqs() {
    ...
	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
		vm_del_vq(vq);

	if (vm_dev->wake_irq_enabled) {
		disable_irq_wake(irq);
		vm_dev->wake_irq_enabled = false;
	}

	free_irq(irq, vm_dev);
}

Take the sequence from the commit message:

virtio_vsock_freeze()
  virtio_vsock_vqs_del()
    vm_del_vqs()            <- vqs deleted, IRQ freed

virtio_vsock_restore()
  virtio_vsock_vqs_init()
    vm_find_vqs()           <- fails

vm_find_vqs() can fail in two ways:

- request_irq() fails, so the IRQ is never re-requested.
- vm_setup_vq() fails, and vm_find_vqs() calls vm_del_vqs() itself.

Either way the IRQ is no longer held. virtio_device_restore_priv() only sets
VIRTIO_CONFIG_S_FAILED, so the driver stays bound.

A later virtio_vsock_remove() or a second virtio_vsock_freeze() then reaches
virtio_vsock_vqs_del() again. The new NULL checks skip the detach loops, but
vm_del_vqs() calls free_irq(irq, vm_dev) for an IRQ that vm_dev no longer
owns.

Won't __free_irq() hit WARN(1, "Trying to free already-free IRQ %d") here?

The virtio-pci reproducer doesn't show this because vp_del_vqs() is
idempotent. Would it be better to skip the transport teardown in
virtio_vsock_vqs_del() when no vqs are live? An early return, or a flag
that records whether the vqs were set up, would both work.

> +
> +	/*
> +	 * del_vqs() has freed the virtqueues. Clear the stale pointers: if a
> +	 * later virtio_vsock_restore() fails to allocate new ones, the driver
> +	 * stays bound with a dangling vqs[] and the next virtio_vsock_vqs_del()
> +	 * would detach a freed virtqueue (use-after-free). Mirrors virtio_blk
> +	 * commit 0739c2c6a015.
> +	 */

[Severity: Low]
This isn't a bug, but the commit message says:

    This mirrors virtio_blk
    commit 0739c2c6a015 ("virtio_blk: NULL out vqs to avoid double free on
    failed resume") and virtio_rtc commit 548d2208455f ("virtio: rtc: tear
    down old virtqueues before restore"); virtio_console carries the same
    stale-pointers-after-failed-restore fix.

Are the virtio_rtc and virtio_console references accurate?

Commit 548d2208455f fixes a different problem. viortc_freeze() kept the old
vqs alive, so that commit calls del_vqs() at the start of viortc_restore().
It doesn't clear any driver pointers after del_vqs().

virtio_console doesn't seem to have this fix either. remove_vqs() calls
kfree() on portdev->in_vqs and portdev->out_vqs without clearing them:

drivers/char/virtio_console.c:remove_vqs() {
    ...
	portdev->vdev->config->del_vqs(portdev->vdev);
	kfree(portdev->in_vqs);
	kfree(portdev->out_vqs);
}

The free: error path in init_vqs(), which virtcons_restore() reaches, does
the same.

Only the virtio_blk commit matches what this patch does. Could the other
two references be corrected?

Also, the new comment in virtio_vsock_vqs_del() hard-codes a commit ID
("Mirrors virtio_blk commit 0739c2c6a015"). Could that history stay in
the changelog only?

> +	memset(vsock->vqs, 0, sizeof(vsock->vqs));
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001-vsock-restore-uaf-send-v1-1-5da60f707506%40eldare.de
