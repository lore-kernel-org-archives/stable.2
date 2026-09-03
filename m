Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDB4E2348
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449941; cv=none; b=AOc3XpkDDO5S3jkvX5N9WkyWMQIMcn5NIc09607Mv9m+6PhrGoZZot3SnVs9n5oAtuNNL4lOQl2WKohp9S/pVSEO3zu7ghhEymhIirPpaBLa4fnvOX2HwHnLSuM+usWSO/eGEIumnvIKO50x8HO4OlqY5USCVnkQ+9ThbHwDa50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449941; c=relaxed/simple;
	bh=MgJMhic1aQyhj3bAfR74WzXqf99R5ecXOFQ/Iq9/TDI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MQK4KEt1lpWfdQ71JSKNrJ6GtMGgMM0IaPaAvFjlK/mYsT14ulE532sE2vP+g9SViROkuvOyzPp7ahi0EhFMC1mT365ZXP7RVVWqZ3hEw4xPfI+gVQ+H6UM1fp6OFK69hC+D9gRwjeYmAnp1xR0RMQsjF1PzDp1IQwDiK0Mn3fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g2vx0UN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g2vx0UN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AAC1F00A3F;
	Thu,  3 Sep 2026 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449938;
	bh=EdiDEI8GGKgzuLBXlUDVOAdOV6sHZLIvPACAFeoQZz8=;
	h=Subject:To:Cc:From:Date;
	b=g2vx0UN5IFA/LkzPEuBliowCfw1Gy8s4wYlWwyx0Aiw8vA16V0nXtb6Z8ZBtT+xwW
	 GQny4nr/1jEyp9JhcqAVHkxtrBoPUxlo97h4+tbkXzah7/nvOE6k/cWi+0F99y9e0g
	 FBoZ0HSAqWgEHIg56K6oaCSWnSBQYzz2f5BdDako=
Subject: FAILED: patch "[PATCH] net: fix spurious TX timeout after dev_activate()" failed to apply to 5.10-stable tree
To: leitao@debian.org,kerneljasonxing@gmail.com,nb@tipi-net.de,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:10:52 +0200
Message-ID: <2026090352-stinking-autism-dd92@gregkh>
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
git cherry-pick -x 82aeed2400786bd3f79d88cb8b8f42e6127e5923
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090352-stinking-autism-dd92@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 82aeed2400786bd3f79d88cb8b8f42e6127e5923 Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 25 Aug 2026 03:50:10 -0700
Subject: [PATCH] net: fix spurious TX timeout after dev_activate()

While debugging another issue today, I found out that my TX queue is
reported as stopped for 4294907392 ms (49.7 days), on a machine that
had been up for four minutes.

    bnxt_en 0002:01:00.0 eth0: NETDEV WATCHDOG: CPU: 28: transmit queue 23 timed out 4294907392 ms

4294907392 is not an elapsed time. It is the value of jiffies at that
moment: INITIAL_JIFFIES is 4294667296, which leaves jiffies 59 seconds
short of wrapping.

dev_activate() runs transition_one_qdisc() over every TX queue, which
resets trans_start to 0, and then stamps only queue 0 through
netif_trans_update().

Stamp jiffies instead. A queue stopped across dev_activate() now gets a
full watchdog_timeo of grace, and is still reported if it is stopped
that long.

Fixes: 9b36627acecd ("net: remove dev->trans_start")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://patch.msgid.link/20260825-trans_start-v2-1-286b4d6d70cb@debian.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index ef2b4bf51564..4539dc2c6d38 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1278,7 +1278,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }

