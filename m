Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273608;
	b=JKwP55eVPhb6YHdR2Nnfq46C3GVxz398BL4vjnYYltE6el29UHnNslz9lmfNJIOsGgw8
	 48Y5QlDc+7NQVcsWnrl+JALWSMlC0zE0odilsmSHmOceFBdOGmovkK3u0gdACu6dwu4Mm
	 Mo5n/fEBbVRzM0fhMnQH1aVQ1Kxy1xV8KEpLed5beSQwNleifhEkLk/tJqHbnfLYyeVny
	 TSSVoHTYNxWwf9jcGWlSUwVyPqylBmshPZpXZKPQzQi4GGLe2Qku7+lSKNd2323y8SFuS
	 O9WaG9zT741e/JRaOc+WMWtbBrLZEU5ftyvk+80k7Ljvjpqw8Wsc0hGlvF/2Sadkj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273608;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C8DZTjUdtL/4/mCL9TdWmwRYITvNwby4e2zBKne/oGc=;
	b=QiOpZoPTPOmu3fPJJzNhAN85JQ5jmOB+WFnu4et4txsDVuZb+FBHmqQTKvuq1Kx4hPAi
	 nZ9j1NlCTAIGrR1pO+GDoYE8X/Waxrd5QniJ5tvuW+aHy6M4pm+GoOi9P2haFkhckdYMs
	 OcNXCdeJZIL1MKccXn6ASOrwPenK/vjN/XA3NsOnhH3HC46DGT9UP9LXw5QEDp/SFVgDi
	 rt5ieMSXZGk0HW0B6rAK/Pvo92cG+k3xhobizpf1J3bkjLoyKJAxxY1PWHY7yUiNLN2iH
	 6xyWx7wwJwEUU5aS1Ynjj9+dSBWW6cQBU/Eb/5+uwo5rqQskHvSiyh+ut5Xkk6tDy1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwvHmUsr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203DF60A2610
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NwvHmUsr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E5A1F008A2;
	Tue, 10 Nov 2026 01:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273608;
	bh=C8DZTjUdtL/4/mCL9TdWmwRYITvNwby4e2zBKne/oGc=;
	h=From:To:Cc:Subject:Date;
	b=NwvHmUsrGTQIGMJRBHUcI4JdfXJCBkapizv4i5gkrMSvP9J2lpeg6G3aJuTPxU+rZ
	 xywS0Q90E/e2lSBgJliTAybznAgw5izB4LG6Z0IOf+CY2ufS0hnuPeEnhGMY++w4cd
	 a8cTcwRkRDzcLUFegTp7hPGy4rUK2wtqYbpY1rMWSfJxcXxuJ39SxvdOj4q6A0a35j
	 u70/InQp+ZmdAVS/l1ewaQWfa/UXIEZYd4yX6rB84RNEt2I/e/kbGm6oJ04rdkntkK
	 KMiATdYh87+ivAkU+Vzt24ovMCikUv0WBVbneuNIz9LzK3CEluNlJV6FXnpkX6NEgq
	 aZ0mW90J0T8nw==
From: Sasha Levin <sashal@kernel.org>
To: zhaoyz24@mails.tsinghua.edu.cn,
	yangyx22@mails.tsinghua.edu.cn,
	wangao@seu.edu.cn,
	fengxw06@126.com,
	qli01@tsinghua.edu.cn,
	xuke@tsinghua.edu.cn,
	asmadeus@codewreck.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] 9p/xen: drain response work after unbinding IRQ" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:05 -0500
Message-ID: <20261109202005-failed-5.15-7b6f2e3c29fb@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7b6f2e3c29fb4d76f1e4973280792eabbd526602
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202005-failed-5.15-7b6f2e3c29fb@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




