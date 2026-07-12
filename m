Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16460328B71
	for <stable@vger.kernel.org>; Sun, 12 Jul 2026 04:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783829480; cv=none; b=LAGfQboOA6KCkCvXDTVFUo5/hijnEwq/3ghbSTHF8GnQQ5peuGSyJKgajZJAwet4eCSRySYahAeqClByRGjb79j7ibA7ZYC+nQIV/TWv9bGqM1zSdwOYDHnvTQkWRU6RuZFk5VPDOtZW9dwEdmbGtlWZrKTUXEKLJaH3PSXZKc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783829480; c=relaxed/simple;
	bh=nwZTpXgP8MVi00sG8x1sckv5BNqKE1ZEPgFs58b94wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V16qb3InT/EI7JABQOksDKDPdYih2w6SqwFoot2rkr9Dobydef4qkP060T6ll6iyGGCfxf2wgsaalQfEHx4yukSkG9MRQdYyBnJ3E7GCLPX2Widu6SwAhN7BCCz+z1YUXAyvRXgGJowMTGKlCAsRdB2wbuDoSJNY0+Rz70mG0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el4GwnCV; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el4GwnCV"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce87c7e3bbso20691805ad.1
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 21:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783829477; x=1784434277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ua0X8FikfiEo6q6nozi853UqZXRTepXxqADI3wGhfM=;
        b=el4GwnCVRUEHzCaTQdqdgvN9cQZkhOL0Xw56f9jRaMh6YqFxJ8IS6kSCtXKA/5/U/e
         cMOiXvJgxmww6SVVhkalUIBwnrYlEeiZiTyc7vyzSlP9XRWX3GpBdC12lXk1vUSq7gcm
         K0HOSEeVNX7Ff+hKf4adw/YfbA84QGySugTl2a/0N2jy5izqcKQIroDYyergzOU44KLz
         u+Z1c2Q4xaH5fKDbi2pB49m3xUYS74Lt5AD4ssuVGXn59Z3rWpqtiPl4n6L++PCiCgaS
         z8fzMzDBQgSc+RFf4rT7CGFr3JTD16k3uXwhB7DtcMftpT+7vl9b1RCTcZH2igp/x0eI
         /dQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783829477; x=1784434277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ua0X8FikfiEo6q6nozi853UqZXRTepXxqADI3wGhfM=;
        b=mGYBFh/onlhEfZnA6ZNY76nkA+fhyqqsyesLXS72zQwvIu4hYvVZd2DItS0RVZjKy3
         sIgS+aS6YRQrO+nLbCixdNdbuRSeToveSER4spYDh6SikvV6WPom+vCcGY/N6G+VRRq5
         sPyTyAwDOU7i5tmPPeF+QGP41zy2SX9ku2mCYX1/V5PDyiD7MskAk8shQVu1sdqxmudO
         0jQ2XyHGaM2o+aetQYp3IuuU1Yn1CJnU80bPZNzgSI1ev4/vTJjcOV/zM9JqiJUpyh0S
         xxbF7Iu1pUN8PvfjtQO3xtjpsi4C/2RJkg6t8XH16pZokEXJS33J+wo1KnhRPghZ2dOa
         Kjhw==
X-Forwarded-Encrypted: i=1; AHgh+RqNe9Xi6XSJx5MgKClDkX5X52Fafw+hoG2g99ztv/Y8shYRvsIt6z/fVUNHGu8VzvItJiY1izU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGn7KS5u9bt61FHSQiEWbSzPPFJW+dUHvgthnUsOrEE+i/9ZJd
	X8+TTn9kCoKV5bKIFeM+GYRpRKbm2EzrGeWN0CYVQATyBCuBSODiVMwP
X-Gm-Gg: AfdE7cki8IReFRvnmhW81ci1GO18tuVTnfQqddoLrrFvzb1rtPt150NwvOpnHcW3Wv7
	aNW7GzAig0vhdUT1jpuVJlQbfImwpuaMVs2p5LPhCB3CLfUFXr1EXiH1g1pLchA4ZUweYPnDqL5
	NgXDE/dE+AInJc5u1J0jH6q26jMnZTZqQpmY20Ss0x+QrliBHfY60CRLF9RWyIAUjYIsyI9uDMR
	7ihaZpo0DQZAKpErD3jYAwnAD7L2HYcdbWLpCIIWwvUnBsVaZxHSLGeGnvYAe/X3usx9CyH2P7P
	sC0WHnf966RHeGQsyKzFTANVgpU8ReM/s6BlALrAvU3RFFrgmMa52czAzhON7ZpMYrb2S7mAN7u
	UrQzauknnVG4yVEU2oVPoDHVMQkvIJWPJ6sRGQ6MIaqwDPgKTQAyHProYam+tAprsWsjf5wFOoK
	idXF+Ymc86CwQCuiUyFuDGWxs0L887l3h5NPP3yLNIYts=
X-Received: by 2002:a17:902:d2c8:b0:2c9:e835:ac67 with SMTP id d9443c01a7336-2ce9eacec40mr49101855ad.19.1783829477400;
        Sat, 11 Jul 2026 21:11:17 -0700 (PDT)
Received: from ChatreeyT9-N100.localdomain ([122.35.120.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce935d9696sm26358595ad.25.2026.07.11.21.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 21:11:16 -0700 (PDT)
From: teirua <qndkdrnl@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	MinJea Kim <qndkdrnl@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix inverted HT40 secondary channel offset
Date: Sun, 12 Jul 2026 13:11:00 +0900
Message-ID: <20260712041100.11787-1-qndkdrnl@gmail.com>
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

