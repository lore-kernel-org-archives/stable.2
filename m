Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441119;
	b=JbTSl0VnINe+w2vx42DA5TeA9tbsZv7fv9jLMG3CnwIMrc0D9zJXHdkoN1ip8KY6d670
	 efeAMqNKPRD9hutQg9pplGCoK93couxSTCvGOklm93n7creh4Cpr6XKJYiMI6eE4bRG2a
	 xUKX4nU1a4770WOsx/nO0pEwLOg7VDXT7kX4Y11nHhV/QiuutRKFM19sE5Tp637A97zgl
	 +i2y/ASWwV/mPnZrWC/T5Z1YSHI2wzMav+lwmATMYwpeY4vuLBBMRiccbDzBEfOTdKCQr
	 W9N8Uwvs0fDl9f4m0ywfBwADBWa1n+XPplGu7349K4/ZVlgElKarAmeAXUVe17AQVrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1g63jGcui2N30M3g0aNdaUb/c+n8cSE0eu9Xrzc3d3s=;
	b=BXfV1POjtjCgNDw6PEvzDH+syiy+ByXh/iqOZB+WXi4P4Rnl3BbeD+R2IdcNpRvgHUaa
	 grLxZs+MzzcGVIMiQ0bMyF8k6zq7GMDQ84Kk/C2NfEmHDH/+TnLVlBp+q4FXaAqctPEbh
	 M830kEG9k1dTYoyPUTmUhVYFjVQV65kKNA1JuiUrQDc9eMEtfgeEWlDt9erYOSdVnk4ZM
	 ttgz2qfcewuJwrkB2y/5ikOIMcSX7CaCvEvd/aAy9hMNFlhjfCeBsgPEFM+QrXDBbyhl+
	 Q56p1PtPzCnbyXYNCwIEr9Oa7AEqqy00khg3FJ5Hh7a7n4M3q8Tv+LEkxdX6cF+xzlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kekz/uV1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3F606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kekz/uV1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAF01F00A05;
	Wed, 11 Nov 2026 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441119;
	bh=1g63jGcui2N30M3g0aNdaUb/c+n8cSE0eu9Xrzc3d3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kekz/uV1CJBWsQm1K0gJS/I1rdBs1QQqT5+8Un5AKe0zpyd4hsJZH4WqvSOtic6kP
	 qATrvfRdgQh7ZUMnujVsadQHJpaXjrEcI3GCq7v92ZYDcuDbgc8lGBFibTz2XyqCC7
	 hfsg2W8MtuPe5dMp0O7qXpr08xEGmhtK5aJVoMejKZrm8zzkJYMHQjJdeZjbljguZc
	 7gcGPNm3XF3Q6+Gulaz6Kkox21YgD1N5nU7avQ72pS986iiMV0aw1B065ESYN03yw3
	 +ECkkZVrJ8XcVfALDM3J/+yyQdEomqLcUM926SFZ9bd/0StXYaCxj+VaaNN3FMTnHo
	 ROi1SROQL5OFQ==
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
Subject: [PATCH 6.1.y] 9p/xen: drain response work after unbinding IRQ
Date: Wed, 11 Nov 2026 18:51:57 -0500
Message-ID: <20261111235150.874631-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201458-failed-6.1-7b6f2e3c29fb@kernel.org>
References: <20261109201458-failed-6.1-7b6f2e3c29fb@kernel.org>
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
index 48a412f6242d1..00448c1896400 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -287,12 +287,12 @@ static void xen_9pfs_front_free(struct xen_9pfs_front_priv *priv)
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

