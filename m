Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794829856;
	b=LBT+ekGbC5G4/83l5nVe1FTEgyIrO+GLil5GVYNZtjigZOzPKCzr+MQYYXNYnOWW7KSE
	 TsCRGtkniqfvwZSUCf+WG3Awq7n132JxM93rQIKOwCuCCQQm4sVAzd5Me5Z8Oq+bVuC84
	 cdwqPn0ysMd85w4RW3jDdxTvGBomQHVX5+aZr+R2j1JWOOOml1hrsvBwWagR/ghsb0HT3
	 PwUXiJS6S6gG+cP65dHyfHyUJL77qM7x9LcEyRFs9I/cupWtjzGP/LN+JZdpJhvJZWn6Q
	 i3IMp5y8LcuckUQbOVZMLlUSKBxmu0c66PCH9lQac+DhZkWt9ya6iNVDEeV4QrXN5yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794829856;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=+Gulw9rQwCgMfpqxWvGwqpn6aChNo0sF9Qf6gDE7Ap4=;
	b=z0CTVVjkzyDx2ZkjvtMNOUaCtOecwCTKRfKXXN5YDen7/jCu9U7CqxqHwt0xEVn0Vj1k
	 muZtyBnIvcTPTRlTzvAgZOaBM4uO7sl5kTQ7GIqIXwUCMBRB9KmgPp7roy+LHizUzGcqB
	 YLCdwZ9/UPeiekBm/+ll2A+yeAWEruNh/qbqVOK7+HI4T86toXjHruNACGtAWVNPe9sFP
	 FWJ1SXr4HWWFW7+wAWCiU4hcAHpu4JQjfC6V3bER1vuFDYwYV3Hc5BbUIffJiKoobsOrH
	 A4ckoxw8l26GMsWYZeIBsAckWpBmiEZ6fvIimu58fsAMm6A80PBxBQTsU7enIrcuyuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F32606A31C;
	Mon, 16 Nov 2026 11:50:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F32606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=+Gulw9rQwC
	gMfpqxWvGwqpn6aChNo0sF9Qf6gDE7Ap4=; b=6QG+SVo3+dvCTkPl539gPwdwCu
	cpeCtg6aCHqPWmLhZ3L9trsWYfoXr595MnbBE11oyc0k9NbauhLFD3aDxqDgHz5H
	hd2rVIR+LGIXUpKGA5SLWUWsyQU+mf/spTlFUHctTK7iGRLITq0U+c9tBpX7oXdX
	9jQGWqGsrrBBVfMdQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkB2vwQF7vpqZ6S3AQ--.3956S2;
	Mon, 16 Nov 2026 19:50:31 +0800 (CST)
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
Subject: [PATCH 0/2] wifi: mt76: mt7615: fix RX parsing on the USB transport
Date: Mon, 16 Nov 2026 19:50:26 +0800
Message-Id: <20261116115028.2766-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkB2vwQF7vpqZ6S3AQ--.3956S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKFWDZF1UZF4UXw1ktFW8WFg_yoWfWwbE9r
	1fJrn3Kw1xGrs7Kr43tr4jqryrK393AFyfZr4FqFWavrZ7ArZ8WFn2qrs8Zr4fua1Iyrnr
	tanFy3sxZFnIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8ZiSPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r5zUi2hAAEs7

Two independent fixes for the mt7615 RX path:

- mt7615_queue_rx_skb() walks the TXS entries up to skb->len, which
  describes the whole packet including paged fragments. Frames
  delivered by the USB transport can be fragmented, so the parser can
  run past the linear part of the skb and read outside of the skb head
  allocation.

- mt7615_get_status_freq_info() dereferences the configured channel
  although received frames may be processed before mac80211 assigned
  one, which crashes with a NULL pointer dereference.

An equivalent fix for the first issue in mt7925 was posted separately.


YuanZhe Liu (2):
  wifi: mt76: mt7615: fix out-of-bounds read in mt7615_mac_add_txs
  wifi: mt76: mt7615: fix NULL pointer dereference in
    mt7615_get_status_freq_info

 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1

