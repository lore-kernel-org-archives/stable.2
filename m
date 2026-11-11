Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415291;
	b=w5D71ROWFbaQwas0ascOtfol+4aLj+ATawEEzJuWMrGWTFPjdrNMDmQLmBAlJSID2gmr
	 Wmecy/qcAsxynVhu6hC4tE8LRq0AzoTJojcdUeqyKWwiPq4TMGX2gyq8NQl1z3FZtWM/2
	 ReRDebiJE6A6UJGFMd7wXmtdz10wsVFULPWmagzDCkoQ3VE8Kiq90fAzYLLWQsHhJcLcF
	 LdhNQUx4wX10/ENddnZoK0h1Klr3Q30Lhw0fC5AfOt59vElUYhmfzUQdldPRs05oTCXLE
	 VtF2NECK8wPDPHm12CDsM9cFsgNqVh/YDl+PANROanMkwfRUjkaSMesm8XhH/znNdPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415291;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=F3BBIBfUmz/DsZXORfvf4WBzIuaTUqhcSuIt5kAJ5Uo=;
	b=HOzgIdY8fFj+DKwrzhJv3u42C5qD6OW0vwcx0zXSNO8ziffyWsb8NSQBsjaiYkhWB/5g
	 +YtAzx4ysRGS2gs2Sz3hSTKZQ4Lv9e/g7Xlo5BxozGewiwxIzK/+jSkGc+7QO+Tqfw+2M
	 GKF1FLJPwGU2eVnsAxXxnb5cG9H4t2EbUrau6f680j9gXk3XDfRhFSYuSgxyReqKd3kIp
	 0zZ1J6oWJJuJFtMM3RQNrlrIzLbDOCP8tgqQFXE56VIQqC1E0B+MW9mfagG/KvlSr5TbB
	 DT9WAJxId1tebtPWYfEpzJE6kU4vUiBmWNN90fcSkLX4pmg1ex9mKSrtTHTfj8HZ/6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcm6he2Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA28606A8BA
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcm6he2Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E7A1F00A05;
	Wed, 11 Nov 2026 16:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415291;
	bh=F3BBIBfUmz/DsZXORfvf4WBzIuaTUqhcSuIt5kAJ5Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bcm6he2Ysqi1Lx3XvJ+yBNbuGtcBQfNDABnAHE5hHk1jNY484Rt09cL2neAOIvtc4
	 NLsNA4dyr1KbitL0WMhAkMjtToKiGtvScaodjYGUuJ3r0uq8JYBDu4q74/U/DMEw+7
	 ZJs1tULoeqdMi1NYdwXokyY6nTJjI6+ztL0MAp2clmmKhwmRYF/rbpIjHk8jRa9pUV
	 RI568o6V8DhkTmnrwIE6tS7y/nTc48Iowq70+mDKu7mXt0OYTOrgVevaMjcDFg84Gk
	 0IrYsX4b3YplQgXnqBJpkUVz1XWJG+RNJuonAy57Xc/a6NrtyWn2EGXSzhNgQ0FIAl
	 FO7gd4U7+swGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gianluca Balboni <gianluca.balboni06@gmail.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: amd: yc: Add DMI quirk for HP OmniBook 3 Laptop 16-by0xxx
Date: Wed, 11 Nov 2026 11:41:29 -0500
Message-ID: <20261111164109.3297929-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201052-failed-6.6-1e73257dff33@kernel.org>
References: <20261109201052-failed-6.6-1e73257dff33@kernel.org>
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
[ sashal: adjusted insertion context from board 8DC2 to board 8BD6 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 73bff3a22fe21..4b86d1cf3c1a2 100644
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

