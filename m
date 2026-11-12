Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794442009;
	b=ZeSiX4UTP6EyJC//E6VKmMOQ5QTaLBY3D8fTUJatAHTZYCDAItzAloO6zbER17ybxJrb
	 /K5D+LsJvnJ8xhxQCfGmRFolOxH0Ru3jeGfegZ3R+5AQ1HmCzdvb4oY/KL8oPbJiTv/w3
	 8U8HyEEseNkY16VnNp0UrsuageoKWTwB4bpesR4iNu7uq1+0oeWnjowrYaI2Y1ETrkIj8
	 XDOCDyxZt/5wtRDi/ih1guVEPtbpqvCpSKLJmJI/YerLhXxtBXWUZU1WsrNYVnxZbbzti
	 G5hI9X3HzDTB6bRvmqvZXj3sb8C1uKIX6O4CtLhm2bKHKtkjzrYNr0zgTvexwjdgG8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794442009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BRfQjUWPptMz1UAMS3vNlUkA1vj1MdhmPpAb6PQGYsM=;
	b=gHdWTV2UqKwfy9Uzc9YuKT10lZCCawZlvsBjPQN3Yv3tXsClqzfcZhUu6JQgSE6WZXB/
	 BSmYjKVnvUYRXsakYlVK9ofgdnPZlK+IlUxgdtNrdde/LdAf1vSUL8fGSLW2m7Svr14OD
	 VNV0B+fFSi8EA2DVJxlSgOhychEiosgPnTTGzg6cwWjC4qvLsUfO5y30qfbFDyNDCU585
	 dS0HcnB+Pkftzj5W0+WBbqYfGrsVZIFRfpNPmawOyR9x529qFipvxzbYYr2Vt3e8QGuls
	 5sJA5qWD8qypYWzT7TQtgBzHKMyPQOuaAC2Vg1uAw/hNqlUKMjRjROOzDXKK3nXhpSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LytuN02X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DC8606A326
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LytuN02X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896791F00A05;
	Thu, 12 Nov 2026 00:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794442009;
	bh=BRfQjUWPptMz1UAMS3vNlUkA1vj1MdhmPpAb6PQGYsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LytuN02X/jbn9p41csK+frAB9PM2UOEvVTUU2Irr0MqlIXUkd7//GTzKULrI3DiEF
	 JV/c74oUfYSVtkmnGFBsl54quvRlm2VeH1RLitBkAIzFTE3C1Tnqws/ABoNJcuI1a2
	 Rn7xM4pZiTxE4lX/WaljHJOnnPvveJ7rS7444dHmZBn55qWoyJqCHO2F++H6epnzMj
	 EBZ82YaSvKolfT/FVuWEMfMThF8KJFhrbzrpZltCZwBgWQdPYH2AQLhheqSPxvt+qr
	 Q9O/gw7Uf1+fmis3OM+T8vplVm06HZTn9vNzPQeZ+I/IbL7EHtD7mKnWtNscLK9GM/
	 3aInvkKIBbGuw==
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
Subject: [PATCH 5.10.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 19:06:47 -0500
Message-ID: <20261112000635.1061290-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202511-failed-5.10-7b6f2e3c29fb@kernel.org>
References: <20261109202511-failed-5.10-7b6f2e3c29fb@kernel.org>
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
[ sashal: adjusted context to the indexed ring cleanup code with its irq > 0 check ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index ff81b323ea7b5..45a16494bd79f 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -310,12 +310,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	for (i = 0; i < priv->num_rings; i++) {
 		struct xen_9pfs_dataring *ring = &priv->rings[i];
 
-		cancel_work_sync(&ring->work);
-
 		if (!priv->rings[i].intf)
 			break;
 		if (priv->rings[i].irq > 0)
 			unbind_from_irqhandler(priv->rings[i].irq, ring);
+		cancel_work_sync(&ring->work);
+
 		if (priv->rings[i].data.in) {
 			for (j = 0;
 			     j < (1 << priv->rings[i].intf->ring_order);
-- 
2.53.0

