Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24CA32720C
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447039; cv=none; b=nT73YWdaBnFqMhZ4feIzlVIE9c3shkv6ozEncc0TdY8dBoVw0mWqptqnLe9Rm25tuRRyoFYZYlRkcoHlnBWqDcDmIssmyb+s+CK6QQoi1Qiu8cEf9SI0Xh/+wzKeTyhQDjNX/WlzUb97oq2DQUczSfAgiPkCjgzG0IYuDnYDosM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447039; c=relaxed/simple;
	bh=uPpDtgbGUrAFzCOWV+ZR/Agr0yif6zL12RY+jdjU39Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYjSZHpbAh8+llO1xIgJ1TbQPKIohoffcd3M+8tSQGXSmHMkCqgrzHLAuDSw1QH1Z1XS9QgvgCfOgaFtDfNGyU51szaN7GJJ6IT66EE0MXMSwAIeiNWUOARZ3SWjIgqMAv+8C/vgJFWaW4stEegZ/bHDDC4jGFUw3vLA2S/JklA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJ+U+DaH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJ+U+DaH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913621F000E9;
	Tue, 11 Aug 2026 11:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786447038;
	bh=SxR0ufxqVBoFIcjQ+55h8FhHci8lgAbtib/9DReChpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HJ+U+DaHivXqz2dWnnpxTlYCh9c4GSRI3haTI63TXvpjCQXf2/PmfOdtuYn95B05z
	 D9LiGdcK7Ai1nS7yzTNeLOd2TMLQeKvc50sZsdsSkxO8cX7YBuHsy9TGckbA6ClyLh
	 zBBVZki+IS2LPFrRNelqcPzYHh0hRvtez94qUIzU089h6PHFNVy04YBoabup/RunvJ
	 GdXVq5jkstXqp7QwLHhzkUP+wVMLWZt5ebZek/stKGQ4qWb014VUzefE69OqVbHdG1
	 oJrl18MBeaHdLm6LfL3w7aGi6XT9vjapXAejuG4Ssq4AaTMs/BVtfUt5aV9NEPeDLZ
	 6Tn6gYopCR2rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] igc: remove napi_synchronize() in igc_down()
Date: Tue, 11 Aug 2026 07:17:15 -0400
Message-ID: <20260811111715.2258680-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080521-shredder-gawk-b169@gregkh>
References: <2026080521-shredder-gawk-b169@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

[ Upstream commit 5ffab5b9589c50e4cfc0cf36ffd76c89422d4019 ]

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 6fcf4fd7ee194..0f9800022a424 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5199,7 +5199,6 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
-- 
2.53.0

