Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273856;
	b=R0i0HhBunqD3G88sMhZvi+18W6Y86CDKoTowcMUzL3PyTEEOMZnC+F/kkO0+buAHhcu8
	 cWLTuOVqBHnNmjNizbSp58h453J7XRPzCFZbKjRN9tiX871s6c+1BlDPiPY+koV+cn6wr
	 ABCIlE3nijo3ZzQNLqdfQc/0XBLWWpGigahiGUcXJXudr+sWkdfhi8acCcCVZryyve2zP
	 415Sz4cfuxQu4bz8YEEqEV+PTijqJpa9sfMDa1Igw93XBcfLC5xf3PVlnnHf4FeEc+WPJ
	 AZZ/jYQolocx1j/6Gj5HvWbxkSkwPaidw+JFbTW6bfbnC3VpaHcxSLThWGmRvPne1MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273856;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GkpqlCksesm+rSHjijVKw6VOnBBWJgcW9BK9TGA7NuQ=;
	b=xZJbPA4ziyyiXSp18EzcVpbFmMlEDCXQ6bSSUWGaWStvp2QbZWigEIOsrRCe4nk2zESL
	 kZ8w+OAJVljenTa6blMC6+ejv0obuwfQxhpwzwVLqoFXRpm6X7cw/PS4stAozOarzZ/Vq
	 Iqv1Q8luZi2QvHSVSPpo6yP458FB3t0l3r+DF7Sok1wHX1lnuxWZ/tJWm9U89EtfpIeTb
	 5HHUKqF3uoEgCYuIrWBOk+B1ULIQaeIV5Hdhl7/rKVZKgYvUJZIM/O2ptGRbVJOuqHgoa
	 NcZvdzLDAx+JfzmsvwSxGST+eCDsgGLcWqryQtoQe9x+FzItoPHa/ZranmfkC2+Ncag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f30aH4o7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE0B60A380D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f30aH4o7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254601F0089F;
	Tue, 10 Nov 2026 01:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273856;
	bh=GkpqlCksesm+rSHjijVKw6VOnBBWJgcW9BK9TGA7NuQ=;
	h=From:To:Cc:Subject:Date;
	b=f30aH4o7mVO0Z4zAgiDXIOeMEtfiFCRZWbyzMj/GtRTxB0NvMeIouSreya/78L3Od
	 Nuhdk0/4fxIZl47F2118dXokZLOuGPKjITamEX5OqMbuTV2oshiYCgHE7S0rMw9LtD
	 ik0QDMaS0LBjELWGTsmnEJ70PWdkUyFo0MsLDHr02i6IrOdchgZ+wtr6ISINevLWwh
	 za5lPGDpGXn0FpQIoZclfyuSKLuxP0oKR/r6QZfB8jp1UXZHymW4JNigPNBuD3sAH2
	 vsUkoPYbN1rjU0hJESvcYLSMzu5BffCFtHGfnuGNMoVmtUf+sATVK30b0ZEemreJrK
	 KTy/tRSeoVrkg==
From: Sasha Levin <sashal@kernel.org>
To: alex.hung@amd.com,
	jerry.zuo@amd.com,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	daniel.wheeler@amd.com,
	sunpeng.li@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Avoid closing unowned DDC pins" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:14 -0500
Message-ID: <20261109202413-failed-5.15-e7ba638b8116@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e7ba638b8116cb5f1a5690f543052371215f1626
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202413-failed-5.15-e7ba638b8116@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




