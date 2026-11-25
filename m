Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598297;
	b=Ks26Pjv3l2Voc4+8CXQX/5qg2nBeGyWbpIp+mG0sY9ox1LC+SjmPCdjR3jcD/U+czAgX
	 R4NgA4XXi7qS56uBWP6QKc4kLb1IpPk65WaIExkbD8EcADO9A7wCEdLotgnFwKdHqOzpP
	 j8VNfoIMSB+OgGeaqasA3O/VH2F4+m5e0jjMpDOiGT7c8xVZ7fn/vUfsHFjx9wcrs+xP4
	 hB1h3QYAT3Wci/FlEnGS6RAcXs58nHi93OnohSqEtmCSvZcJlyAoZvk7cuQCcWn/fHcZp
	 0B/ub2D7xjl7ZJqvX2XeWNB57p1SgC5IbdQaNAPiK61HrGWWxrTWIdcFdIRSmMi3Q4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598297;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=k1W9OmdCC0DgTyjGeBPm2sl1bkiKos1oNbZwzoUDpAM=;
	b=audlTHp2aN1zFO+iyo05U4CILTyDNd/emtYrJJ6GEKH2UcbG7bbQgbkGhaXpGpm2KofI
	 aRzh9ZAMGEnFLnhRTZ3h/JXKBMua7AjTc/9Iq6HodIWbSspcAdjTbZIqf7RbhppqF5k0I
	 NnvDMZy9kVfKw5uA/HF6aYafmRLvds3GYS7U6DTQdElxt0BivT5hhOQcsyj7ltfv7bjeG
	 vauo8XMb/shhe8sZTi4bfbAQZCkJdaJY1lxE4rQVx1zuu2PwRJH3sRd8QrqE1AggkoXm9
	 ge6sPAM+NscUw0FUuGgPzxUlk4LIBNfOdPXfV7Y7kKmZi2CwIeYeALqY4br3eH5uq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC0C606A33E;
	Wed, 25 Nov 2026 09:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EC0C606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=k1W9OmdCC0
	DgTyjGeBPm2sl1bkiKos1oNbZwzoUDpAM=; b=lQJKG9fjOCloiBxDBBSZlBSr6U
	+yL0HiNGXnI5ihSaDxrVNIUQaBes/T/CoshTcgK7SS4iNIM8PlgS6PCelxQzt/Oo
	0djgrFg8zLDknPEmGG/ufVQI8f4WC+sAZq2IMJb3H5PtQGJ8ibdPb2VIYDfyKBqd
	HFiXeiW0RZ5sYE+aQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gO0pwZrgwE0Ag--.13180S4;
	Wed, 25 Nov 2026 17:18:05 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3 2/2] media: go7007: return pending buffers on stop_streaming()
Date: Wed, 25 Nov 2026 17:17:39 +0800
Message-Id: <20261125091739.5866-3-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkC2_gO0pwZrgwE0Ag--.13180S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF48ZrW5Zr47Ww4DAF1UKFg_yoW8tF1rpF
	WFvFyakrW5tF4UCa1UGw12ga45C3Z7Z3y7CayFkw4rZF15JFWUua409ayjgr4Utw4xZ3WI
	yryDAFW7Ca15Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0E
	x4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
	0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUIBHqUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2sFqFm40gAAs2

The vb2 framework hands buffers to the driver through buf_queue() and
expects stop_streaming() to give the buffers that are still owned by the
driver back with VB2_BUF_STATE_DONE or VB2_BUF_STATE_ERROR.

go7007_stop_streaming() instead just re-initializes go->vidq_active,
dropping any pending buffers without returning them to vb2.  That leaves
owned_by_drv_count elevated and makes __vb2_queue_cancel() report a
driver bug when the queue is cancelled.

Return every pending buffer with VB2_BUF_STATE_ERROR and clear
go->active_buf, which may still point into the list.

Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/go7007/go7007-v4l2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
index 0b32cb58142b..6ab067d56b7c 100644
--- a/drivers/media/usb/go7007/go7007-v4l2.c
+++ b/drivers/media/usb/go7007/go7007-v4l2.c
@@ -440,6 +440,7 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
 static void go7007_stop_streaming(struct vb2_queue *q)
 {
 	struct go7007 *go = vb2_get_drv_priv(q);
+	struct go7007_buffer *vb, *tmp;
 	unsigned long flags;
 
 	go7007_stream_stop(go);
@@ -449,7 +450,11 @@ static void go7007_stop_streaming(struct vb2_queue *q)
 	call_all(&go->v4l2_dev, video, s_stream, 0);
 
 	spin_lock_irqsave(&go->spinlock, flags);
-	INIT_LIST_HEAD(&go->vidq_active);
+	list_for_each_entry_safe(vb, tmp, &go->vidq_active, list) {
+		list_del(&vb->list);
+		vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+	}
+	go->active_buf = NULL;
 	spin_unlock_irqrestore(&go->spinlock, flags);
 	v4l2_ctrl_grab(go->mpeg_video_gop_size, false);
 	v4l2_ctrl_grab(go->mpeg_video_gop_closure, false);
-- 
2.34.1

