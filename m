Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A32453A32
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335728; cv=none; b=LwhTQUULq8JBOT6mY8lLXXfFxIWLKnVMG1LlZAhEUlg31MasgrHTIYSWUJ7rvuu9hnMZccJBmHpBQKYvlUZ948zsMlqFygTuwUyVTA+LEc4p5rZUAZfTT7/MltyCvo5CKWWeeJCo7/o/dxgaz1//oGOd+oLX4xSqW7noX0mIYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335728; c=relaxed/simple;
	bh=maAaFWp+36pOtEouL2QkjxGNCrl3ryYg1b+z7VXUdSU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aTGz+2k2YldSggIsl0ZlJ21YT/SNMUYP2crRTgTwAPWZ+YMneCRk9LDhQL8+DblK4vyYiCm3bbRXLKsRT0I9SCC32wCBHlNdqhDg2R/PlgZjvVWJ0i1Vph0vVp73Op5/WI8Vsa/QP31oHjtUQZEt0S3HAxcKxs3QfDuF0VZKQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z+ZYnjyL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z+ZYnjyL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71ECD1F000E9;
	Wed, 29 Jul 2026 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785335727;
	bh=gRrAqY98vY/wZnbD56h9E2w6g9s+sY/BfGYdbOqgMzI=;
	h=Subject:To:Cc:From:Date;
	b=Z+ZYnjyLUt9CqnP1JF3s424oyoys8vHpalL8atwohqJMFDAGGtJbXhVdeE6PUgCtF
	 wqRTOqDMxxYKIqPNhv92NB+Y8SUwdy4dyDPnyqebKwRw2TPT9Egl5AbGoiT2NrWlgf
	 v/HuutodKzg0EwWNFFpKliBhGIV8TGHx8YZMKUXg=
Subject: FAILED: patch "[PATCH] amt: fix use-after-free in AMT delayed works" failed to apply to 6.1-stable tree
To: shlomojune6@gmail.com,ap420073@gmail.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:35:05 +0200
Message-ID: <2026072905-corny-tried-6651@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ea20c44935d6142daecfa9b39d635033a7553e1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072905-corny-tried-6651@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea20c44935d6142daecfa9b39d635033a7553e1b Mon Sep 17 00:00:00 2001
From: Shihuang Liu <shlomojune6@gmail.com>
Date: Wed, 22 Jul 2026 19:39:19 +0800
Subject: [PATCH] amt: fix use-after-free in AMT delayed works

When an AMT device is removed, pending delayed works can still access
the freed amt_dev structure, which may result in kernel crashes or
memory corruption.

amt_dev_stop() cancels req_wq and discovery_wq with
cancel_delayed_work_sync(), but these works can be scheduled again
from event_wq after the cancellation. This allows delayed works to
access the freed amt_dev structure after the netdev has been released.

The following is a simple race scenario:

CPU0                         CPU1

amt_dev_stop()
cancel_delayed_work_sync()
                             amt_event_work()
                             mod_delayed_work(req_wq)
free netdev
                             req_wq accesses freed amt_dev

Use disable_delayed_work_sync() in amt_dev_stop() to prevent req_wq and
discovery_wq from being queued again and wait for running work items
to complete.

The delayed works are disabled after initialization in
amt_newlink() and enabled only when the device is successfully opened.
This keeps the delayed work lifecycle synchronized with the lifetime
of the AMT device.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Cc: stable@vger.kernel.org
Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Taehee Yoo <ap420073@gmail.com>
Link: https://patch.msgid.link/20260722113919.7723-1-shlomojune6@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index b733309b866f..182a41d59a75 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3034,9 +3034,15 @@ static int amt_dev_open(struct net_device *dev)
 	amt->event_idx = 0;
 	amt->nr_events = 0;
 
+	enable_delayed_work(&amt->discovery_wq);
+	enable_delayed_work(&amt->req_wq);
+
 	err = amt_socket_create(amt);
-	if (err)
+	if (err) {
+		disable_delayed_work(&amt->req_wq);
+		disable_delayed_work(&amt->discovery_wq);
 		return err;
+	}
 
 	amt->req_cnt = 0;
 	amt->remote_ip = 0;
@@ -3062,8 +3068,8 @@ static int amt_dev_stop(struct net_device *dev)
 	struct sock *sk;
 	int i;
 
-	cancel_delayed_work_sync(&amt->req_wq);
-	cancel_delayed_work_sync(&amt->discovery_wq);
+	disable_delayed_work_sync(&amt->req_wq);
+	disable_delayed_work_sync(&amt->discovery_wq);
 	cancel_delayed_work_sync(&amt->secret_wq);
 
 	/* shutdown */
@@ -3317,6 +3323,8 @@ static int amt_newlink(struct net_device *dev,
 	INIT_DELAYED_WORK(&amt->req_wq, amt_req_work);
 	INIT_DELAYED_WORK(&amt->secret_wq, amt_secret_work);
 	INIT_WORK(&amt->event_wq, amt_event_work);
+	disable_delayed_work(&amt->req_wq);
+	disable_delayed_work(&amt->discovery_wq);
 	INIT_LIST_HEAD(&amt->tunnel_list);
 	return 0;
 err:

