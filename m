Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73A63B1EEE
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322372; cv=none; b=OUEAvIDVkD++Eg5PhkLOMVmgEe0embjdd+PYzD1sKTXbgDPwL6oHeuab2H8OaHA77W9eSoMM+YjgVr0baUGK/MlmRi1PzZUGDk1gWm5UFVb4Mndj+2QivwybQYC3t8BO34DMoRuw038zmXOKjESPYshv8ojKRrcQqPCDGDvN2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322372; c=relaxed/simple;
	bh=JLQV/W+cC/ILS7nESt1HgaByjmB1yGRPMkcGASeB6bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/Hf8m6UVshb3b1T073tmo8wzOfQmcE9oINRd737dptCZ94XR3I+rgmbgk9cNBaNvVRrwzkpL5XjNOQEmBEGGG5PWNKwwSY+3z534HWKC3GU7bx8ILxVJi4hFSl6rMsP/Salb8FtbTFv3Ie8+9PGZK0Ow4wYwCz0EN2ls5CpWHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bnp5IpLW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bnp5IpLW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1ED1F0089B;
	Tue,  6 Oct 2026 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322370;
	bh=pZNBm5IIzofmGI6+mqVCCmrTWY5Y13zMLHTR4vKIOIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bnp5IpLWlEXietHg/vBDjKsZ7SpHhh6CNCi9N9TqPR/NbrSjjssDWj+TnMNaI49p+
	 bsBE6rPIMRyfQvPahWn9xNmPLflgmuvdqNeQ1eMFqYSCkCk5drMeCjfUQgou6Qr8Of
	 R+XOt/dGEBiigW3MvekHC7q43xLFUN9PkQ8bR+OM9La6xtY35F6ifMiGiJO725VDyM
	 ZXTdQrx2E7kHUT+o9KJ2QlI937P9UjBwRFPKObEysfwmedNmGytpHng1sBUC0+vu5V
	 Ksv9kjCUepEz9TkrrgRBaZj9fb4hgEALw6zzeBlO+yFatJYwHCGW9Sf2josEhbC2l7
	 qheQKIGl/Oe8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Tue,  6 Oct 2026 17:32:47 -0400
Message-ID: <20261006213146.983687-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100505-submitter-smartness-6f6a@gregkh>
References: <2026100505-submitter-smartness-6f6a@gregkh>
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
[ sashal: adapted the timer replacement to target del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index c6fa532304500..32c1be3096b3d 100644
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

