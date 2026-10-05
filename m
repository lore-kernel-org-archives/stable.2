Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468CC47F3BF
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208116; cv=none; b=bAL83a6DPexZU8W0suY7fp0O/rEzsx2ZkfJbgA9m/zuJOUZHB24Uoch0OrtQngmgt2keAQFgevQDz6Y/0GKfk7vik1VfpVYFj8hsaetsdllP19lG0oOCkXJDRIv3oEaxNU4Xf/wEN07ef7pBGQMBRbJS018+tY/GQt1N4BVUzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208116; c=relaxed/simple;
	bh=CzTScrmkZxdYs/uL0JgLIz7w+Fm29vopuHAl6db2JW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZN37LhvLVv7C6+N9xKWE/9gsyhbSKGfd4wdZqG89OWJ23C0qOKXd4l7ImnTFSpqJr+gGcXjhoQ6tEKW7uS9LwAfQGGtpQhQxdb8d12FP/3TkcX+VWAI0JkKZJcywpsxw3I04V0UxnyzrZ4DMI9y6m5L00A8GcagPUX8ze6EGy6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH3W+fAe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH3W+fAe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB571F000FF;
	Mon,  5 Oct 2026 13:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208114;
	bh=K4IfURnAEY7bBO2NQnxahTyyobmT7hk5l9ANDR5pZ9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FH3W+fAe0hRft87rZ8DApDEUoc/Gmgc0rYosDsyEwt/V/fG3ITT/6tmjipkiNSAku
	 b3FWDEU5QWfeMx3PH9Qu9L5wNk4k31IUM3Xr/AhD2a9ccYxnl+kVJ2C6siSWukerUP
	 dNGp/RFcQ4Bne6eoV2X7NyqFrgdvUY14g0CvDTjuyVk7VA1Bx4m8cSVQ1uEyMHWHNQ
	 ywbWwYCLFQzWuPmDTlpoYGdxvuG8q4M0JO2BBvl2Tj/7SJLMZcz3Z9aPHLupoNE2tF
	 cWxK9IkO0/8dHVev8zfpzHWzjn7wgxvE+N2++mQNwdJr5+SL0oJWBqfcbNkCAHpsLf
	 ytHr/k7g5aGUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 09:48:31 -0400
Message-ID: <20261005134757.2955234-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100516-threefold-charter-2aab@gregkh>
References: <2026100516-threefold-charter-2aab@gregkh>
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
[ sashal: adjusted context in dce64_construct() for missing debug and configuration default assignments ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index bf72d3f60d7f4..6a5c8a4cc32e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1354,7 +1354,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

