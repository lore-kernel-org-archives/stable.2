Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAB274FE3
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 04:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829320; cv=none; b=lC6fZCVitS84prF5JNEEQqZpkO9m8gN2NA8uG5Xt8W7yBlv9FNs1X/B1wQqqDzPq6WotKxipK8+K5L8JHSWdWgPtCFxcQByNfzM7v7qi85abuXQeM9kL6F+iqvmz/NDNaI780Z1w/BAMzRph7fhuQyQCOgQO5t0ywNg/gbqpi3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829320; c=relaxed/simple;
	bh=nwZTpXgP8MVi00sG8x1sckv5BNqKE1ZEPgFs58b94wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EobEKYgsTiiCYU8LWytKFeCf/hgbKKbZhQdQEdw8h/owX3KYeBH8s+3L5JRVkBU81p7xMctzbmhn7djXwAtwVY/W03JcPg1lB2LLiqjT1ht5IbaJnqvpEKqabWwUO/KR9pS+ijFwmvZ+CLHrZIOH47AbKa6bdvV9RJWQ9EdUn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pa7hTDh5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pa7hTDh5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so2091999a12.2
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 21:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829318; x=1784434118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ua0X8FikfiEo6q6nozi853UqZXRTepXxqADI3wGhfM=;
        b=pa7hTDh5iyiORp5QVCC4H4E5TxuGAwxGTUR4Z5p1AevOhBOYBZY2I6sfGire7pAuTf
         28KDsJfcMToOu9hQgMvHSl2wbJhNkLmMpAUxSNbYTfieVb7KQTetNjoNXk2XU0KRBHhz
         wxt7iPlhTa34JauVWbKohoTdeMheMQodQSXehltD+GTTJsshefkUMAo7m9BQFeycP1ke
         timVOczagZm4yeuMUPzLf1d1iwxH5Cg+LFL4JpgYKmU4dNRS0tuCCS+SzgRxFhMtPc2G
         jMV17nNZBmzFKp1Jn+nh8EAYSpn+KkCMqymUNsRFRkFxE1Kr1OAyhsqIziG2WPO40THt
         /O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829318; x=1784434118;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ua0X8FikfiEo6q6nozi853UqZXRTepXxqADI3wGhfM=;
        b=ltytRK7XhV7dVjylU0cRP0aAjK6wGtcldsjCjKEhtGBF4bIiToR54QBDIPxL/MX6I2
         4GhfSIbX6xR3CrIgiWaA5NVAjxa7o4b8DTO2jHzxt9SLwSm9ob2cgVPCE8XbEB1Asw/R
         /2vPihaqFcq/roVGDzoLsf4EFFOZVge6o8uchR7XIrWtDC9ydcXt1YW5uxAcU5XLpmZo
         GIM82Vi/Pp6f6dDhvENeuckO7HZFwA7BtGdPjnLQq+ls5LygvQKghuTPGX+Nx15Bokdg
         jpwSjIteu3jka7Qsg7Cl6JWg0bXiV2RvYDPlT2Z75G1/FlWaNjmzLQPzp/M+5dmi7kFk
         j+YQ==
X-Gm-Message-State: AOJu0Yw16fL64AofrIrbHHNLbNb/3+rHLuf6E/Bh5r39rcZUd7hEW+Wb
	w023X3oCcCW9fmhXJ4vEptD9FcCjeVqv/+8XU+xX/Q5/u1O3jtB5A1ujbn2eL3Orhj4=
X-Gm-Gg: AfdE7cnZqzDMZAfETUK+ciEUayOVXPVbo/v5JQhbicPaao3TOWj4ENEV0Sa8LpvAoA4
	V5sPZt9z5sP0HXudK74uD17fmq2//y0dyvMrRVtuPydw8Ypdf7gTxKA+SNRSp5YgA58l//3kz/d
	Bk8nAg3ep44Ti7kkaDOL5HmQu5Xv48tD3SMtZYP64RWYiD/J5K7LpElwE+G/O3tslkKzVheOiXk
	9vwEhTnsC8LkMnoAS+psXo5+gkU0KFW70GgtzkgNRgeGr6QyjkNUCNm1aTusP1LVH3q/qG3Glol
	ipmLzZCwVvWS9r5bwpdMz0PaoWPEp0l/TYp7qkezQOw0gAWwRSA0PN9qk3d9zqJjjCAcP0r0/tk
	6ToWQmij5vKUS0gyw49HNKTdrZMNWjEK+GJP8gQvr3Y0kI1/J45fr0X4MyIZXtyHuG1lvA0FYem
	lrSRHePAP8hsutOWdFjtyMiLRHxW2UMrtc
X-Received: by 2002:a05:6a20:430b:b0:3bf:c07b:a9a4 with SMTP id adf61e73a8af0-3c1108c219dmr4988308637.59.1783829318393;
        Sat, 11 Jul 2026 21:08:38 -0700 (PDT)
Received: from ChatreeyT9-N100.localdomain ([122.35.120.240])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca7d74f05acsm4799387a12.11.2026.07.11.21.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:08:38 -0700 (PDT)
From: teirua <qndkdrnl@gmail.com>
To: qndkdrnl@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix inverted HT40 secondary channel offset
Date: Sun, 12 Jul 2026 13:08:15 +0900
Message-ID: <20260712040815.11011-1-qndkdrnl@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MinJea Kim <qndkdrnl@gmail.com>

rtw_get_chan_type() maps the driver's channel offset to nl80211 channel
types the wrong way around.

In this driver HAL_PRIME_CHNL_OFFSET_LOWER means the primary channel is
the lower 20 MHz half of the 40 MHz pair, i.e. the secondary channel is
above the primary one: rtw_get_center_ch() computes the center channel
as "channel + 2" for OFFSET_LOWER, and bwmode_update_check() sets
OFFSET_LOWER when the AP's HT operation IE announces SCA (secondary
channel above). In nl80211 terms that is NL80211_CHAN_HT40PLUS, not
HT40MINUS.

Because of the inversion, cfg80211_rtw_get_channel() reports an HT40+
association as HT40-. For an HT40+ AP on a low channel (e.g. channel 3)
the resulting chandef spans below the 2.4 GHz band edge and is invalid,
so the regulatory core tears the connection down 60 seconds
(REG_ENFORCE_GRACE_MS) after the AP's country IE triggers a regdomain
change: reg_check_chans_work() considers the reported chandef unusable
and calls cfg80211_leave(). The supplicant then reconnects, the country
IE changes the regdomain again, and the cycle repeats, causing a
disconnect/reconnect loop every ~65 seconds for as long as the link is
up.

Observed on a TECLAST X80 Power tablet (RTL8723BS) associated to an
HT40+ AP on channel 3 with a KR country IE; a kprobe trace showed
cfg80211_disconnect() being invoked from reg_check_chans_work(). With
the mapping fixed, "iw dev wlan0 info" reports the correct
"width: 40 MHz, center1: 2432 MHz" and the periodic disconnects stop.

Fixes: 5402cc178c5d ("staging: rtl8723bs: add get_channel cfg80211 implementation")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-fable-5 bpftrace
Signed-off-by: MinJea Kim <qndkdrnl@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 1484336..e472687 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -1949,7 +1949,12 @@ static u8 rtw_get_chan_type(struct adapter *adapter)
 		else
 			return NL80211_CHAN_NO_HT;
 	case CHANNEL_WIDTH_40:
-		if (mlme_ext->cur_ch_offset == HAL_PRIME_CHNL_OFFSET_UPPER)
+		/*
+		 * HAL_PRIME_CHNL_OFFSET_LOWER means the primary channel is
+		 * the lower 20 MHz half, i.e. the secondary channel sits
+		 * above it (SCA), which is NL80211_CHAN_HT40PLUS.
+		 */
+		if (mlme_ext->cur_ch_offset == HAL_PRIME_CHNL_OFFSET_LOWER)
 			return NL80211_CHAN_HT40PLUS;
 		else
 			return NL80211_CHAN_HT40MINUS;
-- 
2.43.0

