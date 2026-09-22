Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290AD549391
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112204; cv=none; b=lyOtnn9kkJWSFRSWUd7aMqoqxcmtSliP9h8Qr4Z8ZC9iJQDUgD3kFENVcft3znXoQT8KEHEcXJNKwTlLw5YM7VOsPrhMD45SP4+mcdP9hm72eM8yPaZ3MlTArZ9H/nEvGDuvrh5lrnf5nlnYvwja1T754jt6ty0pVh+2VDiwYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112204; c=relaxed/simple;
	bh=0SvP4iaytun6WStnUvZLKvh/3auPMRuOtYXq2aYo2tA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CiMEvRRmGlGvbMsAyqCJUm+b32NpLYFwUTa52RMThQ+W6HdAVHO1KPPEdYKqYgQ8R7L/+c/hyPfON1v6+fSDhUHyG3i44izBDkc4gQzlFPmPEGAtn9qMmcJHdcAlPOJHuC7LJwPLgGnViHPqoQLM5NVbHcRpGpVUb/X3cZuDFTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho1vzz9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho1vzz9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9091F000FF;
	Tue, 22 Sep 2026 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790112198;
	bh=4jl5YSViHF+IVakTvoVJgMCvzY9J1WAKMlLRVeOUYi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ho1vzz9T8m1g2KKnNhM5U3A6o6u+vjkvWbfMs3fQ1yBYrceMIXc3foJdRFbxWD+fP
	 o1etoPfrR3XXS2rgqlH36jKtWQQ9Z1Eng0CDQ704RbMOLxxkx0CohmWy6DLloa5+s2
	 D+JGGc+W5rqO7uzPJuKyVVjWIe99yDxOwIqcV7gKbjGsa4qCtIKairA/StxxuzdBgd
	 dalbx2sayYzUf+lOitUC8/N2z87b6kvNNvaRjJUG5ouzXMLLX63tbSgxcp5SmvmYLS
	 huy3bX3t6qaAVW3DjFgO/x1MdFEHjU3G9QaBHHH2W0v0v77VdfaXlx8YgjSD3SAz+Z
	 X3RPRBv6eL3xQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] wifi: cfg80211: pass net_device to .set_monitor_channel
Date: Tue, 22 Sep 2026 17:23:14 -0400
Message-ID: <20260922212316.751278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092222-setback-rupture-f2fe@gregkh>
References: <2026092222-setback-rupture-f2fe@gregkh>
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
index 38ad49033d0ba..a0e4d85e17dec 100644
--- a/drivers/net/wireless/marvell/libertas/cfg.c
+++ b/drivers/net/wireless/marvell/libertas/cfg.c
@@ -486,6 +486,7 @@ static int lbs_add_wps_enrollee_tlv(u8 *tlv, const u8 *ie, size_t ie_len)
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
index 5b3a63c377d60..acf8ed60d5060 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4513,6 +4513,7 @@ struct cfg80211_ops {
 					     struct ieee80211_channel *chan);
 
 	int	(*set_monitor_channel)(struct wiphy *wiphy,
+				       struct net_device *dev,
 				       struct cfg80211_chan_def *chandef);
 
 	int	(*scan)(struct wiphy *wiphy,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 16270bea49a2f..b3eddf2d7d6dd 100644
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
index f0a3a23176385..038a3736f6b06 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -535,6 +535,7 @@ static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 }
 
 int cfg80211_set_monitor_channel(struct cfg80211_registered_device *rdev,
+				 struct net_device *dev,
 				 struct cfg80211_chan_def *chandef);
 
 int ieee80211_get_ratemask(struct ieee80211_supported_band *sband,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 545f7ecaad76f..7ef5181146b1d 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3443,7 +3443,7 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 	case NL80211_IFTYPE_MESH_POINT:
 		return cfg80211_set_mesh_channel(rdev, wdev, &chandef);
 	case NL80211_IFTYPE_MONITOR:
-		return cfg80211_set_monitor_channel(rdev, &chandef);
+		return cfg80211_set_monitor_channel(rdev, dev, &chandef);
 	default:
 		break;
 	}
diff --git a/net/wireless/rdev-ops.h b/net/wireless/rdev-ops.h
index f8f114a8dc02a..a8712e27a2516 100644
--- a/net/wireless/rdev-ops.h
+++ b/net/wireless/rdev-ops.h
@@ -445,11 +445,12 @@ rdev_libertas_set_mesh_channel(struct cfg80211_registered_device *rdev,
 
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
index df92ee4d91d1d..20ad81c46b1ba 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1222,19 +1222,21 @@ TRACE_EVENT(rdev_libertas_set_mesh_channel,
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
index 52abda40dfb3f..05dcf56fe867a 100644
--- a/net/wireless/wext-compat.c
+++ b/net/wireless/wext-compat.c
@@ -851,7 +851,7 @@ static int cfg80211_wext_siwfreq(struct net_device *dev,
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

