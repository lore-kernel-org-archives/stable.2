Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491373;
	b=eKjx9OLxKsDwtdpaeWY82Ao9IXrgZ4cYoWJ16lrKJMgjGWGXn6XZQphJR3ct1anB4tY4
	 ZFdog85dBiprpVDyrvh3ff5hofiOWaDh3juZ23cVMXPuiP7UNIis0jDbVxBHCFRisJMOs
	 HXspniOgtPidw7CNp5XkXmu/qxSH7Bshn5zRreZGZ1i0gcjuBsj6/6P8dKF1KzbL9S48n
	 CXCvzR9RxZTwaBWynygSXZQDYmDfcvEjr8Vu4ATZXG2m+nAyOcej5T0P1HAuCUVN+Ll3i
	 05sU8eGvUxvBtJUpgmmZ4es0BIe128U1kzxiV0LOgbp7Eax4f1lvjqnX+nrfe8J7UNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491373;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=bgbeXLpakycppDowgUJydOxIlWtu/HCC2F7zxGTUZN8=;
	b=CBmatyXdaEP7VBYC4XMEZV46jZM4f71ygpOMT3ZN/d/XUrZM267AlS0uYzXNBc+vRAtW
	 hrQpewSUkqi1OZ+gEyGAjc3XkJcMyP9vvuExlkinQPna40aEADfqY8WooI8PMfeIxj7jL
	 TvHlxcxdyrzhfSxlmAYHKVa17cY2cYHDzGqWldyb+ngl9f/57uextHRXlXoGZHvttC472
	 9EGdBiOQCt49ctiGQzE2oKFuPb+6deCP91igCw7lL7cHQuYIbPVZF+oBUL2lW2IoEY6Jf
	 WpgPzm5eLir0192mY1Te7voGvmKtLTALnkPHVbzV+U6eTcLxd8iroR3trcTeWqg/qTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887FB606A32A;
	Thu, 12 Nov 2026 13:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 887FB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=bgbeXLpakycppDowgUJydOxIlWtu/HCC2F
	7zxGTUZN8=; b=p9dJ8DMeHJ9bkrpZvs0aXbcWsqHKLhjAT6Jton8a59GSxWKfxl
	EXTMdPeYG0q8LPbHWN/+5zD5XOPDZETiumwMMqbGhkSbNotYmwrr5Hxvc5wSkhTz
	zFybDfEF1JxXo63DhuJaLuEXq59CksHAW0W6QFFXOxs/jGBiQ1Y5AMV1c=
Received: from user-virtual-machine.localdomain (unknown [223.160.172.137])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2Of_Vw_VqZeWGAQ--.35788S2;
	Thu, 12 Nov 2026 21:49:12 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4] media: dvb-core: skip disable_source handler for a released entity
Date: Thu, 12 Nov 2026 21:49:08 +0800
Message-Id: <20261112134908.42697-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <a19fa548-32a2-49a1-86ce-c93fcab7f729@kernel.org>
References: <a19fa548-32a2-49a1-86ce-c93fcab7f729@kernel.org>
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
X-CM-TRANSID:BLQMCkD2Of_Vw_VqZeWGAQ--.35788S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDZFyrKFW5Kr17Kr43Awb_yoW7KF4xpa
	97tay5KrW0qr4Uur4jy3W7WFn8ZanYyay5CFy3X39rKr4rXrySqryYya4DWF17Grs7Aa12
	q3WYqrWfC3yrWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvlb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
	W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bY9N-UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUPD2r0hNbUBAAEsc

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

Skip the handler when dvbdev->entity is gone.  Clear dvbdev->entity in
dvb_media_device_free() under mdev->graph_mutex, before the entity is
unregistered and freed: the frontend paths read the pointer under the
same lock, so a reader either still sees a registered entity, for which
unregister waits, or sees NULL.  Clearing the pointer after the
unregister would leave a window in which the entity is read after it was
already freed.

The entity can exist without a media device when registration failed:
media_device_register_entity() destroys the graph object in its error
path, and media_gobj_destroy() clears graph_obj.mdev.  There is no lock
to take in that case, so the pointer is cleared unconditionally and only
the lock is conditional.

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
Changes in v4:
- Clear dvbdev->entity under mdev->graph_mutex, as suggested by Hans
  Verkuil, and check the field directly at both frontend call sites.
  This replaces the local copy and the WRITE_ONCE()/READ_ONCE() pair.

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
 drivers/media/dvb-core/dvb_frontend.c |  4 ++--
 drivers/media/dvb-core/dvbdev.c       | 20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..a4301e142ea5 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2827,7 +2827,7 @@ static int __dvb_frontend_open(struct inode *inode, struct file *file)
 	mutex_lock(&fe->dvb->mdev_lock);
 	if (fe->dvb->mdev) {
 		mutex_lock(&fe->dvb->mdev->graph_mutex);
-		if (fe->dvb->mdev->disable_source)
+		if (dvbdev->entity && fe->dvb->mdev->disable_source)
 			fe->dvb->mdev->disable_source(dvbdev->entity);
 		mutex_unlock(&fe->dvb->mdev->graph_mutex);
 	}
@@ -2942,7 +2942,7 @@ static int dvb_frontend_release(struct inode *inode, struct file *file)
 		mutex_lock(&fe->dvb->mdev_lock);
 		if (fe->dvb->mdev) {
 			mutex_lock(&fe->dvb->mdev->graph_mutex);
-			if (fe->dvb->mdev->disable_source)
+			if (dvbdev->entity && fe->dvb->mdev->disable_source)
 				fe->dvb->mdev->disable_source(dvbdev->entity);
 			mutex_unlock(&fe->dvb->mdev->graph_mutex);
 		}
diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index d753d329502a..4c0e8e225d58 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -208,10 +208,24 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 {
 #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	if (dvbdev->entity) {
-		media_device_unregister_entity(dvbdev->entity);
-		kfree(dvbdev->entity);
-		kfree(dvbdev->pads);
+		struct media_entity *entity = dvbdev->entity;
+		struct media_device *mdev = entity->graph_obj.mdev;
+
+		/*
+		 * Clear the pointer before the entity is unregistered and
+		 * freed, under the lock the frontend open and release paths
+		 * take before they hand it to the disable_source handler.
+		 * The entity has no media device if registration failed.
+		 */
+		if (mdev)
+			mutex_lock(&mdev->graph_mutex);
 		dvbdev->entity = NULL;
+		if (mdev)
+			mutex_unlock(&mdev->graph_mutex);
+
+		media_device_unregister_entity(entity);
+		kfree(entity);
+		kfree(dvbdev->pads);
 		dvbdev->pads = NULL;
 	}
 
-- 
2.34.1

