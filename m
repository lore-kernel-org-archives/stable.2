Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76817486BB0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336277; cv=none; b=YIYf+nQOpZOWf8M9DiYJdAMVuC5vCO/8rfmmBsvdBEWApeyaZrkHTx4+yk/smtnrV82nBPrB3eHKOHnyZRG8Td4O8i/fAr90rEVufeyNd+hE4zQavItrnH/axDgqUhkXjUNHmEqLH/RWL3z/Vfeuun7rRGbUhoGftbUEejcgMcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336277; c=relaxed/simple;
	bh=BJS1HA8rokFIiV0ne5cRaLj+3cbfWQFKkW4X/b+NT0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzlcIixhJmEfvVBSAeS8IHBLURSDuJjvC5/pnVSZOMlrKxSRCEMFtrqmUSY/aulSkWvhXWElgh3rUIKdIes7037i7eXJdyD8gU2Va0GpAqdiJ1/scxEJFcWNdzoLXYYQfITJxW37EFuDsZmDR9ooPPE3RetI3oqUqFKcPlmxQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNWcPWPn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LdpwD0qW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNWcPWPn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdpwD0qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785336274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
	b=YNWcPWPn9bvAPNDTNyD2ILT5WLEI7d/1jOq4dpgpaLzenlwxMGF/XU2WLVa/vLq1u6VZKJ
	g+ZOI/W2pWL6E13TVrj9aatcGZ3t2u3miOaCvVp26h4zpIWMhRQCJrx2qQ02AyOdegEs7j
	C/6E8lnswo7449EYUtRc1NypluOrXHU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-zyFM9dhPN5GZ061D6nKQew-1; Wed, 29 Jul 2026 10:44:33 -0400
X-MC-Unique: zyFM9dhPN5GZ061D6nKQew-1
X-Mimecast-MFC-AGG-ID: zyFM9dhPN5GZ061D6nKQew_1785336272
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955e865174so6439065e9.3
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785336272; x=1785941072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=LdpwD0qWphlkCEBxQYrOyS6FkvxzQKoLILQlGrnVFFL763mILU1nefBW7SlHcpU+F6
         PjsWBFtIiA5eajvFseDlOKCMEAcaW5LJFbXiUOBs74aiww/s+Z87klLkY/Y+rhzwSR8k
         r37Lha8dRLpCV3ekeHsespKsfqWahPFrN2YlbPI7ad38HSW684mQYfpFwdyhNZcI8ra+
         uGqzah5sS2rSy9osSn3Gx5X54MNQCKUqy6sM6s7R2OU340BUNGqWlJeiKkdZOPY+F/MX
         2lpxXmvTyYOGArBoPERg7O/d40hNo1FtNK6OpUs4P7806N6wrqoMsJIsyTA64/53k5Kk
         EVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336272; x=1785941072;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5H5BXZFmwChe72ax9v3fx7rbm4FIcGAxuXQx1+sJiZI=;
        b=lAshUdXCYBKLdilWJcX3TaER8erMEijr4aQM6P+w2ixYI5asF2mqnNlPL1w+sUho46
         WFHMw53FEXweIRUt6iKZRxJR6XFNSfdiZlHpBMjXEeUQsaDjO539D6M6/8XpGvhdc1zS
         /gLAsu88ta34DX0xnZdeHagO3e+ozY1+luHC50XosCTCq8XBG4Q9YuskHDlKjJKvMjkE
         vM7A4/hemAOWWWlgB2dtESJTA59ME37xloXsrR0yE+CjNLYNY14BRx55XAbSlVquJVLn
         KCiDUKkE6/4Kz58/Vb0qVGmYvQqveYdUut7/yJhAdmr8/j22wS2HSRCVGHe0w4zAsUEs
         x2aA==
X-Forwarded-Encrypted: i=1; AHgh+RpH+GY1HUf48tYIsYJSsbd7Hc/gMt33R7EfaVN2hfrq9SFAsuahdSnzAImhQnjNYb09Jkzum+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgfWqopigJGgeY6CuLR030HgqX26x7dc+qEJMiITLJ/YlqgCu
	05gfCUdn9fs/bSxsPT19ygOthbaBWbThI9t/ttlcKYCWKP+ez0baba5VFmOlE716xAYc1vz6y53
	2vQ2/CDWezLbRr1/mxZiOBmPGzbVol8s5pI/pjUMKJj9Ke8+3t43r5N36Qg==
X-Gm-Gg: AR+sD11sLyLqoXPVqNGcsbM+bG2uOgwtZtgdfnmrw6cLaEeT9rbBWFAmXUL+7JPQ/vp
	MBCVb0Wg/OKhidrzYBj4WoA3FbLxYxspXaopGBJ3FYAt0Aqj3T65Dit8IBx2PN/5OeLSZJBrOHV
	lAuwrsUcH/hiIiiYVo8m5uFYY5/kvrrKH32R7DaCqm+aTieWlsYf8yIJ7oH9oV8l4vk58492dB7
	nk1wOysaagmE9/TbD1Bv1d90inHXlpJHFp7i8nkjpMkxNsIub8a2nYVuweh5GaW9FVrd36wvILE
	JW/KE+aNnrxMaGOLPABKxpN9SCwbtBc1nJW2KbzJlZb9lzaHJLd8/ET/NtH/CwQzQ7/mesb5gUk
	cg8iBV12qBdM1kUM3EcweAT0p7G09KemFwYTiGUelszo=
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603485e9.18.1785336271620;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:495:7285:a498 with SMTP id 5b1f17b1804b1-496c656540fmr82603015e9.18.1785336271121;
        Wed, 29 Jul 2026 07:44:31 -0700 (PDT)
Received: from sgarzare-redhat (ip139-137-192-82.pool-bba.aruba.it. [82.192.137.139])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd52f3fsm36693245e9.0.2026.07.29.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 07:44:30 -0700 (PDT)
Date: Wed, 29 Jul 2026 16:44:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amoPm0aVfnadsJaF@sgarzare-redhat>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
>The RX, TX and event workers read their virtqueue pointers before taking
>the mutex that protects the queue and its run flag. A work item delayed
>across freeze and restore can therefore retain a pointer deleted by
>virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
>and use the freed pointer.
>
>RX has an additional path: when rx_run is clear, the common exit still
>refills the RX queue. A queued worker can consequently call
>virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
>
>BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
>Read of size 4 by task kworker/2:1
>Workqueue: virtio_vsock virtio_transport_rx_work
>Call Trace:
> virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
> virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
> virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
> process_one_work (kernel/workqueue.c:3314)
> worker_thread (kernel/workqueue.c:3478)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>...
>Freed by task 141:
> kfree (mm/slub.c:6566)
> vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
> vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
> virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
> virtio_device_freeze (drivers/virtio/virtio.c:658)
> virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
> pci_pm_freeze (drivers/pci/pci-driver.c:1098)
> device_suspend (drivers/base/power/main.c:1968)
>Kernel panic - not syncing: KASAN: panic_on_warn set ...
>
>Read each worker's virtqueue under its mutex after confirming that the
>queue is running, and only refill RX while RX is running.
>
>Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
>Cc: stable@vger.kernel.org
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Assisted-by: OpenAI-Codex:gpt-5
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>---
> net/vmw_vsock/virtio_transport.c | 14 ++++++++------
> 1 file changed, 8 insertions(+), 6 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 57f2d6ec3ffc..79cf19f58943 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
> 	struct virtqueue *vq;
> 	bool added = false;
>
>-	vq = vsock->vqs[VSOCK_VQ_TX];
> 	mutex_lock(&vsock->tx_lock);
>
> 	if (!vsock->tx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_TX];
>+
> 	do {
> 		struct sk_buff *skb;
> 		unsigned int len;
>@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, event_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_EVENT];
>-
> 	mutex_lock(&vsock->event_lock);
>
> 	if (!vsock->event_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_EVENT];
>+
> 	do {
> 		struct virtio_vsock_event *event;
> 		unsigned int len;
>@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 		container_of(work, struct virtio_vsock, rx_work);
> 	struct virtqueue *vq;
>
>-	vq = vsock->vqs[VSOCK_VQ_RX];
>-
> 	mutex_lock(&vsock->rx_lock);
>
> 	if (!vsock->rx_run)
> 		goto out;
>
>+	vq = vsock->vqs[VSOCK_VQ_RX];
>+
> 	do {
> 		virtqueue_disable_cb(vq);
> 		for (;;) {
>@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 	} while (!virtqueue_enable_cb(vq));
>
> out:
>-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>+	if (vsock->rx_run &&

Instead of adding this check, what about adding a new label...

>+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> 		virtio_vsock_rx_fill(vsock);

out_nofill:
> 	mutex_unlock(&vsock->rx_lock);

And use it when we check `vsock->rx_run` ?

Since we are taking the mutex, we don't need to check it again.

The rest LGTM, but I agree with Bobby about the split, since the Fixes 
tag here is confusing. I'll reply there.

Thanks,
Stefano

