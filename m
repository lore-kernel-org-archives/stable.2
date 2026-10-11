Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3F6469829;
	Sun, 11 Oct 2026 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758046; cv=none; b=UjaxECL1NJeICM7g42tsV1RIkgIJQA9e9L/K1x5CWHwcGbkDqjamQ9TM+Zo9Fb/5GTki7RbVTMBjM418Okz55+yXaMooXn0kK+yKOlEp4TmtdLVY8c7K7Yw//0R3ScOWcwm2+Qq6E/QJtBJPh/GINUUG35Y0xpWtNohMPuvQhPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758046; c=relaxed/simple;
	bh=+dKFlC8W3vOE1tGAfuaZ2p2Uv1/GeOYR8teClFiYmEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W/eEyEmvauzMaxRUTjX6hZCjcgYdt5zfndwrcAiJ4oTogA4F+bwa8QZkw6Jnb9/f6H5b25vEyK1v4pg4WgQzZ3TfL+Vkpk+cFTpNiKKJXnL/r6t5MJpsf3qlaAgXt9rtJ4BtwqUS2eL7OdCCQrP3r0HmNtSugxT1sfpQG97N6ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSUIsz0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSUIsz0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390861F0089B;
	Sun, 11 Oct 2026 22:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758045;
	bh=9ApxRjIgXaJO/vkqe1GeUvOEuj9GXvGm5LSP/tDliAY=;
	h=From:To:Cc:Subject:Date;
	b=lSUIsz0MKqNONShNq08Z1d1HB9gXmXJwmS3aYNKF3f8zkxiLuSUsS0/yyxCOHl3fH
	 E7GdaVUF7chCAftRh5y4PfNo1fUDg1tpS/Ws7Mx35I1h3vyJccBNg/zWmKCkoRKf9f
	 sMI4neydK//Lns5BRlTdvDz/nJsmfBoiABUV+eRc2QAan286HgYj3sy/K18uu8N+lz
	 zo4OUIUdl4gDXuVRuE5u5NrtGMxdv8PdlY0hspTC2TLsAEsRUlF3rloMDI+Ik4raPp
	 Jem8O44pyiLZes3emkj7795d3FfqePeOY6K04kxreKuMtYPBldUu3xRgvrXegl6Qf4
	 7vE2sYJgSMgmA==
From: Sasha Levin <sashal@kernel.org>
To: Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/dma: fix building with O=
Date: Sun, 11 Oct 2026 18:33:31 -0400
Message-ID: <20261011223358.2327625-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With O= set, "all" depends on $(OUTPUT)dma_map_benchmark, but the only
rule builds dma_map_benchmark in the source directory, and built-in
rules are disabled:

  make: *** No rule to make target '<O>/dma_map_benchmark', needed by 'all'.  Stop.

Build $(OUTPUT)dma_map_benchmark.

Fixes: f74ee32963f1b ("tools/dma: move dma_map_benchmark from selftests to tools/dma")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/dma/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/dma/Makefile b/tools/dma/Makefile
index e4abf37bf020c..0c239a6b9eae5 100644
--- a/tools/dma/Makefile
+++ b/tools/dma/Makefile
@@ -38,8 +38,8 @@ prepare: $(OUTPUT)include/linux/map_benchmark.h
 FORCE:
 
 DMA_MAP_BENCHMARK = dma_map_benchmark
-$(DMA_MAP_BENCHMARK): prepare FORCE
-	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $(DMA_MAP_BENCHMARK)
+$(OUTPUT)$(DMA_MAP_BENCHMARK): prepare FORCE
+	$(CC) $(CFLAGS) $(DMA_MAP_BENCHMARK).c -o $@
 
 clean:
 	rm -f $(ALL_PROGRAMS)
-- 
2.53.0

