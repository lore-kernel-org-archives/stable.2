Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277805;
	b=oCShDGw+R/E5an9Nxn59Tbd9v12Ja+O1bDIu9ixxlRsvtk7Wfz3jvNCTpl1mUG2sKlvs
	 BXHIBQ0JFCF3NCP6axCnAYOSX2SbwpjYoDHJ/yzS+oHt+2u1bLjEKWZRNAxjB81rhEhcX
	 zAH8e94wAHRxNizOog9lAkp+A4yVYB0maqT8PbWLppsQtY5tKZBjqJmQD2wMPafp93bFY
	 LwgAGecHHaURlbtntF5Zaf0IclktbM69jSPk917m+lr2bg+iWryY2ipKJ8HzA91e4E9gP
	 5FY3+qgKV96K6/1L71eBFoijcelHo7qh+zDTLMN+DJ4aQyxf55WheN/jOAnQRtzkBJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277805;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZElA5s/21HS1XF60gGGTbmjKeurE3z0LWPC8MyE6+Ew=;
	b=AZ2mxHxez1R50/IIHT+7U17CNWs/KziBnzmCJglha86opAAzghaZhRAFYLRJH9QR4ptT
	 +NwIsT+Zf2Cis5TRWzyHkcEoByPlo5QhGEDquEHixWL8ojl2xP+SDf0kRtF81FQfmDMSL
	 pi8VoDpJfp0EkP5TolvbWfGNa0Idb6dXUgYqBt0+ZoTs/IAWK0b79rEJBLhwg5gvgcZ+V
	 lBubLNjD4klWyO9F7QrzoTyCBFc2mNz4QzDOzd+Bk8hl4QdXb7WVcg2eWTLqQZCRKi7jb
	 0UrDvm/KKqwN1cCX9CKqi65XGYKqDEuj0ElYrF9ubdUcEh2C5e5tAMLrdW+JvJQSaBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEFC606A32A;
	Sat, 21 Nov 2026 16:16:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBEFC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=ZElA5s/21H
	S1XF60gGGTbmjKeurE3z0LWPC8MyE6+Ew=; b=Mftu4QvyDpsxjqimkG9O9vc82z
	Br6ovLe8d6kfAWzddNo928RzckxX61MEyvdnCmQ/R+OEginAj21OAXRzoknIuwCL
	N9Xk4KmkseSdwtJRFmUWzmIrSlUo2O2UmICiblIfOOF8Tru/Pt1BVxSpoosPNETP
	ry3Cpyeg/HDYti0Rc=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDm6fzfwwFrIHEEAg--.57256S2;
	Sun, 22 Nov 2026 00:16:32 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Arien Judge <arien.judge@morsemicro.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] wifi: mm81x: kill the bulk URB when the wait is interrupted
Date: Sun, 22 Nov 2026 00:16:31 +0800
Message-Id: <20261121161631.2552-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDm6fzfwwFrIHEEAg--.57256S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw47tFWrtw17KFWxuFy8Krg_yoW5JF1xpF
	48u34jkrZ8tr1qkw4kGwsF9r18Aa12qa9rCFs5Kwn5Crn8twn3CFy0gFWYgF1vkw1kZa42
	vr4YqFyUWr9xCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Fb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcS
	sGvfC2KfnxnUUI43ZEXa7IU0qjg7UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2sAYljOOwADso

The driver waits for each bulk transfer with
wait_event_interruptible_timeout() so that a signal can abort the wait.
Only the timeout path kills the URB; when the wait returns -ERESTARTSYS
the function returns with the URB still submitted.

The URB then stays in flight on the endpoint and the next transfer on the
same endpoint calls usb_submit_urb() on it again. The USB core rejects
this with the "URB submitted while active" warning and -EBUSY, so every
later register or memory access fails and the driver gives up on the
device. The late completion can also clear the shared busy flag and wake
a subsequent transfer, which then reads a stale buffer.

Kill the URB on the interrupted path as well, so that a transfer is
never left active once these helpers return.

Fixes: b1906cea00b0 ("wifi: mm81x: add mm81x Wi-Fi HaLow driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/morsemicro/mm81x/usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/morsemicro/mm81x/usb.c b/drivers/net/wireless/morsemicro/mm81x/usb.c
index ec94936b157b..3b3ffd94e4d6 100644
--- a/drivers/net/wireless/morsemicro/mm81x/usb.c
+++ b/drivers/net/wireless/morsemicro/mm81x/usb.c
@@ -257,6 +257,7 @@ static int mm81x_usb_cmd(struct mm81x_usb *musb,
 		msecs_to_jiffies(URB_TIMEOUT_MS));
 	if (retval < 0) {
 		dev_err(mors->dev, "error waiting for urb %d", retval);
+		usb_kill_urb(ep->urb);
 		goto error;
 	} else if (retval == 0) {
 		dev_err(mors->dev, "timed out waiting for urb");
@@ -366,6 +367,7 @@ static int mm81x_usb_mem_read(struct mm81x_usb *musb, u32 address, u8 *data,
 		msecs_to_jiffies(URB_TIMEOUT_MS));
 	if (ret < 0) {
 		dev_err(mors->dev, "wait_event_interruptible: error %d", ret);
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_RD].urb);
 		goto error;
 	} else if (ret == 0) {
 		/* Timed out. */
@@ -436,6 +438,7 @@ static int mm81x_usb_mem_write(struct mm81x_usb *musb, u32 address, u8 *data,
 		msecs_to_jiffies(URB_TIMEOUT_MS));
 	if (ret < 0) {
 		dev_err(mors->dev, "error %d", ret);
+		usb_kill_urb(musb->endpoints[MM81X_EP_MEM_WR].urb);
 		goto error;
 	} else if (ret == 0) {
 		/* Timed out. */
-- 
2.34.1

