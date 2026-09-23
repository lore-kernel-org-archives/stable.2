Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7924136B054
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132666; cv=none; b=USgm58WKeiZY4DoFbx7TkdmjI+T717xNnFOcIx/1qbPmeN4jz+LMsWBv7ABJg2fNxoE2CrKdqeWpRvPTZAgCTsQHx+7KSsvSJLDr/HICJ8JjWhtCyIrykw5pVEkuWaQ+jlrW3z57gYAnxqQy1CcQUr/uzS6H1cDPHxKNsHLybvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132666; c=relaxed/simple;
	bh=C3e5BVN9h/rlv6kTn4ln62g/Iv8uN3hETVOMTJA7UrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhKDPGi9PDXQqRk7/xsvMFq2vKvewz7jninPNp1xQIFrtcnxXVu4HbAeWAO+y82ChPybO56/VBHktEQKSj7RdkFuqJvMZQAeAVwajUhecziAY/BPTRPye0WmLTb2yLlAVLqKoD2lVvPefIuH+hfqlc9oZNQAiA9f5nAj4QQ74PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7GK6TPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7GK6TPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FC21F000FF;
	Wed, 23 Sep 2026 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790132665;
	bh=KazGvjNHnCj7Qn93st0jjMLQFBE9KLXLsEXu04KROJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7GK6TPlQ7LI3r6pni+Of+9DhXIXJLh6ZQwoxSKrTBhVxEqBTuGkDlt2KtmuY5gCq
	 97GNIh9XKUZmUI8ErfsMoGtJNNk6hwrY7DDQYCOcgt+SS6VwgJUNIXU3g9TEYOfqT5
	 y2rmXybu+BEGZcia5hOt0FZY04yNMl3qtpj7mpaWVZxi16QWJgMAkG8cXj7MY6uWjg
	 sDbsHrnGacaVFXDRFk3GTi1zpCXTCy9nSzKcJJlicf7Bm43cIT0hYJXMwkyAdvkbPw
	 gntE/7P7xgkbztfDBKuewkA+72ec3cry+FQjSaJOuyb8TnKgPFe/rL4qiYee6BaoeO
	 6Jj63ljwlksRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] wifi: mac80211: track MU-MIMO configuration on disabled interfaces
Date: Tue, 22 Sep 2026 23:04:21 -0400
Message-ID: <20260923030422.1050587-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092224-stonework-unpicked-99d1@gregkh>
References: <2026092224-stonework-unpicked-99d1@gregkh>
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

[Backport to 5.10: retain MU-MIMO configuration on the user monitor
interface and copy it to the virtual monitor on activation or reconfiguration.
Use vif.mu_mimo_owner, ieee80211_bss_info_change_notify(), and
rtnl_dereference() in place of the newer link and wiphy APIs. Omit
NO_VIRTUAL_MONITOR handling, which does not exist in this tree, and retain
the existing monitors counter and initialization paths. Preserve the
original virtual monitor creation condition, since monitors includes active
monitors in 5.10, while allowing an existing virtual monitor to be
reconfigured. Traverse mon_list using u.mntr.list and update the existing
wake_up reconfiguration call site
instead of adding the newer duplicate call. No new functions are added.
This also supplies the MU-MIMO validation context needed for the subsequent
monitor TXQ guard in 2b04d6556964.]

Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/cfg.c         | 35 ++++++++++++++++++++++++-------
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/iface.c       | 43 ++++++++++++++++++++++++++++++++------
 net/mac80211/util.c        |  3 ++-
 4 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f2629e56d1a59..88a49bbcad36c 100644
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
@@ -79,17 +91,24 @@ static int ieee80211_set_mon_options(struct ieee80211_sub_if_data *sdata,
 			return -EBUSY;
 	}
 
-	/* also validate MU-MIMO change */
-	monitor_sdata = rtnl_dereference(local->monitor_sdata);
-
-	if (!monitor_sdata &&
+	/* validate whether MU-MIMO can be configured */
+	if (!ieee80211_hw_check(&local->hw, WANT_MONITOR_VIF) &&
 	    (params->vht_mumimo_groups || params->vht_mumimo_follow_addr))
 		return -EOPNOTSUPP;
 
+	/* Also update dependent monitor_sdata if required */
+	if (test_bit(SDATA_STATE_RUNNING, &sdata->state))
+		monitor_sdata = rtnl_dereference(local->monitor_sdata);
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
index 2da452ec53288..6e81873c2d007 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1796,7 +1796,8 @@ void ieee80211_adjust_monitor_flags(struct ieee80211_sub_if_data *sdata,
 				    const int offset);
 int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up);
 void ieee80211_sdata_stop(struct ieee80211_sub_if_data *sdata);
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local);
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata);
 void ieee80211_del_virtual_monitor(struct ieee80211_local *local);
 
 bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9abec4f929ca0..faa1e277578e3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -662,8 +662,9 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 	ieee80211_configure_filter(local);
 	ieee80211_hw_config(local, hw_reconf_flags);
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 }
 
 static int ieee80211_stop(struct net_device *dev)
@@ -934,7 +935,8 @@ static void ieee80211_set_default_queues(struct ieee80211_sub_if_data *sdata)
 	sdata->vif.cab_queue = IEEE80211_INVAL_HW_QUEUE;
 }
 
-int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
+int ieee80211_add_virtual_monitor(struct ieee80211_local *local,
+				  struct ieee80211_sub_if_data *creator_sdata)
 {
 	struct ieee80211_sub_if_data *sdata;
 	int ret;
@@ -944,8 +946,10 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 
 	ASSERT_RTNL();
 
-	if (local->monitor_sdata)
-		return 0;
+	/* Already have a monitor set up, configure it */
+	sdata = rtnl_dereference(local->monitor_sdata);
+	if (sdata)
+		goto configure_monitor;
 
 	sdata = kzalloc(sizeof(*sdata) + local->hw.vif_data_size, GFP_KERNEL);
 	if (!sdata)
@@ -998,6 +1002,31 @@ int ieee80211_add_virtual_monitor(struct ieee80211_local *local)
 	skb_queue_head_init(&sdata->skb_queue);
 	INIT_WORK(&sdata->work, ieee80211_iface_work);
 
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
 
@@ -1154,8 +1183,10 @@ int ieee80211_do_open(struct wireless_dev *wdev, bool coming_up)
 			res = drv_add_interface(local, sdata);
 			if (res)
 				goto err_stop;
-		} else if (local->monitors == 0 && local->open_count == 0) {
-			res = ieee80211_add_virtual_monitor(local);
+		} else if (local->monitor_sdata ||
+			   (local->monitors == 0 && local->open_count == 0)) {
+			/* add the first monitor or configure the existing one */
+			res = ieee80211_add_virtual_monitor(local, sdata);
 			if (res)
 				goto err_stop;
 		}
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7cb32340108e3..f11c7c6cb98cf 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2610,8 +2610,9 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 
  wake_up:
 
+	/* Passing NULL means an interface is picked for configuration */
 	if (local->monitors == local->open_count && local->monitors > 0)
-		ieee80211_add_virtual_monitor(local);
+		ieee80211_add_virtual_monitor(local, NULL);
 
 	/*
 	 * Clear the WLAN_STA_BLOCK_BA flag so new aggregation
-- 
2.53.0

