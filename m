Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E4263F5D
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786452410; cv=none; b=S2R/2GhB3R9ZfwFVADQxLpr7hKhENJLYR2KPPyNUzdEtmu47N2+TWejvopHzeryDDJC456KIogVgNZxuwJzsGX31C/L4C0e0NdaRKkWwaM9oh3oUdCxQP7dUEPwqAOPq1nESO/2erdLmGPjXWGaCQ7ILPk0rlXCZkzngw6GP+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786452410; c=relaxed/simple;
	bh=PDkos3SA8sJ5/Brl54LFfM05fOwOBR8cLZNSUJlv7BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhN5w7jg7ro/evEh1d2v5bXDxVyNxR7Zi75Frky5H4bRg3NC8SXrJKn0Lhb90wYUbQh1ZmfsaAYaQwwZLLsurmXxHvzVr2cXX7rw5HTh9nk2uVeUEenE98epXoEiOe8tWkW6ywzcBLXsdzDh799EOxhzc0WnzGmrNb5J7cGHkfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ecr7pu+g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ecr7pu+g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7F01F000E9;
	Tue, 11 Aug 2026 12:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786452408;
	bh=zcrwNZu5Fm/3TDGk15aB2BTdpEK2pkyNqgiNFnIaijE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ecr7pu+gieBSRL7aglrVmd+E/Hh1Z7W2DVkyNaiR1WnSdzWgAplWZ3zzi3RfekDkb
	 nKn1L7aU7YWO47pvEXoRz17gzSWAc8SSRwRGqZ93/65bxseoz+7jaMKqwszI7iK9RV
	 TYQZraIUDHQNk0Bxdxn8O5obAii3mIfZg9sNLnWpXimA1+hst7TLWQhwHwtYRyZvgT
	 1HWtq95ehF7zbgxByDr0KxJFiy+RdY9WtSYqv/cHi2bfMQweRph1hG77rqGPIrEAXG
	 w08DEc5gCT+wzEAJnW0tFsUsiOAxi1LnmEzu48NCHgrIQX1WanJehFNZ7KFGfKjWTw
	 AWqw0wPi9Zy6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] igc: remove napi_synchronize() in igc_down()
Date: Tue, 11 Aug 2026 08:46:45 -0400
Message-ID: <20260811124645.2448102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080522-spinster-tricking-40ab@gregkh>
References: <2026080522-spinster-tricking-40ab@gregkh>
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
index d2825170c1e1d..f70fbd1d00a34 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -4980,7 +4980,6 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
-- 
2.53.0

