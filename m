Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794412577;
	b=1NPc5iKF2S7t+ZD7iLlDUCg0tgWGqdQ1vatFXHDwPQd5AxFWCWcoJcyZrFAaxYXp4Ikk
	 /7le9HNv31Gty1ssFdRcExeHk77SjemWMuVYZm+dzEfZBhLYI8oIwXAg5l+cY482p4uN+
	 8GNXsoGsFZlXmtvwBVdOM3EdAEXdtpdBJl0VUqgv0Uze144EABXmbGsHjsTA6nNG6xSrc
	 usUMstrn1tPiba6f5RiRtK9yW3c1nS5IGV0mf+dLWrv5+VHnYUxPL53GEhXo1paLeMmNI
	 CFen/HADAr6LutwcUZ8D0wdEmnwDhOP61qg8iLcOQH4AuyPhoEUNIROLej2nNidIonw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794412577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bfR5s/ycixQBVJuQOIYi2xKL6uNx7WfkTC2YzEj9kjQ=;
	b=xf8jTn0XGREEusUCwKfK+E6SaV7ZVrbmMnA0U054ynhSJud28rydlsjCIJuC2T85CT/N
	 OmP00S4I0Yrf7pdnKDqRCmx0oDree+5u2mAZ2HwKS0eMeoANfx+eKEz4vufBeymO5QA9G
	 +BwZ10yDZO6dglkM5Qno2fFIjBlNi9x5Hf59tiqSw7DksbcZu7cEiL2OzgkAX3P+449kI
	 bnNe75BzyhdqCjyUQld3ciYC9Nzi/d7pxtni/AWK7QzMT9HMdmopOLWgc4U7J4QORrjMb
	 3zDmf2v4H8aX5g5aag0UACzIO6U0f/cKVMmMcMh4xtQIJOWnOquVfb1r77YpB45Bfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbkJ7WwC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F882606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbkJ7WwC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9301F00A05;
	Wed, 11 Nov 2026 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794412577;
	bh=bfR5s/ycixQBVJuQOIYi2xKL6uNx7WfkTC2YzEj9kjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbkJ7WwCPLA/kGGWgZXVizeH0duZnJilNsrQvYhGCT2oikfEdv+deUK178NIm2l/5
	 3JTio2t99YiybJ4l6qKRO6NJYlho2e86rQdZcRYLWaoeUvhra5QlRMC1tSk6moUMm4
	 QrPhgnZ/9AxdJXJ5IucMvYA+kRMqH/cS4jBDd9f530cv6oNmQ360trwR3nhIRzUt9B
	 Mn+VX4E62Pj0xRms67CMuNy7fctnW/0Jbiv8kJZG2wuzS2/Wo0qeLNbPlVF5WV7iVq
	 ++m1/XiUQ9Z5lGA7CltFaJPd9HsnjM+1m6BRzzT1DV4VwOGf68Zt4Sp0lNnHFzMnrY
	 1sAW8I6XapzUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianluca Balboni <gianluca.balboni06@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Wed, 11 Nov 2026 10:56:15 -0500
Message-ID: <20261111155559.2762573-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200112-failed-7.3-1e73257dff33@kernel.org>
References: <20261109200112-failed-7.3-1e73257dff33@kernel.org>
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

From: Gianluca Balboni <gianluca.balboni06@gmail.com>

[ Upstream commit 1e73257dff33ff851af60d5bb00d73893a8b6dc8 ]

The HP OmniBook 3 Laptop 16-by0xxx (board ID 8EE3) has an internal DMIC
connected to the AMD ACP6x audio coprocessor. The BIOS does not set the
AcpDmicConnected _DSD property or the _WOV method, and the board is missing
from yc_acp_quirk_table[], so acp6x_probe() returns -ENODEV and no DMIC
capture device is registered.

Add a DMI quirk entry for this model to enable ACP DMIC support.

Cc: stable@vger.kernel.org
Signed-off-by: Gianluca Balboni <gianluca.balboni06@gmail.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20261031102136.24600-1-gianluca.balboni06@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Adjusted DMI table insertion context to place the unchanged entry after 8BD6 because the upstream 8DC2 entry is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1be8504571ad3..96b0bfeddc061 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -745,6 +745,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "8BD6"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8EE3"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.53.0

