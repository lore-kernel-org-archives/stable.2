Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A564A4990
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211105; cv=none; b=R4OSPRQ71W0s58Z6e4AYWfj5DRENky7KybJdOxG+0kZzqVQT5SnUAimxY5jpydDuN6KJQ2v6riI3biwE5vsQe4wBR7X9CZ09AEzGBUtevfaS1LRycspVPNNGW/+5gKb1cD7skLvB0DSuLwyB4VRbTbjq5eZNnlkNmNz/9skpWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211105; c=relaxed/simple;
	bh=/KFPpy3Kx1ifPspaCfCR/GpumLSj4HFsDkrpvfLZcR4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XEmcS+UUZySYwwhGcuQZLXhHBmSIt9PnQP4sLXhWmTGensLG0F2XD7qNrhwhkdntgCLJsFWpeCuuRL0qCPHq3wdmgxktyUuN+vAqNa3WuwF+f9W4T5z048lmvkhaj/+xX2Wyom94nGcBy71v96P1sbN2hfhtuA5COqhY9sK885s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrgUNmX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrgUNmX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C883F1F000FF;
	Mon,  5 Oct 2026 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211095;
	bh=4afl8bwccBwZJBa/Q+TUgYJp+HTcNWeiYdfmbpPVYhE=;
	h=Subject:To:Cc:From:Date;
	b=qrgUNmX3UzZ4y58vOzOoxGuj8f3E4qPemRRN/IrHpWPHUUYFZbs44s5rrdN/O7VQR
	 BJFd0k3DvdRl1po7LP79bhQpuKJrWvKaSXmnz4cMu/syyVncgtQJPaqgsj2xvrlRmK
	 jTwZkOim0uf8eNaVdVBMkrjC2siOWMHvEn4m5oKQ=
Subject: FAILED: patch "[PATCH] wifi: mac80211: shut down RX BA session timer on teardown" failed to apply to 6.12-stable tree
To: enderaoelyther@gmail.com,johannes.berg@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:38:04 +0200
Message-ID: <2026100504-reverend-stooge-1b02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x e588e83e5c7a0f6d7a77dbbb58927c8c8cfd598e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100504-reverend-stooge-1b02@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

