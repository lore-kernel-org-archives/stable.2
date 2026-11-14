Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640549;
	b=xCwu5aZRvoWqe7rQOZnOt28it85deZFLNIgc1FUhR6ceQoI/2LQlCF1mgvUG5MwHTNky
	 7PkcfH2BJdM0TjRGxWlRnb62psUO8LRpIVxKw5rRRiFRtgLeXgxaKZ+Dk31ByGOdC/Izx
	 /YcJX/HTE7Mwm4GvCuilzAPO9WagUMX62PYxJ+fuEMqNJk4YG+D9FNzgvim1SXehHjRXR
	 DXFwrH0MNBMGw/POQ8RWsb0CRbq/bS6ObJ2mleuBWJ53C6b/TyiGHc+J9HGxXqcQzPIUt
	 qkWWRkEdvSwLZUp3AxiDOPWAuzU1f/NraB27PCQcWfS3ECsJGaHYqeZ1lK2jQ7l5pbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oJMFC0cKupkqGNA9MRXSW8uromdE8tN8qxytTh5esVY=;
	b=vP7DLYf38KDwn/tty6zngcWy0VjTBQodmAxVa0jkP24hcYwXU0o0D7MSjSACUenNBlUx
	 c/K/4KLMQo6LgdpeYRd7rN+H92x7wUgLJvkzNVePX1UR7uZioBB+ZTWhWl5BMnlQ+OdEf
	 3ZFJ/Bb5otoQIXz0R3Whu4IJqBjqwFrBKXGZaKyhcwmoYHL3gZJS1qy4vsFYbo3CvTb8O
	 tDlt/lk/pZkCmWIzf0QF9zRkVwudnC46S4oljXfsxjsIfUYHpM+IiEcESKPJyj9p2IXkr
	 tUXMA4uju8+E1rYkZfCcUiACr8b53Wh7GE7w/PaiA+xBLCIDHjoprwfqy665z3B7VWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcIlAIXT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917DC606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NcIlAIXT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570511F000C4;
	Sat, 14 Nov 2026 07:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794640549;
	bh=oJMFC0cKupkqGNA9MRXSW8uromdE8tN8qxytTh5esVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NcIlAIXTR+ms2s5uFLvAPrntnRkIEgR9AWHJbgRASA+hittQLSZ5he7VJlbplmXWj
	 twmoth4haGq5+QqDjYQ47wnd6AB/MEoWchYmd/0HWG5dbXJe5sm/31DS+VnWhGvJh1
	 qFBO2u69hFXqSkcdgvD1/e9U/DWWf/Rx355AZfIF4eOqqNNyxWsip04iqJH4xaQVd4
	 RmZuhZVDMf88VzSAdAdKDeMv1S7zJ8VqCURIrYvC3JTD/s/xA8pWLa/HKoNzQu98o1
	 0wzKBQmSaDvnmXUkAw2cPBNwnJ43NSAhrW3XfsjmC/camQclfHm+ECn8umijOROfQ6
	 wRjKcXKHm7GUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: Avoid closing unowned DDC pins
Date: Sat, 14 Nov 2026 02:15:46 -0500
Message-ID: <20261114071531.3241195-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201913-failed-6.1-e7ba638b8116@kernel.org>
References: <20261109201913-failed-6.1-e7ba638b8116@kernel.org>
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
[ sashal: Applied the edit to dc_link_is_dp_sink_present() instead of dp_is_sink_present(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f0db2d58fd6b8..9282b065a90a2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -399,12 +399,8 @@ bool dc_link_is_dp_sink_present(struct dc_link *link)
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

