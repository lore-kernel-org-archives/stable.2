Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F049E5C3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105630; cv=none; b=FTWzMXPV2ZSx/0yl8cAH+LmPjyaIcfmp0dndnhiCum4tfrRcNy2tKY4iVS5SUxfdAxoqIugMSUNNnCjuy1/3dCBDsaM5LpqjqGm+MkgP73nFVV2kHahDwuMVh+QnUMpBa8kN1+56rF+6hAxAaYakXVc2gPnRIVxyhyDx2rkud+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105630; c=relaxed/simple;
	bh=COzVcubvnEq8yZeqJNDQs3HMJllM0vhmXqWBfS3S+oI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=phAV9ofjeJZBLGTUeYcCrjWLycnD0p9CHCFyfCuClTRHxKklk0yeJbuahlm9rClalK2mmPw7CFvpKT6rmC8zBh762OOI3LIgSydrx7W6h26SkS3WeAmiH7p0IKM1+M+FX7OweBaIvePgx0jxP8cNqUOSMuArsB0Je06ae6BySOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gfHmwx0N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gfHmwx0N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D629B1F000FF;
	Tue, 22 Sep 2026 19:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105629;
	bh=U3RuhNlyRhjprEprlINjhvyENe6Jwte3QjkJXsVld1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gfHmwx0NYKgPr01gEMuju14xNHV0cKD7LWaKilLtmj1x0AKAF9PEJt2jGVxhbA9Ds
	 /z2aXJcOUy064zNfThJBCWNU9oriS/Tb4kANlfhlbXk9tFAWXgR/G2UzmPJDwZNQ70
	 82PvwPe1vbC/LOuq5cX7JiYiAuIqO4MAyFZt0NQTWnMgEGJL3XicwoEGQQqY5w+D7q
	 P4CO+4eE4Xc4nseLMLQHaaB8gRe7TZ4qmKPNczqWuSUnPaeCeN9cwQ36pz4ICsZjPs
	 t8KMxH7SkQHR7M9wCGAiZSmIdDbW3wGGLD9eLuL/mUGmULlM/wupiuwcI9LpNCACXB
	 ItFYhHUifYcdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Tue, 22 Sep 2026 15:33:46 -0400
Message-ID: <20260922193347.4153826-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092221-mashed-snippet-eb34@gregkh>
References: <2026092221-mashed-snippet-eb34@gregkh>
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

[ Backport to 6.12: omit NO_VIRTUAL_MONITOR handling, since this tree
  only exposes WANT_MONITOR_VIF. Keep the existing monitors counter and
  cooked-monitor handling, and traverse mon_list through u.mntr.list.
  Update the existing reconfiguration call at wake_up rather than adding
  the later upstream call site. All three virtual-monitor creation calls
  now pass the configuration source, or NULL to select a running monitor.

  Retain the MU-MIMO configuration changes so target 2b04d6556964
  ("wifi: mac80211: refuse to make a monitor active when it has no queue")
  merges cleanly on top. No new functions are introduced. ]

Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 39 +++++++++++++++++++++++++---------
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 43 ++++++++++++++++++++++++++++++++------
 net/mac80211/util.c        |  3 ++-
 4 files changed, 70 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f6c5de994898c..02552b7ce01db 100644
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
 
-	if (monitor_sdata && ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF))
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
index 3b00b3f9f17dd..b811713b0e0ba 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2045,7 +2045,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7a79b40d23b36..2b33f481a8554 100644
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
@@ -1159,7 +1160,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -1167,8 +1169,10 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
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
@@ -1222,6 +1226,32 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
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
 
@@ -1376,8 +1406,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
-		} else if (local->monitors == 0 && local->open_count == 0) {
-			res = ieee80211_add_virtual_monitor(local);
+		} else if (local->monitors == local->open_count) {
+			/* add/configure if there is no non-monitor interface */
+			res = ieee80211_add_virtual_monitor(local, sdata);
 			if (res)
 				goto err_stop;
 		}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8ffd7e0643751..2dfb9c089b470 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2144,8 +2144,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count && local->monitors > 0)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
-- 
2.53.0

