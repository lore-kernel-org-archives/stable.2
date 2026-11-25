Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638591;
	b=Klc4slutFMybWQhAmQ/2tICoJz+qfbZZyCbvEi6vvwAAyli7arRbsU7dBCNLhSX14RLt
	 ed0mhA5AcDZEN5hNRw4ShAsVWllSNCsQOqzH41/1NlKVQZIZfgfBbgcreCPliv/V/y4qW
	 UI47iSE8db0dtuVrscDku+Gtm2+H+rwBFiOBuQkxSoweFYl53TYYTeyGEVKLu//GesoGi
	 BnVwdk6HrgOSZuO2wMPBtQK8i6AnbgeFlS2gcCcPWQXxKYetxSdMAApWDOAKyfEVnpMfY
	 SpOFvVpnK8nLr4aApzOhT9T4N53rl8VgwHxCWI9MtvMJL2TGVEL5V6Lq0lOjm07zBTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lVbzR6uMdAA+K3D0QibmZzvuoySzEFN3HtJWDPbLmpY=;
	b=q+bxxu2QhLFZExzIMGkSTWJL8CVanfqWj7pspVe5VvAqMV6jE+ZBxrNi8+HXkjpOJ3qp
	 meD5I1jZQh5ksxKhZ8V7twf6Cif9s1pH9wzxvI2kQnMPP4P9CbRHNpH59YDtDWHfv4aOa
	 bLV3s6LeCTXaPPMTa4OYQ3UI+IqgphmzyxROLjAV7hkHAYpj/ZcX5Xi4KWJjrSKDZD0a/
	 R3hiG5vIH9FUKF95BI4ybTi4palmGKOBbkUwt7/Br2Jr2M2ZG56KYG3kEIJvauwzicTBj
	 7anTrRUtNEYhhkwPpWI/rUs+PwY+fjcRH1WZd9f4IT0qR8SuzVT1ilWpHjMXdw6797A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp9+JrYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5553606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp9+JrYC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCF31F000C0;
	Wed, 25 Nov 2026 20:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795638591;
	bh=lVbzR6uMdAA+K3D0QibmZzvuoySzEFN3HtJWDPbLmpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gp9+JrYCvZM9w+rCHL5TQ8/AIW/0Q4yJojopFAnVhbXCXmhVALC/PMCdQhGpN+mGP
	 NMMfwY+CEMiW/BB7/ZfAMYFkhVFuP8+1eTi3w1EuI6DrMjKd/0e1WnuPoh7BgI0nwX
	 nNMZwm6VcVd714OCtFv+myKrAWMAdEeLHOfMbKIiaN8J2Kf2QRJ0eI21YrhpTvQTAc
	 Xjq0M9F4pJwJlwYP/8STpYDaJoP+Tz9/IIl4PWymEUxq6JDODYE7j1xcIB8qjFdg5R
	 7FMD01fZIzW8Yle04SYtacK8vCuvrZ5FnrGhWaLpn2teqbovgDXZFe3ho9EpNH998M
	 fIYObSHGmKbww==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] wifi: mac80211: fix use-after-free on TTLM disconnect
Date: Wed, 25 Nov 2026 15:29:49 -0500
Message-ID: <20261125202940.1419046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-pusher-anything-a1e2@gregkh>
References: <2026112509-pusher-anything-a1e2@gregkh>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 4af2b71495a3f12196cbea1c9a502c62ada867be ]

If ieee80211_process_adv_ttlm() disconnects, and some other
changes were also detected in the beacon, the link update
to the driver is still done, leading to use-after-free. Fix
this by returning, like other functions, whether or not the
update was accepted by the function.

Cc: stable@vger.kernel.org
Fixes: 702e80470a33 ("wifi: mac80211: support handling of advertised TID-to-link mapping")
Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20261102220313.3cf5e709417b.I339967c7e614057253aa68c005d9ae220577f99a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Kept this tree's timer API and function placement, applying only the bool return change and the goto free in the beacon handler, since upstream context lines differ. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3a08bb4dfca50..d4c69a68774f8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6491,15 +6491,15 @@ ieee80211_parse_adv_t2l(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
-					  struct ieee802_11_elems *elems,
-					  u64 beacon_ts)
+static bool ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
+				       struct ieee802_11_elems *elems,
+				       u64 beacon_ts)
 {
 	u8 i;
 	int ret;
 
 	if (!ieee80211_vif_is_mld(&sdata->vif))
-		return;
+		return true;
 
 	if (!elems->ttlm_num) {
 		if (sdata->u.mgd.ttlm_info.switch_time) {
@@ -6517,14 +6517,14 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 						      0);
 			if (ret) {
 				sdata_info(sdata, "Failed setting valid/dormant links\n");
-				return;
+				return true;
 			}
 			ieee80211_vif_cfg_change_notify(sdata,
 							BSS_CHANGED_MLD_VALID_LINKS);
 		}
 		memset(&sdata->u.mgd.ttlm_info, 0,
 		       sizeof(sdata->u.mgd.ttlm_info));
-		return;
+		return true;
 	}
 
 	for (i = 0; i < elems->ttlm_num; i++) {
@@ -6536,7 +6536,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (res) {
 			__ieee80211_disconnect(sdata);
-			return;
+			return false;
 		}
 
 		if (ttlm_info.switch_time) {
@@ -6561,7 +6561,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			 * switch the AP will continue to announce it anyway.
 			 */
 			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
-				return;
+				return true;
 
 			delay_jiffies = TU_TO_JIFFIES(delay);
 
@@ -6580,9 +6580,11 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			wiphy_delayed_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
 						 delay_jiffies);
-			return;
+			return true;
 		}
 	}
+
+	return true;
 }
 
 static void
@@ -7025,8 +7027,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					       elems->cisco_dtpc_elem);
 
 	ieee80211_ml_reconfiguration(sdata, elems);
-	ieee80211_process_adv_ttlm(sdata, elems,
-				      le64_to_cpu(mgmt->u.beacon.timestamp));
+	if (!ieee80211_process_adv_ttlm(sdata, elems,
+					le64_to_cpu(mgmt->u.beacon.timestamp)))
+		goto free;
 
 	ieee80211_link_info_change_notify(sdata, link, changed);
 free:
-- 
2.53.0

