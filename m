Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795763319;
	b=by9OLqfQyTY+bxP2uSlM+1O5K1NeoTIzuCLR7I8XLSCkc1gEWuWJlU88xar16tPVdGY3
	 PPoK4aq7lMaUrv5QiiNplzsbx+EaYTYF4hgKBCG7rkA1iGliBXY9YNE6XjrL9qe3XiK3E
	 YPN25E41Ax0/Y0JGn8PDNZdhUpeHxUh1MPHZcyZYQ+7F4JzwXGtuN5j7i8Dn7YrpwHqQX
	 +eBCr3m+3ut1iCyDqEGJv3r90gNE7BbIILLKmmxef9nxEx+yl7d5nGtlSKfkN0asyNeXp
	 Q3ne9nEMljPT7dAWhh8D4JxXPv8spuiNDfb539YhDhSCJtDeXoNMCsrXb54hpWDpFyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795763319;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=uTud52MSv5zlX5vzr0q2e7lP5nMrrTTxhkLocH5qEKA=;
	b=2d7HBxP3q42RpRCLkdZhD25qIEEwt79uqPKZlHMAChL6rSG+Lp/hfGi3bURxiR8WMgEf
	 Nb7eoz5oNQxIUiSx0l71H5Zg2BIUeITqhdcT6AeBr8LSRYtRQYrvIIDMKNL8NXwyZp9BA
	 bMzGlliaNeayCU9nuArABm8r7zW6yrE8l6VZn+39KDnOEaA+Aj9duioWirq1N4Fm/SPLn
	 dP8uyCqyECW6fesXrZf+Ely0irTSmS1UDuyPySiSqrsCK6l3C8mYA8Og0mffe9/QI+haS
	 Axo2iAt/h6rX/yVq1Y/JowXW26E9NknQoy16mod1/ZRI7n6TKJ0mVBl+vz6vHSqGr3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=p6WLV8RV;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96D606A31C;
	Fri, 27 Nov 2026 07:08:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A96D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=p6WLV8RV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=uT
	ud52MSv5zlX5vzr0q2e7lP5nMrrTTxhkLocH5qEKA=; b=p6WLV8RVcCkTGo0TNp
	r+jDu02gG8TWbIMVghQ4nD3sQri96VKP+0cecT2i1k1zBVkwU/Ao5QwOz+3CpdxN
	xlqypjrsUduhdMwmKRjpN2scHmTC88ObHOjhsu9D8xAqeicAUBC39RODnAMZZgts
	HwmVhR83ecx9LeXIdDotYLMWw=
Received: from liumingshu.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD33wVdLAlr0sYrLQ--.54228S2;
	Fri, 27 Nov 2026 15:08:28 +0800 (CST)
From: 17868388227@163.com
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: virtio_bt: fix skb double-free when send fails
Date: Fri, 27 Nov 2026 15:08:13 +0800
Message-Id: <20261127070813.662250-1-17868388227@163.com>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:_____wD33wVdLAlr0sYrLQ--.54228S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFyfWr1DXF1kAFy3GrWxJFb_yoW5Ar4UpF
	4Ykr9xArWDJF10vFW7Jr48ury5Awsrury3KrZ2gw1Y9r43JrWUWryIya4jq3WUCr93Ca17
	XF4vqryDCFs09aDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bb5lnUUUUU=
X-CM-SenderInfo: bprxmlaytymjisx6il2tof0z/xtbC6gxDK2sJLGwHKwAA3A

From: Mingshu Liu <26031212613@stu.xidian.edu.cn>

A double-free of struct sk_buff and a subsequent use-after-free were
observed in virtbt_send_frame() when virtqueue_add_outbuf() fails.
hci_send_frame() frees the same skb again after hdev->send() returns
an error.

This issue was triggered by our custom device emulation and fuzzing
framework on Linux 7.3 (7.3.0-00001-g0aef6eb5c859-dirty).
The extra local commit only adds kcov and does not touch virtio_bt.c.
The same error path is still present on mainline. The failure depends
on a broken TX virtqueue: the device first completes a buffer whose
used-ring id is not a head, the queue is marked broken, and the next
virtqueue_add_outbuf() returns -EIO.

The crash trace is as follows:

  virtio_bt virtio0: tx:id 3 is not a head!
  Bluetooth: hci0: sending frame failed (-5)
  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop+0x3c/0x1b0
  Read of size 4 at addr ffff88800ae5bee4 by task kworker/u17:0/71
  Workqueue: hci0 hci_tx_work
  Call Trace:
   <TASK>
   sk_skb_reason_drop+0x3c/0x1b0
   hci_send_frame+0x34a/0x420
   hci_tx_work+0x87a/0xcd0
   process_one_work+0x8cd/0x1900
   worker_thread+0x5a1/0xd10
   kthread+0x325/0x410
   ret_from_fork+0x566/0x7f0
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 50:
   __alloc_skb+0x14c/0x6e0
   l2cap_send_cmd+0x96/0xbf0
   l2cap_conn_start+0x33c/0x9e0
   l2cap_info_timeout+0x82/0xa0

  Freed by task 71:
   kfree_skbmem+0x18a/0x1f0
   sk_skb_reason_drop+0x10e/0x1b0
   virtbt_send_frame+0x1bc/0x210
   hci_send_frame+0x26a/0x420
   hci_tx_work+0x87a/0xcd0

The object belongs to skbuff_head_cache and is 240 bytes. The 4-byte
read is skb->users.

The issue arises because virtbt_send_frame() calls kfree_skb(skb) when
virtqueue_add_outbuf() fails and still returns that error.
hci_send_frame() treats a negative return as "the caller still owns
the skb" and frees it a second time. Both calls run in the same
hci_tx_work. The skb was never queued to the device.

Fix this by leaving the skb to hci_send_frame() on the error path.
Undo the preceding skb_push() so the buffer handed back matches the
one the caller passed in.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mingshu Liu <26031212613@stu.xidian.edu.cn>
---
 drivers/bluetooth/virtio_bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index c20d54088..c6bb602b4 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -103,7 +103,7 @@ static int virtbt_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	err = virtqueue_add_outbuf(vbt->vqs[VIRTBT_VQ_TX], sg, 1, skb,
 				   GFP_KERNEL);
 	if (err) {
-		kfree_skb(skb);
+		skb_pull(skb, 1);
 		return err;
 	}
 
-- 
2.34.1

