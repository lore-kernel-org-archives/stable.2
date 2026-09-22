Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17997488DB6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101287; cv=none; b=fe+6m39SwzdmASKaWb8SK2KD+j/YF69g0MrEeDOVOE97u9zBHkPwLnsXeZwMCuOgK6SDIVJ3Qx+thEpdphQitsIFah7c+UPSXbxyoUcRNfktlMCmUFSJGAsTs9C6H89EnJVy+QiUocynZPwMYYiecs4e+v400LcIeuhRR2FHyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101287; c=relaxed/simple;
	bh=SvPGw52Zmr5KiKa15Ftqr4Mky5RsnKqxhlgmIUib2bI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1RBfmKQyktejfMXrGlulwcL1U6EcQZZrP7oL2PGiPiauadV45UX8NhSFTZtahc1aldq7D8UHu+JQqKoCx6uodN9VvbiI1NHTVqAHbUvDSO1rUlIFLuMMWi7YRvUtEgpWTu+5qqmvE4h24lGxjJJHlAdukGSHxAq4i0MeCgFS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4sS1U65; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4sS1U65"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC5D1F00893;
	Tue, 22 Sep 2026 18:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101286;
	bh=/3v3goIQJ1n8kcQt4ulWff6tSHCVEXKQZGLlcaGQYkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4sS1U65Ese8yPhSGTo7edDvpFIBe+4XgZerJn3pMgXAAuf/AHdR+D6fH0WRvx6hZ
	 D+vwe6G3Da1Jv6fpXlNIW+4vY/2L9kfzxtPy0pjQsLtZXf2E9ZdJ+vnYRiF42w6etB
	 RNZVOsWFa6htie6ii+Iv7XDacH8ZWl/mHo9NKsTSMQzTh2hXvaRLDkmRTZeehQHnzz
	 IvPu6GOjwSlOLn6Oyd2155UqilNjn6ZU9mKiKcHIK3rCs7msbbYT/wQSph7TyTlPlE
	 c+z2bW1hFA/wvI5NXoNj1/BtFKJJjR0k7IAG2oZXuXAmFSt8QcFYN61qCTImz5MvOC
	 mb6nr8pppyflg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Tue, 22 Sep 2026 14:21:23 -0400
Message-ID: <20260922182124.3570726-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092221-dislodge-perfume-02cd@gregkh>
References: <2026092221-dislodge-perfume-02cd@gregkh>
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
Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 47 ++++++++++++++++++++++++++------------
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 46 ++++++++++++++++++++++++++++++++-----
 net/mac80211/util.c        |  3 ++-
 4 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 72c9d5aceae58..2aacbbb974139 100644
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
@@ -103,23 +115,28 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
-	/* also validate MU-MIMO change */
-	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
-		monitor_sdata = sdata;
-	else
-		monitor_sdata = wiphy_dereference(local->hw.wiphy,
-						  local->monitor_sdata);
-
-	if (!monitor_sdata &&
+	/* validate whether MU-MIMO can be configured */
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
+	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR) &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
 		return -EOPNOTSUPP;
 
+	/* Also update dependent monitor_sdata if required */
+	if (test_bit(SDATA_STATE_RUNNING, &sdata->state) &&
+	    !ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+		monitor_sdata = wiphy_dereference(local->hw.wiphy,
+						  local->monitor_sdata);
+
 	/* apply all changes now - no failures allowed */
 
-	if (monitor_sdata &&
-		(ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
-		 ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)))
-		ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	if (ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) ||
+	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR)) {
+		/* This is copied in when the VIF is activated */
+		ieee80211_set_mu_mimo_follow(sdata, params);
+
+		if (monitor_sdata)
+			ieee80211_set_mu_mimo_follow(monitor_sdata, params);
+	}
 
 	if (params->flags) {
 		if (ieee80211_sdata_running(sdata)) {
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index b0e64cf346e2b..ed625b430e738 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2114,7 +2114,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_link_data *link);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 499126317a914..7ad71c21efd46 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -751,8 +751,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, -1, hw_reconf_flags);
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 }
 
 void ieee80211_stop_mbssid(struct ieee80211_sub_if_data *sdata)
@@ -1186,7 +1187,8 @@ static void ieee80211_sdata_init(struct ieee80211_local *local,
 	ieee80211_link_init(sdata, -1, &sdata->deflink, &sdata->vif.bss_conf);
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -1194,10 +1196,14 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	ASSERT_RTNL();
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	if (local->monitor_sdata ||
-	    ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
+	if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 		return 0;
 
+	/* Already have a monitor set up, configure it */
+	sdata = wiphy_dereference(local->hw.wiphy, local->monitor_sdata);
+	if (sdata)
+		goto configure_monitor;
+
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
 	if (!sdata)
 		return -ENOMEM;
@@ -1250,6 +1256,32 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	skb_queue_head_init(&sdata->status_queue);
 	wiphy_work_init(&sdata->work, ieee80211_iface_work);
 
+configure_monitor:
+	/* Copy in the MU-MIMO configuration if set */
+	if (!creator_sdata) {
+		struct ieee80211_sub_if_data *other;
+
+		list_for_each_entry(other, &local->mon_list, list) {
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
 
@@ -1406,11 +1438,13 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			if (res)
 				goto err_stop;
 		} else {
-			if (local->virt_monitors == 0 && local->open_count == 0) {
-				res = ieee80211_add_virtual_monitor(local);
+			/* add/configure if there is no non-monitor interface */
+			if (local->virt_monitors == local->open_count) {
+				res = ieee80211_add_virtual_monitor(local, sdata);
 				if (res)
 					goto err_stop;
 			}
+
 			local->virt_monitors++;
 
 			/* must be before the call to ieee80211_configure_filter */
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index af99ac02953d9..3ed47a8ebf5cc 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2202,9 +2202,10 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 		}
 	}
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->virt_monitors > 0 &&
 	    local->virt_monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	if (!suspended)
 		return 0;
-- 
2.53.0

