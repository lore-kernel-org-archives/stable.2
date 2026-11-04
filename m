Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793836281;
	b=C6mnR3GEpENTZXzf5JVNuOzielJPXDiF8tbottGWNtaTD2ogeNIviw7sqvDXULmq7Dnn
	 bai3vII3HCSE0JZi+uExLLwX41mPSuGEiG3Uh0cy2Hirr940H6y2EcvUiihfTCNvHSnJt
	 Ns0EuvkyBmlYYMKNHrwPxmIWi6iRS3jZ8kXVlPfxi+7+Q76lvCRsj1XAnqswMhfufdDHw
	 Ct8llqbZ5iUMinarONTEcpC1G6UbSdVZ7va1rcCFa3Mgl2uh0lBnt+Syl4y7CCfsAOBQe
	 xXw1sgsJgvAo7Z1rR+sbdC0/kZkxKj79yhYnYkgTqXLTdiZGBCKUNDaoaWRlYrBhmbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793836281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=By49OjL5Kc6sEndYRi/FBlyKkbEPbOohPjlM3mSw1j4=;
	b=v72YbxWuUe06qorbJYH5sNVX8bBuInEb2YeTQw6iVpG3ga+UGx/Eo9mrFThxBHGT4o10
	 ZhZ9peru6Gih1Dh6w4DXO/jetf1T4qmzP/3tsYdeT+pq0PasBPqbA6Ff22uyGhjWeUctG
	 lf1927PUYpEQ415Y0fhoL91RIN/yqjfCVq/F6zfjX69ui/ztOlCXvPmbCFaG29s+QpDY4
	 yigxSE0vjI1zuf2b1p9aryNPqkd5YA2DVlfgRJNnO9TeMBM/OQdVGiKUOl0SaG3F2pzNX
	 rknMHizG8dvP+m6XEtkJwXWq0IpBNAPQ71jnZod+EOMYmIWpJBHsRrRztN/xGaawIQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh0PtVFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC09606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gh0PtVFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FE61F0093A;
	Wed,  4 Nov 2026 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793836280;
	bh=By49OjL5Kc6sEndYRi/FBlyKkbEPbOohPjlM3mSw1j4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gh0PtVFZChPfW7pTVQuLhfMqMDJBuUi2SrzY9Ah+bYQtYZvdTxUezYRd8VhgYIyvS
	 JsUUgAMcMGWo1twD3z2+H+4dx0TBZdYya3pENWS4yFR4OO36l28AVsotQrWjTBRCw2
	 yxd/L0P9HKmLZVH/H8VzLdIeoIhpM+WL0gpGFIHfMn/7uNR/j68GSjnFw/CxBBwK25
	 6WcXM2VrXbVvtE6yCfm7i7DODZr/x0OUVxnCk+0C2BfOD65J7aXVXJSnMSCimKjq5C
	 gHC1Ii4KuO6nFKPO56IIgjJMFzIzCkLbMiY1tid5rGdwmdEneGauk44v2YqxS84I6H
	 xwrnS/Y70Wzhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yuchao Zhang <ndaugoing@gmail.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger@xenproject.org>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xen-blkfront: unbind irq before tearing down ring and shadow requests
Date: Wed,  4 Nov 2026 18:51:18 -0500
Message-ID: <20261104235104.933465-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110402-division-regulate-7540@gregkh>
References: <2026110402-division-regulate-7540@gregkh>
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

From: Yuchao Zhang <ndaugoing@gmail.com>

[ Upstream commit f3e27b7955727a4d7c0e9264a2a209fbba788bdc ]

In blkif_free_ring(), the driver tears down the ring's persistent grants,
shadow request arrays, and shared ring structure (xenbus_teardown_ring),
and only calls unbind_from_irqhandler() at the very end.

While blkif_free_ring() is freeing persistent grants and clearing the
shadow array, the event channel interrupt (blkif_interrupt) is still
registered and active.  If an interrupt arrives from the backend during
this teardown window, blkif_interrupt() reads rinfo->ring.sring and,
via blkif_completion(), accesses rinfo->shadow[id].grants_used and
rinfo->shadow[id].sg.  blkif_free_ring() tears these structures down
without holding rinfo->ring_lock, and the handler only checks
info->connected at entry, so this is a real race resulting in a
use-after-free or NULL pointer dereference.

Fix this by moving unbind_from_irqhandler() to the beginning of
blkif_free_ring().  Calling unbind_from_irqhandler() first frees the
IRQ and synchronizes with any in-flight interrupt handlers on other CPUs
before ring memory and shadow request structures are deallocated,
matching the teardown order in drivers/net/xen-netfront.c.

Fixes: 11659569f720 ("xen/blkfront: split per device io_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Yuchao Zhang <ndaugoing@gmail.com>
Acked-by: Roger Pau Monné <roger@xenproject.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <20260922072155.34625-1-ndaugoing@gmail.com>
[ sashal: Adjusted context to preserve direct grant and memory cleanup where upstream uses xenbus_teardown_ring(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/xen-blkfront.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 831747ba8113c..02dc4a67ac82f 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1215,6 +1215,14 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	struct blkfront_info *info = rinfo->dev_info;
 	int i, j, segs;
 
+	/*
+	 * Interrupt teardown must be done ahead of freeing queue-related
+	 * data, otherwise the interrupt handler can race with the cleanup.
+	 */
+	if (rinfo->irq)
+		unbind_from_irqhandler(rinfo->irq, rinfo);
+	rinfo->evtchn = rinfo->irq = 0;
+
 	/*
 	 * Remove indirect pages, this only happens when using indirect
 	 * descriptors but not persistent grants
@@ -1304,10 +1312,6 @@ static void blkif_free_ring(struct blkfront_ring_info *rinfo)
 	free_pages_exact(rinfo->ring.sring,
 			 info->nr_ring_pages * XEN_PAGE_SIZE);
 	rinfo->ring.sring = NULL;
-
-	if (rinfo->irq)
-		unbind_from_irqhandler(rinfo->irq, rinfo);
-	rinfo->evtchn = rinfo->irq = 0;
 }
 
 static void blkif_free(struct blkfront_info *info, int suspend)
-- 
2.53.0

