Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048170;
	b=Vy35N8ddv0sXbwF8Zbm8YfWtTFUE88IGj8eOE1b+J3ZGk7THj5tnCd/nykjpRCtgomJu
	 sLhUKSUtuDLEzcqRnx4pGv9ir2z8PrmoYDtQM0nz5EVrcMaKf1BtMS22fDOv0AHz33SyS
	 lpswr1iCL1DgYt4/mKzWtdLgkUHVPSdjxN+JnKVi2EZjRKNH6XlgLHA48OrHM8wIIol5A
	 XwRqTGY7vcYrA6vw8QKLoagGNyna7xFvYksoXQew0+MXfcqHFDyhGHhbEAQiERzMBHSu9
	 L5LOLkFu+UZ0ItK0/acwlGigxyYLQMlAGRtKbBVq0Ed86J2+ZLyH7BpobyLcGSjOZLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ErMxiKjlUd1OkFge6O39ftgFqVjlYSMBtfIyBFyixlQ=;
	b=dsaJF4f2CU7TpDL7QgqMIeHKuxkPfhmyVvO5H37yNimgEMmIWLkQqvhQGCNpsf57yK1m
	 GQVu7redKvJ0uzUZsgN3bv1fNoKCmZL7/lnCUwUKO+Uz697lntX5EZ7ov1Nc9yh9VfFrG
	 7HU/BYp0H5YR8nyc84nxfFNCng0d5UqPNjvRLHelze1aHj5cHAd2Sr3vRzyX47vLkmofV
	 iCsUF6euUAIq94CBBtR0Jm4gBclH2dH5viFYZ0jTJWmnHGUQxtBBWYd41S9jiDebk8BQj
	 GcID5XW0t60vztSBxlsMe80uAqEYT5kyRhlr+0B8W7XeuJrLIwjWAtuc7gIbTC9/cWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC3YDVgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FF9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NC3YDVgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37DE1F0089F;
	Sat,  7 Nov 2026 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048170;
	bh=ErMxiKjlUd1OkFge6O39ftgFqVjlYSMBtfIyBFyixlQ=;
	h=From:To:Cc:Subject:Date;
	b=NC3YDVgAFHKfxDw6yYar24ncZmVIVxVHEjPq/iYkfUAV/X5CRvDOL4j1736ysJc2Z
	 Ad1vPdWoWGITXt8DZiQtbXE3s15wGqiegFrCB5rWNS16/ZGpOwKhXvBBEpUZlDoXIt
	 +U5/NJrKcBB/Ro9uSteTCpD6sfZBaGmlRN3jpxP++757M7220lfzxfR5A4c3p7qMOM
	 QVAdRD1nzGCzs/eLjTAu/O0ZGuRiNuNzqn91WWinQnLqO9Vzu4n+aHFJKVjq2YaQmN
	 0lvJ42Rk6l/IAj+TZ9dPls3o7IrbiqLccVKnZfcPxoSgZuqZgBNE59cv16T7XcTlCD
	 N6fIKCClU4OjA==
From: Sasha Levin <sashal@kernel.org>
To: casey.connolly@linaro.org,
	marco.mattiolo@hotmail.it,
	neil.armstrong@linaro.org,
	david@ixit.cz,
	linusw@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/panel: ebbg-ft8719: Set prepare_prev_first" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:42:48 -0500
Message-ID: <20261107054248-failed-6.1-4eeeac9d7c36@kernel.org>
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
git cherry-pick -x 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054248-failed-6.1-4eeeac9d7c36@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




