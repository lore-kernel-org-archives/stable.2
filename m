Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414231;
	b=QShFh7f6S5nEoxGDsKBES1y1hcx9HEP6+w4d1acFNCvBq6dSN/7W33i5xdGwCsLLpH08
	 G0rRLyB5gmp7PL9f9IITg0e/1lJ/2DBYi7eojm/xg6mTw3JYsaj7qm+B5qteOg3ekqMay
	 23BzaMt/BGfwhALijTDhgG8jhmz5urpc9bx82yUP2dRKT8x5piBGBkr5kLxSA42oMjhcJ
	 MkXNkr3wPClrXuYBvfrbKecFGAuB777JE9BcCfV3JGeR/dQi05hVetoMZpjYclConXg/S
	 LSzZ/fD/DR0iKDgswFwvT6kOWrdx5go/6wZVM75Nu5AeGsTjcG1CQih/TV+ybiX3osQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414231;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ObskzAF90YWWNTGr4wp+N+K1trizKfyZ/u0WYKPs9uQ=;
	b=f5Dq0fyuqoD+s63LMnfIp6kmnWz8LD5B0+YpeqGG42TBrkP0mdzJJWrmy2ULmin6s6oe
	 4XmOOz/49rwg7iXKr5g+nvb6gMdXkrHkqQwK+aO1H3cj4SeVkOjDA5FEfRIH/0gTni8KK
	 QGNymtm8ZMqefJS+Zsi5ZTMnb35E5ahykp66/gy7P0pkqoDC6XL1DarfN5c7tSUnZF65I
	 HZepYAzN3HEKNRvPaWwgVpk/El/fIc/EE0ET63u6S8qdah99x8T5v6FsiHKyCv54/nUHh
	 Wq8DhZnCF/Vk3Ays0uEsFYePufVRfyUGUgH0g3NH63W/gbHbYKzrAO9UYBCBM/F7NHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRJR2E5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36589606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aRJR2E5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801C91F00A05;
	Wed, 11 Nov 2026 16:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794414231;
	bh=ObskzAF90YWWNTGr4wp+N+K1trizKfyZ/u0WYKPs9uQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aRJR2E5tSc1Pgz0Bxgsv/pmE9QpChobDgxffmP8NVymVb4nviMtyI1h8f89OYiCEI
	 ZCFr6fTYHaVBlH3lgT3Yh7+QpnPIwnieliAkP12KM5/nkofEXMZssHnDGOAeq9IkSf
	 P1mbosG8yuPucGKbta+DG1Wij7o2pZ+iILYZHfa+dfKvqe+1ibcvgEKqOwZJd2UlHl
	 zsMZaMOBCP1ZHuhiQ/oLiXKzjFplelSeXctAu/NantNrEPBB4q1wczkTkVFWgoydhN
	 9eHZUkf5z1DyHdUfGYJkr2UYR52El7tmMJwe0b25Bij8VxMAE7ZboazGbjkbUiEQjc
	 bDFRA3b4mQ/sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianluca Balboni <gianluca.balboni06@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Wed, 11 Nov 2026 11:23:49 -0500
Message-ID: <20261111162329.3267306-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200634-failed-6.12-1e73257dff33@kernel.org>
References: <20261109200634-failed-6.12-1e73257dff33@kernel.org>
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
[ sashal: adjusted DMI quirk table insertion context to match board 8BD6 instead of 8DC2 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 1aedead0a9275..4a9ff060ebbe6 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -675,6 +675,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
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

