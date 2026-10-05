Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4ED37A496
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236841; cv=none; b=NED+DhMUAgMbWo2795lAJuR4u3/i6DimibW7V47CCUjVasdDXDAL1aRjGUiAXbL3WxKrUs4wHEGBeWDJDDS/kemZznR3hRSCntkRlLcKldjh0AmFownBLNJ3mY2qS0DbmPRzZZPBMC2Cm1yYjVNAluoR+gKDXfQ/n05Q8DR3HL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236841; c=relaxed/simple;
	bh=KKxCgwlNnpw2IehIlRxAKEflKU3u5YtSJ4Pef2ERhzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6Yl5HwXqWDLutWu4AedzHJMQ9w5LFfTr2da2dQXBMjr9uQmRJomqkAoS9t+btXtJOz4UWJeNZPy+qWGStlIcZzAUpsi3U5wNB4XNnYVWkwrTNF/qwgZcuWlKC9vnVNu0GLeWDBL7kUqzgs5WzolRtyWxKNMIyA2XI1+7hEwjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4xMiswQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4xMiswQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0931F000FF;
	Mon,  5 Oct 2026 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236840;
	bh=KNGbQtey5Q9ggaRwpb8vK74XSXcEINvVmpf76A84fnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4xMiswQPtLo78lC+WY5jP/JzlEvbnyofnAe6aYLTnCjpggCJGpx3kuMQOCS6Jsh8
	 gZyZrpUFXG6S0A81X7bkri5beWYwTDFWRxUYuOJaxz4myGXnx3KGlhNfXmrA4YCKWy
	 HUCDfh0E6fZuP42YLjhJHWE/CPrejdOJi6buhE3xUmtVC5BDGeOmcUxcdqbPcG/ZRE
	 J8CYlHsiBxdzBivGAI5eA17jO41EaGVN1MXIk5IZFMBxwhro+FNmbLjfiq0hmVC5eH
	 dXaIuoVVwndCziVO8zX0vAOwRg+onupHbaT1lWMiKUvSmuV/kmBRyC+Zht6TPU1h1y
	 +R/NUzNYmiJ7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] perf/core: Check kernel access when kernel callchains are requested
Date: Mon,  5 Oct 2026 17:47:15 -0400
Message-ID: <20261005214657.3401268-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100516-headstone-video-e3d0@gregkh>
References: <2026100516-headstone-video-e3d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit a4573a3838ae4fc73b70019cfa1dac9aaea7cc2f ]

perf_event_open() currently gates perf_allow_kernel() only on
!attr.exclude_kernel.

However, users can still request kernel callchain collection with
attr.exclude_callchain_kernel == 0 even when attr.exclude_kernel == 1.
That still requires kernel profiling privilege, but the existing check
does not enforce it.

Update the permission check to call perf_allow_kernel() when either
kernel sampling is requested or kernel callchains are requested.

This keeps permission checks aligned with requested data and prevents
unprivileged use of kernel callchain capture.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260616044654.3468742-9-dapeng1.mi@linux.intel.com
Stable-dep-of: 357e8a77a501 ("perf: Require kernel access for text poke events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index d56ad3736e152..8f112f12cc3ce 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13536,7 +13536,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel ||
+	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
 			return err;
-- 
2.53.0

