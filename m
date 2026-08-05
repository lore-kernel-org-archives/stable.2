Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59911D63E4;
	Wed,  5 Aug 2026 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785900580; cv=none; b=pub5HcJ2RnKEZgo2I5pnUL3ADGhz0j/gIceYisvUT98r++PCNQVRrU4fE24PF6/HAY6X7iJXgKc12dU0rD+87u9NdfdEADBUY+65z57SMuXUsmnyq8CAuWJK37lS4T/vWqEPoMcWojp0V9aIR77nzWodZyjyNfzMfV6bw8g+uVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785900580; c=relaxed/simple;
	bh=AI/kIRIenjwsfR92OqT0RI2xId5U24CYtYioWKbLVw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La/s8KvyLNXXeQMFNgWy5n5yXrnLCM+6NtWb6QHBeUgMjuQYAlNYZQ8BF9xwkgXvNXwuRu4aQsO8FIopETFvOjb38EdRe63kOKtNcVjfFbALddnKF20GGsUYQTqhohflZOgUsMtInU2VUXTzTUHL9otr7sx7mRxkVx9BvshZMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: e0cc53bc907d11f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:c12e839d-4c72-4928-8571-6db40df58688,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:1c21bdace605b4b60e9e13bcb2d35338,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e0cc53bc907d11f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from xwm-tianyi510pro-14imb.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 88261213; Wed, 05 Aug 2026 11:29:34 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	stable@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: [PATCH] virtio_input: reset device if input_register_device() fails
Date: Wed,  5 Aug 2026 11:29:31 +0800
Message-ID: <20260805032931.1606652-1-xiongweimin@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Probe marks the device DRIVER_OK with virtio_device_ready() before
calling input_register_device(). If registration fails, the error path
cleared vi->ready and called del_vqs() while the device was still live,
so the device could keep DMA to queues that were already torn down.

Match remove/freeze: call virtio_reset_device() on that path before
tearing down the virtqueues.

Fixes: 271c865161c5 ("Add virtio-input driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
 drivers/virtio/virtio_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index deec24e8e..1a87be4c8 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -331,6 +331,7 @@ static int virtinput_probe(struct virtio_device *vdev)
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
+	virtio_reset_device(vdev);
 err_mt_init_slots:
 	input_free_device(vi->idev);
 err_input_alloc:
-- 
2.43.0

