Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A6429CEE
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197471; cv=none; b=jfXciGV6ltnXoJQCo4lIbpzzP4W0vqG6dL5BIbYTNq3zQx2HnZd+GvzPMTD1TkTsD2mzJaIpO1T/m/GXtWrA9yKCiEUmmvspSGOcZMuMWETA/eO7Dq4rNvOuZbMLOgF0qzCsjaM9LTBtZFOvrSVzDVIOubCcnC88ENrkR1tFjvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197471; c=relaxed/simple;
	bh=CGVCQaXHQryLsHj25HMGUI/Oiv2sTOq5lZWIUk+H9qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcmoRjzGqvhcntOo4INEnWd0PM1J1RupG28BJESFoozvz/OyvBWXxtEkyhwsI58G6uXSkqQwqpxvD5EqKeyMHMY5pp38cDXxgyAtQ7gdofdNVJIILQRiZEbOa1Yw8zt8zSnan00e9jWsddOam/Xho4CGhzzXsb4DrDD/IXVrw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L98/nWzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L98/nWzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6F91F00893;
	Mon,  5 Oct 2026 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791197469;
	bh=zI8KtOJBfDdLnlmrEPPYQMTfxJ1k++lM6N6utdPTbmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L98/nWzqRMUDYGItZFQDz6cTtZIwTsivgxaraxLo4aO3h40mvuExHI74UvCEY8hvv
	 8z+kFednsthui8UAeGrVXstSQ6BviDdIhO6+tdxyWyUQXqTja1K+ZSoFoN8mmvAt6t
	 dLLlGqkSLfLXQrYuBo7lYaZVt/RqgL7baA9HHHhL35GLY0B+/vIRbGyqWEURK8h6Hp
	 IE+qhquv20MUKBJQkTcb2LoATpXhnxbrZZJgjqtSeLHVCZr62oetb67/gQuZv5RgBH
	 IVeXGzV97xdjdzKd04h5TGatk0Oe/IJ+yNHdJVqFlCUAFroQVH4h+h86eQ21Slo3aA
	 9VntX9xI1wiVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 06:51:06 -0400
Message-ID: <20261005105024.1548505-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100503-faucet-depose-47a4@gregkh>
References: <2026100503-faucet-depose-47a4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 3a52d587d1fc8e8bf94ba1b07374f7ec91aaffb4 ]

DCE 6.4 is found in Oland chips, which were advertised
as low-end gaming GPUs in 2013~2015 and then have been
sold as low-end workstation GPUs until 2017~2019.

These are not APUs.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-3-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1072aa811ea1e61d5f763e4ec1bc6d24bb61f14a)
Cc: stable@vger.kernel.org
[ sashal: Adjusted context for missing dc->debug and dc->check_config default assignments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index e94af8522083c..e67c73807f371 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -1306,7 +1306,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

