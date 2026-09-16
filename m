Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FC94EA36F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602173; cv=none; b=Fok3e39IGIzl7vFrV8B5z//RclrOktvnzhYiTNtfpAACveGfoPtT1OD1PBOOY9k4BjG2jUhqM60X7keQZGTcHkR2McbCWOUpdOJCF30jU6kuQ1yVisg/wp+/qHn9fwk7rohQ9v/vVWHvqXb55DLcaEt2RCVVQD588DXIvP7Z93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602173; c=relaxed/simple;
	bh=Ax2UK5KLUGIkM7f2vY8mZZlvNttnolH3/KfiiZQpOqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV+ryvWDEuUeLje7RckihQklmcDVL1jKk7kv38dWxhSzO/udbumeaX3Pk2R+0y8BS58yZ/Lwi3FLc6kwKKwnXHW4aPw96XKDpREypUyAq9QG7ZIfUVhPrwVoT95Xox1vSYb6QHD9gaHd0J1pWXVYZ5JoWUBFFOzXVD7umWxpaEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M21O1ULf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M21O1ULf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DC31F000FF;
	Wed, 16 Sep 2026 23:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602171;
	bh=GQNgrUkMr3T5V3zwtLH/Or8S5+qqkT77zxM1QAHqFI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M21O1ULf3YQfu796pjtIX/3A62ZBBfmDh5EeIF9aI71pymiBtEOBPqacp6Bi689tH
	 WEfFKjIADLcm0LUNXmqq59ggm+qN1XV8Bk1SxvFiSAjj6wX56yYpzjW/EJS2/JnEzC
	 NAY5AQG1JO92pSInqLWGxqjdSEvWKUFBXXpaEp2i+5TIyg5rvP0J6lgs+ezZBe2l9W
	 GnvaL4lBQrTgBeDWA1BdD0TeEkOMm6kgbmtIeUkbXMX3VJobtyq2tX4MIi11w+OHfO
	 ClG1IOugOYHsA1Zewac1DJa4ugfBDmP+dqq4kzjgego3bdhtzyPUPX0TngGuZyV9WT
	 3hB4UjQ2rPtow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sahil Chandna <sahilchandna@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: mana: Reserve extra CQ slot for the fence completion CQE
Date: Wed, 16 Sep 2026 19:42:49 -0400
Message-ID: <20260916234249.3300330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091623-upstairs-protrude-105f@gregkh>
References: <2026091623-upstairs-protrude-105f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sahil Chandna <sahilchandna@linux.microsoft.com>

[ Upstream commit 80dd7e754b3aa9637a0758ad93fa209f9650ec48 ]

The RX completion queue is sized to hold exactly one CQE per posted RX WQE.
MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
the packet CQEs. The current sizing reserves no extra slot for it and in
rare cases, CQ has no guaranteed slot for the fence CQE when it is full of
packet CQEs. This can lead to dropping the fence completion while the
driver waits holding RTNL lock throughout the timeout duration.
Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory()
requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
the reservation pushes cq_size past a power-of-two, so round up the CQ size
in mana_create_rxq().

Cc: stable@vger.kernel.org
Fixes: 6cc74443a773 ("net: mana: Add RX fencing")
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Link: https://patch.msgid.link/20260901121837.3503240-1-sahilchandna@linux.microsoft.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Replaced MANA_PAGE_ALIGN() with PAGE_ALIGN() to match the older tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 4afcb202e3509..2d1e5b83a0769 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1662,6 +1662,10 @@ static int mana_alloc_rx_wqe(struct mana_port_context *apc,
 		*cq_size += COMP_ENTRY_SIZE;
 	}
 
+	/* Reserve an extra slot for Fence completion
+	 * event (CQE_RX_OBJECT_FENCE) in case RX CQ is full.
+	 */
+	*cq_size += COMP_ENTRY_SIZE;
 	return 0;
 }
 
@@ -1715,7 +1719,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 		goto out;
 
 	rq_size = PAGE_ALIGN(rq_size);
-	cq_size = PAGE_ALIGN(cq_size);
+	cq_size = PAGE_ALIGN(roundup_pow_of_two(cq_size));
 
 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
-- 
2.53.0

