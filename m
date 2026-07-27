Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568A418A46;
	Mon, 27 Jul 2026 13:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158675; cv=none; b=udlaoRqkfNqFqOOoCU6XZu80TD5E7z89kSCtz0hXBWO52IpXkis1G9Yd/O2i6XsfveuRiMnLZX6iUG2gtzz3muMQl+xBzchN/pdPgPFY+wnfND8PJxdcQ8DuthvbnWmKxO1VTrTWc3WIERbtOdmieU22Wuj9Pnv+0JTleWoRAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158675; c=relaxed/simple;
	bh=XAaP4cKlv2ZFmUUWW7nh03OqyUfGmWKrIVifrB8ELQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGd/AJAkoaqnKStVXKTIz2voG+UTnMn53gx0acRPMZCNgIJkbaxPnFokvCNl+abAfa/Gr+t7HeW9CsjJkgxl2W1hVVr4FyCe/Brlr+TgM/dPopJQC/8BGKKfOaMY8kUgV+cAkvyuGFd7SwVPio0p23o6QmNZOB/teRG7A6c2JjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9iv7sQo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9iv7sQo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9D51F00A3F;
	Mon, 27 Jul 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158674;
	bh=m6lwCY7Uw+xAyc7oYBbbonAyz7j5Z2E9sRmQDJgmEs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9iv7sQoTz3EZVHLAS6p9hImetQfVPrgmymn9JDriUXnaz6o5Th7LPNuK0+/QvxSC
	 6Lbt9fcWsujhwwL46u9N+3oANDbn5em5D9d+9AsBLvn95QbofN2BWn7MmtBu8g89Hu
	 K3/BmMviMyNDaBt96Y43Wlvqtups61xlw1kOvSeMDdbV+zY6hnfso+smKokg9UiEs/
	 lSxtFSGU2eNxCPJcIkwGcLMVyb/ISiu0bVD31+iXlWVWBrtDUAZzuHTqqs2oapKdDO
	 UCH0Hb9CLaLazsW3aradFgChzQO6TX22DUtcs8YQqu9qLt7dtV+fegWpwuxp+o+GM0
	 e6/XKNIZ1OPIQ==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/10] EDAC/altera: Fix IRQ domain leak on platform_get_irq() failure
Date: Mon, 27 Jul 2026 08:24:10 -0500
Message-ID: <20260727132416.807230-5-dinguyen@kernel.org>
X-Mailer: git-send-email 2.42.0.411.g813d9a9188
In-Reply-To: <20260727132416.807230-1-dinguyen@kernel.org>
References: <20260727132416.807230-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sashiko reports: If platform_get_irq() fails, the function returns without
freeing the previously allocated edac->domain.

altr_edac_a10_probe() created an IRQ domain via irq_domain_create_linear()
but returned without freeing it when the subsequent platform_get_irq()
calls for the SB or DB IRQ failed, leaking the domain. Call
irq_domain_remove() before returning on those error paths.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 13ab8448d2c9 ("EDAC, altera: Add ECC Manager IRQ controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8cbf71ce5d2d8..e5d225f799f39 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2179,8 +2179,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0)
+	if (edac->sb_irq < 0) {
+		irq_domain_remove(edac->domain);
 		return edac->sb_irq;
+	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2210,8 +2212,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 		}
 	} else {
 		edac->db_irq = platform_get_irq(pdev, 1);
-		if (edac->db_irq < 0)
+		if (edac->db_irq < 0) {
+			irq_domain_remove(edac->domain);
 			return edac->db_irq;
+		}
 
 		irq_set_chained_handler_and_data(edac->db_irq,
 						 altr_edac_a10_irq_handler, edac);
-- 
2.42.0.411.g813d9a9188

