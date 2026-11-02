Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629526;
	b=RRlrDTdTOoD5sMI/tn/6lrktrN/3icTexPU5IoZwongbRrc/T8ibxgaIfX91CEYHRE05
	 5MTb6SEPgOOgFRGXs07Bb2I0X45lceThk59bhD/obgS4FzvzZePT7UWXEE9hkrpVPV9XT
	 yWq3l3DWX/Oy5uHukFyltl/aT+IWi4W1RXU/9U2lO48QBVjsA95HXCFwJ4jn/CYsyG2BP
	 einlfIs3QbQHbe+vmNvSMsiP+hv2xZfWLYRuWi9UwLI8ZwftBOCrjoXZD7xaw7nxTgs0j
	 LRsYV2Z5ybyvyyi1Z6gDQJboXdLhoc0xLPxfPstGU6BcuvTko5TgrKemGeYF8/bwlHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629526;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=wxk2D2Tyz0niqEJ7raNF2H1HyA1O1DKEL6gbE1BW9h4=;
	b=m349EwU/JZDSEdk5zBLPD42lPP/OaFYA8hpQxfdEimZySq507/4k7supLVRfCVzvAoLc
	 XZYUpph1X521FxoOYt3wWNR1Uc+j1lS8Pn9zlUArsTYqQBRNIvAV7+lUViam75H4I2BN0
	 eiuwWVVZOMPfN0dXF3uvJW35mGPbxxZVQVjg+ApLjA6ygd8/GNbW9frN2/++3vG/zbikX
	 fcOUXExwzffoBqtqH/BlIOUmGNRef2Q3FNKcyNksENmtztBXWSjiZoIPILpZI76GRAQxU
	 I7avwzgg6rXTTxc0wMwom2Qk+5f2FdpJBdunExsKE9z7MQMQeyiUnl1MmgdcSMZ5yHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC61606B0E0;
	Mon,  2 Nov 2026 14:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC61606B0E0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=wxk2D2Tyz0
	niqEJ7raNF2H1HyA1O1DKEL6gbE1BW9h4=; b=Hhum9g4EHbXywPStVc3wWl4tkl
	vB7y8AsZmnwyiqFJB+lDzIAX7Ji0RzMgM4XzfE1UAgBPeGIszIx3i0ImtOYCN+uA
	Bg5VicHgwgpmgtvjiFrDBNWR8YiZrktT4gR3sUjpgNXVpOPcgontOlMuJmAZQobL
	u3cZlEqJMp4yM/vkY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.101])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGywBEnehqrvoZAQ--.54106S2;
	Mon, 02 Nov 2026 22:25:10 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: au0828: release the media source when the device is disconnected
Date: Mon,  2 Nov 2026 22:25:08 +0800
Message-Id: <20261102142508.24277-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGywBEnehqrvoZAQ--.54106S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZrW8JFWDKw4UZFWxuFyrXrb_yoW7JFyfpF
	yftF4ftrWqqF45u3y7Ja47XF1ruF9agFWxJr9Fga93uF4fCFy8Xw1fua43Wrn8CryrurWY
	yw4jqw4UCFWUWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUcmhFUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2rnWELD1QAAsM

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
so the new call runs only when dev->active_link_owner is set.

Fixes: c94903f1f7cc ("[media] media: au0828 add enable, disable source handlers")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/au0828/au0828-core.c | 53 +++++++++++++++++++-------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 445cbeb7abae..57a163415d1c 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -120,6 +120,7 @@ static int recv_control_msg(struct au0828_dev *dev, u16 request, u32 value,
 #ifdef CONFIG_MEDIA_CONTROLLER
 static void au0828_media_graph_notify(struct media_entity *new,
 				      void *notify_data);
+static void au0828_release_active_link(struct au0828_dev *dev);
 #endif
 
 static void au0828_unregister_media_device(struct au0828_dev *dev)
@@ -175,6 +176,18 @@ static void au0828_usb_disconnect(struct usb_interface *interface)
 	set_bit(DEV_DISCONNECTED, &dev->dev_state);
 
 	au0828_rc_unregister(dev);
+#ifdef CONFIG_MEDIA_CONTROLLER
+	/*
+	 * The frontend entity can own the active link.  Its entity is released
+	 * by au0828_dvb_unregister() below, so stop the pipeline and deactivate
+	 * the link while the entity is still registered.
+	 */
+	if (dev->active_link_owner) {
+		mutex_lock(&dev->media_dev->graph_mutex);
+		au0828_release_active_link(dev);
+		mutex_unlock(&dev->media_dev->graph_mutex);
+	}
+#endif
 	/* Digital TV */
 	au0828_dvb_unregister(dev);
 
@@ -438,6 +451,31 @@ static int au0828_enable_source(struct media_entity *entity,
 	return ret;
 }
 
+/* Callers should hold graph_mutex */
+static void au0828_release_active_link(struct au0828_dev *dev)
+{
+	int ret;
+
+	__media_pipeline_stop(dev->active_link_owner->pads);
+	pr_debug("Pipeline stop for %s\n", dev->active_link_owner->name);
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
 /* Callers should hold graph_mutex */
 static void au0828_disable_source(struct media_entity *entity)
 {
@@ -537,20 +575,7 @@ static void au0828_disable_source(struct media_entity *entity)
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
+		au0828_release_active_link(dev);
 	}
 }
 #endif
-- 
2.34.1

