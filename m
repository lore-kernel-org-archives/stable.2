Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273647;
	b=QoZ/Lgghrk+rA3dTJXymvj6MRX8Fg8IsOlvy8vi7pZmk7a0EW04T7ITMKndVoxZ9gYeR
	 H4WbGrYzWtppP9rj+TtLYV68gpXh4hvZl4TpVOcW0/yEizvqNT9Y0SHIyObTuySGewlWA
	 VH24mPWXaE5i3gbn77GVfUePMujT9N94PyEpsTDdlv3a9JEosaumAIGsB/Vdpx4R+k5At
	 pMjkALHWBA4imIprxCSPZmeoaE7Qu2qDzRfSfaeqUEz+W1nKD9mDJxieKWgW0bZGqu/VJ
	 c6IhbGwgdxkX6k+n42Zn1+QQTYP86JL0a+azwJbL26sBpyKKOvY8VyW/yjVrtF8e8sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273647;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GVesX4NDtAcYVQkguv7EeoXn9GSDF2UwYWgWfpSo0Og=;
	b=Clveuxom0GU9O6bdNnWcZlGucQFEykle6ZOpRAcJnFcsU2JXpQ+FiY44NlhTrO54sN/5
	 w3R+/IJZl5QU5gqDijEccRqGbQP6EOVTvM0HSjwY/xlZERIr2DrcFjtkS8n9qeX2Qzdg3
	 RaE63M6+mtraKanszpWCAHkHQuY0H28NWZutj/yyTg/ckKDLRap4GA81/9r06cgBEYMco
	 CYBZBCu/yFdqm9vWi3nX159fJsaT6n9qMYPaQbJswU3db3B/WyrGwGvENlqcyjEu+zDmF
	 erKZMtp8EIznJHQTiLXIS6GmbEcjAFUYniZ0A64dDO5d4LGV4uUrGya1X358b93YqPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0oTiTGZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A017460A261D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a0oTiTGZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00C21F0089F;
	Tue, 10 Nov 2026 01:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273647;
	bh=GVesX4NDtAcYVQkguv7EeoXn9GSDF2UwYWgWfpSo0Og=;
	h=From:To:Cc:Subject:Date;
	b=a0oTiTGZ46Y0I1NIdWpYcpQJkQz89NWPy3vqyiR5HcoyOEnt0A/PVigqwlAkyyohh
	 Z0QJ9uzxO/2UsfLqpR84PkwJpF933Z8H8ZjQmrphpjKia8jZJfYa8dhfXv9iMKDWA0
	 8se1m/VF+dWdLGgIGz0NS0e7MC0mjPjYNZ3T/xeCZGMLj6ZhZOz1NGC5tmoT3xw8A6
	 v5adFCb31ElotxHHmX1RRoGwD4t51YibXLPlsk92gzsUi1UfOH+zuvfyxOC0lzH5Ix
	 GU+bWQJiaS8JtNeh/aTymn6CSsXPJc9YicFSY47cYcohAHBzmOUfNqK5ahVkalqHNr
	 Y/xcLn4+YOZLw==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:45 -0500
Message-ID: <20261109202045-failed-5.15-1e73257dff33@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202045-failed-5.15-1e73257dff33@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




