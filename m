Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED994AB3C3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211118; cv=none; b=qv0jxXt1fBoDm/o6YZZ5FfbZoUVoIFaH4ll0N82pc+P8xfa3LrFOItif6dFKViaGzFKYPG7CzzlK/Jlxw41Pz2+IBkMKG64QU3AmwiWpfYD+6zpbitJn1IGswkXB/2840SA+C1eJKmuwm/tCOr6JXxKO+1LMq2fMNHVUImqU3jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211118; c=relaxed/simple;
	bh=Ma6p34OiEUb0iJQ7xOsKzdXQ5aXNqg1MRfI1ge/ZiIY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CIjad3MTdzpG/JK4wf3DcsRdDh1jFjxktfWu0lPQRBB9vX+sstnB1iqvDY55LUEtbj75Ei/EYyvXnnH5TK6LUqQjyONK0aTVFcHrSGfThj4TflsJDJPNrm8Z4lltD+X+75MM+pmTjvV37aJLYcKvqyGWYmU9JgQI3aP4BxCE62k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JE8wKQ9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JE8wKQ9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5021F00898;
	Mon,  5 Oct 2026 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211101;
	bh=51M3unoFi753fybYyW0RlEA3sx0Kt/OPBjfL1w8AKU0=;
	h=Subject:To:Cc:From:Date;
	b=JE8wKQ9MrLGiTogrg8W+f3hIN8FCybVTh7Tgu2l2Y3YERJ0HhAYY8eRxQllyMgC8P
	 OaPs8T4gy2keo3OrfNaPiZpqirXh7KleA7vOV5+oRNrvnaqliX5cl61RLeAJl4wiN7
	 2A1mfjWyGFiIK1hO+BvYTexbGJNuH/k+SmvyC/MQ=
Subject: FAILED: patch "[PATCH] wifi: mac80211: shut down RX BA session timer on teardown" failed to apply to 5.15-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:05 +0200
Message-ID: <2026100505-decompose-decaf-fb38@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100505-decompose-decaf-fb38@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e Mon Sep 17 00:00:00 2001
From: Zhao Li <enderaoelyther@gmail.com>
Date: Thu, 10 Sep 2026 14:54:02 +0800
Subject: [PATCH] wifi: mac80211: shut down RX BA session timer on teardown

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

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9629e00069a1..01d6703767c6 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -102,7 +102,7 @@ void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	if (!tid_rx)
 		return;
 
-	timer_delete_sync(&tid_rx->session_timer);
+	timer_shutdown_sync(&tid_rx->session_timer);
 
 	/* make sure ieee80211_sta_reorder_release() doesn't re-arm the timer */
 	spin_lock_bh(&tid_rx->reorder_lock);

