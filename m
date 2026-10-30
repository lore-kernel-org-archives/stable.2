Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793326394;
	b=3Oxxb57Vq7NaiJdk95/t0w5V1bimwEvvM3439DIpuPf/Szel/x1fIsw0RSXnHwkq63L+
	 VLM5WJ2k9W6CNka8bQG3aHFbtIB10c8s8YqK2XS9duzAL1sgJyeYFnsvUDLWeahzI1cCx
	 gPZiuHUlc2hcI+dGX4jAthTNELISWK2z+HtbYdO48apyu2NgR1GaeaQ5cxoepKj+5AlFu
	 /46ULFHF5WTPoW9RdmLeFHrzTNC35gg3CD7IlEIgppPU/dTUYa6DUr53QTUdOXcw7WKvx
	 xBtwtJ7utzU3+nSFJhakqukCBCGu2BkxfmU7rLyqoWJUOpd7Y5JE/fiAbptXF2lRxjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793326394;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=s9TN99h06h+xjvhYPwVB3Gbjq5FR8jNNhPs9dg8k7jA=;
	b=OYZXrkNiZXt2QlUDPJPmMLQku5jJbdvlIK2FU+Y++5qIyLRF9AxwUq0dthFLwp9JINYI
	 Tc/Y2Gp1oQUBaDab/9fqkoylMsyzvWEXKzjVIaT2X3/245fLf7Ry+OJ9gmcdR19ydhKeU
	 7/WoJIdwQ3WvNNq6+R/ANCoQUKkjHCfcUxyT9Vaorhzy7zARWpAcqB90UYPkIrxj/o38c
	 GRKImqOoGyPPker/xESTAMWgMa9MnV1S+TJlE9AGl8MYReJ0NMOolR97wsqEhhnKZIHpl
	 7OlNhAhA1QwKgLKwI06DSyYN8WcDprD8dLvVWy7j9BPmuxx0dUwQSUmxWCX1k6JFGBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACE606A31A;
	Fri, 30 Oct 2026 02:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FACE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=s9TN99h06h
	+xjvhYPwVB3Gbjq5FR8jNNhPs9dg8k7jA=; b=rz8XzhfXL8g+VrQiWr7OE3/xrn
	1a0fhwccJ0ErfHYoG0U+c7suy8+X2WWlxQsqHde4WcXnSLkQSkKHS0BBDUPkBtCL
	l107zRlJ4bvrDkMUC9elASAkB/D+V2O0KCXMfYMEr8Ox5ihQqPCK9J8E3TkZSoOr
	4Iy5SnHZLETGZliPQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.123])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGif4f_eNq05gFAQ--.28179S2;
	Fri, 30 Oct 2026 10:12:48 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] wifi: mt76: usb: re-enable the rx worker when resuming fails
Date: Fri, 30 Oct 2026 10:12:47 +0800
Message-Id: <20261030021247.8032-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBGif4f_eNq05gFAQ--.28179S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF15KrW7AF4UZr1fZw45trb_yoW5GrW5pF
	WYk3yjyryDGF4DGw48A3WjyFWfAan3Gr17GryrW34ru34rAr1rA34Iga4jvryYyFWvka47
	JF4qyry3GrZYvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBKb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r
	4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
	AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU83Ef5UUUUU=
	=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUBD2rjYVQKMAACsO

mt76u_resume_rx() returns as soon as submitting the RX buffers fails, so
the mt76_worker_enable() at the end of the function is never reached and
the RX worker stays parked.  The mt792x USB reset path relies on
mt76u_stop_rx() and mt76u_resume_rx() being a balanced park/unpark pair:
if firmware download fails, mt7925_init_hardware() retries up to ten
times and calls mt792xu_init_reset() again, which parks the already
parked RX worker.  kthread_park() then hits its WARN_ON_ONCE() and
returns -EBUSY:

  WARNING: kernel/kthread.c:710 at kthread_park+0x17b/0x1b0
  Workqueue: events mt7925_init_work
  Call Trace:
   mt76_worker_disable     drivers/net/wireless/mediatek/mt76/util.h:93 [inline]
   mt76u_stop_rx+0x5b/0x2f0 drivers/net/wireless/mediatek/mt76/usb.c:757
   mt792xu_init_reset+0x52/0x80 drivers/net/wireless/mediatek/mt76/mt792x_usb.c:477
   mt7925_init_hardware     drivers/net/wireless/mediatek/mt76/mt7925/init.c:152 [inline]
   mt7925_init_work+0x49b/0x7e0 drivers/net/wireless/mediatek/mt76/mt7925/init.c:196

A stalled RX endpoint makes usb_submit_urb() return -EPIPE, which is the
failure that leaves the MCU unresponsive and triggers the retry loop.
Skip the remaining queues but always re-enable the worker, and still
return the error to the caller.

Fixes: 0d2afe09fad5 ("mt76: mt7921: add mt7921u driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/usb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a9af3aa6b80a..1c9bf3679774 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -775,23 +775,23 @@ EXPORT_SYMBOL_GPL(mt76u_stop_rx);
 
 int mt76u_resume_rx(struct mt76_dev *dev)
 {
-	int i;
+	int i, err = 0;
 
 	mt76_for_each_q_rx(dev, i) {
 		struct mt76_queue *q = &dev->q_rx[i];
-		int err, j;
+		int j;
 
 		for (j = 0; j < q->ndesc; j++)
 			usb_unpoison_urb(q->entry[j].urb);
 
 		err = mt76u_submit_rx_buffers(dev, i);
 		if (err < 0)
-			return err;
+			break;
 	}
 
 	mt76_worker_enable(&dev->usb.rx_worker);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-- 
2.34.1

