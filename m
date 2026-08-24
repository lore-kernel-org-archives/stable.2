Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D43435966
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 00:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530331; cv=none; b=JhxMTmljR2F2K+oxJXOS4uP650dc4OMF4KbPYC4GZpJA6KA1NLfO49KEIq26o91kBWsDNYNyZYBJfy+y6LdGnyhszIR7eeBSS/7o+ME/kf5KUCJnBuwjFE/t6Me+56ZMM7/hZA0Fj19Ao8vlhlNQGPgYTW6DYk2GW5W4vkHqEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530331; c=relaxed/simple;
	bh=2y2RqOEvLot05OQfzLAzSN+n8QDNXDlZnMoziXTE2d0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uT9YYGaB9phSpO4Og6320r1bhlMrFMKy5R1IaU1NRGeffTGNnGARRN1kL23G+vXcROLMs7UISqZBiDuQpOiOeFBRTgyq3FHzTm4sWCNoUNW0SRzqBmh5RJf6xdiBlos7pRsfQWFMgS+jdqlmYx+6iBpdy8QRiiO1kxbaxVmYS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IasS7Yhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IasS7Yhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C4D1F000E9;
	Mon, 24 Aug 2026 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530329;
	bh=K02lCec2Sz8Au8IMXQD+6aVgFgwIbvtld0117/JzNso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IasS7YhkB9oIhhKSAz7+SZ+E82ZJPUVIenivykIkPUhyR/Ngqb0ynAyHM8oLAYxTV
	 clafi5KEaSrGRRvvlz63+Ydnq/71VMFW7ns6odHIfS8p7c5lspz4753lANg0CaI7/q
	 O4/RS6ESHZ86x8GXXpnkpnoci3VbUC1/aRLIjBJ2+zGmzJluo+ENJldKn4dsyDQEOH
	 c3KUuqKA+/4QxI1XxEXur2+B9fRB14wwdilmFjJae5MYLiad5a1Nm7L9EbWzZfF0L1
	 1a3fJPpABMB8yHs55sScxG8XYgkHuBsPjjLFkh8S5Eqmwslgetq6e7NZjdqGAbJAl1
	 XGr1QCoAeAh7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junrui Luo <moonafterrain@outlook.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: disallow multiple FENCE chunks in one submit
Date: Sun, 23 Aug 2026 20:12:07 -0400
Message-ID: <20260824001207.2687378-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082049-refocus-deviator-76f3@gregkh>
References: <2026082049-refocus-deviator-76f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Junrui Luo <moonafterrain@outlook.com>

[ Upstream commit 931cd1d1baeae68e8eb2c23bc1f3d8934dca6241 ]

amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
rejecting repeated ids. p->uf_bo is a single-slot field, so a
submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
amdgpu_cs_p1_user_fence() twice, and the second run overwrites
p->uf_bo with a freshly referenced BO without dropping the reference
taken by the first.

amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
chunk but the last leaks a BO reference. The leaked BO outlives handle
close and process exit.

Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
for p->bo_list.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 665b1fc2a1845206408f9a2c6da67101789edb82)
[ adapted `p->uf_bo` to the pre-drm_exec field spelling `p->uf_entry.tv.bo` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index dcf7cd290b889..e9d51002001a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -247,6 +247,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
 
+			/* Only a single user fence is allowed to simplify handling. */
+			if (p->uf_entry.tv.bo)
+				goto free_partial_kdata;
+
 			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
 						      &uf_offset);
 			if (ret)
-- 
2.53.0

