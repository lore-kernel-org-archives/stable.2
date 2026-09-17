Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527941F09AD
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613452; cv=none; b=mKru/a1N6/lyzHUIOn6SSmchVlaQju/KXQtpQiB+SgporuCF7RAWnx055z9N+ldiaDvCSaE+H1MK6AwZj3qnt0OyBK2QVZVOw1xdeRnKXFvcUSJzp1dpgq12WfUYOkkUvmOoRwcFnu/ZSMdYthhOPktpnVrVtHYD8Qloh9YnpeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613452; c=relaxed/simple;
	bh=E7ZKOHiN879MxbFWl9YjUR5poSpWm+FiiCq8YGLIs1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Re9OHXAxPm/EQg4A4hqNSIEwpic7TStiY/xKhuHEtBnlWRJ76zb4LXF6odUsVXRBnkOWsqUPHNMnV79LOuVd4ge04MHc/RvdtXZR0VQHC2pVDabqPO7YeA8tsKBFZOXU7cBGt0hN7fRnRs2iDJ1UBwjS+14NtCzEojvsvmXiNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFCJn94y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFCJn94y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25CC1F008A5;
	Thu, 17 Sep 2026 02:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613428;
	bh=WS7+SyJbt5RwkJlocoL/A39A/NRX6gan8pNEurWAF48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFCJn94y5Yr8mHD0MBgGxbS3xCsHFEquA2fpZ0/U88DXJ44bS9x03XMcbDQ8A9wmh
	 z6K5ZKCsZ7u37KDvFKulRG5KVU2V9uMieMk/Ugfo4kOqFWHTw4uIHNz2ky3lFA9v+4
	 Kvv7xoW84e0YoLXrvtg5Hbw1btMyL3n0HVJjI8GQraVpCtfrlVKb8f8U5/lZsrMadG
	 bqFPLvqPzxvZpBvjauOtXPGXa5N/tOO6t4Oy3tQR8PwJBlHp47PrFsLqpeub1I4xkJ
	 kObkcZG65Nc8AyYgVUqADwN1VYH6PL5ftCDCXosMujlocfciLREnbLP/Q+b5ywgbdL
	 m1RpQsXvmxmjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Chen <will.chen.tty@gmail.com>,
	Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] bnxt: fix memory leak in bnxt_queue_mem_alloc error cases
Date: Wed, 16 Sep 2026 22:50:23 -0400
Message-ID: <20260917025024.3917679-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025024.3917679-1-sashal@kernel.org>
References: <2026091604-recall-carnivore-5fe5@gregkh>
 <20260917025024.3917679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Will Chen <will.chen.tty@gmail.com>

[ Upstream commit d1000fd7995e51deec872d154e0a40d82f7a539f ]

There is a small memory leak in bnxt_queue_mem_alloc:
when bnxt_alloc_rx_agg_bmap() succeeds
but bnxt_alloc_one_tpa_info() later fails,
the rx_agg_bmap allocated by bnxt_alloc_rx_agg_bmap()
is not freed in the fallthrough cleanup cases.

Free the rx_agg_bmap in the err_free_rx_agg_ring case
and initialize clone->rx_agg_bmap = NULL earlier in the function
to allow for safe fallthrough.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Signed-off-by: Will Chen <will.chen.tty@gmail.com>
Reviewed-by: Joe Damato <joe@dama.to>
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
Link: https://patch.msgid.link/20260729220132.1256924-1-will.chen.tty@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Stable adaptation for 6.12:

The preceding per-queue buffer-size backport already initializes the
clone's rx_agg_bmap to NULL. Retain that initialization and apply the
missing bitmap cleanup to err_free_rx_agg_ring. This frees the clone's
bitmap when TPA allocation fails, while earlier allocation failures
can safely fall through with a NULL bitmap.

Keep the existing queue allocation interface and inherited RX page
size: this tree has neither qcfg nor need_head_pool. Leave the TPA
pointer resets to target commit 5ce7f36c334d. No functions are added.

Stable-dep-of: 5ce7f36c334d ("bnxt_en: Don't free the live ring's TPA state on queue restart failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1aa8c26bf71a1..8398d77211db7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15441,6 +15441,8 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
 	bnxt_free_ring(bp, &clone->rx_agg_ring_struct.ring_mem);
+	kfree(clone->rx_agg_bmap);
+	clone->rx_agg_bmap = NULL;
 err_free_rx_ring:
 	bnxt_free_ring(bp, &clone->rx_ring_struct.ring_mem);
 err_rxq_info_unreg:
-- 
2.53.0

