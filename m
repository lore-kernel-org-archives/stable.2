Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274121;
	b=Dt3etMRy0M9e/xdkltPP7tCgKD4KeM1N/S4ZW3/G7dNCeu8F46AUKCODyjpfRxmXhBXI
	 MAPso7RByxtRaMM013F5UoZWzEdKq+DM3XFhge6tl4VdBSoeMgtzYfiach75VOLXBxcHn
	 bYC3w6bWayx75uV0kynDMR2422vrsh3O7csxGnWK1t9Py1AaQXK/x2rw4GVfwhjpnLGF5
	 0jtrCmyI5/f0auhNUXJdkMQHll3SYPbS442hOZrJpaXWlgHTl8v3Cze663VrdH1Zym2AJ
	 1iAqUw83t+35Dn7ju7DHj6SXcyMTj6TUqt8chpRO5YQYuXhfhjrYbr+iNW+kB9d8gdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7e3msHx/7KtieAFr8GhXlQHgeQqFIfGkbfH6hg6DG2Q=;
	b=tIhS3m6x7bKgzZ7QPaIWpmc4WiI83NoyQwjifsdmVjSpdleOxpxlEdr2U6evGAJnW76W
	 ovIEQXV5TSWYzOzv9GxRubT2Nth0AnM3G5dWsYbhJ8VAMMP9GBeuTkoyHN/FAtY5h9CHh
	 Wa8QCt4k35zETkoJi0AqwE4OFMOlCR1L7FAiEwR6RnH+tstsJ/lF7ysTJYIf6xIOkKARP
	 ONh5sy3Zp+bW/CWT8JCq0tp7eqgs5fAZx5IqFWlTKoRJvvWrIt9jIQywXmSa/47LyrZWK
	 sNdt1hXFEGwyrzIiYy40nYW7a6aYuzDzl/eAC7REhJi/Aq0jq3DoYuXp/NrTZPuqw/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTL+Qubl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A940B606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XTL+Qubl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCB1F0089F;
	Tue, 10 Nov 2026 01:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274120;
	bh=7e3msHx/7KtieAFr8GhXlQHgeQqFIfGkbfH6hg6DG2Q=;
	h=From:To:Cc:Subject:Date;
	b=XTL+QublKWCjfwW7oSx1TTYPJq1tk5z28i/qQcteHsx0hMzn1/YLdufWKBV2oZdNo
	 E17WV75DXOyPWCSDG+UHbJHSxUaKg3JgAKgo1JSJHDIyO7pyetkfWppS+Ry7YpPTwH
	 EVprcnocB5jjbQiKeZcnhjCuy0mUL48GZNQkr3wzUpWZTsasmXQeTzLqc/PlB/4PvM
	 Kgn2YCtclAn5xmB1CSz+u0fbrAv7smF6mzHdR42dg7SmtDevPGoxvJ+20TfwrqnHSA
	 6nebx+h8COhKgaSPyxS/wEmcugCymxIe9hDrWP17p1zoPCTGyfROEdJ+SY4k5hiZre
	 qYWi1B1fnZ7lg==
From: Sasha Levin <sashal@kernel.org>
To: milan.milicevic@amd.com,
	danijel.slivka@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts for navi10_ih" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:38 -0500
Message-ID: <20261109202838-failed-5.10-146b96974b33@kernel.org>
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
git cherry-pick -x 146b96974b33b8cca52755ffed3cd24a82836013
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202838-failed-5.10-146b96974b33@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 146b96974b33b8cca52755ffed3cd24a82836013 Mon Sep 17 00:00:00 2001
From: Milan Milicevic <Milan.Milicevic@amd.com>
Date: Wed, 28 Oct 2026 14:52:35 +0100
Subject: [PATCH] drm/amdgpu: clear RB_OVERFLOW bit when enabling interrupts
 for navi10_ih

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
---
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index df2245fa35b78..ab12ce8da3dc3 100644
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




