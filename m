Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829856;
	b=BVnsFoIpZS/9psxrcVJiXEjsx6P1GvKWhNZDQd3nhiJIe/tSbRLmOoD2uRNukLwHR+o/
	 Xo70pN5UQjSrvpv3ZhOi+8SBYImdIf2TpFpli2nsrlnhM+sC90OCpJPyyfX6Sgn4J3fUi
	 lI4NnlyMIw8d5hilCZxYmaAIXY3l+7UyLAD+bcVLOrats+FocDTpCYgkSdpLUvzY+Yjij
	 coaOtPlR2wkjFaD/1TO5TyvzJ+aGqglQ6VGztZqaR7Xj45do2BqWs1eMkwm7//0KvYnP2
	 btST3KcP+96mzld0yKwqvJYC7Oox8vKXp8JPBMDlCLlHtsWJZuDnrKN2y5lYQk6ogtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829856;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=iDn5Jwu6eLfZdF3r4ltGaB9NYIzcoHuDEBvIkhPKqmo=;
	b=kqxx41checSOWnO53Qy1aq82iQLfSm0mU8un8JVvbwSqCy/XVSWGDzMF1zQXaF5g/5cI
	 a1f96NtVaUXl8LJmaLbXt0aoObzZWdq2seEyTtl2KgYcsUzxyofq1OOV0nRKKEqRYrhZ/
	 nOz3cBEnizMqk9ujveVZDcrtC7TqOVKryxQp32FzOmrAjMOmxlVKqc65lQZDoI8vs3IE1
	 JA96+wPSJisggXbyP5pUHmafBwBtd7STut2zcu+D9AeqTRxUdkIXXz+uXcQ28plSRx5HO
	 n4tkquKyiwY5tstO+mEqnp8qpUSYuUd+bGQTcwK+yn/nQok8EvSbEzQDfWBG2f8DlPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FF9606A32F;
	Mon, 16 Nov 2026 11:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37FF9606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=iDn5Jwu6eLfZdF3r4ltGaB9NYIzcoHuDEB
	vIkhPKqmo=; b=w1m941Lq9P5U3BxeLvEhVlBq3jFmBl7Mp2sx0VjMt2N7cfccMA
	FqhVNIKOROfLp1i4BY3mcO78X1zJgpuIuZIfwjJP7RIzKi+hDmkUit5A5Ju3RD2v
	QrBqPleM+ZFm237NwimvLNaTKlfNKaxLR05Vmj0RSHfamXEYO0hMxxtbs=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkB2vwQF7vpqZ6S3AQ--.3956S4;
	Mon, 16 Nov 2026 19:50:41 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Felix Fietkau <nbd@nbd.name>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <mbrugger@suse.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mt76: mt7615: fix NULL pointer dereference in mt7615_get_status_freq_info
Date: Mon, 16 Nov 2026 19:50:28 +0800
Message-Id: <20261116115028.2766-3-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116115028.2766-1-25031212351@stu.xidian.edu.cn>
References: <20261116115028.2766-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkB2vwQF7vpqZ6S3AQ--.3956S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW3Gw1xWFy5uFyxJr4xJFb_yoW8ZrW7pF
	WDG3yjk3yDGF4DCa95Cw17C345uan8KrZxCr909w1rZ3WkZr1FyFsFvayjqrnYyrZ2kr1x
	Ar9rtFyakFW5uaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQjb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
	aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0E
	x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14
	v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY
	67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2
	IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jOkucUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r5zUjNkAAAsQ

mt7615_mac_fill_rx() starts processing received frames as soon as
MT76_STATE_INITIALIZED is set, which happens while the device is being
initialized, but mphy->chandef.chan is only assigned once mac80211
configures a channel. A frame that arrives before that, while the phy
is neither scanning nor doing a remain-on-channel operation, makes
mt7615_get_status_freq_info() dereference a NULL channel:

  general protection fault, probably for non-canonical address
  0xdffffc0000000000
  RIP: mt7615_get_status_freq_info
  Call Trace:
   mt7615_mac_fill_rx
   mt7615_queue_rx_skb

Only report the configured channel when one is available and derive the
frequency from the RX descriptor otherwise.

Fixes: fcdfc29e58ee3 ("mt76: mt7615: introduce hw scan support")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 86c6b443ef71..b6256226b605 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -199,7 +199,8 @@ static void
 mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 			    struct mt76_rx_status *status, u8 chfreq)
 {
-	if (!test_bit(MT76_HW_SCANNING, &mphy->state) &&
+	if (mphy->chandef.chan &&
+	    !test_bit(MT76_HW_SCANNING, &mphy->state) &&
 	    !test_bit(MT76_HW_SCHED_SCANNING, &mphy->state) &&
 	    !test_bit(MT76_STATE_ROC, &mphy->state)) {
 		status->freq = mphy->chandef.chan->center_freq;
-- 
2.34.1

