Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439483;
	b=JFiaAtuBBHAjr/RW/KcJUduAOlv9nhQ5DorcnMyypzZ2dVI9mdGpJL8qHPMD4W70sXGp
	 QXE+glgU8DsgehhZSwxDP/QkuyGATl6m1L0hqQy8tzB4U+EtVPfABaS4+qH9mC8L8+mjG
	 roE4/bO2qwL2qEMhE7tkVvYfhmg8Zn9fN53/EkBujVB/4hJwDwjY3i7Q0Fm8+8iL+xicx
	 6dvN/4g82IMAPE/FKrO3EYegf9C5ldrfFMTeM9znBYftQbVhOKXewQfSJGgR4gYZjVHSL
	 eY7RJYYJBrwSbed9cvFKk+lg0XibwGaaSubc7Mv7gmFhHEhtnFvNUrQ7m/QPAs6sgzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0lZp5LYlWIljT/TDK+20V6m+qVZi6L43Se5nlTzzq3w=;
	b=dW1pMsitkhs/FmexIctORMhkMTvkj5k2KSDdK74rKk2H2g+9PvBZOoibBUGL4IcVw4sd
	 C5dgVODh1OxYZLPQseHeDYJI/WZ7LBjkvDMJPxL2g1KLWfcyMNb9qaVjJM0Lq83vaCP3g
	 cdZKX8oLmxS7xjdFrY7w6iPbRDHoUaMJ+jWs+EyKGkclg8nocHF9a7vAweX+Qp7SylXuW
	 5H05mTOR/qA7MKSvyE0el57aARPD3nIYdM483Mex8NKJxpftkOf3Uun6W3cnuxnyHsDWC
	 ZeTSc01yuPHqk9Jv3Z73mgnvUCMf1+fXfmYztAdS7FLhiBwzLjd5M3tTBlCi/LZ7rJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwHrruJT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FA1606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwHrruJT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906CF1F00A05;
	Wed, 11 Nov 2026 23:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439482;
	bh=0lZp5LYlWIljT/TDK+20V6m+qVZi6L43Se5nlTzzq3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwHrruJTK0+6hY+BHccWcx7qtX/56Ab1lYWxYlxKhBbHPvvY97Z7DSh2668UrA5nm
	 WCDNp5eQA33u9HRFK+uXniCTZ0bn90fwBYViH5FQ59tEmZ8iDL/UllaOZ5dzZKWZYe
	 uYDIu3IdqoorsoOm6jDEf/0fIPeJqY9TQ2dv69eGQJZ7kGvr31QH3QnNFpyXDMBuLY
	 rSFAaZZK0/Qf1pGzhKSIH8PebwCZL00O+KGa4takm0K40+qywTcNLcvwE7Kk7MBaN7
	 U8ysLao7CWwGmSEH73SOmbIPV8q9HeDTDhp8qaCpt1wyIi38bfMSdfdbKAsQoNLR1G
	 uptt66JCFQsNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 18:24:40 -0500
Message-ID: <20261111232430.405441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200054-failed-7.3-7b6f2e3c29fb@kernel.org>
References: <20261109200054-failed-7.3-7b6f2e3c29fb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>

[ Upstream commit 7b6f2e3c29fb4d76f1e4973280792eabbd526602 ]

commit ea4f1009408e ("9p/xen : Fix use after free bug in
xen_9pfs_front_remove due to race condition") added cancel_work_sync()
to keep xen_9pfs_front_free() from freeing a ring while
p9_xen_response() is still running.

The work is currently drained before the event channel IRQ is unbound.
That leaves a race window where xen_9pfs_front_event_handler() can run
after cancel_work_sync() returns and queue p9_xen_response() again.  The
following unbind_from_irqhandler() synchronizes with the IRQ handler, but
it does not cancel work that the handler already queued.  The teardown
can then free the ring and private data while the response work remains
pending, and the worker later dereferences ring->priv and priv->client.

Unbind the event channel IRQ before draining the work.  Once the IRQ is
unbound, no new response work can be queued by the backend event channel,
and cancel_work_sync() waits for any work that was queued before or
during the unbind.  It is then safe to release the ring resources.

Fixes: ea4f1009408e ("9p/xen : Fix use after free bug in xen_9pfs_front_remove due to race condition")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: GLM:GLM-5.1
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Message-ID: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
[ sashal: Adjusted indentation to fit the existing if (priv->rings) cleanup wrapper for separately allocated rings. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 71a4d276321e2..69a5129a9b64a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -291,14 +291,14 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 			struct xen_9pfs_dataring *ring = &priv->rings[i];
 
-			cancel_work_sync(&ring->work);
-
 			if (!ring->intf)
 				break;
 			if (ring->irq >= 0) {
 				unbind_from_irqhandler(ring->irq, ring);
 				ring->irq = -1;
 			}
+			cancel_work_sync(&ring->work);
+
 			if (ring->data.in) {
 				for (j = 0; j < (1 << ring->intf->ring_order);
 				     j++) {
-- 
2.53.0

