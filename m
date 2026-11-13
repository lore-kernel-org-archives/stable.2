Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541653;
	b=uOlgw7qv00uyFbOR3pEW0ulguCqaKJ7T3DElYgpfdcgCqIR15/ACMNJgOLVr/f5zwxtm
	 65WVPM9j7xrrGzr3PajJr52NJ3kLll8cx7uvP5gm9wY79P/MjcYCM6D/gm/EogZfBRzDK
	 WkfaOy1+yoA06i7LPl5lV7UVTmx51CutXAhfxelWOgoa93b2/ts0tX2ig49DwumGZb0f5
	 Lnw6tb+FJ9ByAOizNu1SeFu3s5+pDBPb6W0hXkMCCM5Pw+iYiU7cjrXD3GRnYCIhOTBDw
	 am0CSMfR7UWrBJ60kNFHC6n0BcReooKBBoG71R9m3E395JroF+vgbnkC7Wdkn/sCoCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3LzhNI6KAXXp1Khvfab5SqGE5C2/yptFBtaVkPjOeYM=;
	b=WETQy1+S3fSqG1Nyb+1rgmkLrArGjLLF/8kFBmAO/PsuvpUIfvEAQ+OFjyayE9SZ2Iv3
	 70WaTjwa+rSzgdMfTY7rYw0qhdmhpxGINgtS5oWXVx4bTu8fNZ68K9qg2wX/Sf/yCN32x
	 LkNdkjKe+jM2KNF6GL7cmV1N3jajUBfLCFQe4i9rROE5Q9iIzAdBFLt3Orcas8/JcEyy7
	 18JjWnyhsNJVZdCpB3tYJrJZTIl155Zktdj0PsPS8dr55Odq3YwcVe8Ofl1rXq0tqwJRv
	 deI1u9iy5lGsVnBt4EGr5m3eB5uiFZrS5dXvflAuce66XHF3puhdBYHE1o1Hb6tSx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqUbI+oD;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E819E606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E819E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VqUbI+oD
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-37628596783so977940eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541652; x=1795146452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3LzhNI6KAXXp1Khvfab5SqGE5C2/yptFBtaVkPjOeYM=;
        b=VqUbI+oDiI3JnOrqc33DlrRxtxm6kkrrCCNbctrscECoVoYuCXiTX/nr/klre+H7tp
         dy+/gTshNxxHC9B4FoaqyTH5xuMYTIeu8EByW+rPKPFNHAmEkjuXuo3ZLBv94SpOHiyr
         Q3zwM7HZcz6hYnSqpNqW2+jINz9/bmjg4Ot7dd3pOUxhimNRYYuMKHtxR/3v2TDr2rQF
         8lc2z/n3zBF7z3ZZjHcrH25M0jt6Zj0TFJ0DPOKYVnw6OqXAfr+1wXj8M9MjBIVRZpX0
         nrvjNOVgaoT3WGrTSlAEQDWWuBwXTIM5SQxBC+WFSAXICrUNTwGFYAe8b+cPFAXquJEv
         qW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541652; x=1795146452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3LzhNI6KAXXp1Khvfab5SqGE5C2/yptFBtaVkPjOeYM=;
        b=FtKVnmPfRf+WISMZ/yXh0LfHJM1p+7LvaHqxyAKeI3ZqYzRP8rH5TMgn5mPoalMaFA
         jkTys/x3O1WqrDnnnEqGqbdt763CXOJAmEOXRuYnzNN2DBvuRPwASmvVlb9Zzfh12fyL
         y7t9zfH6kAZE5GzblRPzrIJSEIj41jReOc5QRcmOAu958+1VZNspXxy+1AmiEBoRJLVR
         0EW3UH6kESZ4Buz/HwwgQIlmg5NsszkojqOhX3HNyOCnTxTN5dHSsp5Pw5Lz6nLXfYuR
         TcznqhswPOnk0iBlsekYetbfFSn+7yCFgTaWXoSdvXBLxqsxj21uaicPeJE+CZapSR7L
         SEuw==
X-Forwarded-Encrypted: i=1; AL+hErHWgewa+VOXX2Sqigt47KQ6e043cktdqgc8jvfdgQy52kp7k/LWEgAiVdTwF31Z3niC7psTcvw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/17rFmmq/14du2eTYL9Ycicmjm05W3MUDiZSM3Z/3MiMxxB3Ul
	A60C2DqMK5JQZQ2Z+UsMZeeIwylFWwsmr1HNlpbpLwg7zZZMPFKPYMIr
X-Gm-Gg: AYBFou12jElnQE9O8xbD01PHQ6ZetcIRgS8bbw6jfTJBBPBlCosEurFoJraIoRa3u0m
	4IRUvpoNAYrx4LOB7rzMKfMJ2/W3JharsLucdtM7hOi4hDcWvO6LZk481VxGjkv+EtXWB23s2xO
	wdq2GRovQ4dh7UCFmhInsrQm3VXlZ3ue2lLPOv8vU9mZux1MMflfRuU2zLzZuvT8zE4HSdh/FKv
	zl8GT/q478n2m2r4VzWLvD3ovHmLaMLxfJxd4Qf10WZ8U401OO2gZmF+aCfhh8Z+QnnxVvMvcP4
	xJFD3Yr26CPtHRbsw8ctZPipHHw7KAzUPK1CzsHFv4dw4A/VfWiIg/3BG76nVJfipN8xt7afIuj
	ow8utm5YjeVWY3GtUEXUd636dohU7H2nCSd3L+55yZlJDYCXLTiSNOvF7LBTRXeAxOpuJDHWnuc
	jWny/LctCqRHyeIjGges8bEned/gA+6J5JfXNBBkggrtKUOFhDfJgSPs6bA2AStKM0Fgr/bcbop
	M5VxGaPmV6OKl9H9KQstiC0/2jy+ufi69Llg1yZdovchytE/m4vRudaBVNdGGHVnGcTydRdtzaj
	+N+ouWJpQ6CITUZPOT3yUXMypqiekZAQsQ0twnT9LA==
X-Received: by 2002:a05:693c:6219:b0:377:1ad4:1947 with SMTP id 5a478bee46e88-379659c685dmr921272eec.6.1794541651747;
        Thu, 12 Nov 2026 19:47:31 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::243:8a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm2882111eec.12.2026.11.12.19.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:47:30 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH v6 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
Date: Fri, 13 Nov 2026 09:17:02 +0530
Message-ID: <20261113034704.21283-2-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113034704.21283-1-skalpesh942@gmail.com>
References: <20261113034704.21283-1-skalpesh942@gmail.com>
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

When mac80211 stops or suspends the device without WoWLAN,
drv_reconfig_complete() is never invoked with
IEEE80211_RECONFIG_TYPE_RESTART. If firmware recovery was in flight
during this transition, RTW_FLAG_RESTARTING remains set permanently,
blocking all subsequent firmware recoveries until the module is reloaded.

Similarly, if rtw_core_start() fails during drv_start() in a recovery
restart, local->started remains false. When mac80211 cleans up via
cfg80211_shutdown_all_interfaces(), drv_stop() returns early without
calling rtw_ops_stop(), leaving RTW_FLAG_RESTARTING set permanently on
hardware that failed to recover.

Clear RTW_FLAG_RESTARTING in rtw_ops_stop(), as well as in
rtw_ops_start() when rtw_core_start() returns an error, ensuring the
driver always exits the restarting state on error or teardown.

Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
Cc: stable@vger.kernel.org
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/mac80211.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 5e40cf06a9e..ffd86f08185 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -57,6 +57,8 @@ static int rtw_ops_start(struct ieee80211_hw *hw)
 
 	mutex_lock(&rtwdev->mutex);
 	ret = rtw_core_start(rtwdev);
+	if (ret)
+		clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
@@ -67,6 +69,7 @@ static void rtw_ops_stop(struct ieee80211_hw *hw, bool suspend)
 	struct rtw_dev *rtwdev = hw->priv;
 
 	mutex_lock(&rtwdev->mutex);
+	clear_bit(RTW_FLAG_RESTARTING, rtwdev->flags);
 	rtw_core_stop(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
-- 
2.53.0

