Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793625569;
	b=k/rroyRhYNSeY4a+BqApQJduPabA6hizPkz3yg5R1TU3cPE4dUU/5jf5TqfYRqt9Bfe6
	 3kxz2+Fjsxro/86n4kQD2TE9vN+zqiTeU1jEzrj2nkzAtytQSEVEnYze9632Vk3iIyVae
	 IuN/a/ZKf+P6W1UL0SZ1XtKRn16pcJDprJ1vUO1A8A29y3078b1901AIfWIUzGhTzDXuC
	 QOwGeeMYmiAc1RKWku1PEcJ2KzNPe2CTlENrtrBKlyT+kYr9aC3k7vmvyAdvYH2Y1tnX0
	 ZswkglNauat4RqWyxSNM0FzoR6xLnVAZc49ckd5KxZILGLsywfr5Rl7BGicNraN8beA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793625569;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=w13Rrn3tdlEuELFhNo3jkTdNqJmcL+1f+76btXH5O7w=;
	b=Wk0aOONvQmgehQS2ZRN85RBzc+InHKjmtE1aWpWjP7wRsWWPY2fS3Tg1kzQxBwZ6j5IH
	 DHinqsVi3/I79u4KXDKQAWs2eVnsVmj4eqU7YkymL+p9vwn+I0kmerMZRvXnJ/ZVy7oNv
	 06jxSaJrlbsNVqfBrUgg+GCwNI7qAObeV50cfSCNCvebXlCToUdjR/bePJS7qaRGGHCoQ
	 2uxcn7Z+wfh8aDWLitNj1VMxiiOmd32UFVDNUw+WVdfFidPZu8PlZTJXZdp3BxRyssCbz
	 z1nemtQFluJiSLuXdZPTaY2ISFIfw1ALZjQn76A4hzk99fV3hhexu6XcpKLEubjs5Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE22606A324;
	Mon,  2 Nov 2026 13:19:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DE22606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=w13Rrn3tdl
	EuELFhNo3jkTdNqJmcL+1f+76btXH5O7w=; b=P4GHcqnjhWG8rvfe9UONBBm3Gk
	nKb/9nf+tyf3M8Px91hjBTP1/QiZQSGR8XkoIfoeRm0FYHe7rRiST+u6OTUvyacd
	ywxqd74McwS+1+XhqhWX2am6YC8sHAiPSj1mu3gVYheMZefI9Zb3oDgXB1oucgRF
	WJyFMym/OH1miVpiY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBGbgTMjehqpOkZAQ--.13114S2;
	Mon, 02 Nov 2026 21:19:10 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: dvb-core: skip disable_source handler for a released entity
Date: Mon,  2 Nov 2026 21:19:07 +0800
Message-Id: <20261102131907.8922-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBGbgTMjehqpOkZAQ--.13114S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF45GrW5Kry5GFy5KF48Zwb_yoWrArWUpa
	97tay5KrW0qa1UZr4jya17XFn8ZwsYyay5CFy3J39rKr4rXrySqryFya4DWF17Gr4xAw42
	q3ZFqrZ7u3yrWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j5txhUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2rnWEK3qAAAsF

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

Fixes: 68ff5767ddc4 ("[media] media: dvb-frontend invoke enable/disable_source handlers")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dvb_frontend.c |  4 ++--
 drivers/media/dvb-core/dvbdev.c       | 14 +++++++++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

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
index d753d329502a..0b1ac40af164 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -208,10 +208,18 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 {
 #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	if (dvbdev->entity) {
-		media_device_unregister_entity(dvbdev->entity);
-		kfree(dvbdev->entity);
-		kfree(dvbdev->pads);
+		struct media_entity *entity = dvbdev->entity;
+
+		/*
+		 * Clear the pointer before the entity is unregistered and
+		 * freed.  The frontend release and open paths read it under
+		 * mdev->graph_mutex and pass it to the disable_source
+		 * handler, so a stale entity must not stay reachable.
+		 */
 		dvbdev->entity = NULL;
+		media_device_unregister_entity(entity);
+		kfree(entity);
+		kfree(dvbdev->pads);
 		dvbdev->pads = NULL;
 	}
 
-- 
2.34.1

