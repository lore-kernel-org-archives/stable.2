Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627937;
	b=eGqHWMttAaHev3ItIej4qYAh0dNNZe6jsf2gA7bmu9mEexEadg44HZsZtP2SR6lPuv5B
	 nrw0DGm2mkmt6I2aamEIvT9EvuIBEeG+GZd/JLRHZNZHGv/MTjvdnVJ7fzYCdloVISU40
	 8OwuGuH+H91jz2VGHEBzFi3N8vjFmE0RFd3cVtM+mIrO2l4Z9k2fE5roYeicwX3KRtu6k
	 yDDEEyjrkVeK5loQEcvgUsvLRGoGIZm+7xUZcTD9J5Xh2ATn8GBTOQwFKBW/fjzqOjHje
	 BHXl2oOTyZI9PHDuqAUFeBDQ/QZpa9XwMqucfMZxBwlZJRcMBZsmPk9Zm3Rlc0rE9Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627937;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=F5bX9LxXmM/a058JbeXjccAF344bS/YmCY7trRb5PMQ=;
	b=XqZYf5TMoHjkdpfe+RjOkeOwZzvIIuiI79wGK5dNvb/GpPTD/xQ2l0uqAqVk8RoywqXg
	 SoEV3dLL6EgDcpHs0/H3ThcwEoOctypx0NAUq0XfLRom7/DY9EnyyKBEX74kuz/Aw/LBn
	 CxAbu+MezCk0a3b4+0qZMgZgM9Cbr3OjaiYAF2MozrPZBBUMCtMI+NpUnrGcb/p6fHKUn
	 fF+tMyUm34JuhZh8/No++CbGrvzj/qVeA3YfpISf7viDsjXJB0puYch6YdX19tlJeBSxq
	 6WfNU+2MHUnXExtTbXeVxl2IEGe5Mn5FcGrPnJ3MPAocJhNMovhNpW/zjcjAjUTk6zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC45C60A3837;
	Mon,  2 Nov 2026 13:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC45C60A3837
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=F5bX9LxXmM/a058JbeXjccAF344bS/YmCY
	7trRb5PMQ=; b=thQADmLnRD2cGU0QggbmbEX5++SYWh7vOdWZm5Khn0svek/igK
	yZCVfAzYnxIkXG7Tp5QGFgHbMcfbm6z+9NBmLYfYJA3FUv7x/8TD7XAArU09qLmS
	e7bZqnKg8DdP0YNGuUBi3dKyKIxO81ndUsVa/4mjwdoqaKAs5DZwDTV84=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkB2fP8Ql+hqBIAZAQ--.47013S2;
	Mon, 02 Nov 2026 21:58:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Ricardo Ribalda <ribalda@chromium.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] media: dvb-core: skip disable_source handler for a released entity
Date: Mon,  2 Nov 2026 21:58:40 +0800
Message-Id: <20261102135840.17953-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkB2fP8Ql+hqBIAZAQ--.47013S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDZFyrtF47Wr18WFWUtwb_yoW7GFy8pa
	93tayYgrW0ga1UZr42ya17XFn8ZwsYyay5CFy3X39rKr4rXr9aqryFya4DWF17Grs7Aa12
	q3WaqrZ7u3yrWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Xr4l42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxU4fM3DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdS-+AAAsF

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
NULL and hand it to the handler.

Fixes: 68ff5767ddc4 ("[media] media: dvb-frontend invoke enable/disable_source handlers")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
- Read dvbdev->entity once into a local variable under graph_mutex at both
  call sites.  dvb_media_device_free() clears the pointer without holding
  that lock, so re-reading the field for the call argument could still pass
  NULL to the handler.

 drivers/media/dvb-core/dvb_frontend.c | 14 ++++++++++----
 drivers/media/dvb-core/dvbdev.c       | 14 +++++++++++---
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 0286da57f382..37bd909fe0fe 100644
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
+		entity = dvbdev->entity;
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
+			entity = dvbdev->entity;
+			if (entity && fe->dvb->mdev->disable_source)
+				fe->dvb->mdev->disable_source(entity);
 			mutex_unlock(&fe->dvb->mdev->graph_mutex);
 		}
 		mutex_unlock(&fe->dvb->mdev_lock);
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

