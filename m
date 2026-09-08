Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75034A014C;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871504; cv=none; b=Xfdp6VU8+C7WYzM9kJZHTnCE6/1KwVA2eVrzdOmtf/sG4pspkhjWn5nqLFBL37+TwvTgtyv5cH+c5QOXan4jZdkEUns1p0Ed5tUYDF0wNU+g1UgInOmDQM4m9RpiO5wTRDAvTxE4pnmO16Ua/+2dbt/2tU5BXbu3ls0DV+uQ7P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871504; c=relaxed/simple;
	bh=VFryqqzhM6lSSy4pdb+U7EIAsRSleqEPMNVWVeCSDEY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0H02Cyg0+L0H9di74AzsLFO53J7M2dPxyx6LC7Ay4FKpWhdS8q6ps5HONHQd/nfNmQKCd4t6//QmsLHC43VoUYguCLP1SEuQefBMBP8b/XctWiIyCMr65WbkH20xUuXDHN8oQ65dnMNWuUwjGn7QpY4LxqQN/gSTbfZ8bom2Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afWsrmjO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afWsrmjO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 751A3C2BCB8;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788871504;
	bh=VFryqqzhM6lSSy4pdb+U7EIAsRSleqEPMNVWVeCSDEY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=afWsrmjOmN2spwI9V5Gq+ptION1ON4GzIJVcRHD+Gys4Qp0aQyyRyGpDNhGNTMe3K
	 Cep5LswnJcUhNv0B3ipisWUwcyjYZeUQpx7TvpUXLNkqVLIvF3j7Atqg8XCCNe9K3U
	 SK1WA7giHIz07OQj4BCggJb7xg68BdQmOVmo4zoC+PJkQt7aeU1TBXcLlpS9SylVI9
	 flsVO29m70PUCXj57E8vaAPjiUU1vJXeo3iOhDWzGwG5NIxgPc6nc37xlEKHwMy50j
	 3oLe2VCifwBMvw/rvWdh/bkezFom4CeULKobni32lN+6HhRqchvRl0+Few02bF88LE
	 h21ZlIebIsHpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC2C79F9E;
	Tue,  8 Sep 2026 12:45:04 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 08 Sep 2026 14:45:02 +0200
Subject: [PATCH v2 1/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ebbg-ft8719-fixups-v2-1-5454ae1f5581@ixit.cz>
References: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
In-Reply-To: <20260908-ebbg-ft8719-fixups-v2-0-5454ae1f5581@ixit.cz>
To: Joel Selvaraj <foss@joelselvaraj.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=rkKe1B3w8nfJnM/PyCVxhpwlE8OgOguOydHVF4lcyVc=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqoANOWhebknUywxD5wXoUqrrutGzcfC1TSC2Mq
 SrOYSEh9xOJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCaqADTgAKCRBgAj/E00kg
 crXcD/43mQI7xN9miQgoykM1OpJnWuQGafBFybMVjDZFyfkt7CTMOwFv5FpL1r4/pFWXQodJnWe
 sPpd67/FfM+fcYokvSJE5a8ntXH1Byy+ydbTCtGN025m2+RPndkBKuthCOvRR/zDc9eCQ0mZmbs
 EbfNd2X6f1GwpAahLHoHLJ4lblEDTTal3aoXEjn5NzMYFGlKhmDsRp2Pt1o3l4rnEjNnS/r/ckC
 163s/4qNMyRcqmJ+zxpxXcyXb+t29j+Yxgg2AjIwQ5+Nbx4m/gwIRdABebKIzgBlpNC8Y4geGHp
 Zm+uRAw4udaFkIkquEyJe0ac31M6fcV6RE2iNjYgZQ7NKwS1qvLPGTDuVd0/6XrFXyKzFecAgxR
 HadSlAnvPzRIVKSuvKqlfAGbetGQf0NxEFzbG50EP9wq0EPP1g7/R+mWKX5AdmB+90RU8vewyLO
 8pR/tpihVs2uZUR5h6au9GZVkFVBQz6HpJf8Z5155L2MGVOYWQ6sqkGU1bwMWUnfyiz+FofwBqU
 IVtrIm3ctSVzz9elUXCVL3MfOLkiYO0cwlvoFxSzcSl+dYLogNjyXsLH6fKnGYLK4Cwr30EMDcm
 qMFs7q6aGhxI3ovBV7iBbBNVLvwY8Z62oxyCoG9076APn23uEN2/VsRcjarLkez9nRak5RwU5uV
 IWn6n4jI+fzGF6A==
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
Tested-by: Marco Mattiolo <marco.mattiolo@hotmail.it>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


