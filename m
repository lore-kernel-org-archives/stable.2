Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0D9484237
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791460319; cv=none; b=fWvRGf+ZaXYsifnmxqIgzXWqueoYTB1i3qyWBYYA8qzrOOeCXF56xI1BhoWdcqf4Pk7mavrJ4YWoxamX0wfB7YfF7yvIZxvR48skE8rSCc0l8lG0v51EfsxuiMIJ1vv92yM4UBNNfQ4395jzJty8nNCjawAMYGICw99tMLzwISI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791460319; c=relaxed/simple;
	bh=25Cy4hLs//7T7QQPA32J2gRwiv8swJf1KlsN0jWfScs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKfxtpJ0FZKxwqxUWwBgwnnsVNjHkVK5DsKfsJUmLc4rrhoyNNfFzQ/xNnT4I/jn+lxVdAa5ZJvk3xWlTTYpAeOqaaKY/IISEmRt45QRxTmBgTdCDZJOsCLjJ8hmJueIbWhy0jyumf8pvktfHYcIwqVS3uaOqKJBjSi8BpgKpyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7vUz9r+; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7vUz9r+"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a98fc80925so21169091fa.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 04:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791460315; x=1792065115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YfozA0kOqu0j23n9iWNtMreJdG+KsOuhldDG1WEkjM=;
        b=J7vUz9r+endiGLrt7US8Etgjx80m6jFGyLi2Scs31762cAfnRPu3C+vRTawwhdN97e
         3Cb/XTAqb/bS+XYLQwQJJ2ZRyo0pPIQdutu5UOH71XVzviAgFcyN5jXkDTFyafPeIPfN
         0FA3HfgEkc390cvd8Crl2GYzWt1qdrnkbvJ+vnvV1W4a+4QaTgVTsfMnMB/jvvNhzAh2
         sMQSt+5QDwCIXv9w8vgBqIz9cqjLqNrnnXmyfiivnuvx/71lti8OYIOjJ01p/ycPfqKj
         d52K8w57B2+/XuFmlX68cWyN6jTrIzLcSRC1HN9MifEg7rL+/aKTheYlajcWLI0W2UXX
         UGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791460315; x=1792065115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YfozA0kOqu0j23n9iWNtMreJdG+KsOuhldDG1WEkjM=;
        b=Rz0jDlkG4zA5Sfv1X4yrQCySOZAS56Z1kwl9liNbuBwfJLrYUOku+M6tYxJUvIZl/+
         8wKOOa1V2fCGEx8T0J/EJ9DrKtquPxO/omKd8pkSIEAWcCGnod5IsdmfIV19V9d7Nzfg
         w/IH06zbGvMlnSGQjBmOs4gRaDvFFwGBxAPHoc5UraHWJDR2lK09VDUYNf5/1cDc1S4B
         3+NVsLWpiG+K10PUKZ9vyAuEzoFXZQNEJ6uLnCqLd79NMs2WjA/QJqrb1EN2Oyh1Ib0C
         GAZvq9zHid1syNc5Snn6SZkQciL+CSskEOvIJhjEftfTHjP+BoiJghowTF5ea6BiyQjz
         RH6w==
X-Gm-Message-State: AFq9FYJpwb5GUJdbx4T2FAEnQTRTpIkicYMXSASh+RLKre0Wc/pkBSLj
	4DV8bbYZGhTKrjulKUlP+mInAtHt8xh/X2sIBu7m7tHy5KyWpcxeYftWJwzbO+ci
X-Gm-Gg: AYBFou2uc9nsdrczVpmNzeRBFwDun408Rn+78Hpy27IOXME3DDndt6i3hbj4/IRbACD
	Z8XOZ/yPy2qrMzmX6Rd98UdUNm2QQwOa1gJFbTv3B6AwLScyMSAAhccqOg4eyO1CM5+X742ZWSd
	pBHSKvCUUrihUdDvg+L43lDh51tVgocv3Ec0VrutR8Of+JTJTWD1zlcne3NxKhzQizt9ybcEzJA
	hmPJ/TkPM4mwWOlArgn53rSrGtuSkyGZfZ+jYCJwzT7TfZaEqi7SZjhWcvhG73EThIBq0nlmxs6
	nPiHCU64lEq3B2xaRY2noVZt1OfX56n5LLK6aMitDksbR0lKLyrY9wWVjXxXrRuXQj73GUPEM7L
	dQ49NwJN7ZncZO8w4XXYY5xAB49hJ5VRWH+jeUDCCms08rIRwGaifoTbhCIeN9EhHCaHdZruhPT
	gbn7x0eqJbyQKMLzQUxlhKguoNsXZoNaj/aclFVDt48p9Q4sAxF+ZDA1+5+du1A5K/TJL7Imtpn
	bztNJjz5g==
X-Received: by 2002:a2e:be91:0:b0:3a9:849c:128a with SMTP id 38308e7fff4ca-3a9a2cfcf26mr12750371fa.19.1791460314922;
        Thu, 08 Oct 2026 04:51:54 -0700 (PDT)
Received: from grower.astralinux.ru ([38.74.72.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a9a1d3370csm15427281fa.13.2026.10.08.04.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 04:51:52 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Pedersen <thomas@cozybit.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.10/5.15] wifi: mac80211: mesh: release the channel if start fails
Date: Thu,  8 Oct 2026 14:51:40 +0300
Message-ID: <20261008115145.83101-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

commit ae97fff6495a8764bc0ef281cfe5444f701e527f upstream.

ieee80211_join_mesh() acquires a channel context and then calls
ieee80211_start_mesh(), which can fail. In that case, the chanctx
isn't released then interface removal will attempt to unassign it
after it's removed from the driver, hitting:

  wlan0: Failed check-sdata-in-driver check, flags: 0x0
  WARNING: net/mac80211/driver-ops.c:366 at drv_unassign_vif_chanctx
   ieee80211_assign_link_chanctx
   __ieee80211_link_release_channel
   ieee80211_link_release_channel
   ieee80211_teardown_sdata
   unregister_netdevice_many_notify
   _cfg80211_unregister_wdev
   ieee80211_remove_interfaces
   ieee80211_unregister_hw
   mac80211_hwsim_del_radio
   hwsim_exit_net

Correctly release the channel on start failures.

Assisted-by: LLM
Reported-by: syzbot+63a84ea9c0f57d6133fa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=63a84ea9c0f57d6133fa
Fixes: 2b5e19677592 ("mac80211: cache mesh beacon")
Link: https://patch.msgid.link/20260908122838.201719-21-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-98326
 net/mac80211/cfg.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index afb1ad3e6ea1..bae9588ea913 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2276,7 +2276,11 @@ static int ieee80211_join_mesh(struct wiphy *wiphy, struct net_device *dev,
 	if (err)
 		return err;
 
-	return ieee80211_start_mesh(sdata);
+	err = ieee80211_start_mesh(sdata);
+	if (err)
+		ieee80211_vif_release_channel(sdata);
+
+	return err;
 }
 
 static int ieee80211_leave_mesh(struct wiphy *wiphy, struct net_device *dev)
-- 
2.43.0
