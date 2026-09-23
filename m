Received: from fraori-sdnproxy-3.icoremail.net (fraori-sdnproxy-3.icoremail.net [132.226.202.154])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1037CD2C;
	Wed, 23 Sep 2026 02:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=132.226.202.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130243; cv=none; b=AcXI0WI7bydB8T1tOj4qJwhmOfGyt+Ldc3hhROvK+dutQxl4hqli1R2VWGxK/vob+xokJAtpOKEBV3p8em5ZEh7aCyW85X+7JUsLJp9+XdoSD0U3CtNmDzzfAT9jR3Ua63ez56Zjhs8TpBii4gX9N/WoqBuL5rFkfT2fDLkz+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130243; c=relaxed/simple;
	bh=vqFMPjQWlxbj7M2C2z9wc7VWBFB95EXi5KDIe2h8Fh8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgjSWgEqIl4FfsikWSzqxNNaYtV+SjVA8wj5oLmNLK/vIx1LnuG1iJ62mh9TsVvmXxo+WI0vN5ktqGq2pc8h8XprkU/Oap7s0pYKj+sYjPXEAQTtqjZh2GcmBS+4Eg/FX1/WXINrYUxz6R0rK5f8vzoeeVkWPKkjk2YkM2gJO7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=132.226.202.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3migtOLNq4vsvAQ--.4161S3;
	Wed, 23 Sep 2026 10:23:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAH7DQtOLNqzObNAw--.61111S2;
	Wed, 23 Sep 2026 10:23:41 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Neal Gompa <neal@gompa.dev>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] nvme: apple: don't unbind the driver on reset failure
Date: Wed, 23 Sep 2026 02:22:46 +0000
Message-Id: <20260923022246.396036-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zi_KCgAH7DQtOLNqzObNAw--.61111S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?o5En3QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZx14AC2V9q43cqIiEB7VCKWQgzTF47xQDkI8NAgYzF2bFu/
	H+AHJg4+1EcSoEokfq2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZF18CFWxCry8tw43JFWftFc_yoW5Wr1kpF
	4rWasI9rZrWr1Dtr1UJr4DuF98uw1fJryUJryIgw4rur1FqryrZ3s8KFyY9FW5Ar9Yva13
	ZFWrJw15CF1kJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU

When apple_nvme_reset_work() fails it queues anv->remove_work, whose
callback apple_nvme_remove_dead_ctrl_work() unbinds the driver through
device_release_driver(). The work is embedded in the devm-allocated
apple_nvme, but apple_nvme_remove() only flushes ctrl.reset_work, so an
external unbind while the work is pending frees anv through
devres_release_all() before the callback runs, and it operates on freed
memory.

Fix this by not unbinding from a work item at all, mirroring commit
c7c16c5b1967 ("nvme-pci: don't unbind the driver on reset failure"):
on reset failure, disable the controller, mark the namespaces dead and
leave the controller in the dead state instead of queueing the deferred
unbind. The device stays bound and can be recovered by unbinding and
rebinding the driver. apple_nvme_disable() is now passed shutdown=true,
as in the final disable in apple_nvme_remove(), so entered requests are
completed.

Draining the work from apple_nvme_remove() is not an option: that path
holds the device lock the callback blocks on, so waiting would deadlock.

This issue was found by an in-house static analysis tool.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nvme/host/apple.c | 2 insertions(+), 15 deletions(-)

--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -193,7 +193,6 @@
 	mempool_t *iod_mempool;
 
 	struct nvme_ctrl ctrl;
-	struct work_struct remove_work;
 
 	struct apple_nvme_queue adminq;
 	struct apple_nvme_queue ioq;
@@ -1224,20 +1223,9 @@
 out:
 	dev_warn(anv->ctrl.device, "Reset failure status: %d\n", ret);
 	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DELETING);
-	nvme_get_ctrl(&anv->ctrl);
-	apple_nvme_disable(anv, false);
+	apple_nvme_disable(anv, true);
 	nvme_mark_namespaces_dead(&anv->ctrl);
-	if (!queue_work(nvme_wq, &anv->remove_work))
-		nvme_put_ctrl(&anv->ctrl);
-}
-
-static void apple_nvme_remove_dead_ctrl_work(struct work_struct *work)
-{
-	struct apple_nvme *anv =
-		container_of(work, struct apple_nvme, remove_work);
-
-	nvme_put_ctrl(&anv->ctrl);
-	device_release_driver(anv->dev);
+	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DEAD);
 }
 
 static int apple_nvme_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
@@ -1531,7 +1519,6 @@
 	}
 
 	INIT_WORK(&anv->ctrl.reset_work, apple_nvme_reset_work);
-	INIT_WORK(&anv->remove_work, apple_nvme_remove_dead_ctrl_work);
 	spin_lock_init(&anv->lock);
 
 	ret = apple_nvme_queue_alloc(anv, &anv->adminq);
-- 
2.39.5

