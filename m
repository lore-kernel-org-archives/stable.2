Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC8A37AA9F;
	Tue, 29 Sep 2026 23:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790725992; cv=none; b=B/OyNZeVgNnbcFPxsUVreeNEVz+zEjIdl4frmq6IjvQSJh0qz69kGh8soK72PiPUOTmB+8cLuL3njhnRDnGZt9E8q4xVvVIYUdzXWAHPosiu47h1sz4APlXlQiVpzHO6c7C3m5SJXayq9J9PLdQoVv8+yXUPGLGYBOHHU0nqlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790725992; c=relaxed/simple;
	bh=6q/6KnWjsu69vYtu98mMDGpzBK6JpaRpFdcOvQuRvzg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U46phU0oNrCwg8n5/urji3t57k7nCsCxJbpd8EzDsehb+mJ7wecYf0Md4dpwmAbiL74trDzTcfWDoDGWVeBTDYZSFD2c3xpuZVn5CXGx0Dt3nmtZPmaJwX2A8Yt0qNXbanasgTm5jKraNzhuoeNYvl6xrkgerh+8gElpjDv6SYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=el6Mko8m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="el6Mko8m"
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8ACD020B7166;
	Tue, 29 Sep 2026 16:52:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ACD020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790725938;
	bh=uWh+FnnglfzJGtPzkZJzUV9NoEhwz6g37aVYhBgGsgI=;
	h=From:To:Cc:Subject:Date:From;
	b=el6Mko8mXIsPUvM8NXQw+mc+f4Cttczggwq6Kvn5IgXeUdSLETeIhDeiRmoc3kRLp
	 i1KSrfoZUDGjM1ppvGhAWaUK0G6GRU9sQ8FuUm2YBfY1EsCGIHcyOoEJR90zdvjPhH
	 TrkoGJEJBvzseSg6o7TDzUpVMsHOlZhNf7/XME4w=
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	raminwo0202@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com
Subject: [PATCH v2] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Tue, 29 Sep 2026 16:52:56 -0700
Message-ID: <20260929235256.1398309-1-taherafahimi@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An XFRM_MSG_NEWSPDINFO request can queue the per-net work item
policy_hthresh.work onto the system workqueue. xfrm_hash_rebuild()
retrieves the enclosing struct net from the work item, so the callback
can dereference freed memory if it runs after net namespace teardown.

Mainline commit 29fe3a61bcdc ("xfrm: prevent policy_hthresh.work
from racing with netns teardown") fixes this issue using
disable_work_sync(). That API is not available in Linux 6.6, so the
mainline change cannot be directly backported.

Provide the same guarantee with an XFRM-local work_disabled flag. Protect
the flag and schedule_work() with the existing policy_hthresh seqlock so
teardown can atomically stop new queueing attempts. Then use
cancel_work_sync() to synchronize work that was queued before the flag was
set. This ensures policy_hthresh.work cannot outlive its struct net.

Fixes: 880a6fab8f6b ("xfrm: configure policy hash table thresholds by netlink")
Assisted-by: GitHub-Copilot:GPT-5.6 Sol
Signed-off-by: Tahera Fahimi <taherafahimi@linux.microsoft.com>
Reviewed-by: Allen Pais <apais@linux.microsoft.com>
---
changes in v2:
- removing incorrect upstream commit annotation from description

 include/net/netns/xfrm.h |  1 +
 net/xfrm/xfrm_policy.c   | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 423b52eca908d..99eb5c2ff888b 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -23,6 +23,7 @@ struct xfrm_policy_hash {
 struct xfrm_policy_hthresh {
 	struct work_struct	work;
 	seqlock_t		lock;
+	bool			work_disabled;
 	u8			lbits4;
 	u8			rbits4;
 	u8			lbits6;
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 00d9693c13ae7..cc8f4d4b70875 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1384,7 +1384,10 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 
 void xfrm_policy_hash_rebuild(struct net *net)
 {
-	schedule_work(&net->xfrm.policy_hthresh.work);
+	write_seqlock(&net->xfrm.policy_hthresh.lock);
+	if (!net->xfrm.policy_hthresh.work_disabled)
+		schedule_work(&net->xfrm.policy_hthresh.work);
+	write_sequnlock(&net->xfrm.policy_hthresh.lock);
 }
 EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
 
@@ -4181,6 +4184,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 	net->xfrm.policy_hthresh.rbits6 = 128;
 
 	seqlock_init(&net->xfrm.policy_hthresh.lock);
+	net->xfrm.policy_hthresh.work_disabled = false;
 
 	INIT_LIST_HEAD(&net->xfrm.policy_all);
 	INIT_LIST_HEAD(&net->xfrm.inexact_bins);
@@ -4206,6 +4210,19 @@ static void xfrm_policy_fini(struct net *net)
 	unsigned int sz;
 	int dir;
 
+	/* Prevent new policy hash rebuilds before draining the work item.
+	 *
+	 * The upstream fix uses disable_work_sync(), which is unavailable
+	 * in v6.6. Protecting work_disabled and schedule_work() with the
+	 * same seqlock closes the check-to-queue race, while the subsequent
+	 * cancel_work_sync() drains work that was queued or running before
+	 * teardown disabled it.
+	 */
+	write_seqlock(&net->xfrm.policy_hthresh.lock);
+	net->xfrm.policy_hthresh.work_disabled = true;
+	write_sequnlock(&net->xfrm.policy_hthresh.lock);
+	cancel_work_sync(&net->xfrm.policy_hthresh.work);
+
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
-- 
2.43.0

