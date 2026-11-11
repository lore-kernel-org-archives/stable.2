Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413493;
	b=XsSpbmaOTJ84w2AYbmI/4uV090cKyk1/jkitotp4C0scGJW/yPrw2Hy81mqGd/ESCatk
	 U8b5E5lRq9EDXGV3Dg6dU32umiKF9b4s5mlhdcpei65stDmGMFh2/sXK1H8UqtR9qtWCr
	 ldhCofq0h0LDNr9lE/hWcTi5nDNql1QXBzvv7rDuBGkBdCzb92DWDImXEbgt9i+TpWi94
	 QQkIGOimq6G8s7fDV9UQXMuRw0lxGKRNzGt9CdhDjpZiFj310R3beGPTRVp9+t0oUnUKW
	 ftNVkkl2cK6NZl8z6eci2icDVw2cDyheJ3YlruAnpppF3AfLk4pqyIwvZrh/c9U4F9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413493;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pCU77ScjUqG12A4tKj4Ik34Ym66i1u2AaOjv61gzeJI=;
	b=aUsKujFjuW0naROxK1BanKXog1UbqrnjzvWE0lmXrMi/UpHIEt/Z4/XcQSzLfD9dZCQH
	 ASyNa6BtZxJnRzez5b123Jfv+72hxWSpEDRDblUqarC/rEva5f9hfoikKba5HwU3c9xlx
	 EOFFHP2HQsV7A21rQROlLUhEIOXqODNbLes7mt4L9nN6/sSRVXKDdggU1lveej2SNHnSb
	 VW1V5nda7I6tn9TiVJ1BcHywo4rizZ4u5Wfg9pDE5cqQ9dYNGNJxmNTEShSbaItcXPyvN
	 DgVo6vLMPkRyHBa3bI7rwTm/xHcGJa5xYzrHh3wFyp+Ee/Nd3v6xaWdlRtuODVc9X0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne0vT7Jh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E685606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ne0vT7Jh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F511F00A05;
	Wed, 11 Nov 2026 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413492;
	bh=pCU77ScjUqG12A4tKj4Ik34Ym66i1u2AaOjv61gzeJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ne0vT7JhRCf4LqlbKg/+C1MhrctrLwlzkjr1sWWyUz9KY1kNr6lDFrqCmlwSHoqIj
	 MQP9sYcvr/1Cx6XRR7WILB6mZZpV88jJfavT0+a3GMOQdKIu/PRHsx3+FPpuYYGbHk
	 JkLCowLZ4fhKkmpnHfjuBmYlBuQdLwF07V9mit/i74dx4yLbrX4RwTcGMJnPFZtaS4
	 l+BzFOC73cSO/PLoc92tLVqosG4zGDeSm9Vbr17WES704rzu1S4btjpNvlsJN3k2aM
	 T97HuaVhBeJdW66WbxX64R4XZ497AEa2goMrvQc3uHbTEFp35icTpotKh/0klv55Of
	 Fe4/E1AdIqy4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianluca Balboni <gianluca.balboni06@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Wed, 11 Nov 2026 11:11:31 -0500
Message-ID: <20261111161109.3157277-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200238-failed-6.18-1e73257dff33@kernel.org>
References: <20261109200238-failed-6.18-1e73257dff33@kernel.org>
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
[ sashal: adjusted insertion context to follow the 8BD6 board entry instead of 8DC2 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 209ac43f9e31e..f7507446494b1 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -682,6 +682,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
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

