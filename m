Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D13453A2E
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335720; cv=none; b=jEjN+6wWskdijChvLBI/9OiYh9aS3wVBblIgvu5UvCWPHyNj2MUIdqnfqAOvCJtt8Rf9ii2X1vhG1qYIZHJBbckM4HUIju+RwX7gf1NKhJICWTDnG7BmKRtQkUK5d1EAZfhs6IAmqqtFQFmAV5bwPktXfcMpnxjkKpWIzig08zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335720; c=relaxed/simple;
	bh=lGtByWXeBleIePRqd8rkZVbGBzUbi+hypzP44Nf/MAI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=I6fJvphVKs1t+G5KJWDNjXXidKk8DcagBRBvtAe3shWg9Vi9uRDvohc11d0/avmnG8xN+NOAu+0gJ4ZU1Vs2PHhQ79Wq692q3FghWIzCYL3ng+vvYxcuHfZgbKGc6nPcAxIjb4OcGPbwHGmofZY86xa295DVhAI3WTGYb1v6510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KU0/hEIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KU0/hEIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878751F000E9;
	Wed, 29 Jul 2026 14:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785335719;
	bh=DSOIRxS0YpYScOb8j7j7+KcldHLWbe9ZHkMCTkjjjrk=;
	h=Subject:To:Cc:From:Date;
	b=KU0/hEIpXcWrx3ONXYxu3TVq8CVU+L2SwLQZP1XXZMJj7I+k/3f2Mb9/PTmz4RLLC
	 ndJ6lDl4gL6UpMh0Uk4QJybdBhtq4/Wugu1iUfiXzmg5AB1eeFIWsRiX5YWN5cK2Qk
	 Sh50eBcHfVqgiSbXGjP6/WwnEq0mND9D5CdPfmME=
Subject: FAILED: patch "[PATCH] amt: fix use-after-free in AMT delayed works" failed to apply to 6.6-stable tree
To: shlomojune6@gmail.com,ap420073@gmail.com,horms@kernel.org,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:35:05 +0200
Message-ID: <2026072905-extras-punctured-4cae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ea20c44935d6142daecfa9b39d635033a7553e1b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072905-extras-punctured-4cae@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

