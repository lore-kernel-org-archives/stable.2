Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C89A12B94
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785964197; cv=none; b=kiR/+WaKxm2OHRfbHHgtn7mTm4S03o5bAAtPfxGmODqgJ47+emUTj6f+mGZSABl4JIrn440Y1PWJIDj/RhbBokXL7eRI1umRxYileHCmHUkugcrJBtPmi7nWayfaHzgPyyd/L72XWN5OMhkv8Z6LeskmkSfB9ZDl2KkQysrFpzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785964197; c=relaxed/simple;
	bh=j6D8ImoteM7kDuq1VRILlohiwkKfmrlM2XD9L0SLgL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vz80T3FdMazuU9d3YTNZbxLScq0zOceI4Voa67Qgh9tSzFNK05wUPccgv0iKbMnomEL3w/gRFg0bYpq4VEmwvjOC9OFI1uOksMTWlKUZ7cKKXflVVc+SaskYuXd5w7xNXVdrmQR4aGMpKH0FtJ41TY0NKmBQyAIkcq1aBvqeZug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bepM/hld; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bepM/hld"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so213675a12.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 14:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785964187; x=1786568987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NCfLIwLQXd+ehjGtddX19Kp+kZQI1+gPoAz7ZcG61eM=;
        b=bepM/hld3cwSizRaDp11fhZZCy5k3JTr3yOzBhHPrq7AEV6mpPwdfvAlWgs/2mdOqY
         r8QVZCDUcGJ6BcFQoVhcdzaNG1WaAR5gXxMBmJYn2ikm36d4EBy8+hDStxksz1hzCstG
         eCUp8pKO8ZvOJNza78+yn9Li9AG7dpn8WuyriuWKdicFSVExEyhymGZPap1nbQ0l8qVB
         XtQtoKXh/veoQA9WNoBLDCkO18qRSxxQLIWfcBOM/TzUIm2T3phhmD9XTDHdQdNaU3fJ
         KaP2R7ofz2OkPiLUvMrGsM0/l80GPoW/7u2rkAZHepFGeCF5zB8FjY9Ucjy1LTWU+ES+
         QwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785964187; x=1786568987;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NCfLIwLQXd+ehjGtddX19Kp+kZQI1+gPoAz7ZcG61eM=;
        b=RP/N3iD5MIDiive1fM3BSMOVVyTGvbgiIrWWSlrXqitVJ0Xrj+EAqlGlXMFhqM5ceZ
         XkY2oXPLn1eOwNG1dR20PwiBhF46WblPIPra9ebX/An8ONS/QylaEA1tKyiWzj669x9f
         cS2SoNR/msPkwIwz81PJ+nVVhyyUrLqYs3DvLzvem31PA+0ibX43i28yfA3AQXOxok73
         3frp9lQeFoHjyNtvhmkSRx4j7d4O3CFZErotTKMeQW+5Qi62dKyEPBND/go9Rh5NBYzf
         A9w9hQl9n5rQH185WJukEERpYK4j115i+U6s83Gh12mEageQtI0lqlTRiuvySWiqZVh0
         boMQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSuXF/OqWu5SGumvR+/7+bwz439pyHcttWPLgyqoo0I825Z5wwUQAXZQOAG10iaopvYU3IVPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoW6e9nkNjIL7UfElXWqLavZSRdV+UBTA8SM1qPiNfZ4i1ER9R
	KLXfxWCTxcYvrlQAoCFcpB2qbW1t9aSF14IKjCwFRtqrbX1jRxdQcLoQ
X-Gm-Gg: AR+sD11FBDHdDynSmEGCrRns9f6jQcBa6RayTcTEaubszPCYk6xDQZI3xnnVkxUo4/D
	1ekcKRKvXG9SMXfD4QiO+1xePgIM+CCpbnwZrpp7f9V2Rn/tHM5+0KNGeEOWqOoG7hqbfnF89VD
	iGsZwrBj1fNUHpfnLs9lM+E+gUUSG3+ddNY5uek0SFmuaTsW05UTz/cScAt6Z4i2MHDmXt9ICEl
	c29grbh7VrwsNfw1WF6axKBcIXfMh61h1TKhRyXlYhxWq6zEgWn2qbtrDlSq25u1H4LaC5jDotY
	hqdgTBAlK5uBJUjuiScI0HppSRWoo35miZ2Z99XF66tHp2BeAl0Z4DluVzIet5Np9yRsP4WV37p
	G5nFyubZKew66TyMbQ7qIMtvC0aldlTwzr+7t2hHHl8isykeLFfEpOg1jOF+yIYfs/BYsMrzRDb
	ruYiSnojdkOnDyxPtFCohuvsL6OwfdnP7yOEowmy3F6o/oiaw5XJzd06NF9Q==
X-Received: by 2002:a05:6a20:7f91:b0:3ba:d7b0:fcac with SMTP id adf61e73a8af0-3cb9c0a2040mr2070221637.5.1785964186427;
        Wed, 05 Aug 2026 14:09:46 -0700 (PDT)
Received: from eos ([103.89.26.200])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca2e8ae2sm16914896c88.0.2026.08.05.14.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:09:45 -0700 (PDT)
From: =?UTF-8?q?=E3=82=A4=E3=83=A0=E3=83=86=E3=82=A3=E3=83=A4=E3=82=BA?= <reza1234khan1234@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org
Cc: =?UTF-8?q?=E3=82=A4=E3=83=A0=E3=83=86=E3=82=A3=E3=83=A4=E3=82=BA?= <reza1234khan1234@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: fix out-of-bounds CAM write when key table is full
Date: Thu,  6 Aug 2026 03:09:41 +0600
Message-ID: <20260805210941.75136-1-reza1234khan1234@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In rtw_ops_set_key(), when the CAM table is full,
rtw_sec_get_free_cam() returns RTW_MAX_SEC_CAM_NUM (32) because
find_next_zero_bit()/find_first_zero_bit() return the bitmap size
when no free slot exists. The bounds check compares the returned
index with ">" against total_cam_num (32), so the invalid index 32
passes the check.

rtw_sec_write_cam() then indexes cam_table[32], an array declared
with RTW_MAX_SEC_CAM_NUM (32) entries, causing an out-of-bounds
write that corrupts the cam_map allocation bitmap. The write also
sets bit 32 of cam_map, which overruns the bitmap as well.

Fix the off-by-one by rejecting indices >= total_cam_num.

Fixes: e3037485c68e ("rtw88: new Realtek 802.11ac driver")
Cc: stable@vger.kernel.org

Tested on: RTL8821CE (PCIe) on kernel
7.2.0-rc6-rtw88test-00059-g0d8395707651. The patched module loaded
and associated to a WPA2 network; ping traffic passed with 0% packet
loss. Reassociation and disconnect/reconnect cycles completed
without errors, and the CAM table (debugfs dump_cam) showed valid
key entries. The CAM-full boundary (28+ pairwise keys) requires an
access point with 28+ clients and is not reachable in a
single-client setup, so that path was verified by code inspection.

Tested-by: イムティヤズ <reza1234khan1234@gmail.com>
Signed-off-by: イムティヤズ <reza1234khan1234@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 766f22d31079..3b6302f14de0 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -597,7 +597,7 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		hw_key_idx = key->keyidx;
 	}
 
-	if (hw_key_idx > sec->total_cam_num) {
+	if (hw_key_idx >= sec->total_cam_num) {
 		ret = -ENOSPC;
 		goto out;
 	}
-- 
2.55.0

