Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074989;
	b=HRm4VScwkB9bfU3iuDfwoDbFofXupbQhDdTpOr78xIBePRlcGZYts0pD6epQn9OVwV8h
	 Bd7fpVnWPv+alE88vSVTtxmE9M7KB3gSzE1YOp3jD8j5d8oD33SklJ/pF6osbra6xaJqz
	 qEcd4YImIqSZ5oyOHXIHYnl8BB8HfXv/6F5hKUpZnxsUhqm0rijfU/pOkp7kATEjEsIpc
	 suO3Vr3QOJIgwYE/AkW0x8jr8832l4jL7YcTAMOHwkuT+YG3T2unW2mCM8vN5qHfGktGZ
	 6YMq0x1fT0v7pGF1+vp+sLvPhnLw03hpTDFNUrEIxGVXkCkm9EeeIFplYrWXf7q7aBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074989;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zD4vWVrzj0m5l3wwaVzmZX6fctqf45aDG3D9ksl4C6c=;
	b=uTwm0aoQswfPjG0nugBRDvIEtZGuULX7WcNCTd+okS+vwLxMNqyc9VNyfLyw+X6wF/th
	 LLUUP/vAr+W3q5r3JFJ//D028qUb3v1oIB5sAi3MsyWvQb/RSNYkEQa4HmDOWoRTTJLSj
	 0XJv2ux6v9iOlZbJgYFaftS1HWRt7PrSmbgzYoGS4QLfhWTRx28YNUl1OS5TRX1lerZIR
	 EMwhpuw6oOSm9YTZeB5JzizKVcAOBAxozr3zJfOoeikys0YmYtY6vAOu3bsbFj+TtQkxP
	 N/vVPEGsGiMbdoDzfiThfpoo4MpfkH9iIGo9JFgC2/ZmU6femJjvSf0cIXyCrz3Yrow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB4Hwqg0;
	arc=none smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FC606A325
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 544FC606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YB4Hwqg0
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2efd659464aso7932545ad.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795074987; x=1795679787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zD4vWVrzj0m5l3wwaVzmZX6fctqf45aDG3D9ksl4C6c=;
        b=YB4Hwqg0DiuGEH09AUeOt3wJvoIWEDxxJr+bQEPUE/yv227htIMm1ypFAL/7XjQ0EC
         J9gBdTDOEvnceKo4pbdKyyWEFpAK26KWd3jIEpCzqgtuH8WqzcmY3YIWcwtdImFwI/sx
         fdJqpu3MCWQh8i7Qf306MWqM8NGl1LGE8eH144xnFUqZxtRpzvijTgq6D5x96Okrk1cI
         guKoL1BhmJ+UxI2nPcwqW7/OSf0CfaESi0dfvz0vei89aoRLQe2t13Y0HO9jqHcZQc4f
         +r7WrTosr0CblSIzkDrWu0yJJQlL/y7Xj22sxCPh9KCQeL7v2F0EXBw/LIXHK7W3l+cI
         PnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795074987; x=1795679787;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zD4vWVrzj0m5l3wwaVzmZX6fctqf45aDG3D9ksl4C6c=;
        b=M3Wrefy2zorhrMyU7Wj3GfWYbb6fbZv5HgpmOgFtNrWvZi4V4caBs1nKC769UA0iAo
         U/FFxVgocey1NmsinFVbm4+K+jUTEBOabBxepjc7c26wDjGf875z23xlN3Z3FUaKmwro
         XWWZapBJJi4EEXz2rKm8N0OdbX8RrVFm9kUbjybjX4OK+vGmHYRgKMxkMO/+ymRnomCh
         FLsKE15JDl5bDCad6wM97PoaLsofeHu9ZoY8qngsHuJ6DVceY66yBDPcqk9+6E5Gj90F
         spTQBpwhbWJYIcpgeynUEMCwc6vaNfpbD8GGviTs/Sj3CL3hZgNekNgpPHJVQPp2kwOB
         Z6+Q==
X-Forwarded-Encrypted: i=1; AL+hErEGf+izV02tu8Ai6Tl45KBRYZWPo7GaANeMQaWWGzbgZRidKPL8L+XPxbEPxPnMcmydrZDFx0I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9oO5LXk/SnlscE/7/Yt4hiGxZ/tVRP+hiPBqwHtXaMgWh7fxye
	NCYh5bjBbJq+PdC1YMnZkjJKjb8BJW3vOPoMPJno/AUmKgUXJCEx6zpW
X-Gm-Gg: AZFdTZfoFDMcf1A0JXf5NtvvfI/+Jr6/rQbFreu7IkMjb6DpHgXy1iGAaGyzmTW+eD9
	K+lFYHjdAC8CUJalcjtL+b9Y5w82ZXaGATBmfoaSXVn95+ttcqwOM0c48bHG9x0Oe72PYaHtWJh
	2ugbPBQ9NgKufsOs1e8RXYk6UE7aKahA6jtt4usR9VAef0vWHeDz04gtB4seoIqbcHNuhBKKU2a
	WGIl3osgvmK98Ye5zf5FdBsn9XfoeN9MkLXujj9TKkZ1qi1Ll4DJFVswKHONJQnBBo5/biBgr5E
	hv5/H3YEVq59N8xuo3EkkQhbLfLlkpWLay377qLetLCNuvi+AJKJ5XGb032Qc4eO088TwNnSEjS
	2ayIjZlkG22HswMtP7E7S6hAVPTTOOFZX06fqvW4ErA3aCcbvq9mh/QzPX3Ejt4N1qDjnMWinlA
	yNg1n7gL7rDvrsxC6XDDGOfoWepOxEkX/FboU4kVRHItTt2H9PzdHgCDeIvCyzfLGzVPQ4Y+w/S
	7N09KIC4hnKEOBBPHAvzXEo3f7j029zjCv0tV/T5bj0wuHlf9wpeT4890ShjQRu781NfrxHs1Bk
	8BigO/B/AMDQiv7EX6b1WInEhPXY0zjzPpE7L7k0qterauybuV6IM5pZ/rMC
X-Received: by 2002:a17:902:ea03:b0:2df:90d4:7758 with SMTP id d9443c01a7336-2eff72f4385mr44649885ad.23.1795074987036;
        Wed, 18 Nov 2026 23:56:27 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:84c0:a687:3d35:47b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6183f8csm25817825ad.31.2026.11.18.23.56.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 23:56:26 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
	Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
	John Crispin <john@phrozen.org>,
	Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH ath-current] wifi: ath11k: fail the start when a service ready event fails
Date: Thu, 19 Nov 2026 15:55:59 +0800
Message-ID: <20261119075559.10177-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
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

ath11k_core_start() waits for the service ready handshake, in which the
firmware sends SERVICE_READY, SERVICE_READY_EXT and, if it supports it,
SERVICE_READY_EXT2. Only the last of these events completes the wait,
whenever its own TLVs parse, so the start goes on after an earlier event
failed (for example, on -ENOMEM or a malformed TLV), with capabilities
that were only partly extracted. An event that arrives again, even after
the start, is handled again and rewrites the capabilities under a
running driver.

Track the next service ready event that this start accepts. Each handler
takes only its own event in turn, closes the handshake before parsing
and opens it for the next event only on success. A failed event then
makes ath11k_wmi_wait_for_service_ready() time out, and any event out of
turn, including one after the handshake completed, is ignored.

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Fixes: bd6478559e27 ("ath11k: Add direct buffer ring support")
Cc: stable@vger.kernel.org # needs adjustments for <= 6.1
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Found by code review. Tested in a QEMU guest with KASAN and a test hook
that feeds service ready events to a synthetic device: without this
change the start completed after a failed SERVICE_READY or
SERVICE_READY_EXT, and duplicate or out-of-turn events were parsed again
after the handshake; with it the failed start timed out and those events
were dropped before parsing.

No new W=1, sparse or smatch warnings.

AI assistance was used.

 drivers/net/wireless/ath/ath11k/wmi.c | 22 +++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h |  9 +++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 08fd6795ed9e..5f9b18338478 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -612,6 +612,11 @@ static int ath11k_service_ready_event(struct ath11k_base *ab, struct sk_buff *sk
 	struct wmi_tlv_svc_ready_parse svc_ready = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH11K_WMI_SVC_RDY)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY_NONE;
+
 	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath11k_wmi_tlv_svc_rdy_parse,
 				  &svc_ready);
@@ -622,6 +627,8 @@ static int ath11k_service_ready_event(struct ath11k_base *ab, struct sk_buff *sk
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service ready");
 
+	ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY_EXT;
+
 	return 0;
 }
 
@@ -5118,6 +5125,11 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 	struct wmi_tlv_svc_rdy_ext_parse svc_rdy_ext = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH11K_WMI_SVC_RDY_EXT)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY_NONE;
+
 	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath11k_wmi_tlv_svc_rdy_ext_parse,
 				  &svc_rdy_ext);
@@ -5128,7 +5140,9 @@ static int ath11k_service_ready_ext_event(struct ath11k_base *ab,
 
 	ath11k_dbg(ab, ATH11K_DBG_WMI, "event service ready ext");
 
-	if (!test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
+	if (test_bit(WMI_TLV_SERVICE_EXT2_MSG, ab->wmi_ab.svc_map))
+		ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY_EXT2;
+	else
 		complete(&ab->wmi_ab.service_ready);
 
 	kfree(svc_rdy_ext.mac_phy_caps);
@@ -5180,6 +5194,11 @@ static int ath11k_service_ready_ext2_event(struct ath11k_base *ab,
 	struct wmi_tlv_svc_rdy_ext2_parse svc_rdy_ext2 = { };
 	int ret;
 
+	if (ab->wmi_ab.svc_rdy_next != ATH11K_WMI_SVC_RDY_EXT2)
+		return -EPROTO;
+
+	ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY_NONE;
+
 	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
 				  ath11k_wmi_tlv_svc_rdy_ext2_parse,
 				  &svc_rdy_ext2);
@@ -9315,6 +9334,7 @@ int ath11k_wmi_attach(struct ath11k_base *ab)
 	/* TODO: Init remaining wmi soc resources required */
 	init_completion(&ab->wmi_ab.service_ready);
 	init_completion(&ab->wmi_ab.unified_ready);
+	ab->wmi_ab.svc_rdy_next = ATH11K_WMI_SVC_RDY;
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b2dade0516ac..c69037c8a114 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -5849,6 +5849,13 @@ struct wmi_peer_sta_ps_state_chg_event {
 	u32 peer_ps_timestamp;
 } __packed;
 
+enum ath11k_wmi_svc_rdy {
+	ATH11K_WMI_SVC_RDY_NONE,
+	ATH11K_WMI_SVC_RDY,
+	ATH11K_WMI_SVC_RDY_EXT,
+	ATH11K_WMI_SVC_RDY_EXT2,
+};
+
 struct ath11k_wmi_base {
 	struct ath11k_base *ab;
 	struct ath11k_pdev_wmi wmi[MAX_RADIOS];
@@ -5857,6 +5864,8 @@ struct ath11k_wmi_base {
 
 	struct completion service_ready;
 	struct completion unified_ready;
+	/* Next service ready event this start accepts */
+	enum ath11k_wmi_svc_rdy svc_rdy_next;
 	DECLARE_BITMAP(svc_map, WMI_MAX_EXT2_SERVICE);
 	wait_queue_head_t tx_credits_wq;
 	u32 num_mem_chunks;

base-commit: b1ed5a45b994a6473ca1cf34f35a1bf87f1d8e2a
-- 
2.56.1

