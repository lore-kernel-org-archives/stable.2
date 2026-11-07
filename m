Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047448;
	b=g7j4+2Gpt3bE3yo8ZG73NNM83rrZKcrZ3aoh7ZcSPwq3MRRqF5wgXTUH1fl1hNXrqA2y
	 oLUtyPAubTePeDpnFIl5F45YAog0P1TTezqFsc6TU0E4ObqlKxSerad23Z/rUFFJWxUlH
	 byQ3DC3AvEYBL7A+MBbSMZ3HfUEuhiSLqlevDa9SAO5norxa1Z1faKYo/3yNrTAOnNgRR
	 k0cogqUFDHff1031IffYptZrNqe03DqGU+RlFJrZN0bSdImYbE4mZFRMHMSO5gV/7czKo
	 CTPcIwELFynoMs5GFk2bGx1+ZiUm1dP7swyo2GnomGj8WI9p5JPfmgZ79K7RCUe01Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047448;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kPJqFqXcPPg40F4LL3Le+ecF+zMPmvQnZp4v8W+BK3o=;
	b=uEvcVHlGzW35O7EeFBFnGiL4ofj+DojTrjwrSfQcFVjR+qzUMdWY1QiBeXuMGLz86utc
	 HNMJ2rcItMge3NMooyvhIaHnxOST+tsXdRygBcDvH0BG6QBr862lhTOOQ/Zu/wuAZkS20
	 IAqz8APzc37DCKmyRlWkwtKF+QV1fjPIvCwP0ia2ayETOg05HyTYmMvm+CZhPtfsAWbTc
	 RCvcpIVeH/FLBVLy9n2bi3XEf5zhFUPxv8D3M+6FjilxlNpAqXV920VtYhFlqJPZrouwu
	 D5UaZ7KBar5BJ1BST8yK9sLIGFpBMSbUghmm8AlTDTRFN+VbH8VUjMB8tXrKggHMQfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfFIDcuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A951606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TfFIDcuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D560A1F0089F;
	Sat,  7 Nov 2026 10:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047448;
	bh=kPJqFqXcPPg40F4LL3Le+ecF+zMPmvQnZp4v8W+BK3o=;
	h=From:To:Cc:Subject:Date;
	b=TfFIDcuzDP3Q5xES21o6J3Kwsh5whOuzuvC3NDIO/BYcXcG5vKL+PWtabKvQRwSlX
	 8A+3xkJxII97UqupCtb+yyQgZNsb3db0Yb0nIXAL5ilpJc+mJSw4LOLyOJ8vVYRN/L
	 gAv8rgyLP5n+3b7K9MTa9/b01t6AlQ7TLDcmqD2Rb+93j2kdTKCCu5gmusHXXiPMO5
	 7PM9qi32tsL/1oev92Lb+qy6TtktoA/AW5lGqlO/Y5g+SptjWv3O//M46g9lkykHpK
	 70wj6ZegIBg6ijJS/PLRiMuQ3kGopSNS6Iqbl0xNVB+eqFKQooysAjKBuhfLTpL0HY
	 nl7ZlD+iCgkLA==
From: Sasha Levin <sashal@kernel.org>
To: pkshih@realtek.com,
	luka.gejak@linux.dev,
	pepe.schlehofer@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: rtw88: TX report with long timeout for non-PCIE devices" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:46 -0500
Message-ID: <20261107053046-failed-6.6-7cde94dab0e7@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7cde94dab0e74434ccc0a387d7ad373fb3becda0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053046-failed-6.6-7cde94dab0e7@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




