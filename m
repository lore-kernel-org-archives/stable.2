Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440700;
	b=sIDgnDi7Lvzkcbuh1yFnEASxLphSNDc1hIJUQG8Dvp4mKxfjquSdL8vu8KQbPs2+e4T8
	 /l5qjpCmXNI7aQTVDXw/DPS9ZEu/e3H661aP2gxYg4hbxaS6n3iUbVhV/rbtvHnypQhby
	 UlmuLvpynzdrU//xzT/oAgt//vAEfoEWHcUtaqg/SNg2Hjg0KueIhzbyvptqq7VECea5i
	 APa0LLEPpfcFSdsY4OhRISh8pl6+0wzquZ4zF9XZlG+cL1pPeD7GClWfrWH1nMXYjlN3L
	 eQwobhBfPGKxPy4eTW5liHTsMb4L+RcE8q2VP/BHJ1+adeyFQbheq0UecIqoD1EDuBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440700;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HQ27pWcK+1BV/aH3qN+TbqJBO+RzkCvXh9nk2rz6CuU=;
	b=dK2DzNdLTcNXyGVlHonqvUZz8cTKfNdPGTuwWzX5/cGXfjmAufkVLQLK0DC4SLp+BhXU
	 3g7N6DQ99jbXfn8Yy4WkNykTVqynw3ahhuX5ga6YOWF/lN41UCOG0p2KEX2zjcAsPotho
	 gi0DLRNIW96o8HzvG+nxEZF8P8bfAJUNhbtrnfs7WRPSX+h+3UPPpCigmkECuTLvAck93
	 Q4twrFi1sB7kmVTGb9wzA42WIMbz2NNcouVgDVn3kITGZtN6FZfu3y61XGMvE/31Q3hlO
	 nYTHdSciQc6O8Odzpeae9V/rwUbZjoGkE5pQKJ0jhvanJBtlsS8GLlayGDjlRGWsWhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vptd2Hu9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D591606B5F7
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vptd2Hu9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21D4E1F00A06;
	Wed, 11 Nov 2026 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440700;
	bh=HQ27pWcK+1BV/aH3qN+TbqJBO+RzkCvXh9nk2rz6CuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vptd2Hu9/GGLLBe27Gq+ttGHyAArG4f4mGYyXJxVSmVLruij6b4zRex93jc5Q1XL9
	 U0PblDiBYC4EnUFns9B4TqV/rD1kjoAHJAVE8ckaVhSwsjktdG3EMucZTGsjJu7O0y
	 BxFggAtddZo6Wii/Yk54fD/q9abbmCbHkXkscORjYTuGtTDOk1zRc10ZA9TzbDCto1
	 dyZK4Ec/oS4EHURU/aXoLQVdWuqHMgbVQ1Jr5NN1f2+Xhj0v1LaUEEUDojKZOZUG8D
	 FfuY2iX7WK4ora9mzizyvfYnKUCs0s8zPaLeu4L/+/zISfkKaXrN0YQBgbqE2lPlpA
	 1hy7kh5XN/hgQ==
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
Subject: [PATCH 6.12.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 18:44:57 -0500
Message-ID: <20261111234452.768495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200601-failed-6.12-7b6f2e3c29fb@kernel.org>
References: <20261109200601-failed-6.12-7b6f2e3c29fb@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/9p/trans_xen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index 67f464acf6171..ef9bac5f4a24a 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -288,12 +288,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		for (i = 0; i < XEN_9PFS_NUM_RINGS; i++) {
 			struct xen_9pfs_dataring *ring = &priv->rings[i];
 
-			cancel_work_sync(&ring->work);
-
 			if (!priv->rings[i].intf)
 				break;
 			if (priv->rings[i].irq > 0)
 				unbind_from_irqhandler(priv->rings[i].irq, ring);
+			cancel_work_sync(&ring->work);
+
 			if (priv->rings[i].data.in) {
 				for (j = 0;
 				     j < (1 << priv->rings[i].intf->ring_order);
-- 
2.53.0

