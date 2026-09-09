Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335B4492E42
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976470; cv=none; b=JaE6c3ucJD7iwUb/FO6q/td4pcifjJ13rdPN8QhNz6CK8wmybMI0Vu2deSdkzHKUWiu0ZaGegpoP2EedplPPXe3MEnKmGi1QlKp5C+OtME5esan9n1rpeIVZKX6nQ+gSH55Uxzybbwf6wC0FXEUsVbcKi/Ujs4isngMWHzp8Xe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976470; c=relaxed/simple;
	bh=xm3Z8xwOnGzik5M8+vLUXiKvfZoQd5kkUThOWleujqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7l+ka+gaUhLyldHM/CbHMjsccRTu9SCbT3r7N6UegZ5aa1d6kd/vwRSceGApFCUKCoUUej7YMgeR9mio3bi2ylC0QyYMUxuuCAx45+hIQ9Zgt7+WYa4dWT/pwIUKPG4nnl+hhkdLUypouHVKCzPqTOuKDendc8zNQAWDUx2pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PaX2E51u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaX2E51u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C8C1F00893;
	Wed,  9 Sep 2026 17:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976468;
	bh=b7WhmwHMTXJ6J5ykZcoqwx4xW1fpBgFKC6waE6D4Tys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PaX2E51u74kRVZH65C5rQsgzs4aPcb16xk7582GD+9eMtFuDg9VW9tJnzdiRnIuOQ
	 k6sXUGX8okEEpZK2V77z72Y7XkjqfMTpOXppLbOAadr7eE7xojD3R2AmSa0fWAV44Z
	 gxavWpfKcZjk+VlIlfwm/n+T5Xzx8hwRdkXzzHS4DN/7+sPxX+0E0MP84G4m260xgm
	 5GkzzJOIJqC83cdlZuldnzVeCvX5CaSZXhJKyOoofwGuIuhClQBU+nImjD/M6UcA42
	 MFrc9daRuRqUlvo+vOtKAm6LJSXVzl7e6ictwyRfwP56WMnWZIGI5cYN147ZsA8Prq
	 KMN17doQnzPKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] net: fix spurious TX timeout after dev_activate()
Date: Wed,  9 Sep 2026 13:54:25 -0400
Message-ID: <20260909175425.3373482-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909175425.3373482-1-sashal@kernel.org>
References: <2026090352-stinking-autism-dd92@gregkh>
 <20260909175425.3373482-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 82aeed2400786bd3f79d88cb8b8f42e6127e5923 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/sch_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index d55b010285739..b5fc998b53f43 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -1149,7 +1149,7 @@ static void transition_one_qdisc(struct net_device *dev,
 
 	rcu_assign_pointer(dev_queue->qdisc, new_qdisc);
 	if (need_watchdog_p) {
-		WRITE_ONCE(dev_queue->trans_start, 0);
+		WRITE_ONCE(dev_queue->trans_start, jiffies);
 		*need_watchdog_p = 1;
 	}
 }
-- 
2.53.0

