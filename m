Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94362C11E2;
	Thu, 23 Jul 2026 22:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784847397; cv=none; b=iCMtQtTIPOwugpQHsBDXI90rvpWHksDTH1oSWmMnBD+3G09grkJFkFcbwECcwch+jfRJL2PnfFhWLg8NP8vpqP8Te/rRmRRyOT3EDKGEK85azR71smIiTaT9pRmBOcDDNriAV/uIkUHZR4kUY5KPukeGyRSq//vmm+n57KzYygI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784847397; c=relaxed/simple;
	bh=LL0cZbUOCMPlgQr9fIP1NYVFCodvw/DKepAQBmi5m/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eU6+xmGslfrBxJkRZy2wql9mcf0D8pEvxk89NeeohF9oBVYMr8r4TMeIkc6xHGOPi3R6gARwdQ1n3g05EJK5GFfAvElNVZztxqHio4bLGSKNrCw/LXFe0xbn5XHVoW07kBDdB5gt2YtT3Aqd4Oq2OGVyEASUdBrZhPKhrtX4He8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQPYk+bO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQPYk+bO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DAB6C2BCB8;
	Thu, 23 Jul 2026 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784847397;
	bh=LL0cZbUOCMPlgQr9fIP1NYVFCodvw/DKepAQBmi5m/A=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=RQPYk+bO3KAd6Mky0pYxLNHvkhl6bDRu3133FqK9hpNPz4+/bvtC+JckWYVKWIIw4
	 Vcbm8gCW7t7dOr7FO54H/9KGHodlkrHvHsPlS1PzyXuvgQtmSGeEXfc3h+1YTHkEfx
	 0PGhtMXbh2LzP/mw3jcoKnJj8yS8b1eoYeji9IGNIK3OP/7G/LPfXfSxHnYMx5r3Gr
	 RI6pCAcctcUCH/AGog0Yck8XYsncqHEV+t2cFO8OoYkJ5i1N7uYEnL/slKIa6sOxRX
	 P9/glg+xpC9vx5MlS36ZMY1HURQfXy+pk7U1fPv0Eq4B/Uqg1d+61ZlUtcC+ps7hHz
	 ArwHaWGdWXZkw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A507C531D1;
	Thu, 23 Jul 2026 22:56:37 +0000 (UTC)
From: Vincent Jardin via B4 Relay <devnull+vjardin.free.fr@kernel.org>
Date: Fri, 24 Jul 2026 00:56:33 +0200
Subject: [PATCH] bus: fsl-mc: set dma_mask for the root DPRC device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-for-upstream-fsl-mc-dprc-dma-mask-v1-1-6f08af883195@free.fr>
X-B4-Tracking: v=1; b=H4sIACCcYmoC/x2NQQqDMBAAvyJ77oIJaqVfKT0scaNLjYZdLQXx7
 wYvA3OZOcBYhQ1e1QHKPzFZlyLuUUGYaBkZZSgOvvZd/fQNxlVxz7YpU8JoM6aAQ9aCRJjIvkj
 OcRNa6tvQQelk5Sj/+/H+nOcFc1VD13MAAAA=
To: Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bogdan Purcareata <bogdan.purcareata@nxp.com>, 
 Stuart Yoder <stuyoder@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784847396; l=1926;
 i=vjardin@free.fr; s=20260525; h=from:subject:message-id;
 bh=50GoUATjGzTOE04DbAm6nufTMWrQbESmgDWMsefMpuA=;
 b=G/rIzE9Z00+txF2HsSaVork5JjXa/HUmU6sdGAwS5CqDVJ6ty4/eAcaTlKHYt1XIHo88cbx2+
 Nuyh+327K58ARkUaktB2yx8+DxrMdXge7fCpWfQhMqc+N9kvE0hHKP+
X-Developer-Key: i=vjardin@free.fr; a=ed25519;
 pk=hppgLeFpGpKOi7LNwGEZ4jOYofJCoGd4Jf1ltAabiLw=
X-Endpoint-Received: by B4 Relay for vjardin@free.fr/20260525 with
 auth_id=871
X-Original-From: Vincent Jardin <vjardin@free.fr>
Reply-To: vjardin@free.fr

From: Vincent Jardin <vjardin@free.fr>

On Layerscape platforms, when SMMU is disabled,
fsl_mc_device_add() leads to the DPRC device with a NULL dma_mask.

It has been tested on LX2160A, no SMMU on the MC
domain: the root DPRC can probe cleanly and fsl_mc children
enumerate.

Fixes: a259ed1618d2 ("bus/fsl-mc: support dma configure for devices on fsl-mc bus")
Cc: stable@vger.kernel.org
Signed-off-by: Vincent Jardin <vjardin@free.fr>
---
fsl_mc_device_add() already seeds a default dma_mask for non-DPRC
objects, but never for the DPRC devices themselves. When the MC I/O
domain is not behind an SMMU, the root DPRC reaches
fsl_mc_dma_configure() -> of_dma_configure_id() with a NULL dma_mask
and the probe warns "DMA mask not set". This mirrors the existing
non-DPRC seeding into the DPRC branch.

Tested on LX2160A with no SMMU on the MC domain: the root DPRC probes
cleanly and its fsl_mc children enumerate.
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 64d75eed0d34..585345ac0179 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -832,6 +832,14 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		error = get_dprc_icid(mc_io2, obj_desc->id, &mc_dev->icid);
 		if (error < 0)
 			goto error_cleanup_dev;
+
+		/*
+		 * Seed dma_mask so platforms without an SMMU don't complain
+		 * with "DMA mask not set" in of_dma_configure_id().
+		 */
+		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
+		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 	} else {
 		/*
 		 * A non-DPRC object has to be a child of a DPRC, use the

---
base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
change-id: 20260724-for-upstream-fsl-mc-dprc-dma-mask-a11e4c5a85c6

Best regards,
-- 
Vincent Jardin <vjardin@free.fr>


