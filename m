Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C64D27FB37;
	Mon, 19 Oct 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392016; cv=none; b=joNPQ56Lsv4R2OR/k/mriVVjWJEJ223uEf+I1KSiiOEg1HaiaVhJckmut5MV4rk3DXp5/3pOl7bauGfscIaRKEsdFDvLeV2tGVdvapTUmexaomOfRck0ZALsrQK7W9SaBosB7kDEFdjo3RxieIGXCUQAPaGdCFgucMH5HI46eRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392016; c=relaxed/simple;
	bh=DEgEoR+CwSwQzoTuJw1vhywsj1BSGJlHxb5/nkup5dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NI2RlnAHp+FMtrJFGNvINzjvXSHNktt0Axh0ZoQz6D7wci3bH7lVyjktiSDw5ddj1yU486vU0E6ddi0dtkTzJtPKfkux7BNJ1n9Wztv6Aj8xdoL89McNMMJP17FEJzb07iLElN42V6fnB7IwLiLGK4U3irU6WCasrjz9j7N7ewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=uHO2UKtd reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="uHO2UKtd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=YR8FxMCJvzlwEHCna466jdpfQc7jTqAFDm
	lQJKGC4dw=; b=uHO2UKtdvemOfNEAV6o6Cr6GkeN7BO16YIr0BPIuR8aQhWvnsE
	bJFSErtt2iAyDNIMzY3+SOwlDuyPu0slMkZb6uYyNxf9sEWBg1qAoBcgM513b9qx
	4lCM+7V/0J5IoIuO+ZONORZhf5tj+qSQk78PIjdgehxSMPkEbB13EIHMI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.71])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkCmqfxBu9Vqtxm3AA--.6288S2;
	Mon, 19 Oct 2026 14:40:02 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] wifi: rtw88: usb: drop RX frames received before the device is started
Date: Mon, 19 Oct 2026 14:40:00 +0800
Message-Id: <20261019064000.5167-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
References: <20261016161931.18495-1-25031212351@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BbQMCkCmqfxBu9Vqtxm3AA--.6288S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4UGF4UuF1xWw45Kry8Zrb_yoW5AFy3pF
	Wrtayakas3GF1Uua1rJF1xJFyrZan7Ary7uFWFg345ZFn8Xa4fKFyFgFW29r98AFWkAFWS
	yFn8tryUGFs8CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUxSfOUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgULD2rU4z5oBwAAsP

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
Changes in v2:
  - Restructure the check as suggested in review: bail out at the top of
    the data-frame branch with goto skip_packet, and drop the comment.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 64e1c3420e0a..dbfe02f7d6f0 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -665,6 +665,11 @@ static void rtw_usb_rx_handler(struct work_struct *work)
 			if (pkt_stat.is_c2h) {
 				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
 			} else {
+				if (!test_bit(RTW_FLAG_RUNNING, rtwdev->flags)) {
+					dev_kfree_skb_any(skb);
+					goto skip_packet;
+				}
+
 				skb_pull(skb, pkt_offset);
 				rtw_update_rx_freq_for_invalid(rtwdev, skb,
 							       &rx_status,
-- 
2.34.1

