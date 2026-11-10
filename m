Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283281;
	b=4TQ1UuGwpt7UkU+cEHoYTqMMBmloTOConGSnaGMJ66cEhUc9bJi7BHcCZRPHRa0BV/KL
	 uNXKAxYLTEZCzpOdqcEkU79CMfGI9Kv7JvGMTFSerMHujg5PzFU+aHlf1u5dCPmr1gV/H
	 2E+TqMc61EHum4ImW4E4i27usTLUEDLtk2cFVEYRc0QxWfZyLnRXGMH9050aHIxt4udDu
	 mm4x7kLl3+Z6UFXXH9n+puMpXg5nsfQ3S5gr4RRl1bltQjM4RDCZF0H6Y2PpgvaQQFRuo
	 pNAOdMDnbqwlsxy1b7OtBBZ3GFhuLD6qxlVCcf4ANUCHJgD4gB6VUuilha2in1+r/kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0AP2dwxK4MusiI9zSZcE2L5hRHRtFL2+nXB7r7LjIE4=;
	b=VE7LBN7Np3UpbQNmC+IcwgFuDBKQ2bZVe0Tc1JmW3lhkJsHcmGqjViZ7Zp8shPeOH0p8
	 AoNDMP4QePyvsUSRemACYz/8nCxKo8AB3DcVT2IT6WpGrTcRoDldaSgnJDKlifykrdo1V
	 oEbzjr98VLCWya/xW07pqx/kBmdhUwVaWvktsaIvqhOJ1QyP4O/DolpuVCL2QdHYlAoUe
	 C07qmjkz4cRHrhxLPN61eXsegWDyJRm1iQWY0bazrPOR1SyFWbWhmgE+FMlL4ZLQvJGcM
	 87LE4P/KwgvLieMluGazd7ffPXNbLubdhzKaVvCJKt5Lgcmfx5OTY37JnZ5DmquxoIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIfEazmb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A3606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIfEazmb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DAA1F008BC;
	Tue, 10 Nov 2026 04:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283280;
	bh=0AP2dwxK4MusiI9zSZcE2L5hRHRtFL2+nXB7r7LjIE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIfEazmboo6oIi2ny6x0KyjRi1EspSqx2aKjr5OXcOMy+eF4e5laflIlZM6O6BfZs
	 yDvqpwqAhcAtMmX/67gNvaliv4QXwrs0iBUSYv2endXtFo2Uf7Exw617OUNlqbhe3c
	 +xiAuOsW69LhwAD5Dli85ixDkgRYTHRDE5PcJT4HphhGRJTPBINLpKxU8AJDPHXs31
	 0II4KTB8+W/ldbxLjsbmPN0krCWQWjgyEfl3PeH7pxa5y3GAGp1CaRRgWfVEVVEPEu
	 HHMqCOikqeXS5bPLZV0bQXcKdKOkOSivSc3Stqr65RS8fnd/qGY4to6XBnJUyiutnM
	 pJwlcxUOJjhog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
	Marco Mattiolo <marco.mattiolo@hotmail.it>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	David Heidelberg <david@ixit.cz>,
	Linus Walleij <linusw@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/panel: ebbg-ft8719: Set prepare_prev_first
Date: Mon,  9 Nov 2026 23:01:15 -0500
Message-ID: <20261110040023.284489-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110040023.284489-1-sashal@kernel.org>
References: <20261107051740-failed-6.12-4eeeac9d7c36@kernel.org>
 <20261110040023.284489-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Casey Connolly <casey.connolly@linaro.org>

[ Upstream commit 4eeeac9d7c3600a6cae75b2a7bc9c5b67530923c ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index 74b56ee42fa49..c97825177693f 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -233,6 +233,8 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
 
+	ctx->panel.prepare_prev_first = true;
+
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
-- 
2.53.0

