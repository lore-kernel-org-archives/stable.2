Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272797;
	b=CEFqC2nJt2MLjj5fdFGrbQfiwkHjQ8ylxgNIF1Zl0Zyi4yNxPzCRYU/V3PdiI4tEfWur
	 hDjCn0ZukPm6uh+yrGnzEKkUG4PueBqygCfpc8GnIlkESXS1FNfjHBu0Fsx871nnNtaD+
	 WelOv7DEkj2iKTTFxTVtAzkSEVS3ccWDJubY9GVrpW2i3z9WXFn6v9k5sF2/SDeUvMuTe
	 5sf1uaoJPCvEmE0plQLtwzGhsNrkpUGTMW/37UFWI5NxM0XUh7B1vALfr6KPJQVdR2ucz
	 LPgm4laTVmh4qfWOxz+Xdevu8wdgxm1XRUZteDRT+ov1jeo1un0g1F1jybTlsnTciow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CGt7F3Ur/qCZwbIXIHAOXNs4UDPtuAfy4OWJG4w21wA=;
	b=5dyJCRUAKhTbfT2hivY3xSUe+oH4oFJ3G6Opg6WPTV5MtWhwFBnuBTNpaDp45C6aOGij
	 7BYpXAh7Ega5DU9u5dOdNXHMAEm3n8PY+mPHKdypcjSfSw2kFJRyAikZQg+hsuGF9DfFj
	 Qrf7dsloa03pOf1DyCnidZNcY+MEdiB++o74gZ021BDSJMNxqmbjs/vVv6wX1Nr6h/GnI
	 rCZlgdQ039MRzrH3PSSQjb1kAOoPmOzDo3C6EmAMYz2HWGLYGhkDFK++Wbnua/fyLumyj
	 f/tHIdfhabQWLsYLEa3zVlLrtrtczcmNHTRlosdY9m2nOp+yRSuOexJ4zThavMZy6qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=df2+xZ1B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C1606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=df2+xZ1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED141F008A1;
	Tue, 10 Nov 2026 01:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272796;
	bh=CGt7F3Ur/qCZwbIXIHAOXNs4UDPtuAfy4OWJG4w21wA=;
	h=From:To:Cc:Subject:Date;
	b=df2+xZ1BDYJZzZCTzZtdsOaTCtP7udx/hBLZ8Map/n8yRLGw/2hgWojU9Ki2KSURY
	 T6kqv0W4h0ObzrHjtjA0RuQWNFtzn4G61xXD2hMppvTORFH5z+RkRt3lKHWdVJE18e
	 uwkq4XqxdWjJtz+XB74IPkkXLbO+mdQLMjnMAHodkQvbjY0cSNfuqKd8UW1mB3DkWU
	 eVaqmto/QbyVL3H84HBAsLs2IuTWwmFYJYGwTFH7EUbQaZ6cG8EKmp0sLkV0gYtse4
	 ZnzcH7kuVLuiCsiC6oMoKw0FeCYywTZTiZUlIJLFPuYY55ZQwAU91/6wDSqWm4kqNl
	 hy+3dGjNFyTSA==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:06:35 -0500
Message-ID: <20261109200634-failed-6.12-1e73257dff33@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200634-failed-6.12-1e73257dff33@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1e73257dff33ff851af60d5bb00d73893a8b6dc8 Mon Sep 17 00:00:00 2001
From: Gianluca Balboni <gianluca.balboni06@gmail.com>
Date: Sat, 31 Oct 2026 11:21:36 +0100
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop
 16-by0xxx

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261031102136.24600-1-gianluca.balboni06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1d06b2a16e58d..4908f4cc147a3 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -780,6 +780,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8DC2"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0




