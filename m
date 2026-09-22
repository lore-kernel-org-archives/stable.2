Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06E650129B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112219; cv=none; b=IBPYjKhqehBque0PwnHPeNckrQTDqMo24PxW0HsmZQIAFDHbgiFhJU3Aa6TxaCW13BGr4uztxzf8hq9AkldaCPMBzXLZ77JCPmtNvAduGpBxhCNTs32vh1nba8IuHAZZkT/9CxydexwqZdfQYDG+7YePLbrOT+AWE17OwlVOaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112219; c=relaxed/simple;
	bh=MC/3wrVhZm8f/0PTMiEf0mXKNM5riCUjmHNycCBkLAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlGyulcY5lM+UbSlwahx5PBqkAMl3Pj2mkSygoUVsvZLUkiSrGqbgiqkc4UG1dwgTIdCj+OeNfivrTDV5nkXkka4xWm7ErGCJmpHtZu7dgPHVrNrOw00d+dpuAKxYwBIQc8o1L93NIyczKFM7G/4m9Li2KrseNq3p0Le8pfHUWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwRxwf67; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwRxwf67"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78A41F00898;
	Tue, 22 Sep 2026 21:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112199;
	bh=lmHLarJvvlPN9S0By2JUHYf9PLw+OP5ra0mVBJt1D4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TwRxwf676DBBfXu1ezLHDzLu3XaUVyHvg1/Zvt2GFjJ29BYvlAH5Mua0FHA1iAt3d
	 NKMrJ6xxzP+QXc2iFBgxB6LQqR6H3Z4QWDZkeo1SBnuoYROf8my+11U4mfdi+gkfhF
	 KPZsi+yBv1vUK6dTD0TvuzGcem+5mbRgm2YRBuxDGfwo1kpNH71Z1uUfXMVCJLtvEM
	 WUMpNd3lp18iZL9LvNFfBwVFPYDK9+/CJHTtHRaWLNRRDBcfkio8XTRpujBSIMX2VM
	 2b+7L5IGmRrf6i2GbPjluisNsg1uDb1RBrmY/gqEWrw4QGCaG70oPRsYUdg6XSLCQB
	 gLEPWImmsGz+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Tue, 22 Sep 2026 17:23:15 -0400
Message-ID: <20260922212316.751278-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922212316.751278-1-sashal@kernel.org>
References: <2026092222-setback-rupture-f2fe@gregkh>
 <20260922212316.751278-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit a5aa46f1ac4f53e03b9b75cbf55634131f2f8cac ]

For monitoring, userspace will try to configure the VIF sdata, while the
driver may see the monitor_sdata that is created when only monitor
interfaces are up. This causes the odd situation that it may not be
possible to store the MU-MIMO configuration on monitor_sdata.

Fix this by storing that information on the VIF sdata and updating the
monitor_sdata when available and the interface is up. Also, adjust the
code that adds monitor_sdata so that it will configure MU-MIMO based on
the newly added interface or one of the existing ones.

This should give a mostly consistent behaviour when configuring MU-MIMO
on sniffer interfaces. Should the user configure MU-MIMO on multiple
sniffer interfaces, then mac80211 will simply select one of the
configurations. This behaviour should be good enough and avoids breaking
user expectations in the common scenarios.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251110141514.677915f8f6bb.If4e04a57052f9ca763562a67248b06fd80d0c2c1@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Backport notes for 6.6:
Keep the MU-MIMO configuration on the userspace VIF while it is down and
copy it to the virtual monitor when it is created or reconfigured. Drop
NO_VIRTUAL_MONITOR branches because this tree only has WANT_MONITOR_VIF.
Keep the existing monitor counter and virtual-monitor creation conditions;
opening another passive monitor also updates an existing virtual monitor.
Use u.mntr.list when walking mon_list, matching this tree's list linkage.
Update the existing wake_up call in ieee80211_reconfig() instead of adding
a second call at the newer upstream location. No functions are added.

Also complete the preceding .set_monitor_channel API conversion for the
orinoco driver, which exists in 6.6 but was already removed upstream.
Its existing callback needs the new net_device argument to match
cfg80211_ops and build with incompatible-pointer-type errors enabled.

This retains the validation block needed for target 2b04d6556964
("wifi: mac80211: refuse to make a monitor active when it has no queue")
to cherry-pick cleanly, without importing newer monitor infrastructure.

Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intersil/orinoco/cfg.c |  1 +
 net/mac80211/cfg.c                          | 39 +++++++++++++-----
 net/mac80211/ieee80211_i.h                  |  3 +-
 net/mac80211/iface.c                        | 44 ++++++++++++++++++---
 net/mac80211/util.c                         |  3 +-
 5 files changed, 72 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/intersil/orinoco/cfg.c b/drivers/net/wireless/intersil/orinoco/cfg.c
index b2d5ec8634b5d..a5c06bdca7cde 100644
--- a/drivers/net/wireless/intersil/orinoco/cfg.c
+++ b/drivers/net/wireless/intersil/orinoco/cfg.c
@@ -162,6 +162,7 @@ static int orinoco_scan(struct wiphy *wiphy,
 }
 
 static int orinoco_set_monitor_channel(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef)
 {
 	struct orinoco_private *priv = wiphy_priv(wiphy);
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b3eddf2d7d6dd..b1176e9d81d48 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -63,12 +63,14 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->vif.bss_conf.mu_group.position,
 		       params->vht_mumimo_groups + WLAN_MEMBERSHIP_LEN,
 		       WLAN_USER_POSITION_LEN);
-		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
-						  BSS_CHANGED_MU_GROUPS);
+
 		/* don't care about endianness - just check for 0 */
 		memcpy(&membership, params->vht_mumimo_groups,
 		       WLAN_MEMBERSHIP_LEN);
 		mu_mimo_groups = membership != 0;
+
+		/* Unset following if configured explicitly */
+		eth_broadcast_addr(sdata->u.mntr.mu_follow_addr);
 	}
 
 	if (params->vht_mumimo_follow_addr) {
@@ -76,16 +78,26 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 			is_valid_ether_addr(params->vht_mumimo_follow_addr);
 		ether_addr_copy(sdata->u.mntr.mu_follow_addr,
 				params->vht_mumimo_follow_addr);
+
+		/* Unset current membership until a management frame is RXed */
+		memset(sdata->vif.bss_conf.mu_group.membership, 0,
+		       WLAN_MEMBERSHIP_LEN);
 	}
 
 	sdata->vif.bss_conf.mu_mimo_owner = mu_mimo_groups || mu_mimo_follow;
+
+	/* Notify only after setting mu_mimo_owner */
+	if (sdata->vif.bss_conf.mu_mimo_owner &&
+	    sdata->flags & IEEE80211_SDATA_IN_DRIVER)
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MU_GROUPS);
 }
 
 static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 				     struct vif_params *params)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *monitor_sdata;
+	struct ieee80211_sub_if_data *monitor_sdata = NULL;
 
 	/* check flags first */
 	if (params->flags && ieee80211_sdata_running(sdata)) {
@@ -104,18 +116,25 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
-	/* also validate MU-MIMO change */
-	monitor_sdata = wiphy_dereference(local->hw.wiphy,
-					  local->monitor_sdata);
-
-	if (!monitor_sdata &&
+	/* validate whether MU-MIMO can be configured */
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
 		return -EOPNOTSUPP;
 
+	/* Also update dependent monitor_sdata if required */
+	if (test_bit(SDATA_STATE_RUNNING, &sdata->state))
+		monitor_sdata = wiphy_dereference(local->hw.wiphy,
+						  local->monitor_sdata);
+
 	/* apply all changes now - no failures allowed */
 
-	if (monitor_sdata)
-		ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF)) {
+		/* This is copied in when the VIF is activated */
+		ieee80211_set_mu_mimo_follow(sdata, params);
+
+		if (monitor_sdata)
+			ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	}
 
 	if (params->flags) {
 		if (ieee80211_sdata_running(sdata)) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 639268d70f96d..f08cfbdc7143b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2027,7 +2027,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index d4a554d6d5de5..13721f4dadda4 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -761,8 +761,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 }
 
 static void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
@@ -1167,7 +1168,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -1178,8 +1180,10 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (local->monitor_sdata)
-		return 0;
+	/* Already have a monitor set up, configure it */
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
+	if (sdata)
+		goto configure_monitor;
 
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
 	if (!sdata)
@@ -1236,6 +1240,32 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
+configure_monitor:
+	/* Copy in the MU-MIMO configuration if set */
+	if (!creator_sdata) {
+		struct ieee80211_sub_if_data *other;
+
+		list_for_each_entry(other, &local->mon_list, u.mntr.list) {
+			if (!other->vif.bss_conf.mu_mimo_owner)
+				continue;
+
+			creator_sdata = other;
+			break;
+		}
+	}
+
+	if (creator_sdata && creator_sdata->vif.bss_conf.mu_mimo_owner) {
+		sdata->vif.bss_conf.mu_mimo_owner = true;
+		memcpy(&sdata->vif.bss_conf.mu_group,
+		       &creator_sdata->vif.bss_conf.mu_group,
+		       sizeof(sdata->vif.bss_conf.mu_group));
+		memcpy(&sdata->u.mntr.mu_follow_addr,
+		       creator_sdata->u.mntr.mu_follow_addr, ETH_ALEN);
+
+		ieee80211_link_info_change_notify(sdata, &sdata->deflink,
+						  BSS_CHANGED_MU_GROUPS);
+	}
+
 	return 0;
 }
 
@@ -1393,8 +1423,10 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
-		} else if (local->monitors == 0 && local->open_count == 0) {
-			res = ieee80211_add_virtual_monitor(local);
+		} else if (local->monitor_sdata ||
+			   (local->monitors == 0 && local->open_count == 0)) {
+			/* Add the first virtual monitor or update its configuration. */
+			res = ieee80211_add_virtual_monitor(local, sdata);
 			if (res)
 				goto err_stop;
 		}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 3a3cd09bdab65..472b37f8fde50 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2908,8 +2908,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count && local->monitors > 0)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
-- 
2.53.0

