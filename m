Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760899;
	b=1ZUvhjNw2+sED6vVFpOHAh4GigkYanNGWLM8eAB9BISpzLLf6CXqKr5BnrNgI41M2zvd
	 06JOA7sO6foZF2PElF8m6ltDvviL3zTrhNFPosMqxpvTzHZYwIQGl+9W3t1M+q5FXnF+w
	 wPEyJcwTVZ4Q0qgFKgYnL2td1MK1+j1Skemo91aVgldl9uqbRM+7eUrzQS8VpnrYzDGwh
	 qRYhEb7r/YbDT35F2BwXKKWaH1H9YqMu5FKaXvVM/5TYM5RkiFbOAz2d19KpQ1anismDC
	 xQJo+jgzbTas2UjqL8y7yVr4qM0FUzXkU5p0hGfkNQxSDUHB0neOFE2ymq2MDbiiXhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760899;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8cCv0vSN/Bt7Oa9WFq636oxtRKnBm/9HGR5Gr8ivkmo=;
	b=ElbtMOXE7EcU46PsHbx0nXaXCU8dZ4/IQ5+HF585GjgeoW/VD3TO+sjI8sLvEHU4sn64
	 UELs3uSjey1HoBay+N2JZL6JoR8STyI9/ITm3qRUWfs5Gjn5Xt2DzZ5a6hajRChEYe9B/
	 /zuebyCwr5S1vvVoENmbmCpJdAEgfXMfsWTg2APMJijkRcYQVGpZ4nrcNqPsZipGq5oL/
	 +3wUbV2s3R4noopl/L4cDdW5V3sR7ZeIiigmJVsLMMA/D8q3JYRONVMsFenOwfg+Yd1cV
	 oJASpfstRZk4HJMdV2qVNvnTYOCudyRL9cdwkMiMKALeR/5P79VSg4vVToEh5Wst6Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZNvMWvl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94342606A31D
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZNvMWvl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890211F000C4;
	Sun, 15 Nov 2026 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794760899;
	bh=8cCv0vSN/Bt7Oa9WFq636oxtRKnBm/9HGR5Gr8ivkmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QZNvMWvlSHVyDKq6mlzITnDw9TYv3bUftddoij2xeS3cpvPscFQZ0M5p5CJ/aIQnn
	 XwagwTEVMK59epODIC/i8U6C+RwVa6aLhnwgxffG3IiZBL41bAg58yOwxFm1c31b/U
	 QgcwdjLpNrmR+fZppXwdyPf0GzvemucpmD2jbZe69Qmi6XtqyUQu9IAkNrLiSnRXXp
	 7XBbH//WpS5++hFGaMI3I3XCrRvJgqhNe35542WNpdPNtBu4CYufSxHNYGNlVdgL6W
	 OxKkUHVE4O/usD+/2keRB7Qn3pwEUajYuEA+21mWe2kto1hpVRfuPTV6LqHdiIIgrU
	 zjtYLyBtmIDtw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Milan Milicevic <Milan.Milicevic@amd.com>,
	Danijel Slivka <Danijel.Slivka@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/amdgpu: publish IH enabled before PSP programs IH_RB_CNTL
Date: Sun, 15 Nov 2026 11:41:37 -0500
Message-ID: <20261115164116.1674485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202411-failed-5.15-9d550dd1a3b4@kernel.org>
References: <20261109202411-failed-5.15-9d550dd1a3b4@kernel.org>
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

From: Milan Milicevic <Milan.Milicevic@amd.com>

[ Upstream commit 9d550dd1a3b4b96da49f3560a84b5c2413a88cd3 ]

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
[ sashal: Omitted changes to the absent IH v6.0 driver. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 9425a9448cf51..352d6f14aa413 100644
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

