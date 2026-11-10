Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273913;
	b=k1wJIWiuLSJ6AWwW503iFnuqKiQb1k0yP3VDbhw4Y/X1UfHUL/a6lU2A3nw6rQl2BDsO
	 PKCQo6TVg82mU2EXTkP2K2hp8234bhiRNvjGFyOS6jYXQ9yH9dj2GOjuxSNyodWTv6Jxl
	 rQBnQ6v8UFvbcmKtF4pPh5UVaokBkiWg/jJgCxOnOTSx0T05JBHD583qLJf44xFa5did/
	 7m7npj0LTp1es1nyTzqbEkYhaexLFscS/kkKDA6VJ7oBx/j5EjclTu+nAS42qZx9qq+N3
	 sNBquRQLf6eZGIzB9WShGX2amOlRXMWlLHOhCvwkZJuK4hj6GNavp0OtVM3ktHqE3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273913;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZXPmd6tut/anTcTkS+vA3cwBSsjTEehAuagEfE/ZRqs=;
	b=wZLSDHOiNfrW4sH1wcoi9+aQ8+1mmbjWd1zROIBoO44GyF5HF7zKI+IkHz8pFHP350RD
	 v3qUjqCXzlGt9buh+VFjG47B5FeF9Z4ZXvbgu+PXS9rafrkAyw3i/YQZLD9zXiPXsny9o
	 vXVeeQogCpY02z1zZKh8YxQVbzbd6wEfhW0bgbHZbLWD7b8sobiCT6HZHhZUqnNBrhSyy
	 MxXrfpKxbwCgPsw7TrUW717geL9gr1i6bXODyULxHCQdn3ctsT6NZNe2wLB1py+oVjGgF
	 HbcbCfru6SI/IsBvb9tHtHbySKvMfsqO1NaJUDcEIsNFlHH0IDoiEygpD1Q8N7Lsjtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeXcBzkj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E4B606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LeXcBzkj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF061F0089F;
	Tue, 10 Nov 2026 01:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273913;
	bh=ZXPmd6tut/anTcTkS+vA3cwBSsjTEehAuagEfE/ZRqs=;
	h=From:To:Cc:Subject:Date;
	b=LeXcBzkjXX/2WbLj1q7+6q2+m2hwEV+CZhIP789Dbf1lzEpuqyFmKqyWhD276kOxv
	 pL4gGa6HiS/c8xiNXkdHFWwYuCVCT67bxV3DPbTgFL5z71gZ4jA8CVlXsbopOiMyxI
	 KqQ3n5flMGOsHrju+QZElGJKTPsUwAN555e0B2xZ6Ni1i+n45ysjusfp/H0vDXON5B
	 FQ7CrbIYX585DRB4OhdeIrlL9oM4HVSt+kKwMAxOh86EL2pzMqtodZjWS1ONdd+snh
	 7kCkVeQpjj6M9h6jYq4jVY7k2+CkMCZvT+pfaKrPP3qYh0sFbVCPvj0p0c/tc/dUmF
	 u2rfX/rDD45iQ==
From: Sasha Levin <sashal@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	asmadeus@codewreck.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] 9p/xen: drain response work after unbinding IRQ" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:11 -0500
Message-ID: <20261109202511-failed-5.10-7b6f2e3c29fb@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7b6f2e3c29fb4d76f1e4973280792eabbd526602
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202511-failed-5.10-7b6f2e3c29fb@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




