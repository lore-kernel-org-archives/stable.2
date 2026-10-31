Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465493;
	b=QZJoF+1F5w4aSwALLL8Rf9Rb7Ka798YnuJT8YRJ9LDrIrhj9WCOrq81yIbmrZIgI/MWg
	 87DdhZTWqMyuBTLbmstS6npkr12pIkSu+96sqJLMZ8bWTa+VTnZADY9N68UrU8pjAYOAh
	 rNh85zSs92VkhPQyRp0Oegu+PQ8MMnCYOLkHZly+umR1VSULWftlZo6I5s5OOEKJvxrGX
	 pCGC9C1D8yTBIMIKHYyg7oo4i79eBNXjVcE83F6EZfnlttSckKwWCiPOR+fT50uSbtTq1
	 8QIYQ7Zs7tyXPr0vu1NKpFcSfNBT65siuGnEN78ACxujzsDdP6cVJwkMyFV03RH5jgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465493;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=KCQU5UBdUKOKPuYMs15blstZHhzt4p2pk9uyUc66r64=;
	b=zHlFNFSWIHcm53JLyYeNM8pDOeaNOtqE43YrvHajXzF2PhfUCVwtI0o70npysf6pwBse
	 b2hHEwpPvf/9gEksvj9lU0i5Ss618Zqx8kFORq6zJLwxU5zG/P6e4Bd8+5bfM0H0zc713
	 AI+e5gYXQrNeXXVqPiLgGA5yuicygbkvhHvHksJir0OKWBWJK/EM548dLBovZeQlobLVm
	 Iyhz1LgBSSUPC+EfAd0NCNopQ4saWHuVavWzbDOdPNGxDt5t8DLzSoTIPcS8ISCN/Hbir
	 aOHfwq/VpVUK/S4K8hQ5S7aigb7aRX2WQvFODrfztB+fBX4D7c0XuHH3omyN7+mvNcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC37606A326;
	Sat, 31 Oct 2026 16:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFC37606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=KCQU5UBdUKOKPuYMs15blstZHhzt4p2pk9
	uyUc66r64=; b=dECWU22N21uPmMesS4YkdjH7dcvTyBsGdqwSTWWYoQpgg1EkZS
	x9nCJsy8Ra7Pt8gNFmqBhIKlIkLil7V1uyn8CYbvMjIqSCpsZr8lXQJtZhAVVkLs
	402Qz9mvrIGMb1LflbMHpmrbIhWfGN77JBCg9LavZQ3LH8WvdoAvUttiQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkCGrAJ2HOZqZFASAQ--.38901S2;
	Sun, 01 Nov 2026 00:51:03 +0800 (CST)
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
Subject: [PATCH v2] wifi: mt76: usb: re-enable the rx worker when resuming fails
Date: Sun,  1 Nov 2026 00:51:03 +0800
Message-Id: <20261031165103.2594-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030021247.8032-1-25031212351@stu.xidian.edu.cn>
References: <20261030021247.8032-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkCGrAJ2HOZqZFASAQ--.38901S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF15KrW7AF4UZr1ftr1DJrb_yoWrZr1xpF
	Z8tayayrWDGrWUK3yxAr18AayfAan3GrW7WFykW34rZws5Ar1rC340q3WjqryUCr4vka43
	JF4v93sxGrWvvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyXo2DUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2rmBFQNYAAAs5

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

The early return is unbalanced with the URBs as well: mt76u_stop_rx()
poisons every URB of every RX queue, while mt76u_resume_rx() would only
unpoison the queues it reached.  If MT_RXQ_MAIN fails to submit, the URBs
of MT_RXQ_MCU keep urb->reject raised, the next stop/resume pair moves it
further away from zero instead of back to zero, and every later
submission on that queue fails with -EPERM.

A stalled RX endpoint makes usb_submit_urb() return -EPIPE, which is the
failure that leaves the MCU unresponsive and triggers the retry loop.
Unpoison and resubmit every RX queue, keep the first error, and always
re-enable the worker so that both pairs stay balanced.

Fixes: 0d2afe09fad5 ("mt76: mt7921: add mt7921u driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
 - Unpoison and resubmit every RX queue instead of breaking out of the
   loop at the first failure, so that a failing MT_RXQ_MAIN no longer
   leaves the MT_RXQ_MCU URBs poisoned across reset retries, and the queue
   indices are reset for every queue before the worker runs again.

Yes on both counts, thank you for the review.

mt76u_stop_rx() poisons the URBs of every RX queue unconditionally, so
mt76u_resume_rx() has to unpoison that same set of URBs for urb->reject to
return to zero.  The previous version only fixed the park/unpark pair:
MT_RXQ_MAIN is queue 0 and MT_RXQ_MCU is queue 1, so a submission failure
on the main queue left all MCU URBs poisoned.  The next
mt792xu_init_reset() then raised reject to 2 and the following resume
lowered it back to 1, and usb_hcd_link_urb_to_ep() keeps rejecting every
submission on that queue with -EPERM because reject is non-zero.

The skipped queue also kept its old q->head, q->tail and q->queued, since
mt76u_submit_rx_buffers() is what clears them, while the worker had
already been re-enabled.

v2 walks all RX queues, unpoisons and resubmits each of them, keeps the
first error and still always re-enables the worker.  The error is still
returned to the caller, so the firmware retry loop behaves as before.
---
 drivers/net/wireless/mediatek/mt76/usb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index a9af3aa6b80a..252a18dc3cb2 100644
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
+		int ret, j;
 
 		for (j = 0; j < q->ndesc; j++)
 			usb_unpoison_urb(q->entry[j].urb);
 
-		err = mt76u_submit_rx_buffers(dev, i);
-		if (err < 0)
-			return err;
+		ret = mt76u_submit_rx_buffers(dev, i);
+		if (ret < 0 && !err)
+			err = ret;
 	}
 
 	mt76_worker_enable(&dev->usb.rx_worker);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(mt76u_resume_rx);
 
-- 
2.34.1

