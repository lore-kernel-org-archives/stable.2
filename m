Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441865;
	b=xBXfcqwXP8M8sB4lcNitwju4/G3/bfBCj8nhn/U1yxYtRiBAQoSaEHA4iGFKRnqrM+sH
	 MnHaurY8Kq/vI2MITSw9bjULbyPGbpei5a6P5Wu3s++Oo9ZZpmDy5BdBhNsxokezd9Wmk
	 yot9nryKKspytVJYWTIO5LPZaB9WYQyYJwpJpKiHBcDH91B/Er1NvhvcSlUB2r5PKsSVw
	 oWRF2qGDPQoG/BpwtmHgL/i4RCvvbXQBYkuvMOs8q1/REMaFO4bVJxtOMUCXAH11jCmA0
	 zhUmtZgfm3EbMAt2hkzK7uQ9UjwDPtoddUSMdNqMOQ2jyPrjiepvPagBcLopL4/Kbdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441865;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tt8UWNGdcbiboyLUx9rN2ABwxp8LpisqUv2j+o+zvEE=;
	b=EULLQIA4aTsa+H+lpj8Z+mVK+74hNIDBp2jEH/rzTuNTYMZA3K5roBXO//0UtSq0ouPy
	 rH0lNKbdgKitJ0RY+5w/BtG+/IqvL+QR5F2dyPC5QrXPIopxFvphbwLLrf7QLITC3lt1S
	 t4D3+YRtNMge9vUEau85xF/M/KtOcF00L+5+Kar5BbfJLaGkV/OlHbd4leoU8SHdmxAga
	 7rmjvUPX4ZqceXfeEuH1rbMBXFf/hd923bctF1/OIZ0O++SYQiXNZ2suhkl0zy+DIoBfU
	 pLY+HjkgZguVTKv0qv7kuQy3h+koGvlmdk1UZmy/TO7GzIyyLJcB/KQHexapZYllrXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb+KUZom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A060606A331
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lb+KUZom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8B91F00A05;
	Thu, 12 Nov 2026 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441865;
	bh=tt8UWNGdcbiboyLUx9rN2ABwxp8LpisqUv2j+o+zvEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lb+KUZomtdlHJcqq6qqFMnW8wLnPirIReG95iKxBGraTdg8R74fBSzmu4aGi450/X
	 AgM5T3AW6kNuF7pzguqkiK7ybrgj21MCntwxsU6hEWXMig2Hi8xv9Q8rA46tZ5c0iq
	 2kTKmgUcW8jSMpgwrC1x6N+McJyZD9gDDNbgyD0GejFM87il8P/jo1zVSrd7r6nzYs
	 Ew5ilTnMeb6KxWfWDbSAiK20Y1S8MMOe7Pwfv0Rk0pIE/SLGipKF6ndU51sCLsxq/H
	 tWt2p2eIrkklLLxTVfDLlGgDcrqgTSdVr7PoFhHhJ0YSvyTrWXt0wBUkJV6dqAUXBf
	 cZ+1+/XwcrBQg==
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
Subject: [PATCH 5.15.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 19:04:22 -0500
Message-ID: <20261112000410.920683-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202005-failed-5.15-7b6f2e3c29fb@kernel.org>
References: <20261109202005-failed-5.15-7b6f2e3c29fb@kernel.org>
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
[ sashal: adjusted context for older IRQ cleanup that leaves the IRQ number unchanged after unbinding instead of resetting it to -1 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index d07377e5a62b7..49efcd8f8fe55 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -312,12 +312,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
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

