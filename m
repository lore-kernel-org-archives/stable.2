Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E73B41D10D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341238; cv=none; b=GAvFJ+oYZIqMUKqbZX4Y08thM5AcGeXxIAjbMPVPaz9ksCbiLqD++d06WxZoUGY2ReWXyVIrOZ9Sljld+JelExrR9ASDeKbm0Ngf/QbJM67YipIEERdVgLqyOw1V8eIftTm1Yw2NTjGljk4vu3gTq7NefcG0Gl/CVobjBwIdlls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341238; c=relaxed/simple;
	bh=Ufx/Na5ud9+HB4KmgqLZ2egUUb8IbKIAGqt4GKt4yFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdpfea1G9jUC6Gg9oCO0yoj1jLQBgbALVskBUs28+jdzV4dEpubamEndFsaiWhIxEMNRwUkpzBLuBTOyqTF+76/g3cc0J79uQyd+2yMOZ2sd1MzgiJoigfGNQhBrx3t8TPA+viY7HM8onMxUxewpKmlcPzi90usLddHpzTmjDa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKXyDqkf; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKXyDqkf"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-85339ed040aso697727b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 02:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788341234; x=1788946034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eRUAOAdoeg0ACoOZGqt1RM6QAFvC+MmIu2Q8vR/OfzI=;
        b=PKXyDqkf6VbnIabTAHzLjJVq4JNAhEiCnK0lcWXV4L2nZp/oFBEZ2BR3zlIFmm+QaA
         GAOUDw4YZSku9pbqjcXRRuHPO98U5+PjZG/wOBfFn5bdE3CIX7kl6Nb0ZTc7DRJ6ZPiY
         re5BbwC4H2SpHCG3BWyByu1c2wTR87pJ7UDkY9VgZp5eg+BuyQs+tGb6+AnCsZa1vCuY
         4cqjM6Yvg+rpS86Vtp776VIE0mJv7eGkRyOdNZfLNlgER1SBgjVxCXhfZd5OhlKMX+TR
         s9aPzll71lJFrvjdSeFInKEl61r7mJ/zR7NTjCH59DN2jgRJHLIfMRlppWm9HaHNJWka
         cCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341234; x=1788946034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eRUAOAdoeg0ACoOZGqt1RM6QAFvC+MmIu2Q8vR/OfzI=;
        b=sv7pvLi91bbWKP1o1eqlBDaUm6/Izf/pLVdOMBXWtkR2BnGhw6GtF8zl3RLD6jca01
         n+N9HPLGRHdt0bQbdCatwJv6RtyAxAiRjoX4BI2hfMTxgat+JZxN/1m5TzF+lq5wg4qj
         52MFXDXvsYBbWuN0AUxPMOXBjudWMhO6hO73YFZtzBO3aaU88vrC5W4hVpaL8vbwqqcA
         RMOX5BWK5T9Jr9RcbnIrTZZsgIIoC8pAR56PfwlH6JYzw43OboBB6PXBzfbz/qRpARRv
         fPLY5Lj3rC9Jd8iwcFbhohIsyVCKRy++B0EBO4YSLuOJoZDNMSdz3w15B0VShFkCHuef
         BuMA==
X-Forwarded-Encrypted: i=1; AKwUvBwOJG5fY4nO2g3rFQ7pTJyJkgGcPowWnuTUUcPhmgqfNZhx/xTU2eljjkwUTe/6Nju/8gtEm6k=@vger.kernel.org
X-Gm-Message-State: AFuF++mZGl6kQcQf1qBD8eGiDa3CY3sxWBtQ1a70It92TjqShKPMkD3x
	PSkjYkZ/kq3DN8nn88ghcvuyU/W8um9XMj/i50zMG8ite6X7g6tuwP0+
X-Gm-Gg: AYBFou2Ic5rd16oJ0AncTS7Kbtit8LZVddnHLItHhN2DWXoCuHyLrto+Dk7nqTCtgYx
	yzesSByHf5G/56PRD3pvbGYDI38Ry5KkkbL/S8dshCuiJApfOr0RSjpMeWuTmOQAONyU9se1802
	ZXk6vtPtowl2Rc/7pItoCMyrxJInDJ98c6FerES9RLDSwTNBg7i1/lGGjhEcBAu8bmoDjPaWTiz
	ElpRM0QaKQxeimC+/rm1SGG06yg10xQKedBI57vC/sua10Kh6ozaD72c+PXDc5Wy9PcDiuyNv/M
	BBoWXTErhvXtaS0CI76YnLFuEzXBc10ahntYv69nCxrQOoFVTpzDXWMyd2NQ/rNchpe9YVwtSV0
	2Qam12DygbkKl5SYAyUmPW48AzcOsjWJsKSgzGdn2Vk0AsU+X9Qroc3/hfa7jnqJ2+XYpy4mSBv
	AgG1KRwswIKbeqFJ7+13+2f2vsh4xJrG++PVGUULVMWNGiBEWSlSY1ZURG+nNtXdThN6DdWKhje
	T6As3A9W0gwplzgUdD2
X-Received: by 2002:a05:6a00:2183:b0:857:7384:b5f6 with SMTP id d2e1a72fcca58-85ed464053cmr5298268b3a.18.1788341233701;
        Wed, 02 Sep 2026 02:27:13 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-85dc11fae83sm1055963b3a.59.2026.09.02.02.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 02:27:13 -0700 (PDT)
Sender: Weiming Shi <thebestswings@gmail.com>
From: Weiming Shi <bestswngs@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Eliad Peller <eliad@wizery.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+36935f8953d6874a@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: mac80211: fix link STA group key use-after-free
Date: Wed,  2 Sep 2026 17:26:58 +0800
Message-ID: <20260902092658.792735-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902092658.792735-1-bestswngs@gmail.com>
References: <20260902092658.792735-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A group key installed for an MLO link STA is stored in link_sta->gtk[] and
sdata->key_list. Link STA removal currently frees the link STA without
removing these keys. A later key teardown then returns -ENOLINK before
unlinking the key, while its caller still queues the key for destruction.
This leaves a freed node on sdata->key_list and can also leave key->sta
dangling.

Remove a link STA's group keys while the link STA and driver link are still
present. During full station teardown, collect GTKs from every link
together with the pairwise keys, unlink all of them, wait for one
post-unlink network grace period, and then destroy the batch.

Also let removal of an already orphaned key reach the list unlink
bookkeeping when the link or link STA is gone. Keep -ENOLINK unchanged for
key installation.

BUG: KASAN: slab-use-after-free in ieee80211_remove_link_keys
Read of size 8 at addr ffff888028c3c818 by task exploit/5192
ieee80211_remove_link_keys (net/mac80211/key.c:1114)
ieee80211_vif_update_links (net/mac80211/link.c:192 net/mac80211/link.c:351)
ieee80211_vif_set_links (net/mac80211/link.c:408)
cfg80211_remove_link (net/wireless/util.c:2894)
nl80211_remove_link (net/wireless/nl80211.c:16312)
genl_family_rcv_msg_doit (net/netlink/genetlink.c:1117)
netlink_sendmsg (net/netlink/af_netlink.c:1889)
Kernel panic - not syncing: KASAN: panic_on_warn set ...

Fixes: ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")
Reported-by: co+36935f8953d6874a@bugs.sh
Closes: https://lore.kernel.org/linux-wireless/s6BRFbJoyNpjUBu6NC9TdJxvXM9vpQsN1FcY@bugs.sh/
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/mac80211/key.c      | 55 +++++++++++++++++++++++++++++++++++------
 net/mac80211/key.h      |  3 +++
 net/mac80211/sta_info.c |  6 +++++
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index a69617d8d1c7..b907258829f0 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -475,7 +475,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		return -EINVAL;
 
 	if (link_id >= 0) {
-		if (!link) {
+		if (!link && !sta) {
 			link = sdata_dereference(sdata->link[link_id], sdata);
 			if (!link)
 				return -ENOLINK;
@@ -484,7 +484,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 		if (sta) {
 			link_sta = rcu_dereference_protected(sta->link[link_id],
 							     lockdep_is_held(&sta->local->hw.wiphy->mtx));
-			if (!link_sta)
+			if (!link_sta && new)
 				return -ENOLINK;
 		}
 	} else {
@@ -535,7 +535,7 @@ static int ieee80211_key_replace(struct ieee80211_sub_if_data *sdata,
 			if (new &&
 			    !(new->conf.flags & IEEE80211_KEY_FLAG_NO_AUTO_TX))
 				_ieee80211_set_tx_key(new, true);
-		} else {
+		} else if (link_sta) {
 			rcu_assign_pointer(link_sta->gtk[idx], new);
 		}
 		/* Only needed for transition from no key -> key.
@@ -1183,23 +1183,57 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-void ieee80211_free_sta_keys(struct ieee80211_local *local,
-			     struct sta_info *sta)
+static void ieee80211_remove_link_sta_keys(struct ieee80211_local *local,
+					   struct link_sta_info *link_sta,
+					   struct list_head *keys)
 {
 	struct ieee80211_key *key;
 	int i;
 
 	lockdep_assert_wiphy(local->hw.wiphy);
 
-	for (i = 0; i < ARRAY_SIZE(sta->deflink.gtk); i++) {
-		key = wiphy_dereference(local->hw.wiphy, sta->deflink.gtk[i]);
+	for (i = 0; i < ARRAY_SIZE(link_sta->gtk); i++) {
+		key = wiphy_dereference(local->hw.wiphy, link_sta->gtk[i]);
 		if (!key)
 			continue;
 		ieee80211_key_replace(key->sdata, NULL, key->sta,
 				      key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE,
 				      key, NULL);
+		list_add_tail(&key->free_list, keys);
+	}
+}
+
+void ieee80211_free_link_sta_keys(struct ieee80211_local *local,
+				  struct link_sta_info *link_sta)
+{
+	struct ieee80211_key *key, *tmp;
+	LIST_HEAD(keys);
+
+	ieee80211_remove_link_sta_keys(local, link_sta, &keys);
+	if (list_empty(&keys))
+		return;
+
+	synchronize_net();
+	list_for_each_entry_safe(key, tmp, &keys, free_list)
 		__ieee80211_key_destroy(key, key->sdata->vif.type ==
 					NL80211_IFTYPE_STATION);
+}
+
+void ieee80211_free_sta_keys(struct ieee80211_local *local,
+			     struct sta_info *sta)
+{
+	struct ieee80211_key *key, *tmp;
+	LIST_HEAD(keys);
+	int i;
+
+	lockdep_assert_wiphy(local->hw.wiphy);
+
+	for (i = 0; i < ARRAY_SIZE(sta->link); i++) {
+		struct link_sta_info *link_sta;
+
+		link_sta = wiphy_dereference(local->hw.wiphy, sta->link[i]);
+		if (link_sta)
+			ieee80211_remove_link_sta_keys(local, link_sta, &keys);
 	}
 
 	for (i = 0; i < NUM_DEFAULT_KEYS; i++) {
@@ -1209,9 +1243,14 @@ void ieee80211_free_sta_keys(struct ieee80211_local *local,
 		ieee80211_key_replace(key->sdata, NULL, key->sta,
 				      key->conf.flags & IEEE80211_KEY_FLAG_PAIRWISE,
 				      key, NULL);
+		list_add_tail(&key->free_list, &keys);
+	}
+
+	if (!list_empty(&keys))
+		synchronize_net();
+	list_for_each_entry_safe(key, tmp, &keys, free_list)
 		__ieee80211_key_destroy(key, key->sdata->vif.type ==
 					NL80211_IFTYPE_STATION);
-	}
 }
 
 void ieee80211_delayed_tailroom_dec(struct wiphy *wiphy,
diff --git a/net/mac80211/key.h b/net/mac80211/key.h
index f5a97213a559..e4ee89de9438 100644
--- a/net/mac80211/key.h
+++ b/net/mac80211/key.h
@@ -24,6 +24,7 @@
 struct ieee80211_local;
 struct ieee80211_sub_if_data;
 struct ieee80211_link_data;
+struct link_sta_info;
 struct sta_info;
 
 /**
@@ -167,6 +168,8 @@ void ieee80211_free_keys(struct ieee80211_sub_if_data *sdata,
 			 bool force_synchronize);
 void ieee80211_free_sta_keys(struct ieee80211_local *local,
 			     struct sta_info *sta);
+void ieee80211_free_link_sta_keys(struct ieee80211_local *local,
+				  struct link_sta_info *link_sta);
 void ieee80211_reenable_keys(struct ieee80211_sub_if_data *sdata);
 int ieee80211_key_switch_links(struct ieee80211_sub_if_data *sdata,
 			       unsigned long del_links_mask,
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 22eba0e6e54c..cebfb2c4c0cc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -3444,10 +3444,16 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 void ieee80211_sta_remove_link(struct sta_info *sta, unsigned int link_id)
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct link_sta_info *link_sta;
 	u16 old_links = sta->sta.valid_links;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
+	link_sta = wiphy_dereference(sdata->local->hw.wiphy,
+				     sta->link[link_id]);
+	if (link_sta)
+		ieee80211_free_link_sta_keys(sta->local, link_sta);
+
 	sta->sta.valid_links &= ~BIT(link_id);
 
 	if (!WARN_ON(!test_sta_flag(sta, WLAN_STA_INSERTED)))
-- 
2.55.0

