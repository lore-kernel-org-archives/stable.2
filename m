Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273959;
	b=z/bX1lKwH5VBDsF/BNhoHFCBRWirK9U9rIMlMyT/U6FVmZ1GkLVLuPKwhxm72JRDR1g3
	 kH8J0KtgPnmQS9Rj3eVSX0dZEOVY2Fi3CHm8XS6oysaeOseZMn/pqGWPgctIY1cXrlGGv
	 4bSmBm3p4dBbvLEjxkS6vVH8OmhY5K1orS+KOM0ZHd+OriIqRkCGIr8PWNM0NXtFH0Yfg
	 eZpZqlDUIK99cUodFB4NRTLtMzFi9kpO3Ds3OS94uOkFtI8jQfTDgGIE+RB/jZh2f6VEa
	 0eZmQCpNp9K51sozX745knAbz/2cwODSlXINelXySUwfHeqhm4T+6250UExscjjH36w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=fP+FDNI684wDTyEli+aaBVhUOalaBjfvoy95tI33+Ic=;
	b=nzT0Y1w5YhqFK5IlMmjx1RyPDo/g9mGqU5pDlPDdYvcgVvdJ9WMg6V52S4MwDvSjYArf
	 lVOWXZy/eiMv1SmjsH3l650MyLsB5/ClqbvAJiokhb+ZGISpzdcziymmeqC7Xr+D6Ja30
	 QZRZ+64frO/AHJpYci6SnuaDtvyQw0vVohzzd2BQq7yKHqOjNbwJEicI1TVo2pQfJ3Z1N
	 ZTEZEicnlJ7tnb+oPYhhLTYUcrrnxzZuq2Ols4H3d6w3d8HbbKoY4jSiY5pAb8wkWoQ5h
	 iF2QS9t2QOJqf+qgInFbbjYDWFi5QUTExR8fnOtSswgDwAljTakZ3kH0TD9gHFXeWnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy3mLClj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A05160A2603
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hy3mLClj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423351F0089F;
	Tue, 10 Nov 2026 01:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273958;
	bh=fP+FDNI684wDTyEli+aaBVhUOalaBjfvoy95tI33+Ic=;
	h=From:To:Cc:Subject:Date;
	b=Hy3mLCljHELW3Yi52MuvclGJomRMrfz1MfGcH3eMpqHvf35KDB3wlKqfAJAw0pEdF
	 M0FaV6bWyL/Ij7Kkv2wQ3FCOJ7j3zJ8c9O78SWgxNq6wAWlmIZBGPjPnX4A08ok3UA
	 hvwuz7WG7p9jj4PI5cufU2Ci7w/tJOMGFiajWAzRYoewaF1NbiKojMnWFL1Fvp+pT2
	 sP3z1jpmrriXkmGi3OzqcqDkfqbXXS1tCwN659cYCppNVUt2rrXU1pUnXQv4g1y0mn
	 MvDlp00RNVSAtsLlNAv+HbgfD5KUA0EKywSE6F0qYyNvd4XBXu8F+ElOKtmB1jxSzO
	 QTd2YrTbr756g==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:25:56 -0500
Message-ID: <20261109202556-failed-5.10-1e73257dff33@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202556-failed-5.10-1e73257dff33@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




