Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795075487;
	b=H5uNBMdPwdRO9x449fjWt4Gt4NIERWo79AhdshIVQ6DeGxUVnbc8z+ZiNd4m94cJhGO0
	 1bp5iU53Ny4JjoVUGQirwV5MR1d7LJfIFsaj9A6SFOsptfBpzqig8Pdg8YF9g5iYSvkM4
	 uia66ND+E0wFMrfTrTZiabKy7rLKIMZso1A+CRwdbcZIsGcl6tVc32EMgfXgi1ngSWMOq
	 VfUnD3/jeP+7ewUvtTTfl9SWC3h3m4ZitUmAPhqFGPCuAc/xRqXUaHM3U1tcjIRtINaaC
	 SG/J4S95ftOsmSSoGt21uoo8k1TQ9dceViLbX6SlnMAlzAQcuAmtnXyhjrihVIRjBoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075487;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=UEzpk2HpAM8kbjTVy5Qgfc7BYjAlifvE+YiZH4ViRtw=;
	b=q8ET2pj4h1NkSrxQdHUl6kLlz1jKJUSno/NdHsCNU9i+FR76TQagjlC3zHtBgVvlyi13
	 aWZkARldBeREHH5yiommtwH3LHmrA7LKBgivskxBfXxt7bG0MXPV7saeLeKL29BT+qmr4
	 zXVMblyItOBX1pyL4EiF8Y+lx2p5K673lo8qwULnWCZx+GohTfpV2sar3Lbs5HvBPPBw2
	 G1IkaFcN6YN/Z4OMJvqQtUNaCd0I1hQCpTLsWSbrW5Lgh6nfG4jSjOIHGSPe1j8Av2nW9
	 2mYmJKtczW4VqAhC0b7pmzur7/I3rDZ3DnF9FW4HQ6PfmbMjr49GykF+FoBdBo+5gAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ph4ntom-rev.uz;
	spf=pass smtp.mailfrom=ph4ntom-rev.uz;
	dkim=pass header.d=ph4ntom-rev.uz header.i=@ph4ntom-rev.uz header.a=rsa-sha256 header.s=zoho header.b=UmSGbynj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.54
Received: from sender5-of-o54.zoho.com (sender5-of-o54.zoho.com [165.173.182.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BFC606A324;
	Thu, 19 Nov 2026 08:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70BFC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ph4ntom-rev.uz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ph4ntom-rev.uz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ph4ntom-rev.uz header.i=@ph4ntom-rev.uz header.a=rsa-sha256 header.s=zoho header.b=UmSGbynj
ARC-Seal: i=1; a=rsa-sha256; t=1795075418; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jFeitUq+5DokULq0dujRFVNB6OSb7vmXjB+Gtchmrzgx+Kzdgt3DD6kkA40qccF+rSIcLJq0h8CwD0ACiPX4XgMFmPhuWF+L06xAMzDGiV/TebZ5abDTCmDyovNiif0xh+98QF7HDg2UEfSMIBwn6MnXcwsxgmYFrZfFZO+6bGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795075418; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UEzpk2HpAM8kbjTVy5Qgfc7BYjAlifvE+YiZH4ViRtw=; 
	b=QyQ6UNSddGuAU5tfg5Xze2ZSRF5SJgN6ucI5yyHmfN5G4eYgSKFmRydUIpY69pY66xRIElIhapdZKKEe4VyYYxdG5kjBGzjI0t1cHBD+VBI8BofePpTNz0svJ9Fj+DpQ3Gy9MC7C5/saqRiQNX1S4GqZrx3ubKz4xANjj6/Amuw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ph4ntom-rev.uz;
	spf=pass  smtp.mailfrom=owner@ph4ntom-rev.uz;
	dmarc=pass header.from=<owner@ph4ntom-rev.uz>
DKIM-Signature: a=rsa-sha256; b=UmSGbynjG4Wtcvxw+V8UlMKvHXRIQ5a5R63lS/7g3Hp4bsfy7gOxBh5tIDKjzBuCQ7+EBtjEeV08hhbGGLdDHC9SKDsrtwTNe24uzhoVlIo3fZKEz68zC/i+XWqBT/2TRKLNp7Vm5NsiNEnYPtae6s23gri9FQP0ZCh8PuD/brrcPDuR+64e2nf1sf0EvqkH6xJyTZwHWs786bs64v6A0yC4NKTFt3ZAYNtiFTpR/0Kr1PYZ2qOoj/fWbDmqPURY1CwhscG7YRBUdCxxkrU4+o2t3Xm7buvc26iIaXERV6QnjL++OoQZavmOEbdVZyfJRBOLVW6RoZDiX7Gxp0kk4Q==; c=relaxed/relaxed; s=zoho; d=ph4ntom-rev.uz; v=1; bh=UEzpk2HpAM8kbjTVy5Qgfc7BYjAlifvE+YiZH4ViRtw=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795075416766333.12419585070074;
	Thu, 19 Nov 2026 00:03:36 -0800 (PST)
From: Enver Ikromov <owner@ph4ntom-rev.uz>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v8 2/5] wifi: rtw89: handle negative rate index for injected frames
Date: Thu, 19 Nov 2026 13:03:25 +0500
Message-ID: <20261119080328.391-3-owner@ph4ntom-rev.uz>
X-Mailer: git-send-email 2.56.0.windows.4
In-Reply-To: <20261119080328.391-1-owner@ph4ntom-rev.uz>
References: <20261119080328.391-1-owner@ph4ntom-rev.uz>
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
X-ZohoMailClient: External

When user space injects a frame with a radiotap rate that is not
supported on the current band (for example 1 Mbps CCK on 5 GHz),
mac80211 sets the rate index to -1. Storing that index in an unsigned
byte turns it into 0xff and programs an invalid hardware rate into the
TX descriptor.

Clamp negative rate indices to 0 so the lowest valid band rate (1 Mbps
on 2.4 GHz, 6 Mbps on 5/6 GHz) is selected.

Fixes: e96abe4fd7cd ("wifi: rtw89: consider data rate/bandwidth/GI for injected packets")
Cc: stable@vger.kernel.org
Signed-off-by: Enver Ikromov <owner@ph4ntom-rev.uz>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1e8b60e..37ff745 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1259,7 +1259,7 @@ static void rtw89_core_tx_update_injection(struct rtw89_dev *rtwdev,
 	enum mac80211_rate_control_flags flags = info->control.rates[0].flags;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	const struct rtw89_chan *chan;
-	u8 idx = info->control.rates[0].idx;
+	u8 idx = max_t(s8, info->control.rates[0].idx, 0);
 	u8 nss, mcs;
 
 	desc_info->use_rate = true;
-- 
2.56.0.windows.4

