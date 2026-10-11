Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018934657D0;
	Sun, 11 Oct 2026 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791758049; cv=none; b=LiPjJr0xhTYFxv85ugpz2WOYTVOgv8OX4YZRrpCfjeTC+HEj9zqQAT2w5r3O78ypAQ3p9ertDsUDR3cxpXl/lDrG7iQ4FjGbu7xgIAnSedaSmR0XbhvMgn4RKRzFGphbWI/Cif37WBI9KkesZ9Zv5swffmeJIY+44UCDWPDwKXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791758049; c=relaxed/simple;
	bh=o1+v7Sz1ngSUQFXjenftpDZyVoDzwAMbydX+OrkDo2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4AIdudthnlk4iW3IPIsQWOViRbx/GqFnBBTU0qcokZu+loHR81jWUPgOr7YH7l2pF7J5VZ/mypaONCPYMEjdJxcO9k3L1hT9+yv9Dx2GDiQVAAcONr1/ekFkol6mvnY32JEJcyfpuWBiY4Bdj7guQAfYWUuhbIqISx18vpV+zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OU5yzbnI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU5yzbnI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F2D1F0089C;
	Sun, 11 Oct 2026 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791758048;
	bh=FQ5LhxSlGfDYZPptBMBWJk+3azBNynEB4pGObOBbqno=;
	h=From:To:Cc:Subject:Date;
	b=OU5yzbnIo7CNHGCr/MNFPfuHWkQ2AdnE06NlLk6ZZ3S5m6J2OJUk9T9UOCCOF6W58
	 dRQyHrZf17P+1jSsXAJe6sxk8R2G2hB/fM3emXheO/g0/93oGm0ep3YYtlFBD2FdsA
	 HJjl9yUBAvNhBUZpExgbJFgqmiPqDA9vPUZ5NCffKQlWCs2BKdAqxQ0VhhsJ83DdpI
	 AndzQP3KOyZa3kZF7WZzgH+RJd1FUW01f/AvXGrhUnZXCqsujEeWmgot+3lKwN+oB+
	 xzy3nvBTmkSLRWtTsrjgz+1A1Bx956BoO5DuBvuqTtf4/wniw+K/iKkdnhaXKVR1uw
	 XSDOiCtRsK/VQ==
From: Sasha Levin <sashal@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] tools: gpio: fix building from the top level with O=
Date: Sun, 11 Oct 2026 18:33:33 -0400
Message-ID: <20261011223358.2327625-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"make O=<dir> tools/gpio" fails:

  Makefile:27: /tools/build/Makefile.include: No such file or directory

tools/Makefile clears srctree, and the gpio Makefile only works it out
again when building_out_of_srctree is not set, which the top-level
Makefile sets for O= builds.

Also work out srctree when it is empty, as tools/bpf/Makefile does
since commit a89b2cbf71d64 ("tools, bpf: Fix build for 'make -s
tools/bpf O=<dir>'").

Fixes: 4a6a6f5c4aeed ("tools: gpio: Use !building_out_of_srctree to determine srctree")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/gpio/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 342e056c8c665..1cd7636b9cac5 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
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

