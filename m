Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272456;
	b=JS/RkMKDRzbBsodP4t0lqi4NgpudVszrpX35ZO5qD4vuRqXl/34Qfn86G2lSSq6t19KY
	 fGELg7S65u0IpdYRjD//CVUtFXjHyDpbKpE0IE3/YBaT4owAiepgDXSi8AuwHuKzvmZYO
	 IqKQB26RbvMkVUPavlxA1/d7I7h1yHP/7z4QvZAlt4YKCRHqXVrzczhWVNX0Tw56Y07hJ
	 z3KjHpypXW3LrXgJVYkk81ESezudnn/KccLOEHkXYzUzMrUtCqrDg26gMZMIuvmA4itOp
	 JI9nh20Vsqd4KKocggM7c3ADarwXCiqM4OYXNH/pz5eRguf5CVDxtPrm87HxairgoZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272456;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=q/xp3ksJitjsyBHsKTRktsqG+iWF66HxAT19HfbKGtY=;
	b=g1EfRlo0FbndtZmx1LNbyUJck3eKX1GyN0IThn7ZTlX/cdCgWqqO9ZHYutYaNDR8gHA5
	 +Qkqmut/dRzgFRXsDQDktcnEyj6bAr9uQja1jUmYK1ooxJWeaC3lm3AEFmwzDyn+3pW2i
	 OaVGSw75BsmJt/BldrSoVty3G6ME5ZZIfssA1F83VvIRDIvhSSdWRbkv6lz4PmntNCp5R
	 +vxMHQ/u3u+KtWk7y2aImFuEErUsvvnnHMRn7gh8//bqU/wyKDQdIcEosSrE8sGDbARvj
	 oEs+ywcvYHk6ti+OpnUGl/9ADVXhnTZmnFFCJcxs/9kR7ORJMmuEd9KPHLK1svgfQ6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+6PVagd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83518606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L+6PVagd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793311F0089F;
	Tue, 10 Nov 2026 01:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272456;
	bh=q/xp3ksJitjsyBHsKTRktsqG+iWF66HxAT19HfbKGtY=;
	h=From:To:Cc:Subject:Date;
	b=L+6PVagdcuoJMyx+UgP3HajlNMsPc6Qu5+znp4W70iRgAWSdXR5En101wQCd7Jqhn
	 ARN2CElQOW+U35LXwBZxXPwMSVDLVFStHbHrXN43uQdNpgTL3tOQQe57cUDCuz0YCT
	 Q+oUcw/4n6USA+1aCYZPpQJ+tOH6ktriBQssQfk04ou4jCaO6Wgx+UHzG8qvei9/95
	 qmZ6HhwqJVjMnUqMaUUTpSRj1+EkMZ+A0Qvv/l/kHkPKjU2xt01rHf3/1BxhYd6tQn
	 ko0LrQVsWGLtBInVUG6YxKVL5xUUjAKfejG/TXvkP/B4sLbHVWzU2vdYVtNiW1eUXv
	 O1nxz4NZpfA1Q==
From: Sasha Levin <sashal@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	asmadeus@codewreck.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] 9p/xen: drain response work after unbinding IRQ" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:00:54 -0500
Message-ID: <20261109200054-failed-7.3-7b6f2e3c29fb@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 7b6f2e3c29fb4d76f1e4973280792eabbd526602
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200054-failed-7.3-7b6f2e3c29fb@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




