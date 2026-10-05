Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E7B4AC172
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211276; cv=none; b=Nhbwjqf2SdMhiJYan9gxXdptXAYcJUv30z5fmDY8gKFLbP7CSUR3eCLh4F5iv4lHZK/EyoHk4wxtpbPauR/SXhYUoJd6sRLV/fdsEzbN6l0MnSP1vPvqRHfJM/bvd3x91weWfIwrQWhTGnCfoywHLjK2awYWDwq78Dsd0aj+HBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211276; c=relaxed/simple;
	bh=u4cegiD+QtXTyG3m77gQH7Rwx0XOKu21z/HjTpUtrXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9myxADobpl4BFam7gZ+6se6t9t/jFG41EfKo1CiZh2AalNA6bxKicDqjTldH6IjKqVbE5L0Y+rwgfcDGIjK5rRZv2THExZkQeXuaUE64HpT2Wv9eJ6UVVH+tiNbOGyQOQBVPorhH0shF2mRWy/BQAcJsX8K60CiyHNGYgqFjPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qn/J9Ryw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qn/J9Ryw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28021F0089A;
	Mon,  5 Oct 2026 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791211272;
	bh=B62Y8URpQsOHhXSxgt8KK19/TKadycqJ/XHqZFte1GU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qn/J9RywK1hsWhNUcHFds6XEj4CZq+9x5bsgH//hlIvemN6Qn6IJZW0+LkqR+EL7r
	 NT298fvH/9NWWERTH9YdWG6cZefkk4FquNxma1opPR5t5MOZrVETnhLJ7AxhaxQF98
	 G1nc1bcCM/mcE0OEXMnpiSScrVc5JPb7SsDXF8qBzPTb17YeJ72sYVB2XShju22sxE
	 gCo6xwduMP15s8QQWT6UqxgFF8xIgiVl/MwsAw0Ofa50Qf0dlo0Q3cHHwtPXIDYZlB
	 finUiAk8PuDIF3f7SyoINWCcu7pWfVWTaWqRqSYH4lCHjpzVzau1qL8kgkdGESAraL
	 kLUSJns2X0ERw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 10:41:08 -0400
Message-ID: <20261005144039.2984708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100516-conjure-falsify-cbe0@gregkh>
References: <2026100516-conjure-falsify-cbe0@gregkh>
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
[ sashal: adjusted context in dce64_construct() due to missing debug and check_config initializations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index bcdd8a958fc01..fd064a5196d26 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1359,7 +1359,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

