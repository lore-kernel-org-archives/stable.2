Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440236;
	b=eifaa2NfFns/SUWK4SYsKAXZG6diudtxxoNBr/ISvjYVNRvRrGgKD0UpdX/FcdCMpT76
	 Yd0f7wlJEJPp4xE6B96jq8hnN4untQt1PeUFAidKWIMOaHVeJokY7RxNqx52idPz86vw7
	 NjSI5aUKuJ7MTnexHlXwE0S0QHEvhZA+vL/vM5obtsGyGbr4CaOUEZTgTEnO1ZfPJgeOa
	 UMgR//wMbmxi5VnCc0xInhTfLt/pZSjBoEOetyCUALhNAyl42tIKNb1paZU9UUAzPMYXt
	 P2XgPI5RM3qDakFhebcG88vvdkaUOdR/jn0Kmg2zPTZUKHOpl36PHwNQERGWuDiV3Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HQ27pWcK+1BV/aH3qN+TbqJBO+RzkCvXh9nk2rz6CuU=;
	b=GOsVD7sqsr7QdBvkO+eKQBIqNArm+3cgYRKDGqW2v+GdLx+FecYnVu2tohFwoH3OTGt0
	 azy7xQdF0UUwAwQ2FWOHf3+984A0JlBF13/oEk+wXdX7LAVWzaJReqhNjJoeUcyb309UI
	 CSw5KGQ4ZxgPjpGGLjJVl70YmzXlX1XS936DAmXd2yY7vz1/oeYv+LcmauIX5AiaJquXp
	 ZJKuuASkSumIk+atae6QcHSnWsA0foEuIfRRVrvoZB7hX1gTxHSj3smNFnYjsbguf4+aJ
	 ukdMDYZ4uezOWQG+K51+3z/E8GgmR7h28QG55oW9oAJ4uOHnVLBWLamJrkJI0CLmycA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXyA23HB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD2606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mXyA23HB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46FE1F00A05;
	Wed, 11 Nov 2026 23:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440235;
	bh=HQ27pWcK+1BV/aH3qN+TbqJBO+RzkCvXh9nk2rz6CuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXyA23HBIit4C7892vtco064iFGjV5PVrzYPUl+rzFpGhCTeUDzJq4nk/Ce1/iB2e
	 QvSNB6+/YiRGw9jEH+ZoiF3wUv1gXaKPfPeJendLW41vN7K0zWvjd/GOHveNofEzXr
	 LN+bTjRbgyIu/S3NY3yP5v2kg5GPyKHZ6LyzfyNC+7CAGDEYUElBS6gr1b74sCpoNj
	 5cRfNHFSS0nhu/WYUJDhUIKJdTwpIJ5oLXNn9v22k7WUHNHCTP1RjgA2ZlGnH4uIoB
	 YEpKEHwA8pnpxmxkoiqnHamyHDj9On4eu4ZxMI/aABfhSAJHtFm7Dy3iJCepU9aYyF
	 JJ/iDE1PmiUtw==
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
Subject: [PATCH 6.18.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 18:37:13 -0500
Message-ID: <20261111233708.634026-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200210-failed-6.18-7b6f2e3c29fb@kernel.org>
References: <20261109200210-failed-6.18-7b6f2e3c29fb@kernel.org>
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

