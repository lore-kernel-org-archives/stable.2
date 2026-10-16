Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881C4442372;
	Fri, 16 Oct 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146158; cv=none; b=SdiylXEF2Q59ThsRDFW9xhxgheSjsckF/KTxh69dCZZ0n/xrHjk0n9upogiMa5Rc1UF17ImtmYG2RIXlr5SSEKZAKuw2caKb8Cg0jxmx3niuzWZ8mwsxpnE5BziC8Pl2bosg3rhoWxXgrfu1zeRZ+NP9Jw75awWojkqQrHRf2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146158; c=relaxed/simple;
	bh=MW5IvNBYwiHBeYNR4r2nz/EeyoR93OeQnRKavzXx0FA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DT91kkZheKpPgVOGC0jMXQkMmtxHWXf3tNQLY9X6h6G4vrRMoBlyN1CvWSmHZmh+Dulz9P4cimNq8n+RWOv5AYXR4Lj4FU4T6l0zITrQw+1EP4r3OAT6K7RhMzK6k9icddfRo4KG5+oY2gDSZ8LmH6RDKqFZ/poXIdgCLY68r0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=KEWrpJW9 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="KEWrpJW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=/lK1aOrmSM
	sK6G3QvQQvpEM4E0EN5PTXRgpLljzp2xQ=; b=KEWrpJW9Z5NsxnagTaTmEJRXaC
	KvcBfCwrTQOx8eh51wpiu0PF+6mp6lYv4f6sJiTHF5g7bU8twREzxC0aJHb0c0in
	0hZu8ZXZLR+niUT4fNffhbU3lKuI+XFsKViGsvT+E8tLKhu+Yrxn08xJjLSIb5jD
	GDYXKH5xJmiCz+dxY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.90])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2vP_X+tFqXf+pAA--.50685S2;
	Fri, 16 Oct 2026 18:22:16 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH] media: go7007: return queued buffers on start_streaming() failure
Date: Fri, 16 Oct 2026 18:22:13 +0800
Message-Id: <20261016102213.42771-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkC2vP_X+tFqXf+pAA--.50685S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rAFWxGFykXF4ftFW3Awb_yoW5ZFWfpF
	yY9ayayrZ8tF48ua13Gw1ag3WYkas7A347CayfWwn5Arn8JF98u3y0q3yqgr1DC3yxZF1j
	yrZ8CFW3CF4jyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9K14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Gw1l42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYxhLUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rQ7FG19QAAsE

The vb2 framework hands ownership of every queued buffer to the driver
through the buf_queue() callback before start_streaming() is called.  If
start_streaming() then returns an error, the driver must return those
buffers to vb2 with vb2_buffer_done() and VB2_BUF_STATE_QUEUED.
Otherwise vb2_start_streaming() fires WARN_ON(owned_by_drv_count) and
forcibly reclaims the buffers.

go7007_start_streaming() returns -EIO when go7007_start_encoder() fails,
which happens for example when a USB transfer cannot be submitted because
the device has been disconnected:

    go7007 1-1:1.0: error submitting audio urb 5: -2
    go7007 1-1:1.0: error starting stream transfer
    WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1797 at vb2_start_streaming

but it leaves the already queued buffers on go->vidq_active.  Give them
back to vb2 with VB2_BUF_STATE_QUEUED before bailing out, clearing
go->active_buf as well.

Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/go7007/go7007-v4l2.c | 29 +++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
index 2087ffcb85a5..e0b646e8dad1 100644
--- a/drivers/media/usb/go7007/go7007-v4l2.c
+++ b/drivers/media/usb/go7007/go7007-v4l2.c
@@ -394,6 +394,31 @@ static void go7007_buf_finish(struct vb2_buffer *vb)
 	vbuf->field = V4L2_FIELD_NONE;
 }
 
+/*
+ * Return all buffers that have been queued to the driver back to vb2.
+ *
+ * The vb2 framework hands ownership of every queued buffer to the driver
+ * before calling start_streaming().  If start_streaming() fails, those
+ * buffers must be returned with VB2_BUF_STATE_QUEUED, otherwise
+ * vb2_start_streaming() triggers WARN_ON(owned_by_drv_count).
+ */
+static void go7007_return_queued_buffers(struct go7007 *go)
+{
+	struct go7007_buffer *vb, *tmp;
+	unsigned long flags;
+	LIST_HEAD(buffers);
+
+	spin_lock_irqsave(&go->spinlock, flags);
+	list_splice_init(&go->vidq_active, &buffers);
+	go->active_buf = NULL;
+	spin_unlock_irqrestore(&go->spinlock, flags);
+
+	list_for_each_entry_safe(vb, tmp, &buffers, list) {
+		list_del(&vb->list);
+		vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+	}
+}
+
 static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
 {
 	struct go7007 *go = vb2_get_drv_priv(q);
@@ -409,8 +434,10 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
 	else
 		ret = 0;
 	mutex_unlock(&go->hw_lock);
-	if (ret)
+	if (ret) {
+		go7007_return_queued_buffers(go);
 		return ret;
+	}
 	call_all(&go->v4l2_dev, video, s_stream, 1);
 	v4l2_ctrl_grab(go->mpeg_video_gop_size, true);
 	v4l2_ctrl_grab(go->mpeg_video_gop_closure, true);
-- 
2.34.1

