Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2C377A9E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187657; cv=none; b=KDR/di1qRzyOtitAPYBQSO6r+aRvKD1HJepDBqtUGxUeQnrJ3QsQYOpY7KIo27AXc4j3jkXJX3SUgeJvsySLns5EJHg3cRGMMVG0Dnn+4RlTjBSYalti2yulxZJ8w2Twqe3AB7NzV///IZunCF+LQ7K2DFF/fyaSJC8UgN+jH8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187657; c=relaxed/simple;
	bh=6NbLxmzv/VTm+QQxO7ZcuuDHmL7Mk79PYusHs6mNtBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cXrFXm+PtfIpp2BhhpGNuuMhqIDBdUwbFXlM9laRAwUAf0qWqymZ91yhR0tj7v2daFChYg0+jayNc+oVNeRXhwB7+njWnEdyVJBoHrB1hco5EiylGcH+hMNteD7uwB80dd23rwcJRWnPkK3W1h7z3k0d2SWk78bK/QL49IA/dHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fN7G3ml/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fN7G3ml/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C0E1F00893;
	Mon,  5 Oct 2026 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791187655;
	bh=VOE/KbBiyqrOPgwpI5n6Hxsd5vwOVXwOLi1Il9SZjm4=;
	h=Subject:To:Cc:From:Date;
	b=fN7G3ml/XPeQzZzzozFMzrwaxHH7pnhYFVX4TraNswZgKs6+MLrHqoph6bETtiUHk
	 OXqzKO5VZua9gpWjLpNqp07THi2wFl+TrTOj/Wg/2oryfTB+FRG9UAk8QHOItywjip
	 mWFF9R6V5wvuV0ub0PoMZKyvrNS6PRF312m7j3Zw=
Subject: FAILED: patch "[PATCH] drm/amd/display: Mark DCE 6.4 as not APU" failed to apply to 5.15-stable tree
To: timur.kristof@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:07:16 +0200
Message-ID: <2026100516-threefold-charter-2aab@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 3a52d587d1fc8e8bf94ba1b07374f7ec91aaffb4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100516-threefold-charter-2aab@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

