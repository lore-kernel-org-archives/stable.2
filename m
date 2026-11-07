Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047412;
	b=xm45NA+a6CVN3fu/IW5WNJZrn1mbX8LwIarbJivCAkqCen0e07N2jHpRU5FYDbpYbwqA
	 T0S62YvF4T2URDuZiKGwb4jLFQ27622UwQQIJNGFn7S3KQ+lwJlAbL2NX9TSKJHcmIVMn
	 sDnXmzv/iLnTHhqWSj1kmh0OEqbRn5lk4YEkL7tvqyWNiV/YlRYimQaTkim+ckYlpRWs7
	 ufUJVxVbQBeZBDFbkt6HfTm8q3NMWDwI4/Hg5IC5oCPeA+S0klWXyjlCGBM9fBvUYsPrj
	 o0xivqWGabkOrYvyyng/jZKGZqpTi6N/WlKNDkL9Eo3AXxc96iGtujhRGxd7S1EXdWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047412;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0gMg57WHHs6o4ZycYyHXqrS1bsbqYCn9ysYNY98VO6M=;
	b=ncsCotf47ynbM/3QQOmKe3+8LGINT/YVJxYn6KpJi4QK4D+F9rB3WdC7slvCAVig5zvr
	 aQgC9ceXJFUvzJKeumWkxKRRRvZ4pon6sGP6c5SqsInyGs4xhyrAqoWXWAIClMhPpvdZc
	 kflZ0pO+Rqdc/lGLghF+SM5Ib6DkOeb21IpY1vyBSL91pvRlTGtGxCrqR4o1VGXsN1yAR
	 n/KrgAaLG+dOlC5M0r2IgycEwQ2h/hVvOGzE5VOM/h7x5mfphVVH183KimPvXRsVAUfa5
	 cgC+YajjZcHdsU4TMGaPqSlwr+mJ5OqqMdu59FvYeFvBXV3T3UGVE4YZGo3GWwmb6VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbU6FQIW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD1606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbU6FQIW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA051F008A1;
	Sat,  7 Nov 2026 10:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047411;
	bh=0gMg57WHHs6o4ZycYyHXqrS1bsbqYCn9ysYNY98VO6M=;
	h=From:To:Cc:Subject:Date;
	b=BbU6FQIWMV8+7NwP07j9MkFFIK6bmaVb0QSIzPicQLlgMAVfP4/NAqrxZrLtLM9cl
	 KJ3OxuCXjhGZ1fyV9jJJ2xEkDNRYAf7wLsbla2oj/G0N0kGFrlAwoz2LmvME51Me0W
	 +JQGUYpHCNkflPWClU5cNBM/mpc0LVpNMLFRJLx2ceKZmopZrrS9uwOxJ9zbKt5KHV
	 aqBrvkBktnJwqU3tbIrK+INE5ALMkh93J9gZFeVkyeCZQ4+nzGldSje79Sf5rH1hV9
	 RRSYSoTvCbi/H1WJU3AyNUZXerP8pMxqyvqloLkU0wKQdE/5xQzQf+gXmRCbZDrmyB
	 8fBztbfUUChgQ==
From: Sasha Levin <sashal@kernel.org>
To: casey.connolly@linaro.org,
	marco.mattiolo@hotmail.it,
	neil.armstrong@linaro.org,
	david@ixit.cz,
	linusw@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/panel: ebbg-ft8719: Set prepare_prev_first" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:30:09 -0500
Message-ID: <20261107053009-failed-6.6-4eeeac9d7c36@kernel.org>
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
git cherry-pick -x 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053009-failed-6.6-4eeeac9d7c36@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c Mon Sep 17 00:00:00 2001
From: Casey Connolly <casey.connolly@linaro.org>
Date: Tue, 8 Sep 2026 14:45:02 +0200
Subject: [PATCH] drm/panel: ebbg-ft8719: Set prepare_prev_first

This corrects the host initialisation sequence so that we can send
DSI/DCS commands in prepare().

Cc: stable@vger.kernel.org
Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260908-ebbg-ft8719-fixups-v2-1-5454ae1f5581@ixit.cz
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f2..1ab09c50a6306 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -198,6 +198,8 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.53.0




