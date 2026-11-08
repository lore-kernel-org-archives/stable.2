Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148074;
	b=LwAkxkocYM7o7BQaMejXUzqn+N8tI0PyTS7yFvgbi/33hwCB13s4cPOfBBtm90E009Lj
	 d0yAdrfzMB0V33hFLx5DqZPkeoDzHZjcL1K/4K5gNvZ3YGB3L7u0NAZ1MmI4jNVZnWfVc
	 Wapr7b8TvWqrzPYR2a8VM2kW7nVrQ+GVJ1JpunUBXB61JD80xWAtsr+V3O+G3tVfxjo6c
	 cS9FQUs4AW2LN1siZjcZ/6nDLwX/rQKvjsNTf+W6DDdSmtYnaFjVOEfw3V2T1PmUUsBKz
	 DNJNXCmFWqiA53IVA6endRT2uYVf/yxcs1CE9CDnZOFw6RYEJoc/3jTHAJmlITFXDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148074;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
	b=4XA3Zfvykg17Vi7Ykuvbe/jxhLnAwdv80V8bar6g98rm15IRWG2xINpOrEazc7rHeqfl
	 2qdbfHm6xK5eQXm7HIiLFhcl8A9OhDzcutWA7TXlqMQzhCHePPxLizCk4w1earH5IAXss
	 9nL6/boIBppeDB30+hXGI7sCHn1Mj7bW1o+r3n2/xV2GmDqLx/mZTDivPJI2evD9/QHyj
	 5vmRKgtsXZxAkjcajqGy5QTeu19AeDm57fSk5HbQ6KbAaYweRtkxix2nMfjbxGDYtEDeX
	 kG0iAOpyzFZnLC0oxNIsoJcVcDV3R0AGbmzdOEBLrgORPPUq8H+z9DUY4/fsDK6t64w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0sirvTP;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E181606D809
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 14:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E181606D809
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0sirvTP
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1ae18eb9b69so99452c88.0
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 06:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794148073; x=1794752873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
        b=f0sirvTPLxWEvAI6+/UILFtSwA3Hev7EAdoFejnIOKvv8M3lqVw2mHz9svP91wh7+F
         GyHdLBgPH76ma44FH2Ht6pYj2tziSn88lK9BVipO51nheRsxIWCvB19f4ccek/wPmfQa
         J2Jb+DulIjhTItBH5dh3+Ra3ZMopGB5+ptFXaO+G15u7e8YNWIBhKehgdVWG90K55rpd
         LRy4bn+DhYKSHkH5o9pRDE7UgdirMtGWdsO5wbSHiwKUHM4z2QUr/WWERs5SWSMniDQg
         33P485V8g9IGqnxkm9GtbRn9cPI7HL79BJyC7igBdCF51tKVGVLgukB62cio4D0o7TOj
         sbPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794148073; x=1794752873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t4Gwp/Nt7vNjWJ9ArSkVjCLBZ8+pUy0VbQocO5sogqI=;
        b=X1C4n1SNAFy+OvRSOkO7FsxgH2qEJRjecCvtX8VoXFAAG82uYxmv5/v9lTybPNv1eM
         TVFz45ltEOcqiJTbVc60oc9z9egPD/RFx31JenXRYWSbOxSB0pqtJEGrsQcA7sqLSZ/m
         ixZ4pDcm1y6zoxq2f1wVBiYZKLfH8O4iObnB09txlLyhzF+4eBrX8RvVsoPlrBJE/M20
         cb5rtOWcx+pLobN0We7uuZBYGHfQcs4SvHChzYPt8QX5kBM377r2zzAvzWL1vmUjkyQa
         WHceDccTt3nSxsEPdqXBPKAk+3s9FhmpPwJBVSUro9mAeiY84t8OBR489XFPMfnWKgcL
         INHA==
X-Forwarded-Encrypted: i=1; AL+hErEq0SX+tMDzhDRrNAPvYS4wbdsZFv2WKLt/Ks9kWpECi7swNyX/aA6lppg49DP7Nht2x4ORe4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i1rEgMaQrFALKd+59ne3hIRyrfVsL+4E2LVdmjNqPJ3h73ftQ
	ic3MOr0btilVbA1Xb7R9bBzYjWnLYpmtQYvFTrwf/lJrpR199120JwY9
X-Gm-Gg: AYBFou0DME8T+h29GwJLJfXxp3aP+IK5SJssbz1V/JmM7Nj6+BDsXBuB4HFhF9mT97V
	tZGBqcRSfkfpQIGevFyDBYgUkOwfxKrO5FNp2nWcTORSCVphFDJF4VDzHhxwKo1CMnv3PUzP33D
	UW7GU4ADXhI37J7+DD5/RcL/DXamxtsKZ/OycM6TNp9PTg10u8L49XGRmSZ0MyURjfN6wHP4Xpw
	uWQf26LXKREwOHm9PhMxZeXiqfYpx5Yo+jGSzMYZZcuLhGBKf09yT2lDDtNPsZznmrdSj8xZLiP
	HEn3UGfpe8QADBK6EuM1KdYrL/J8zCkLTSByaDKMNmUB3Da0pgDocmMp3u5bfhzrXMxnDq3cQ0K
	9miCxSIXFNVIsVN+muqCJ8Y6HbMsiMElK6Wy3D7/kct6CpEg+j09g+ZVR4AxjS4AKQ4FR0bmXGD
	tRCzZg1LnoawjHksB59PNjo3bB37BstmdL1eaoEkqcBM5gyMSxmsQ5AJKcSiZpeZ1r0keTlY1Jf
	8ZBujt581qgCbb4wSaqB08zxeyRP13+ZLDcg1cCBqMW4YGbNd6mxzzNuK5ncK18VhiLN5iIsciW
	DpWVMB/jkJTZuds/klBpJsB3w5zgI4vDUL9zCcw=
X-Received: by 2002:a05:7022:b0c5:b0:1b2:4e79:bfb0 with SMTP id a92af1059eb24-1b39fed4817mr2154779c88.23.1794148073261;
        Sun, 08 Nov 2026 06:27:53 -0800 (PST)
Received: from xploitoverload ([2409:40c1:6412:e5b:5516:cd42:6c8f:c918])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b375604109sm7141347c88.10.2026.11.08.06.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 06:27:52 -0800 (PST)
From: Kalpesh Solanki <skalpesh942@gmail.com>
To: pkshih@realtek.com,
	luka.gejak@linux.dev
Cc: kvalo@kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kalpesh Solanki <skalpesh942@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/3] wifi: rtw88: skip already reset station in rtw_sta_remove()
Date: Sun,  8 Nov 2026 19:57:06 +0530
Message-ID: <20261108142708.489067-3-skalpesh942@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108142708.489067-1-skalpesh942@gmail.com>
References: <20261108142708.489067-1-skalpesh942@gmail.com>
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

