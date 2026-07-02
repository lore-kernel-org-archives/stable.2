Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3F1B85F8
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782953426; cv=none; b=iEa25boNEsUW0Mnxp/7grzEXaaCPKJonZOQ/ta61MAjP8Tvk0LtvgbUtoIf93MUVEWHaJgVaFcizIL+/QtgkwvOroMg9C/PlzfibrFxvHlzO1JJ8SXvWcDpmi1u40I1Hz/WBV1Fa5RHzsihUHKxrVwJ6BZ7nJPG8zabLq5iaz5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782953426; c=relaxed/simple;
	bh=oAV3PO9BQ+ZuyovnCrvkgJTGceWcDv9CRAo4iAZ12p4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hNY+mwuxL5kH4ja6kFm5oHI3wzK45sLtgIxb1rC4HJle0LtPB3dtJPUvvcGv+x4XZo2Y58mXezHEmDTvZUqPTsH5oFfDueeOPJSUbotLxXsP4/QO/wUL2ZA5qQVX6qiaBJFucWnYyMb5oHEHRHGE8sMlPGc7zxNmrdFri7U7T58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0qW8dek; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0qW8dek"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-475881b9a4bso1263960f8f.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 17:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782953422; x=1783558222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CWkUSJ2157Xsff0+/g2CHpj4cXQ6nQx4HiCWFbqWFso=;
        b=T0qW8dekdGH0/URnE6qqg0dAY4aUECbNrYbMHqPJlPoAGcNi/n930ocAnIkqUKy+wo
         lSP9RyayirXAzHruU2CFrLofdrB9OUGNtLYDgNn4tXYKGpMrsnYoAHMOwb50W+XN1ti3
         nWnYuuHnztHbyjUREXTwVFeP1pdh/18JW5ulFoLAKFlzsZF37RGb+D1EIaBPJ68re4jR
         ONTwIc4qvJxkT8BOa1ZqVQxSsCqaI/5uvsyrSL70gHRDkUn47xkY7TXSVz8TtYZfl8XV
         RzFX69sPh5AdJiInWcUuxHVp2YKDjRu2shAHpyBpLsGQwv5z63Q0pQT9OB5PuPzc/Ao7
         yeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782953422; x=1783558222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWkUSJ2157Xsff0+/g2CHpj4cXQ6nQx4HiCWFbqWFso=;
        b=gsOUrMJZPGWUjAyZab08BCFB7hoFl4Mf9QM7bagg3M9i3wH2uVyFU42EFr/25I5QNa
         ILn6paNgcHlVugwTQZ0H+FL+akdxiU3RqeXf4oDahpR0Wc1bM3/wvPgjBWA6W9k8FxHS
         YNTONXWe1A+YvmI9zNOsegMH3ifMS/V22NqqX3hLmtZxnQlvVA/tSJdDpKCwQwBzWtgp
         XlFCbFfiwjVCx8OJ5/jKIoxBui7pautqaCdK7IzlOTt9QQEYnm530XyooKs3xUfvSZBa
         IKTSE4EtnPWDhm9OtzPhFyrlfD90Jn4TpJYSUZkMwFaC1TkgWS+3OrP69slKnlN56aPw
         5Mvw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1PQOi9J48+M79Xan6Mk7G93PNR4KBvf02RfUs1ti3UkGfsMAeC72XAClUIfx97mcFcTLt8hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBsJPHf0Jf8U6qKXt93byOV0oPUI8KE5W/XgpnGO3z0DXaMEJQ
	gZF4eviikkpw4Ng84knZNGqV3fT0pfxGXKFR2KptyffO0+A+Zho5Txc=
X-Gm-Gg: AfdE7cnSocL/JrbVLjX2DQmOOnPn90JRVhQBHPPNytpKQRD9kEP7+oHAQZ27OInjzBe
	GhdmdrCGim4sk/xZSSlDuPU6Wgthb5qkTZxlIEted7Pz7XLK3JTJNRSGjwlE19SXX3Ps3LmJXB6
	IoXxCSoQ8I2VsUh7NhtsqwDuw5SXs4zb45w5sHXHk+kdQ1qPaRJIuANFncuhhgF1Bvto/e6yK6O
	lnkEZD3UZrnPYPyAiDSGPmESO+oL36apt9WAHgmnl2CZ8jkZQhVLGj+VaxQEpbhIBDA98R90csn
	SahXaxyipvfCed8P/v95cWIG5ItcmsCJ570F6cqFNLnmZGKVSfphCBsGqJiU7hXDBxWxrb6FAlt
	eM8NpNunAFI2XFVfxhP3joSFZRxOdOxmNZ+WU2CqYFbjfWkt5aSTj4Zew8w==
X-Received: by 2002:a5d:5588:0:b0:475:f100:35f5 with SMTP id ffacd0b85a97d-477b5c415a8mr3398042f8f.50.1782953421736;
        Wed, 01 Jul 2026 17:50:21 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db8a4b83sm4747406f8f.12.2026.07.01.17.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 17:50:20 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vasanthakumar.thiagarajan@oss.qualcomm.com,
	jeff.johnson@oss.qualcomm.com,
	johannes@sipsolutions.net,
	tristan@talencesecurity.com,
	Tristan Madani <tristmd@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5] wifi: ath6kl: fix OOB access from firmware ADDBA window size
Date: Thu,  2 Jul 2026 00:50:20 +0000
Message-ID: <20260702005020.708717-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

aggr_recv_addba_req_evt() logs a debug message when the firmware-supplied
win_sz is outside [AGGR_WIN_SZ_MIN, AGGR_WIN_SZ_MAX] but does not
return. The out-of-range win_sz is then used in TID_WINDOW_SZ() to
compute a kzalloc size and stored in rxtid->hold_q_sz, leading to
zero-size or overflowed allocations and subsequent out-of-bounds access.

Clean up any previously active aggregation session for the TID first,
then return early when win_sz is out of the valid range, instead of
proceeding with a broken allocation size.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Cc: stable@vger.kernel.org
Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---

Changes in v5:
  - Add From: tag in the patch body to fix the From/Signed-off-by
    address mismatch (Jeff Johnson).
  - Drop Suggested-by, add Reviewed-by (Vasanthakumar Thiagarajan).

Changes in v4:
  - Move aggregation session cleanup before the window size check so
    that a previously active session is always torn down, even when the
    firmware sends an ADDBA event with an out-of-range window size
    (Vasanthakumar Thiagarajan).

Changes in v3:
  - Regenerated from wireless-next with proper git format-patch to
    produce valid index hashes (v2 had post-processed index lines).

Changes in v2:
  - No code changes from v1.

 drivers/net/wireless/ath/ath6kl/txrx.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/txrx.c b/drivers/net/wireless/ath/ath6kl/txrx.c
index 80e66ac..a39c815 100644
--- a/drivers/net/wireless/ath/ath6kl/txrx.c
+++ b/drivers/net/wireless/ath/ath6kl/txrx.c
@@ -1722,13 +1722,15 @@ void aggr_recv_addba_req_evt(struct ath6kl_vif *vif, u8 tid_mux, u16 seq_no,

 	rxtid = &aggr_conn->rx_tid[tid];

-	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX)
-		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
-			   __func__, win_sz, tid);
-
 	if (rxtid->aggr)
 		aggr_delete_tid_state(aggr_conn, tid);

+	if (win_sz < AGGR_WIN_SZ_MIN || win_sz > AGGR_WIN_SZ_MAX) {
+		ath6kl_dbg(ATH6KL_DBG_WLAN_RX, "%s: win_sz %d, tid %d\n",
+			   __func__, win_sz, tid);
+		return;
+	}
+
 	rxtid->seq_next = seq_no;
 	hold_q_size = TID_WINDOW_SZ(win_sz) * sizeof(struct skb_hold_q);
 	rxtid->hold_q = kzalloc(hold_q_size, GFP_KERNEL);
--
2.47.3
