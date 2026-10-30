Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370080;
	b=PMEEFLqTTODf1AgIhxXqZLdIcUUwhBYXc7rKvIoeYhSTxpqiJodG6azzncMyulOdXrp0
	 XVwfD36tYDW5EGcfQNXIr5qDu8xD6k74Tj2Fj9+UbIrkKwoW2364kjUpO3NF8fMWb4gV+
	 dODGT7iMiLP2DQlDQxKcwNQ9JXyfxrIc9rKSh8RTx/FpkKyzCoE2MWIRlftG4uQkP6Mg6
	 yLUHGPkjl5Y82kQZjdtbcQmCC0EcgJQlq8JjSs3zNi/S1YuVZMr/8EChnm5d4F4c86xeZ
	 +k+izrfot20+tseIGOGRXsuLceJucF4KJka+Jl/irxLzw4k0dSXAPKdSkVpHPzf4GyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370080;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=fEfp8kxzeB0lYyMGgIvcUMd83vVWKlsFB9jWk+Wz83o=;
	b=defnI/tTWskRxqSMyTeRDHh41urPntc31Jr6gAyddFcfKAb4mTwtWG9aV2OP5jR+NhBk
	 2z5oLmVWQxMRb+Kqe/eIBaFZU+2Eh2JUq8wmPD2gwDx5bQi9xwFsA66RQnm8TzH36l03p
	 YkiCzPK528B1a4xpK3QEWhegY6pwf3I9rslxWLWh3idaA/+WYduvP9ngEUaqmZB5+JGzX
	 toyoqZNRNB5gDruMXVi42PmmhVCFmPwos2evLYvLb1QRLh0sXsC/rPeFs8PsCWmmU/jkw
	 JoWFvPIY6hzYka9MfXvalJW7YLlaHJOpfmlGyFbJye+nco+ujEYo6W+6zC7yMgMlamg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jGYqoRLG;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MCOGZNHK;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF39606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 14:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF39606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jGYqoRLG;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=MCOGZNHK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793370078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fEfp8kxzeB0lYyMGgIvcUMd83vVWKlsFB9jWk+Wz83o=;
	b=jGYqoRLG0CEg/NftlvRjVJveHcyR+ApDZQjuS0/HO80L4embutAVPovvGk37sVd4B+STFS
	GXqVLsCswKbkTqfZlLko7+yv6dJVXTyuxQziXGzEmktoMLLyT+sJW2Z7L1IVDGUKgnvd2a
	pdj+oUrSI8Z+28OQ4w23Z89fDEH24dA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-3kXG-mA6M7OPxu1xXfTuRw-1; Fri, 30 Oct 2026 10:21:16 -0400
X-MC-Unique: 3kXG-mA6M7OPxu1xXfTuRw-1
X-Mimecast-MFC-AGG-ID: 3kXG-mA6M7OPxu1xXfTuRw_1793370075
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a35db2d6b3so5649325e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793370075; x=1793974875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fEfp8kxzeB0lYyMGgIvcUMd83vVWKlsFB9jWk+Wz83o=;
        b=MCOGZNHKyinRet/jCbzWKHznRh6CjHpYaEKUC6ONb8hpjrun8+iobJnYxpSdv1xslb
         abmQLY3FGx+Xsi9+23teNcbMQiJhkZZFiPnsTJ3h/qbOpeErF9xTRjeG/nAJifVghZ6N
         TYb43YUdScHZ1etxXGzK4PJe6bVMI0XV+uOPILj8nDpH57D4Vstc9oMvkCjgXbDk1F/0
         7yakolSfPaG2VpnXC6SIQ6gxYFw6WibkfvAVQN0oggwvoJBZgg0ohSXtyASgn86x+jYo
         U+MdSi6zHeAS9mPig6C9D778qaaMX51CuxSVrsRbgnJ3EOMccVC6jfedaL+7UhgZhRVq
         XHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793370075; x=1793974875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fEfp8kxzeB0lYyMGgIvcUMd83vVWKlsFB9jWk+Wz83o=;
        b=Rz4uno327v7+7JrOsjlqWTSLydtcidCHfHtmSekxlGnIRIgN8JSBmyWb5RIRP0U7bQ
         HZbX4iTyhHS5ypUfq9LfcDyHRCns24ep4WNWZYfYNR7+pAoTWl/z91W3ZqG2JoxbyYCP
         3759z/HoAI8brj9XrE3g8LHfX/zWB+f23sDH/v8Nm6BjZMQDAk1HNC5n/j8c41ROJmK9
         b6Zh0y7o9Wm4kOabxDmWuhe7FafzBEXUjQ5VC3qw3LiaPyD2RBzWSVs7weE9LH6VZCPs
         oz3zWyb6moBdCE0ieudSbWrrDWeN4lV5GZdmgDM1i4WKKUdx7GEXeZTvMlp5Qdo/wfpi
         VdWg==
X-Forwarded-Encrypted: i=1; AKwUvByqoEMGb+G0/gZYclLSXw02bEowK4gjYXD3UsvZoBwJWA9Sh8h/twG2sCHzX90OT70m10J98e8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzCDtQihrd0FZPtpMByNzImZV+V2jcNHfz+62aqLYa65+4gwIT
	d9FRzw/x+wAv3gc8po3HajOTWyijMc9I9gXkaV6cr76xXlpGie2wO/Kb5z+koZa0MLaM0IemwB6
	7AezKToG4Fz/d9UGNoBKp9RJFRlOzpjWP4RzVB7oViE2I0akHTrXadXyYNw==
X-Gm-Gg: AYBFou3WszEWR3mI4MBdjEzrIwqgTgqCS/d7OYRk8RX3Hgwnlq33fx/uCbX9tP4wMYc
	V4Jj2dShIZ+fIl7Mpji3JZBH3J5TY9KhkjrpaElvI/hGiaoWxy+6lKhgTzKHGsawv9a+wzBcmg/
	wCNJfobvO44IPZ1Q9WsWZYDk2cHYqtKdSqM52H87RZPRlp50/gvgSqTa3XFIBph7UKnpEPeQmcC
	TZz+OLQfVRHgFSVa72vJewAMcnF21O24W3HOse67BvDC1ZOkE4Ap7d4fHZ/RL6VIYzs+vJG8JIi
	eoVlJ2Qtaqw/+D47nVHk6xNdfYMOE7NClrKWaUIShdtE82Jj6yt27L8P9YkY0mU8DPUfoxfLIVA
	ZeweC3Tz5c06rFO0zOoww/rD7xJMmS1RXi4eA9qU=
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4ac150b38abmr52841605e9.3.1793370075009;
        Fri, 30 Oct 2026 07:21:15 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:4a1:fae2:a8ab with SMTP id 5b1f17b1804b1-4ac150b38abmr52840155e9.3.1793370074228;
        Fri, 30 Oct 2026 07:21:14 -0700 (PDT)
Received: from redhat.com ([187.40.250.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm3743741f8f.7.2026.10.30.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:21:13 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:21:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: jrmmhm.kernel@eldare.de, Stefan Hajnoczi <stefanha@redhat.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
Message-ID: <20261030101918-mutt-send-email-mst@kernel.org>
References: <20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de>
 <auSZtMqcTz3r1nRk@sgarzare-redhat>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auSZtMqcTz3r1nRk@sgarzare-redhat>

On Fri, Oct 30, 2026 at 02:51:26PM +0100, Stefano Garzarella wrote:
> On Wed, Oct 28, 2026 at 07:22:43PM +0100, Jerome Mohm via B4 Relay wrote:
> > From: Jerome Mohm <jrmmhm.kernel@eldare.de>
> > 
> > virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
> > clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
> > reallocate them (its error path is a bare "goto out" that only unlocks
> > and returns), the driver is left bound with a dangling vqs[]. The next
> > virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
> > passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
> > use-after-free. KASAN on a guest with a virtio-vsock device on
> > virtio-pci, after a restore made to fail by fault injection:
> > 
> >  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
> >  Read of size 4 at addr ... by task repro
> >   virtqueue_detach_unused_buf
> >   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
> >   virtio_vsock_remove
> >   virtio_dev_remove
> >   ... unbind_store
> >  Freed by task ...:
> >   kfree
> >   vp_del_vqs
> >   virtio_vsock_freeze          <- the preceding freeze freed the vq
> >  Allocated by task 1:
> >   vring_create_virtqueue
> >   virtio_vsock_vqs_init
> >   virtio_vsock_probe           <- original allocation at probe
> > 
> > That second virtio_vsock_vqs_del() also repeats del_vqs(), which not
> > every transport tolerates. virtio-mmio's vm_del_vqs() always ends in
> > free_irq(), but after the failed vm_find_vqs() the device no longer
> > holds its IRQ, so on virtio-mmio the second call also warns:
> > 
> >  Trying to free already-free IRQ 51
> >  WARNING: kernel/irq/manage.c:1894 at free_irq+0x23e/0x840
> >   vm_del_vqs
> >   virtio_vsock_vqs_del
> >   virtio_vsock_remove          (or virtio_vsock_freeze)
> > 
> > virtio-pci's vp_del_vqs() is idempotent, so the PCI case shows only
> > the use-after-free.
> > 
> > Clear vsock->vqs[] after del_vqs() and when virtio_find_vqs() fails in
> > virtio_vsock_vqs_init(), and treat an empty vqs[] as "no virtqueues
> > are live": virtio_vsock_vqs_del() then still resets the device
> > (virtio_dev_remove() expects a reset device) and purges the send
> > queue, but skips the detach loops and del_vqs(). find_vqs() cleans up
> > after itself on failure, so skipping the second del_vqs() leaks
> > nothing. Clearing the stale pointers follows virtio_blk
> > commit 0739c2c6a015 ("virtio_blk: NULL out vqs to avoid double free on
> > failed resume").
> > 
> > The use-after-free was found with the help of an LLM coding assistant
> > (Anthropic's Claude); the free_irq() warning on virtio-mmio was reported
> > by the netdev Sashiko AI review of an earlier version of this patch.
> > 
> > Testing: on a private VM with a KASAN fuzz kernel, over virtio-pci and
> > over virtio-mmio (QEMU microvm). The restore allocation failure was
> > forced with CONFIG_FAILSLAB steered by the fault-injection stacktrace
> > filter to the virtio-vsock restore path only; a guest-root program
> > drives a pm_test=devices freeze/restore cycle (so .restore returns
> > -ENOMEM) and then unbinds the device, or runs a second freeze/restore
> > cycle. Without a fix (v7.3-rc5 based) the PCI run reports the
> > slab-use-after-free above. With only the vqs[] clearing (v1 of this
> > patch, on net 363c8c79220d) the MMIO runs report the free_irq warning on
> > remove and on the second freeze. With this patch on the same base,
> > restore still fails with -ENOMEM on both transports and neither report
> > appears; the device works again after a second, successful
> > freeze/restore cycle and after unbind/bind, and a normal freeze/restore
> > and unbind/bind still leave a working device. A find_vqs() failure after
> > some virtqueues were set up was not exercised (each restore attempt
> > failed at its first allocation, before any virtqueue was set up); that
> > clear is covered by code reading only. The three single-VM tests of
> > tools/testing/selftests/vsock/vmtest.sh (vm_server_host_client,
> > vm_client_host_server, vm_loopback; 44 vsock_test cases each) pass on
> > this tree, as on net; on both kernels the host-side runs skip the SO_INQ
> > cases (SO_INQ not supported by the host kernel). The ns_* tests of
> > vmtest.sh were not run (they need root on the host). checkpatch.pl
> > --strict is clean and the fuzz-config build is warning-free. The
> 
> Do we really need to write in a commit message that checkpatch.pl --strict
> is clean?
> 
> Descriptive commits are great, but we're going a bit too far here.

It's just what AI writes if you tell it to make it checkpatch.pl
clean in the prompt.

> Please
> include only the relevant information; for example, I think the part after
> "Testing:" could be summarized in a few lines or removed altogether.


Yea please write it yourself and make it concise. My eyes glazed over
in the 1st paragraph.

> > reproducer needs guest root, CONFIG_FAILSLAB with
> > CONFIG_FAULT_INJECTION_DEBUG_FS and
> > CONFIG_FAULT_INJECTION_STACKTRACE_FILTER, and CONFIG_HIBERNATION with
> > CONFIG_PM_DEBUG for pm_test; it is available on request.
> > 
> > Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
> > ---
> > The use-after-free was found with the help of Anthropic's Claude; the
> > virtio-mmio warning comes from the netdev Sashiko review.
> 
> This is already in the commit description, no?
> 
> > 
> > Changes in v2:
> > - Skip the detach loops and del_vqs() in virtio_vsock_vqs_del() when no
> >  virtqueues are live, so the teardown after a failed restore does not
> >  free virtio-mmio's IRQ a second time (Sashiko review).
> > - Use an empty vqs[] as the 'no live virtqueues' marker instead of v1's
> >  per-loop NULL checks, and purge the send queue before the early
> >  return.
> > - Commit message: cite only virtio_blk 0739c2c6a015; drop the wrong
> >  virtio_rtc and virtio_console references (Sashiko review). Drop the
> >  commit ID from the code comment.
> > - Tested on virtio-mmio (QEMU microvm) as well as virtio-pci.
> > - Drop the Assisted-by trailer (removed upstream); tool use is
> >  disclosed above instead.
> > - Link to v1: https://patch.msgid.link/20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de
> > ---
> > net/vmw_vsock/virtio_transport.c | 24 +++++++++++++++++++++---
> > 1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> > index 4f9aa9c4c3aa..bba594b7fc14 100644
> > --- a/net/vmw_vsock/virtio_transport.c
> > +++ b/net/vmw_vsock/virtio_transport.c
> > @@ -714,8 +714,14 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
> > 	atomic_set(&vsock->queued_replies, 0);
> > 
> > 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
> > -	if (ret < 0)
> > +	if (ret < 0) {
> > +		/* On failure virtio_find_vqs() can leave freed virtqueues or
> > +		 * error pointers in vsock->vqs[]. Clear it: an empty vqs[]
> > +		 * tells virtio_vsock_vqs_del() that no virtqueues are live.
> > +		 */
> > +		memset(vsock->vqs, 0, sizeof(vsock->vqs));
> 
> Should we move this in the virtio_find_vqs() ?
> 
> Maybe not for this patch, but for long term it could be a good idea IMO.
> 
> > 		return ret;
> > +	}
> > 
> > 	virtio_vsock_update_guest_cid(vsock);
> > 
> > @@ -781,6 +787,15 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> > 	 */
> > 	virtio_reset_device(vdev);
> > 
> > +	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > +
> > +	/* No virtqueues are live, e.g. after a failed restore: they were
> > +	 * already deleted, and a second del_vqs() is not safe on every
> > +	 * transport (virtio-mmio would free its IRQ again).
> > +	 */
> > +	if (!vsock->vqs[VSOCK_VQ_RX])
> > +		return;
> > +
> > 	mutex_lock(&vsock->rx_lock);
> > 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
> > 		kfree_skb(skb);
> > @@ -791,10 +806,13 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
> > 		kfree_skb(skb);
> > 	mutex_unlock(&vsock->tx_lock);
> > 
> > -	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
> > -
> > 	/* Delete virtqueues and flush outstanding callbacks if any */
> > 	vdev->config->del_vqs(vdev);
> > +
> > +	/* The virtqueues are freed: clear the stale pointers, so that a
> > +	 * virtio_vsock_vqs_del() after a failed restore skips them.
> > +	 */
> > +	memset(vsock->vqs, 0, sizeof(vsock->vqs));
> 
> Same above, should we introduce a virtio_del_vqs() to do both and call it in
> all drivers?
> 
> Or skip del_vqs() if vdev->vqs is empty.
> 
> I guess this issue could be spread around virtio drivers, so would be nice
> to add common API in the virtio core to be used in all of them.
> 
> That said, for a fix, this patch LGTM, my comments were more for a long term
> work.
> 
> With a fixed commit message I can give my R-b.
> 
> Thanks,
> Stefano
> 
> > }
> > 
> > static int virtio_vsock_probe(struct virtio_device *vdev)
> > 
> > ---
> > base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
> > change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
> > 
> > Best regards,
> > --
> > Jerome Mohm <jrmmhm.kernel@eldare.de>
> > 
> > 

