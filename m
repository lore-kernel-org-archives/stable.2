Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4FD3A5456
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259081; cv=none; b=twEgDCz9/VeKKnFVOGcyLmu33slOn5fkN7Ex75Vq/1g2qCHbACRfp290uHeUvLtqy94Itv0zv+fCqxnNossciUDlQ2EqGEYr1ezjUDvEIHPrMknWNiP+xhW+b8c2WemejB2Qg7uDyk3SKp7c/VSQFViV/73FFeNocJOf7X3R/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259081; c=relaxed/simple;
	bh=r9XIrRq0BRe9ek3EhJSgmSSJMb3TghTwa3VFKLtOMHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H06TXxe28GAm518y94cGRK0BW8TvmtiT7MTWdEb5px6rBCgjN48srDfiy5YrBgDTwwdIGqYUgU4zN0DxDznkUk3QVgJIjdRmPxIb3VHVwFjAgjKgZ8e3haJYEfct3MCAJtQ4/d7cRxHXAbttDvYtEnTlVOJhbUqPaaN5wR44Gf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hN09AZDe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hN09AZDe"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso93704b3a.1
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785259079; x=1785863879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WR4BOhpZkqrSIT/iY8eTx3WwtTbSih09bCKXi8nvBxI=;
        b=hN09AZDepD3t0OEG0rgi2Ektg+FeuFkLkeA8H16Yj3MAu4bec//B7mFByrbMV7b3qX
         Khj/rZyr/6xUh2N8YRwEy0RWPQGNhWS9Bc1+SjZhNMSXYKbVLzH8BWf5tGr/WkceANlM
         Zdr8vzcBYGXEVEi40qh0o1s20dvw1mJDvSSzCvoQI1BhasuI3e5FPkxvccYi/9inzJYY
         txPlSvhTlUsbVS4aowk739BUIC43MEbe1RQ8QVh5ipnIPiQWzpXW1yPWqHVbuxQKmGRr
         v/k8SObJ7/5HW0fy3eqdhAFeceeXZOmNwATP89hZ3S+7onlUvM0Hdohka/TauXxBck5j
         q8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785259079; x=1785863879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WR4BOhpZkqrSIT/iY8eTx3WwtTbSih09bCKXi8nvBxI=;
        b=J/DPWWEfJToBLn9yWle6U1KGYgtNBOIQsOaVyVbp+SOFPWtAQMvc2aeFHFZokBFZxf
         Jx9T+9I00n4oVLGJRvVGtgniiSYiNb9r2u87J4OqyGaFwOLF13BLjQjSMyzxHl2lOnau
         To5MqokZFedS1r4RzYOcTn6K4kSWmMyWvCIcr7Kik7hgnb99vk1W5NBpFwpWpQpYNcBO
         gGpSs6xekc2Vl+qsxsS+IKfnSM3OaQkrBNJ0P3FomBDO8GgUenV1MAnYFc2Gv/Bq8guC
         sZ0gfp6b+pdQdS8B99238rns9mQYx3xeYori+fbvjjfp0XTS2gCFi5lmnKvHFt4tFiSV
         COlQ==
X-Forwarded-Encrypted: i=1; AHgh+RqCyq87w2ItX7gR62hV+ptYFphb3IWEbAQ6i1fuqceiAWj/J9FpVkCEvLDzOZu3G/a07htnbYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgOaEupP9YY/1P3HHz4KWs3HaOmkhOaQhOH/hUmuvW3UoDaJEj
	PSBhGtREPdC7bs8f8JpRCjzk8iptWvhWDmQibyGAFR7m0kv5dcfgyFTl
X-Gm-Gg: AR+sD10UEUfLZlozzpbF+R+MC3woQaBVAAHFzd3FsBm9HhuXM7lG3XY46HjiImPg5P0
	wJwCynfqq9SSGFO5hrsc9oBQfVUS10JqUo5dOBiyRLHzU1p+JKmA8TZ0Tbf0X/7WRwdI6wcy7V6
	B//VGxLBkTYsxeTzA6xoRd1IJzLinqXv2rafMzE5M5TInY4q3EvlDwzs8QSvVzRsMNPLag+NuPp
	DP8jIC4GxyDaaWRsAhIO/STfRD2V/N1ezbCK2Cb32bcGUIPQB3+JjF3aUORtDncruaP7qZqlYa1
	tKHL1xkq25Lyyx67kj9cE6yXTLNGyhOLHyDjWFSrFbuuKskpCi4zWg/vCNJiRJNInhUu8ny1VHZ
	6Zy/FHdvKJBPFP9FF+vEFPHP8Kak/6e+Qy7hW0WiJVBF/04oCUwz94bKkPUULKqAsgvfEqFwu3b
	3inNwNrcvFiMohYa30UKrU6ig=
X-Received: by 2002:a05:6a00:9289:b0:845:d286:1fa2 with SMTP id d2e1a72fcca58-84e932ee09cmr3569287b3a.49.1785259078809;
        Tue, 28 Jul 2026 10:17:58 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea03767bbsm229289b3a.47.2026.07.28.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 10:17:57 -0700 (PDT)
Date: Tue, 28 Jul 2026 10:17:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] vsock/virtio: prevent workers from using deleted
 virtqueues
Message-ID: <amjkQ2F+NEK9SPAj@devvm29614.prn0.facebook.com>
References: <20260727035804.1860862-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727035804.1860862-1-bestswngs@gmail.com>

On Sun, Jul 26, 2026 at 08:58:01PM -0700, Weiming Shi wrote:
> The RX, TX and event workers read their virtqueue pointers before taking
> the mutex that protects the queue and its run flag. A work item delayed
> across freeze and restore can therefore retain a pointer deleted by
> virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
> and use the freed pointer.
> 
> RX has an additional path: when rx_run is clear, the common exit still
> refills the RX queue. A queued worker can consequently call
> virtqueue_add_sgs() immediately after freeze deletes the virtqueues.
> 
> BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
> Read of size 4 by task kworker/2:1
> Workqueue: virtio_vsock virtio_transport_rx_work
> Call Trace:
>  virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
>  virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
>  virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
>  process_one_work (kernel/workqueue.c:3314)
>  worker_thread (kernel/workqueue.c:3478)
>  kthread (kernel/kthread.c:436)
>  ret_from_fork (arch/x86/kernel/process.c:158)
>  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> ...
> Freed by task 141:
>  kfree (mm/slub.c:6566)
>  vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
>  vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
>  virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
>  virtio_device_freeze (drivers/virtio/virtio.c:658)
>  virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
>  pci_pm_freeze (drivers/pci/pci-driver.c:1098)
>  device_suspend (drivers/base/power/main.c:1968)
> Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Read each worker's virtqueue under its mutex after confirming that the
> queue is running, and only refill RX while RX is running.
> 
> Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
> Cc: stable@vger.kernel.org
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Assisted-by: OpenAI-Codex:gpt-5
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
> index 57f2d6ec3ffc..79cf19f58943 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c
> @@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
>  	struct virtqueue *vq;
>  	bool added = false;
>  
> -	vq = vsock->vqs[VSOCK_VQ_TX];
>  	mutex_lock(&vsock->tx_lock);
>  
>  	if (!vsock->tx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_TX];
> +
>  	do {
>  		struct sk_buff *skb;
>  		unsigned int len;
> @@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, event_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_EVENT];
> -
>  	mutex_lock(&vsock->event_lock);
>  
>  	if (!vsock->event_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_EVENT];
> +
>  	do {
>  		struct virtio_vsock_event *event;
>  		unsigned int len;
> @@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  		container_of(work, struct virtio_vsock, rx_work);
>  	struct virtqueue *vq;
>  
> -	vq = vsock->vqs[VSOCK_VQ_RX];
> -
>  	mutex_lock(&vsock->rx_lock);
>  
>  	if (!vsock->rx_run)
>  		goto out;
>  
> +	vq = vsock->vqs[VSOCK_VQ_RX];
> +
>  	do {
>  		virtqueue_disable_cb(vq);
>  		for (;;) {
> @@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
>  	} while (!virtqueue_enable_cb(vq));
>  
>  out:
> -	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
> +	if (vsock->rx_run &&
> +	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
>  		virtio_vsock_rx_fill(vsock);
>  	mutex_unlock(&vsock->rx_lock);
>  }
> -- 
> 2.55.0

Not a strong opinion from me, but since this last hunk is the one that
fixes the bug and the other hunks are moreso hardening, maybe break
these out into two patches?

Besides, that all looks good to me.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
