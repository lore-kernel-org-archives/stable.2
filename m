Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795075451;
	b=TDBaJjtzfEHhpiJTC2pM6h67G+EueBLWRN0cvnmzCzKv2w/K0uEb1hbp5S0czFJxf88w
	 4cP6wMtQmpOqTCxCM54HIBj4YZWCA9JJuAXZwNjRqv3iQNT+63kGzuDg6hMBgOvhDGZlg
	 5ZKg3ZSfwzRgp4aoiOP6wlsXUaVRgPSm0dkV8AYysXSNle9vxeqP6jE62j6XXwirYrfFn
	 mCvYfyIxCV34kQoYpME9GZLS2VU9e4ndFSmT/UXcoPU3bv01HnQ8ngGgDJNRmLjqqrCy/
	 eK7r3mxgic+k7bNCRhvbqlZFHAJRj/g8j59kzfO4aznYjYwLlXLdbuHlxpVqu8XiZyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075451;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-ZohoMailClient;
	bh=QPjMco0FQ+VHzTZM6hi+y6FSu5z2KGYf3XFJfrdQ46I=;
	b=MIRh1IkiIQD5l/GHMmSCn/C0mc3aGVUjR2BppG1q1mLTrV4NgctXNG36/aJ61kzyBAL6
	 Bf93E8ppR+gpjXl7GCZ5zB5NjDp7U6ReZU1rwUaQcIkPuAsOpZp5/LntmVQkXPwyYJTgd
	 uSXx/VyStp07rEv/HXbnDtL4eb9squrPsdElPONzTtomR9n6VIEWq+or4byHDcXRLqw9j
	 LpDk96fjG8cQC6cNflKR/axm/DDwfmW/HGTLuVf8QVuJcPdAuOaAm6/O9oWvKYjeRW0M2
	 YVyvy/j4Q7OSJggeaSmYknc/FydUXOc6Z3MJOSM76cVCKIuz2MH2wkqJYQ7idAB8TTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ph4ntom-rev.uz;
	spf=pass smtp.mailfrom=ph4ntom-rev.uz;
	dkim=pass header.d=ph4ntom-rev.uz header.i=@ph4ntom-rev.uz header.a=rsa-sha256 header.s=zoho header.b=TZ0hNrG7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.54
Received: from sender6-of-o54.zoho.com (sender6-of-o54.zoho.com [165.173.180.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B4A606A320;
	Thu, 19 Nov 2026 08:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B4A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ph4ntom-rev.uz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ph4ntom-rev.uz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ph4ntom-rev.uz header.i=@ph4ntom-rev.uz header.a=rsa-sha256 header.s=zoho header.b=TZ0hNrG7
ARC-Seal: i=1; a=rsa-sha256; t=1795075416; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dFRr1Sk/fC2DI7Ubq7NcQ79N9j9bXBTKHOIi536o3/eKeAG4hJPQSvvmi1sYXnN85vZWK0BVuX2Tqz5DVAAJBn+/62Nc2/H4TpUtnbsarz3lwn/5ALsLYOjV31Z77wNlAtDWnu0SmJmkoGSgDDctkYa17bZhQ7Hfv8m+Ek5rPm4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795075416; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QPjMco0FQ+VHzTZM6hi+y6FSu5z2KGYf3XFJfrdQ46I=; 
	b=NvBL/H2WcdK9iDJT0jZjuUooj/xYdeiGimsyqAyG4JbWPsFcKyGzLQRNohd0hUYcVXFdoLpdigY97CxVK5oYkcx48ODmvn5GavMOziikwoxHyxJF+Ictl+ExtRqEAj/s1i9BfpdWL4Aa/OGp0c9Zl2HqKff7WDFh2g/7FNUpGIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ph4ntom-rev.uz;
	spf=pass  smtp.mailfrom=owner@ph4ntom-rev.uz;
	dmarc=pass header.from=<owner@ph4ntom-rev.uz>
DKIM-Signature: a=rsa-sha256; b=TZ0hNrG75dVIHzgvLz4vkZ/3vhnMEurRgSdl5IHLTs+A+eS2j676l6mgrwwcrm8O0z0U/xIp7PRlaN3gX919dEeGUhJFWr3LAMAcT4n/XKp1Uv6SYy7Kv2HGZbvpW68FLUo/mqWlg6RT2U/7EyhOrfMyDnYYB7JOEGYgxzarpCQLcIatGIy0oJURiNlujooLcuo1OvzUc4cp/l0Zwb3sqUkckSDjM06WX11NK6kymE1R/TevxyiI9UC9/xgF422OipmL6+IFQu/6luZ1MjpwrC46Q8h90O1hOdZ+j6ifYpVq4/z9rGOpRdvyRgcR3El21i1IXEPGGafMfQBBlRaHow==; c=relaxed/relaxed; s=zoho; d=ph4ntom-rev.uz; v=1; bh=QPjMco0FQ+VHzTZM6hi+y6FSu5z2KGYf3XFJfrdQ46I=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795075414311926.3669518349;
	Thu, 19 Nov 2026 00:03:34 -0800 (PST)
From: Enver Ikromov <owner@ph4ntom-rev.uz>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Zong-Zhe Yang <kevin_yang@realtek.com>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH rtw-next v8 1/5] wifi: rtw89: avoid NULL vif dereference in rtw89_ops_tx()
Date: Thu, 19 Nov 2026 13:03:24 +0500
Message-ID: <20261119080328.391-2-owner@ph4ntom-rev.uz>
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

Injecting a raw frame on a passive monitor interface while a station or
AP interface is also up causes a kernel NULL pointer dereference,
because mac80211 has no virtual monitor vif in concurrent mode and
passes a NULL vif to the driver TX path.

Check the vif pointer with vif_to_rtwvif_safe() and drop frames without
a vif.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")
Cc: stable@vger.kernel.org
Signed-off-by: Enver Ikromov <owner@ph4ntom-rev.uz>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac80211.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index c85ea82..7a55fed 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -23,11 +23,16 @@ static void rtw89_ops_tx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
-	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
+	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 	struct ieee80211_sta *sta = control->sta;
 	u32 flags = IEEE80211_SKB_CB(skb)->flags;
 	int ret, qsel;
 
+	if (unlikely(!rtwvif)) {
+		ieee80211_free_txskb(hw, skb);
+		return;
+	}
+
 	if (rtwvif->offchan && !(flags & IEEE80211_TX_CTL_TX_OFFCHAN) && sta) {
 		struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 
-- 
2.56.0.windows.4

