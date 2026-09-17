Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42543A48E3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613449; cv=none; b=lwrD3rltxVlBRGKXhjtnJy0fwAvrTLocdMkcqNylfPuKHukvmDdKZWxgwnCqpgk3vC7prNyhQ2NPoh2z2/WkpmbDnkMD2sjLpsgDqis5d0uqczv6sGT7wIDjZjFnQfbdM4FlS7RStFz+VdGYLHBcKPvKvbObFLJVZhYicIVd+Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613449; c=relaxed/simple;
	bh=1h9/9bVXssk4UtTe+s8vYOriVCcWEFiqsUcTTSDoN6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2rDyApTwk21isVsbTE2mBWgnQKs26HmNAAB/jRi3DeqVMm18Y9oEIass+p0JPrudDpq4wtAp9o+pJ7dQMU2hUllbUHYdFt6LxxUWGmtQlCXFkFWulp+Lqnljc9QFTtI/UO0ON10cPDE8Xf5cyUYtBXflwC0eEUj/Hl/4OSvh84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhjPUDzD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhjPUDzD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EEAF1F008A4;
	Thu, 17 Sep 2026 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613429;
	bh=qZKsAUevdcE8bVGP6wAzMmkJFgxH8uVRoA60HtA/t38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bhjPUDzD+H4NzSfwvmXOT21UdE1FUcwNbPVVzd2I7HTSaxzzm1M6rpJQl8D/cFN/u
	 mhcVsgVYczphwzGzKk7DM26tYo8RPaUKOXTnAiza3j/cUkErogZsE4mmErb7yE44GX
	 /Eml/WNH2DwUUoit7mH7QiERahzfS2Hph+dSdiLCWHO8LohLsGfv3PgnME/i7kD14O
	 oYFlMom8Z05fx0bclB03FZKy2nmuttvcLpeOGRm1xDWpgcxeXP2ScB0P4LwbnzExkt
	 iFKq6qvGLnvL1eyGT6lWSHr07QJ/YjdYZ9VN/k64q1HATm1FfNxU4wQDPz3/XMmvZ6
	 dihz5JlScPZhw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] bnxt_en: Don't free the live ring's TPA state on queue restart failure
Date: Wed, 16 Sep 2026 22:50:24 -0400
Message-ID: <20260917025024.3917679-4-sashal@kernel.org>
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

From: Joe Damato <joe@dama.to>

[ Upstream commit 5ce7f36c334d723954855ac769ede2fe0e8f89c8 ]

bnxt_queue_mem_alloc() shallow copies the live RX ring into the clone:

  memcpy(clone, rxr, sizeof(*rxr));

the code currently clears pointers that the clone owns (such as
rx_agg_bmap), but rx_tpa and rx_tpa_idx_map are left pointing at memory
of the live ring that was cloned.

If an allocation failure happens later and the err_free_tpa_info label
is taken, the live ring's memory can be freed while still in use.

Fix this by initializing the clone's pointers to NULL to prevent live
ring state from being freed inadvertently.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-3-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8398d77211db7..217c09c644ee3 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15389,6 +15389,8 @@ static int bnxt_queue_mem_alloc(struct net_device *dev, void *qmem, int idx)
 	clone->rx_sw_agg_prod = 0;
 	clone->rx_next_cons = 0;
 	clone->rx_agg_bmap = NULL;
+	clone->rx_tpa = NULL;
+	clone->rx_tpa_idx_map = NULL;
 
 	rc = bnxt_alloc_rx_page_pool(bp, clone, rxr->page_pool->p.nid);
 	if (rc)
-- 
2.53.0

