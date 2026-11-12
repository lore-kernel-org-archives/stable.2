Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489275;
	b=1TvoqorUl6fg5DWe5vBEgZcTCHleepuYsfsecn3zx8PGXVh/aCkkNIzRaH07bEMGB/aG
	 OrLWyfg7JdY2yNCmq2jRVtJwdFsFYN1rSdMaiogw01NaYsLTOEA+Yve7HUJZ95jU3sP8Q
	 HsNjbaRE1NiO5Sm9sHVHpQaan3OUbAXnfTpcrmi0cHtJkNjni9qUjVJNcmrpL1Cjsnoa4
	 pPrCld7VICMnHCJAfiiK/P0/Jc9tYBOU8arq+1Y1NSb6ooPXFJZBjsu2x1nJib37IDa9V
	 waHRBYSnYX+D8Z1KhrMExir6MBRMktCiZJMVC12p1i5nxpKljKUlTWARS4a27yTd2wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489275;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
	b=sz2pfwQ9QgDYBs+zEnC72W1Pu16BQeQio9xlq2hJMwg0oL5bPlHdrzVOjIwuF+2kOUaZ
	 uN+EL1Dl3vu1UOMR8u4c6eNSi6bqF4+jmNslXDPlabEtT6+yclb4uycUjDUNTRQbBsivQ
	 jQzzNqNQFo127EwLDu5+fMIB7OychaIII/2MPYmaR25BQtXLWpW4bLsxoFamMLo04LYPa
	 yeWj6e+CS3DnnhgV3skUPQnAD6CnmBcLLihaX+m2NVmyYLZohc4e0nxvBjtgIUHybQw12
	 5IU4EwDTqHJSGJygWlle05s6bUQhgfIfv/Z8vZtypd/Z16Q2kWVwQlyT3Jm35Unxl/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYBPTTOm;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52917606A888
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52917606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vYBPTTOm
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1aefd1bf74aso673217c88.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489274; x=1795094074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
        b=vYBPTTOm8GleGcw3qfhCn+TvP4oQRbhRiMedd7yb2IrVyeLBuOipFOMRuHNpo9eWGv
         6eaa7YX6ALpVeFl2m8JQ0XrlGMhF5Hew3fIsCPur/okc/Wf5WR7Z1oQVR6YONREOvwWc
         z7TtZc8HUFyEN4nFniimnXYo++Wn3Go9HVC/Z/msQcVeZVG32cYY29HWaeaZvLlrit6q
         8eVhqmMwmipFQpnulFnp5Gdotg0YRvQqnGZr2lOIb5WW613M+fXyzVEVC3VMpsaCAKYn
         Q/KuPfOECxbGGQnYD/cWUnR/RADetbdRSUR3KWvPrOkhDfI1upFpdSUHfVh5IxgOjO8h
         PyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489274; x=1795094074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHv1Jqi7GXywnb/nW9IKsLC85UK00ELbr2eA4avD0lg=;
        b=Ix7QRBmHnNscnothtHXIWVKcijWyYwknDi94vqCT4hIhVD+LDdgM2LWATIft5HZ73e
         x90pYJDI2uUDCsB70n1fYbK8xFC8u6g3SayJbP6o9qsX5ZvFOMudC33WECabP1ma3NGB
         0rVA81r6n94Ne3wbAmRtRsEic9NJZvFsjU4jT/MlMAyCluTeOwdK8jAFL0isryNzoQ7Y
         NEQVMyYCDjQq6N5l8Gq2uOROWcUoK5PTRW8rvX651E+dd1S/gkNaOvDlRO/pEfoGxW24
         GPiHacE6YM2EcirorSVO6npaUWwQ0bJ6aBQkT/khC23aiOfHpz7aIliXFtZchAMu1qbK
         4r4w==
X-Forwarded-Encrypted: i=1; AL+hErEDeA247tfEl0oAiW5lRhxUlFleU/tszrmAPe587isz9LqYOpRPZ48qBk/lSE/KU4FimAvOoLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sn2NMe6A4wx2mqNu76QXAEBLLi9YLdmQpYJv6iXrVsuknCWNW
	5Ily8cvqru0fI59wrxN/kTGKXcQraCPuqTkcUyVUWTxh75i4voeAwe86
X-Gm-Gg: AYBFou30Mv/I1g28ok6C/kzWut1g0UiRQBZq56T3Phepake9nUvOaaD0eTg0DVB1HXf
	iUOlet9SSTOGsEpuglNegcH7/7t1YrKE1AXSeEQfgzWrXvdTEpoFCYlUGasPr5cWxl7o2xJHgZg
	FNLF8MbCERrTDjfMmtilczmxr4lAkcYHdGZvP6tuicUwrC+JFxUgawzLNfgDADIcMZvTmaI4Leb
	YsH0AjImHXP8qNDZOAmEUXrrN73i8RoR/oteUs2yz4DsudXyD31iq8WJLFgNRV7buF91FcKyfPt
	8GTXiOxPyHVbfD8yuzPQ4wTvDWFGfYonp1miwPDo3s9Xkmhmk4sHZjhWyOsIlvj6mWC8X8mH1xO
	/3u3LmLw9InWUE+FZVWaRy4duT/EQtDAtYWKZXZiVojyQlJsmHSnPLDA1CELCRQuunJFxI1Q/AW
	LKsjpjXOWoOs3Dl9rJpH2vhpaEZlb0MspKnNKdbuQ0OiXcZDzWpd0mDAlGS1QORQZ22sugXRilB
	L/qlblz3mkdvw9pWYlCodOhH5jXPFJ5Fy+gD8xhH8VfqvaEZAh7JeqIykk4xiUMN+KxNq87oEu0
	BFm5/ukc1CNs3X+TxBN63Q==
X-Received: by 2002:a05:701b:2402:b0:1b2:6d4d:9d8a with SMTP id a92af1059eb24-1b4f5ea832dmr1835486c88.2.1794489274209;
        Thu, 12 Nov 2026 05:14:34 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::1c5:160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b48a9c34c9sm8985969c88.4.2026.11.12.05.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:14:33 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 1/3] wifi: rtw88: clear RTW_FLAG_RESTARTING on stop and start failure
Date: Thu, 12 Nov 2026 18:43:59 +0530
Message-ID: <20261112131401.236433-2-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112131401.236433-1-skalpesh942@gmail.com>
References: <20261112131401.236433-1-skalpesh942@gmail.com>
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

