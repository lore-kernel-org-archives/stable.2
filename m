Received: from mail-wr2-f39.google.com (mail-wr2-f39.google.com [74.125.225.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA24D9564
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580104; cv=none; b=sJWWQWLrdi5rxiB4yatz5UCp0ATJH352Jn8zYGfWsPyarecZXxi5OuefdwEroN2tRn6No27VSHAeHBjTfHuwzT7kDWi4hyRrmEXm8Tcn/5Vh0DVO73hsA5tV6xbrgcTwmisgS1CSyhnXWWGF5vqImmrl3Tr1Jr5eVQIwxssb5AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580104; c=relaxed/simple;
	bh=vfPgszcrKMkOdEiihjECb4jnRWMn9BoIETfDExylycs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTLT8qmkNG5fq1BcFU5spVL1Wh6GponWj0j9gOHlu8GwfsVJSl9OaKdiZqZWIwHm4Xn2qkqeO05U6LLbwHJFlg+0+sa3DCzEhx+L92V8WI8YtBXEFlJip4aHynTLxvT22Op+fH0Gmf7nUJC3IYPdgiJXRFZPv8+aVSx7mx7//Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNAu4/xG; arc=none smtp.client-ip=74.125.225.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNAu4/xG"
Received: by mail-wr2-f39.google.com with SMTP id ffacd0b85a97d-482f633ece3so781410f8f.3
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 10:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789580082; x=1790184882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EXWmb7VjjlkNtn1q70BvaaY3UDnd0CfPKSfQaqn3n2k=;
        b=FNAu4/xGxulIBRs/0kFJf7a2BYLWyLH8Ui09Gy6NQYKQX/14DScyW77uLKWAVQoFIV
         AWwSBIlVmQvk0ac+q2HW4Ps98Wgk9thQXe64WXzkVTkRLhX/yFLx/C948BM/A7B7XZNE
         aTIxua+aHaERYrjHyereN+fnSN9VSSRwLrtc5Ml7NcCHBvOEmAb6AONolgw7fbBcDgAR
         aQB7O3kYFvZUTACTVeM7Um5OljEKpDLK2XAfPtOp394skWEN0femRjwxUx1XHGz5iZHc
         6zU6I3HVVuglk3AGlcofyYtUEi3Ow5au+M3tt6GurXBLCnaTgLYA1wxyWCqmx/S4jF5h
         b9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789580082; x=1790184882;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EXWmb7VjjlkNtn1q70BvaaY3UDnd0CfPKSfQaqn3n2k=;
        b=jltgZOUM/Aaqd16CJibf9KkGRMkjK6oUUfjevQTVD93DjYRGXDwVB9OkxldNwI23YT
         UhHTM2RU4x5qWnQgpjAxwCjqjaWByz+qqjeaX9SAgEQ22QdKmQ7XqmfSTOtTueiTYgJ0
         S2gx/XglaBzqe9ZKKQiHM9njIqvOy7chi0f3kUIQx37s4gkgPC/AayeuUz3HGZTgLsVX
         3qokOyTXu6DqrffpiG+ZAxF/ZFs1+qbtTATvxhiB3KYcM6AzyxCX70V0HCDzSmNPMrDz
         saezup9xrTzrmMtOjxKcU6znogYq38DMJjMFyzyFmfXbR49Wyg8qABVohtN0q9XKdavN
         82Pw==
X-Forwarded-Encrypted: i=1; AKwUvByp+y1uUCAc5cVCEvUqHx3G4POqSlGTr968L25HdRq6oa4z7YVIJ8z22AcIE4b0qLr9I7jkNpk=@vger.kernel.org
X-Gm-Message-State: AFuF++nHKP8wpZiiNi7PgZ/wo7JoOgNbrgYzU4iVs2sTHCtR5p/0ywPn
	1m3eru25v0ghpCy3wLSIHi5c+me7iNIeWXj45/mlQnk6+l+WfFIvEoM=
X-Gm-Gg: AYBFou2C1Ax2vRdi1KrEh37Sam+MtjI0r4gJ2yfv9U/ojLHIR1sb9dwuL9StA5rlNQw
	cw7/WeVf36oWWgjgcuLaDzi69hxIPWnhwLsrixQezCvKZJHjWOHfC5aX0J0p2bqi4unQdEVqBYy
	0sAlElYelhO0XbtLvb4CCi0kRSD+isVvxHEEmpPfDFQG6aTP7DGiFlP3a2wH65JYUcXgOeKGQwn
	XF1EEkx61V+k9uUbvfAi+0pbFUHM9qxvzNayE4CxCuqWTkBfcqHIBDYe8fY0L+jinDXgzZCDvpc
	QBGgxKhRAsDYPeM1a1ZOF31b1XgwyuMACOs33wEwRBy4iaMbeeLFeRLhhpha9cI5ozlME5BktiP
	gCtjcL6gppPqDgyaKc2IwsdL/UXgSSHHJhiIo973AqzYuYHu+bHhic4ZhQihtzySBYijTzSNzNW
	VccwfjRTpW0RLRSk5CKqO6Hjhxul0Xrikh9HNMe4RLutUgbRsRYktktD+O3TwM6Y2rQsyvsGtt6
	shF4YhZTxbE9Z5sp7POS0scjqW6Vy620ZjtnudPNF8jlcwJ0WK4mEW2vW9aAsMsDW5O+FLH9PdL
	cjlbN4t6XTM8cdg=
X-Received: by 2002:a05:600c:c8f:b0:49c:fc6c:be15 with SMTP id 5b1f17b1804b1-49eb733c62dmr44718705e9.27.1789580081884;
        Wed, 16 Sep 2026 10:34:41 -0700 (PDT)
Received: from nn ([2001:1ab8:1003:0:f23c:f0c3:c09d:d6d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27ce2sm8987544f8f.20.2026.09.16.10.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 10:34:41 -0700 (PDT)
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
Subject: [PATCH ath-next v4 7/8] wifi: ath9k_htc: pass CRC-tagged spectral samples to the FFT parser
Date: Wed, 16 Sep 2026 20:34:28 +0300
Message-ID: <20260916173429.403889-8-nerijus.bendziunas@gmail.com>
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

The AR9271 firmware reports a frame that failed its CRC as a CRC error
even when the PHY error bit is set too, so spectral samples received
under interference reach the host as CRC errors, and the host passes
only PHY errors to the FFT parser. ath9k reordered the same check in
commit 3a325565c7fa ("ath9k: reorder error codes for spectral"); the
firmware never followed.

While a scan is active, also pass a CRC error frame of FFT report size
to the parser, with the PHY error code it expects. The parser rejects a
frame without the spectral bit in its trailer. A monitor interface with
FIF_FCSFAIL no longer sees those frames.

Fixes: 83fb287ecd8a ("ath9k_htc: process rx spectral packets")
Assisted-by: LLM
Signed-off-by: Nerijus Bendžiūnas <nerijus.bendziunas@gmail.com>
---
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index bed7ea2425a0..23d1ef2407a4 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -969,6 +969,25 @@ static void rx_status_htc_to_ath(struct ath_rx_status *rx_stats,
 	convert_htc_flag(rx_stats, rxstatus);
 }
 
+static bool ath9k_htc_is_spectral_sample_len(struct ath9k_htc_priv *priv,
+					     u16 len)
+{
+	enum nl80211_channel_type chan_type;
+	u16 fft_len;
+
+	if (priv->spec_priv.spectral_mode == SPECTRAL_DISABLED)
+		return false;
+
+	chan_type = cfg80211_get_chandef_type(&priv->hw->conf.chandef);
+	if (chan_type == NL80211_CHAN_HT40MINUS ||
+	    chan_type == NL80211_CHAN_HT40PLUS)
+		fft_len = SPECTRAL_HT20_40_TOTAL_DATA_LEN;
+	else
+		fft_len = SPECTRAL_HT20_TOTAL_DATA_LEN;
+
+	return len >= fft_len - 1 && len <= fft_len + 2;
+}
+
 static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 			     struct ath9k_htc_rxbuf *rxbuf,
 			     struct ieee80211_rx_status *rx_status)
@@ -1052,6 +1071,16 @@ static bool ath9k_rx_prepare(struct ath9k_htc_priv *priv,
 		goto rx_next;
 	}
 
+	if (unlikely(rx_stats.rs_status & ATH9K_RXERR_CRC) &&
+	    ath9k_htc_is_spectral_sample_len(priv, rs_datalen)) {
+		struct ath_rx_status sample_rs = rx_stats;
+
+		sample_rs.rs_phyerr = ATH9K_PHYERR_RADAR;
+		if (ath_cmn_process_fft(&priv->spec_priv, hdr, &sample_rs,
+					rx_status->mactime))
+			goto rx_next;
+	}
+
 	if (!ath9k_cmn_rx_accept(common, hdr, rx_status, &rx_stats,
 			&decrypt_error, priv->rxfilter))
 		goto rx_next;
-- 
2.55.0

