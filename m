Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274128;
	b=Y86IH/gDECzSinyGBFLLde8mqFZUIB5X8XET9TWXaZD2pdC5Q/8PlvJ1AG7L87KiQViz
	 f2EiuuYKJToDSje79A50/Tu3BzerQQf3pTC/vw7214QZnhlbLKKZEdplVfexc+9DEDKzk
	 CtY8Zt5VUh/V15LnqrMzwQbWjU2ygrHn90+maeqLkzVReZVvU8Tub1n1ylKB+AKm7LmyK
	 t/vurJoI++qBYtVzGd8zpaO7KbDR4kP/9CbQWo+QO8ekidUVWB/L2+LwDDqh2AP27X8u4
	 12QtyZkBPmIWi24wEOn2mWOICEzmPi/lQa2st1UG99ZdZfhIha5bXKXCv+UIp0sBzXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5BHXMpTIMJWtjEhlf/iI2Iv7d+gRnkLJpYp8QdRdl6A=;
	b=UevNrJWVrTWuMY03TBsFDHnyq8baVFk6KHgIzlCZ6sw2EscpOGQ3gdxRtCowaFBTkFxQ
	 il6bPyTWUwEr69d3Lmif/gXl+WoGKcr6caBu5beg2F/ksjO0RQk7Ax9JggjMofkgOJ6ac
	 KvE3K2veHUxrfUxajR/HTUqWJSz+rUpMoTHawA1K7ik8CLGjltTTglHd8vX5hPF6w5z73
	 GmZXJnCVtREsN6t8tkwG3YVoQ5BK6Jx76pU4l3XV8Dnd/ye9erHFVflo6sLbTIYH683p2
	 D+tincAdO2sp0sIRjtI2CbMma9nhsqgz+soZv8IPHNrPtoxKrHJPcDlF15UL/NrhACg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oE2wO0w4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F514606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oE2wO0w4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED4D1F0089F;
	Tue, 10 Nov 2026 01:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274128;
	bh=5BHXMpTIMJWtjEhlf/iI2Iv7d+gRnkLJpYp8QdRdl6A=;
	h=From:To:Cc:Subject:Date;
	b=oE2wO0w4P1ylsYltpWMFAjkxyC4UkefybP7IUbazDPk8AkX2iDFwQsEtXQUAYs0vS
	 ykKDyJl/Q8mst7j6s+TNSRO5iq76pU0mW3idZZaRYOHJm10a6kJv8F+/81bpRs766S
	 4t6z92OMWwIsTmO7engfEG7BNUmKp7GoVuzJQ7FbURDjxwy3UKKmRipO9hJDTS0Go4
	 ABJ3fj+fzrigyIM+5IeNmMEKEZO9QNUJt/Yr4WoYNUiWhSPk6Gx6t+U6nWDGCnjSEF
	 hW37c7QdJwFGjGpOVav0H8TGd3AUE7pjBUQAFOymNj+GH9JMHzUHF3ksrNkAVGb/tj
	 qiQ3cBXf4NKxw==
From: Sasha Levin <sashal@kernel.org>
To: alex.hung@amd.com,
	jerry.zuo@amd.com,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	daniel.wheeler@amd.com,
	sunpeng.li@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Avoid closing unowned DDC pins" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:46 -0500
Message-ID: <20261109202846-failed-5.10-e7ba638b8116@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x e7ba638b8116cb5f1a5690f543052371215f1626
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202846-failed-5.10-e7ba638b8116@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e7ba638b8116cb5f1a5690f543052371215f1626 Mon Sep 17 00:00:00 2001
From: Alex Hung <alex.hung@amd.com>
Date: Tue, 27 Oct 2026 17:17:04 -0600
Subject: [PATCH] drm/amd/display: Avoid closing unowned DDC pins

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
---
 .../drm/amd/display/dc/link/protocols/link_dp_capability.c  | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
index ad1a499b0d9d2..c487c5b87dfd7 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_capability.c
@@ -2602,12 +2602,8 @@ bool dp_is_sink_present(struct dc_link *link)
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




