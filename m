Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91234E744
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788497335; cv=none; b=UVeDyvOx8Yq6fqPIvbxY1ux8yOwfNoWCYb35oGKLwx6vnaG8gfN2rf1o8G9E379QqnspUb+cA1S7wej/Gwv+HB3hqI6bUJzTL1pMryHMRVJd9zPszdLo6CHEG8ANaQIY0Q5mIDqeqYBIHAv/RyIVS1ESG5S74iRQ4SU1/VUdnac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788497335; c=relaxed/simple;
	bh=f/xL8zPPS2oy2b+Y7LFg6JiDnctsHVSiERVBsKleNW8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XKIwMcf1OV+4KU+LFhK9UVI/BP9U9ipwWlYVVC9wRY1BN6oN69Y2mZkXYT/mdA5IhAh+XJ+ZkB6YMibMA6IEtBIS8IhSZsFivv5GBW7AmL+SjQVh0xIuVhVNi7XDbKIsOWeKvzLMlDWe2+ySlr+lwPF+4kBTR7Rr0SKsYQt1bIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RkKnuQQe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RkKnuQQe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645411F00A3D;
	Fri,  4 Sep 2026 04:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788497333;
	bh=Kj8z7OXz3KER0eOengMIQUq86ajplXGCb4qh/1w9SEs=;
	h=Subject:To:Cc:From:Date;
	b=RkKnuQQeaS09080rv4wPzzeVhyfgCrX72BScw9eFlk4Lpg+hV64L5qyOrtPLuTHuC
	 vDkybsa15pk94h8S/42vEFDUQXGMSHt1/+1pz9BjJ7JPoADxURHt1R0D2vN0VHN+oc
	 loIfy2bvFjD7ml4lu0B0jhpC+kvNlgWY7Wvmp5So=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7615: avoid waiting for mac work under the mt76" failed to apply to 5.10-stable tree
To: runyu.xiao@seu.edu.cn,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 04 Sep 2026 06:48:48 +0200
Message-ID: <2026090448-broiling-unsworn-6960@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bda8324270b1ac91bfba1df8928e0570e29759e8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090448-broiling-unsworn-6960@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bda8324270b1ac91bfba1df8928e0570e29759e8 Mon Sep 17 00:00:00 2001
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
Date: Fri, 12 Jun 2026 12:13:31 +0800
Subject: [PATCH] wifi: mt76: mt7615: avoid waiting for mac work under the mt76
 mutex

mt7615_suspend() acquired the mt76 mutex and then called
cancel_delayed_work_sync() on mac_work.  mt7615_mac_work() acquires the
same mutex via mt7615_mutex_acquire() at the top of the worker, so if
mac_work is already running and blocked on the mutex, the suspend path
deadlocks waiting for the work it holds the mutex against.

Flush scan_work and mac_work before taking the mutex, matching the
suspend paths in mt7921 and mt7925.  scan_work only takes the mt76
spinlock, but moving it keeps the sequence consistent.  This also keeps
mac_work from running over an already suspended HIF, which the previous
split (async cancel under the lock, sync cancel after release) would
have allowed.

Fixes: c6bf20109a3f ("mt76: mt7615: add WoW support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Link: https://patch.msgid.link/20260612041331.2596331-1-runyu.xiao@seu.edu.cn
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index fc619acbb40d..67f56e428d9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1239,11 +1239,12 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 	cancel_delayed_work_sync(&dev->pm.ps_work);
 	mt76_connac_free_pending_tx_skbs(&dev->pm, NULL);
 
+	cancel_delayed_work_sync(&phy->scan_work);
+	cancel_delayed_work_sync(&phy->mt76->mac_work);
+
 	mt7615_mutex_acquire(dev);
 
 	clear_bit(MT76_STATE_RUNNING, &phy->mt76->state);
-	cancel_delayed_work_sync(&phy->scan_work);
-	cancel_delayed_work_sync(&phy->mt76->mac_work);
 
 	set_bit(MT76_STATE_SUSPEND, &phy->mt76->state);
 	ieee80211_iterate_active_interfaces(hw,

