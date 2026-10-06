Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B737F739
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323624; cv=none; b=O8X9QE6YO2NQRaGQdboqpUS7WT/0lmujVDU59RT9EKrWOLM57YhNBicTqctLN1LPLlYARte4co5VSDWyChsnj0mOceahwvaIzT9c8AaY1JPHOFXdQMUS9+Idb9P2incYtEelyfJqPzyduF73hf3H3J+jpoWfZ6bLxbxk5n1nqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323624; c=relaxed/simple;
	bh=5RBcVbqphZwWXfijkLL4cz3pvRj6SfXPITbjWNVnKsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B56XKPDaoo61W1yI8NT8tYKPyIj/cP/C3iCT1sel+1OUBoRg0tp9yjbzYCsUVG97rGcfmhT/gNmdC8whcgm/yBDrAoVrpidmasXYAOYydMpsFY5UyUP2b94rgEAyVMO02vs6IKdxUSKWRhl6EI+k+y4NY3qFFeFce2s8BKCC1y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyU6BC88; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyU6BC88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6281F0089B;
	Tue,  6 Oct 2026 21:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323622;
	bh=PMXPkac4gAOhj/BltP7xFf2nxzPC96b3HvnKTKszJv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SyU6BC88yQ7f7HVSNqaPMPscRMfu4Kc/M1w5/6nGwIAs/T0LC0lw/0xtKYXz7JHsn
	 dTDK0SzqVFljJaypHPXdV/iLrGs88Vj7whxREWE51mfnaKETHr6+ILazrfesX8N8PI
	 q0FeG+s/wWR2TdiwyeazehjCf0raIm0XSNN+C2iCf0DlMKuoHySDm6v6oTcU24jqyb
	 RKPBw1euDAJpIyE+3k8alzmPmwefL4o2r/8bz9ZO20Lk9+lXdzmL52Ogtb4vJ7CDAW
	 +BWBVmuSUe+nONZAoPp+IdCD/5tHucPqRxnQ71ISX+9Fr8mzIqpnYY8T2k8U5xqZLd
	 J4H7l9SNbLotg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Tue,  6 Oct 2026 17:53:38 -0400
Message-ID: <20261006215313.1044647-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100505-serve-oops-72c9@gregkh>
References: <2026100505-serve-oops-72c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Li <enderaoelyther@gmail.com>

[ Upstream commit e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e ]

Tearing down an RX BA session can leave the session timer queued on a
freed tid_rx. Later timer-wheel processing and the timer callback itself
then run against freed memory.

An RX BAR handler can dereference tid_rx under RCU before teardown
unpublishes it and stay in its read-side critical section while teardown
deletes the session timer. The stale handler can then rearm the timer
after timer_delete_sync() returns and before the RCU callback frees
tid_rx.

Use timer_shutdown_sync() so rearm attempts become ineffective once
teardown starts. Keep reorder_timer unchanged: teardown marks the session
removed under reorder_lock and its release path checks that state before
rearming. session_timer has no equivalent guard because
ieee80211_rx_h_ctrl() rearms it before taking reorder_lock.

Fixes: a87f736d942c ("mac80211: use RCU for RX aggregation")
Cc: stable@kernel.org # 5.15+
Assisted-by: LLM sparse kasan
Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
[ sashal: Adapted the timer_delete_sync() replacement to the existing del_timer_sync() call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9414d3bbd65f6..acb295bdb71cb 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -103,7 +103,7 @@ void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	del_timer_sync(&tid_rx->session_timer);
+	timer_shutdown_sync(&tid_rx->session_timer);
 
 	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
 	spin_lock_bh(&tid_rx->reorder_lock);
-- 
2.53.0

