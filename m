Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541658;
	b=DAKLRHwiACdzIjj6n3tSDOeGtuEfnltiEf1nxsvtoAkTb1Xm3WPxQq6WZ4TLwuwpewYp
	 vl+TTrff0vOQwSKEVCUipvoewU43kHnj8ZksZBUsAbzuIlf5mbM8ONyfNM068gEEnyhET
	 TsoO0bidAHQLwb1buy7NVNTaC9Wvp/tNX1YTFIEEKUVKBeXTRz3zXpQP8LvWwJ3ZIoatT
	 +fYf2/xdxERA9+khzxzcVEyLM+JKs4KY7fAVzECmPPFYEr98anKmqZ1lsguxJqTyzIs42
	 omnWDjR3r7Lp0COnSs8vEkXxdtmDbFtzPjSc/lQYemTg+9iZo7yzmcSxWxkboH0zaiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=krFGc39cDQc6W4RIn7CRVnBJgRk5o9JOSMsGfSyQOaw=;
	b=EHRl/IGSxU9EYDat/pT6sOprm7BpEffrEy7keavBTr2FrBJi0WVhHliW7h+Hf6xNBgkY
	 Bfd/ORcS4rmtKbQ9vfK0MrkfX0L5c0NqMZZm1H8vynEOLE82bIX9fQzjbn6n/AnXj7CFD
	 mFmgj8RkEUsEKaVMVKI0An5H/GCZnpZSRW2x+U1Hu959/8nlmpfpvJTSXWCvYAWY9nt+D
	 wiVrg8CrKeoapCaPCjM7YPYSgJmcZGfKDUz9V8CAOQ54qABDv58DoWW14RCB1bUOSJ1oT
	 tAyZYsmRNz65TkMqBuxZTmjUX+tEnzj0VaqAcnabsz8OmPkr1J/CHunx8Z5PV/hgRpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBSC0mJO;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ED9606A8AC
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:47:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3ED9606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HBSC0mJO
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-372bdb942dbso610894eec.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541657; x=1795146457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=krFGc39cDQc6W4RIn7CRVnBJgRk5o9JOSMsGfSyQOaw=;
        b=HBSC0mJOXL8FSFnSuZAaqLFy7pGovQkHDUeou+qbg5iQMpZ0ySKPLyoJj4R+f08bPT
         GzX+yUTfUhqHBSYFiN/E9U4bmqb7KFw+aZi3oGAY8OZ7dopI9t0k9X4ah0CL9vjlOdJ/
         c5C8KdDrXJSxOGZJoW+rjoTCglBLOjGo7Uyulxb0dD6E2nKr5iZ3OiDE3zC8azf3lfYP
         GxU63tAbRoSLuPxv3SleDfEWSVeWTBIcxovI1WnGuyf/IrBYWbByPWBjJKu2kwbpPGTf
         eV846oU0LuamoHiAjrrwwiNJ4IjdoFxid0bbur/pwnttY5mv3kUz3ie5u0K+9XXgoFpe
         AlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541657; x=1795146457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=krFGc39cDQc6W4RIn7CRVnBJgRk5o9JOSMsGfSyQOaw=;
        b=07SxabgMJr9TU03v28Ruicsie2crS17GoOTMrI2cmff7ypeN12xlv8Ocr4Wt2rmc+5
         XnLmCFpaDJeorqF3xl8VufEULpZT6Dix5IxGsng4eVqQjSHd8uKWE9ue+HkF1Us6Lrea
         jUopdNzQ50x+vNluA+kOUSKfQqVk68xxHby64tHy2ozyzSKWXyNXSnm/aZiwuFqDrQQF
         fGmjOh0fd2GwtEJYnPdr4pd2pdGs06T38zvLvCY7kKlywhP8+68TzKokQ3Y82tv8bwr4
         D2X+quHZzPdIm+KFYUNPjOgrRDbwekzGyrjJ7GV9aXjVjy1XK7FTTnUlTpsP1aWX/8YI
         BKww==
X-Forwarded-Encrypted: i=1; AL+hErEtzyx9dsnQDPGouA99KGX2WfmfLMZwI1GT+li1SZHS6dGN8snrF8x3qTLIM/C+Bq36wH1OiVE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OMCFEmvKaRltuxIvX8hb3dXGDtC9M4taqx6bbR+iGvXHV2YYJ
	SE/pJci9wAJbTnZQirs9Dg14n7jZa1R65Zjb25CqBykbAPpePniiTimc
X-Gm-Gg: AYBFou39lYeLe3wFgj808O14kduiE44KsG00CkD+n/lG07w7tEaE7ybZWPRXxmo6tl9
	jdSTTjUw2YsNgLqgMbL6h6UVJ/KcdCg/aFrNT/a5/78cv/pj0AuO6htODKKVHszZPkonL6aMnzM
	ef+0PSL1dPsV/IT3+dgKHTelM+oZgHinL/94eKjMs4ZSaTd46ufKQ2cdwpog48wUfm1OmxTbgZN
	OF4+TGipqr5GBs7xN9Jg97U39uNeG0ERS1iUvzSDDeRxZlFMSYhUro5rnA9X8Y+KlgRr6V3GiLo
	BhSiQ8RAcOSvcIY0u9l+HaJ3+nqkXvE96JDWKZSQBfnfetayIrMVtJ+1C6EcQkcdG1R3W43ghgj
	Y0rtNRLEQsJjPtc6ONKLFOP7pzd6zJe3FEPC8v91jcpygsKIdMmgliQwoYv0eMqF8L7Qdhmxwui
	A0SsSLNZOqp65g/Fjk93YHd7ID+ZSvw+PGpKf8zuf2qb7djTUCxiH0or0hVWJPxZLNpHg4rCMpO
	wG+r5QYO/spt0nMsmIHfWAnot9593RQU/m+HoKzePg65WlaF1YH11KmAgE7dOXpRGw25sIlUKjh
	zrQlQBebicvc7+nNrhegnNlxyxyla8vTQ6qwofNfjA==
X-Received: by 2002:a05:7300:e9c5:20b0:361:167c:2364 with SMTP id 5a478bee46e88-37966e3ab7cmr1252984eec.8.1794541656922;
        Thu, 12 Nov 2026 19:47:36 -0800 (PST)
Received: from xploitoverload ([2a09:bac1:36a0:120::243:8a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379558231eesm2882111eec.12.2026.11.12.19.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:47:36 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>
Subject: [PATCH v6 2/3] wifi: rtw88: skip already reset station in rtw_sta_remove()
Date: Fri, 13 Nov 2026 09:17:03 +0530
Message-ID: <20261113034704.21283-3-skalpesh942@gmail.com>
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

During firmware recovery, __fw_recovery_work() iterates over all
stations and invokes rtw_sta_remove() via rtw_reset_sta_iter().

If recovery is triggered concurrently with station teardown (such as
during ieee80211_set_disassoc() where mac80211 leaves LPS before
removing the AP station), rtw_ops_sta_remove() is subsequently called
for the same station. This causes rtw_sta_remove() to execute twice,
leading to a double free of si->mask and an underflow of rtwdev->sta_cnt.

Cancel pending rate control work first, as rtw_ops_sta_rc_update() can
still schedule rc_work after the station was reset. Then check si->vif
and return early if the station was already reset. Clear si->vif,
si->mask, and si->use_cfg_mask upon removal to ensure clean teardown
and avoid a NULL pointer dereference in rtw_rate_mask_cfg() if mac80211
re-adds the station across recovery restart.

Fixes: 5c831644e1f4 ("rtw88: handle and recover when firmware crash")
Cc: stable@vger.kernel.org
Signed-off-by: Kalpesh Solanki <skalpesh942@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f7708ad17b6..8e62d38a269 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -386,6 +386,9 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 
 	cancel_work_sync(&si->rc_work);
 
+	if (!vif)
+		return;
+
 	if (vif->type != NL80211_IFTYPE_STATION || sta->tdls)
 		rtw_release_macid(rtwdev, si->mac_id);
 	if (fw_exist)
@@ -395,8 +398,11 @@ void rtw_sta_remove(struct rtw_dev *rtwdev, struct ieee80211_sta *sta,
 		rtw_txq_cleanup(rtwdev, sta->txq[i]);
 
 	kfree(si->mask);
+	si->mask = NULL;
+	si->use_cfg_mask = false;
 
 	rtwdev->sta_cnt--;
+	si->vif = NULL;
 	rtw_dbg(rtwdev, RTW_DBG_STATE, "sta %pM with macid %d left\n",
 		sta->addr, si->mac_id);
 }
-- 
2.53.0

