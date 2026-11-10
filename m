Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273261;
	b=3nM/fbTu4F8imS3c1BKIEF0OYJmHlULiHO/iRuDCT+7KRauPoBOtH64vowH+CMFDUPx4
	 Yv657n5j4pK0uQQYiF4sc/ZROSk95IXXu6qMo/ncIqKfvSwZlnA6rPM7IuVCaX1CVfb4e
	 Fi47a1NWOEWaMK9wuubSn04he6ZEqlOgVdo1NtdIvpwp3WyRlwvo/mbVDLrpMpKd/ose2
	 M9f7Zv1UxqINrl3Qj+Pus0qI8Q4yC/IMpj0PQmUBkx96bA6nrYEkcAANxWInkjHMdU+9+
	 QdqGJEnL+OPO/GetrU5KKrOO/Kuf2J0COCWvS+pFvaiRN/eCiAIfQyuXJRUj42+li1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273261;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=jTX7ejQbE5JnZM3YfEiX//LtPGENF/qugot6Z896V3Y=;
	b=Uykp4I7hJ0csGGKtz33tonecb7F7rHks1BL6ZZo+lTfWTq/vtLYbQoMM9baw+wWahIxD
	 4uuOLM+W/J2gOif5+9xYfWDBjeUvWXGZQnb06UjkhBliD9keFPBB+lwC7U5kNEew3SPw2
	 yK2W6Jh5WcoMqDbcbz1bVaYCSpbf6hDHAy/FTSlG7oFqaLPVRiLOY+nw/aJ2Il+kPLhCI
	 j118ZPQOHbO0bSRyA7MiKfyVlS+Mo58C8FShrsu/xKLWG+T9/xmW/dyO2iiYKlV0id5lB
	 ibe//B4UD24hTJERGtNX58qH6x3CsE6Ojr+HEVcNDLyCW4Dn4XghzcypCqZ74w6yVaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOVXNE4p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64118606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IOVXNE4p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0181F0089F;
	Tue, 10 Nov 2026 01:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273261;
	bh=jTX7ejQbE5JnZM3YfEiX//LtPGENF/qugot6Z896V3Y=;
	h=From:To:Cc:Subject:Date;
	b=IOVXNE4pf9IA2qQJ5aFbacVQYuVzyTwnsfvQUUCYVGtRKhxx19E1tSUXSs2SmH11E
	 lSOyRdpwswUXtR7Nv/9qs2Zk/rAwh20gQrysctYFV+rowIrv5t03swtMvbA2Kx13Lo
	 1OpLOvBsaIjWkF3KVqn49LeAlG97bP6mmN9l8MBKW4pv68Mo6KB1LOQB95hgMSprwJ
	 gqJ4vwpKSNaR7mJPpc7X3ctOkGudMtrhHabrOsnZoAwtfn5iXXfbToLD/dHj9Gr4+6
	 O8QtiYaTJl+gP53DLlFoVm4KXQ0mt6+A531l2EFtMNOU/2Ap1ubLm199jDpmhKwhns
	 6YEp9oSfigQXg==
From: Sasha Levin <sashal@kernel.org>
To: misha@nasledov.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop clock requirements on DCN32 when no displays are active" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:19 -0500
Message-ID: <20261109201419-failed-6.6-bba4dc330648@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x bba4dc3306483335ddbe065c05b2d8359ec387a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201419-failed-6.6-bba4dc330648@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bba4dc3306483335ddbe065c05b2d8359ec387a4 Mon Sep 17 00:00:00 2001
From: Misha Nasledov <misha@nasledov.com>
Date: Mon, 19 Oct 2026 16:42:32 -0700
Subject: [PATCH] drm/amd/display: Drop clock requirements on DCN32 when no
 displays are active

amdgpu_dm builds the new dc_state as a copy of the old one. When the last
stream is removed, dml1_validate() returns early on pipe_cnt == 0 and
never reaches dcn32_calculate_dlg_params(), so bw.dcn.clk keeps the
dramclk/dcfclk/fclk requirements of the display that was just turned off.
dcn32_update_clocks() then keeps those hard minimums applied.

On an RX 7900 XTX this leaves UCLK at 456 MHz and DCFCLK at 637 MHz with
the monitor off, and the board idles at 28.4 W. With this change they
drop to 96 MHz and 145 MHz and board power falls to 15.3 W.

Reset the clock requirements in that case, as calculate_dlg_params()
already does when no HUBP is active and as the DML2 path does for
stream_count == 0.

Signed-off-by: Misha Nasledov <misha@nasledov.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 0261a0ef89f37ef962fbc9dbc724ebf65fe681cf)
Cc: stable@vger.kernel.org
---
 .../display/dc/resource/dcn32/dcn32_resource.c    | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index 3a6a489388435..619b9b3362fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1941,8 +1941,21 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
 	out = dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, validate_mode);
 	DC_FP_END();
 
-	if (pipe_cnt == 0)
+	if (pipe_cnt == 0) {
+		/* The context is a copy of the previous state, so without this the
+		 * clocks the last display needed stay applied with all displays off.
+		 */
+		context->bw_ctx.bw.dcn.clk.socclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dcfclk_deep_sleep_khz = 0;
+		context->bw_ctx.bw.dcn.clk.dramclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.fclk_khz = 0;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.fclk_p_state_change_support = true;
+		context->bw_ctx.bw.dcn.clk.num_ways = 0;
 		goto validate_out;
+	}
 
 	if (!out)
 		goto validate_fail;
-- 
2.53.0




