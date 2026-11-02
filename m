Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630067;
	b=zZSv5UiEGeb1CkBpo/r7iL8LvHvoLMsNRMUiW/XzXusOrEntVQkRIEG5DOeyCZQ1L3cx
	 NFg4FvDDju4IzZNXyhqEuTLhNMv3JxFZUZpgjk/awRcg0KB8m+C9dwg+BNQzgEaze/Bw0
	 HLrzmya1HUnGMPTEFCH3W5yrFh/3xSOF64CXGaZfk5SExFSnwl+GQOz1/AGl3u1GgvhLb
	 Zvbo7AmUkfGUAgJR1C2AxD5DwUK1QESWE1pmGSWaLaWfiNW/noC6UUXQz9PYu4VSx1gGq
	 65doPEfYdij2eeyYfmszbFYiGuvq0PaHtOReIg6LaPvZ3EQ/rZ7dPfBCXwbgqnNNztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630067;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=t2yJp9KJBtieLRaAUWCyHBOm25XmWK3DPcZY4ncy7dI=;
	b=yw1A5T/CppGR9NFsjrTuePDeJU9rkSKMl1Pdsti3ON2Q+SS5ueZxS84W2e8lAPTgCfQk
	 M12i2I94S0sr5ZSm/fDYqCMq4sSFAIc0iSdF3Qw4vp0nyw+UnwkcISnl+Ac7SSRaINjWy
	 AGrMbA1gnBYeZ8v0f0DJO5+Fq0cao6auUXFt5sVLAaOniHIMiVVcBsYgOUJR07xecRHj8
	 kcTj3lyxRByBPZzjmF0hCzX5pVtMAv7/85XUnwr2ghzV3FkN+6hSjozCJsvTVER8OGbqH
	 xJ3acQnBrPid4Q2eLMCWuA/7b1Y67zGPgwDQH1xsos5bCqjjeG9cTGi5bzRe50ILL2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A266606B0FE;
	Mon,  2 Nov 2026 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A266606B0FE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=t2yJp9KJBtieLRaAUWCyHBOm25XmWK3DPc
	ZY4ncy7dI=; b=kgnbyooCI7G9l7/YrnVEznB02NsJFa3oLBs0AZV+uyqOxg7JEZ
	UzCMPnoGLWgnh5YK18nawp4ldGIM06hTkJp6kX0huVUTTCtNMDyF132qu5nKdEt4
	UZ/ydH5QaObQbvPiJi6wNepUKnhCBb8esBf0L2JtCAfn6hdYb11Zf4U/U=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDm6v1nn+hqhrQZAQ--.25523S2;
	Mon, 02 Nov 2026 22:34:16 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] media: dvb-core: skip disable_source handler for a released entity
Date: Mon,  2 Nov 2026 22:34:15 +0800
Message-Id: <20261102143415.26942-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102131907.8922-1-25031212351@stu.xidian.edu.cn>
References: <20261102131907.8922-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDm6v1nn+hqhrQZAQ--.25523S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDZFyrtF47Xw1kKw4kWFg_yoWxGFy8pa
	93tayYgrWjgr4UZr4jya17XF98ZwsYyay5CF9xX39Fgr4rXr9aqrySy34DWF17Crs7Aa12
	qw1YqrW8u3yrWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUgUDXUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdTIMQAAs7

dvb_remove_device() frees the media entity of a dvb_device through
dvb_media_device_free() and sets dvbdev->entity to NULL.  The media
device of the adapter can still be registered at that point: au0828,
for example, only clears mdev->disable_source in au0828_usb_release(),
which runs after au0828_dvb_unregister() has unregistered the frontend
device.

A file descriptor that survives the disconnect then reaches
dvb_frontend_release() with dvbdev->entity already NULL and calls

	fe->dvb->mdev->disable_source(dvbdev->entity);

au0828_disable_source() dereferences that argument unconditionally:

	struct media_device *mdev = entity->graph_obj.mdev;

which faults:

	general protection fault: 0000 [#1] SMP KASAN
	KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
	RIP: au0828_disable_source+0x27/0xb70 au0828-core.c:445
	Call Trace:
	 dvb_frontend_release+0x2eb/0x500 dvb_frontend.c:2946

The error path of __dvb_frontend_open() has the same call.

Skip the handler when dvbdev->entity is gone.  For that check to be
sufficient, clear dvbdev->entity in dvb_media_device_free() before the
entity is unregistered and freed: both frontend paths read the pointer
while holding mdev->graph_mutex, and media_device_unregister_entity()
takes the same lock, so a reader either still sees a registered entity,
for which unregister waits, or sees NULL.  Clearing the pointer after
the unregister would leave a window in which the entity is read after
it was already freed.

Read the pointer only once, into a local variable, while the lock is
held.  dvb_media_device_free() stores NULL before taking graph_mutex,
so re-reading the field to pass it as the argument could still observe
NULL and hand it to the handler.  That store is not serialised with the
locked readers either, so publish the pointer with WRITE_ONCE() and
read it with READ_ONCE().

Stopping the pipeline the handler started is not done here.  Only the
driver knows how to release the link it owns, and dvb_media_device_free()
runs for every dvb_device, including the demux, dvr and ca entities that
never own a media link; calling the handler for those would deactivate a
link owned by another entity.  The au0828 driver stops the pipeline and
clears its saved link in au0828_usb_disconnect(), before the frontend
entity is unregistered, in a separate patch.

Fixes: 68ff5767ddc4 ("[media] media: dvb-frontend invoke enable/disable_source handlers")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v3:
- Publish dvbdev->entity with WRITE_ONCE() and read it with READ_ONCE()
  at both frontend call sites, so the clear in dvb_media_device_free()
  is not a plain data race with the readers that hold graph_mutex.
- State why the active pipeline is torn down by the driver rather than
  in dvb-core.  The matching au0828 change is attached to this mail.

Link: https://lore.kernel.org/r/20261102142508.24277-1-25031212351@stu.xidian.edu.cn

Changes in v2:
- Read dvbdev->entity once into a local variable under graph_mutex at both
  call sites.  dvb_media_device_free() clears the pointer without holding
  that lock, so re-reading the field for the call argument could still pass
  NULL to the handler.
---
 drivers/media/dvb-core/dvb_frontend.c | 14 ++++++++++----
 drivers/media/dvb-core/dvbdev.c       | 16 +++++++++++++---
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..bcee88e16576 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2826,9 +2826,12 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 	mutex_lock(&fe->dvb->mdev_lock);
 	if (fe->dvb->mdev) {
+		struct media_entity *entity;
+
 		mutex_lock(&fe->dvb->mdev->graph_mutex);
-		if (fe->dvb->mdev->disable_source)
-			fe->dvb->mdev->disable_source(dvbdev->entity);
+		entity = READ_ONCE(dvbdev->entity);
+		if (entity && fe->dvb->mdev->disable_source)
+			fe->dvb->mdev->disable_source(entity);
 		mutex_unlock(&fe->dvb->mdev->graph_mutex);
 	}
 	mutex_unlock(&fe->dvb->mdev_lock);
@@ -2941,9 +2944,12 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 		mutex_lock(&fe->dvb->mdev_lock);
 		if (fe->dvb->mdev) {
+			struct media_entity *entity;
+
 			mutex_lock(&fe->dvb->mdev->graph_mutex);
-			if (fe->dvb->mdev->disable_source)
-				fe->dvb->mdev->disable_source(dvbdev->entity);
+			entity = READ_ONCE(dvbdev->entity);
+			if (entity && fe->dvb->mdev->disable_source)
+				fe->dvb->mdev->disable_source(entity);
 			mutex_unlock(&fe->dvb->mdev->graph_mutex);
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..bb6369c3abde 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -208,10 +208,20 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 {
 #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	if (dvbdev->entity) {
-		media_device_unregister_entity(dvbdev->entity);
-		kfree(dvbdev->entity);
+		struct media_entity *entity = dvbdev->entity;
+
+		/*
+		 * Clear the pointer before the entity is unregistered and
+		 * freed.  The frontend release and open paths read it under
+		 * mdev->graph_mutex and pass it to the disable_source
+		 * handler, so a stale entity must not stay reachable.  Publish
+		 * it with WRITE_ONCE() because the store is not serialised by
+		 * that lock.
+		 */
+		WRITE_ONCE(dvbdev->entity, NULL);
+		media_device_unregister_entity(entity);
+		kfree(entity);
 		kfree(dvbdev->pads);
-		dvbdev->entity = NULL;
 		dvbdev->pads = NULL;
 	}
 
-- 
2.34.1

