Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794469993;
	b=22GlSalvTA+SL5eE2owIhdn6ycXj+2zGKRSyTgM3o0g74l8xaHQqg0tLIplBV7nhKOEu
	 8JFQ1W+z28G/DMBMngIga2NRWOhACAfcoiakux96meALxYnT0lKILeLndk0B4yw9dGqtW
	 XwPgaD0R5TQr57gE9anVVRro6HjgDD3KGcONtVxJ+IsJeX0dZhhcmbJnN+FcxVNo6wZx+
	 PliM/R/Ex/Wj8DGv5GQxO0M0vG/5KbPqwAnxKBPu3Dydx8dL2Ba7HCHNCssUIQiRdxgDY
	 wOy7oP5YTR0wH9E8HgH/Z186aZse8GQ23t1BMpAvqXdJrNtnBxhZARZ0HBzvRSQAA2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794469993;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=71PKivdAwOSBBlvUSmJBCa4SkBlLU3GWY5ZqAIO/Hmo=;
	b=cPC2pMvvDdPfVtRphF49hvFPDULZ2lZKyrsCUHPL0VCz5U0uljtM3Im0hcERjtkq/p3s
	 6s4xCSeiIckCTd8TwRmURQG9GqBfDsROXLETuGjW8esAUPGGeReH4SUSq9NNGEYzU8Br4
	 TbXvupL7F2jEdXZxQthWq8i7C4DIq13N9my9QIaHUB4P5ZtLjwfvAJmibhJ6GJWK1xUIj
	 OMJZIbMKvZszRQkY9yi/na6MPX148aSfN9wlON50rWmMvJhvofXb2WKI/p2Fsr/DPi7bO
	 cPr5pn42lys6IytEkIamh0rwsgrNvGGmBwSWytehPVkBpDbzermEIUhKUtttZ0oOAYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvmHw23l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532CA60A2639;
	Thu, 12 Nov 2026 07:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvmHw23l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB751F00A05;
	Thu, 12 Nov 2026 07:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794469992;
	bh=71PKivdAwOSBBlvUSmJBCa4SkBlLU3GWY5ZqAIO/Hmo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EvmHw23lThNMVCAbbTD3OCKKjZYnLaXMtEd4JQwjY8BTKo9pXYsR6hlL39mlDyxKy
	 biuOo2rcxQm916YYtMXulFuBOgqjM9ebP3Yy2ZRytSu6EVrZsjuejKuSb7cg3uzRy2
	 EFLMd4eMdbo1h1XGxrgByTvTFBWTS1/fcrNI86G7Yi5Ybf8H2/gkazXB+IAz2o4tP1
	 mMOoPgSDvL+n+2RIxLGa8TwH6RmtN6k543ebsdZjHxqgzcfqLKvRsIpRthckOqyWZz
	 IE3OkOdxBOcVzJlIoi6y6ej6d1tRu7sHA1qhMNgExP+lL7Ywnden7AOvuN8V+ywm/p
	 xc1S1YkjXBn5A==
Subject: Re: [PATCH 3/5] 9p/virtio: keep a request until the device returns it
From: netdev-bot+sashiko@kernel.org
To: lian@is.s.u-tokyo.ac.jp
Cc: ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux_oss@crudebyte.com, horms@kernel.org, viro@zeniv.linux.org.uk,
 tomasbortoli@gmail.com, chirantan@chromium.org, groug@kaod.org,
 aneesh.kumar@linux.vnet.ibm.com, v9fs@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, shina@is.s.u-tokyo.ac.jp,
 stable@vger.kernel.org
Date: Thu, 12 Nov 2026 07:53:11 +0000
Message-ID: <179446999129.2199510.15094266003962078465@kernel.org>
In-Reply-To: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
References: <20261109105251.2545764-4-lian@is.s.u-tokyo.ac.jp>
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

Critical: 0 (1) · High: 1 · Medium: 0 · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Client teardown still frees requests the virtio device has not
  returned.

Pre-existing issues:
- [Critical] At this commit, p9_virtio_zc_request() releases the zero-
  copy payload pages while the device may still own them.
- [Low] The refcount comment in p9_tag_alloc() (net/9p/client.c:205-214)
  says that for virtio 'p9_client_cb eats the second ref there as the…

--

9p/virtio: keep a request until the device returns it

This patch removes p9_virtio_cancelled(), so a flushed request no longer
loses its virtio transport reference twice. Instead, req_done() drops
that reference when the device returns a buffer with no reply. The aim is
to keep the request alive until the device hands its buffer back, which
fixes a refcount underflow and a use-after-free on a late return.

> diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
> index 53046668c16b1..68c3457bec401 100644
> --- a/net/9p/trans_virtio.c
> +++ b/net/9p/trans_virtio.c
> @@ -145,6 +145,9 @@ static void req_done(struct virtqueue *vq)
>  		if (len) {
>  			req->rc.size = len;
>  			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
> +		} else {
> +			/* No reply, so put the ref that p9_client_cb() puts */
> +			p9_req_put(chan->client, req);
>  		}

[Severity: High]
Is the request still kept until the device returns it when the client
is torn down?

On umount, p9_client_destroy() calls ->close() and then frees the
outstanding requests and the client:

net/9p/client.c:p9_client_destroy() {
	if (clnt->trans_mod)
		clnt->trans_mod->close(clnt);
	...
	p9_tag_cleanup(clnt);

	kmem_cache_destroy(clnt->fcall_cache);
	kfree(clnt);
}

p9_virtio_close() only clears inuse:

net/9p/trans_virtio.c:p9_virtio_close() {
	mutex_lock(&virtio_9p_lock);
	if (chan)
		chan->inuse = false;
	mutex_unlock(&virtio_9p_lock);
}

It does not reset the device, detach posted buffers, wait for
outstanding tokens, or clear chan->client. Its kernel-doc also says it
frees the channel's resources, which doesn't match the code.

p9_tag_cleanup() then calls p9_req_put() on every request still in the
IDR. That includes a flushed request whose last reference now belongs
to the device. So the request and its tc/rc sdata are freed while the
vring still points at them.

If the device returns that buffer later, vring_interrupt()->req_done()
gets the stale pointer from virtqueue_get_buf():

  len == 0: the new branch calls p9_req_put(chan->client, req) on freed
            memory
  len != 0: p9_client_cb() writes req->rc.size and the status, wakes
            req->wq and drops a reference

chan->client is then either the freed client or, if the tag was
remounted, a new client. p9_virtio_create() reassigns chan->client
without taking chan->lock.

p9_req_cache is a single SLAB_TYPESAFE_BY_RCU cache, so the freed
request may already be a live request of the new mount. Can the stray
put then decrement a live refcount and p9_tag_remove() a live tag from
the new client's IDR?

This looks like the case the commit message describes:

  "a misbehaving device can return the request after the RFLUSH, so
  req_done() writes into the freed request"

Here it is reached by unmounting between the RFLUSH and the late return.

A well-behaved device can hit the same problem if a request is abandoned
without a completed flush and the device is still working on it at
umount. This happens when the client is no longer Connected (for
example, BeginDisconnect after umount -f) or when a fatal signal aborts
the TFLUSH wait.

The later patch "9p/virtio: keep zero-copy buffers until the device
returns them" adds wait_event_idle() on req->zc_pages in
p9_client_zc_rpc(). That only covers zero-copy requests. Requests sent
through p9_client_rpc(), TFLUSH included, still return without waiting
for the device. Neither p9_virtio_close() nor p9_tag_cleanup() changes
in the series.

Before the request pool and the client are freed, should the close path
take back the posted buffers, either by resetting the device and
detaching them or by waiting for outstanding tokens? Or should
chan->client be cleared, or kept valid, under chan->lock?

[Severity: Low]
This is a pre-existing issue, but the refcount comment in p9_tag_alloc()
still names p9_client_cb() as the only place that drops the second
virtio reference:

net/9p/client.c:p9_tag_alloc() {
	...
	 * (the write happens synchronously in the request/zc_request
	 * callback), so p9_client_cb eats the second ref there
	 * as the pointer is duplicated directly by virtqueue_add_sgs()
	 */
	refcount_set(&req->refcount, 2);
	...
}

After this patch, req_done() also drops that reference directly when
len == 0. The comment also leaves out existing puts: in
p9_virtio_zc_request() when the request was not kicked, and in
p9_client_rpc() when ->request() fails. It never mentioned
p9_virtio_cancelled() either, and it is unchanged at the end of the
series.

Could it be updated to list the current places that drop this
reference?

>  	}
>  	spin_unlock_irqrestore(&chan->lock, flags);
> @@ -195,13 +198,6 @@ static int p9_virtio_cancel(struct p9_client *client, struct p9_req_t *req)
>  	return 1;
>  }
>  
> -/* Reply won't come, so drop req ref */
> -static int p9_virtio_cancelled(struct p9_client *client, struct p9_req_t *req)
> -{
> -	p9_req_put(client, req);
> -	return 0;
> -}
> -

[Severity: Critical]
This isn't a bug introduced by this patch, but it is in the same fatal
signal handling in p9_virtio_zc_request(). After the kick, a fatal
signal during the reply wait falls through to err_out. That path then
releases the zero-copy pages while the device may still own them:

net/9p/trans_virtio.c:p9_virtio_zc_request() {
	...
	virtqueue_kick(chan->vq);
	spin_unlock_irqrestore(&chan->lock, flags);
	kicked = 1;
	...
	err = io_wait_event_killable(req->wq,
				     READ_ONCE(req->status) >= REQ_STATUS_RCVD);
	...
err_out:
	if (need_drop) {
		if (in_pages) {
			p9_release_pages(in_pages, in_nr_pages);
			atomic_sub(in_nr_pages, &vp_pinned);
		}
	...
	kvfree(in_pages);
	kvfree(out_pages);
	...
}

TFLUSH has not been sent at this point. Can the device still DMA the
read payload into pages that are unpinned and possibly reused? Or into
a kvec buffer that the caller frees once the call returns?

The later patch in this series, "9p/virtio: keep zero-copy buffers until
the device returns them", appears to fix this. It attaches the pages to
req->zc_pages before the kick and leaves p9_zc_release() to req_done()
after a fatal signal. p9_client_zc_rpc() then waits with
wait_event_idle() until the device returns the buffers.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109105251.2545764-1-lian%40is.s.u-tokyo.ac.jp
