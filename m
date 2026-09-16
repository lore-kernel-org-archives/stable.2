Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524F5013C2
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602178; cv=none; b=CfuvrsI0tMat3U9ce5JKNiu7ABMo1ThxU26/MNtje3sdB+Zc/goIOLQ8ZOowkd+mbjg6mCoWx9uwnQvyrBSQG0IPb7AZxL60qMAObfccLO6j/674LWKWQy8toe5fASKIPgkifNMJHyXQ2UmKYYxayq6kGPZxMRhll1U2LAr5kLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602178; c=relaxed/simple;
	bh=43WcRz7zrAy/HP2yydtyaspJ/neFGs2pienpeVwMh38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZ0f5kI4rSozLYUuxUDrmzCTc5VMgxiexiGbc90wS6lBPrMzuCP+dWI4e1z6LCrA2ZGh0LLdujfeVYZJCmjqfKfZ5tjkqRXJhIJhKrmklg7wlJwtWq3dns6Em33BOmXjx4URfYJgQWssOOHrgGlT3IqL5dJbx8k6VCcivCKKrB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEq5yEf9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEq5yEf9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A11F000FF;
	Wed, 16 Sep 2026 23:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602174;
	bh=Z9yDXwI5ydmA4ym/FNCfbHBqqJDUDy+4c2vPOdnkJGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TEq5yEf9TqA23knNC7EEgxgTlpv+F2vnidd9P2gEJbDBk/Ea2luw2Im8jb7nlH8wT
	 7GPECumOi2qlkI5mWtmA65nyiJFwoOre8GGGG1iPXaZVkGVuzOG57dOr6/fjkbdlR0
	 d0POt0+T/j9tGLKn2qdoDf60KYz6T0aL2PWfnMtppzUf7i1xbxDSNfNshmNeNF5f3g
	 EN3B02ghl4AxGU/OsIwazxKa0ftZhmujR1rqtr5H1UvfqF/f8xF94tuZBtmK6BoehY
	 cDyqjN5ZyI4G4suvN5d6yAcyAUAaSbtbdplIGwQedLKRseJZggPR2mHR/RK4vk+EYy
	 GPV+K4Cg16zLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	intel-xe@lists.freedesktop.org,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches
Date: Wed, 16 Sep 2026 19:42:52 -0400
Message-ID: <20260916234252.3300600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091604-exterior-freestyle-24d9@gregkh>
References: <2026091604-exterior-freestyle-24d9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

[ Upstream commit f5fcf7e638b904397ec0f66d3ea6766ef0cfe25b ]

emit_render_cache_flush() sets PIPE_CONTROL0_HDC_PIPELINE_FLUSH to
flush the L2/HDC data cache before fence signalling, but it never
requests a flush of the LSC untyped L1 data cache via the 'Untyped
Data-Port Cache Flush Enable' bit in PIPE_CONTROL DWord0[11].

Per the Bspec, in 3D pipeline mode HDC Pipeline Flush is documented to
also flush/invalidate the untyped L1 cache, but only depending on how
HDC_CHICKEN0[13:11] is programmed. Starting with MTL, this coupling
between HDC Pipeline Flush and the untyped L1 cache flush no longer
holds in practice, regardless of how HDC_CHICKEN0 is programmed, so
relying on it is not safe on newer platforms such as BMG. Mesa's Vulkan
driver (anv) has been assuming the kernel flushes both caches between
submissions, and hit user-visible corruption in apps such as Llama.cpp
because of this gap; it now works around it by flushing both caches
again from userspace at the end of every command buffer.

Correctness between submissions on the same queue is userspace's
responsibility and belongs in Mesa, not the kernel. However, for
security we must ensure stale data can't leak through the untyped L1
dataport cache once memory is reclaimed or evicted, which requires the
KMD to flush it before releasing memory for reuse.

Prior to MTL, HDC_CHICKEN0 could be programmed (as already done for
DG2 via Wa_22010960976/Wa_14013347512) to reliably keep HDC Pipeline
Flush coupled to the untyped L1 cache flush, so those platforms are
unaffected. Mesa's own anv driver found that on MTL the HW
disconnected the two independently of how HDC_CHICKEN0 is programmed,
and could not bring the old behavior back even by writing the register
by hand; see Mesa commit 7c2ff46a4fc3 ("anv: don't prevent L1 untyped
cache flush in 3D mode"). The kernel can't reliably request the flush
from the CS on MTL either, so restrict the new PIPE_CONTROL bit to
GRAPHICS_VERx100 >= 2000 (Xe2 and later), where it can be relied on.

Explicitly set PIPE_CONTROL0_UNTYPED_DATAPORT_CACHE_FLUSH together
with PIPE_CONTROL0_HDC_PIPELINE_FLUSH in emit_render_cache_flush() on
Xe2 and later, so the L1 data cache is known clean before memory is
released for reuse, without depending on undocumented
platform-specific HDC_CHICKEN0 behavior.

Bspec: 56551
Link: https://gitlab.freedesktop.org/mesa/mesa/-/commit/7c2ff46a4fc3e537573ac9503057e0cd29b6fff3
Fixes: 9f8f93bee3ef ("drm/xe: Emit a render cache flush after each rcs/ccs batch")
Reported-by: Lionel Landwerlin <lionel.g.landwerlin@intel.com>
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/8909
Cc: José Roberto de Souza <jose.souza@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Assisted-by: GitHub_Copilot:claude-sonnet-5
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260903114552.48634-1-thomas.hellstrom@linux.intel.com
(cherry picked from commit 434514b6fe731e873808297c268fc52cdf4a1ce6)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ replaced the inline HDC flush argument to emit_pipe_control() with a new flags0 variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/xe/instructions/xe_gpu_commands.h    |  1 +
 drivers/gpu/drm/xe/xe_ring_ops.c                 | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
index a255946b6f77e..b4fe9aa4e2347 100644
--- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
@@ -41,6 +41,7 @@
 
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
 
+#define	  PIPE_CONTROL0_UNTYPED_DATAPORT_CACHE_FLUSH	BIT(11)	/* gen12 */
 #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
 
 #define   PIPE_CONTROL_COMMAND_CACHE_INVALIDATE		(1<<29)
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index c9e8969f99fc7..50ab1e97ca262 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -174,9 +174,21 @@ static int emit_store_imm_ppgtt_posted(u64 addr, u64 value,
 static int emit_render_cache_flush(struct xe_sched_job *job, u32 *dw, int i)
 {
 	struct xe_gt *gt = job->q->gt;
+	struct xe_device *xe = gt_to_xe(gt);
 	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
-	u32 flags;
+	u32 flags0, flags;
 
+	flags0 = PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
+	/*
+	 * Prior to MTL, HDC Pipeline Flush reliably also flushes the LSC
+	 * untyped L1 dataport cache, provided HDC_CHICKEN0 is programmed
+	 * correctly. Starting with MTL that coupling no longer holds
+	 * regardless of how HDC_CHICKEN0 is programmed, but explicitly
+	 * requesting the flush via PIPE_CONTROL is itself only reliable
+	 * from Xe2 onward, so only gate it in on Xe2+.
+	 */
+	if (GRAPHICS_VERx100(xe) >= 2000)
+		flags0 |= PIPE_CONTROL0_UNTYPED_DATAPORT_CACHE_FLUSH;
 	flags = (PIPE_CONTROL_CS_STALL |
 		 PIPE_CONTROL_TILE_CACHE_FLUSH |
 		 PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH |
@@ -192,7 +204,7 @@ static int emit_render_cache_flush(struct xe_sched_job *job, u32 *dw, int i)
 	else if (job->q->class == XE_ENGINE_CLASS_COMPUTE)
 		flags &= ~PIPE_CONTROL_3D_ENGINE_FLAGS;
 
-	return emit_pipe_control(dw, i, PIPE_CONTROL0_HDC_PIPELINE_FLUSH, flags, 0, 0);
+	return emit_pipe_control(dw, i, flags0, flags, 0, 0);
 }
 
 static int emit_pipe_control_to_ring_end(struct xe_hw_engine *hwe, u32 *dw, int i)
-- 
2.53.0

