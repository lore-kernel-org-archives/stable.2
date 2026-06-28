Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7DD345CBF;
	Sun, 28 Jun 2026 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782648979; cv=none; b=kqDO9KKdf6FytsT2MgifEnfkTRn0dRtdzSbFRzuVU+sI+lDRyfCSvJlTToazIAAMeI/4gj8orPuGnK6nQtfG4RurJPoZJ9thWs3e5tO6vvjFlqTZIgpfd4KlsH2k6mYScB7bk/x2oK1pA7TFdo6tMnURrnCZ/Mtiw7VA37vlQfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782648979; c=relaxed/simple;
	bh=K3LEOZi3mb6+Ahq/uyE5LxMYUu9tCgUnWkf5g+oXaEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O5ILlHdRXdDHqqLKElQMBKUJXQ2U620O/wBbvtNTIUPMgwhr80BFjn1tIqo76wJsOIbeC8vpI8SUIhZAVoFPO9TQSnV6tDd7qw5L1tolLsiSzL0PE8GW4Z+8qQzQfBtXYjh3Otd+4p7Cr+Viagxr0Lul/+tshOAQ9foQgPiJL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.74.7])
	by APP-05 (Coremail) with SMTP id zQCowABXo8aMEEFqIOfDFQ--.54108S2;
	Sun, 28 Jun 2026 20:16:14 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH v2] bluetooth: fix hci_dev registration leak in virtbt_probe
Date: Sun, 28 Jun 2026 20:16:10 +0800
Message-Id: <20260628121610.44496-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXo8aMEEFqIOfDFQ--.54108S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1fAw4kKw1xJr1fZrW3Awb_yoWkCFX_Wa
	4xZ3sruFn8CF12k3W2kF4fZr1Fva4FgFs7X34aq3s5WryDWF4UXw42qr1DAF1xW3y8CF15
	Aw4YqF4ay34fujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb48FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUjJ73PUUUU
	U==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAAMA2pAiorXYAABsf

When virtbt_open_vdev fails after hci_register_dev succeeds, the
open_failed error path calls hci_free_dev, which only releases the
allocation reference. The Bluetooth subsystem still holds a registration
reference and keeps the device on hci_dev_list. Fix by calling
hci_unregister_dev first, then hci_free_dev, matching the pattern in
virtbt_remove.

Suggested-by: Greg KH <gregkh@linuxfoundation.org>
Fixes: dc65b4b0f90a ("Bluetooth: virtio_bt: fix device removal")
Cc: stable@vger.kernel.org
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
Changes in v2:
- Fix patch format based on reviewer feedback
---
 drivers/bluetooth/virtio_bt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..bf6827431bb8 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -397,6 +397,7 @@ static int virtbt_probe(struct virtio_device *vdev)
 	return 0;
 
 open_failed:
+	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
-- 
2.39.5 (Apple Git-154)

