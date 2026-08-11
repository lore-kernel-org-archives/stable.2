Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0827443AA3
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450525; cv=none; b=mqxlrqUEgqKDveM0yTN0ji9j+BdDrif29VDZk7/73BK7dGkZXvptwgmc4MH0a+dUfJPL/+EobO3SmCdAwqcmUC0rULwtrvx6ey/Dxd2dWRJlVoGXOAWKIx7tcZrInn57JFby8UE4dqbaJCF6fswztZ8Afi0OplLt3eU7aSbQ13c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450525; c=relaxed/simple;
	bh=sExZ8cJu+BTg9WZxZkyHh1+vAMN1L+gz7ohdR1KFW2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec92hMPZUpJSp/LlvXhbdAg7PBV+RKwGh0In9yEyr0+jEHm75XLISXMTRrsmXACBYFRvGfHsM+mn3BFUMEbrRTgaKZ87D2ETboGvgYBvdjoHmxYCxhL6dpf1NjvOr5GDc6VmlPKFwaH7HfuXI7EPw4nFn9mqpP8f+ypaHZGmIeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRldR3W6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRldR3W6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB51F000E9;
	Tue, 11 Aug 2026 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786450523;
	bh=rqI/dH7UAwTG6a0uDTRvbMJ6VzaWsEXzJwuxLwvZ+zE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PRldR3W65xKqIVyyRQqKCDVOyNyhSGL67hrS7fyqSgRwtDIXsz+qpKNJ3nmt0gBPu
	 wSOX2d0jPJ0G9YUwpVhb3toIVFFFMIo5Kxdx71GFCTlFEnWLEYuGQ3ZW6tBWco1uww
	 /PrDckFzx+Q0JUCKnwJQ1P8XMNz01SMDJEYO8vCEds7BlfkFw6wdpMARIzv4G0Op9J
	 WzTRdAykwG6WRTQH456GT8zR78kKRdPVbjL2yV4hA8IFCwMWCkRiS/E1ZPvPcKbDbI
	 Wo8rhFGLS5zQwVWuL0i+KYLirRoc99EDrNczyx/RMslwOoqK0YduuHZgKntXJaGe6f
	 wz6bLgXCuzbbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Dima Ruinskiy <dima.ruinskiy@intel.com>,
	Moriya Kadosh <moriyax.kadosh@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] igc: remove napi_synchronize() in igc_down()
Date: Tue, 11 Aug 2026 08:15:19 -0400
Message-ID: <20260811121519.2373544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080521-detention-unleaded-97b7@gregkh>
References: <2026080521-detention-unleaded-97b7@gregkh>
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
index 13c41facfc976..6fdf009df836d 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5085,7 +5085,6 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
 			napi_disable(&adapter->q_vector[i]->napi);
 		}
 	}
-- 
2.53.0

