Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222604CEE4E
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580095; cv=none; b=DGbsbIJTmLsmRTNrM71OQ+mFmZx7F0yi0sV/7vRsE1ARBZZiKKUt95k7uQYdTRTtIlnU5WoQr98DQ+0O7Nma1ln7SY87YBplbaEjtoR2qoLvfyEC3WFVQNddwBeZetN5ql0kIRC5tM/2E374pDhPf+KjpRU5BZqWKUNrmEe4gxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580095; c=relaxed/simple;
	bh=fSGL1mOOCyTsYa09zn/uR5Z/XbG5GF80+DVedQRCVh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LGGyxogVtfP9qIdZ0aMCaXl0g8K0dag2DEi5ZBB96qLTdo4rY8moX7EieGUZSxeVA0SgY9puXpCx06lhE+kwINkk3dNdEsls+hQClzGA0PjdnB/iFtw06sKT2BBEY8ZY1Ngzz3EB461gX2Rud9MsbqCO4wJHEFkYHE6E57vI36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mcFolMZ3; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcFolMZ3"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f63546c5so864510f8f.2
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580081; x=1790184881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=A8rQM1SCspNmiwKjpWc6vCGmypeC9LKlk/ALZbiEucg=;
        b=mcFolMZ3PNHbruBKUBnGOfYcwWvX2Ltd6zW7a9rfq+4Suq+C1WAai9XW4b4YC2yhwk
         VGz3j9l7MZDBBX8dLk6tlou4jr/nkrWvssL56dJW5F7J4KL2PN/DFuOjQnUK4zfX5Qe5
         moij6/Sh0YXe3fK6aPdvb9kB7RlbPh9NgudpRKPyRDtaiDzz0S6yOU1DVvjUnxXyDqxE
         kjlaqXsHxpRpRQrBiFNW+NbDula84cnrdISQi1MJX4qeAhOeyq0eWHxoCv0vMTg69upb
         NfSkSWmovw90ppbIT9N7Cjjut3l1ZCsLtqc90mC0xkwQI6h69+AzOGL6lyaRDZXXr73i
         s9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580081; x=1790184881;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A8rQM1SCspNmiwKjpWc6vCGmypeC9LKlk/ALZbiEucg=;
        b=AoLodayL2QvAivGHxmrUFYtqeSy5SUajRxaFhc1vpBjCkNOZLBfeat+/GTc8SO3+Tf
         iuShlIEtJnsHPVGLHfquc0Mgg/JbUHeefJc/N+nOF40+r5ypY3Odh2DSKeSZ3blTGfwy
         regBm6gpyQiPT3TMF3OFCfNvWaFMFXExGtk6dvufYhJ6HiNbrcR7LgoJkck/8MXtr96I
         0vIDOKgV8xNORvyVjl+QFxcEM+zBTXEoAlZ7PcvpeeonNGY5B5I9NISYwu1r2M6SxTAl
         2pJoSOQSjggp9Ok1awgF4Z0GAVYmd7Ge8gTnCv8xA8KZVLdPyI91h7i41wc/brV/k5ks
         jLOA==
X-Forwarded-Encrypted: i=1; AKwUvBy6hUF18GtUv9ms34HbzCR9WoGurTMZ0z4A27TW/fA9xhZhc8Rq87V9SO/PPXB4cu7U1yT00xw=@vger.kernel.org
X-Gm-Message-State: AFuF++k2ei8IARshqUa4oZwmKKRInm6U9wzULstBNzxo5A5W3F+0GnWP
	cnTg7ZUPMYw34bEUqiEXjOZlk8E9rUNqSQfAHQ0AYUnYtweXICWTTW8=
X-Gm-Gg: AYBFou1sXiLOrhcskHiaz0bWV07MFuMH+ZJAFPwoRBN9RwRajJFk7DZPmJAtMH0fJ+s
	FfFdR3A0WKuEqrr4bUhC4/LcF/xVG29Fcprs34DomJnYl/iVXhQu6RjumTe1iuoNu/oxy2jWcAK
	Y1VjOR1HYcB6WrlkEE8pP8YcQ9MDkB+gFQV4VfCGNpcpqmj1irO9GaT2wLlN5bJvkr199+gVUP/
	/XGd0nxZIG51IEps8qQFqX+/2ICAOIXFCGvuFLllda1ZK5dKKNV96XqvFM7U0BtlTm+MlelnXpT
	QuZ0AqjAcCMkPJzlGjjjXDe4QeeuUe/93r0kL9fzkvRuphUsU9inGh3FEnnE6lXtWVM6j+F0Lkg
	/1OtUXOWCO0H33UphBpiLKzgW2pe/MLbsoyPRiwZjoZjCGK5P1prpRBwIk3cMsz3a0mKwq9HCCo
	lUyVptLj1HzfGq9cpSgU0S8BtX+W2Dho4H2vnFq59Bn+SmHv292R48YcBEHOpKVROLt2eMtGDH/
	43zjx3GH1Ce/lX4he68JPBkCpTnxP6759AnzfL0nKxQfbzkaYRsSWlYZ+W39nWzMOqXKMfsfGYR
	A32PCBhAa4N4U4o=
X-Received: by 2002:a05:6000:4b1c:b0:487:b44:a561 with SMTP id ffacd0b85a97d-4870cf0a3aamr4317108f8f.10.1789580080711;
        Wed, 16 Sep 2026 10:34:40 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:40 -0700 (PDT)
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
Subject: [PATCH ath-next v4 6/8] wifi: ath9k: count spectral samples in the driver's own RX stats
Date: Wed, 16 Sep 2026 20:34:27 +0300
Message-ID: <20260916173429.403889-7-nerijus.bendziunas@gmail.com>
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

ath_cmn_process_fft() is shared by ath9k and ath9k_htc, but it casts
common->priv to struct ath_softc to reach the rx_spectral_sample_good
and rx_spectral_sample_err counters. On ath9k_htc common->priv is a
struct ath9k_htc_priv, a much smaller structure, and with
CONFIG_ATH9K_DEBUGFS the increment lands far past the end of that
allocation, once per FFT sample.

Store a pointer to the driver's struct ath_rx_stats in struct
ath_spec_scan_priv and count through it. Both drivers pass their own
stats to ath9k_cmn_spectral_init_debug(), and both print them in the
shared recv debugfs file, so the two counters now also work on
ath9k_htc. Without debugfs the pointer stays NULL and nothing is
counted, as before.

Fixes: 03224678c013 ("ath9k: add counters for good and errorneous FFT/spectral frames")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 .../net/wireless/ath/ath9k/common-spectral.c  | 29 ++++++++++++-------
 .../net/wireless/ath/ath9k/common-spectral.h  | 10 +++++--
 drivers/net/wireless/ath/ath9k/debug.c        |  3 +-
 .../net/wireless/ath/ath9k/htc_drv_debug.c    |  3 +-
 4 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 24000d5b2a6f..44b5a5bbe74a 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -465,6 +465,20 @@ ath_cmn_is_fft_buf_full(struct ath_spec_scan_priv *spec_priv)
 		return 0;
 }
 
+static void ath_cmn_count_fft_sample(struct ath_spec_scan_priv *spec_priv,
+				     int ret)
+{
+	struct ath_rx_stats *rx_stats = spec_priv->rx_stats;
+
+	if (!rx_stats)
+		return;
+
+	if (ret == 0)
+		rx_stats->rx_spectral_sample_good++;
+	else
+		rx_stats->rx_spectral_sample_err++;
+}
+
 /* returns 1 if this was a spectral frame, even if not handled. */
 int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_hdr *hdr,
 		    struct ath_rx_status *rs, u64 tsf)
@@ -472,7 +486,6 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 	u8 sample_buf[SPECTRAL_SAMPLE_MAX_LEN] = {0};
 	struct ath_hw *ah = spec_priv->ah;
 	struct ath_common *common = ath9k_hw_common(spec_priv->ah);
-	struct ath_softc *sc = common->priv;
 	u8 num_bins, *vdata = (u8 *)hdr;
 	struct ath_radar_info *radar_info;
 	int len = rs->rs_datalen;
@@ -624,10 +637,7 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 				ret = fft_handler(rs, spec_priv, sample_buf,
 						  tsf, freq, chan_type);
 
-				if (ret == 0)
-					RX_STAT_INC(sc, rx_spectral_sample_good);
-				else
-					RX_STAT_INC(sc, rx_spectral_sample_err);
+				ath_cmn_count_fft_sample(spec_priv, ret);
 
 				/* Mix the received bins to the /dev/random
 				 * pool
@@ -642,10 +652,7 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 				ret = fft_handler(rs, spec_priv, sample_start,
 						  tsf, freq, chan_type);
 
-				if (ret == 0)
-					RX_STAT_INC(sc, rx_spectral_sample_good);
-				else
-					RX_STAT_INC(sc, rx_spectral_sample_err);
+				ath_cmn_count_fft_sample(spec_priv, ret);
 
 				/* Mix the received bins to the /dev/random
 				 * pool
@@ -1054,8 +1061,10 @@ void ath9k_cmn_spectral_deinit_debug(struct ath_spec_scan_priv *spec_priv)
 EXPORT_SYMBOL(ath9k_cmn_spectral_deinit_debug);
 
 void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
-				   struct dentry *debugfs_phy)
+				   struct dentry *debugfs_phy,
+				   struct ath_rx_stats *rx_stats)
 {
+	spec_priv->rx_stats = rx_stats;
 	spec_priv->rfs_chan_spec_scan = relay_open("spectral_scan",
 					    debugfs_phy,
 					    1024, 256, &rfs_spec_scan_cb,
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.h b/drivers/net/wireless/ath/ath9k/common-spectral.h
index 011d8ab8b974..6c397b8726b9 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.h
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.h
@@ -94,12 +94,15 @@ struct ath_ht20_40_fft_packet {
 	struct ath_radar_info radar_info;
 } __packed;
 
+struct ath_rx_stats;
+
 struct ath_spec_scan_priv {
 	struct ath_hw *ah;
 	/* relay(fs) channel for spectral scan */
 	struct rchan *rfs_chan_spec_scan;
 	enum spectral_mode spectral_mode;
 	struct ath_spec_scan spec_config;
+	struct ath_rx_stats *rx_stats;
 };
 
 #define SPECTRAL_HT20_40_TOTAL_DATA_LEN	(sizeof(struct ath_ht20_40_fft_packet))
@@ -169,7 +172,9 @@ static inline u8 spectral_bitmap_weight(u8 *bins)
 }
 
 #ifdef CONFIG_ATH9K_COMMON_SPECTRAL
-void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv, struct dentry *debugfs_phy);
+void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
+				   struct dentry *debugfs_phy,
+				   struct ath_rx_stats *rx_stats);
 void ath9k_cmn_spectral_deinit_debug(struct ath_spec_scan_priv *spec_priv);
 
 void ath9k_cmn_spectral_scan_trigger(struct ath_common *common,
@@ -181,7 +186,8 @@ int ath_cmn_process_fft(struct ath_spec_scan_priv *spec_priv, struct ieee80211_h
 		    struct ath_rx_status *rs, u64 tsf);
 #else
 static inline void ath9k_cmn_spectral_init_debug(struct ath_spec_scan_priv *spec_priv,
-						 struct dentry *debugfs_phy)
+						 struct dentry *debugfs_phy,
+						 struct ath_rx_stats *rx_stats)
 {
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 74a0134075cf..042a4f542a94 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1389,7 +1389,8 @@ int ath9k_init_debug(struct ath_hw *ah)
 
 	ath9k_dfs_init_debug(sc);
 	ath9k_tx99_init_debug(sc);
-	ath9k_cmn_spectral_init_debug(&sc->spec_priv, sc->debug.debugfs_phy);
+	ath9k_cmn_spectral_init_debug(&sc->spec_priv, sc->debug.debugfs_phy,
+				      &sc->debug.stats.rxstats);
 
 	debugfs_create_devm_seqfile(sc->dev, "dma", sc->debug.debugfs_phy,
 				    read_file_dma);
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index 9437d69877cc..9d354b1d929c 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -487,7 +487,8 @@ int ath9k_htc_init_debug(struct ath_hw *ah)
 	priv->debug.debugfs_phy = debugfs_create_dir(KBUILD_MODNAME,
 					     priv->hw->wiphy->debugfsdir);
 
-	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy);
+	ath9k_cmn_spectral_init_debug(&priv->spec_priv, priv->debug.debugfs_phy,
+				      &priv->debug.rx_stats);
 
 	debugfs_create_file("tgt_int_stats", 0400, priv->debug.debugfs_phy,
 			    priv, &fops_tgt_int_stats);
-- 
2.55.0

