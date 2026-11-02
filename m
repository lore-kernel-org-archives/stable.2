Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637919;
	b=AdVMJohKq3V6oqHEFzh6Xl0VWpt3L5CD5YwhBB2yZeIdbH8qqbiNuVjNi/kZOsnRTlMe
	 ZkNc8nClW92rS9ZO/C91tXKCO3D5VBLI7KIXbI49qIPC/pdrfy006ma7sIxzpq9fhD6xC
	 0OgIKJeqzAJdBqDO8tHmd0YZhrPN8TU3FJgunURWrRUZ2uFOrDj/D25UYPvKSIaVZkDtu
	 tOMLoVn/tchphzjDKbLgy9zgHEdKk2YKMiu6B+Giod5tr4DBXn7qi2T16sjRR9lOEZp2a
	 ZUEDBJKMbXEtLXjiFjgHfaxPaLbH2g7A3ZgchJse+8VD9g3/7x5Q1dcDxWUzFc/723w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637919;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=+0lRfq2vj1MiAcYu28+ByKVnJnPRI+zYbAYZT7dKudM=;
	b=e7CAh7FQZE1dTWwzPChodvpYArMExmrRKk4kcEPOmRepCkh2xct1YI/I5msFvNHKYsjj
	 bWNhIw8kDDEAn4GHA2krgt7n4c0cuGCG3AjaRLhadh2heFZ3GlK6l7zT6WB//b9eCd/ka
	 +cOTDjbUBAaXTex8sUif3OKUg692OwrVikx6FczVXVsK0iiZhZe02x2LGKyE94IND2dzq
	 wdrFVdSudbZJQJoI2t4Yl4lcQfKi37FWNpSNH59kk+hwIuhL+6PS0xXTDQsiopW9tK+tE
	 Y9iddUlhfpHnx23fE/+Z8egGxefwClmlhcHnT+sCVPCDuPGQe1G7BOKp+yRTj65qooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CC0606CEC3;
	Mon,  2 Nov 2026 16:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85CC0606CEC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=+0lRfq2vj1MiAcYu28+ByKVnJnPRI+zYbA
	YZT7dKudM=; b=CPqM+gLO7q/Lrri/PorKip2/6JIaoVofgNnoywpuPJ+i+Zwcn7
	kCI6RaqE1LPsZ94CinV0skVHKOpcRNUlPWHyRpyyYCV8rMHZA6Z8BozpWbyJwImu
	gN9CioplirWwYpv9xJWOvloB2ztRc/g5BPZRs9VEpEMGL91oeJ5aRX3rA=
Received: from user-virtual-machine.localdomain (unknown [223.160.172.231])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCGifwTvuhqM0gaAQ--.24869S2;
	Tue, 03 Nov 2026 00:45:08 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: au0828: release the media source when the device is disconnected
Date: Tue,  3 Nov 2026 00:45:06 +0800
Message-Id: <20261102164506.2995-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102142508.24277-1-25031212351@stu.xidian.edu.cn>
References: <20261102142508.24277-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkCGifwTvuhqM0gaAQ--.24869S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar4DCF1xWry8GF45JryDGFg_yoWxKr1xpa
	yfKF4rtrWqqF45u3y7J34UXF1rWasaqay7Ar9Fga93uF4fuFW8Xw1fu343Wrn8Cr95Cr4Y
	yw4jqr47CrWUurJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r1l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUkg10UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2roqcIOxwAAst

au0828_enable_source() starts the media pipeline and saves the link, its
owner and the source and sink entities in struct au0828_dev.  The matching
au0828_disable_source() is only called from the frontend open and release
paths.

When the device is disconnected, au0828_dvb_unregister() removes the
frontend entity through dvb_unregister_frontend().  dvb_remove_device()
frees the entity unconditionally and __media_entity_remove_links() frees
every link of it, but the source is not released: the pipeline is never
stopped and dev->active_link, dev->active_link_owner, dev->active_source
and dev->active_sink keep pointing at freed memory.

struct au0828_dev stays alive until the last V4L2 file descriptor is
closed, because the video device holds a reference to v4l2_device.  A
later close therefore reaches au0828_disable_source() through
v4l2_fh_exit() and dereferences the freed link and entity.

Stop the pipeline and deactivate the link in au0828_usb_disconnect(),
before the frontend entity is unregistered and while holding graph_mutex.
Move the cleanup tail of au0828_disable_source() to
au0828_release_active_link() so that both paths share it; the disconnect
path must not be skipped by the dev->users > 1 check, which only applies
to a video owner.  Nothing has to be released when no link was activated,
so the call is guarded by dev->active_link_owner, and the guard is
evaluated again under graph_mutex: a close that runs in between can clear
the field before the disconnect path acquires the lock.

au0828_disable_source() stops the pipeline itself on the way to its
deactivate_link label, so the label deactivates the link and clears the
saved state only (au0828_deactivate_link()), while the disconnect path
calls au0828_release_active_link(), which stops the pipeline first.
Calling __media_pipeline_stop() a second time for the same pipeline trips
its WARN_ON(!pipe) check.

au0828_enable_source() refuses to start a pipeline once DEV_DISCONNECTED
is set.  Without that check a frontend open that happens while
au0828_dvb_unregister() shuts the rest of the device down can reactivate
the link after the disconnect path released it, and the frontend entity
is then freed with an active pipeline.

Fixes: c94903f1f7cc ("[media] media: au0828 add enable, disable source handlers")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
- Re-check dev->active_link_owner under graph_mutex.  A close running on
  another CPU can clear it while the disconnect path waits for the lock,
  and au0828_release_active_link() would then dereference NULL.
- Split the shared cleanup into au0828_deactivate_link(), so the
  deactivate_link label of au0828_disable_source() does not stop the
  pipeline a second time.  __media_pipeline_stop() warns on an unbalanced
  call.
- Reject au0828_enable_source() after DEV_DISCONNECTED, so a frontend
  open cannot reactivate the link while the device is being torn down.
- The NULL entity that dvb_frontend_release() passes after
  dvb_media_device_free() is a dvb-core problem, fixed separately by
  https://lore.kernel.org/r/20261102143415.26942-1-25031212351@stu.xidian.edu.cn
---
 drivers/media/usb/au0828/au0828-core.c | 64 ++++++++++++++++++++------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 445cbeb7abae..0d4528a26c7d 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -120,6 +120,7 @@ static int recv_control_msg(struct au0828_dev *dev, u16 request, u32 value,
 #ifdef CONFIG_MEDIA_CONTROLLER
 static void au0828_media_graph_notify(struct media_entity *new,
 				      void *notify_data);
+static void au0828_release_active_link(struct au0828_dev *dev);
 #endif
 
 static void au0828_unregister_media_device(struct au0828_dev *dev)
@@ -175,6 +176,19 @@ static void au0828_usb_disconnect(struct usb_interface *interface)
 	set_bit(DEV_DISCONNECTED, &dev->dev_state);
 
 	au0828_rc_unregister(dev);
+#ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * The frontend entity can own the active link.  Its entity is released
+	 * by au0828_dvb_unregister() below, so stop the pipeline and deactivate
+	 * the link while the entity is still registered.
+	 */
+	if (dev->media_dev) {
+		mutex_lock(&dev->media_dev->graph_mutex);
+		if (dev->active_link_owner)
+			au0828_release_active_link(dev);
+		mutex_unlock(&dev->media_dev->graph_mutex);
+	}
+#endif
 	/* Digital TV */
 	au0828_dvb_unregister(dev);
 
@@ -300,6 +314,10 @@ static int au0828_enable_source(struct media_entity *entity,
 
 	dev = mdev->source_priv;
 
+	/* Do not start a new pipeline on a device that is going away */
+	if (test_bit(DEV_DISCONNECTED, &dev->dev_state))
+		return -ENODEV;
+
 	/*
 	 * For Audio and V4L2 entity, find the link to which decoder
 	 * is the sink. Look for an active link between decoder and
@@ -438,6 +456,37 @@ static int au0828_enable_source(struct media_entity *entity,
 	return ret;
 }
 
+/* Callers should hold graph_mutex */
+static void au0828_deactivate_link(struct au0828_dev *dev)
+{
+	int ret;
+
+	ret = __media_entity_setup_link(dev->active_link, 0);
+	if (ret)
+		pr_err("Deactivate link Error %d\n", ret);
+
+	pr_info("Disabled Source: %s->%s->%s Ret %d\n",
+		dev->active_source->name, dev->active_sink->name,
+		dev->active_link_owner->name, ret);
+
+	dev->active_link = NULL;
+	dev->active_link_owner = NULL;
+	dev->active_source = NULL;
+	dev->active_sink = NULL;
+	dev->active_link_shared = false;
+	dev->active_link_user = NULL;
+	dev->active_link_user_pipe = NULL;
+}
+
+/* Callers should hold graph_mutex */
+static void au0828_release_active_link(struct au0828_dev *dev)
+{
+	__media_pipeline_stop(dev->active_link_owner->pads);
+	pr_debug("Pipeline stop for %s\n", dev->active_link_owner->name);
+
+	au0828_deactivate_link(dev);
+}
+
 /* Callers should hold graph_mutex */
 static void au0828_disable_source(struct media_entity *entity)
 {
@@ -537,20 +586,7 @@ static void au0828_disable_source(struct media_entity *entity)
 			dev->active_link_owner->name);
 
 deactivate_link:
-		ret = __media_entity_setup_link(dev->active_link, 0);
-		if (ret)
-			pr_err("Deactivate link Error %d\n", ret);
-
-		pr_info("Disabled Source: %s->%s->%s Ret %d\n",
-			 dev->active_source->name, dev->active_sink->name,
-			 dev->active_link_owner->name, ret);
-
-		dev->active_link = NULL;
-		dev->active_link_owner = NULL;
-		dev->active_source = NULL;
-		dev->active_sink = NULL;
-		dev->active_link_shared = false;
-		dev->active_link_user = NULL;
+		au0828_deactivate_link(dev);
 	}
 }
 #endif
-- 
2.34.1

