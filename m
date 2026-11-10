Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273055;
	b=rEalgAtAYaq5mIigWUzBxSHLpR6AfsifjTDWA1Bvbfq+7wEQ25qyrfRE6QIw57lFIdsM
	 pwzrGBV4fPZnXDMkNpMbgACVRfWb+UtDqWQY0eD93sCz24ACTyHaMXWO81u8uxrrGbxWo
	 8SwkSjZW64aqGtJr8kDvTMaeRAJ34tOE/iSVnPM8F05lLzHbWfM8NR1zR37UwwqUp4qAc
	 rpLjI5uXYJ8eaR23uTN63vmdNMUb3XAVfHCrpm0BIH4FbFIB+p9F8F0kEs5T+GkyT6NDc
	 KnfpxakbJIJq3GZJePs9r1Ntu4poiaEYh6zm2EAGsa+IMkr+huKxIu+0akExHPNkSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273055;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mwcyeZmQjP7iS8V5C8qTE4E2tHnCglLGIU4say6mv2Q=;
	b=octvZmQBFpzLvHaNPKcMlQHxuMquwq6I1qIZlSNfIWFZNhYz4K9CRfTzZ1D5tt0f9F6g
	 wsgRNboa69gFEORFrui8U+iwNNl5+Y2xoIlGx2O7d3iOPNXCNUANC50EQrkMX0ZgLPh3G
	 veJuUArrH/qcXxHXYgPMixomFm1we3hB0GP3jD15VYP7TnBY+qKtnobBu8NcRdAYWTxzh
	 rbkSD3pnEjRcYnpuO1NpgXjUkdKd0XMugAj6drtbm3SxvlFmEISff4EOs5abMhJ+1VZrY
	 s1Qq3l3kzqStZyHArTYAvbmytTuvIeYaqmo6sFsI+KBamheqINewUxz/rrGKMplmSsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mc2Adei6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218A5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mc2Adei6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DE51F0089F;
	Tue, 10 Nov 2026 01:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273054;
	bh=mwcyeZmQjP7iS8V5C8qTE4E2tHnCglLGIU4say6mv2Q=;
	h=From:To:Cc:Subject:Date;
	b=Mc2Adei6NtRniJzWePPhtWP9/NRaG4XBtJF9wLGRF3O60y5pQUSJlDxEShpBeVW/W
	 4SWgKL962oZQw9xhdKwZqWZcEXFHhna3bUOAUXzryKJwTdLSOoWXur4jlO/hwTnedP
	 arqBHaOjqjstn97eqXBZCgGWFN23BK2LsROsueMpynXSTtYodphUZfIHQomM8s3Z1A
	 WCSLKU8zVphxwDEhMATqepa6MEt+2SjROeGCBheiEkNu3kzn0zat+tVZYrjaWc903S
	 cspWBtMqyncZ97kXCvtD1KQ7eYroN2os4dUXXrZYbn8TiAa5t+0FMNFt6VhZIc42kd
	 hvj18J/b+Ss4w==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:10:53 -0500
Message-ID: <20261109201052-failed-6.6-1e73257dff33@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201052-failed-6.6-1e73257dff33@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




