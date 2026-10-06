Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA638656C
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 22:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325133; cv=none; b=OaE+T07uep2oqR/eHdPdxIax6l5SBeDc1ni74b6gAv4Vsg94wo+yxm+Tk5vg0rEAOpACZOB8x875bFnKQIIqliT2n0xtHBFU9hbCfhjfHonjDAINcV0XV8vLW6SeqV3M3IA+9TS1QVr6pmWY/J0l0UgSLBOjPMHAQhWDkJXdlAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325133; c=relaxed/simple;
	bh=Sp6m257yGC+8S01wlID39ZENPdjCweCcG5UAd0e7Vck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSbRD2lRCdWcLkhtwjEMtbGQqxiRSuKX39z/q3YghhsBjtkOxD+A3S/pS3J6wEqhRmSpE6TY92OFO6Xy4reWbi0/NkzQxSbmkZARJOgEupl/gnXKzyAGpTWC0U6zzVnFlTzywg/FRt5LSzE1PH4QWeTN5+lmc78tjNuKLrWI5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSzyRA1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSzyRA1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3481F0089B;
	Tue,  6 Oct 2026 22:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791325132;
	bh=EbySyw4pl993u9RgZbRXMhoVvmy8eMOKmlgusOfIlZ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSzyRA1uj9L6jhC0U+ww/k1jEt+4xa8yXtp7WwsNdCxn6ruzYH2NDyMjQYmsICeGU
	 QapYGMKKm5Riqlxa2Y8vIr6tnQvKa7H5GAp51vG5JHxa3NAZCO4OJY9mUNCKMmwQI6
	 PhWgNLYSQtX5qhLqXHJMc1kJURbD9evwY8D5pkoRgtqIOIiC4iNPEKhhKaEmHsyIOy
	 4fPBxR3uWTa0KjoZuuKZ6wxTUky03Gv+maomnvqXrv0m6u7+u+IL9N+JC6++FWGvYm
	 L2OaVmNUmtgv+7Z+jukyUX47l1DSTmdGpppmBbmOt3B0DpbUuRHUk+G0NNFQwDIurZ
	 rpWGF0iRgV7SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhao Li <enderaoelyther@gmail.com>,
	stable@kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Tue,  6 Oct 2026 18:18:48 -0400
Message-ID: <20261006221827.1100415-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100505-decompose-decaf-fb38@gregkh>
References: <2026100505-decompose-decaf-fb38@gregkh>
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
[ sashal: adapted the timer replacement to the existing del_timer_sync() call ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/agg-rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 0d2bab9d351c6..f6a7eb7181c8c 100644
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

