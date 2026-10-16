Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D671C50C29D;
	Fri, 16 Oct 2026 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792167591; cv=none; b=QQJ0SguTuA1itw+8ZBwiCDCqTv6x9Bxl/AxAbabmpuwzpmQSVEEkU8myNTTXEgULE2g/Xw5IAXWFPegnFZfxuB+u4yvlchcquO52IxKRlH+udaCMAIXEXXcERJI7/JP8qso1WQAroNg1Zr0ApU2uAWZjAlqCQKr+VXJYRMMbHeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792167591; c=relaxed/simple;
	bh=ENFZgHtxdvF4pI9iefiApJtXu8xO78IX1WmmevgYHZc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmhFt+cl4dFxIVSNJli6bf6uUBH/KN+3dHT/Tgf2ciIOHE/Z59mSRcVuBZ4a3L/1/y3/PdzbGkPxLoKjjQQm6shzBlE61Wa+2ZhNSyi8cCayF1Za6LZKpiZsOn3pBHoh7OgdeNUysLOcN7Zlr+YxcZFPk9CZiw3BTOhuJvcaERY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=UKTdQzBT reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="UKTdQzBT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=3SI2PYB4A4
	I6Xf6xw/bHHDGscaxuo07tsHr29BUxlDg=; b=UKTdQzBTSoxeovbnd7wka+ES1Q
	aTENkin+kyTYL/zxpqM0MLMRQJjsM7X22TC6/fW8k3PQLFhvyCW1QvbE55gWYkt6
	DsJ2aiB7ZC5ZkJVmMXw92ymxzFH5aDrDhB8+dzeZ4qdzMdXUaLbAvkvRF9Osfb2n
	jQB15rftgZlrroQ9I=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.96])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkC2uv2TTtJqAPOrAA--.62184S2;
	Sat, 17 Oct 2026 00:19:33 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] wifi: rtw88: usb: drop RX frames received before the device is started
Date: Sat, 17 Oct 2026 00:19:31 +0800
Message-Id: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkC2uv2TTtJqAPOrAA--.62184S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UGF4UuF1xWw45Kry8Zrb_yoW5Zw4DpF
	WrJayYkF93GF1jvF1fWF1xJFyrZws7AryxuFWrKa48ZFn8XF1SkFyFgFW2vryDAFWkAFy3
	CF1DtryUGan8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Jr0_Gr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8Jw
	C20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAF
	wI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjx
	v20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU59TmPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUID2rSPdEJEgABsN

rtw_usb_probe() submits the bulk-in RX URBs at the end of probe, right
after rtw_register_hw(). A device can already have data queued on that
endpoint, so rtw_usb_read_port_complete() runs and queues the frame on
rtwusb->rx_queue before any interface has been brought up. Submitting
the URBs late does not close that window: the frame can arrive as soon
as they are submitted, which is still before the device is started.

rtw_usb_rx_handler() hands every non-C2H frame to mac80211 without
checking whether the device is running, so ieee80211_rx_irqsafe() runs
while local->started is still false. mac80211 treats that as a driver
bug and warns in ieee80211_rx_list():

  WARNING: net/mac80211/rx.c:5601 at ieee80211_rx_list
   Call Trace:
    <IRQ>
    ieee80211_rx_napi
    ieee80211_rx
    ieee80211_handle_queued_frames
    <TASK>
    rtw_usb_rx_resubmit
    rtw_usb_setup_rx
    rtw_usb_probe

The frame is dropped by mac80211 anyway, and because the URB is
resubmitted from its completion handler, every further frame repeats the
warning, which floods the log until an interface is actually started.

rtw_ops_tx() already drops frames outside of start/stop by checking
RTW_FLAG_RUNNING, which mirrors local->started: it is set at the end of
rtw_core_start() and cleared at the beginning of rtw_core_stop(). Use
the same check in the RX path and free the frame while the device is not
running. This also covers the opposite ordering, where a frame that is
still queued in rtwusb->rx_queue is handed over after the device has
been stopped again.

C2H packets are left untouched: they go to the firmware event queue
handled by rtw_fw_c2h_cmd_rx_irqsafe() and are never passed to mac80211.

Fixes: a82dfd33d123 ("wifi: rtw88: Add common USB chip support")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 64e1c3420e0a..12fb669015d1 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -664,7 +664,7 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 
 			if (pkt_stat.is_c2h) {
 				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
-			} else {
+			} else if (test_bit(RTW_FLAG_RUNNING, rtwdev->flags)) {
 				skb_pull(skb, pkt_offset);
 				rtw_update_rx_freq_for_invalid(rtwdev, skb,
 							       &rx_status,
@@ -672,6 +672,14 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 				rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
 				memcpy(skb->cb, &rx_status, sizeof(rx_status));
 				ieee80211_rx_irqsafe(rtwdev->hw, skb);
+			} else {
+				/*
+				 * RX URBs are submitted at the end of probe,
+				 * so frames can arrive before the device has
+				 * been started. mac80211 does not accept
+				 * frames in that state, so drop them here.
+				 */
+				dev_kfree_skb_any(skb);
 			}
 
 skip_packet:
-- 
2.34.1

