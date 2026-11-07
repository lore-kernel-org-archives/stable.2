Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045780;
	b=e8oUTKlTXw6hu+w0beCh9d9X+4MbKwWVNOHvenBw8YLQT7h7lAfcwLZ4O9F2Yqh0kA3A
	 9EfzB363qCyJ2flvOGVlJPdC44VLX0NpDCYaZ+4QMk3lagmJdOaHKZ1Kei8E4L8Cyrh4d
	 Ue30Hs7ifJ8hH/5YInvUeRUVGdN58the31wHu0Bi5tN9yLowfLYcPXO2CcprUZ10hYzQk
	 LRA/DoVL9KkYS6HCuWvOUhEGDCovNZUVN1jP2pEY3jDHhbgX+3fUCQrLASDlrATppeXbo
	 wkbDAqaOq/9Eo6x71BplLFF8o883cd++lgbB+oJdR6+CRafOtIGmulQUXh7W3VKEuYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045780;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=2zBGIB59Ep+I5HOc01aNWMX+w+lm5BVlL2kgwHjyZ1w=;
	b=xFkLqG4HCCjih0UzO/4CkglUb0idXj1aDoSEasYgZjsHuf5CcOqrc9yd9s+Ulw9OR/Ia
	 PwEIHowXbWCgN1eQna7Re6j7gi9AgpT66AbGXxQOnjlLWfH5m6FRJ1UwYK1BrBwcjAa/6
	 P588K3NVOjE1jeR3ZsHzCdLWcLMlSJcFEY75sjQ/KD3hCMA34sCI8zRZKcJxJ37To5tdu
	 8NlIhNMG7i4NZWqxUsvhla7trJ44YYc1HnpVJJLFtlP8gPD1jx6v0GjMmorUO4/dHo7zH
	 FMyTdubQjLFj8xjEb8qjHVkDK5SEMdcTKqQr31ElCkmI+dzYamh8iYr6qkd0U2CJ83A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XotUVbXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A996606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XotUVbXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9C01F0089F;
	Sat,  7 Nov 2026 10:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045780;
	bh=2zBGIB59Ep+I5HOc01aNWMX+w+lm5BVlL2kgwHjyZ1w=;
	h=From:To:Cc:Subject:Date;
	b=XotUVbXn5LPZZuY9Ddca6ZkX9JGUVvIvpdlEwOE4wBnTo9HcYmOPZuTSswpdcuoD9
	 /C3RNA44XEUuvl/8FHxOpYsxPnrDP0PIXHk5ggUqpZKEj4iRV3abfg8NJRhLwYaJDT
	 bM2PQALs1EkmXF3qzhGgYC/5FYcl0D1X/lfgtabqmVit0wDBYne1JoiZns+iCaKols
	 EaNgbl1H6w+VV+rlcuCrBlYPeg0RXVM7CETh6QoTQHNCXl2vDYZ8snXgQ+OsC7KRox
	 /Q2+mZ7abLFPAJexFq5gllp+8njc+rx3qnHPyXhQzjq1znQq9JxoOKBGdBzH8v64vs
	 x6UojccdcmH3A==
From: Sasha Levin <sashal@kernel.org>
To: thomas.hellstrom@linux.intel.com,
	lionel.g.landwerlin@intel.com,
	jose.souza@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:58 -0500
Message-ID: <20261107050258-failed-7.3-434514b6fe73@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 434514b6fe731e873808297c268fc52cdf4a1ce6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050258-failed-7.3-434514b6fe73@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 434514b6fe731e873808297c268fc52cdf4a1ce6 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Thu, 3 Sep 2026 13:45:52 +0200
Subject: [PATCH] drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs
 batches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
 drivers/gpu/drm/xe/xe_ring_ops.c                  | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
index 18d0fde8c98f9..faf8d7e2c5c11 100644
--- a/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_gpu_commands.h
@@ -46,6 +46,7 @@
 #define GFX_OP_PIPE_CONTROL(len)	((0x3<<29)|(0x3<<27)|(0x2<<24)|((len)-2))
 
 #define   PIPE_CONTROL0_QUEUE_DRAIN_MODE		BIT(12)
+#define	  PIPE_CONTROL0_UNTYPED_DATAPORT_CACHE_FLUSH	BIT(11)	/* gen12 */
 #define	  PIPE_CONTROL0_L3_READ_ONLY_CACHE_INVALIDATE	BIT(10)	/* gen12 */
 #define	  PIPE_CONTROL0_HDC_PIPELINE_FLUSH		BIT(9)	/* gen12 */
 
diff --git a/drivers/gpu/drm/xe/xe_ring_ops.c b/drivers/gpu/drm/xe/xe_ring_ops.c
index 39a670e91ba72..08b4a4283e96a 100644
--- a/drivers/gpu/drm/xe/xe_ring_ops.c
+++ b/drivers/gpu/drm/xe/xe_ring_ops.c
@@ -212,6 +212,7 @@ static int emit_render_cache_flush(struct xe_sched_job *job, u32 *dw, int i)
 {
 	struct xe_exec_queue *q = job->q;
 	struct xe_gt *gt = q->gt;
+	struct xe_device *xe = gt_to_xe(gt);
 	bool lacks_render = !(gt->info.engine_mask & XE_HW_ENGINE_RCS_MASK);
 	u32 flags0, flags1;
 
@@ -220,6 +221,16 @@ static int emit_render_cache_flush(struct xe_sched_job *job, u32 *dw, int i)
 				      LRC_PPHWSP_FLUSH_INVAL_SCRATCH_ADDR, 0);
 
 	flags0 = PIPE_CONTROL0_HDC_PIPELINE_FLUSH;
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
 	flags1 = (PIPE_CONTROL_TILE_CACHE_FLUSH |
 		 PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH |
 		 PIPE_CONTROL_DEPTH_CACHE_FLUSH |
-- 
2.53.0




