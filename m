Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794642009;
	b=mh+E9us0Snct2FtHFiH68JrKE2OfF3oAQnR6HruZ1JbzqQuIUW4rL2YzbNIcqhCODYy3
	 tzIACnNDUcqBw8mkh6dlcWjJC2OhvGAKkkgVzJFRjgjvTCeoraFzbgFX3EwBH6UyIAvYM
	 jfVtOPTSIwZyWUfcyMB7/fjrOH6p7DuBpK6HNnZl7BwgtdoM/Ax2V17cvbIWD+CG3Ta7y
	 C8qmRKDw5Ajz1fxOgsoubUMZaJQRr79NI/HPmlRjrr8i6FPQIa8wQXv+mIb4QYi/FWbz0
	 XYeVeCKDwbPICOL6K0NufKekE+NOv1N35QzrHV4mSJx0w0qmLUCEuRr/D4oUCFHnIUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794642009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J+tYbRRIVpg9l4yvOIw3XAccjj0V+nIj5yfZ8E0QSNY=;
	b=lF8o3F3xgCmaOuJe2vKmMzmgI/+CplLFj9tvsyem94WQJeMZrkM18vD7s34BqF4SztGf
	 YUlIVaY209pvUsanqWtvsxHm1aa2IKZDRvGFuOHRAGwiUE8DORydLy5rmT1377oeyol3Y
	 dXmMLx8V7x0kBnBYvbDUVs2hYOfrRyownmwxA0lRYut/hZCbidFpD/YT1reihoPnsRC7s
	 pHFaoVnolPymCCy4OoWb2jCsTHFAG1AOc+JGSG4WElFnI6ksnQiw3RKUl0BNGZaAqQrTY
	 Atto5tZ+J35/0Ac4unlxhvq8RGCs/OgK7+4//2BecxvDg8gsIWyyX90UTAfHO5ZBaJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6s9DxrY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA84606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6s9DxrY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8191F000C4;
	Sat, 14 Nov 2026 07:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794642009;
	bh=J+tYbRRIVpg9l4yvOIw3XAccjj0V+nIj5yfZ8E0QSNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W6s9DxrYl/EB/OBSMT5T1lecow7zJSM2JK6b+d2c00JvPvmrvjn5ICaNMa9R0O03N
	 Olciu9frdADdHJsP1V6bFMkh+xFWToHpBSNa9Q79O2DyBrUWG101/ckSrpNez/xLZw
	 t7Uvo5hHPgGaItsZmPzOfkEj1Eu14EYIMH7B20TKcwIYQ292YLM1kQ9Vu+icqHopEV
	 IxmDGn7P/5tf0j8HgwKP5kTeDGhtlBpAhqgCGYDXUFd+X5fIuqfqVdwyA9luZQ52Fr
	 YdaliReV1AWmg0ESR1+q1VRJVwiVGAk8JsRgMqcXn+y8xBgNPg53KK85nNwP7bxS90
	 qBJF+II5Fg+Ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amd/display: Avoid closing unowned DDC pins
Date: Sat, 14 Nov 2026 02:40:07 -0500
Message-ID: <20261114073950.3248411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202413-failed-5.15-e7ba638b8116@kernel.org>
References: <20261109202413-failed-5.15-e7ba638b8116@kernel.org>
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
index 6696372b82f4b..00d5190db5ed6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -392,12 +392,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
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

