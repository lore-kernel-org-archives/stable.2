Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D5C414A2E;
	Mon, 27 Jul 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158675; cv=none; b=SctUvEy+h6j+xP1ZukZkd18yCLC9/98dcof5Jp/f5nb1GLPgTfBRqwnjPK6g3kArjbo1yrznKDGXYb8RoQE4ZE2S0lBphiCh0O6SWK7Orsfx94VTmQzkaCg8Xc6Kc46i9DLbujM5l0U16it3IWV7TfQhvUd2BWGYoxPvxBS5grw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158675; c=relaxed/simple;
	bh=Q0HuwyvC2ry8KqMluQG1PMszwy73hhEPMHRW9P8n+Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hajLigrViVCgtCleJcqy2qbu0FNUyTxWBlXT0deUQopZc5eL9uMmvibFlxacBw4NGWDUJQb34vRHS5nVsRihMdQoHvzNP0KRQd7ggOTNUvbBh23qRw9Gtzc++PV/FgRdJGEk0rUZB0VGV4fjUTBAHNuO7dFiOXy9dBg72ErZZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwthpMkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwthpMkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA7C1F00A3E;
	Mon, 27 Jul 2026 13:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785158673;
	bh=2vDaUeDUM1aE7DrrIZmHmubL6eDtK1I5LrqzLWG9aEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwthpMkDUKt+s0K8GqAQv0EjOP0q+zJ+JQwEp4B5IgR2070j6kZEhIL6dikPiaLCc
	 rGzSk13f7GHbIVJE0MjvvAMk8vgcKNzKXdlwFzGYw5k8nnAZwtfUsZh1Ra1PUT/l+v
	 e4KzYARHEToxdEpOBZn68saZw6NbdvzEe4vDa646W/5JK6fzVNT1N0lw3mqcvyx1w2
	 7Hmw4NJTGiMhBS3Fq/poDIN6DFss4XuteR3VqT6NoamTJY4xd8mGNVIPtA/F6tsyf2
	 oT2Rea4swzr5LV7Aekf95ykRgm+dQjRKPM4LNH7j0X67uJzIY7wz+MRQMhjNKTXU53
	 +sijwhGeJuzAg==
From: Dinh Nguyen <dinguyen@kernel.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: dinguyen@kernel.org,
	rounakdas2025@gmail.com,
	niravkumar.l.rabara@altera.com,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/10] EDAC/altera: Guard against NULL match data in altr_sdram_probe()
Date: Mon, 27 Jul 2026 08:24:09 -0500
Message-ID: <20260727132416.807230-4-dinguyen@kernel.org>
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

sashiko reports: If a device is manually bound and lacks a valid match entry,
of_match_node() or device_get_match_data() could return NULL.

altr_sdram_probe() dereferenced the pointer returned by of_match_node()
and device_get_match_data() without checking it, which could cause a NULL
pointer dereference when no match data is found. Add a guard that logs
an error and returns -ENODEV.

Assisted-by: Cursor:claude-4.8-opus
Fixes: 143f4a5ac5af ("EDAC, altera: Refactor for Altera CycloneV SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/edac/altera_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 34b33298cf86e..8cbf71ce5d2d8 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -300,6 +300,10 @@ static int altr_sdram_probe(struct platform_device *pdev)
 
 	/* Check specific dependencies for the module */
 	priv = device_get_match_data(&pdev->dev);
+	if (!priv) {
+		edac_printk(KERN_ERR, EDAC_MC, "No match data found\n");
+		return -ENODEV;
+	}
 
 	/* Validate the SDRAM controller has ECC enabled */
 	if (regmap_read(mc_vbase, priv->ecc_ctrl_offset, &read_reg) ||
-- 
2.42.0.411.g813d9a9188

