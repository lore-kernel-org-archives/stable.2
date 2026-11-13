Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794542226;
	b=mokhJp3CnuvnjbFL6396wXqBbSm2rJ58St5UnuLaFAJ3YCEeT19opeGNh3zdgjloTHMQ
	 tGIgnOSLdN+yXhFk+vcxhhnj9+7NwtkgWBH1Zc/PMN0MTp1nlRyzUDYYGV6SjnZTymh51
	 Tn2ozkSygn2xKCQmQcnz3qRE0byRVeBwHKuBPaNBUwII3hQW4yHF3ry8Wjr7j2qRogQSn
	 vcjbxAwJwc5VSw5ttYEcGGojHgHpCawNJVmm7UoTVcVXtUj6/+VtvbsmKBCVy22XpllG4
	 eJwDw9IqU2d1WqD0rTUkOD1O/PgmHpPbyi88dVXzZ6lQ9hOnNgIGpnLaJOLNPGwqRKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794542226;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ARf1xSo1qTt0mrDhYrTV/y+PKtp0zfgdaAAic0fn+K0=;
	b=Fgul14wgka1+fAT2862glLvhIAEKShyVcEi2jAAifvti5DKXyV//ePY+HrfvVEGtGj3I
	 kxt5oCNMkBtTAbvCerS6MGGHJmPf3EGvr7xhOQzyOUeQEeSOEj0J7MRfZu8REdSpjLvoW
	 vXzN3irb2kRVX1zH6YfoHGpnGIaYJxqANEtV1Yva1Rb955fzS+yiH+72tJq3RNa0HD7P9
	 5S6fP6EyivBcHzb4LXUwm+JSpUXASil8APnW3OHI5f+QbLHXWWlBrEDrb/RolpxqvHmTP
	 RAKXv/A/em+rD8TVzJpsYLvzgV8x4ZP5V9Y/LmMZfLgeOiE+Sy1wgCM65DafDhZibLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJmRYekW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD2606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJmRYekW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809201F000C6;
	Fri, 13 Nov 2026 03:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794542226;
	bh=ARf1xSo1qTt0mrDhYrTV/y+PKtp0zfgdaAAic0fn+K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FJmRYekWkhUhdyGOBYqdzT/NaDiD2cU0iXo+6ILeXrmzf0/YmyV8jlaKxWfaOQigs
	 +iM9CbWVRW+FR6P3eHsan52MB2iOzmkwpYy/IyIl5QtpmdeJe43tz1fdBqk4S6tljm
	 MZwmRsCwITszpgLLlt+9qaekLABMi7Bnd22PQGn/wvDHn+8zdkNw0WaK3a0hLSmM8H
	 AV3rOuk9YkjtfFH76ot4sjIzRbs2shRv75yxMpgbOJG5KZoS+x6Gu2C1+49C/VaIbd
	 YbSBVQcntRGfESpzbN++cer7enyLGPG1wMJoVcmddXGVMyhP0GOCEOT19N1Tb24SFd
	 X+vv2rI9fFVMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Milan Milicevic <Milan.Milicevic@amd.com>,
	Danijel Slivka <Danijel.Slivka@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih
Date: Thu, 12 Nov 2026 22:57:03 -0500
Message-ID: <20261113035638.1074375-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113035638.1074375-1-sashal@kernel.org>
References: <20261109202406-failed-5.15-146b96974b33@kernel.org>
 <20261113035638.1074375-1-sashal@kernel.org>
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

[ Upstream commit 146b96974b33b8cca52755ffed3cd24a82836013 ]

Port this change to navi10_ih.c:
commit afbf7955ff01 ("drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts")

Setting IH_RB_WPTR to 0 does not clear RB_OVERFLOW if RB_ENABLE is not
set. Pulse WPTR_OVERFLOW_CLEAR after RB_ENABLE (and with
WPTR_OVERFLOW_ENABLE) so overflow is cleared when interrupts are
enabled.

Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Milan Milicevic <Milan.Milicevic@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 713fb4ab04f4d2af6120f8eb607c5673b2759b38)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index 2c42b9a7ba74b..9425a9448cf51 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -161,6 +161,34 @@ static int navi10_ih_toggle_ring_interrupts(struct amdgpu_device *adev,
 	tmp = RREG32(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_ENABLE, (enable ? 1 : 0));
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_GPU_TS_ENABLE, 1);
+
+	if (enable) {
+		/* Unset the CLEAR_OVERFLOW bit to make sure the next step
+		 * is switching the bit from 0 to 1
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Clear RB_OVERFLOW bit */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+		if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) {
+			if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp))
+				return -ETIMEDOUT;
+		} else {
+			WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+		}
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	}
+
 	/* enable_intr field is only valid in ring0 */
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enable ? 1 : 0));
-- 
2.53.0

