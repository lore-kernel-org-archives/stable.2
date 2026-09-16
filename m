Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E684BEE2C
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789567624; cv=none; b=fZjU7DmgkbKwX0T1myu6K2vW6LFGJHAK6Ldi3VYKjkckS1N2NWWpq0nVQ6xEhWzpocS5Obo0f0bwnBPrBKP4wqwPM5bHug5HrupMdjPa0503KINTlKLV31Jg8tzhO8a9SXgmZzGlRZnSK8svzIhGlJ+vXoyNn2ZGFdHljmOQ0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789567624; c=relaxed/simple;
	bh=4oIEmEX65ThH+N5pbWS2lkQOpuwAkPHdf4a1fFwowPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swPkhRGOTjCrQWWzvtc4a05oLZnfCoNdk+KALSaH1IGT6L/Z99YppCF0dA8TZlcCjEAW3jytyl2mpliAcLHQ/cCFaNR5Ow7ym6ar03EMlsNEfciS3pF6iXdIMyGcXvPg7Q9/qRBozWMX+yx13LJH6n/5ef4ZSELA2giJxwEy7AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmuN3bPE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmuN3bPE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B0A1F00898;
	Wed, 16 Sep 2026 14:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789567623;
	bh=6CO/PHc7wGIQ7e0wdlMaGlr8kKiTLKaJ83UdQbFgHcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmuN3bPEkBvJFfqGc2W+WXR8Gp4jGawvNi1H3XnE09CxtrtlIGDDA668uz4eMTvat
	 ZCO9MygAp1KdtYoPdI/ig0RGKuvCjU0HKxgw7BxE4YJI1Rp9HrHON4ddwREZMb0ciA
	 espAL67vGSqEu5mXJU1dErilJf5/RRo75ioNzz611sseXJgno0G/tgm4VwCxhBu1UD
	 Ls+rmtNDDbeYfcPHCeYlnpXUbRrJUhi4hQVTGmRCEsksp2bjTrBHqTR0ybxq74OmuG
	 uIT05vygGNIj0hbuPLfPceu1BapInTj8PocMA+Pz0hPr0YCWjy+340rMg9Zbm6nNDe
	 8hgVBjlVtSNIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Arda=20Do=C4=9Fu=20Ari?= <arfeliousheres@gmail.com>,
	Krishna Chomal <krishna.chomal108@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] platform/x86: hp-wmi: Fix board_params typo for 8DD6 board
Date: Wed, 16 Sep 2026 10:07:00 -0400
Message-ID: <20260916140700.2892359-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916140700.2892359-1-sashal@kernel.org>
References: <2026091627-nephew-drained-5a51@gregkh>
 <20260916140700.2892359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arda Doğu Ari <arfeliousheres@gmail.com>

[ Upstream commit ee02ed6308fbbd851c4e5c1f642d029617049a12 ]

When adding support for board 8DD6, &omen_v1_no_ec_thermal_params
was passed as driver_data instead of &omen_v1_no_ec_board_params.

Because active_board_params expects a pointer to struct
hp_wmi_board_params, dereferencing active_board_params->thermal_profile
results in a type confusion bug and invalid memory access. Update the entry
to point to omen_v1_no_ec_board_params.

Fixes: a7320d6eb9c42 ("platform/x86: hp-wmi: Add support for OMEN MAX 16-ak0xxx (8DD6)")
Cc: stable@vger.kernel.org
Signed-off-by: Arda Doğu Ari <arfeliousheres@gmail.com>
Reviewed-by: Krishna Chomal <krishna.chomal108@gmail.com>
Link: https://patch.msgid.link/20260827235139.154462-1-arfeliousheres@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/hp/hp-wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index 16aadf27bf391..051676c7ec1ad 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -291,7 +291,7 @@ static const struct dmi_system_id hp_wmi_feature_boards[] __initconst = {
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8DD6") },
-		.driver_data = (void *)&omen_v1_no_ec_thermal_params,
+		.driver_data = (void *)&omen_v1_no_ec_board_params,
 	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8E35") },
-- 
2.53.0

