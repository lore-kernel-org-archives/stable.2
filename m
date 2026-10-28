Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197383;
	b=WasiCSC2+hfyrDQA1KIC0kxy5T03Rssm6eVJYfWMPnmarBAf8uby2+t1xyMXp7VPlwYz
	 gNFghAnrmwtI8JSsZ0pGXytgo7ItogerTSn/ZPZhEcay2z5gYOKGXNCzsJRNtS+XABK0+
	 YZSgh/Z2d3VYtiiBAu9csyUA9Xn8U/q/qHMuzRcxtKEfF0vJr9qJS3PG3DpzE8eEWMJ/L
	 Jh/r1vc4nwtS6O+XR1wu+UitukDGzQc9bg8nrdAd0guLMwReOzk50WXFuHpc7O4SGj9Bw
	 17KXJjnoivB944wpim3sjUTWmaXX6sgrNp7WBlOaxHjFBawS7Jtd7odXPtQ0QFO3nTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2EjwqmUAG4LVpCIBaqLuA4imatC8t7BVaBsfJCHKdeI=;
	b=mkyCT4eehoUJ8tfT6OXWazbP8Uzd+AaiZ7JwFE3hbM5z6w7QPCFuAs2jQ2sc4fwFg3TB
	 TZFdm9+XPjOsXcip29/0gofjwfkXcXLeWqa5oMlr1JtqYr0+TGOpTB+2lJj9HFJkRTWkc
	 nsIUZhiQgWCBmC1qxzwvknrb4UWpiKPkQglRQ6Zez4PL7oClaxKKrc53WyoNL9qSM5PZ4
	 zoT6ysCtJBmJbTY8EiU1X6XjlZMO4LJMoK5zF6UDzvoo3Im2waiEdY59Iz7fRQo20uc2A
	 1cYomtcNINRx1G5cxUerGhotooo2wpzbthsVMB11ncIRWTsqen1FQui2OVA3HubDfbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTvJrCSC;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C853606A335
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C853606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WTvJrCSC
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a070755c8cso591838b3a.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793197382; x=1793802182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2EjwqmUAG4LVpCIBaqLuA4imatC8t7BVaBsfJCHKdeI=;
        b=WTvJrCSCS5fiZvdk5coryFKio7Svqrh5ARAM/N3GbSRvPoDa2woYMG7vyYstYCZplJ
         k7fS3rAuRu9410kE3ITExIHLH4rl1XVvrguUGqSgj3Cd5W6N5Y5qQuG/fqAleC+0g6oW
         YZy6UipYhbYzZNc8/ylnpQeTuDWnAu5ZIYCF3DTqz3RHiZB9eeO/TFKA3m4sNua0ST7z
         7b1TXpm2r+Yk6q/RwVrUlWxQp0BZ2WYpl5Qlw4JP1d0oAM9NZzqNWXyaW1kDY2/96A5F
         UJWBCD/nAwks0yEZwmYXf8G312w9vakk8UvlFDQldpGsq9RrlJlZ/xuFdNQTBSidRu8/
         dEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793197382; x=1793802182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2EjwqmUAG4LVpCIBaqLuA4imatC8t7BVaBsfJCHKdeI=;
        b=0912D0BFxenvR0E6xZfGUsXzVCzpgzEj2qx7IBW4G7tf5Kp2wk9ZHqRK8iLFQpaObG
         XOTZLAnIbcVXFXy2SqmtTHWPp+ZzVAGABKwGkKPfHhsu1jNUw+Cv29TxpudsrO08ULEv
         XSgATxvEcJohp/EynX2OXMC1sSojVGLb6aeGtcIRuWpXSgN4bl/pxdILvCBz7DR7Vjeo
         u/1CSHWiECJpsTWbBDrbzjcxE8dsn1HmnX9Q1b1ZeNWdkoDKv4htgAlAv3yNzvggq4mB
         STpnnKF5IKyYA5dlUx9WjYyP5jN798ohseGvLXwE/CfmrkSuc7eVJaJujaADdkvtRtRw
         WQtg==
X-Forwarded-Encrypted: i=1; AKwUvBwVCQ0BjO0IRHjjV+a1gfB+6upuTiU2JGVinQ4FTNT86aJXOrnHkMkIE8IXGqIkJhtQld6gRNA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTocW8pA6smudRwN6Qx9HOQGFG2B7J1FanN1XvadrBVPLU5FZb
	g7mbmwJxo+5jqxIWySe+wrHC2UFo05RZwzKiuW8xnMrT0QTwN6SaeROe
X-Gm-Gg: AYBFou2w6eYIt3TXp/OcCPMPiN2fcH3TRoOIm3604EonxKGfCygtFU8qRxojDbMebBP
	IjfTpMGMi11u4k6N4jnl9g0h192Fv1U45il1VogFrfa/sOony/amApEHRB4/LJvr0OWjxCvC0Xb
	U5KWZo9c2V2ggpqJgmPskwCpIFwgB5g0cQGoTjrP4olwk/mT41BWOEGH6gJU13gW4/4qq7OQqs3
	Lx5ZtodCE3DzMz789SA5H1lNirhJhp9ZBegi3s3eNl3LnDaRAmlUp5xGbHPzoEVzFKn6ffjyXvL
	ehzgmc6WyVg4jHXnj8jIxm2IzYH01qL1tQRAI8Y+RnMp5Al18U7V92sQaYf2vK8WhUk2HQxy/zb
	lZvL18X7NzQLwaUOXFO5kIBNQJjhxB4YeOR69ej2RXCu9LprX9UoAvunbD92ESq0tGYta34E7xG
	fW9NAdndInliYXnDVRdBmvmoasRI2GwjRHoWa3TkQOSy/pK0hGW49qlUq75lGqQVoPCxnIuzwUT
	iVNngH9cvVm7v7sg//PuqOU+Aw3t+kv33WpXAdOrEFy6JG9kL3p0/4iSfWtys5M6oYjy7gY2X9A
	RwfGQ9y/4/WBKLehuSFHCDRQuFDaO7AfYbUEN+DNRvqjO/ueCmdpkMXZcXH3n0azHB0L
X-Received: by 2002:a05:6a00:b56:b0:899:394d:2976 with SMTP id d2e1a72fcca58-8a6e78d158bmr1990970b3a.39.1793197381902;
        Wed, 28 Oct 2026 07:23:01 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a662ba00sm1245181b3a.23.2026.10.28.07.22.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 28 Oct 2026 07:23:01 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211: bound pending IBSS station allocations
Date: Wed, 28 Oct 2026 22:22:35 +0800
Message-ID: <20261028142235.15428-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028142235.15428-1-enderaoelyther@gmail.com>
References: <20261028142235.15428-1-enderaoelyther@gmail.com>
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

Delaying the IBSS station worker while frames arrive from new peers can
retain an unbounded number of station allocations.

The receive-side limit counts installed stations, while new allocations
wait on incomplete_stations until process context inserts them. The list
lock does not cover the interval between allocation and list insertion.

Reserve one of 128 pending slots per interface before allocation. Release
the reservation on allocation failure, after the worker inserts or frees
the station, and when disconnect frees the pending list.

LLM assistance was used to find the bug and review.

Fixes: 8bf11d8d0811 ("mac80211: delay IBSS station insertion")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation: A W=1 module build with MODPOST passed. In a QEMU
hwsim guest, a 2048-address flood left 293 IBSS stations before the series
and 128 after it, with no KASAN report. This is a resource bound, not a
memory-safety result. A reproducer is available on request.
Sparse C=2 passed. Targeted Smatch introduced no new diagnostics.

 net/mac80211/ibss.c        | 13 ++++++++++++-
 net/mac80211/ieee80211_i.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index bd7dbaa942fa..e7d69869772b 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -680,6 +680,7 @@ static void ieee80211_ibss_disconnect(struct ieee80211_sub_if_data *sdata)
 		spin_unlock_bh(&ifibss->incomplete_lock);
 
 		sta_info_free(local, sta);
+		atomic_dec(&ifibss->incomplete_sta_count);
 		spin_lock_bh(&ifibss->incomplete_lock);
 	}
 	spin_unlock_bh(&ifibss->incomplete_lock);
@@ -1173,9 +1174,18 @@ void ieee80211_ibss_rx_no_sta(struct ieee80211_sub_if_data *sdata,
 	band = chanctx_conf->def.chan->band;
 	rcu_read_unlock();
 
+	if (!atomic_add_unless(&ifibss->incomplete_sta_count, 1,
+			       IEEE80211_IBSS_MAX_STA_ENTRIES)) {
+		net_info_ratelimited("%s: No room for a new IBSS STA entry %pM\n",
+				     sdata->name, addr);
+		return;
+	}
+
 	sta = sta_info_alloc(sdata, addr, GFP_ATOMIC);
-	if (!sta)
+	if (!sta) {
+		atomic_dec(&ifibss->incomplete_sta_count);
 		return;
+	}
 
 	/* make sure mandatory rates are always added */
 	sband = local->hw.wiphy->bands[band];
@@ -1632,6 +1642,7 @@ void ieee80211_ibss_work(struct ieee80211_sub_if_data *sdata)
 			ieee80211_ibss_finish_sta(sta);
 			rcu_read_unlock();
 		}
+		atomic_dec(&ifibss->incomplete_sta_count);
 		spin_lock_bh(&ifibss->incomplete_lock);
 	}
 	spin_unlock_bh(&ifibss->incomplete_lock);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 9374c2942489..cc0d02ca56eb 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -682,6 +682,7 @@ struct ieee80211_if_ibss {
 
 	spinlock_t incomplete_lock;
 	struct list_head incomplete_stations;
+	atomic_t incomplete_sta_count;
 
 	enum {
 		IEEE80211_IBSS_MLME_SEARCH,
-- 
2.56.0

