Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866343563E1;
	Fri, 16 Oct 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159311; cv=none; b=D/AzTc6UyyqHOAa3I89OVTFQBr/VrqM7xXzi55HTYdHHdQfEZjq9704SqEHTN3mmsVblL4nB3tDEdiiOJOB6G6ypAmSoCf0SftA8ubeR7rr9upZOfHLgNmo+o2W5JXiIIBCz4S3xwfsG7PXs26QbTYP4/6afcQHsB1razO7POT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159311; c=relaxed/simple;
	bh=BRLhYJq+FprxXKwR/7RZHZibWLPJXaCDdw64bUPUOX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+QsN1TAzkHTncEfB2JjZ83rK+ew0lzx8Ae1E7X5SN8teGWV6NON9TdvMcFiNh4NQhg0jXWw0EyXRGfiLkVD57JHXRMLTzPetw7r7/L2MgW4a95uXjBQyNXfm3cUy0LJk+ozjldowoxhL+0EBf6tBMsMW+xUk2C+nPPFpj5pG2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=Pwy7vHAF reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="Pwy7vHAF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=5y99YE6n0O
	W+1DNoYGe8C7yFHqiHZPPcb4G9giKUy7U=; b=Pwy7vHAFyrLogh80Ly6BNCcW3c
	gf1PcKy5aiBcp2+v6oWXInjsGOA+bLhmQi33nHS6MEai8vIxu2E0xre0WfQdJfKg
	C6FvRuR5dOBxKT9p0m4w3sx7WsXDUM7tLF1hxtwP9RVtJq08B9K06JV7IYniuEWn
	Uw/NerVDaufeiaCQE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.96])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBGSv08LtJqAymrAA--.61730S2;
	Fri, 16 Oct 2026 22:01:34 +0800 (CST)
From: 25031212351@stu.xidian.edu.cn
To: Hans Verkuil <hverkuil@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: YuanZhe Liu <25031212351@stu.xidian.edu.cn>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: gspca: don't complete buffers before streaming has started
Date: Fri, 16 Oct 2026 22:01:31 +0800
Message-Id: <20261016140132.23712-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkBGSv08LtJqAymrAA--.61730S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFWktrWrKw1xKF15Ar4fKrg_yoW5Zw17pF
	93KaySy398Jw4kuF47Ww13Ka4rGan7J34UKrWSgwn5Zws8AF9IvFyFyw48WFy7CrZrZrW8
	tFn8K3s8Ca95taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2vYz4IE4I80cI0F6IAvxc0EwIxC4wAS0I0E0xvY
	zxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxV
	WUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI
	7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU5Czt
	UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rQ7FG19wABsH

From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

gspca enables the data transfers before it knows whether start_streaming()
will succeed: gspca_init_transfer() sets gspca_dev->streaming before the
URBs are submitted, so an URB that has already been submitted can complete
and gspca_frame_add() can hand its buffer to videobuf2 while the remaining
URBs are still being submitted.

When one of those submissions fails, gspca_start_streaming() returns the
buffers that are still queued to vb2 in QUEUED state, but the buffer that
has already been completed is no longer on the driver's queue, and
vb2_buffer_done() cannot take it back (it only accepts active buffers).
vb2_start_streaming() then warns because the driver left a buffer on the
done list although it failed to start:

 ------------[ cut here ]------------
 WARNING: drivers/media/common/videobuf2/videobuf2-core.c:1821 at vb2_start_streaming+0x312/0x680
 ...
 Call Trace:
  <TASK>
  vb2_core_streamon+0x285/0x470
  __vb2_init_fileio+0xdc1/0x1120
  __vb2_perform_fileio+0xa7a/0x15e0
  vb2_fop_read+0x219/0x3e0
  v4l2_read+0x1fc/0x320
  vfs_read+0x1d9/0x980
  ksys_read+0x111/0x210
 ...
 gspca_main: set alt 0 err -19
 gspca_main: usb_submit_urb alt 1 err -2

This was observed on a camera whose USB configuration was changed from
userspace while a read() was starting the stream: the endpoint is removed,
so usb_submit_urb() fails with -ENOENT, and the driver is unbound.

Complete buffers only once streaming has really started, which is what
vb2_is_streaming() reports, so that a failing start_streaming() always
leaves the done list empty. Frames that arrive before that are dropped,
just like frames that arrive when no buffer is queued; this costs at most
one frame at the beginning of a stream.

Fixes: 1f5965c4dfd7 ("media: gspca: convert to vb2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/gspca/gspca.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..ffaf77af9079 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -392,8 +392,15 @@ void gspca_frame_add(struct gspca_dev *gspca_dev,
 	spin_unlock_irqrestore(&gspca_dev->qlock, flags);
 
 	if (packet_type == FIRST_PACKET) {
-		/* if there is no queued buffer, discard the whole frame */
-		if (!buf) {
+		/*
+		 * If there is no queued buffer, discard the whole frame.
+		 * Frames are also discarded while streaming has not been
+		 * started successfully yet: the transfers can already be
+		 * running at that point, but buffers must not be handed to
+		 * vb2 as long as start_streaming() can still fail, since a
+		 * completed buffer cannot be taken back.
+		 */
+		if (!buf || !vb2_is_streaming(&gspca_dev->queue)) {
 			gspca_dev->last_packet_type = DISCARD_PACKET;
 			gspca_dev->sequence++;
 			return;
-- 
2.34.1

