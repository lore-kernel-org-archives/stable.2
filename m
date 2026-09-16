Received: from mail-pj2-f14.google.com (mail-pj2-f14.google.com [74.125.227.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797804EC66C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558685; cv=none; b=bkV+znepMY9lka41tzL3GlDY3TKiUs62+apAmd2Bf7ycWky0Fu1RdxLPgYC4fVoeS18ri1cNIgJV2lbFxY+RLFgMCXf2zpAlMTWhTiaVKp1wxh+pJyK9IEJUJ3cQK0QoMimTbE9TRDIhXVaKviCQK5gUR3OzxwmZqYaL8EhmM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558685; c=relaxed/simple;
	bh=csUfOndJDz7EZEfMA2frijyrNrVz9OUmpEKxWFv+B0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsc7vsUEFgrCW1w2YbZl94ZPgU98IctjeIS5Q5xhc86lvP0j0sAhmSvDRL8EBuWfK2gbhOUKXNmL2sSw9OxN7CUWt1ciAQdtGrx+lA2/86KENJk+HyELqmJrNbh+l2gHBV2muePkFn5wQ5iNRPWMl+LUvJqgYE6FZi3iL9h7Vo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqq9nzJo; arc=none smtp.client-ip=74.125.227.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqq9nzJo"
Received: by mail-pj2-f14.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so8026655ad.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 04:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789558675; x=1790163475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T34qbeg9BZiIizWsJRPiGsD94KV01+5BcoUdEM3GmQ0=;
        b=Fqq9nzJos2eu4inH0JHbUgSMQtF+zKO8I5pVv1pv80Ooi+2NKXQ5GpiuluhftHdL0t
         u3+2xipl/DnmJJBIH4ObXC6pNi+U4S6br6dsh/1qWsGUi04Trua84p/2NKL2ZktJXwO7
         laFeumLsNsFC9mG++zbzmDNZaXmIAMJVfJCvXnS3nF0FZVCUdTEu+snR7Vfi6tk1PtRA
         i2RNI5LaqzE9tXRcbzq37XpxhqHqXzqDcGviJ2l0aXvBm5m6R5nWdfjD8e2TZyYE1EdG
         sBanqUY2i5/NUR5Dm9VTzzjZ3D/Mr1E6gxsXc5weuQQUi0VMXoOCWKwTcB2haVdxK00m
         5MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789558675; x=1790163475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T34qbeg9BZiIizWsJRPiGsD94KV01+5BcoUdEM3GmQ0=;
        b=2YYSytL60RcY3cAA85tHTjqkh/eoXoBnowQ6r8pjAWhxQCIJIII7VZtYu9oeQGv0sh
         JOkl/p2vUnunRYKnf+MI645HT3E5sAA3MBfdYrlabAWCnPYE3d8uuVGC3saI+QmWg5pG
         EUgV1xbzIS228ynSruTDQXrxqQDxWB1poK12Me/h2OvN/q5Mi3yDuwNbmtAxvk6JlEb8
         CYrKaONfvzXu4LjY29qGI+HGwy7AghjJxzZrinKF6goQfcORxn7qc8i0byzN6NG4hdai
         prWVGzmJng1ddr/A7aHy55UxFGtekd1hNi00jsiJbXwv8P0EocTvLy3HVGyTX/EfamBX
         lacw==
X-Forwarded-Encrypted: i=1; AKwUvBy/7aAjln4mFmCG81POiRMRdDaMuY/iF5bQ6Ea7s/JTxduOOvbztfR7kA8NIgOPLclY8n48JGA=@vger.kernel.org
X-Gm-Message-State: AFuF++m94rB+AfBIYv1AVX+W7xiQqHYy1Qhwk9S55+qvLH0vxcHIaT1L
	XgdVpacUV5uNfRmfwmhmHlFuZBh4S1ls7+P8I3wGSryXg6YKDvEWctoh
X-Gm-Gg: AYBFou3R5zE3UvQcRqYNvANO5XO6ILfgQJlVEd9bxHjZpoFLiO82JxXSr+mHk0lOI3i
	2K1rBEbjreZB24nCPYbuMd0nR8gAfn77gYYqltFLaOTnjg30PhMPQC+yKo7VZy7OSZtZ1NHEup2
	0t2wA0iBI3etX6tV5P/DI66r0cA+HLZidnTDn2SSpykXTQha7VIngairzeXpJrfbLzHyTkQU/eH
	b0yIOgHZqVPopnjGO10vGAD3tlUKgljW6zHI+9HIKo562mht8oMswaRGAmPnFprLi0FEb+muWJ9
	TTR3q/OpnKNynexi/f6JRmjNbi8QLEBJgSAEnjGM42pogbfXgaOyDhW1yQfd5vd75UtVulGk8B6
	6fBSjHrnEOxm5tnQfQ6vkKmpYVXg9SxG+a06SCptc0J+srRLkiZkIkloQifuorUzG3dguHBzUqv
	3YBUL74D23/wKrytvtzDqGjr1c7HouCtuTo0lskWuVfFa+zv138lSYGvJ6R+xA+LBGxYYce+Acv
	KhmvFKQaaXsegJucUrfx1BhW4WWaCX9Vs7d8Gg=
X-Received: by 2002:a17:903:1a0b:b0:2d8:d4d0:792b with SMTP id d9443c01a7336-2dd8e7546c1mr49020405ad.15.1789558675144;
        Wed, 16 Sep 2026 04:37:55 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f02fc2sm9936495ad.59.2026.09.16.04.37.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Sep 2026 04:37:54 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] wifi: mac80211: drain PS delivery work during station teardown
Date: Wed, 16 Sep 2026 19:37:35 +0800
Message-ID: <20260916113735.31029-1-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Removing an AP or mesh station can notify the driver and wake TXQs after
the station has already been removed from the driver, and can update
num_sta_ps and the power-save queues after station cleanup has purged
them.

sta_deliver_ps_frames() tests sta->dead only before it starts delivery. A
worker that passes that test can be delayed while teardown sets sta->dead
and removes the station from the driver; when it resumes it still runs the
full delivery.

The existing cancel_work_sync() sits near the end of
__cleanup_single_sta(), after the final driver state transition and after
PS accounting and queue purging, so it drains the worker only once the
state it has to protect has already changed. Before commit d34ba2168a3c
("mac80211: don't delay station destruction") cleanup was deferred
through the same ordered workqueue as the delivery work, which kept the
two ordered.

Cancel the work after setting sta->dead and before moving the driver
state, and move the existing cancellation to the start of
__cleanup_single_sta(). The first drain closes the driver-lifetime window;
driver callbacks during the remaining state transitions can still queue
drv_deliver_wk through ieee80211_sta_block_awake(), so retain the second
drain at the start of __cleanup_single_sta(). That drain also covers
insertion failures, which reach cleanup without setting sta->dead.

Fixes: d34ba2168a3c ("mac80211: don't delay station destruction")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse smatch coccinelle kasan
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
---
Validation:
- GCC W=1, Sparse C=2, Smatch, and five targeted Coccinelle rules produced
  no diagnostics.
- A controlled in-driver AP teardown filled ps_tx_buf and tx_filtered
  through ieee80211_xmit() and ieee80211_tx_status_ni(). Before the fix,
  cleanup purged both queues while the worker was held; the worker then ran
  after NOTEXIST and left num_sta_ps at -1. With the fix, the worker
  delivered both queues before NOTEXIST and num_sta_ps ended at 0.
- No KASAN or list-corruption report occurred. Each arm has the same three
  disclosed harness warnings. No physical-device test was run.

 net/mac80211/sta_info.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index fdf00cbf49d8..e81cd155197b 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -137,6 +137,8 @@ static void __cleanup_single_sta(struct sta_info *sta)
 	struct ieee80211_local *local = sdata->local;
 	struct ps_data *ps;
 
+	cancel_work_sync(&sta->drv_deliver_wk);
+
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
 	    test_sta_flag(sta, WLAN_STA_PS_DRIVER) ||
 	    test_sta_flag(sta, WLAN_STA_PS_DELIVER)) {
@@ -166,8 +168,6 @@ static void __cleanup_single_sta(struct sta_info *sta)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_sta_cleanup(sta);
 
-	cancel_work_sync(&sta->drv_deliver_wk);
-
 	/*
 	 * Destroy aggregation state here. It would be nice to wait for the
 	 * driver to finish aggregation stop and then clean up, but for now
@@ -1582,6 +1582,8 @@ static void __sta_info_destroy_part2(struct sta_info *sta, bool recalc)
 
 	sta->dead = true;
 
+	cancel_work_sync(&sta->drv_deliver_wk);
+
 	local->num_sta--;
 	local->sta_generation++;
 

base-commit: 50d3d79dc0743b616afb00d01a626c76758721f7
-- 
2.55.0
