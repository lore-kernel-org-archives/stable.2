Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217D92AD00
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786451711; cv=none; b=H38tDAbmoTSZ0URxQ2EO6ZgkjY6d1HDeEQYC88ihkSYubV1Cq3gi2Cnrx395r62s4S5LC7d0yBsa/h0E4kPsEJLEEIalUUMBfisYDrLUze/EynZrXG1Qca8wm4jnch0FKha2P5B7nW3+h6j/PWysomWBIN7zXKfIkRdIZoCIRFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786451711; c=relaxed/simple;
	bh=4KQmN9dh3XZ6NrqbQ2mvbbJmOHIXsLSvuwv/Gw0gmd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvgkhSN7oCYDhxivOYUOQ3PVJdNiVQ1XDRGkslUFFX9JmC8Yk/kYRpQ4mMw7rtjYFGjL6N4BKEuAb4jcfwhXr5UscjIHbtQRGpCYhvzmeHJNzOvd/UDAitIcJlwf19OgPE8Sr/TdW7la/waOVYGBJxMRd8Qf4U2T0sQ2U3sDDgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YibjupYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YibjupYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01CE91F000E9;
	Tue, 11 Aug 2026 12:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786451709;
	bh=CHhr+2ZiQ7qbgv3E2LKNN/KoToznF4hGRe+rAWWu358=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YibjupYInIm8plANIulcUm3ALxP6OHKP9PO1JUnO4YvjIhBVbfcCSO+qDESMCo+Mi
	 FZhDgWAwtjjduHe8pOewnUvwDSfElJGO5C6DCOEJ/9HraFZG512GAyz9yTd4/ULeqb
	 R8/dYOdhpxIl2eOkhwtYILLm+/S/cBx/POJ9HOZ3ufSv2/Vo7hd3ZHMZ3KoXOyohZ1
	 NiVlqFRjdZOOQ7wjBsWEOIV8kV7R68DGFxn7maVH3c3fJGLaslk0e8ynT0Ah7DS07G
	 EGzBVXANSLqogWn+l3tSvWL5wXeDxuU7zCWb0za1XbQXyln0Hgy4+Y9GMIjh6u9q9q
	 Kmr2b8qweFxMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] igc: remove napi_synchronize() in igc_down()
Date: Tue, 11 Aug 2026 08:35:07 -0400
Message-ID: <20260811123507.2400685-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080521-trapping-implosion-5850@gregkh>
References: <2026080521-trapping-implosion-5850@gregkh>
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
index 8f8312a250c83..f2700c3e60992 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5034,7 +5034,6 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
-- 
2.53.0

