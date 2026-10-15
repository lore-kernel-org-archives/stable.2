Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B44C8C7B;
	Thu, 15 Oct 2026 20:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095775; cv=none; b=gvrAj1RMlWh/g1+n50BONDiMMyAB0nzxPqGJ+ju0IIMds++R3NsmJJmfD6REyGM3xUobnoqtCTHZgQgrUNbrnfrYZJYhGHi29koUbg0b7buh5qLBKPvKcNJQtEZAI9lRd/MlRUerBI1SnleIWes5iS4F/+9Cf6Uw51u0gBoCtus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095775; c=relaxed/simple;
	bh=UcyxboG3y4L8zSlqROYakKPtWdAkd5ZJG3Xq1yyxLPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iQ1t2mqX5Hut0aiT/KxrIl/spE5inUc6IaDxHHglDVr1J6cAtRO0s4DRIBPUl6dXRJ2/g0FkNmsSYosIP7iVDtdT0k9SmeckY2GWhDCmYf4ZZV3WysNnzsQGlOMeK820hOBLHqmjNt1wdEDJMd2Whge8Gns59z75EXP89IkTqfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hTdr02zf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hTdr02zf"
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA98920B7167;
	Thu, 15 Oct 2026 13:22:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA98920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792095768;
	bh=gRg/cH7UL6lx4NNK1/RDk8bJXtB2dqMDham2GHNVmaI=;
	h=From:To:Cc:Subject:Date:From;
	b=hTdr02zfbgCwM8o2he4X9xFV7rXqOGXCT4LHJiY3euSae/TehobTBbIhG55Rtrqpc
	 ve5wyp/RupVIxRoAS3qeZgdZ/OKm75hzsLeoK1c6pVKQelLRZKNBZqJPmUCSuD90EC
	 A+aGaGFcwDADXylebCgxKIKZxsxW9r/wp2NRsVs4=
From: Tahera Fahimi <taherafahimi@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com,
	edumazet@google.com,
	pabeni@redhat.com
Subject: [PATCH 5.10.y] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Thu, 15 Oct 2026 13:22:39 -0700
Message-ID: <20261015202239.1936469-1-taherafahimi@linux.microsoft.com>
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
disable_work_sync(). That API is not available in Linux 5.10, so the
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
 include/net/netns/xfrm.h |  1 +
 net/xfrm/xfrm_policy.c   | 19 ++++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 47bc0ec051eb5..bafdfdccbd954 100644
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
index 26bc082139550..c14f495f62b80 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1378,7 +1378,10 @@ static void xfrm_hash_rebuild(struct work_struct *work)
 
 void xfrm_policy_hash_rebuild(struct net *net)
 {
-	schedule_work(&net->xfrm.policy_hthresh.work);
+	write_seqlock(&net->xfrm.policy_hthresh.lock);
+	if (!net->xfrm.policy_hthresh.work_disabled)
+		schedule_work(&net->xfrm.policy_hthresh.work);
+	write_sequnlock(&net->xfrm.policy_hthresh.lock);
 }
 EXPORT_SYMBOL(xfrm_policy_hash_rebuild);
 
@@ -4129,6 +4132,7 @@ static int __net_init xfrm_policy_init(struct net *net)
 	net->xfrm.policy_hthresh.rbits6 = 128;
 
 	seqlock_init(&net->xfrm.policy_hthresh.lock);
+	net->xfrm.policy_hthresh.work_disabled = false;
 
 	INIT_LIST_HEAD(&net->xfrm.policy_all);
 	INIT_LIST_HEAD(&net->xfrm.inexact_bins);
@@ -4154,6 +4158,19 @@ static void xfrm_policy_fini(struct net *net)
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

