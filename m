Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469995;
	b=TTdMgzBXJbsUjbZboaCNW4AX9MLf+mg6zRMBtXvSoOMIz6PDfn0SWDS2CR5UYOe9l5qI
	 FB6FjjbYCVzRbZxtWSwC/Y/koofOOofhpqi9TQA75+EuvpP5AZfBbEL/KaytTTwpJri/h
	 OjCsXjeOL6QFDO+s6YS5sX+Lvin7ADGhjBdaQPtqEIoly3FvZTBAWU6u+L+1DkeBR7fXA
	 LPj3kbj8YAD1z1Qm9HH0hrLiHD6eJmBfDEdZl0Vjx0YVNok6735GIyBJu8nho0WG4sIjU
	 0NKXTSLQN2+SAWojYlOlWIh+J51T5WBwZQv9srL1AfYczof+DewBKL+2SamJwV8vaLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469995;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zQHNkAvN/1ynVe3zD3+jO9CA7hfyjYhk47iEo0nnWpw=;
	b=ILum3h/ceK9Pp3HlSnmyx7YhXcXeh0EUB70masLunBZxaAAmKo/2fVntx58h3mEM3rXc
	 sdPjVSlm5KM/rcTaN4vc+iOF32hU/OP2MdCzk/rIaLJhE7B0Gm0RRKiMMizdxhYRGdP9F
	 CHX4eNrIe/G9yZuCgLA+r2tLNahVhMRTVZS8w6h9y8biXeMSSRvriLAichIB/JSImUoOz
	 zw+XP5CmyQAMgKDWo72xYwr8Fl60i/9z/QuDaHf8EcU94BbX3fDkeyhgwQGuX7817uAns
	 1xTgNg5U7ssm5JLxU9wlxLYMWiu93Su/FdGxbkVFCNvaS60chO9eyYvzM5Czg14JPrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6TAwTah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4460A3804;
	Thu, 12 Nov 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6TAwTah
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5B41F00A05;
	Thu, 12 Nov 2026 07:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794469994;
	bh=zQHNkAvN/1ynVe3zD3+jO9CA7hfyjYhk47iEo0nnWpw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k6TAwTahZ3Dm8p0vnPazApfqV2rKsVGAVmzVs2fBLVwWRK/K3ffUg03EbJyetQvb2
	 /1fCsfNMey8nUhVS+8Ni6KsQkVStQ8shZY7m+VK5pEnaj5btuCp1yUE3Y5WXE4Rz/7
	 t6RJ2HVPuZ95m2WP5UlLpc+PEOTDOO4/BVAYBOwHmvecju95KXgpqBvV2W0IkRv/tu
	 Zxo7Z5G4bVySX3Tr9wBUVsjGJHmCXiF7xkoVJonLR5ULk/0gWuIfAx93kARohhEsqm
	 cfYjseyaZoYFC5LwcDt/6SbrDiBqKvKoU0SYDBDUZQ7h+viaXLGXid5yjXGOWAqScg
	 YYvIiCoZZzCnQ==
Subject: Re: [PATCH 5/5] 9p/virtio: keep zero-copy buffers until the device
 returns them
From: netdev-bot+sashiko@kernel.org
To: lian@is.s.u-tokyo.ac.jp
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux_oss@crudebyte.com, horms@kernel.org, viro@zeniv.linux.org.uk,
 tomasbortoli@gmail.com, chirantan@chromium.org, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shina@is.s.u-tokyo.ac.jp,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 07:53:13 +0000
Message-ID: <179446999308.2199510.11222629754827394625@kernel.org>
In-Reply-To: <20261109105251.2545764-6-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-6-lian@is.s.u-tokyo.ac.jp>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch adds an unconditional `wait_event_idle(req->wq,
  !smp_load_acquire(&req->zc_pages))` to p9_client_zc_rpc()…

--

9p/virtio: keep zero-copy buffers until the device returns them

This patch fixes a use-after-free. If a fatal signal ends the wait in
p9_virtio_zc_request() while the device still holds the request, a
misbehaving device can later write into zero-copy buffers that have
already been freed. Freeing of the pinned pages moves to req_done() via
a per-request struct p9_zc_pages, and p9_client_zc_rpc() now waits until
the device returns the request.

> diff --git a/net/9p/client.c b/net/9p/client.c
> index 15bb939087165..34be0d2652d4e 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c

[ ... ]

> @@ -707,6 +708,8 @@ static struct p9_req_t *p9_client_zc_rpc(struct p9_client *c, int8_t type,
>  		 * into rc only while it waits.
>  		 */
>  	}
> +	/* The caller may reuse the payload once the transport releases it */
> +	wait_event_idle(req->wq, !smp_load_acquire(&req->zc_pages));

[Severity: High]

Can this wait leave a killed task stuck forever?

wait_event_idle() sleeps in TASK_IDLE and has no timeout, so SIGKILL
cannot end it. khungtaskd also skips TASK_NOLOAD tasks, so the hang
would never be reported.

The only code that clears req->zc_pages and wakes req->wq is in
req_done(). It runs only after virtqueue_get_buf() returns this exact
request:

net/9p/trans_virtio.c:req_done() {
    ...
	while ((req = virtqueue_get_buf(chan->vq, &len)) != NULL) {
		...
		if (req->zc_pages) {
			if (req->zc_pages->held)
				p9_zc_release(req->zc_pages);
			smp_store_release(&req->zc_pages, NULL);
			wake_up(&req->wq);
		}
    ...
}

On a fatal signal, p9_virtio_zc_request() hands the pages to req_done()
and returns with req->zc_pages still set:

		held = req->zc_pages;
		if (held)
			zc->held = true;
		spin_unlock_irqrestore(&chan->lock, flags);
		if (held)
			return err;

p9_client_zc_rpc() sends a TFLUSH only when c->status == Connected.
There are two cases where no flush is sent but the new wait still runs:

  - after umount -f, via
    v9fs_session_begin_cancel()->p9_client_begin_disconnect()
  - after an earlier -EIO has set Disconnected

If a flush is sent, p9_client_rpc(TFLUSH) can itself return early on the
fatal signal. In every case the wait above runs.

If the device never returns the original descriptor, nothing else clears
zc_pages. That can happen in several ways:

  - virtqueue_kick() fails and sets vq->broken. Its return value is
    ignored right after req->zc_pages = zc in p9_virtio_zc_request().
  - surprise PCI removal. virtio_pci_remove() calls
    virtio_break_device(), and vring_interrupt() then stops calling the
    callback.
  - a hung backend, or a device that answers the TFLUSH but keeps the
    original descriptor. This is the misbehaving-device case the commit
    message describes.

Before this patch, a killed task always left this path.

Once stuck, the task keeps any VFS locks its caller holds and cannot
finish exiting or coredumping. Its pinned pages stay counted in
vp_pinned, which throttles p9_get_mapped_pages() on other mounts. It
also keeps the mount busy, so p9_virtio_close() never runs and
chan->inuse stays true. p9_virtio_remove() then loops here and never
reaches virtio_reset_device()/del_vqs():

	while (chan->inuse) {
		mutex_unlock(&virtio_9p_lock);
		msleep(250);

That is a circular wait. Remove waits for umount, umount waits for the
task, and the task waits for a req_done() that never runs for this
request.

For pinned user pages (need_drop == 1), the zc->held hand-off already
keeps the pages alive until req_done(), so the unconditional wait seems
to be needed only for kvec buffers. Could the wait be limited to that
case, or bounded or made killable? Alternatively, could the transport
clear zc_pages and wake waiters when the vq is broken or torn down?

The commit message also does not mention that killed tasks can now
block on the device with no time limit. Should it?

>  recalc_sigpending:
>  	if (sigpending) {
>  		spin_lock_irqsave(&current->sighand->siglock, flags);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109105251.2545764-1-lian%40is.s.u-tokyo.ac.jp
