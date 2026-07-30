Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734145C71C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439803; cv=none; b=jFm8IGH2DQRSNBCCGpWEvrTYRYbjFsoRikH7pAhAUdXGtWknB3963otT/Y38LIEeyblZDvx9am+BbKWY9SVoa4mMosX8a6iXqVhHFxRr6bxf1pzYCdJUtLwMvIJyCFIMWFZLqcngm+dYKK6eKvgcKk8eVAHHvGr35L0G0hj8eVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439803; c=relaxed/simple;
	bh=XZtPDnBIDjS9XxeP/OtG9ILdLTOTXu1UaH06sWIqAuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qz+1VHM6AEBTCn/ACAw45if2tOUhbfYGA43ZWE1M21EDVkrHA0bVzkMQ7lrgFXFd9WVadLD07Id6vSiiV2j02JLFI3z8S51D5KZzTURVBDPHhO3RMHMXtehXM9XJGqQoQHQB1LZgu9GncqRJh5N6+RFo9fIqggeXbcKDM1iRsS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhN2eWN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhN2eWN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77081F00ACA;
	Thu, 30 Jul 2026 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439798;
	bh=reTWRGUzfHj2yEr6mq7UC6aJLczWqmQ4AknK/XmpgnQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RhN2eWN26JX7q5MLrtJpGA3ddXxHW+4GNA5G1CFrWZwocAQe/OzmMn07CH7knBv3R
	 x/gSYUO1Czwa2z2FhNTGhs4i9JHnLizKdx3r5ZyWL+7WftjKoDsDRb81HgAiBvPRP1
	 QtaA996im7ldIqwK/D8yYfUXk0dlDI7Bfx4LjqTOOFriI5LMNBagtpY7XoUSp8fku/
	 AlPnDjXpDL3AS3zYnFfDL/7teNbd1krzP2C1FsKYSuQ7Vi7rR+LTwxBPxExy3VnP+M
	 /tMJzRKG88p4/qMF6y2JAIwBEaMU/z8HMEMax/KJLKjjF3VVr4AoJhe/1l0OA238yq
	 tEk6k98fnv5Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm: renesas: Move RZ/G2L MIPI DSI driver to rz-du
Date: Thu, 30 Jul 2026 15:29:54 -0400
Message-ID: <20260730192955.3124753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072951-ended-spoiler-e626@gregkh>
References: <2026072951-ended-spoiler-e626@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 1b5dfd1881dbe303536d4167500b94549ff2f6a7 ]

All the RZ/G2L DU specific components are located under the rz-du folder,
so it makes sense to move the RZ/G2L MIPI DSI driver there instead of
keeping it in the rcar-du folder. This change improves the organization
and modularity of the driver configuration by grouping related settings together.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240625123244.200533-1-prabhakar.mahadev-lad.rj@bp.renesas.com
Stable-dep-of: 7cbba8a8ba02 ("drm: renesas: rzg2l_mipi_dsi: Increase reset deassertion delay")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/renesas/Kconfig                           | 1 +
 drivers/gpu/drm/renesas/Makefile                          | 1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig                   | 8 --------
 drivers/gpu/drm/renesas/rcar-du/Makefile                  | 2 --
 drivers/gpu/drm/renesas/rz-du/Kconfig                     | 8 ++++++++
 drivers/gpu/drm/renesas/rz-du/Makefile                    | 3 +++
 .../gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi.c   | 0
 .../drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h  | 0
 8 files changed, 13 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/renesas/rz-du/Kconfig
 create mode 100644 drivers/gpu/drm/renesas/rz-du/Makefile
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi.c (100%)
 rename drivers/gpu/drm/renesas/{rcar-du => rz-du}/rzg2l_mipi_dsi_regs.h (100%)

diff --git a/drivers/gpu/drm/renesas/Kconfig b/drivers/gpu/drm/renesas/Kconfig
index 3777dad17f81..21862a8ef710 100644
--- a/drivers/gpu/drm/renesas/Kconfig
+++ b/drivers/gpu/drm/renesas/Kconfig
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 source "drivers/gpu/drm/renesas/rcar-du/Kconfig"
+source "drivers/gpu/drm/renesas/rz-du/Kconfig"
 source "drivers/gpu/drm/renesas/shmobile/Kconfig"
diff --git a/drivers/gpu/drm/renesas/Makefile b/drivers/gpu/drm/renesas/Makefile
index ec0e89e7a592..b8d8bc53967f 100644
--- a/drivers/gpu/drm/renesas/Makefile
+++ b/drivers/gpu/drm/renesas/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-y += rcar-du/
+obj-y += rz-du/
 obj-$(CONFIG_DRM_SHMOBILE) += shmobile/
diff --git a/drivers/gpu/drm/renesas/rcar-du/Kconfig b/drivers/gpu/drm/renesas/rcar-du/Kconfig
index 53c356aed5d5..39af73cf2092 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rcar-du/Kconfig
@@ -60,14 +60,6 @@ config DRM_RCAR_MIPI_DSI
 	select DRM_MIPI_DSI
 	select RESET_CONTROLLER
 
-config DRM_RZG2L_MIPI_DSI
-	tristate "RZ/G2L MIPI DSI Encoder Support"
-	depends on DRM && DRM_BRIDGE && OF
-	depends on ARCH_RENESAS || COMPILE_TEST
-	select DRM_MIPI_DSI
-	help
-	  Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
-
 config DRM_RCAR_VSP
 	bool "R-Car DU VSP Compositor Support" if ARM
 	default y if ARM64
diff --git a/drivers/gpu/drm/renesas/rcar-du/Makefile b/drivers/gpu/drm/renesas/rcar-du/Makefile
index b8f2c82651d9..6f132325c8b7 100644
--- a/drivers/gpu/drm/renesas/rcar-du/Makefile
+++ b/drivers/gpu/drm/renesas/rcar-du/Makefile
@@ -14,5 +14,3 @@ obj-$(CONFIG_DRM_RCAR_DU)		+= rcar-du-drm.o
 obj-$(CONFIG_DRM_RCAR_DW_HDMI)		+= rcar_dw_hdmi.o
 obj-$(CONFIG_DRM_RCAR_LVDS)		+= rcar_lvds.o
 obj-$(CONFIG_DRM_RCAR_MIPI_DSI)		+= rcar_mipi_dsi.o
-
-obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
new file mode 100644
index 000000000000..8d97d6fd7ebe
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+config DRM_RZG2L_MIPI_DSI
+	tristate "RZ/G2L MIPI DSI Encoder Support"
+	depends on DRM && DRM_BRIDGE && OF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	select DRM_MIPI_DSI
+	help
+	  Enable support for the RZ/G2L Display Unit embedded MIPI DSI encoders.
diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
new file mode 100644
index 000000000000..5b2b2ddf097c
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
diff --git a/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
similarity index 100%
rename from drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi.c
rename to drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
diff --git a/drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
similarity index 100%
rename from drivers/gpu/drm/renesas/rcar-du/rzg2l_mipi_dsi_regs.h
rename to drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi_regs.h
-- 
2.53.0

