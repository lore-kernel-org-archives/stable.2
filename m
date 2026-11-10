Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273853;
	b=16pZu+lk7PIwrHQr7t/jnPHCsEjkxEP59Yt+LJmC0gdpkBxxwLQhbTEXJ1iBjXOuxDNu
	 ESc8HT+vo6YtxQyCXzlEt1W9uzrOb7JRt469wElq4UWzTqBH6lBX6mB9OmfsdD4XZrasd
	 /e/XM3X2vvR3a+NzdiY7gt59JACIXIK6sXvc71utQfmZRiV+Wc5d9C5Qpqa+anagmQhHU
	 f1yZOhf8NluLGKuSA4AbKEgq6PX+WDYclCTbUxhAjrr+PR/pF/fhC6v7CLLGe/MM5ZCP2
	 b/EWf70dKaa3w+VPX0d6/oUWKJEoehC4SxK+gHfyKwQw5mWmkOP/5dBxwmmfR56y6PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yABJ3vjYBgLJg8xS+hKTQ/PCMdDUH0NSuUWEzZ1CR1w=;
	b=KDOmjOb5KlyZhjZ7jaoY35ViqR9IQQxeOCK95uKYYWs/D10c2T53qkmSv0BvQCzj8XuK
	 iw+lEgTyYVczpm/Zwcanfvd2Q8rDg9gDfmA2Z/TXn0uF/o2oOBP+9WKEYxg6HqK1MbLSz
	 P1XQIQa3RWUFr6Tya2dEa4rtsPBhW+FGOrlW3JWTaZttS3iaSGqrCLZUqT1D9Yyq3Vv66
	 zV+X79ftt7RU3vIvLzywARpH00W1b6GACGIdoYJDf5/DeGK2MYXzbJkqcOEibCcGU/D4A
	 hJrD2hqAa3jSVv2wMftrqdMs2GncmFu9qrC29ml9FhoO6L7AY5uyhqyhimU+Q/H1TKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oemTk0bX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727E260A3809
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oemTk0bX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAFF1F0089F;
	Tue, 10 Nov 2026 01:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273853;
	bh=yABJ3vjYBgLJg8xS+hKTQ/PCMdDUH0NSuUWEzZ1CR1w=;
	h=From:To:Cc:Subject:Date;
	b=oemTk0bXT1xkj9Wd+4/HjlICcaDYMl2p/2KBGe8Cq8EH8ncfpekxwoPPffE41Pa7P
	 sj8Ia27de4gG6mxjmGpXHnRbowY2th52sW59Iq/rEG3F/6d1FkEtYSDwN/lPWNhK+D
	 UPjHAyXEjyTDE/loaA6uwF8SNDDvIk8bsliWNdn4KghPyIpmQpfDu+9Y9VCetWhYj0
	 GU3+9/VLN/JIeVM1gTEtAwM2a6rytXsIU3Lt6Q9KvXXeMSF5cGk6IhVk5any3rQwin
	 pBnryldV4YU2WYkS+I+pgc1tqXPMtlWP5vSiPDop5lZ0q3ZqTBtqmA8yFegfaRm6ND
	 q8dfghIMr6goA==
From: Sasha Levin <sashal@kernel.org>
To: milan.milicevic@amd.com,
	danijel.slivka@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:11 -0500
Message-ID: <20261109202411-failed-5.15-9d550dd1a3b4@kernel.org>
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
git cherry-pick -x 9d550dd1a3b4b96da49f3560a84b5c2413a88cd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202411-failed-5.15-9d550dd1a3b4@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




