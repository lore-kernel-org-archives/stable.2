Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3121C4DD3AB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580089; cv=none; b=AVt7iJiZg9T1iGX39a1PTk2fWiGeY+cc8QWwq/ozyPQxcr3fzX+a1LU1y5Ye00bfpiH3qLJNG7MOw86SVy4sqMAfFPIa/GbkKrbmujdMpY6FRZqztFEt2rHDov+VWNT/q1reJsIwPJD1bgZodmuBcnNNA3ULHKPKbKlQ61Tp3OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580089; c=relaxed/simple;
	bh=ghaLQhsjErRuw7z0EbmTWSMQtRPaLPRGjjmIhiMeksM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZxAN0ecblD4fEEpvmW0djkc+X6V1eZ5SwoUkD+tyYhP3ggLs2CwqUVBpKdSWdopCKJmVixYydtmuXXljsspSbKftQeIEnVx1QReieLEBf09zuaGnQWfgvMgYL/T2UumvL6LCzJ2BwDIEPOYetsjVK/lodxo7uKtsJZOWpCEaupc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvGRz5r4; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvGRz5r4"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c3so883919f8f.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580080; x=1790184880; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w65kxI0NVO+6JXj4YPaYmqJGny/IamxZxDoeb93T3ro=;
        b=YvGRz5r4skKFjGn+VPbLzIIJHKluXbJn8oeVovguT6l160/YI+S372+BL1ZWluNCsF
         Dl8Jn0Z/NQV/Fd7hMnuoGfy7rNi2ueoZWk67NTGajFxa/ZuPBzKysCuavDA6jANDdy9g
         YzfflkCnIKQ8FW0byjMQCHTRW/BoVXv8/7npmyEyeSxM1nidHa//ploxa3U2Y4hJmkno
         TCK+B1r9sxmFvhjvuQwtH3vGTQPDdyet0ClQlTZjEbMcli+XmRdy+rs1PVXRMl8/7MSl
         hkIo0saWuTfLWejxjAgWRV5PakFPQ10Im3CxPJSZ3/ILN/GkXFIjhnJzwP8telP6V4Ke
         5HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580080; x=1790184880;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w65kxI0NVO+6JXj4YPaYmqJGny/IamxZxDoeb93T3ro=;
        b=Imf+fzIQQd9cvELAKEHdD4zvzdCMt6IZLTft5kCU6YSbybYwkm30VYE+/7G8GnZUFz
         neoBJJJOY++geHDYQe5VNd8w+NtvCQ99cMqDX4boNjhOFl+d2/MluOg3nWWqNQNKgP2L
         LxAmqfCpNEvtbWf9LEDl/xI0acWFm4M7Guxe8d+TGVV5JbGygItrHdzjpwJPX5LVbya7
         xyqbiWFFoJ4Xj2L71QlATPsNtS+G0J9V3Y0SzIePNX+c3TjTQOhZjlSzsg7EwCNruI5M
         9xUJ6bLd0nl6ngSLfL0JCWW45diqSpS3g4GkxZ3EOr78H6EW+E24DuvKWORYwlV8O0Lt
         V7pg==
X-Forwarded-Encrypted: i=1; AKwUvBz82O5Mt7veSxUi5mGExmiOznfa0iN/cti6iL3VwdKSx3GSmySZ30kamiRW8FSqKjqugAuk3/8=@vger.kernel.org
X-Gm-Message-State: AFuF++l4Bm78sSYIBWs+a+TQ8mcPU116IwbhyMA7rywf7RIVuVczS6pl
	JwY90rEr+eU5w3nbqMCZUu4mSHRuMNGBjoE3SoSSZ4xOc+6GW+DSo4g=
X-Gm-Gg: AYBFou0xZEmFhM1SiCWt64HgccYvO6uoCO5sXkMh4UJufWTmj9hjBxDIpxc4aLaQ+NI
	QT9iyJghG97CiqhPSXqRV4y6EMC1Pm9sjP6k8psqbYyqu0lSFqBmZUZFwl+ngwTMZOXk6iNHRoU
	w8CTIL5NRr7MmGF5bu9o/SJoHqUvI87F2jaRWjwggOHKJ0EFuh4bScIc89oYWsoxYxTezxPXwht
	YNaulCtQyYFilf3J3N47CUtJ0+/04PQR6SgGOKnVbNNvmL8ccw+9bNgglV2mqxBXMn4IgPQpw9s
	UAuoR9nEBoIQGrHUlQ5SZ/KlS9O0TNOL0inco6g/gv4wzM1ow+hQC42lEdFpbWo9BHcJCI2IlQG
	GtsNNWloS0h3n8WSPw5RyI3imQaflttn51qyKU2Bp1wLFUMHLGm5H6qYZvaGtuXz+TOdeWDpf/S
	q2Z6lzJlmYbtvL8WsdOY35uQ8ypHxC2TKdTR61E0noQ6wXYT9OaoYN+Kkele7/pDy4WdhLZ4X7K
	JMo/gPKz8jcQ6BS04aaF5VxaKzCfAQ4BcCcBwlkrW/aFLzfyrzKEU0JuLWiqNvF7HMqpEVabvR9
	bNMNXvOhLrKNqP2I
X-Received: by 2002:a05:6000:4b1c:b0:487:c99:8bec with SMTP id ffacd0b85a97d-4870cf0a430mr4310836f8f.3.1789580079562;
        Wed, 16 Sep 2026 10:34:39 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:39 -0700 (PDT)
Sender: N B <gen.benner@gmail.com>
From: =?UTF-8?q?Nerijus=20Bend=C5=BEi=C5=ABnas?= <nerijus.bendziunas@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"John W . Linville" <linville@tuxdriver.com>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Oleksij Rempel <linux@rempel-privat.de>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH ath-next v4 5/8] wifi: ath9k: clear the PHY error filter when a spectral scan is disabled
Date: Wed, 16 Sep 2026 20:34:26 +0300
Message-ID: <20260916173429.403889-6-nerijus.bendziunas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
References: <20260916173429.403889-1-nerijus.bendziunas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Triggering a spectral scan sets the PHY error bits in AR_RX_FILTER and
AR_PHY_ERR and sets AR_RXCFG_ZLFDMA; disabling it clears none of them.
ath9k_htc carries the hardware bits into every later filter update, so
an idle device keeps forwarding every PHY error as a zero-length frame.

Clear all three when the scan is disabled, unless radar detection is
enabled and needs the same bits. AR_RXCFG_ZLFDMA must go too, or the
frames keep coming.

Fixes: e93d083f42a1 ("ath9k: add spectral scan feature")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 .../net/wireless/ath/ath9k/common-spectral.c  |  5 ++++
 drivers/net/wireless/ath/ath9k/hw.c           | 23 +++++++++++++++++++
 drivers/net/wireless/ath/ath9k/hw.h           |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 73c1eb4ebe0e..24000d5b2a6f 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -776,6 +776,11 @@ int ath9k_cmn_spectral_scan_config(struct ath_common *common,
 
 	ath_ps_ops(common)->wakeup(common);
 	ath9k_hw_ops(ah)->spectral_scan_config(ah, &spec_priv->spec_config);
+
+	if (spectral_mode == SPECTRAL_DISABLED &&
+	    !common->hw->conf.radar_enabled)
+		ath9k_hw_disable_rxfilter(ah, ATH9K_RX_FILTER_PHYRADAR |
+					      ATH9K_RX_FILTER_PHYERR);
 	ath_ps_ops(common)->restore(common);
 
 	spec_priv->spectral_mode = spectral_mode;
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 7cafd6c5870f..b8f3a8afaeb3 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -2928,6 +2928,29 @@ void ath9k_hw_enable_rxfilter(struct ath_hw *ah, u32 bits)
 }
 EXPORT_SYMBOL(ath9k_hw_enable_rxfilter);
 
+/**
+ * ath9k_hw_disable_rxfilter() - clear RX filter bits without a driver-side read
+ * @ah: the atheros hardware data structure
+ * @bits: ATH9K_RX_FILTER_* bits to clear
+ */
+void ath9k_hw_disable_rxfilter(struct ath_hw *ah, u32 bits)
+{
+	u32 phybits = 0;
+
+	if (bits & ATH9K_RX_FILTER_PHYRADAR)
+		phybits |= AR_PHY_ERR_RADAR;
+	if (bits & ATH9K_RX_FILTER_PHYERR)
+		phybits |= AR_PHY_ERR_OFDM_TIMING | AR_PHY_ERR_CCK_TIMING;
+
+	REG_CLR_BIT(ah, AR_RX_FILTER, bits);
+
+	if (phybits) {
+		REG_CLR_BIT(ah, AR_PHY_ERR, phybits);
+		REG_CLR_BIT(ah, AR_RXCFG, AR_RXCFG_ZLFDMA);
+	}
+}
+EXPORT_SYMBOL(ath9k_hw_disable_rxfilter);
+
 bool ath9k_hw_phy_disable(struct ath_hw *ah)
 {
 	if (ath9k_hw_mci_is_enabled(ah))
diff --git a/drivers/net/wireless/ath/ath9k/hw.h b/drivers/net/wireless/ath/ath9k/hw.h
index f102f73a0114..983146208f26 100644
--- a/drivers/net/wireless/ath/ath9k/hw.h
+++ b/drivers/net/wireless/ath/ath9k/hw.h
@@ -1056,6 +1056,7 @@ void ath9k_hw_get_channel_centers(struct ath_hw *ah,
 u32 ath9k_hw_getrxfilter(struct ath_hw *ah);
 void ath9k_hw_setrxfilter(struct ath_hw *ah, u32 bits);
 void ath9k_hw_enable_rxfilter(struct ath_hw *ah, u32 bits);
+void ath9k_hw_disable_rxfilter(struct ath_hw *ah, u32 bits);
 bool ath9k_hw_phy_disable(struct ath_hw *ah);
 bool ath9k_hw_disable(struct ath_hw *ah);
 void ath9k_hw_set_txpowerlimit(struct ath_hw *ah, u32 limit, bool test);
-- 
2.55.0

