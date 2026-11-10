Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273337;
	b=p+OoNhsMu1rZ3dS6LNxixsarIQPYVwYu/8bXYMjJlRq5uNd+VBVYTl/zofyTj1xJdSW/
	 XnBEz8rb8m1gIJCldFyW79f413xW9qEXgXVz7EkrfVUwifMLhoqAJEym0bIkq8EmTf+sg
	 7gZosMrwaPHOd8tvFMAQUtF8qIi6fnwRynzyiBKOfI0nR/YfrImZ6Z7sgxGrcWNWjhyOK
	 oCF3qw4R3hVIb8ADNqXxATDGUmrzagD/8lJFO/Dgp2GNtVo6UgI2wwKh7PPjXcqDAlYHb
	 E7ssa5CrAIQfx69ILaUP7q2rDLKssPn1BeiTISXyYLBdwfC9+BoaVMQUSjpoaDdJDlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273337;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=UpiQg7AdO8mRGtjeMFB8epUBdCsJs7VLw+c1hvj183w=;
	b=RZlfroWvOtm+Z/Ujv0/je7W2kKYcqRKZNEfuX5plJuDLN+o4azUCRVYhle69pSeCzAG+
	 qHoxFF02RUZDE5ddN0/UfqJJDue+bWRZGREa5MCbetaWspdRZ3QhH5NWTFsdYVwcRIH/u
	 ezfVHYOu5SC/4Hqy6LeXHEgmfUaIMdICJz1vNtcH4YHwG5nUKMRc+I1TEEFs9q5Kq+Wbw
	 45yIkJUApCDkECwZX1ytfeVCpGMQHKo9/QaEQ6tsQIsIewLeRj/5KWdrvs9DXnV/l1VR6
	 8DH8HMqdaq1yhSqtOWIRirBUrM+f/c+EjsdwPZytWpvGss9hsN+TPjAs3OHoC05Td/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Txho2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5132D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G7Txho2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25EC1F0089F;
	Tue, 10 Nov 2026 01:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273337;
	bh=UpiQg7AdO8mRGtjeMFB8epUBdCsJs7VLw+c1hvj183w=;
	h=From:To:Cc:Subject:Date;
	b=G7Txho2sVcc23l904xcH8tZyksPm4qOIctTUqj2ZAC7d5UvaBfee+6yuASESUIabi
	 +JL5iH3Wf1Xp2pErwkVKmUmAN73elVgvhtC7IWwhtNDfaGqwDs6RHIFn3ZbtKqgN0M
	 zfQB5pCHtGravil3NPQYc5MRXgm9CoMhjUy1k80cI2an6xLbEQp4B2YBkOp64kIlhx
	 BWEJ6QVb50QX+ryfh1bPrKKpk8Momh+hgleOoAOGjt4cak7lGCRcv93akxghLBL36F
	 YpbhLihPsfvYyYiQnyW6gHE7JZqcbb0Zd4FSUepunN7zPYnQf2aqtiiscqqNc+hipc
	 rwQOAxdY0QrYg==
From: Sasha Levin <sashal@kernel.org>
To: gianluca.balboni06@gmail.com,
	vijendar.mukunda@amd.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:15:35 -0500
Message-ID: <20261109201535-failed-6.1-1e73257dff33@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 1e73257dff33ff851af60d5bb00d73893a8b6dc8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201535-failed-6.1-1e73257dff33@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




