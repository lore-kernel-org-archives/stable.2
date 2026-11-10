Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794337765;
	b=tQnwnD81tKQFwDNn0z8jmQl2+x9/muNmST2cPeUy2q93VhwS6+fch2sxqRGz4eOUryH2
	 a97veRINJN4SPhd0A5lESss1i6zEsjo6rXFwKNcxckV2khGxrjlxlSpzqa27SP89V+CI6
	 wC60OKpwBExD900lCcNXex4yOXjIc4l3KHL2eVKKx0e7+lhlOxqUbkRSJAukJSRgm/YJE
	 xx1FHCIBbUspIUAqgoXvGRYZKFFuKoZuW+gJxaJ0StSiyNcH8pMaWI8+APSIeu/pOvy5B
	 yrMp9W8MNNEVltCT3xP3IZt4SaT0WYzAYWO4O//n0lOc3INFwcPKkxly/9AiajOuccg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794337765;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=EfeEFyop+VbcYOV1Lca4917rwXx2dNL4Ll2Ja0hVQa0=;
	b=GJh/zxl+EnXQVhG30gODAmpr31OURoxsBbfvVcvzP9WicphxtBMfB0gker8kXqgY4ByY
	 +6Rgi30OZeOEsVH86cnwEGwYVBq9rdDlLhU525lsnJxxnoX9hN+ChCEnJh+xV1hxierTX
	 awNRoz4UTIHBWUGY1JAaD89N+6AKrIHy5ljRcy+LvofzO2tDt6fEsPQu6dfFkxwXeMcTn
	 Qf0MRnkCHNWWhOGvmOFVZHqOu6qym6MOW8XI+CLdLmThXWoj1Dsp8XaPHsghzqtt0iyiI
	 eHfqgogc+HvY4xFwaPgl9ig7JEr4D7v3XK+JjOgR7tBgO95+syRM7sVhQf066Eo72SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9WmJLuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45817606A33E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B9WmJLuX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBD51F0089F;
	Tue, 10 Nov 2026 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794337765;
	bh=EfeEFyop+VbcYOV1Lca4917rwXx2dNL4Ll2Ja0hVQa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B9WmJLuXbiApZUitDyh592IKVualo9pl/LMqrp6JSJWMk+MOiORaoTfzuLscF4E/w
	 esCc8nQIpIbcMEZqNt93jPTmWU2pHPqA33fKp5eSdazIFkXK6OypucOyW79QLmwMNb
	 koP6P5oEMEOT87qoOBuwZnGxVlhR5kmko3qWoDFz4osOCpuUdV9kPrZa1fo5KydDue
	 MtV+kl46/NL4dygSeuc7UwvZvlwUj4y7vwB2SWxnOBZdXq2cISbQCuJa2EPxGNXIIP
	 eYzmRXUhKHn5R8s6dj9jwBvtiNQ1vlWftGNEhKMskfDisY1I+0/ge3J1oK8g8VNZsl
	 rh5R3/OaOaPow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] platform/x86/amd/pmf: Add AMDI0112 ACPI ID
Date: Tue, 10 Nov 2026 14:09:22 -0500
Message-ID: <20261110190841.3480488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051036-failed-6.18-325bcc126cf7@kernel.org>
References: <20261107051036-failed-6.18-325bcc126cf7@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 325bcc126cf7a512a0e2da0efddad665f69badac ]

The AMDI0112 ID is used to bind the PMF driver to some platforms.
It doesn't have any Linux side code changes relative to the most
similar AMDI0105.

Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260826163611.2268377-1-mario.limonciello@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
[ sashal: Adjusted ACPI table context to account for the missing AMDI0109 entry. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index e787480f4df26..c1b369fdf801e 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -464,6 +464,7 @@ static const struct acpi_device_id amd_pmf_acpi_ids[] = {
 	{"AMDI0105", 0},
 	{"AMDI0107", 0},
 	{"AMDI0108", 0},
+	{"AMDI0112", 0},
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, amd_pmf_acpi_ids);
-- 
2.53.0

