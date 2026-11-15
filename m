Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794729786;
	b=Q7dZTVVpTlE9q4s0sEDqYrkkb6TqGlDxKGn1LsbUym9CIW8eLB7Ka/oT6Rl28qkPvMtz
	 5i5drN+Dnc+nxOSI0+4qfwLvppYNPi/NCLslMhfso0r/X7KKJ2/uA0ulkfEVnbjPWll9D
	 2cPhuUoV4l53G0Ljfxj8vyUydRqmzw2SDEsYAIW59goatdBVFgG/du5H6ji8sAlme+mTL
	 7lGqzGMFU4+lGVhxIQwuxSyCQkQM4VJSMf3jKr9LJwONCzz8e3BY1qMwXW2J6JWlt9c10
	 cvKACTNTg7tt8Lakw1w1nvXoZNkB5WMseJFPVpU7c7FFAy4uBSeTAClQog/mBn6rQZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794729786;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Ox2XlTyOSiiELfMJRA1RMpYz/DEXqGXFohGx482vSjg=;
	b=NZM9NLoF3hYCbue13oKE2z2FulGLOtNE+Q3dFvEehmHANn+kmT3O0sQaimpq32QZydLO
	 BKYX8MFa0KaZiGpQVo4/wi1uOyUkk1xtwoWr0XcKFFTrdVjm+ZfEVRYwX6dJIA2vi1Zm+
	 ngaH8pJW9DgEr5WPSY0vCYiH6nNJ6PlEB0m3qTYYgZoyhUzLbJDLIxqX+Tqa5A4fn/REc
	 9fbheqCP20n8la3Ut7GQIT6j4+uUdRWOk5LkS9Zsu+QtOi1jruaJFEwRd32JhlFVLzt3C
	 tAXA5bvnvTXWVbDIcXUL5CIqhGF/CDTVel042pNC5aprDQayfPwwgZl0i5eL54HmNTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UsTDTdqY;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E1606A31A;
	Sun, 15 Nov 2026 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C39E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=UsTDTdqY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Ox
	2XlTyOSiiELfMJRA1RMpYz/DEXqGXFohGx482vSjg=; b=UsTDTdqYIgrfG2yCl7
	p9l5zRaFhkqL6dLz7I/pvh7lF9JVvwXTHcZbyM6qyu9RToyIrz2nn1u9Y99wxQbJ
	hiuBkVTiiOBvZ+2UgAU1qzNyciERnaszjeVo4NcrYeCaEObDLKqdAQ6Fj+QSM31P
	oej25ueIQDy44OiIK/5f+Opvg=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3v_AZZ_lqifQ9IQ--.40454S2;
	Sun, 15 Nov 2026 16:02:33 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mt76: connac: use wcid_to_sta() when dequeuing PM frames
Date: Sun, 15 Nov 2026 16:02:33 +0800
Message-ID: <20261115080233.910330-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wD3v_AZZ_lqifQ9IQ--.40454S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF47ur17KF1kZrW7KrWDtwb_yoW5Gr1UpF
	WUK3yq9r1vgr45Za1kAw4kZF9Iyan5GFy0yF1S9wn5uw1rZF109F4jga4YyF4FyFs2qFnI
	kr4DtrnxurZ8Z37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jkGYLUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7hn4SWr5Zxmk1wAA3Y

When the device is in runtime PM, mt792x_tx() cannot transmit right
away and queues the frame with mt76_connac_pm_queue_skb(), keeping only
the wcid. mt76_connac_pm_dequeue_skbs() later recovers the station
from that wcid with

	sta = container_of((void *)wcid, struct ieee80211_sta, drv_priv);

This is only valid for the default link's wcid, which is embedded at
the start of struct mt792x_sta and therefore at drv_priv. Since MLO
support, mt792x_tx() queues the per-link wcid of the link the frame is
sent on. For any link other than the default one, that wcid lives in a
separately allocated struct mt792x_link_sta, so container_of() yields
a pointer 600 bytes (offsetof(struct ieee80211_sta, drv_priv) on
x86_64) before that allocation. mt76_tx() then passes it to mac80211,
which dereferences it as the station, e.g. in
rate_control_fill_sta_table() via ieee80211_get_tx_rates().

wcid_to_sta() in mt76.h follows wcid->def_wcid for link wcids and is
correct for both cases. Use it.

mt76_check_sta() in mac80211.c has the same pattern, but only uses the
result when MT_WCID_FLAG_CHECK_PS is set, which only mt76x02 and
mt7603 set; neither supports MLO, so it is left alone.

Found by LLM-assisted source review. Not tested on hardware. A test
module that queues a frame for a separately allocated link wcid and
calls mt76_connac_pm_dequeue_skbs() hits a KASAN slab-out-of-bounds
read in rate_control_fill_sta_table().

Fixes: ebb1406813c6 ("wifi: mt76: mt7925: add link handling to txwi")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---

Notes:
    The changelog was drafted with an AI assistant from my analysis;
    I have reviewed the code, the fix and the text.

 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 8481eac8d..6c2caade6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -134,8 +134,7 @@ void mt76_connac_pm_dequeue_skbs(struct mt76_phy *phy,
 			continue;
 
 		if (wcid && wcid->sta)
-			sta = container_of((void *)wcid, struct ieee80211_sta,
-					   drv_priv);
+			sta = wcid_to_sta(wcid);
 
 		mt76_tx(phy, sta, wcid, pm->tx_q[i].skb);
 		pm->tx_q[i].skb = NULL;

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

