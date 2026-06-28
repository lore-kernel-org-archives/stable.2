Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1397034CDD
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782606346; cv=none; b=REQItUS8G7g35u92lAmt5qYu35yjg70QJYklJUnRSSjurkdQKx5ZcYZKuPuZf57UD/QWOyNo3Jx7FkR+rglLwlaBZjg4tGJfCbPi8GaSPIguBIa5GTSrWfB/YWksHxb6uJKUNOWBbJcn+arLFYaTCogpIjz6jBKSQznFXAOSlGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782606346; c=relaxed/simple;
	bh=Gp9heeZl8YOVXLS81sRHuvkbEUIKeicfYWTiUjTKSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgMZRDwileaG4fQQkeJolIZGfnWyJwuv43Bu1JxwMvSIhd9b/LYt5wL8hXCMJ4agtMVDlS+o476Gzb36AlnwBrs+t4XxLB2nDBkzrpFSXLWJvMeoBWxCCbwOg5rw3MnXONHzU57z9mIczRtnBmc7xnMcaNwMlY24GI9Wu8w6U6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yy5/MvoO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yy5/MvoO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15547425e9.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782606343; x=1783211143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+ggCHBmTIi4iroEDf3wYeBaqmZKkqX7ae5VYLvC2Dk=;
        b=Yy5/MvoOFUCHwQQi3KX9W+0IZlV5baCQ2HyMk8lARPWRP2fkJZsbAMDKPLnEJAb1s+
         O/JBp10mly4ZQR801vCxhpgstqA+uOys8Tz4rQQuFkuEojiNGsIYBnhnKF/JoYvP0BfM
         x9t1JlN/DeX8oXXdg2H4C6qyuJbXrfqfkWfJEEfIx2c+V6VgjWB7mmvoSziKXefekkue
         IcOFSJwJF2T1MpC7Ol8UFb3VSIwFI3ihxnE1ggSs5YB/YDDJ8n4c16ZUS+/5sv5LmBsz
         vAh8iu5MMKQVHEUDuRcjeiTmQ9yckZBbhDHYMSomD2Wq6/l/gZE0HBQjXSiwcNTtWe6m
         rNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782606343; x=1783211143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+ggCHBmTIi4iroEDf3wYeBaqmZKkqX7ae5VYLvC2Dk=;
        b=hZGqK9q82J00Llb+wDzJT69ehQrN1avxKbj/p4pA/nRfvsL4Wv2h6EV752ZIJ70OcK
         C0phNiNh5GWBT0M/aoVRdLs9rYCZD3YSG5JnEPTJPOcqc4FW9aGZrMtwI7gv5N9tuG3N
         UA6ggKVmuSzVugOcQ3+umbTXiOh/Ci7j2jn9YuWn99L5faSgBP2kE4oVrR/qmXYwFIsd
         eG03TSimSmYKsKSdZ48BiG1HLIwVjhCE83JzelrVkTHVrmiHnq8W0t7dUYhePBj80ztB
         GnR3ZjgBtyDNDBt08cyE45yKcMsydqzbeZDyCNN0gfZ5NjoWDJTx19lbGn7iA32vEDHs
         jsaQ==
X-Forwarded-Encrypted: i=1; AFNElJ/NKTQn3Mbmy0qzZeZr9R1XriNKh/RQevo609qzb7Oy4A33vczlQGvPhWzkOhoZtCyqnv95u18=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcCk9Vg/JsyeehxzPTI5MTNa+UQ/VZU1ifZyY+JcQ3e/U83Enn
	7M2/r+ofIkp6hl9yThiH9JfyAJnvlZIyYCkag/EYMGrxg5NymnWP/zae
X-Gm-Gg: AfdE7cky12uI42KUR+z7oKMt+r+vKHkr6YV80S7Le/nNZi+AaFKN4+iOYoM0yEKITXY
	SiXpMSE/qRAeSO8wcCG94VtfPkWLNR2fSOSx0MQNAAP59jxlH+B6mCpT9ZkXHLEbhx0rny0aDUU
	KboxRrXhVpgfBH6F+M3oOC4056IMCocJ6jNF7JgTwWuQxBHa/SYBI8sjii9F8i47LmqKkd3Fsy2
	cuz02C2BNYmlqmsBCQWLS0A1oSIUfMqYRUi+/UoD49PHtXtftZGolyDpla6cC9ezJNkohexw84y
	C0u3i2AGH30U/vxmIVd1h5Wg+srvlRnjadhNCWfDOLmzqMurtJ9VxoCtL44oYRHZF2eoNbApXt3
	Vv/JIGU/+xaq7Il0DQ4FpmZb0Sw9LpqhOBsfgq3IZIMOxAUKaE2IHuw83RNTZ5FSVbsjeOq42Tr
	HwjanDoT7waii74LPawVzYP5YJUA==
X-Received: by 2002:a05:600c:6792:b0:492:7187:aa67 with SMTP id 5b1f17b1804b1-4927187aa7dmr68432665e9.30.1782606343532;
        Sat, 27 Jun 2026 17:25:43 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926f94f213sm145611055e9.12.2026.06.27.17.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:25:43 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	stable@vger.kernel.org,
	syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] wifi: mac80211_hwsim: avoid treating MCS as legacy rate index
Date: Sun, 28 Jun 2026 02:25:37 +0200
Message-ID: <20260628002537.23550-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Injected HT and VHT rates store an MCS value in rates[0].idx rather
than an index into the legacy bitrate table. hwsim nevertheless passes
these rates to ieee80211_get_tx_rate() while generating monitor frames
and timestamps.

A crafted injected frame can therefore read beyond the bitrate table.
If the resulting bitrate is zero, mac80211_hwsim_write_tsf() also
divides by zero, as observed by syzbot.

Use ieee80211_get_tx_rate() only for legacy rates. The existing fallback
continues to supply a conservative bitrate where hwsim does not yet
calculate MCS rates.

Fixes: e75129031f1c ("wifi: mac80211_hwsim: move timestamp writing later in the datapath")
Reported-by: syzbot+21629c14aa749636db9d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=21629c14aa749636db9d
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 .../net/wireless/virtual/mac80211_hwsim_main.c    | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim_main.c b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
index 0dd8a6c85953..4a66272526f3 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim_main.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim_main.c
@@ -1324,6 +1324,17 @@ static void mac80211_hwsim_set_tsf(struct ieee80211_hw *hw,
 	}
 }
 
+static struct ieee80211_rate *
+mac80211_hwsim_get_tx_rate(struct ieee80211_hw *hw,
+			   struct ieee80211_tx_info *info)
+{
+	if (info->control.rates[0].flags &
+	    (IEEE80211_TX_RC_MCS | IEEE80211_TX_RC_VHT_MCS))
+		return NULL;
+
+	return ieee80211_get_tx_rate(hw, info);
+}
+
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 				      struct sk_buff *tx_skb,
 				      struct ieee80211_channel *chan)
@@ -1333,7 +1344,7 @@ static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
 	struct hwsim_radiotap_hdr *hdr;
 	u16 flags, bitrate;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_skb);
-	struct ieee80211_rate *txrate = ieee80211_get_tx_rate(hw, info);
+	struct ieee80211_rate *txrate = mac80211_hwsim_get_tx_rate(hw, info);
 
 	if (!txrate)
 		bitrate = 0;
@@ -1603,7 +1614,7 @@ static void mac80211_hwsim_write_tsf(struct mac80211_hwsim_data *data,
 
 	spin_lock_bh(&data->tsf_offset_lock);
 
-	txrate = ieee80211_get_tx_rate(data->hw, info);
+	txrate = mac80211_hwsim_get_tx_rate(data->hw, info);
 	if (txrate)
 		bitrate = txrate->bitrate;
 
-- 
2.54.0

