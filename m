Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7172877DE;
	Sat, 17 Oct 2026 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792220633; cv=none; b=Ufo+C1WEdGC8BppyL3e4LHoRmesIbXc9upLA63ZjpnQ/jcmqvg5ELxydWH99Ux7lup5lFlVCpcB8P7CM8dT2lOidCopFuRdkouAacdsmi8pG8jO+PJyYbP8yS/5uqRYMQTiDcgK7BV5LpCo4MrRxWOjIdBN842dJOcRtx0vbD1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792220633; c=relaxed/simple;
	bh=LlGpm7qD6u3DExZbUErAOyHnhK2G0MPho8mL0LeRKrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ltAc8EesJ9jj/d7nRdCs3uj0EQruS09wBM82x/7V3/uOwxGD05o6MHqulyGh55yei11eRdVeItk5cUFCgBPfxuLWQaOkXph8jdjCCedX2oTy6soPul3hqhm1GSN10RNdx/ggqmHFK0uRfVWdzLLKI/RUuBpbC30idBcI3ir9pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=VigEsU6H reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="VigEsU6H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=LH5oxfFALy
	feze5kOzVd/GRJgHOwip9pVGpes13qqVo=; b=VigEsU6HFhexcs3LBS6k+2+4xR
	BcK0BDY2+EkpoKIS5h2MGqI7SnFnslgkj/2Uc8ATs+VeM7RGmk+kUYWXpsyXFLWF
	v/UgJlBsGhIMxTrDLoEwCfgWeZlZVxJ083eMVqXka9oLZD4Qh562QPBoO2Hcdwd3
	5DXMujB3a1XYZ2MJY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.50])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2XALHHdNqiyWvAA--.26153S2;
	Sat, 17 Oct 2026 15:03:36 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: linux-wireless@vger.kernel.org,
	libertas-dev@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] wifi: libertas: check workqueue creation in lbs_add_card()
Date: Sat, 17 Oct 2026 15:03:35 +0800
Message-Id: <20261017070335.19330-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkA2XALHHdNqiyWvAA--.26153S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy3CFWfKr1kZry3KF4kWFg_yoW5Wry3pr
	W5CryUK3yFyr4qka98Jws7tF15Cw1fJFy3GrWI9w1rAwsxGrZYv34FgFyUWrW5AFW0vFW7
	ZF98t3s2yFWqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8HrW5UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUJD2rSPdFn1gAAsn

lbs_add_card() does not check whether create_singlethread_workqueue()
returned a valid workqueue.  That helper always creates the workqueue
with WQ_MEM_RECLAIM, so alloc_workqueue() also creates a rescuer kthread
and returns NULL if that kthread cannot be created, for example when the
task which starts the driver is killed while kthread_create() waits for
the new thread:

  workqueue: Failed to create a rescuer kthread for wq "lbs_worker": -4

-4 is -EINTR, which is exactly what the killable wait in
kthread_create_on_node() returns when it is interrupted.

The card is published anyway, with priv->work_thread left NULL, and the
removal path destroys the workqueue unconditionally.  destroy_workqueue()
dereferences the NULL pointer while unregistering the workqueue from
sysfs, which faults at offset 0xb0, the ->wq_dev member of struct
workqueue_struct:

  KASAN: null-ptr-deref in range [0x00000000000000b0-0x00000000000000b7]
  RIP: 0010:destroy_workqueue+0x2e/0xc00 kernel/workqueue.c:6147
  Call Trace:
   lbs_remove_card+0xc9/0x3a0 main.c:919
   if_usb_disconnect+0xc1/0x270 if_usb.c:317

Fail the probe instead of publishing a card whose workqueue could not be
created.  The other two libertas bus backends already check the result
of their alloc_workqueue() call, and all three callers of lbs_add_card()
already handle an ERR_PTR() return, so no caller needs to change.

Fixes: 2afc0c5d71a3 ("[PATCH] libertas: push WEXT scan requests to a work queue")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/marvell/libertas/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/marvell/libertas/main.c b/drivers/net/wireless/marvell/libertas/main.c
index dd97f1b61f4d..522736ca6cfd 100644
--- a/drivers/net/wireless/marvell/libertas/main.c
+++ b/drivers/net/wireless/marvell/libertas/main.c
@@ -877,6 +877,12 @@ struct lbs_private *lbs_add_card(void *card, struct device *dmdev)
 	}
 
 	priv->work_thread = create_singlethread_workqueue("lbs_worker");
+	if (!priv->work_thread) {
+		err = -ENOMEM;
+		lbs_deb_thread("Error creating worker thread.\n");
+		goto err_thread;
+	}
+
 	INIT_WORK(&priv->mcast_work, lbs_set_mcast_worker);
 
 	priv->wol_criteria = EHS_REMOVE_WAKEUP;
@@ -886,6 +892,9 @@ struct lbs_private *lbs_add_card(void *card, struct device *dmdev)
 
 	return priv;
 
+ err_thread:
+	kthread_stop(priv->main_thread);
+
  err_ndev:
 	free_netdev(dev);
 
-- 
2.34.1

