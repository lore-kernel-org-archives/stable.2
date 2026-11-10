Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273560;
	b=QIMUTZelZ+4hzuTfcaERlzuKz+UPL9LpZp8a/SINzCtCc5b49QmvAER/Ly7oXN+McGaL
	 6MYt82cp+3nkk81oMnxpT5uZox3m+obIqf2ZuV9JKlQUdc2pA3UdusyR3ANybPGAfZIaf
	 ey5oOOSS6Rfo5gXcNqHlR6GJyOt5CEXciwGB/FfS8nScZFtFCGUfGsVUxUGqLQTkKHXIJ
	 2T3YVW9c448y2S3tTlrA4vMhsT/QAi3jhRVxMWN1JpJSJ7c+Idyy6K8dr54IqXrpVfqI3
	 0soNGPcjvqid/peOxsvO0ZnbJh5p/IIGZb5Nj8egZ/y5inXDXmK4cRBMLCaNp8/yfuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LPJxMmqIu34g5dYRnrnyq3MC0famBiFzLssTRJfX304=;
	b=V7+M72vnBPUDfE90FtMlJfS5X3R2yyPGHFnROQSuMttpekMeMEZDNpyelnTLwEYWJjW6
	 PyzCUTFphzJACwZFVOPA0Nojc/gd+/R0zWWnjZfQ4GzCLRsV+FkZ7pbtDA9YLV0L88wqW
	 R6uhLvdBig1uuv5pFKyDHyrhfPaGppkvHZtodk5hY5dfYXMi43RhwjfhRL+dm5w0h14Sp
	 7j7CrxGz6miwsB3O/9gxrCjdklbVM0Yq8mTaPLHzdg4V69YI9dOIZBRSyNHvWt1ocnKun
	 CamXYkMQv4pyOKeZ+Fwzaw3ASEw5Z/KRYGGKIAta67HZXG/rWiPdWfYkVc9vgIgAszQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYNjKAQn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587B5606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYNjKAQn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02111F0089F;
	Tue, 10 Nov 2026 01:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273560;
	bh=LPJxMmqIu34g5dYRnrnyq3MC0famBiFzLssTRJfX304=;
	h=From:To:Cc:Subject:Date;
	b=cYNjKAQnthpFp7qj4VtxJV7CkGOBGHURJ+XmT+Fh24L0i4K2dG599EfkWX7xYSaWd
	 lxCXFltGtVl7Qmhneqi8vZJuY0rYwyM6RkkJpWyQDfXDW6nqwfIYCo7ye2mey0+/cf
	 kfCsgTjJf+44/rp7snFa1xoyaWQv4UCM888rRqjy1bJwNDPQcGZuTZHYK7105Pg5qO
	 1a5Kgi1VcR5xB9nqfH7E6Pn7+MCnW0OYZ9HzczgGR2Eyz5EVIYpYc26NlKzydvUdaN
	 Cvnqey3Qmuem3zFoOzZbn7Tvy6H8bDZWZVKf6Q0MNXU7wJCaCjFFP0KuLEnto7cot5
	 8JrxVsRol51gQ==
From: Sasha Levin <sashal@kernel.org>
To: misha@nasledov.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Drop clock requirements on DCN32 when no displays are active" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:18 -0500
Message-ID: <20261109201918-failed-6.1-bba4dc330648@kernel.org>
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
git cherry-pick -x bba4dc3306483335ddbe065c05b2d8359ec387a4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201918-failed-6.1-bba4dc330648@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




