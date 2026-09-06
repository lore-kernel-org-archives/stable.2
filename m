Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088023D3308;
	Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788700754; cv=none; b=aQFHSyW4++9X8ULohDm/5DTilX2y2uYOEJK1M2pWqoOnytH+Sr2nYd5ZbwjORN2j6AeZGX7JDmpVp5EZ7TlraTZQMLc0Q60pTPwswdrFgAK/ZMD0gp5bRvn10UBEti3IiknSAsEMv4cvYgHYMO2bwVKukhjLgRX0ggtMR9a5+hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788700754; c=relaxed/simple;
	bh=kNVsV8jEUDBx8YJnZ3D2TG/jephKjsRz2aHGkVRdHyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTCF+8B0uJT16euPfCcoq9+mnkwuTk2/xYSVsBDG7DYPI2FO9V5Q/y+b4ma1hojbJuPqQqqgXQ1ojPMmTtgA7Eg25uO1RFFlEhPk3zQPvSUDHYzff3C7UMr9VKvayDy4bpxBMT/0ipVIrVopvKS8H9+8uMj5+S/IY+2GcRzztEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q2jRVWxL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q2jRVWxL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96DFDC2BCB8;
	Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788700753;
	bh=kNVsV8jEUDBx8YJnZ3D2TG/jephKjsRz2aHGkVRdHyY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=q2jRVWxLoaqHVInd5vI4zZO1ZcB60SvCJy1PrwphLvIPHde2vEkAWfsVvg3u6TfK2
	 +N6KzkdINtxC7NFtBYgAxLT+BatYZvjoS2K/lS7n0y0afAIb7kP1G33kYxszxEilY9
	 YTcW5vwZ0+34eLYHNRF6Mbu8RCQ48eWFn0rG+taTKty8NkrZnG+ZVjDHEiK5omLuyk
	 bp1A614v2vMQhfqRGW7+letSkeUUzYZpHDKdNTE7PoexrkK7CidTHXYDQgD2zslEYQ
	 vTfvgTGfZn1I+C0PiRjcvMzSG7EWY6C1EFvPJGIM3dnOB0XdWBOqgcvcJA6GGi+pXA
	 wc4S6NQVtE0oA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD2C79F99;
	Sun,  6 Sep 2026 13:19:13 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Sun, 06 Sep 2026 15:19:02 +0200
Subject: [PATCH 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ebbg-ft8719-fixups-v1-1-4e846510cad1@ixit.cz>
References: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
In-Reply-To: <20260906-ebbg-ft8719-fixups-v1-0-4e846510cad1@ixit.cz>
To: Joel Selvaraj <jo@jsfamily.in>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, Marco Mattiolo <marco.mattiolo@hotmail.it>, 
 Linus Walleij <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 Casey Connolly <casey.connolly@linaro.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1210; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=MdKS4MaN+wl5Cm+tdhGjh1Y6pdj5edF/ffF4+200w9w=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqnWhPI76LaG4om4ZpsbFRORTnkEMFZ4suxTmK5
 QUqeYXA9JSJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCap1oTwAKCRBgAj/E00kg
 cga2EADLwprPfozo4mnQ3SHTqkt5yXwlnKlXeLiAuz3rs7kylKD/ov9rwC4F9et4v1qo5i9d5Vo
 bQ86yjgrFQhjW10D/8T5tgK/r037RdK2WMNtlj4j8yqIYOzepyZ5DSyo1tXTYSf7rtdgoXfS363
 PsuDFzL6GSfairKq8AbzjgyCRuZg1N4/ankH9+1vYBP5Z14fAmo4jnEJgktYWK7gK4DQWb9zvOb
 U5XjoyVpfjO7pXsHgwV9ejQ/t3Pz5dZspJCtDSLywJl+v0qNUnPwDOJv7pdsKLyuJm6VZyGDFjV
 Cgr1U1jO2rB72t59pCQQU+0uRux/GafvV/IL5orsNLxrf/2Pi8gjYcRWWG52FzWzjiSh2CLCbg7
 bzGIxDGxHJVsfXXgC+WgXnrqb7EmIbcppOCvXggTSJ8fDPC1a6AHol5SxyZThGXTIhDTWND7rrw
 S8oX2llUvvtPMXR5nG3vtd2y+BByn4E0Xg13NG3lsO5xtRHGxN3EeFx5QnnB6Tkr/0tpf+SjwBI
 GznskK6hFt3ABwr49l/yFzFtJdYCp0a7YIQ4J/XEPwxqvCB9z9RQUgrQkf7u+8NdsPfQmeXyTXV
 m02TQhR89R6SPmvkhfKwgHHUipoRuiiisBxmoth875tFgRXhCPswQPB2WFIbVfhbvzlEJmyKRti
 WeFbOiq9oK3gZpw==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Casey Connolly <casey.connolly@linaro.org>

This corrects the host initialisation sequence so that we can send
DSI/DCS commands in prepare().

Cc: stable@vger.kernel.org
Fixes: b00de0e237da ("drm/panel: introduce ebbg,ft8719 panel")
Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f2..1ab09c50a6306 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -193,16 +193,18 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	ctx->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, ctx);
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
 	drm_panel_add(&ctx->panel);
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {

-- 
2.55.0


