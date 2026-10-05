Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977412FC00D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187638; cv=none; b=reUANeFHwSTpx23P+91xCJRC0Nxev1MCES81S0pRVGcPcB0+BuLs/fcjM5ubNRzv6Os3xwHQP4xiLu2LWjVWLR2OSxdOPmTiiK0fx27rUvWKOD4D6AhTUxhdCZUSVleH5lizKOXdiFFBQloHuGYh4qyDcStd/S2wypi/wQ6WIgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187638; c=relaxed/simple;
	bh=+vrNx+j0/B91rKK3SOpVgetPdL2cs5UKt6+zTIFR0j4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tpv4b/BKHUsdD9ylhf7iQrVlyQESXzFDvyypGAKZ9yZXb3XhTDAmklaH9LKyJf+551u7coezEcIFziJLj2OtGJKhqtoyRIvjCoatBqlgRA++mu3y6BYzYJondDkajr5L0jU9UGZuUCUR8p9H5VemI2okD8VwCZYMuknj85rolRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTXaI6u6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTXaI6u6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA251F000FF;
	Mon,  5 Oct 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187637;
	bh=aOmM1q4Jl9FqE4GceAzubj+BIKZ4dy/g5FYK+nLMaag=;
	h=Subject:To:Cc:From:Date;
	b=bTXaI6u6WFM/LPq4UjdA4KQE6HY16Hx4rvnLcF1kOa8g5UxofSvCC+3v+kwEq/C+V
	 YX9HN7oIWaIYGfEypDwRwQwx1W7YIXRO4xTEcz5tSo0e4iF/VY417AV0lB9WBqPmhk
	 QmIxH+Ap/THBW49EdBzNXBV41q2MSSGX1m36lNhY=
Subject: FAILED: patch "[PATCH] drm/amd/display: Mark DCE 6.4 as not APU" failed to apply to 6.12-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:07:14 +0200
Message-ID: <2026100514-expletive-duplicity-53b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 3a52d587d1fc8e8bf94ba1b07374f7ec91aaffb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100514-expletive-duplicity-53b0@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3a52d587d1fc8e8bf94ba1b07374f7ec91aaffb4 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Date: Wed, 23 Sep 2026 14:20:33 +0200
Subject: [PATCH] drm/amd/display: Mark DCE 6.4 as not APU
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 8612cc66a6ba..65c7dae3ff66 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -1341,7 +1341,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 	dc->debug = debug_defaults;
 	dc->check_config = config_defaults;
 

