Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D81DED5B;
	Tue, 23 Jun 2026 09:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205491; cv=none; b=eK2spR0Nfb5A19Wfpu3y04J2NWu5AjFxC9mfjO6Elu3uPh+djs9JKE7K3AqLf8Q4sMYqIkYa4ZVKQUrcFQC8t/ITaVmi9pWyFpA8UDUEC90XVqHRGySXUrMVpjnsehSLRQ+q45TbrSXBzCDTI9pNxibNCR/xQ+Z/AJYp1yGGuNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205491; c=relaxed/simple;
	bh=e30/EBdHy6ruqTs+mAWKkelv3RojvtlGDvlLpFoOUCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrfeSFsXms5bB4tGp+FJ/LbAEmQPsUsYyPxF2tXAlLFRHWlUAod/cMtNQ+Lfm6Xw6IIdDIlZ2ACmXTJLW61PmXt4CtQw/5TbkTLLDqOMvf0n3q2Ldh/SUMx+HJXgKl0aqfulivD3PMYE8X+JsUErxwX9BzI5Olq20Btrpx2s7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sigvoid.com; spf=pass smtp.mailfrom=sigvoid.com; dkim=pass (2048-bit key) header.d=sigvoid.com header.i=@sigvoid.com header.b=QwZAW+f4; arc=none smtp.client-ip=115.124.28.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sigvoid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigvoid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigvoid.com header.i=@sigvoid.com header.b="QwZAW+f4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=sigvoid.com; s=default;
	t=1782205480; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=1kA/pv6c18TWV0iuO1JyYtl4CY5iQNoXnZGjkmZm89E=;
	b=QwZAW+f458EYGTHeMBJEY5xAMuGVk5wZf0drxZTB/bq16LGcJ+79xosAw9E29qXrFD9qXgrqxOzsfK/0d1OJSWfhnOF8FaJEik9wrYesAhM1UR937KJKMZAWBw41jKDnW4+hIunV/q7BMV+wn/18RnJtrb8St9mqBLX/eXcTmec9IXNVym8i+tSDnbbD9kCIhhD26d31dL2/4pF9Zz9X+VgbSS4MFatejWaTTAqhlQkbVlBM4eeij45v/ldN5mwpXJ6lyXCRopvXIoqdSXAQfx8Xqq2OGaTFCN/5jiWftiYzZwWHQbqFgx4nzybd8VQNHCO8qEjcscO8lG2Yhu6QVw==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743649|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0227488-0.0005507-0.9767;FP=5535002710502289173|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=yingjcao@sigvoid.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.i3HR.GG_1782205478;
Received: from localhost.localdomain(mailfrom:yingjcao@sigvoid.com fp:SMTPD_---.i3HR.GG_1782205478 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 17:04:40 +0800
From: Yingjie Cao <yingjcao@sigvoid.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: only accept IBSS channel switch from our own BSSID
Date: Tue, 23 Jun 2026 17:04:37 +0800
Message-Id: <20260623090437.13198-1-yingjcao@sigvoid.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ieee80211_rx_bss_info() acts on a channel switch announcement (CSA)
carried in a received beacon or probe response before it verifies that
the frame's BSSID matches our own IBSS; it only checks that the SSID
matches. ieee80211_rx_mgmt_spectrum_mgmt() acts on a spectrum management
(channel switch) action frame without checking the BSSID at all.

Because of this, any station in radio range that knows the IBSS SSID
(which is broadcast in cleartext) can inject a beacon or action frame
carrying a CSA element that points at an unsupported channel. The switch
then fails in ieee80211_ibss_process_chanswitch(), which queues
csa_connection_drop_work and tears the whole IBSS down. The members
rejoin and the attacker repeats, resulting in a persistent,
unauthenticated denial of service. Encrypted IBSS networks are equally
affected because beacons are not protected. Since both of these CSA
entry points are IBSS-specific, the impact is confined to IBSS (ad-hoc)
mode; managed-mode CSA is handled separately in mlme.c and is unaffected.

Only honour a channel switch that originates from our own IBSS, i.e.
when the BSSID matches. A CSA carried in a beacon from a foreign BSSID
that merely shares our SSID is now ignored; such a beacon remains a
candidate for the normal IBSS merge path. A channel switch coming from a
station in our own IBSS keeps working exactly as before.

Fixes: cd7760e62c2a ("mac80211: add support for CSA in IBSS mode")
Cc: stable@vger.kernel.org
Signed-off-by: Yingjie Cao <yingjcao@sigvoid.com>
---
 net/mac80211/ibss.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 97292ff51475..6440fd915aa5 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -895,6 +895,10 @@ ieee80211_rx_mgmt_spectrum_mgmt(struct ieee80211_sub_if_data *sdata,
 	if (mgmt->u.action.action_code != WLAN_ACTION_SPCT_CHL_SWITCH)
 		return;
 
+	/* only act on channel switch frames coming from our own IBSS */
+	if (!ether_addr_equal(mgmt->bssid, sdata->u.ibss.bssid))
+		return;
+
 	if (!sdata->vif.bss_conf.csa_active)
 		ieee80211_ibss_process_chanswitch(sdata, elems, false);
 }
@@ -1111,14 +1115,21 @@ static void ieee80211_rx_bss_info(struct ieee80211_sub_if_data *sdata,
 				sdata->u.ibss.ssid_len))
 		goto put_bss;
 
-	/* process channel switch */
-	if (sdata->vif.bss_conf.csa_active ||
-	    ieee80211_ibss_process_chanswitch(sdata, elems, true))
+	/* don't process beacons while a channel switch is in progress */
+	if (sdata->vif.bss_conf.csa_active)
 		goto put_bss;
 
 	/* same BSSID */
-	if (ether_addr_equal(cbss->bssid, sdata->u.ibss.bssid))
+	if (ether_addr_equal(cbss->bssid, sdata->u.ibss.bssid)) {
+		/*
+		 * Only act on a channel switch announcement that comes from
+		 * our own IBSS (i.e. matching BSSID). Acting on a CSA from a
+		 * foreign BSSID that merely shares our SSID would let any
+		 * station force us off-channel or tear the cell down.
+		 */
+		ieee80211_ibss_process_chanswitch(sdata, elems, true);
 		goto put_bss;
+	}
 
 	/* we use a fixed BSSID */
 	if (sdata->u.ibss.fixed_bssid)
-- 
2.39.5 (Apple Git-154)

