Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273556;
	b=49lkKUtQTcXbvTpZW28f11mSiB6LomsltVzM8KI/9GsCYoTkV7ak+aW+Ru54uk7Vaybk
	 tynuAHbsWgOd8Oy2cc8TmhoU0F9B9srPYAgybX8XAiq6Th9lmAZIhraGBMbhvRXylO89X
	 sOjkSA+a1HxgyScaCmJdqCiJMu/7hqYjbA5JBXB2HMfFul4K86efGF/yXx+/GN+AiQLoC
	 I0qMd1gGnqrUwccxWnCWEdgDqTWjtavIZSkZ4Apz/uCW1Li7oqkISDfnd84wk5COuoBDK
	 2DikYwrFiS0/w33eHEtczQo+f2iHcgcHHMaKT4Qj1PxfkEYBrrVvOs1s5eCzLJb4HxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RkeuNVStR7j3foqB2D6KlFqes1eQE3Fj6ZXulVBKcOA=;
	b=xRlZbpWxcxS1xdM4jd9bQzLIE9jJRMrGe+b2usj1J4Rzm/dV7+eXP6WCXASH+LFFcsOD
	 Im6uOjIIOQQtgOHEr5gxyce2EjW0esWxmvH6P0LhtD5wPF5AjjgjmU66zWo3PSsuQHLNf
	 I1w917JM3bI/BOXKkYu1uZiPd5jBZfiv3xiaDiTUqooolFLF7Wp84MjsFbcbCt4bQ65F0
	 egHGAQ0AZdHEMiKFOdVMEpPMMWKynWqkQ9K1GSWWixcQOylwHnt9WFXA/668bmTzXBmQB
	 2G0kIjzX9FnDOCUUWt+Os62tv6tSImsVYg4nnmdMRtt2L0oHRPWDp41jZ0Wdmufjgvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQh7d7wC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF726606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KQh7d7wC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD14A1F0089F;
	Tue, 10 Nov 2026 01:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273555;
	bh=RkeuNVStR7j3foqB2D6KlFqes1eQE3Fj6ZXulVBKcOA=;
	h=From:To:Cc:Subject:Date;
	b=KQh7d7wCak9P2ZHN35PSfYwaETB2fQFY5mYv0QmrZqu9bhvlxMvkmbC6FKLt0xPIE
	 vv+guSQVeGy22/WAELg2k4SIbxaWu2y62BaUZ+4e4ZHXt3so2uYN3EPgVz5FN26gFW
	 zOPl27lW9pR1fswMfDRRgojqCRrjTvId4kZob3C9T/cbvfAHdfwLbT58hlTyOe64r9
	 +/2kzvHAcQoPOwWnC5YeBJ5+Lt6POKONNnLPN0cJTjLaQUonPL2vX90y1scZUpOb7q
	 5dIad9rW85tTgchIAoGSPivaJRdeivmWaAfNyF2AQxHvJ7dD0prkFt7qZWzUHLRGNt
	 +ACQ7/0hgzQqg==
From: Sasha Levin <sashal@kernel.org>
To: alex.hung@amd.com,
	jerry.zuo@amd.com,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	daniel.wheeler@amd.com,
	sunpeng.li@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Avoid closing unowned DDC pins" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:13 -0500
Message-ID: <20261109201913-failed-6.1-e7ba638b8116@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e7ba638b8116cb5f1a5690f543052371215f1626
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201913-failed-6.1-e7ba638b8116@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




