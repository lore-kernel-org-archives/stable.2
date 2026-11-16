Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794797051;
	b=ozqvEPmZZygC/zZwGwTlNDElsKSBzKq+CaSCkn1kW5Be2+Zz9U0yGnFnv1La6ZENoE6H
	 4Psnz65NCu7Wct2gWmSoY6s81lW4s1EW7UsIxgGZl2FPGuwl4coeDYSZuX8AbY4Cc1TGU
	 otRWTkPbf/q+irQ/7HgRGMBZW80s81kVpSyRT43vYJAmzqISMgXpyKHESUBtz2n9FXtJc
	 A5DObLSpfgzj3hZLINg4aIAytFTVdO3Qi0KUVNCJftOutoM2yGGQ0QiVAQxeblxvpzXRa
	 R2rm4gbHHuzp/CgK3HP/or1EUW475M80MjUZRB6drzfu903UmqalB/gJZ3RSN1/1WFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797051;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=QA54ZmiCg4eSRO8G55NzOCBf0UqL63kojA2ZQ4QzxvQ=;
	b=Z8t6aokwiV+Oa4RTQYuzlZJwHR+LFcpdLwF7eNgvJsb6wlZbCbCmto7FywtnaXf484gW
	 mTwpCt0tpUbjste90DLO2DHliQI5Zd7awZhpjR9eMI+oeriWG8O7oyKq3IIpzQpE6+ejV
	 nlyMcZmwQQfaDs1M9ArFavW//mQRl58AcmwVLyJpH2G35zF+PLqvWPzoh/qrqyQy1t2S3
	 0xORBQhYxMfLmigy6XvC0knPAB23m5MEk6+9bFWjbqCscOR/xWHw9et33ZQo4U5hBAm2t
	 l8ih78TQYONrZ2AgA1STJEHCSgkmXpchrTlpXEIdyvF2pa6TYysvEM03c5YVEYmUTEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBDF606A31F;
	Mon, 16 Nov 2026 02:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBDF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=QA54ZmiCg4
	eSRO8G55NzOCBf0UqL63kojA2ZQ4QzxvQ=; b=WbzKWahzjRp0XXQPG+rFJxiLIo
	BnCnuoKmywrt6gcAeUKxMX74M+KAobmSFivCR8XgoW/DsUhCB3ZJmrHeSHDkXPD4
	6L+vzDBwjG7NzMjdtVQvE+/rd0M2tY9yHLDxrquq55ubSWjlON7fAQRT0nNATHZ5
	KZUIe5D0q8P7SpsVY=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2OP7sbfpqHHeyAQ--.1603S2;
	Mon, 16 Nov 2026 10:43:57 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: dvb-core: initialize DVR ring buffer before registering the device
Date: Mon, 16 Nov 2026 10:43:55 +0800
Message-Id: <20261116024355.17602-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkD2OP7sbfpqHHeyAQ--.1603S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw1DXw4rAF4Dur1rXF4fZrb_yoW5Xw1rp3
	95Kay5trW2grs7Cr47u348uas0yws3ArWSkF1fJwn3urnrGF4qqFZ0yF47XFnrGrZ2y347
	Kas8Way8CrWUJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUc038UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytdqdQAAsJ

dvb_dmxdev_init() calls dvb_ringbuffer_init() on dmxdev->dvr_buffer
only after dvb_register_device() has registered the DVR device. The
device node becomes usable as soon as device_create() runs inside
dvb_register_device(), so a reader that opens
/dev/dvb/adapterN/dvr0 right after it appears and blocks in read()
can reach wait_event_interruptible() while dvr_buffer.queue is still
zeroed.

The waiter is then queued on a wait queue whose list head is still
all zero. __add_wait_queue() derives (void *)-24 from
head->next == NULL and faults while reading wq->flags:

  BUG: unable to handle page fault for address: ffffffffffffffe8
  RIP: 0010:__add_wait_queue include/linux/wait.h:177 [inline]
  RIP: 0010:prepare_to_wait_event+0x2ef/0x520 kernel/sched/wait.c:316
  Call Trace:
   dvb_dmxdev_buffer_read drivers/media/dvb-core/dmxdev.c:76
   dvb_dvr_read drivers/media/dvb-core/dmxdev.c:277

Commit bfbc0b5b32a8 ("media: dvb-core: fix wrong reinitialization of
ringbuffer on reopen") replaced the dvb_ringbuffer_init() call in
dvb_dvr_open() with dvb_ringbuffer_reset(), so the open path no
longer initializes the queue and dvb_dmxdev_init() is the only place
doing it. Initialize the ring buffer before the device is registered.

Fixes: bfbc0b5b32a8 ("media: dvb-core: fix wrong reinitialization of ringbuffer on reopen")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/dvb-core/dmxdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/dvb-core/dmxdev.c b/drivers/media/dvb-core/dmxdev.c
index 6a825d9bae43..8ef31066ec8d 100644
--- a/drivers/media/dvb-core/dmxdev.c
+++ b/drivers/media/dvb-core/dmxdev.c
@@ -1431,6 +1431,12 @@ int dvb_dmxdev_init(struct dmxdev *dmxdev, struct dvb_adapter *dvb_adapter)
 					    DMXDEV_STATE_FREE);
 	}
 
+	/*
+	 * The DVR device node is usable as soon as dvb_register_device()
+	 * creates it, so its ring buffer must be initialized first.
+	 */
+	dvb_ringbuffer_init(&dmxdev->dvr_buffer, NULL, 8192);
+
 	ret = dvb_register_device(dvb_adapter, &dmxdev->dvbdev, &dvbdev_demux, dmxdev,
 			    DVB_DEVICE_DEMUX, dmxdev->filternum);
 	if (ret < 0)
@@ -1441,8 +1447,6 @@ int dvb_dmxdev_init(struct dmxdev *dmxdev, struct dvb_adapter *dvb_adapter)
 	if (ret < 0)
 		goto err_register_dvr_dvbdev;
 
-	dvb_ringbuffer_init(&dmxdev->dvr_buffer, NULL, 8192);
-
 	return 0;
 
 err_register_dvr_dvbdev:
-- 
2.34.1

