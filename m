Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492375;
	b=tshubxdZTFujEpq9wsIYlHIkZSGCb46p9XP9gp9M5DfkQ78LHNHu1QWhUrQgguGGmtlO
	 M80gQPecKuCE8JfeSJh+NxHdsdtsM9kZjFCvIgFqtTMs4miY5JQQhGvD8Q42PkXVxGET+
	 js2Byl+PuAUoQhLNDMkIfYgKGp+Z/dgK0dldrWmq9oJjOPobnnsYXsQTVCHyl2jdhfyMx
	 5HnpC1BJNmI/fD98tHKJn2FwtlkmE1htNBAWKhbB6CWgYl+Cc/MnVFq/ipHvJzWATQjGM
	 OQEoR1yHBnNomaTV0xD5neZufYnTiGGg5GA2m9TtGz7ralot4bVmDgr8eW1nNkQ8sWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492375;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ODbPJMdntmTvoi3vjeeM22n7i5ZX+wtJIejtzH1ClhU=;
	b=Pj22TzTMGJi/QUt4maaSSUqXqKL1BqL9mx1Mp2rInlNkX1A4KP7w3Udb/3Crb10lC7rk
	 yJyAUCv6Hk/iILVZbXvYek+uspM6Hs/xbbER2xCPdLCKQ/q2KflQoXcfg4wGUobSPqy2a
	 l0cLlJDJIz4EltQ6zkTOPu+rN85yeODb6kpl2cc0j8sG0ftrcvsWHfCqvToehOdmOuF2n
	 oqUw+DG+rPE0zN7UvQMEPR1uX+9SYASCUWpCbs/0H3mLTIRLH+vF/zKmmCZx/SDS/7zky
	 xgVZAPpXpopt2y5D+9Mh2Ck/yLp8MTyi+ecspxdZnbDjic6ynhtDGYPWIhh9RTObNBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A6606C721;
	Thu, 12 Nov 2026 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 471A6606C721
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ODbPJMdntm
	Tvoi3vjeeM22n7i5ZX+wtJIejtzH1ClhU=; b=7UtzpQI3kBVk0BzOG37XBrqKQP
	DaAzoCJ1qcEAvazm3R1cj0hxy22BTc6xR04uosF13M4DbpWFZm8U9DPXxQCMiYov
	DV8LB7NeK84ZEDXKcnSfScZew9WPTGl1+xeR+g0huherB+ob2uKk11AhJQYH39/i
	kwqP9pysmKMXhqyp0=
Received: from user-virtual-machine.localdomain (unknown [223.160.172.137])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWHALFx_VqogKHAQ--.34687S2;
	Thu, 12 Nov 2026 22:05:59 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] media: go7007: return queued buffers on start_streaming() failure
Date: Thu, 12 Nov 2026 22:05:56 +0800
Message-Id: <20261112140556.5230-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDWHALFx_VqogKHAQ--.34687S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rAFWxGFykXF4ftFW3Awb_yoW5WF17pF
	yF9ayayrWDtr18ua17Gw1ag3W5C3Z7A34UCayrWws5ZrsxJFW5u3y0qayqgr1DCa47Zr1j
	yr98CFW3Ca1jvr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Sb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCFx2IqxV
	CFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r10
	6r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxV
	WUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG
	6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07jO189UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUPD2r0h0bq5wAAsV

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
back to vb2 with VB2_BUF_STATE_QUEUED before bailing out.

Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
- Inline the buffer return into go7007_start_streaming() as requested and
  drop the separate helper.
- Drop the redundant go->active_buf = NULL: active_buf is still NULL when
  go7007_start_encoder() fails.

 drivers/media/usb/go7007/go7007-v4l2.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
index 2087ffcb85a5..030a127cb9ea 100644
--- a/drivers/media/usb/go7007/go7007-v4l2.c
+++ b/drivers/media/usb/go7007/go7007-v4l2.c
@@ -409,8 +409,26 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
 	else
 		ret = 0;
 	mutex_unlock(&go->hw_lock);
-	if (ret)
+	if (ret) {
+		struct go7007_buffer *vb, *tmp;
+		unsigned long flags;
+		LIST_HEAD(buffers);
+
+		/*
+		 * The queued buffers were handed over to the driver before
+		 * start_streaming() was called, so they have to be returned
+		 * with VB2_BUF_STATE_QUEUED.
+		 */
+		spin_lock_irqsave(&go->spinlock, flags);
+		list_splice_init(&go->vidq_active, &buffers);
+		spin_unlock_irqrestore(&go->spinlock, flags);
+
+		list_for_each_entry_safe(vb, tmp, &buffers, list) {
+			list_del(&vb->list);
+			vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+		}
 		return ret;
+	}
 	call_all(&go->v4l2_dev, video, s_stream, 1);
 	v4l2_ctrl_grab(go->mpeg_video_gop_size, true);
 	v4l2_ctrl_grab(go->mpeg_video_gop_closure, true);
-- 
2.34.1

