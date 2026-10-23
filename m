Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.239.133.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753157;
	b=fNyJSdcFpBcUK44o7dk+uwLjqddaf+dvsqN2HPIbyX4uaMdhEMIsdg5lJOr4Rg8HtvIm
	 EGkNBqGA8lh/JnzgvRk15XaA1yo+myuicLiYkxnFOOUj2hKPZTKnDfSRlE5H5FS9qhQLf
	 oH0GAm8JmwIDftTvhYR9uz72hveWw8jCrqUsej8qnvM4fkhQKo2+m81Pf6F/2PLlk22Q5
	 HDFRzzk2OtKfLUE3GklSA0YrvxWARMdSa+qtzNIxbp7NxdTsxuMghKLSSG5x+IUc6bxI5
	 cUwiWbeDvhakxFczxnNHZTmSS3i0+nDaH4Fgus89HZb/ePpY/oodL5sODAXPuEIVpXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753157;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-Authenticated-Id;
	bh=HkhiN70ziVFXW1i+IKoqtGuSltinZnwzYBrMyQL/3Pc=;
	b=yZvn6yIGtWOumkuBH2vGtbAeoDwqGxqmRbRR2MfKvHxicdulq8QxgUN8WDlZI8YO8LuD
	 MRkDNx64KIH3WBaiygUVwivQttvZajbR4cryNeKC37tF3H9Xlu6j3pMbiPMyGvbwOPdvC
	 gX5jr95kdO+1ivRIl+ISZyynn52oPZ/B0JUp2WQ6dSd24c59rALRXYe5ooBGC8OborLyR
	 gw8Adb1Ch2Z06sDuGjbQqps8uPuD3X2WHk+UyFWwBgDKFYHbsou/KM06Q4fd1wWfU4sIU
	 1Yd5qCM1Dq9Cs4g0A08MNMQAbKTfuFZYGy2QXpT9+JO2asw3vTYUzaF3fHV4VCvVgwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kubik.pl;
	spf=pass smtp.mailfrom=kubik.pl;
	arc=none smtp.remote-ip=213.239.133.37
Received: from mail-e842.seohost-mail.eu (mail-e842.seohost-mail.eu [213.239.133.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE53606A326;
	Fri, 23 Oct 2026 10:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE53606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kubik.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kubik.pl
Received: from static-46-238-236-132.awacom.net ([46.238.236.132] helo=localhost)
	by h84.seohost.pl with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <piotr@kubik.pl>)
	id 1xKCzP-00000007hGy-2EMY;
	Fri, 23 Oct 2026 12:59:11 +0200
From: Piotr Kubik <piotr@kubik.pl>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
	Muna Sinada <muna.sinada@oss.qualcomm.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piotr Kubik <piotr@kubik.pl>,
	stable@vger.kernel.org
Subject: [PATCH wireless v2 2/2] wifi: mac80211: set the link addresses of a 4-address AP_VLAN before its links
Date: Fri, 23 Oct 2026 12:58:44 +0200
Message-ID: <20261023105844.1117460-3-piotr@kubik.pl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023105844.1117460-1-piotr@kubik.pl>
References: <20261023105844.1117460-1-piotr@kubik.pl>
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
X-Authenticated-Id: piotr@kubik.pl

ieee80211_set_sta_4addr() gives the AP_VLAN of a 4-address MLD station
the links of that station. It added the links first and set
wdev->links[].addr afterwards, from the link_conf of the AP_VLAN
itself. ieee80211_link_init() takes the address of a new link from
wdev->links[].addr, so a link that the station gained later came up
with the zero address that an earlier call had set, and the copy from
its own link_conf kept it at zero. With two such links,
ieee80211_check_dup_link_addrs() refuses the change with -EALREADY,
and the station stays on the AP interface instead of its AP_VLAN.

Set the addresses from the link_conf of the AP before the links are
added, as the AP_VLAN link update in link.c does.

Fixes: 469d5d5a3b7a ("wifi: mac80211: synchronize valid links for WDS AP_VLAN interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Piotr Kubik <piotr@kubik.pl>
---
v2: remove the now unused vif variable.

 net/mac80211/cfg.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a1753335eb9d..371f441d6b7f 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2736,7 +2736,6 @@ static int ieee80211_set_sta_4addr(struct ieee80211_local *local,
 				   struct ieee80211_sub_if_data *sdata,
 				   struct sta_info *sta)
 {
-	struct ieee80211_vif *vif = &sdata->vif;
 	struct wiphy *wiphy = local->hw.wiphy;
 	struct ieee80211_sub_if_data *master;
 	struct ieee80211_bss_conf *link_conf;
@@ -2762,26 +2761,29 @@ static int ieee80211_set_sta_4addr(struct ieee80211_local *local,
 
 		wdev->valid_links = new_links;
 
-		err = ieee80211_vif_set_links(sdata, new_links, 0);
-		if (err) {
-			wdev->valid_links = orig_links;
-			return err;
-		}
-
 		master_iter = master->vif.valid_links;
 
+		/* ieee80211_link_init() takes the address of a new link from
+		 * wdev->links, so set it before the links are added.
+		 */
 		for_each_set_bit(link_id, &master_iter,
 				 IEEE80211_MLD_MAX_NUM_LINKS) {
 			if (!(sta_links & BIT(link_id))) {
 				eth_zero_addr(wdev->links[link_id].addr);
 			} else {
 				link_conf = wiphy_dereference(wiphy,
-							      vif->link_conf[link_id]);
+							      master->vif.link_conf[link_id]);
 
 				ether_addr_copy(wdev->links[link_id].addr,
 						link_conf->bssid);
 			}
 		}
+
+		err = ieee80211_vif_set_links(sdata, new_links, 0);
+		if (err) {
+			wdev->valid_links = orig_links;
+			return err;
+		}
 	}
 
 	rcu_assign_pointer(sdata->u.vlan.sta, sta);
-- 
2.55.0

