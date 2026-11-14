Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645079;
	b=hQGAbQA9U8tIKuEWsHdT0uekf9gIWoMjyUlrfE8DHkTJ2fvyFsXTHZ7SKzXsTqxYzoG0
	 a5vpA3sR48trzvmAEfaTJsqHcU3SATdtE8wz4HmWeK6NelvQaNcsjfs5eth3tjfvanmhz
	 KQehtaBWWVaRwe5Y0lvK6OXUhksZLwUZ0oje/XjVHUPv9C6zmd/3TSzqc7+YZ3IPEkHny
	 SbhKkY5Va+x8LssdTJQCfkmdfTPy1gKyBrHlSpjt2Yb5PqSCDAy60+9Em0TagHqp3OFmD
	 ks4x+tF5coHKJzVKQl9T8EyY4rHw7i8Rtvq/J6t3zACiFdGvGw3ZWmt57bd5n00EOpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645079;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7bf74JBZJaiRPtSMX4QFCMUR0UG89iuIz4QHWAT2UNU=;
	b=pYsnafh02HeWuXu00fkNLV18w5dmGg9S5Lo5WZufl5US8CAEUzdAiS962h9AvG0XFdR3
	 Enz/h96Hm8rCv29Cmn7lSLXFlGTpph4nCmzK4QjSJUgpfAfJliHlnYTAEIkX4bshhaKdA
	 wP2BvC2mC6ZuJJjvL9ogzNQWebcYrR5b9bZVGpgCxzMP/98hLiwuLI5iY9kDm9foTj31N
	 lIRvgGkpSOfHHzimr6DCMgY+Mbh7j1t7Efi6ZBnWj3PCSp6fJgcGP3td/9iGCHhPVB6Bf
	 EaR3jP2VxfeAEOGqXd1BVcoxmWp87eumZkj7agHcmXr9+MpgVehcSTUnTOptCxGPx+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOQUHZPx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7014606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cOQUHZPx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4701F000C4;
	Sat, 14 Nov 2026 08:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794645078;
	bh=7bf74JBZJaiRPtSMX4QFCMUR0UG89iuIz4QHWAT2UNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOQUHZPxKDbvIYrQ02c5y9GUO5TBPOewM7E1LuZvoHtoyKcbCKIOKqpt+vZNSGmqJ
	 aXlDXjPXEk1zGqVTywz+jhnNBLuRLjLf9RmrPr5qf2LJLI9XactZdMrORv3EtreuzE
	 8NolOEo1HmdXbiJzrpU2n9MUhVvL7gWFUgOhcSBSrwh6L9TuAAQYYqzLe3LvJsFQ9K
	 2uNzvYEqjcr2UwsjtAJ9Fzs1y5NqNfZq0UJKMtBKFKy+6TGd25nooUMPffptRkaBhp
	 DU0ftCNYz4FGjzSxHb1qk/ZFq1e/n0lofcTfduORuv8ZrTOUFxubR1zE19hzrqnUux
	 Zl4Zzaq8Eei9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amd/display: Avoid closing unowned DDC pins
Date: Sat, 14 Nov 2026 03:31:16 -0500
Message-ID: <20261114083102.3256259-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202846-failed-5.10-e7ba638b8116@kernel.org>
References: <20261109202846-failed-5.10-e7ba638b8116@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit e7ba638b8116cb5f1a5690f543052371215f1626 ]

[WHY]
dal_ddc_open() cleans up pins it acquires on later failures. If the
data-pin open fails, this attempt acquired nothing. If opening the
clock pin or configuring fails, dal_ddc_open() closes the pins it
opened. An extra dal_ddc_close() is unnecessary and unsafe:
GPIO_RESULT_ALREADY_OPENED can mean AUX owns the existing handles,
and closing them here would disrupt AUX.

[HOW]
Remove the extra dal_ddc_close() from the failed-open path.

Cc: Jerry Zuo <jerry.zuo@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 175ae7772b68757b4932f34ff862923cab7abe21)
Cc: stable@vger.kernel.org
[ sashal: adjusted context for dc_link_is_dp_sink_present() instead of dp_is_sink_present() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 62778ccea055b..b05e515236224 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -373,12 +373,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
 	 * which indicates we need additional delay
 	 */
 
-	if (dal_ddc_open(ddc, GPIO_MODE_INPUT,
-			 GPIO_DDC_CONFIG_TYPE_MODE_I2C) != GPIO_RESULT_OK) {
-		dal_ddc_close(ddc);
-
+	if (dal_ddc_open(ddc, GPIO_MODE_INPUT, GPIO_DDC_CONFIG_TYPE_MODE_I2C) != GPIO_RESULT_OK)
 		return present;
-	}
 
 	/*
 	 * Read GPIO: DP sink is present if both clock and data pins are zero
-- 
2.53.0

