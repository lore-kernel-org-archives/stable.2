Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769D238D27
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 03:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124704; cv=none; b=bSxh4RumJwK19szrW0WEwAHePq+hG6U6n3Y39i6z40/MX8dmSQGa4qR3i+V7B5yFEiKWzEHZHwEduBbUwo3iA6XvAzfJm5ceKNvFBcJXV6WBlCZWE4G8FLb96hPUQf9aKzY/G0n2XCNuzhTtJVYza6WrL8fHYmUwZTojBELsbDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124704; c=relaxed/simple;
	bh=TlYdtrHL+mvv8ijwFP2OcSIxIVHRN2GalntvmJUIBYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LRpMw3p7x3lh4DcB8sbAAMG2p6Ynw6DCttrom6MAM1LV8nap5dKiZL0RGqp0P3j/cETYJyQ0i1DTxPAIZ7vl+cuI/Afmd+GuIenbPuFSN7k2uqFfNu1tkACsLUHghEBM+Lvy+JDKJMNB2aTcT+fb22qIVk6epk5U7w5kGna4U5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahwfY66z; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahwfY66z"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso2525146b3a.2
        for <stable@vger.kernel.org>; Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785124701; x=1785729501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=ahwfY66zDbAXsQqwMUqmvNugb24L7dtZnO1YYO4fmR8R5/rPZc3Yt4DvLM/1jnW/P+
         PuB9W2gZpU2pgAG4Pht9DZBLERJgiOxxFN6h5SH6UEaWt89OCPQallXr13NR2vfCptFA
         mFK1d31Mv7z5RAafcGaRAhrOt40UG6QxrtnwMnj4Ur0Sr58xvgOB0mM1c2JNwmV6NDNm
         hX87wFKSyGWM7IBoUYGMti9sOTScrCJtuMd/MEf5tUClEwlihqIunGNWmiJwvnoydaKJ
         WvzhVbLzj+Zhm+S4t4qo7/kftxeKr14RbE44/2iD1i24uAv3GNL6nzfGVNnjPGaLvXdU
         7W+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785124701; x=1785729501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CNXhg8nK5Amg7PhF6ggu9ut1cROCit9+iswBjWYSAoE=;
        b=UdmkmlRUIdyxUNFiOGAMBsLfiYwVZ0py+rHmvDLp1xSDXrXgFrAwdaZR5S4ILBv5eO
         RNQ4paouFtaxTQDBgQf1BPuQD2QpiYFJU5Z2R4cF0OjB80B+MqSPIp7n8fHSmsmOrx9T
         WuGIe86u/1gYTwZrHt17SB49bOatrHWMMWa67pXBSPj1XBe3I6r5G3hd/Jgx0XjM59F7
         bMNVu/VK1khwQ7a200m/tF9hE3M289pYxgdRJuOO5A+vq2jCHlkv3mEtJ1BDzTDSPVT2
         qhZraJY0j92jHhztODrRXSJ2jMBgCTFAgwbpd0S2gIi+InRObSzYWNniCgP3CDJH0TLh
         xpng==
X-Forwarded-Encrypted: i=1; AHgh+Rp9lGBT7QXTrfJmQS9DSiS+AXFXHyu75KrGxojCh4DKrprfGmxxRn+ohXNvJcyTKn9ZCJ3LSTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvomKoO2p4lcugA30pwcjyaqlleLI/Ofjyzt8u5z24rZqyuBFU
	6dtrisDjtlPemTOSX1BwEN7X3s10HxCxdjBtEUWXkveatPrZgx9Q8yYa
X-Gm-Gg: AR+sD11TqFbyxnJk3xwGd+0ZrxkEBmL4ijt5OkQNbpkKZzqa6UOZUeOxHLmgkokPcHC
	CKIgPXA4qA8z4fSTQIthgDyoWnVCMhT7MLmk5DYanb63QpQCtIJW9gThly5encbDzsMOCXf/hrG
	wnJR9TNAzGLBtHj6S5IBqoyJ94QVuMHCqsZ45sENHsDm/vzbQN8D7w1Xd4rCj/XjYFwY+5e3NK4
	Bg69O7+mz0XsSXC/voF8ecCyQ+PslFgls+Cb/fLP5zxdMviI5HFOK8TukLSgkf4p/cesrWzdU3C
	ykH70Ub+kgGp79uwPi0CJS1n3ZrkQDDB1GgZR4lllwjJQlcO9di+mLpf1DvBCZ9epphwHm2JXvT
	rLcR9rEoQolFuznz1qI8Q62jsXDkGWLFZkJg74wLghupbagSwWM3Qv7i/2jKdVmbthpumlJp/c/
	S1ydpVYt7BH4ciQwRqMt82
X-Received: by 2002:a05:6a00:4294:b0:848:4190:ae72 with SMTP id d2e1a72fcca58-84e5955f15cmr5374554b3a.46.1785124701206;
        Sun, 26 Jul 2026 20:58:21 -0700 (PDT)
Received: from bogon ([2408:8207:1832:1b44::c6b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660dedfsm2680815a12.4.2026.07.26.20.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 20:58:20 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: [PATCH] vsock/virtio: prevent workers from using deleted virtqueues
Date: Sun, 26 Jul 2026 20:58:01 -0700
Message-ID: <20260727035804.1860862-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX, TX and event workers read their virtqueue pointers before taking
the mutex that protects the queue and its run flag. A work item delayed
across freeze and restore can therefore retain a pointer deleted by
virtio_vsock_vqs_del(), observe the run flag for the replacement queues,
and use the freed pointer.

RX has an additional path: when rx_run is clear, the common exit still
refills the RX queue. A queued worker can consequently call
virtqueue_add_sgs() immediately after freeze deletes the virtqueues.

BUG: KASAN: slab-use-after-free in virtqueue_add_sgs
Read of size 4 by task kworker/2:1
Workqueue: virtio_vsock virtio_transport_rx_work
Call Trace:
 virtqueue_add_sgs (drivers/virtio/virtio_ring.c:2796)
 virtio_vsock_rx_fill (net/vmw_vsock/virtio_transport.c:332)
 virtio_transport_rx_work (net/vmw_vsock/virtio_transport.c:701)
 process_one_work (kernel/workqueue.c:3314)
 worker_thread (kernel/workqueue.c:3478)
 kthread (kernel/kthread.c:436)
 ret_from_fork (arch/x86/kernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
...
Freed by task 141:
 kfree (mm/slub.c:6566)
 vp_del_vq (drivers/virtio/virtio_pci_common.c:259)
 vp_del_vqs (drivers/virtio/virtio_pci_common.c:285)
 virtio_vsock_freeze (net/vmw_vsock/virtio_transport.c:912)
 virtio_device_freeze (drivers/virtio/virtio.c:658)
 virtio_pci_freeze (drivers/virtio/virtio_pci_common.c:601)
 pci_pm_freeze (drivers/pci/pci-driver.c:1098)
 device_suspend (drivers/base/power/main.c:1968)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Read each worker's virtqueue under its mutex after confirming that the
queue is running, and only refill RX while RX is running.

Fixes: b917507e5ad9 ("vsock/virtio: stop workers during the .remove()")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: OpenAI-Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/vmw_vsock/virtio_transport.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 57f2d6ec3ffc..79cf19f58943 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -346,12 +346,13 @@ static void virtio_transport_tx_work(struct work_struct *work)
 	struct virtqueue *vq;
 	bool added = false;
 
-	vq = vsock->vqs[VSOCK_VQ_TX];
 	mutex_lock(&vsock->tx_lock);
 
 	if (!vsock->tx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_TX];
+
 	do {
 		struct sk_buff *skb;
 		unsigned int len;
@@ -451,13 +452,13 @@ static void virtio_transport_event_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, event_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_EVENT];
-
 	mutex_lock(&vsock->event_lock);
 
 	if (!vsock->event_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_EVENT];
+
 	do {
 		struct virtio_vsock_event *event;
 		unsigned int len;
@@ -634,13 +635,13 @@ static void virtio_transport_rx_work(struct work_struct *work)
 		container_of(work, struct virtio_vsock, rx_work);
 	struct virtqueue *vq;
 
-	vq = vsock->vqs[VSOCK_VQ_RX];
-
 	mutex_lock(&vsock->rx_lock);
 
 	if (!vsock->rx_run)
 		goto out;
 
+	vq = vsock->vqs[VSOCK_VQ_RX];
+
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
@@ -689,7 +690,8 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	} while (!virtqueue_enable_cb(vq));
 
 out:
-	if (vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
+	if (vsock->rx_run &&
+	    vsock->rx_buf_nr < vsock->rx_buf_max_nr / 2)
 		virtio_vsock_rx_fill(vsock);
 	mutex_unlock(&vsock->rx_lock);
 }
-- 
2.55.0
