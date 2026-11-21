Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278995;
	b=wURbx2lrVL3+lDRfoMougSy3NeRR8wsoV3ecG3RK097tRyPShxGb68C+Wdvj8+LuEgY9
	 XupPs94qyiKy6sjDW5mSrrLDsXLD4y0RUdAIyZ5SoZhdbtl68icKNCAle/rSn1X46Kkvs
	 X+lt+zjyyBTPRN7OJUeOooesPj2qD5v7E4gPsq3pBL4m5oemttSarNznH4j/0i7cvi/GU
	 GJ09WH1dYAI3/8z0OCAQq4YwNFIAPQKV1fKpGpsr45hi36MhvpLliJ+bYIlnYHemb6uQw
	 h8iXt2UVS/1sQJ2gyA17EZTzv4kG43PrONb5WLhz+QJiGZbDTz7XjYnHqGBmobnBHJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7DeVTuQrYsASnJ+ymnmCnAG2Ji9/l6ci1SThhWZ6G6s=;
	b=RJmnus70ox1VF9aG0ZomkW/tRr5PSj60PvIhf74m9MqCH1hCoD11V3pqRFDgVoHr3rZn
	 yNX9khAH4AhIp1S9HYP/vTtkXu9GBX4rs/nExJSWkC0gwLFEBz6Gd9taNby5R9l8QCdYT
	 0WYy88a0GZw+B6JGELRTkuBa9golMpfyPg+bE7tbxzBG+1LoJ307cDieE016YbZ4fJVr/
	 HhXbvj3ST3WczdTvg0hNpq3rUC76xZlsvfrDgqyOZEmufOfNaJN14xTXkqt+t/LE/ib7C
	 VjaBB5ebFDvjJ4ttvZVpT+vhPKFa5xhLNkfonXmo4F8JMFjg3VFfmroHLX2+PkRpmDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEwVr+HS;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981F9606A33B
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 981F9606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEwVr+HS
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb2893531bso1091039a12.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795278994; x=1795883794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7DeVTuQrYsASnJ+ymnmCnAG2Ji9/l6ci1SThhWZ6G6s=;
        b=dEwVr+HSExkMLBvHFfNA74Q/D0EPIuEXkbx7gYIS+Lv21hLambcZQucOVyr+NOdvec
         DcGyLvEPSAus6Vkdbehg9v+we0k1gWzdUTm3mq/MIZSjprEhxtzKsB14yL0ZPJ2W+U/c
         19J8NSZG033JpeCkTkNd/7CsKJZM0uQXNupgw0lHpIK2/6+ktW8N7jp2T2A4ynHwwvuS
         WQ3WdRIz48hbv5MxB2DpmzA/aj1k1TXbRGMM8yZaY0gEFGGVIszQHgpBdJ9XQknhzCb8
         sTIY0sfkYGN90gwXLXwFkNBFd7Z4Pn3U2g60sxBpeLGMbRFfVdhWgJ/vbMnJ4BnQ6tHR
         5OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795278994; x=1795883794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7DeVTuQrYsASnJ+ymnmCnAG2Ji9/l6ci1SThhWZ6G6s=;
        b=eZ+t+TnOKkqZon6mHYrVRIatlgRU4CupnKlBSphY0QI6fOR924wZLYFzQ1fsUTA0Tw
         A2XjmkSQVMpCNxny/fXZ+qgoYyO/c5vPStpu4M1zMXUklspMyTUHqtLwvEY+X3sAc+Vb
         ZcGZ35npuIEEJWCcynHV3QQQi1wnLtFFEb6OzZS6zkQ0TevQsLRgby/b2m8qLni77nRm
         pN1LDcl60/oU0O25uPVcd1mXukb3j0AWda9Oshp+03RvhgPuZFjcPcAjO2PS8wIu2jYW
         yTS8FJR6gGHBFenESbKgfaIh5c26xsVEdCl49oVbfg10zfXb3bW57+c6hgdr3bkww77L
         DmEQ==
X-Forwarded-Encrypted: i=1; AL+hErFOZdsVXXxM2sRXRC2g5M1GmKH9IdNvq/Y2kVUOD7WdV7Q7RyX5FDr0t/mU0AC6qhh6ZJDwJUM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zbowAOu+UXAuvPKsiPk58sFYplGxiG8u9nWTtQncXp/KbO9l5
	imvwGOy+rh1XPmxKVjN8amQgHn0CLxs7b/GRC7duUfNpMu1n7drTeZ9m
X-Gm-Gg: AZFdTZdJ6iAhK/h4oXqAWCM7vHLJh3PhEaQo4F5N007O0CH2w4QfvEd1lhMMyv5ip8e
	LG4jIb5aXiLmztZe4V6EZZ5cyBpkzI40b90614t430PNvXLpAJ8tCePyqN+apif0HCBJlLLnSHH
	jF3hY/wkKYI8NxN6m63Z1yinFjnVAO5LTVRY/h/HwKrJAxBbmAW8OX8J5lSyE1+KN+/QA4s7NuC
	zTfDAWO3tduC+1Amrz2AhqBUd7BalnQspDXUSVqwvx0K7jgdFIWh8r3K1rfJEeQMvAwueiEXRcy
	kQCeEbx4/pILCOxTii3G1SM63Xz7UU91JQ9pCnR90AwkGCSPwYNAeyGejgDaUa9+J6EhzWe+7v/
	tRyYUGwXAX7CuY/6f06yrlvzkUtGdeRWCHbgeS/PC+BzQN6eOO0aap6hHsMgG3b7czL0kIXt5Vm
	d3RHGyC24jB0+9h5l+MQMipFyIOjTHeW4+9XRrhHDcT9LliRvPsgiT/T3DnuCAMKErddcA2wNjr
	GvMY1zSMJp/SMizrkaJMstje6pw0lSTxcTwcYoe9UMN+47WzVSRzA85m36ROTG/f+BBhJ+8owKw
	KVDHr+KYbafqoN/y9yaGp0CwlLR1U/3PqCEK9w+isijHbRlWaE+xdQ+KBIf5JuyYSVDUYgvFrg4
	SNX/V
X-Received: by 2002:a17:90a:e705:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3b41c7e118emr6541664a91.5.1795278993908;
        Sat, 21 Nov 2026 08:36:33 -0800 (PST)
Received: from G7XWH7K1F3 ([2408:8256:2e80:7371:8549:3fe7:526f:af9])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d11753sm12357403a91.5.2026.11.21.08.36.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 08:36:33 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Hemanth Selam <hemanth.selam@gmail.com>,
	Morning Star <alexbestoso@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: [PATCH rtw-next 2/3] wifi: rtlwifi: rtl8192se: don't mark unencrypted frames as decrypted
Date: Sun, 22 Nov 2026 00:35:46 +0800
Message-ID: <20261121163547.37019-3-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261121163547.37019-1-enderaoelyther@gmail.com>
References: <20261121163547.37019-1-enderaoelyther@gmail.com>
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

The receive descriptor's SWDEC bit is set when a frame still needs
software decryption. It is also clear for a frame that was never
encrypted. rtl92se_rx_query_desc() nevertheless sets RX_FLAG_DECRYPTED
for every frame with SWDEC clear except a protected robust management
frame, including unprotected data and management frames.

mac80211 then accepts an unprotected unicast data frame although a
pairwise key is installed, because ieee80211_drop_unencrypted() passes
frames marked as decrypted, and it accepts unprotected deauthentication
and disassociation frames on a connection that uses management frame
protection. A station in radio range can therefore inject plaintext
data into an encrypted connection, or end a protected one, by spoofing
the peer's address.

Set the flag only for a protected frame that is not a robust management
frame, as the rtl8188ee, rtl8192ee, rtl8723ae, rtl8723be and rtl8821ae
drivers do. rtw88 dropped the same assumption in commit 0649ff58a0f6
("rtw88: Don't set RX_FLAG_DECRYPTED if packet has no encryption").

Found by code review. Compile-tested with W=1.

Fixes: 84f494cef7d9 ("rtlwifi: rtl8192se: Merge TX and RX routines")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
No new W=1, sparse or smatch warnings.

834fc28d7880 (7.4-rc1) fixed "managment" in the comment this patch removes;
with the old spelling in the removed lines it applies to 5.10.y through 7.3.y.

AI assistance was used.

 .../net/wireless/realtek/rtlwifi/rtl8192se/trx.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
index b057d035a3a8..663f7a5fc070 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192se/trx.c
@@ -274,22 +274,16 @@ bool rtl92se_rx_query_desc(struct ieee80211_hw *hw, struct rtl_stats *stats,
 
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 
-	/* hw will set stats->decrypted true, if it finds the
-	 * frame is open data frame or mgmt frame,
-	 * hw will not decrypt robust management frame
-	 * for IEEE80211w but still set stats->decrypted
-	 * true, so here we should set it back to undecrypted
-	 * for IEEE80211w frame, and mac80211 sw will help
-	 * to decrypt it */
+	/* SWDEC is clear for plaintext too; mac80211 decrypts robust mgmt */
 	if (stats->decrypted) {
 		hdr = (struct ieee80211_hdr *)(skb->data +
 		       stats->rx_drvinfo_size + stats->rx_bufshift);
 
-		if ((_ieee80211_is_robust_mgmt_frame(hdr)) &&
-			(ieee80211_has_protected(hdr->frame_control)))
-			rx_status->flag &= ~RX_FLAG_DECRYPTED;
-		else
+		if (ieee80211_has_protected(hdr->frame_control) &&
+		    !_ieee80211_is_robust_mgmt_frame(hdr))
 			rx_status->flag |= RX_FLAG_DECRYPTED;
+		else
+			rx_status->flag &= ~RX_FLAG_DECRYPTED;
 	}
 
 	rx_status->rate_idx = rtlwifi_rate_mapping(hw, stats->is_ht,
-- 
2.56.1

