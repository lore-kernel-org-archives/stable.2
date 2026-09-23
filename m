Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8914A35E958
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127599; cv=none; b=bZLQUpjz7fREgF3VdgC6PAKq6Im28fA0tdjtJ+z3Isv8taF5a3h2XeBqiZE4C7kqRfly5IlDZvHnmLqVTfvVhndOKAhsVWfPmnUs2Fqd87Gu1V+mqtrr7/2pZo/PjBwFwXCNQEyAtKvedf9qP1Uql4YIEI7YYOKJ7s5oNmDH72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127599; c=relaxed/simple;
	bh=lAr1uc4Ko2lYrNSqNaT4tlXxrAboWFD7pCfAJckQb0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IzuM1LeUfMc8LMMTeb6GfJotX8YUmbnGqJKEcJZWtkejzLFJgYWBQVPkZA9Is2869XuyvMGLUGE81EDLIJC85FelpclYTsTsE/9gus/6tLvngObiCkETBUYtAbARIPqN4DOUAEYQHCZt+PGo9fDoAM2yHpNtkRVWKPdyapKnNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnNI6JGe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnNI6JGe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A271F00898;
	Wed, 23 Sep 2026 01:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127597;
	bh=l/+Um4TW6UxhBhcL+/CnQHBvINPleeawtOMEgmr7B60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fnNI6JGepbT7D++X7yNCxUfMKmSwNLNwkcJ5ziNjeI3vzBbybK/aUB2Qc63PGq/8B
	 UmP032ieDHhKpYn1dKfR3QDeVEz6uyH/old6ubTSu6+yeiQztrv0Ixshc43NaFFs9U
	 c9DGmZCqOITe4WMzmMFSYXAIMqRNKaRw2h5Ec7g1rKMjm1fuFUHB8ammIjelZzo5yu
	 l4YrbjAu+3OK5hoY/5DQyISysKpNHpWprWEsm/05aDFA+LIlnbmWItuuCeuobOtGsy
	 K0Drc2GNTBynNSKjlwISOzeGkBCjYWaG3pJ0ZkPuAuL01flhOqT4FSswhh3W6bWNbZ
	 XVcqecGZW94+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] wifi: cfg80211: pass net_device to .set_monitor_channel
Date: Tue, 22 Sep 2026 21:39:53 -0400
Message-ID: <20260923013955.878331-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092223-support-ladylike-66dd@gregkh>
References: <2026092223-support-ladylike-66dd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 9c4f830927750a2bf9fd9426a5257f0fdce3b662 ]

Preparation for allowing multiple monitor interfaces with different channels
on a multi-radio wiphy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://patch.msgid.link/35fa652dbfebf93343f8b9a08fdef0467a2a02dc.1728462320.git-series.nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Stable-dep-of: 2b04d6556964 ("wifi: mac80211: refuse to make a monitor active when it has no queue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c        |  1 +
 drivers/net/wireless/marvell/libertas/cfg.c        |  1 +
 drivers/net/wireless/microchip/wilc1000/cfg80211.c |  3 ++-
 include/net/cfg80211.h                             |  1 +
 net/mac80211/cfg.c                                 |  1 +
 net/wireless/chan.c                                |  3 ++-
 net/wireless/core.h                                |  1 +
 net/wireless/nl80211.c                             |  2 +-
 net/wireless/rdev-ops.h                            |  5 +++--
 net/wireless/trace.h                               | 10 ++++++----
 net/wireless/wext-compat.c                         |  2 +-
 11 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 40f9a7ef8980e..750738ab8cca4 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -1496,6 +1496,7 @@ int wil_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 }
 
 static int wil_cfg80211_set_channel(struct wiphy *wiphy,
+				    struct net_device *dev,
 				    struct cfg80211_chan_def *chandef)
 {
 	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
diff --git a/drivers/net/wireless/marvell/libertas/cfg.c b/drivers/net/wireless/marvell/libertas/cfg.c
index 5f0fef67fa841..6b419a2deed61 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -443,6 +443,7 @@ static int lbs_add_wpa_tlv(u8 *tlv, const u8 *ie, u8 ie_len)
  */
 
 static int lbs_cfg_set_monitor_channel(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef)
 {
 	struct lbs_private *priv = wiphy_priv(wiphy);
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 6f3245a43aef1..30d57f4007cc6 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -233,6 +233,7 @@ struct wilc_vif *wilc_get_wl_to_vif(struct wilc *wl)
 }
 
 static int set_channel(struct wiphy *wiphy,
+		       struct net_device *dev,
 		       struct cfg80211_chan_def *chandef)
 {
 	struct wilc *wl = wiphy_priv(wiphy);
@@ -1430,7 +1431,7 @@ static int start_ap(struct wiphy *wiphy, struct net_device *dev,
 	struct wilc_vif *vif = netdev_priv(dev);
 	int ret;
 
-	ret = set_channel(wiphy, &settings->chandef);
+	ret = set_channel(wiphy, dev, &settings->chandef);
 	if (ret != 0)
 		netdev_err(dev, "Error in setting channel\n");
 
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index f39a60475c24c..24c7c47be8a50 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4433,6 +4433,7 @@ struct cfg80211_ops {
 					     struct ieee80211_channel *chan);
 
 	int	(*set_monitor_channel)(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef);
 
 	int	(*scan)(struct wiphy *wiphy,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0d5ddd3d2c5fc..a68731e33f15e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -907,6 +907,7 @@ static int ieee80211_get_station(struct wiphy *wiphy, struct net_device *dev,
 }
 
 static int ieee80211_set_monitor_channel(struct wiphy *wiphy,
+					 struct net_device *dev,
 					 struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_local *local = wiphy_priv(wiphy);
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 0b7e81db383d4..b3d648d84fc8f 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1389,6 +1389,7 @@ bool cfg80211_reg_can_beacon_relax(struct wiphy *wiphy,
 EXPORT_SYMBOL(cfg80211_reg_can_beacon_relax);
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
 				 struct cfg80211_chan_def *chandef)
 {
 	if (!rdev->ops->set_monitor_channel)
@@ -1396,7 +1397,7 @@ int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
 	if (!cfg80211_has_monitors_only(rdev))
 		return -EBUSY;
 
-	return rdev_set_monitor_channel(rdev, chandef);
+	return rdev_set_monitor_channel(rdev, dev, chandef);
 }
 
 bool cfg80211_any_usable_channels(struct wiphy *wiphy,
diff --git a/net/wireless/core.h b/net/wireless/core.h
index 987c41b12856a..7f443abaabfb9 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -535,6 +535,7 @@ static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 }
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
 				 struct cfg80211_chan_def *chandef);
 
 int ieee80211_get_ratemask(struct ieee80211_supported_band *sband,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bb2d19057480b..c05710d65de44 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3422,7 +3422,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_MESH_POINT:
 		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
 	case NL80211_IFTYPE_MONITOR:
-		return cfg80211_set_monitor_channel(rdev, &chandef);
+		return cfg80211_set_monitor_channel(rdev, dev, &chandef);
 	default:
 		break;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index df7f88ca0db38..8da2e56b6ca14 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -433,11 +433,12 @@ rdev_libertas_set_mesh_channel(struct cfg80211_registered_device *rdev,
 
 static inline int
 rdev_set_monitor_channel(struct cfg80211_registered_device *rdev,
+			 struct net_device *dev,
 			 struct cfg80211_chan_def *chandef)
 {
 	int ret;
-	trace_rdev_set_monitor_channel(&rdev->wiphy, chandef);
-	ret = rdev->ops->set_monitor_channel(&rdev->wiphy, chandef);
+	trace_rdev_set_monitor_channel(&rdev->wiphy, dev, chandef);
+	ret = rdev->ops->set_monitor_channel(&rdev->wiphy, dev, chandef);
 	trace_rdev_return_int(&rdev->wiphy, ret);
 	return ret;
 }
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index f325ca28facea..d0b2886ed251f 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1209,19 +1209,21 @@ TRACE_EVENT(rdev_libertas_set_mesh_channel,
 );
 
 TRACE_EVENT(rdev_set_monitor_channel,
-	TP_PROTO(struct wiphy *wiphy,
+	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev,
 		 struct cfg80211_chan_def *chandef),
-	TP_ARGS(wiphy, chandef),
+	TP_ARGS(wiphy, netdev, chandef),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
+		NETDEV_ENTRY
 		CHAN_DEF_ENTRY
 	),
 	TP_fast_assign(
 		WIPHY_ASSIGN;
+		NETDEV_ASSIGN;
 		CHAN_DEF_ASSIGN(chandef);
 	),
-	TP_printk(WIPHY_PR_FMT ", " CHAN_DEF_PR_FMT,
-		  WIPHY_PR_ARG, CHAN_DEF_PR_ARG)
+	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", " CHAN_DEF_PR_FMT,
+		  WIPHY_PR_ARG, NETDEV_PR_ARG, CHAN_DEF_PR_ARG)
 );
 
 TRACE_EVENT(rdev_auth,
diff --git a/net/wireless/wext-compat.c b/net/wireless/wext-compat.c
index 2fec3606f8479..b15224d7d36d4 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -838,7 +838,7 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
 			ret = -EINVAL;
 			break;
 		}
-		ret = cfg80211_set_monitor_channel(rdev, &chandef);
+		ret = cfg80211_set_monitor_channel(rdev, dev, &chandef);
 		break;
 	case NL80211_IFTYPE_MESH_POINT:
 		freq = cfg80211_wext_freq(wextfreq);
-- 
2.53.0

