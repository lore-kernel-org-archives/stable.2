Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D5841D216
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206052; cv=none; b=sBHhj3BO5PRL0HXoWLnCfC/QnCJU3WvLAP89FbL/zPa9uEpEidsX5NfNvt0owvVw0GtvQ5rZV1lPw7Wo7TpXMTMBBjDkBmb6JeVtAJ36t351rtjs/jYRBh+5ELwpZ1B/51tXOJUet3U33M78EnFwGWhyyS0f5s5NH5LXDaNxREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206052; c=relaxed/simple;
	bh=5vWt0VJmM70wjDbP5wEkV65aatlNMn9IZN6WWYIMEPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pVdWdBNaxoz2rL4sV7XyWh9yea7dOFiHp31SC2WdV0EWQamLbdKtBy0wXoqWnoD8GmcQ0t+GtC/keQS4Drz4qisMd7GdrnecIiT71DmR9qadfx2FctWi/6XdAcA/MYB1mA9Tdlq4YIZAYfW5awpKv5Z6q0YBPzJqgeOaU9badVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZF5vVST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZF5vVST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45EB1F000FF;
	Mon,  5 Oct 2026 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206051;
	bh=gRM3n+KUJ4S3UWv97lwpTtkiCRR/UhznQw+QTqCTJYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZF5vVST4Yok0Hr2H4tb9sT19MVdXY6hh+ee19ngoLUnb6K1pz9RKKbNbY3gKNBBa
	 Q+O91fp9H9K7r/+svEmDKiI6s9dwKh3aNEIBw6BLhKO8d214jzZNTWLMpIi1tB9dia
	 biEDNCAkpiDxWEAhaQK9UO8i24yjygSxaU8MpnI+lB6T/KrizxIYQRrSoC8PpK4LSe
	 /YRA5bmX2mOpEGJDWb3oj1UosFpLJwDaug/Idn/XHztnuZz9V0slY7yMilD2CgDChY
	 UmRJ3kBbHi+srQhYhy87SGh8z8aMWHCvlyiRR4Lh1SMpUsZZOc0HpLxsk4bXeIKU0g
	 3FHWF+u00RnDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 09:14:07 -0400
Message-ID: <20261005131343.2491482-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100515-snazzy-basket-56a9@gregkh>
References: <2026100515-snazzy-basket-56a9@gregkh>
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
[ sashal: Adjusted context for missing dc->debug and dc->check_config assignments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f75144662..556c453666a74 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1355,7 +1355,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

