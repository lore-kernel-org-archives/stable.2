Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BA3542D4
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616162; cv=none; b=QtrgTOWacMPfGv/UBndMEL8gDZUoafKSwFyqe3oFTuwW4orCPk7x/OIgg4JtfoU13/Sr5/UhAq2YcCbJsgtNBHZ98Uvo8WveHL6hyOOGfy9TghZVMUijuYWaOuadoNsl30b3yjafIcFRHmHtSTBC56TB6aEKLUMf5ccfF2H23Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616162; c=relaxed/simple;
	bh=OQLRiiOr7QAvFIIM2BJvlaZE87Ga8sFPu6gQ8GIh9o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwafcZb6dZ9kYhI1ehv35baho09UzmteNC4WgnodxEIVGlm34s8wuk0tfSpThrJuGHjaQU6g+MJjp8ds5CRHO27x4oCsCZU7xJbZCzwirQfJfqOq44+A40lz/nZaEOLWBSgPe3MTQrKmI6Dt4Il9brZYH6Y5+vgbSiFfKDCVj3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASwTjm3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASwTjm3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53251F0089F;
	Thu, 17 Sep 2026 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616149;
	bh=74ibGZtS/uOSMN94MqRlU7CK5DAgwrtKa47VNgXHIxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ASwTjm3VRNDSqY5WiMjO6oYhCM8dWshp6p5NnKZGOqd2llpZQFBHyvxEYjhysffTj
	 jvCui7hF/kqFdJBkmgBTwsdIFFRhHGbVM/873yu8OFy5qJ5mX2zTffDydBjYLWToAn
	 dDrXMFChC74ozjjAP16TLj1jzAUXTInsh1GGNyK54C1nrBaxo27j2zXiIkgkfZg9OB
	 N2aC3KOsyx0yOTwcy4ctvh4LoH9jc938RAlo78K/kbizuXukPF3KY89LNl5zgJMmSu
	 X9KYLzSGZLSbgxjsMfHK0NRwxOx7Dh0u2WtaBjKBbsoVO66Edg/NX0Hbip0pSr150A
	 Vq86ZSdMk8r/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
Date: Wed, 16 Sep 2026 23:35:45 -0400
Message-ID: <20260917033545.4044963-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917033545.4044963-1-sashal@kernel.org>
References: <2026091648-flakily-icing-f492@gregkh>
 <20260917033545.4044963-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joe Damato <joe@dama.to>

[ Upstream commit 961e2a17c5e3559b3f8654d2daabdd25a42e770a ]

bnxt_rx_ring_reset() frees the ring buffers and then reallocates them,
ignoring the result.

bnxt_alloc_one_rx_ring() can fail in bnxt_alloc_one_tpa_info_data(), which
returns -ENOMEM on the first failed allocation and leaves the remaining
rxr->rx_tpa[] entries zeroed.

The error isn't propagated up, so the loop in bnxt_rx_ring_reset
continues and at the end the code re-enables TPA with partially
unallocated rx_tpa array.

This means that when the agg_id from hardware is mapped to a SW index in
rxr->rx_tpa[], an uninitialized slot can be chosen which would hand a
zero DMA address to the device.

Fix this by falling back to a global reset, which is what the existing
code already does when other functions fail, but unlike the other
failure cases this particular failure has to return because TPA can't
be re-enabled since the allocation failed.

Fixes: 8fbf58e17dce ("bnxt_en: Implement RX ring reset in response to buffer errors.")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260902015652.2421609-5-joe@dama.to
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1555f337e3021..1da3b434cc44a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -14336,7 +14336,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		rc = bnxt_alloc_one_rx_ring(bp, i);
+		if (rc) {
+			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
+				    rc);
+			bnxt_reset_task(bp, true);
+			bnxt_rtnl_unlock_sp(bp);
+			return;
+		}
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats->rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
-- 
2.53.0

