Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048212;
	b=NEtjhOjUhhAQzXM1O2oK0zwyjb9iRWx6lt825tveSo3bF4CCYxw8NIHtY7PUSigFyA0G
	 wgHMRVBCYmMbwhDpo8Q6ciobN8M9zM1aMIk4czFeNqhvbKROeu/RDw5qiWqfxtyUrVMWP
	 P2UEET7UQyHP9HC5pVhQuhxwEv1b637kXa5cXHCOaCQScdZrTDK03N3xFOC94+PNThvMQ
	 bkppxxV9a7h+y9QT9tOdbycyVcj3/nqqY2SjpO8HRL84BsaE8rFYps/fzw2MxM5jLZlKz
	 ie1HNY/tIs2tkS7++TyBzntEzPXPYlW9HYay5BMp84dUlEAYTx5RY8qSzLRxjOgzgKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GbUr6L6AouiR2A+3+ErX8tni/W7jTOVP6uDAmtocgIQ=;
	b=CAX7VfuDip3TXWRPj9OtjjyI+1hTpdLU8fSrHdGqPgybfu5m2OoegsziMEfqfKm/bRgq
	 UBl5HxEZFQW+qbwo5gF532rotDloqVCkZlNwR5cLAU6iFqDI3nHKpMMxsva/1L9LliV2F
	 3gpAzmQRIQMUeEzdpZsqO3gQuXGM68hEuuQgCXI0jFMkwHeshvxZNVGVhc6EJZOgkAzGY
	 KMtcD/LwnLG0/65I/0dPtDFteAKMiDz9mgPs79xC6BatJ8KPPbyJdvpOoAw3yD0UjwCTS
	 hZRBTlSr2dSGNc7k+TU8CZfqDsBp/nHQm2FBpSmWngYXBJY3QitUzhMes2kp2xtglog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUrIq0ke;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WUrIq0ke
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F75D1F0089F;
	Sat,  7 Nov 2026 10:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048211;
	bh=GbUr6L6AouiR2A+3+ErX8tni/W7jTOVP6uDAmtocgIQ=;
	h=From:To:Cc:Subject:Date;
	b=WUrIq0keebpyEr2e6IyZvOEkleJGFfOQJQniNbPq7u0T4QyRDnY/FHKOu8YFPlA6I
	 B7zjt92+sPgV2Z66JBvAkwuFUgpHI75wMEMVj8XcmqkXJZz/9dFqlHhIZgnwDRLHyt
	 g7jBa6INU8VIC4ShRB3CtFUsExI4zcoU3edeBxUX0HO2jcWa2a1eH+Y/NAFpqmA2b3
	 rvgkKcA6syXP4B1PBchPOy1AC8ckQa9XnklcEUXQGwwesD+EIDi7ryGkuE8MGqk/Vq
	 2zVSexvzS+JYHv0qGLdfhrCnPajiZ91tlF1PVDmnNH0ecS3Q/6o0otvofE9Td2vr79
	 bW084adMOPbMw==
From: Sasha Levin <sashal@kernel.org>
To: pkshih@realtek.com,
	luka.gejak@linux.dev,
	pepe.schlehofer@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: rtw88: TX report with long timeout for non-PCIE devices" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:43:30 -0500
Message-ID: <20261107054329-failed-6.1-7cde94dab0e7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7cde94dab0e74434ccc0a387d7ad373fb3becda0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054329-failed-6.1-7cde94dab0e7@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7cde94dab0e74434ccc0a387d7ad373fb3becda0 Mon Sep 17 00:00:00 2001
From: Ping-Ke Shih <pkshih@realtek.com>
Date: Thu, 24 Sep 2026 08:46:37 +0800
Subject: [PATCH] wifi: rtw88: TX report with long timeout for non-PCIE devices

Many USB and SDIO devices can't report TX status within 500 ms, and
extending to 2500 ms as tested USB/SDIO devices can fix the problem [1].
To avoid adding chip ID one by one, and this change looks harmless.
Keep PCIE using short timeout, and others use long timeout.

[1] https://lore.kernel.org/linux-wireless/20260921165343.8131-1-pepe.schlehofer@gmail.com/

Cc: stable@vger.kernel.org
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Link: https://patch.msgid.link/20260924004637.9958-1-pkshih@realtek.com
---
 drivers/net/wireless/realtek/rtw88/tx.c | 10 +++++-----
 drivers/net/wireless/realtek/rtw88/tx.h |  3 ++-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 4e110a457e71d..701ed7c4f3f75 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -196,7 +196,7 @@ void rtw_tx_report_purge_timer(struct timer_list *t)
 void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 {
 	struct rtw_tx_report *tx_report = &rtwdev->tx_report;
-	unsigned long timeout = RTW_TX_PROBE_TIMEOUT;
+	unsigned long timeout;
 	unsigned long flags;
 	u8 *drv_data;
 
@@ -208,10 +208,10 @@ void rtw_tx_report_enqueue(struct rtw_dev *rtwdev, struct sk_buff *skb, u8 sn)
 	__skb_queue_tail(&tx_report->queue, skb);
 	spin_unlock_irqrestore(&tx_report->q_lock, flags);
 
-	if ((rtwdev->chip->id == RTW_CHIP_TYPE_8723D &&
-	     rtwdev->hci.type == RTW_HCI_TYPE_USB) ||
-	    rtw_is_8723bs(rtwdev))
-		timeout = msecs_to_jiffies(2500);
+	if (rtwdev->hci.type == RTW_HCI_TYPE_PCIE)
+		timeout = RTW_TX_PROBE_TIMEOUT_SHORT;
+	else
+		timeout = RTW_TX_PROBE_TIMEOUT_LONG;
 
 	mod_timer(&tx_report->purge_timer, jiffies + timeout);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/tx.h b/drivers/net/wireless/realtek/rtw88/tx.h
index d34cdeca16f19..168f48e87853d 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.h
+++ b/drivers/net/wireless/realtek/rtw88/tx.h
@@ -7,7 +7,8 @@
 
 #define RTK_TX_MAX_AGG_NUM_MASK		0x1f
 
-#define RTW_TX_PROBE_TIMEOUT		msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_SHORT	msecs_to_jiffies(500)
+#define RTW_TX_PROBE_TIMEOUT_LONG	msecs_to_jiffies(2500)
 
 struct rtw_tx_desc {
 	__le32 w0;
-- 
2.53.0




