Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197207;
	b=w+HNG/mjkmAg9sa2GVrKjzVxmgWpn4L76ReeNzf6QK50Qg6G/dLVTX5z54bbpE3axO/U
	 QYUjhcpibtvd3NWf7wcpezrSWcCp1XMtllaezPDX/zLBCBpfyk2qwWMyst1SChLjcxV3I
	 KuPgi7RWCBNNfnphUC1utP4qmw/T6gjQ5Ti2OEQEz5fDoe/6ZNLvstMOwF5Q8zCMuPxBj
	 PwijsaZdEXcgeXp1asp0zCaAinxLAptBnuCeEM47/VOC5VZwmuzQayTE/44NN3E5KPMWb
	 Eoe7OqYl5ms9mMHWPmq0cNMeATWMlelzNdOgP2j2YsILz9YKcUFsrJ1ur3X+kzV9KLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w0FuKmqjAAxc2G36lErL/3fM5DHNQeeC+jY9FSXhzZU=;
	b=w/9jYcooPrv+7eNh6dS60xGBm5NAhSYjdw9nsmrXS0kn0ZVojB2GF0e19TjaRx3vxOsh
	 pYcARSMsqVJDeAwZ1gQu84wKZbE4ONIl3WskZ7XLfWqKZQzuw9xTNoq0iagTVQVh8iBXG
	 nAWevjsMFFDp5TscedF33cfXdP1gf/AHmf4QMUKMkTUwbOYcrlWgLAy/pr6uBaDIMoC0d
	 C1UEpVu1x5sUglPGEJpFj1E6IwAI1BGpj66KQUUZfv9siam/w6wm9SBU2ylEgwavU7jIz
	 bswfzykAzDvpydy+EXqeJXcUmfIw/2+p7ugyTB2wlOp1LrSGd0hMpgwkr10G7XVC2uA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCc+nva5;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66416606A324
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66416606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yCc+nva5
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd8ca57ef64so1016237a12.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197207; x=1793802007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0FuKmqjAAxc2G36lErL/3fM5DHNQeeC+jY9FSXhzZU=;
        b=yCc+nva5YiTEVaq1YUYP+cS7RYAm+YZnTgtCkpztxgFAzXPaQCUPS11qNaxU1ZJdDx
         mZQ9zZfEXvr4Oj8rXA413TUukEUjPx8KNgURIik6NBj4r7lfhYwE7X2oKrBL1dFM6cYi
         coLoKkiB3zzWvTHYWNG/AGTvRcm9zq7iMwJtyU2kciUOIE1HYo9HpSbDQvf3bToytnkh
         70LX2PQNSUGFNyYI3283IjlFu4XyOyxCMNMQBhBesmzXgRL/FephHrFIH5eEYuX9D9BE
         8d1nvq+QDrSiJTr4PxFa/4HaC7CUTYIB24uNkh17lrDNwRpBnWeH89F2tXlSLgfUWzeZ
         EiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197207; x=1793802007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w0FuKmqjAAxc2G36lErL/3fM5DHNQeeC+jY9FSXhzZU=;
        b=KfpHAVCjIgz9wOwsNi+Qc68y/PIPqBLNLdy40wKjeWTxlHCWA0XqW4TcRLJX0QUgmS
         vAbTVN4sqOPichNmxbUE6lsz8mgQCwQasIFeEfZ5r8xCg5ujqga6/mGd4mVEWUPE72e4
         R37IXASMDz/3az/poHy10sxXJD5j5JxNFUh8rZdGltTMj0vhcGiVPjqzxIAfJxleUqeA
         oqbc2/9YQT9jAJvKqBnM3MGWhUNQDyQonk0rDwv7XrbHWPTlb/Lw6PwxtvWCArKF0Pma
         tDMvp2FZfxy4YeD9mLmC3tkieTKdjvKjZ2FUx5eR2R987TvLKDVVihqZgw/nYMmAF1Vw
         ckOA==
X-Forwarded-Encrypted: i=1; AKwUvBzV2A4GoOGoSE5VA0qpEOZrL0fVeXYKOu3dRtQNen286GujOs9yLNOZbDXwogJzERRKQoPaf3M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTy1P2xV4qUC6TFyQvyBBCdU3scSZl/7HMZOl+7xuLEVHU48gv
	DHbSEwZ3ksPttFf4xjN00CcKfnbPZXFmFSrH+3xNotxTdibFV83yZewK
X-Gm-Gg: AYBFou3CP7CpkcK9HMB0i92nDvbTwFbKQoLMwJQN1nD+ewjVy4Eo6ySscF25tsTv2bO
	AjHIgwVZbnDdEhAZnTyLUSMMm2U1X3F/PTl3bLfF2I0UQMJM8mOwpBqQgqGdcN0ANSF3AZyhWRh
	k7PdbmEntUgt1E8NsmV5LpwQepjBJvErstsGdeEb8HeHhabeB7xaR1jOXGNk4FS+LtmZRVJymkP
	vXIcw4HtTNnHus7JUJXEaMmT4sQEnLOZJPRC8WCFKdnrMFgWvf9Ry9hAdg9t8koFsKtRbLWDjRX
	yM7WWBNjN1nedqDhF/hrIDtccSo+9p5L8GfjyPyeIToYjfQs0ZrVLLdW++gberwOJHTLKo4tHbv
	0ySBf1plesEgRhg9L1mGe8vyIqOCYAirn5F5yMaJjlGNMFUllflZ5CIc+DED8hn6sJU+1BKBv6P
	nSeo9jQhTXcNdFOirDEG5XzVsUwe8KjAxiU3WkgCJtt2Jwxh0IMjdVPDdKfib5msCQ3YxOQrxvU
	ZNdDWbGnQksPE1VMVoF7h6l/POEQ3iVYgWWS1ZispvpBeY/qTmmUBav3zIadfPzu126BZPlh+a3
	+Y/UO6PYQWn0nFtPAZt3ifunoUHLzrxXz26WnAd2dvaS/oTYyTraE92AjHMU/Ygjw7uH
X-Received: by 2002:a17:90b:5150:b0:3ac:a6a5:5757 with SMTP id 98e67ed59e1d1-3ae5c801c2emr953367a91.11.1793197206400;
        Wed, 28 Oct 2026 07:20:06 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9f286fsm3290141a91.15.2026.10.28.07.19.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:20:06 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Ville Nummela <ville.nummela@kempower.com>,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	Marek Vasut <marex@nabladev.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Stefan Hansson <newbyte@postmarketos.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
	Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/3] wifi: rsi: report background scan start failures
Date: Wed, 28 Oct 2026 22:19:26 +0800
Message-ID: <20261028141927.9306-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028141927.9306-1-enderaoelyther@gmail.com>
References: <20261028141927.9306-1-enderaoelyther@gmail.com>
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

rsi_mac80211_hw_scan_start() returns success when a background-scan
command cannot be prepared. The driver never marks the scan active in
that case, so neither cancellation nor the firmware-event path reports
completion and mac80211 keeps the request pending.

Build the probe request before queueing the start parameters, propagate
preparation errors, and clear the saved request before mac80211 frees it.
Successful scans keep the existing firmware command order.

LLM assistance was used to find the bug and review.

Fixes: 7fdcb8e12660 ("rsi: add support for hardware scan offload")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: W=1 module builds with MODPOST passed with CONFIG_RSI_COEX
enabled and disabled. Not reproduced; RS9113/RS9116 hardware was
unavailable.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 14 ++++++++------
 drivers/net/wireless/rsi/rsi_91x_mgmt.c     | 13 ++++++++-----
 drivers/net/wireless/rsi/rsi_mgmt.h         |  3 +--
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 27bfdb6affaf..a2e981e261d6 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -237,6 +237,7 @@ static int rsi_mac80211_hw_scan_start(struct ieee80211_hw *hw,
 	struct cfg80211_scan_request *scan_req = &hw_req->req;
 	struct rsi_hw *adapter = hw->priv;
 	struct rsi_common *common = adapter->priv;
+	int ret;
 
 	rsi_dbg(INFO_ZONE, "***** Hardware scan start *****\n");
 	common->mac_ops_resumed = false;
@@ -260,15 +261,16 @@ static int rsi_mac80211_hw_scan_start(struct ieee80211_hw *hw,
 
 	mutex_lock(&common->mutex);
 	common->hwscan = scan_req;
-	if (!rsi_send_bgscan_params(common, RSI_START_BGSCAN)) {
-		if (!rsi_send_bgscan_probe_req(common, vif)) {
-			rsi_dbg(INFO_ZONE, "Background scan started...\n");
-			common->bgscan_en = true;
-		}
+	ret = rsi_start_bgscan(common, vif);
+	if (ret) {
+		common->hwscan = NULL;
+	} else {
+		rsi_dbg(INFO_ZONE, "Background scan started...\n");
+		common->bgscan_en = true;
 	}
 	mutex_unlock(&common->mutex);
 
-	return 0;
+	return ret;
 }
 
 static void rsi_mac80211_cancel_hw_scan(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index 9ceb6cba3546..165423313c5f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -1862,11 +1862,8 @@ int rsi_send_bgscan_params(struct rsi_common *common, int enable)
 	return rsi_send_internal_mgmt_frame(common, skb);
 }
 
-/* This function sends the probe request to be used by firmware in
- * background scan
- */
-int rsi_send_bgscan_probe_req(struct rsi_common *common,
-			      struct ieee80211_vif *vif)
+/* Send the firmware commands that start a background scan. */
+int rsi_start_bgscan(struct rsi_common *common, struct ieee80211_vif *vif)
 {
 	struct cfg80211_scan_request *scan_req = common->hwscan;
 	struct rsi_bgscan_probe *bgscan;
@@ -1875,6 +1872,7 @@ int rsi_send_bgscan_probe_req(struct rsi_common *common,
 	u16 frame_len = sizeof(*bgscan);
 	size_t ssid_len = 0;
 	u8 *ssid = NULL;
+	int ret;
 
 	rsi_dbg(MGMT_TX_ZONE,
 		"%s: Sending bgscan probe req frame\n", __func__);
@@ -1928,6 +1926,11 @@ int rsi_send_bgscan_probe_req(struct rsi_common *common,
 	skb_put(skb, frame_len + probereq_skb->len);
 
 	dev_kfree_skb(probereq_skb);
+	ret = rsi_send_bgscan_params(common, RSI_START_BGSCAN);
+	if (ret) {
+		dev_kfree_skb(skb);
+		return ret;
+	}
 
 	return rsi_send_internal_mgmt_frame(common, skb);
 }
diff --git a/drivers/net/wireless/rsi/rsi_mgmt.h b/drivers/net/wireless/rsi/rsi_mgmt.h
index 236b21482f38..6a4907e6bca9 100644
--- a/drivers/net/wireless/rsi/rsi_mgmt.h
+++ b/drivers/net/wireless/rsi/rsi_mgmt.h
@@ -753,6 +753,5 @@ int rsi_send_ps_request(struct rsi_hw *adapter, bool enable,
 			struct ieee80211_vif *vif);
 void init_bgscan_params(struct rsi_common *common);
 int rsi_send_bgscan_params(struct rsi_common *common, int enable);
-int rsi_send_bgscan_probe_req(struct rsi_common *common,
-			      struct ieee80211_vif *vif);
+int rsi_start_bgscan(struct rsi_common *common, struct ieee80211_vif *vif);
 #endif
-- 
2.56.0

