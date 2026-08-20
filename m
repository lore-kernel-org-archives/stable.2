Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDFD3DD87B;
	Thu, 20 Aug 2026 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260481; cv=none; b=KUXgc59HKOZRZkKpsEREroDJNqTipqyvAz0H/uxJROopWbkJMpJzlxpKp5ylgBaEA1F6xwSSjcD0vFOCIdeIPKf8sEFw0+pXOlK2jglUl+T/47JkelGWV4QIHaufLgYUNNhhXuxMSGTRV8M8HMU5KDEW2edpQ0LbCytGHUEOy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260481; c=relaxed/simple;
	bh=stkbopTI1vtZm3RSXs41CcEU4yW8JbdiXRQG0a2vfMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pyjcfGhHq+pDPh/kMTPW4IsCkMNG5QUvrjZVULoWBG3cyvs96rc8d9Dap2EZPc5fXykWqM0l309Sv2Rvy6moIlx7c7JNuq4wnSML/JKjWkYEvFUJK7yxY+v5r23b5+WeZDHPbgnN7SMrU6x+XL5bTIZ0AMXRtLZSFuPBDJoZglo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hx+ZQsw2; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hx+ZQsw2"
Received: from vm-dev.d0aziqou4eyuzblxqhi51nu2sc.xx.internal.cloudapp.net (unknown [4.246.87.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id 72B9C20B7128;
	Thu, 20 Aug 2026 14:13:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 72B9C20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787260438;
	bh=JtR5TctMcS/Ts6F1E1F0hudbmG1QYLKTHTLiSiZGywI=;
	h=From:To:Cc:Subject:Date:From;
	b=hx+ZQsw27LQPmT/Dkvggt87AYxEvv/YuAqHP74xH4WRNPSHOw6fsjGvlol+cAp4fV
	 MzqnaGun4KlzFkGQ4+X/vsKMkuGahBrtOtM7EjxOFjSe4qC6M54Tph/V944GkTU8E/
	 eC2R4duOnm6OqaxJCzKgzSeWcVxN/3tRMF/s6wGw=
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
Subject: [PATCH V1] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Thu, 20 Aug 2026 14:14:18 -0700
Message-ID: <20260820211418.1409602-1-taherafahimi@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 29fe3a61bcdce398ee3955101c39f89c01a8a77e ]

An XFRM_MSG_NEWSPDINFO request can queue the per-net work item
policy_hthresh.work onto the system workqueue. xfrm_hash_rebuild()
retrieves the enclosing struct net from the work item, so the callback
can dereference freed memory if it runs after net namespace teardown.

Upstream prevents this race with disable_work_sync(), which blocks new
queueing attempts and synchronizes pending or running work. Linux 6.6
does not provide that workqueue API, and cancel_work_sync() alone is not
sufficient because another request could queue the work after it returns.

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

