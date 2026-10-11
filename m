Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076B8367F2F;
	Sun, 11 Oct 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758048; cv=none; b=WEGSfUBCjs+EB0mwWswypo9uVCYZUclSgjak8OwxWIrHvSpSUuGjfsUyjYH9j8OMmTSd35D/RZ/dOSV0I4OFM1E652pE+Xkss8Fql3bPaKbqO9ULhuv/agf/y6bDVtAZbbWiK9HJ0SXw0lONvMyOghHZiEl97RiO1LRktEk8cUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758048; c=relaxed/simple;
	bh=WMwOo6ZHJKM/+LALDpbbjM9jBR11NdKWAMF74UFsLrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MwLYA9eh+2aHCOVg30JaZuTzBsYupNOwh3GfUwLCPmMgivanQ5N+/PWBfsjIkqLoQokj+vbb3kx2EV67XTH/k2pS50cPxgX0EhIgHd+E5BY5gCjcszhZVEF+C/Ha4OqiRRUxY+T4Hk17sR9oP3k8S/GKUUtXwRXaepcw2z+P9/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWg7LNYM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWg7LNYM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165C01F0089B;
	Sun, 11 Oct 2026 22:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758046;
	bh=KveST5rNXakYwiTZc2jZX+M6zkjSYi3PzHAhaxZQntc=;
	h=From:To:Cc:Subject:Date;
	b=ZWg7LNYMNOg7qU7BoIOsjZVrBe8UUuoSdqCxIrzRWiqh/LNIDk3ZSFcADaCDsI7yv
	 SUAQyuWqT8CJh/5v+3YjOo/tpS8Jjt7zPyGJmnoPQv3EzAgQavWg7MvC92JqXc4R+Q
	 rlFgTahUzXstoo6epRyh4Ei9tRdG0pVot5Imug6pfaATdMF4hrrglxCtgA3ZgBQXUI
	 q3VNdhI9/xsv2BRIi2wIYV8IYeMDbTCbZGT6Q6TZYwYAQ1PHjMs1regCPpM5BzH1Pm
	 wOh8rMNhhZHfWo7lag2CEYxonJpLsKDRVZuQjr/IiYIpBRFlksnrKzr37fS7+hvh0x
	 5qnnNh7ddy2yA==
From: Sasha Levin <sashal@kernel.org>
To: Barry Song <baohua@kernel.org>,
	Qinxin Xia <xiaqinxin@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] tools/dma: fix building from the top level with O=
Date: Sun, 11 Oct 2026 18:33:32 -0400
Message-ID: <20261011223358.2327625-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"make O=<dir> tools/dma" fails:

  Makefile:27: /tools/build/Makefile.include: No such file or directory

tools/Makefile clears srctree, and the dma Makefile only works it out
again when building_out_of_srctree is not set, which the top-level
Makefile sets for O= builds.

Also work out srctree when it is empty, as tools/bpf/Makefile does
since commit a89b2cbf71d64 ("tools, bpf: Fix build for 'make -s
tools/bpf O=<dir>'").

Fixes: f74ee32963f1b ("tools/dma: move dma_map_benchmark from selftests to tools/dma")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/dma/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/dma/Makefile b/tools/dma/Makefile
index 0c239a6b9eae5..20ae7f09cd206 100644
--- a/tools/dma/Makefile
+++ b/tools/dma/Makefile
@@ -7,7 +7,13 @@ bindir ?= /usr/bin
 # isn't set and when invoked from selftests build, where srctree
 # is set to ".". building_out_of_srctree is undefined for in srctree
 # builds
+ifeq ($(srctree),)
+update_srctree := 1
+endif
 ifndef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
-- 
2.53.0

