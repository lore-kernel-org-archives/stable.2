Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D8314D1F;
	Tue, 22 Sep 2026 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068850; cv=none; b=ggYrZ4+SsE2vWQH3bMDgI0MCHv4yoGeWCS9F4XbLSupB/iwFeaVqPYhzrbwqMpsD4MZR2wZB4jqW6YLkssHLpxs309VbYC8jthmmdyJjr/y4uu+w0j1YC8yo3xGXNSfV5g8b780Y9pxZ+0dU+PE4BcnHC2HivcWGE/Lt6tp4VKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068850; c=relaxed/simple;
	bh=ufHQwVLWhbEqSDudZEAnnILdx9qDHelU/xGM0QyoWGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DgMYBhxNToQ/CEjrIpQPONODmSVIXzPdpjuKZp8RYNcAvhuvWP9cgx8GzcGOPhbfSR1wC6WCu7bJ1irMN2+9vEU260mIIUj/LKz8IpKdlX3USi705hKEuKmpd/JYsh9hSOCjg0ZUOFZp4Kl+jYg7SV/dxivfp3ZSTzpWTtlIUo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwGJuFnp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwGJuFnp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A111F000FF;
	Tue, 22 Sep 2026 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790068848;
	bh=dYkHamlC0XvL4sfwKvaCSqNhRE91tdB+Ax+AruYP6lc=;
	h=From:To:Cc:Subject:Date;
	b=HwGJuFnpjyM9k6k+oCT2JqJu2mw7v3tyJW/5e1pKdVs/V9X70gyZOPYq5y3GTp39n
	 S4/Qw3WWlzKsQfAPOw3QXTjD3pFAIBPXE+gn2KQl/yRwZsoUvNFciOPs8uPSoSYK4n
	 deQrdkoWqGaToY+umNDVjCV2d7UJxcbZrphE/3rwoahPReu1NZwzIMfNbgmS69Ka2a
	 muiBn+1ZOWoPPBisPEZ6M0oIkLQF5OEgnDCYBkdXnDmKx8mhFK4e3X5CB3VJ4pPt6u
	 4+JJAz550HW0OWoEl3xjfhr2hAfmx0xd3ZMhF32jFYVKoqHMMG59B5cKx6Za2vj7KP
	 0X0UADqXcecLA==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	stable@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup
Date: Tue, 22 Sep 2026 12:20:37 +0300
Message-ID: <20260922092037.224884-1-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>

lmdesc->nxla is the address of the next descriptor, so comparing it
against CRLA, which is the address of the current descriptor,
finds the descriptor before the active one, not the active one.
The residue loops below then summed one lmdesc too many on top of
that.

Compare each descriptor's own address to CRLA instead, and add tb
after advancing to the next lmdesc.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
Fixes: 172bfb57481c ("dmaengine: sh: rz-dmac: Add cyclic DMA support")
Cc: stable@vger.kernel.org
Suggested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ca76f1bb45c4..fdd7131e890a 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -937,7 +937,7 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
 	u32 residue = 0, i = 0;
 
-	while (lmdesc->nxla != crla) {
+	while (rz_dmac_lmdesc_addr(channel, lmdesc) != crla) {
 		lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
 		if (++i >= DMAC_NR_LMDESC)
 			return 0;
@@ -948,13 +948,13 @@ static u32 rz_dmac_calculate_residue_bytes_in_vd(struct rz_dmac_chan *channel,
 		u32 start_lmdesc_addr = rz_dmac_lmdesc_addr(channel, desc->start_lmdesc);
 
 		while (lmdesc->nxla != start_lmdesc_addr) {
-			residue += lmdesc->tb;
 			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue += lmdesc->tb;
 		}
 	} else {
 		while (lmdesc->chcfg & CHCFG_DEM) {
-			residue += lmdesc->tb;
 			lmdesc = rz_dmac_get_next_lmdesc(channel->lmdesc.base, lmdesc);
+			residue += lmdesc->tb;
 		}
 	}
 
-- 
2.43.0

