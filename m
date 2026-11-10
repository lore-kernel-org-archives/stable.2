Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272533;
	b=bK1haKPQyjB0vf8ytcnptkNpV3F42YMQa2BOyBJSOWDRjFOvmjo5L82to/R4QlUz9Afb
	 8MGSkmfV3p2nDn1JopBFPUSLX6nTV33n/r28aEHpIhb5hU87PeCQf6tDO4tlSo/2GDpr0
	 c1cbT37FWy9oa9Jpvs9U820nbtn0RYFhQm+aNY8vE2aZm00Xfc9NoCdjT7++jrlsOcZXj
	 FJXBQjk3HyjeHWFUzKD2h90NgP+COU+gr6u1h5iuap6iMlr0gVATWV5ilkB9ykEuFL0wf
	 yk9MkdU0tlBzNr9Xdps98xpKh+Q7ZvOlc0ZEGB36mMKCvd/dsJfVVYTFuq90MH/1I4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jy3VEBgxMZURJv/rGA8tqFb4k/nn9rTukJ+APuawrO4=;
	b=A8/JZh+gHP523hvgBPezqBdz4kRlbvD5ptKuGhqjNZU7/q3g6i9+tVpxAWG4LTcHhjkV
	 8djGdfSPUhiuvy8+egmpsBN+zS+Cz7rikcXiBm9ynjEcEBVSy2GMTwbQ/FFwWHkRBdstI
	 8uPe1cxTYrIKwzIIigXW1UmfMCoJbh3cpijoNxUZm0HPIpKkooU1C0bopNV9RrcGpJOQ5
	 MxFRQkl1th3HpB23bg1GuYEl9Uih/miF73UcRaZ5drcx5wa4f1zAT9T1hMv1y0ext5rRR
	 wuU5DSkf58YT4c1UoiAWeNEmTwXw4IyUooCrN+IdiSU1Ib0ydWY4zgr6rybkw3wzdLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbw5OdRZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015BC606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbw5OdRZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33581F0089F;
	Tue, 10 Nov 2026 01:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272532;
	bh=Jy3VEBgxMZURJv/rGA8tqFb4k/nn9rTukJ+APuawrO4=;
	h=From:To:Cc:Subject:Date;
	b=bbw5OdRZnmtmkMZR/vuEtK4W1TYBmXEipVdH2UkxfpL3O5LmZYMGy+zNa6+raa/xT
	 ie0nCCWo25RJEJRSkJcR7OoalFdsBwNIvm5jc1we+PgCX6Wg3xyCT/+sbwxuf1Bonb
	 t3Zk+MtAptw3MiPucw5eOPwyEwwQEoRbx/0XI7jyUJXmlDR42wAvpJWU0FC6m8XUVQ
	 hkHDngZ1urAP7o8iVQIW0ccE3lQGX2fZLlGDPDlWKnzqeNoE74141b2cw/OVVI3qGV
	 c449Tljag335Lq3OVvD0kIFCP5YZH4rTyKS6jpFr35E6P/7IG+1OqSOV+CI48ulEfq
	 OSMTX56QZsrRA==
From: Sasha Levin <sashal@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	asmadeus@codewreck.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] 9p/xen: drain response work after unbinding IRQ" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:02:10 -0500
Message-ID: <20261109200210-failed-6.18-7b6f2e3c29fb@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7b6f2e3c29fb4d76f1e4973280792eabbd526602
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200210-failed-6.18-7b6f2e3c29fb@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7b6f2e3c29fb4d76f1e4973280792eabbd526602 Mon Sep 17 00:00:00 2001
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Date: Tue, 9 Jun 2026 23:52:01 +0800
Subject: [PATCH] 9p/xen: drain response work after unbinding IRQ

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
---
 net/9p/trans_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 5a0b5b83e8ab4..9ee1ac9143d43 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -282,14 +282,14 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 	for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 		struct xen_9pfs_dataring *ring = &priv->rings[i];
 
-		cancel_work_sync(&ring->work);
-
 		if (!ring->intf)
 			break;
 		if (ring->irq >= 0) {
 			unbind_from_irqhandler(ring->irq, ring);
 			ring->irq = -1;
 		}
+		cancel_work_sync(&ring->work);
+
 		if (ring->data.in) {
 			for (j = 0; j < (1 << ring->intf->ring_order); j++) {
 				grant_ref_t ref;
-- 
2.53.0




