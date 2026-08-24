Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92D2F7EFC
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584754; cv=none; b=VgE6Gxow2wUpWOXVZmpMsbfA6iL4G0tWpUGw3JnzI4KT/KkBF6NEwyF4327GWZlutEdVDyqLinE8R7WzvjNR6XNIgcwOrBJ6nkBGKFC3fVTo4a3DKjl7SnjDk59YO9lpFarhEaGz3ZJJHD15JJGbBRgDjGoBt5uE6WwuIF8Ih/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584754; c=relaxed/simple;
	bh=6inoluI4Ve2mca1iokCc5bOcVjiy5lPso8RwbY3agG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP4wzneishAXq/FjxMdayM9gxsKO+lTIcjQ0sMYer8YTSFtGxFwI1jBRhKeTlVrlHpYNNG+ZXcnKR9wu5PbBuYZjv/VmFtYc2LDsll4c6jjsygJNyQQ6U5y2qdmuP2XGuwcXrNvYOL4HLBtkWrkOf6kVi2Ayc+pFo94Vor8MSkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gPXnvR2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPXnvR2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF6AE1F000E9;
	Mon, 24 Aug 2026 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584752;
	bh=Kj5ZR97XrmCeHI2UW1L3P3aC7VKdvVf6EqOvZ3NCijE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gPXnvR2PaNXnntaD4ImuLxGrmQEDRIDMuO3rK4fc41Q6MpaKRuZZqaCGD84B2waIi
	 fpjMRgN5h40ej+SeeDBEm5Gf2KYkDAr2sx55FQNNZ1/OS3HloCXVYnw3YV+tWgFWBx
	 SKHE6sbkB1bOsj+M59r86HI4stHPRphT+vU9gmL4nkmasd+wP/BcqxZ6tCz0Z+2g2s
	 o0EC4FiR/5ZVv3JIQPMzTJm2n6jMN6cHzr5nv5QwwDfYR2sZsYgx8ErC4ucWTDD4QK
	 w25GypEPQCf63LC6/xe8l2FWcimEghED4jaZ8GmT7jetJht2h7EEdXCHSiKk6fi/C0
	 qFP0jwZRIUWjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Mikura Kyouka <mikurakyouka@aosc.io>,
	"foad.elkhattabi" <foad.elkhattabi@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard
Date: Mon, 24 Aug 2026 11:19:08 -0400
Message-ID: <20260824151909.3764555-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082022-overshoot-smother-3576@gregkh>
References: <2026082022-overshoot-smother-3576@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

[ Upstream commit 2aaf33c6e1e82561d7dce2345298a985a2483266 ]

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
FMB-P, aka HONOR MagicBook Pro 14 2025's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Reported-by: Mikura Kyouka <mikurakyouka@aosc.io>
Reported-by: foad.elkhattabi <foad.elkhattabi@gmail.com>
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Link: https://patch.msgid.link/20251022-honor-v1-1-ff894ed271a9@linux.dev
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 410c44b10967 ("Input: atkbd - skip deactivate for HONOR ZQC-P")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 66d73cad96eaa..6ca9910b852ab 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1944,6 +1944,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-- 
2.53.0

