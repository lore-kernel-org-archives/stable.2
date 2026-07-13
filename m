Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2B434E4B
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950814; cv=none; b=JBzEpWsONFfOISNdMZose0WhpUbtGAt3iVR4TPklvp7G1q+al8xrc38lar16CrwdpV8nV+cI6WiVabaPd+rZXr7tXORzqmaId6XYKu57I4oaQ1pTUNHGLcmVJ0GMHJCoEsyqbmqZ12SXgNyu7nVVQeN0PcgVbfC+rOt0jqdXqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950814; c=relaxed/simple;
	bh=S1xKfgeIFWG1s5VdaMDGPoJESbsuJi159VmFumETu94=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UcUPvfxr+ua07EBS/Sy0HQk2UkqXB/6SVRiTYPsfw2PzUDVXMEXSYUs/fbjBG7KpZeQwPo1EYHQboDaU7sYRc4mGdE/Dcl/Zogy3qhpPJtTEw7C6uZwkYvkS0yKczqkAqP7jAytcvm2zpqw1mqL59xbLbBM71rJ6fK5nDe8kPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LDnf59Hd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LDnf59Hd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2ED1F000E9;
	Mon, 13 Jul 2026 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783950813;
	bh=7DWlsb3D6+50zHbBjUbhuGfSBfWlu84n/coGuYmuIjQ=;
	h=Subject:To:Cc:From:Date;
	b=LDnf59HdT5Qz4Ju3otxfKKK5jS1hATl6fbxxuWCctAV8kU44udgtINIJ8EzCkP8zl
	 Cqcpr1uaRJQFMuYjjHoy436oFlmXuMTRvPCzGO9rbTGIZQ+K8sE9GLQv8ykHoL/0yX
	 zGqNB/MyrfccS3m1fFcLpOLNn75LFONq3Uy+m59o=
Subject: FAILED: patch "[PATCH] netpoll: fix a use-after-free on shutdown path" failed to apply to 5.15-stable tree
To: leitao@debian.org,kuba@kernel.org,pavan.chebbi@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 13 Jul 2026 15:45:50 +0200
Message-ID: <2026071350-embark-gave-c0f4@gregkh>
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
git cherry-pick -x 45f1458a85017a023f138b22ac5c76abd477db42
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071350-embark-gave-c0f4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 45f1458a85017a023f138b22ac5c76abd477db42 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Thu, 25 Jun 2026 05:03:18 -0700
Subject: [PATCH] netpoll: fix a use-after-free on shutdown path

There is a use-after-free error on netpoll, which is clearly detected by
KASAN.

      BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
      Read of size 1 at addr ... by task kworker/9:1
      Workqueue: events queue_process
      Call Trace:
       skb_dequeue+0x1e/0xb0
       queue_process+0x2c/0x600
       process_scheduled_works+0x4b6/0x850
       worker_thread+0x414/0x5a0
      Allocated by task 242:
       __netpoll_setup+0x201/0x4a0
       netpoll_setup+0x249/0x550
       enabled_store+0x32f/0x380
      Freed by task 0:
       kfree+0x1b7/0x540
       rcu_core+0x3f8/0x7a0

The problem happens when there is a pending TX worker running in
parallel with the cleanup path.

This is what happens on netpoll shutdown path:

1) __netpoll_cleanup() is called
2) set dev->npinfo to NULL
3) call_rcu() with rcu_cleanup_netpoll_info()
  3.1) rcu_cleanup_netpoll_info() tries to cancel all workers with
       cancel_delayed_work(), but doesn't wait for the worker to finish
4) and kfree(npinfo);

Because 3.1) doesn't really cancel the work, as the comment says "we
can't call cancel_delayed_work_sync here, as we are in softirq", the TX
worker can run after 4).

Tl;DR: queue_process() is not an RCU reader, it reaches npinfo through
the work item via container_of().

Use disable_delayed_work_sync() to ensure the worker is completely
stopped and prevent any future re-arming attempts. Once npinfo is set
to NULL, senders will bail out and not queue new work. The disable flag
ensures any in-flight re-arming attempts also fail silently.

In the future, we can do the cleanup inline here without needing the
npinfo->rcu rcu_head, but that is net-next material.

Cc: stable@vger.kernel.org
Fixes: 38e6bc185d95 ("netpoll: make __netpoll_cleanup non-block")
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 229dde818ab3..96d5945e6a30 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -633,14 +633,6 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 			container_of(rcu_head, struct netpoll_info, rcu);
 
 	skb_queue_purge(&npinfo->txq);
-
-	/* we can't call cancel_delayed_work_sync here, as we are in softirq */
-	cancel_delayed_work(&npinfo->tx_work);
-
-	/* clean after last, unfinished work */
-	__skb_queue_purge(&npinfo->txq);
-	/* now cancel it again */
-	cancel_delayed_work(&npinfo->tx_work);
 	kfree(npinfo);
 }
 
@@ -664,6 +656,7 @@ static void __netpoll_cleanup(struct netpoll *np)
 			ops->ndo_netpoll_cleanup(np->dev);
 
 		RCU_INIT_POINTER(np->dev->npinfo, NULL);
+		disable_delayed_work_sync(&npinfo->tx_work);
 		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
 	}
 

