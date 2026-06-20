Received: from mail-m60231.netease.com (mail-m60231.netease.com [210.79.60.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180B64A8D;
	Sat, 20 Jun 2026 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781924212; cv=none; b=ZfKtaAJkJ+TYdUrO66HBDD6gk49dtkSixDKLGe0oH8UQlE3JaSRX0FF2BLpUVwj3JF/uqP+6D3L6gvXDNUNGbraUtGKbHHibRPcCyQBWuBcmS9DN/MvMfZjObp/NHjjlDc5C3yu1boOcjhq6f8DT7X1p8H/NSTa9cfIETjo7NZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781924212; c=relaxed/simple;
	bh=JNpBd+uZkP6DfCrlhTY/drlL03eMzz5KkGj4NbXGVJI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iAXRJMNGcQ5CURrcmimJuPr45bjfTdhckqFJouO9fCLfv8rZfIdzeWfPR38KsJ41zdqBB7MPvQ8/mQPizdkQR3QtucG66CI+1Tx2SGqrRD6PQZOABMt5jzQXKZWlsr3K2/85zhgZ3b2WRxtuyB6rmN9awB0XlkGcM0xNT2dgl+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=H8n47/0A; arc=none smtp.client-ip=210.79.60.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="H8n47/0A"
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4314e50de;
	Sat, 20 Jun 2026 10:56:37 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH wireless] wifi: rtlwifi: rtl8192du: check QoS TID before indexing tids
Date: Sat, 20 Jun 2026 10:56:32 +0800
Message-Id: <20260620025632.46206-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ee2f574f803a1kunm08c4dea4e65b2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB8YVkwYHk1MS0sZQk5LSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=H8n47/0AWazikQVEYseH7wOscfM60hPCE0l7xvqUy6iVyAqg6DFz0fT5NPEOuUWvLn9tW+qBo/5R9GMDKWD42OlPZn/YdeEq8cG752Mnws48Pt/q/rwuYxgrvCoxJnzB/e/NLSL8IKGOsSZ1lBCfnyRHquw6S+z1zgWONT++0Tg=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1IWZ9O+Sl5aFiIfjp0uZas22aqensvgdoia6QJQRyjY=;
	h=date:mime-version:subject:message-id:from;

rtl92du_tx_fill_desc() uses ieee80211_get_tid() to read the QoS TID
from the 802.11 header and then uses it as an index into
sta_entry->tids[]. ieee80211_get_tid() returns the low 4-bit QoS TID
value, so the result can be in the range 0..15.

rtlwifi only allocates MAX_TID_COUNT entries for sta_entry->tids[], and
MAX_TID_COUNT is 9. A QoS TID greater than 8 therefore indexes past the
aggregation state array. Keep the default RTL_AGG_STOP state for
out-of-range TIDs, matching rtl92cu_tx_fill_desc().

This issue was detected by our static analysis tool and confirmed by
manual audit. UBSAN validation for the same bug pattern reports an
array-index-out-of-bounds access with index 10 for type
'rtl_tid_data [9]'.

Fixes: 8321424134a4 ("wifi: rtlwifi: Add rtl8192du/trx.{c,h}")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
index 743ce0cfffe6..c608c51f1b78 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/trx.c
@@ -106,7 +106,8 @@ void rtl92du_tx_fill_desc(struct ieee80211_hw *hw,
 	if (sta) {
 		sta_entry = (struct rtl_sta_info *)sta->drv_priv;
 		tid = ieee80211_get_tid(hdr);
-		agg_state = sta_entry->tids[tid].agg.agg_state;
+		if (tid < MAX_TID_COUNT)
+			agg_state = sta_entry->tids[tid].agg.agg_state;
 		ampdu_density = sta->deflink.ht_cap.ampdu_density;
 	}
 
-- 
2.34.1

