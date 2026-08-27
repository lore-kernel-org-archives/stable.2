Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750D23F7872;
	Thu, 27 Aug 2026 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787820325; cv=none; b=t4vX7FFEMK1RQLzAwZ7th3TqaUTULhf1FDo+EV9XYfH7PjMbBpWvvcxaIfN5F1amE+pIiYgS3773UoHPVx3vGZk4zq3rbmIMrEAg/DqdQl/caJa4M5Waomlr2djFTJvVtz2bK6XPznmGDZSKeKu+aMPTMgHIVdMMEJyXUGO7Ihk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787820325; c=relaxed/simple;
	bh=I6OYYoffJEfpbW5zhOWheUwP13cP0kHisifFIVJxQwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HUD4ia88Py6As5BiPVgPIeMzIzJp+MvYovBN2HgIyQzQ6wLCyGIW6gstk0ge4eo+dyTj5aKegkSDRH9Xc9id/YXRZaLhQTRzxRUN8aUYwxlGFkzBJDebNbEf8HvqllM5vQwKjFobrYLXMu8wSJdjQrZjHaXi+YEi74yixpu1/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EM4EXgVz; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EM4EXgVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+P
	7bjONK6gu57aqGlngemiW4PS9He6XDYV6ywZhjoVs=; b=EM4EXgVzSECCt4nwX9
	PpLq6MRTwrRFWWFGAPc7pmMa5uEKQQwuDWCeDVJ6Orkf5mFqn1mOXsbEKWS4C1bV
	Du+qEShCMejWlznyWZXezd1NJ6Y/3QlbEg6+rRCzrsQbdp9Jm7OxWhYKsVVtRDBK
	mEvt/MDq87RRIR9a1K4KRAQAc=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXY_kG+Y9q545uPQ--.26825S2;
	Thu, 27 Aug 2026 16:44:55 +0800 (CST)
From: ghuicao@163.com
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>,
	Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Cao Guanghui <caoguanghui@kylinos.cn>
Subject: [PATCH v3 1/3] md-cluster: fix lock_comm leak and __sendmsg error path
Date: Thu, 27 Aug 2026 16:44:51 +0800
Message-Id: <20260827084453.124629-1-ghuicao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260827061200.79753-1-ghuicao@163.com>
References: <20260827061200.79753-1-ghuicao@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXY_kG+Y9q545uPQ--.26825S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrtw47Kw4fAr45AFy5Jwb_yoW8tFyUpF
	4UJ3s0y3y5Grs7Wr13Cws7uFyYka40g3y5Gw47Ja1xuFn0qr4j9F4kGr9xuFy5KrWxXF9I
	qrn8KFn8urZ8Zw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UWxRgUUUUU=
X-CM-SenderInfo: 5jkxxuldr6il2tof0z/xtbC+wf9kGqP+Qd-UQAA3k

From: Cao Guanghui <caoguanghui@kylinos.cn>

Fix two error handling issues in cluster communication:

1. lock_comm() leaks MD_CLUSTER_SEND_LOCK if lock_token() fails.
   The bit is set by test_and_set_bit but never cleared on error,
   causing all subsequent cluster operations to hang permanently
   in wait_event().  Clear the bit before returning the error.

2. __sendmsg() has two problems in the failed_ack cleanup path:
   - ack_lockres is left in EX state if the down-conversion to CR
     fails, causing a cluster-wide deadlock.  Attempt to restore
     it to CR and log if that also fails.
   - The while loop for message_lockres unlock spins forever if
     a previous DLM operation timed out and left a pending request
     (dlm_unlock_sync returns -EBUSY immediately).  Change to a
     single attempt with error logging.

Fixes: 818da59f97d6 ("md-cluster: add the support for resize") (lock_comm)
Fixes: 601b515c5dcc ("Communication Framework: Sending functions") (__sendmsg)
Cc: stable@vger.kernel.org
Signed-off-by: Cao Guanghui <caoguanghui@kylinos.cn>
---
 drivers/md/md-cluster.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -735,6 +735,8 @@ static int lock_comm(struct md_cluster_info *cinfo, bool mddev_locked)
 	wait_event(cinfo->wait,
 		   !test_and_set_bit(MD_CLUSTER_SEND_LOCK, &cinfo->state));
 	rv = lock_token(cinfo);
+	if (rv)
+		clear_bit_unlock(MD_CLUSTER_SEND_LOCK, &cinfo->state);
 	if (set_bit)
 		clear_bit_unlock(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
 	return rv;
@@ -801,7 +803,15 @@ static int __sendmsg(struct md_cluster_info *cinfo, struct cluster_msg *cmsg)
 	}
 
 failed_ack:
-	while ((unlock_error = dlm_unlock_sync(cinfo->message_lockres)))
+	if (error) {
+		int ack_ret = dlm_lock_sync(cinfo->ack_lockres, DLM_LOCK_CR);
+
+		if (ack_ret)
+			pr_err("md-cluster: failed to restore ACK to CR (%d)\n",
+			       ack_ret);
+	}
+	unlock_error = dlm_unlock_sync(cinfo->message_lockres);
+	if (unlock_error)
 		pr_err("md-cluster: failed convert to NL on MESSAGE(%d)\n",
 			unlock_error);
 
-- 
2.34.1

