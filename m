Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598289;
	b=2H2L7zWnSprs7IdDwuQGIKDomKWSX8FdMxIFu8FzrB+XAjwIrj/T79dIuh9Krv9zCZwl
	 72+33FtqPtIWRq55vGefXVf4MNp00gv/MsZcbKQ1AACttwFWvSO6uclw2CMSQbknSAKvX
	 L+B7WnygJU5Mlz89+cCNBQNFIoXm4hoJkPN6c6wKM/+LlC3jKl2cdyYuekupFwSZZO30K
	 Ck4zWtzrzSxHQG9heH+QneG/lpiujxMI84HVMmMJMeNofsFxB/AYRIrMgCGQoYTJTukal
	 0umR1L5EA7Op133GlWd5B4DJWx5s3IIIKWGRCG3iU0QuqnueG2LPUR8bqDCjpI9U01w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598289;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=huflbJ1cgWLwqtARw8n3+33IaRue5jo2Oaf8/KKbjC4=;
	b=gwe0obHipqnuRceOL/G0OdTyN5q2MJIPkjjIZqVbCEMdZ9obV6K/MwgtI1qkrW71O9a/
	 ky9i6OQCeF0H3qMV7vAPIGTQptQs9Po1AbS9glkOtX5TwpTiUR8BEH0SVALcc9WsPyIwC
	 9NdI5BQn5oroKydCWTSYj/DWhfvU1ONs5TVqApaFiLssTpf+R4j+R4hrnN3hXc4mMNN+o
	 eiPeZ4rY+fWsE5AfawSifgROtLASUg/CSdTOw2NIqN9fYvlSkX6s7AO0jje7i+66wiBnP
	 7VulD84k+hjXtlMy5BQ/C6xrZKVQejVjR9hOCz9iCiq3JvtjoiD/TTcOrnU9p3Sr4ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3BE606A684;
	Wed, 25 Nov 2026 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB3BE606A684
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=huflbJ1cgW
	LwqtARw8n3+33IaRue5jo2Oaf8/KKbjC4=; b=wIP/c41pBeCDbQWacMspd0eetK
	2Qu1YUryGbwRy9hvfD+TwxzVGDPDAP8I0E5GiQu5oPEDXAcuNW+rjYajoH8kbhYt
	4nuIRfDILjWxPg5N9py/R4lqqZ1jA1vk3FaDQHJ+bbMEropxTB4mI1tiUhIze1B/
	56OCGjHiLjThd2//0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.108])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gO0pwZrgwE0Ag--.13180S3;
	Wed, 25 Nov 2026 17:17:53 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3 1/2] media: go7007: return queued buffers on start_streaming() failure
Date: Wed, 25 Nov 2026 17:17:38 +0800
Message-Id: <20261125091739.5866-2-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkC2_gO0pwZrgwE0Ag--.13180S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4rAFWxGFykXF4ftFW3Awb_yoW5Jw4rpF
	yFvFWayrWDtF4Uua13Gw1ag3W5C3Z7A347CayrWwn5Zrn8JFZ8urW0qayDKr1qka47Zr17
	AryUCFW3Ca1jyr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
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
	CTnIWIevJa73UjIFyTuYvjxU4HGQUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUID2sFqsq2zgABs3

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

but it leaves the already queued buffers on go->vidq_active.  Return them
to vb2 with VB2_BUF_STATE_QUEUED before bailing out.

Fixes: 7955f03d18d1 ("[media] go7007: move out of staging into drivers/media/usb.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/go7007/go7007-v4l2.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/go7007/go7007-v4l2.c b/drivers/media/usb/go7007/go7007-v4l2.c
index 2087ffcb85a5..0b32cb58142b 100644
--- a/drivers/media/usb/go7007/go7007-v4l2.c
+++ b/drivers/media/usb/go7007/go7007-v4l2.c
@@ -409,8 +409,23 @@ static int go7007_start_streaming(struct vb2_queue *q, unsigned int count)
 	else
 		ret = 0;
 	mutex_unlock(&go->hw_lock);
-	if (ret)
+	if (ret) {
+		struct go7007_buffer *vb, *tmp;
+		unsigned long flags;
+
+		/*
+		 * The queued buffers were handed over to the driver before
+		 * start_streaming() was called, so they have to be returned
+		 * with VB2_BUF_STATE_QUEUED.
+		 */
+		spin_lock_irqsave(&go->spinlock, flags);
+		list_for_each_entry_safe(vb, tmp, &go->vidq_active, list) {
+			list_del(&vb->list);
+			vb2_buffer_done(&vb->vb.vb2_buf, VB2_BUF_STATE_QUEUED);
+		}
+		spin_unlock_irqrestore(&go->spinlock, flags);
 		return ret;
+	}
 	call_all(&go->v4l2_dev, video, s_stream, 1);
 	v4l2_ctrl_grab(go->mpeg_video_gop_size, true);
 	v4l2_ctrl_grab(go->mpeg_video_gop_closure, true);
-- 
2.34.1

