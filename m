Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489281;
	b=SC0U7i/w3gwD8upGFKi8rdeJUutSdP/pEyHOzLu7ni5OKILjfMHPwFDDRHhgV52DJwui
	 G135aRHbGkNy+LJ4Vslj7DiP/4I2ROXRqwdx/qRM1JKrsO9bdS6GlPIWNSFIgX2duX4+T
	 FBQM96tvVs84PpxyCb8b+iSmbhjA4R0SCvNwBTAFThfnquiX9a/XCg2VBfEz+Sp1FLjBE
	 QYRt+ohRuYdP2u9ykrrQ+4yK009zDgMvk4taYqjKdf1UsVmVz0qEXIe0qZ14oylF7ZwIz
	 n9ZBjGUT1qbx1ExfSaV9QNMzOEsPhYJZo4uT82BQ9ebX+0NSy5ru4DuGadTq4WXBxLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
	b=eudjIqUg7KC6m40QyOKAezECe9ufefgR/hstkpe2AYr2xxZ8r9EEWuWIGEdh7OdRbZX0
	 jkcOOPHbtaESUt66ioD3BDHr1g1Hrc+Z9jg38Pv1+6K+fX/VEEPRR5cWmCzww1Cj2vbZ+
	 aOeonbvTfdeGqJ0x+68SbuaetI39z3CfKvAgUHGNtRTh+FW5imrb+6EbsOrw+MR+a1ixX
	 WJXsXADOWdE01JD+V1lkHI778lOOVXgY71mb4nY67zH3RFxUbgMnlWkJFXNtx/3ZN59Hd
	 SirJfwmkLZNmL1n7/GNEuxl2+qOptdatFpl6XCQq+3RnAqDGRhufE5SH7N4yJP0Cy+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqxmhICb;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F91D606A32E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 13:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F91D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NqxmhICb
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-18818daa3e7so397125c88.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 05:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794489280; x=1795094080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
        b=NqxmhICbTIYcfGuXIJz1P6XnftDanJtNo1IcpGIrdtTtROTY7LSHAsKlxtR1mLJjkV
         DeJCGFOk/0UaAA5YZUQqhxbdhU4eVd+oxCqDdarxd/Z9xrtnYzTjwP8fhWX0L2WJOfxB
         wrT8sFQ0X4/vfD5buGCD5n1yGmvmWxm+KYAOSJ2G3ik+NEhRWQmGZoaw/AGJz1aR2xeu
         w18NVhyrBFhXIypj7bT5NYU4WolJoZ9oIofbV/tDVHMWzUU//90qy22fS1HeJ31MtAAL
         otzvebmGP6K9gHj+Ym8q51sw1yDljXNX9ltgpi1KZeHNhpOTK5IpyiQJaY4E0pW6eQZL
         0mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794489280; x=1795094080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
        b=IbZkihAFzQPSgNB/78DFGcHkomwBImHmJdzTvst+1NIoJfLAMKXLoX2C7S12gpjnyJ
         lqqA2wQNjqEQ2JyCVmh4DEB2wwGjMmwEHS6ayxjSC4QHIVpCJN9+6ytzCykRqFniLpbg
         eWRbFvP6Vr0p98hlCMqV1y4e5i33+ue+OWl9gb7X3cXBDTTyjIX9Z/eVPvE4waKdGCmA
         7DLrqkUw5M8mD9wPGbD6Y1R68wT69I4B09HgRB+jN4Fs/tOYyTAOKbwmqyBTuvvTIGoV
         ItTO1fAfe9X1zz2vmjbL85UYBDMpcX4i9Bysm2kmbT2ET4Z5aBd8o9C8b9jtYJ2Og/Bv
         O3JQ==
X-Forwarded-Encrypted: i=1; AL+hErHUccOTY4ukC63JjOQfgSEYU2JQ6p3YgBuZ50akkNHZt4LVSXJ1Fh2rOb6oNInYZT2YhBANumQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Qc/dYOtVSR4udQADAbaIYClKYcTizziRb0CcITrDe4ITH6M7F
	ZL8OUNZsdSQNfr5ZzoBVDgrDFYUPX/xHmmInn9QMcOEc1EzmozBNcFxM
X-Gm-Gg: AYBFou10T+3IMwY7ApNL4gGJsnSJkWCuyr/kEImT8uHo2qdQpEsCbwtTZnMKsEHI9WR
	rF+nY3QAhYFKwC+mvVW+6DUFg72j2IkKkfhZMiaHnab242OnrDh22EoRAH2uVzp/y/LLDrqwrXN
	aWQYOlrKnVaHKEuZsiHlqCSRgDIQLnvN1CkyTfW8CbqCmVvQbGMEjhQx1iqoTyJK186P1HPfxOK
	Z1TZHTbg2LjOnxCzdfkGWzPJ0O+r3UK+iaUpH52PjSKnyXrqBi2u4TWqEGeL7xYn916WKjYfX3b
	D1XCqhd8G4hjBWxh0tMmrYikwKZR659ctL7KRRfbm4/m7gYmWh52a7VS42jUADzGsWP2uB9S4ko
	Ni2TF3unE8XxM0nJGVfVOu+GwgIJOsYpz78bPXzdyG4CPk+Of+5upCUaBQprFlwRy42Jy5dbK67
	98X1nviG4dfUYtwfkMsuP9bB/D+aSkB7HLdlpCfxVRD/V/wAoij4JEZHey7sTgWmFeRw6adTnbJ
	doHTDwHl7Fs0C4A/V7aDZzJCGp59gxVjBiv2vb/Paa9Tj5YRqpzm1d/v3TXWhluY7v5FOathzSl
	mS4Y81CGYtZoRXEmmnui7JQ=
X-Received: by 2002:a05:7022:b0c4:b0:194:e9e5:11b0 with SMTP id a92af1059eb24-1b4f5f37813mr2187785c88.14.1794489280241;
        Thu, 12 Nov 2026 05:14:40 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::1c5:160])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b48a9c34c9sm8985969c88.4.2026.11.12.05.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 05:14:39 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/3] wifi: rtw88: skip already reset station in rtw_sta_remove()
Date: Thu, 12 Nov 2026 18:44:00 +0530
Message-ID: <20261112131401.236433-3-skalpesh942@gmail.com>
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

During firmware recovery, __fw_recovery_work() iterates over all
stations and invokes rtw_sta_remove() via rtw_reset_sta_iter().

If recovery is triggered concurrently with station teardown (such as
during ieee80211_set_disassoc() where mac80211 leaves LPS before
removing the AP station), rtw_ops_sta_remove() is subsequently called
for the same station. This causes rtw_sta_remove() to execute twice,
leading to a double free of si->mask and an underflow of rtwdev->sta_cnt.

Check si->vif in rtw_sta_remove() and return early if the station was
already reset, setting si->vif and si->mask to NULL upon removal.

Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f7708ad17b6..a74f199a93a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -384,6 +384,9 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 	struct ieee80211_vif *vif = si->vif;
 	int i;
 
+	if (!vif)
+		return;
+
 	cancel_work_sync(&si->rc_work);
 
 	if (vif->type != NL80211_IFTYPE_STATION || sta->tdls)
@@ -395,8 +398,10 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		rtw_txq_cleanup(rtwdev, sta->txq[i]);
 
 	kfree(si->mask);
+	si->mask = NULL;
 
 	rtwdev->sta_cnt--;
+	si->vif = NULL;
 	rtw_dbg(rtwdev, RTW_DBG_STATE, "sta %pM with macid %d left\n",
 		sta->addr, si->mac_id);
 }
-- 
2.53.0

