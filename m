Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8622356A12
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583669; cv=none; b=OJM7/mik8v/+qXvBPCPXTsrWtTS2+KstBPjBjczl3N6/D2ikj+lnJun1LIHyhTf3kFs6lPMUxTq8uEUoFWbT84tpRASOEOJEKXbc5Fu2mw5m4ysIb7vmH23m1qFjARb8mkkAK864m4LdnZRIPThbizi+c8t16NIP5OBWc+UACqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583669; c=relaxed/simple;
	bh=qe94mXndSezODbGsnPne2J8gcb8U4rdNVVkM4WCEsqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFyoMgVssU0EbTybdXkbhkZX8L+rWqqOLKyEu0BikH+97Qh+CxtzRH45H4iNDKnota3QmvrvmgaHkq7W2r2oM1qzWAsGgHexUR5PZJrXqtBDGgsh0N4W8KiOEtCP6YhmK4rufKSLP2aMZZ3bjQztdYCgwUeQGl8hcrX/iy4TBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Od+BZmgQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Od+BZmgQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FE71F00A3A;
	Mon, 24 Aug 2026 15:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583667;
	bh=EegOgHkzYzkdohXKBVFnTMRZFtDqrXFocX3/+9qigFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Od+BZmgQz7mgs4EG8BtxAEgnUB49Ti6ZwVH2r2V7JfR4x4PVcZ9Hy/xhuZOHzWB7p
	 7ni1WJtKABaeUpv+OO6Xpd0BK+zBd+UW8sl2c1hXLJcfj++BlwSfYQiaBHyEYDLBQk
	 wP1vIRjXn2TYCAWzkc7E38iYr0tpNIGUbEQUFPZYE4BgKEfsXN2lnlifsk8nTWxtyg
	 O5jCBWErAsxPUWYEqJTeVS9o+7VptPkQW52/4gFwTgOkPWGKN5IbFIqRYknO1H/bfT
	 THwSF30okAi69ap1XtsvuBMQ4CAzlDaOq9IPdIZjKNGqysVQ495PHGUhSECW5e74bM
	 ClyO3kyUpXpPA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Mikura Kyouka <mikurakyouka@aosc.io>,
	"foad.elkhattabi" <foad.elkhattabi@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard
Date: Mon, 24 Aug 2026 11:01:04 -0400
Message-ID: <20260824150105.3723623-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082022-version-salad-624e@gregkh>
References: <2026082022-version-salad-624e@gregkh>
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
index dea8ce0032748..f55f935c60c5f 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1937,6 +1937,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
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

