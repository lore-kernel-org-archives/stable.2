Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB337BE98
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 02:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790129797; cv=none; b=hRl1abZ1qtzaxHcMLQmx8xxV8aqGVUbDUjweyQP8gpELeyMOHOtvRtMWp19W+gBKONYJ0SC28zJe9FGp9MJSknA7syXX5wNjMtgXJsbSFHlTfbTDh3mC2LJPPOVsc07+L2IdbIbutLwnt01LP8G7J7Ucd9PpQsOgG9bpZrc/j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790129797; c=relaxed/simple;
	bh=bpCK04TjI+Ng9cfjBfI4Byjw8m4Y9ZMIC4NUQPR/tDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6QZummfLpv3LpKKhAPmjxoZNdVjIvF6Sn4z59hyJKQh/UKdQRxzNXdlFFSVCvobw8yPIGYignuVnmHEAlmfzk6+wGbOOrk/b6DKIunfhKuWUkhsBT8DwPlGFEMMEKsFs3CF/zPL1hFyOH7SP8Ma2m/O71NXM78RhZlqpze3+qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHS9aEb8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHS9aEb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9B71F000FF;
	Wed, 23 Sep 2026 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790129796;
	bh=IzN3UeOGR3Qr3BUc1krz/LAgB3OkmAY8N/DFR5aIXZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PHS9aEb8d7hV+WsVGEDP9r0ET42CxC1LHwterJphzyhZATSNrK5nKP45Iq1w/cVpH
	 X5e2T/ytqOQpFb4yrLDH7v9zoHDX6yVhbmBlfIHRiYk+W9IkohM7AaHf81v2CUVAcM
	 bZr8bHamtbEBfDSRgmyra3inv8ZZpR02BhhswXVN9Pn3kzLx0g2Q1kMp0UO2+h/+ci
	 0vKI3avKb8d2tRUZds7Ky0+depL7/xdxwp1npRuNMq8S+bdGWsig6qzswUm0hnuNsz
	 OYomCnqJ+bobr/n+EK+HNT7rbMO3W55BGn5hBGRsKm0MQFR4j6E+EjZkbEp1LYBJxW
	 ClwxwSlfl/R8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Tue, 22 Sep 2026 22:16:32 -0400
Message-ID: <20260923021633.902921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092224-dawdler-equator-70f2@gregkh>
References: <2026092224-dawdler-equator-70f2@gregkh>
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

Backport adaptation for 5.15, as a dependency of 2b04d6556964
("wifi: mac80211: refuse to make a monitor active when it has no queue"):

Use vif.mu_mimo_owner and ieee80211_bss_info_change_notify() instead of
the newer link-specific state and notification API. Gate MU-MIMO support
on WANT_MONITOR_VIF; this tree has no NO_VIRTUAL_MONITOR mode. Preserve
its cooked-monitor checks and existing monitor accounting.

Use u.mntr.list to walk this tree's monitor list. Pass the creator when
opening a monitor, and select an existing configuration when stopping an
interface or reconfiguring hardware. Update the existing wake_up call in
ieee80211_reconfig() instead of adding the newer, relocated call site.
No new functions are introduced.

Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 37 +++++++++++++++++++++++++--------
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 42 ++++++++++++++++++++++++++++++++------
 net/mac80211/util.c        |  3 ++-
 4 files changed, 68 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 706ff67f4254a..c019dd9af6866 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -39,11 +39,14 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 		memcpy(sdata->vif.bss_conf.mu_group.position,
 		       params->vht_mumimo_groups + WLAN_MEMBERSHIP_LEN,
 		       WLAN_USER_POSITION_LEN);
-		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MU_GROUPS);
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
@@ -51,16 +54,25 @@ static void ieee80211_set_mu_mimo_follow(struct ieee80211_sub_if_data *sdata,
 			is_valid_ether_addr(params->vht_mumimo_follow_addr);
 		ether_addr_copy(sdata->u.mntr.mu_follow_addr,
 				params->vht_mumimo_follow_addr);
+
+		/* Unset current membership until a management frame is RXed */
+		memset(sdata->vif.bss_conf.mu_group.membership, 0,
+		       WLAN_MEMBERSHIP_LEN);
 	}
 
 	sdata->vif.mu_mimo_owner = mu_mimo_groups || mu_mimo_follow;
+
+	/* Notify only after setting mu_mimo_owner */
+	if (sdata->vif.mu_mimo_owner &&
+	    sdata->flags & IEEE80211_SDATA_IN_DRIVER)
+		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MU_GROUPS);
 }
 
 static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 				     struct vif_params *params)
 {
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_sub_if_data *monitor_sdata;
+	struct ieee80211_sub_if_data *monitor_sdata = NULL;
 
 	/* check flags first */
 	if (params->flags && ieee80211_sdata_running(sdata)) {
@@ -79,18 +91,25 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
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
index 306359d435717..a168e52d63c9c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1963,7 +1963,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3b2d51df5d947..01791a9866a72 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -652,8 +652,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 }
 
 static int ieee80211_stop(struct net_device *dev)
@@ -947,7 +948,8 @@ static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -958,8 +960,10 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
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
@@ -1013,6 +1017,31 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
+configure_monitor:
+	/* Copy in the MU-MIMO configuration if set */
+	if (!creator_sdata) {
+		struct ieee80211_sub_if_data *other;
+
+		list_for_each_entry(other, &local->mon_list, u.mntr.list) {
+			if (!other->vif.mu_mimo_owner)
+				continue;
+
+			creator_sdata = other;
+			break;
+		}
+	}
+
+	if (creator_sdata && creator_sdata->vif.mu_mimo_owner) {
+		sdata->vif.mu_mimo_owner = true;
+		memcpy(&sdata->vif.bss_conf.mu_group,
+		       &creator_sdata->vif.bss_conf.mu_group,
+		       sizeof(sdata->vif.bss_conf.mu_group));
+		memcpy(&sdata->u.mntr.mu_follow_addr,
+		       creator_sdata->u.mntr.mu_follow_addr, ETH_ALEN);
+
+		ieee80211_bss_info_change_notify(sdata, BSS_CHANGED_MU_GROUPS);
+	}
+
 	return 0;
 }
 
@@ -1166,8 +1195,9 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
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
index 5b1799dfa6757..6ea8a14fbf6c2 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2634,8 +2634,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count && local->monitors > 0)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
-- 
2.53.0

