Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274123;
	b=rGqJcwA+ZIFAl8Dp+whnIlVpt0a6RrmcYK0u8RD6AQwfI9z65eZAwocq2bwsw+JcuOek
	 GR670kN6alKi2/v9WV/7SmMKmfOXAWp64sJzUbxu0IGStH/Ubn8Hg+u/ThdBgmoufz3rU
	 kRBDXp4+/890w/webDW6W3+ST3IQGm8zwqKDmM/tt0SEzpYI8apqyhy8gdOYF24zDu13M
	 v6/UA4zEUzSS6VzMlqs4vT7oQ+lMuU3tLsDUkAPhUX0gTMjnG2y4JySxXT5cY1fSqzNMy
	 Fn0fCr47TNPLBIabANRmM2Z+huRLPHsXan/ornZ22vGt+9IyAZ5B0rpHx6KZ58Lxnlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274123;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OXfVWuzfp3j2A9NzxA60hWTHwa92svbldeh3XvODRGA=;
	b=YletOvUyMF+gmDQoi67XbYWe85ayl6EZWTXKDf62+Qii3/WZt8jK+rYDTJTpmkja8l59
	 2/k5eVtOu0ClINtLh0d86+MsqY/mVPHgxUr04o2zLfDW844BnDAJlvL8SW2Rve1F9PE/N
	 sNVX6B2jyeIH+32e2ZDEtrtN005xiupsvAgDrwEmZwEIDVT8FvgUm1bkV9Ak3xDF7waGp
	 x9GupAfey73vhKHsqTrqPI0qNwXY+YxJ1Z6TYI4EORLid/apb1GBH28Yon5fTR+T0ngdF
	 oba+BA46tNpGCyIJ/nRKNk2zkYjoWCLmYX4wd9DdWNb7h9KssgpY4xLxJ8qj0m3/M2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV9qy8VZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1254A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XV9qy8VZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EA91F0089F;
	Tue, 10 Nov 2026 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274122;
	bh=OXfVWuzfp3j2A9NzxA60hWTHwa92svbldeh3XvODRGA=;
	h=From:To:Cc:Subject:Date;
	b=XV9qy8VZB6xGGqDnq65gm3cjo0RwQEcnFiiYqxSVsRxpLlIRzoSZqzOPS55dev7VE
	 QH7B8z/TCRQNBdhOrg5pkLNq9453rINRSj3cETqKrwke+qg8FIgdVxfVGhJgMgfHOk
	 3TxhSQV5/9txCQgkewvCQ0yPXzVGoub3lrU6+NUCBxSN8rGiOvFLebcTXbTQQX5dSx
	 YDuFfS9EbYRUchwu07wehvNQeH4tLT709V6tSp/u0iRUYznPIDoz9Lh88hbOc5DCLR
	 oQIQJ0iS5upQL8J948pRNVUgcOfFcJD7z6Fliw2GOaQT2UO/C3paa07M1wqdLmh4KQ
	 TUprA1i/ibgTQ==
From: Sasha Levin <sashal@kernel.org>
To: milan.milicevic@amd.com,
	danijel.slivka@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:41 -0500
Message-ID: <20261109202841-failed-5.10-9d550dd1a3b4@kernel.org>
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
git cherry-pick -x 9d550dd1a3b4b96da49f3560a84b5c2413a88cd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202841-failed-5.10-9d550dd1a3b4@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9d550dd1a3b4b96da49f3560a84b5c2413a88cd3 Mon Sep 17 00:00:00 2001
From: Milan Milicevic <Milan.Milicevic@amd.com>
Date: Wed, 28 Oct 2026 15:31:55 +0100
Subject: [PATCH] drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL

On SR-IOV, programming IH_RB_CNTL through PSP is slow enough for the
first MSI to arrive before ih->enabled is set. amdgpu_ih_process()
then drops the interrupt, rptr stays at 0, and RPTR_REARM never
generates another edge, so every ring hits the fence fallback timer.

Set ih->enabled before psp_reg_program() on the indirect IH path for
Navi10 and IH v6.0, and clear it if programming fails.

Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>
Signed-off-by: Milan Milicevic <Milan.Milicevic@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b2f9434f9d17c94798e8d8957af3adc4a9949016)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 ++++++++++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 8dee486496501..478b7169f44c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -168,8 +168,19 @@ static int ih_v6_0_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+		/*
+		 * PSP programming of IH_RB_CNTL is slow enough for MSI to
+		 * arrive before this call returns. Publish ih->enabled first
+		 * so amdgpu_ih_process() consumes that IV and rearms.
+		 */
+		if (enable) {
+			ih->enabled = true;
+			smp_wmb();
+		}
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			ih->enabled = false;
 			return -ETIMEDOUT;
+		}
 	} else {
 		WREG32(ih_regs->ih_rb_cntl, tmp);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index ab12ce8da3dc3..fa5148ae526de 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -194,8 +194,19 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
 
 	if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
-		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+		/*
+		 * PSP programming of IH_RB_CNTL is slow enough for MSI to
+		 * arrive before this call returns. Publish ih->enabled first
+		 * so amdgpu_ih_process() consumes that IV and rearms.
+		 */
+		if (enable) {
+			ih->enabled = true;
+			smp_wmb();
+		}
+		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
+			ih->enabled = false;
 			return -ETIMEDOUT;
+		}
 	} else {
 		WREG32(ih_regs->ih_rb_cntl, tmp);
 	}
-- 
2.53.0




