Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440880;
	b=uik6WIJt4bp8tMsw27P2+nEeY9knzbIfDng2nE08Nf7bvZS4kV5LE4luV4m2gWUo8qoF
	 hcRtHHuXt1tWktT04SzsdcpqzrYb/+FvSmJCs310soSdLX51HDasE/iLzqsJn8e3vSQHh
	 81iTdcphm8op7v8V6bnbOGdw8jHz7VEFBAXEKvHzN7UZ4ByPWMgDuMtYdazxeQ2IMu5PZ
	 ZKxwYAAlHDfwhRECCyaadWyc08DiDvYA76aR9fpEUvsA6MXKVMkP3ntrrVT6UxFopfHup
	 A9ryNFBLR3p8ySDyR5pIrn4dk8zpp2t/P97Nqd0OnF6sGsu6t6ubEWDzwEz4wuQYNQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h+N9Abt0w/0DlLriHZkVT17Jo0tdw/y6Vn6fU1C3O1s=;
	b=riFZSpplQq3n7Iqvc9C9HDOQ0bPT95HeSZYbfZqrfAPcQzZfO7HBW7kqecvEYPniGN2T
	 R4A1hecXi1YI7Zg84FbgiVkBZK1VBYJAgmdC+HzIOHpNkOkLEZnmDy7PUea0g1PRZwjrr
	 Uzs7bImab1whm1+LyquJ/9zNHgl5ZIFnNePNlwKXnVjc74b1VZJUTv/k7GLjN5p7Aa43j
	 ZiwTHYE2KjqNsSsg5fIrqdXyeAWV58kYKIGT+kPQpjRop5D5QXyAPLFsvK/J2mKxADb6G
	 h34buWAvKIFq4KCwxXymgQMU4SysYrpKGMBjKTzYb6oGaBiHLADjlLdfy8hs/vZ4jJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co8p4ZIi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DA4606A336
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=co8p4ZIi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EF71F00A05;
	Wed, 11 Nov 2026 23:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794440880;
	bh=h+N9Abt0w/0DlLriHZkVT17Jo0tdw/y6Vn6fU1C3O1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=co8p4ZIiqao/0wh5dvwZ4esxMZ1TX9PqK3i+2g+k1lnbvruS0dnQZHSrjZQEbCOa2
	 AhNVcVwkzXWApeRMqLgZFEqTz9WuUDFHmKOtKp92kSYb+3GVq2MfM43h9mTkUmnj+B
	 rWcMUglrWeYnZpv3t9WpVxG+CcL9acc2TXtzPDyp4aWhjM2WGs4BBBPGOqU38LdgOY
	 13l+FRhS3m/Om7DfMCg1fu7pSRFhvwf9NsiPFM25ddXM6nJaAOTEC/X8erxzdECjLh
	 LJcLDhxmuNZZJxRe5act57QVzKx+FNbZYt5Or6ats1Y99snsKMaMKOvZziWyjX9DIu
	 ShOODEuObyqtQ==
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
Subject: [PATCH 6.6.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 18:47:58 -0500
Message-ID: <20261111234750.833665-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201020-failed-6.6-7b6f2e3c29fb@kernel.org>
References: <20261109201020-failed-6.6-7b6f2e3c29fb@kernel.org>
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
index ee5bbdf7dec25..fbf8e6598f273 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -289,12 +289,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
 		for (i = 0; i < priv->num_rings; i++) {
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

