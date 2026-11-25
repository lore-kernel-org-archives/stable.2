Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603237;
	b=3GAnua7G6lYwxlE33cz2ecNnHL8UHR7cRwIAUb6nH0FBMMCkJuSnYKvwbLcBdJonYAyJ
	 EZK45DeoyO0V67NDY09G8xfcFWzOdcwvk/kLZqpigAMGIP62lCmH4csidr23n5eH36Qjq
	 jcndv+fI7EdEi34CFbzIjSMBlkklC2tgAiPryoj6hMhSZdsVG4glo1ddlszSn+D7+nz8r
	 7WDLpo8jLUJtQIfV42uEllnLkefuKScdsFcn0/0TqiSB4d41/hVeMI1hz44fBledRWVmc
	 04bV6VfLpu6bgLjWtNI6mj7n79QiMsD9G6vU8jwo9Q4cSycccjpTcVZjMQh1sDFxBGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603237;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CmUntYhfwBoBo/Nct5dJxabKGW8gFyJ/OdNI3w6G80Q=;
	b=hxWRBn4K5k8YIpdRVmnU0Tv/UzacPp6sK0gHu2yJ1mh7AOvWVwWxBI6rwYAd0JAzdVPg
	 MYM7+Gw/7Cg6A2zynmJAU8QTGD9br49EkbCe0x2A74wMaXGX22BYdfSoJLnL7utRc+888
	 nPAL1Bj5/Hd+CLxu5NS4697bJ7irRZe3/JitZci1IFll4Hdsigwk0uBSVxohl52/wdOc/
	 XE2N6dvLGzo4UDMh09TWXuhC2mXZ9olPH6UdmT4o79W55u1QFnJ0WL+Ispip2dfhrrt5Y
	 RltJBWpa0VBWngLbGvlYW08HBvlzih1K9wERh7gf0i/yPMlSYGlH79e9rDI+rwzGEbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KVknsKEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A6E606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KVknsKEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80311F01564;
	Wed, 25 Nov 2026 10:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603237;
	bh=CmUntYhfwBoBo/Nct5dJxabKGW8gFyJ/OdNI3w6G80Q=;
	h=Subject:To:Cc:From:Date;
	b=KVknsKEnrNYj6ADnPj+GVSXPNOramCXstglRQScH3xqRIm2DOgEWNFnvqCnNiFiTe
	 d4OeWiDMFgI80h4bxJ5bWcfZntiruXfjpoySjecQwzpRKU+xNRcq9Bzx8uAGbA8OoX
	 DH//Q6qwVwx6jf0EKlACnIWVBfocgG3uwi0r94EM=
Subject: FAILED: patch "[PATCH] wifi: mac80211: fix use-after-free on TTLM disconnect" failed to apply to 6.12-stable tree
To: johannes.berg@intel.com,benjamin.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:33:09 +0100
Message-ID: <2026112509-pusher-anything-a1e2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4af2b71495a3f12196cbea1c9a502c62ada867be
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112509-pusher-anything-a1e2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4af2b71495a3f12196cbea1c9a502c62ada867be Mon Sep 17 00:00:00 2001
From: Johannes Berg <johannes.berg@intel.com>
Date: Mon, 2 Nov 2026 22:03:13 +0100
Subject: [PATCH] wifi: mac80211: fix use-after-free on TTLM disconnect

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

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5d466270b4ba..b5efc6ccc985 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7872,15 +7872,15 @@ static void ieee80211_tid_to_link_map_work(struct wiphy *wiphy,
 	sdata->u.mgd.ttlm_info.switch_time = 0;
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
@@ -7898,14 +7898,14 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
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
@@ -7917,7 +7917,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 
 		if (res) {
 			__ieee80211_disconnect(sdata);
-			return;
+			return false;
 		}
 
 		if (ttlm_info.switch_time) {
@@ -7942,7 +7942,7 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			 * switch the AP will continue to announce it anyway.
 			 */
 			if (delay > IEEE80211_ADV_TTLM_ST_UNDERFLOW)
-				return;
+				return true;
 
 			delay_usec = ieee80211_tu_to_usec(delay);
 
@@ -7961,9 +7961,11 @@ static void ieee80211_process_adv_ttlm(struct ieee80211_sub_if_data *sdata,
 			wiphy_hrtimer_work_queue(sdata->local->hw.wiphy,
 						 &sdata->u.mgd.ttlm_work,
 						 us_to_ktime(delay_usec));
-			return;
+			return true;
 		}
 	}
+
+	return true;
 }
 
 static void
@@ -8486,8 +8488,9 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 					       elems->cisco_dtpc_elem);
 
 	ieee80211_ml_reconfiguration(sdata, elems);
-	ieee80211_process_adv_ttlm(sdata, elems,
-				      le64_to_cpu(mgmt->u.beacon.timestamp));
+	if (!ieee80211_process_adv_ttlm(sdata, elems,
+					le64_to_cpu(mgmt->u.beacon.timestamp)))
+		goto free;
 
 apply:
 	ieee80211_link_info_change_notify(sdata, link, changed);

