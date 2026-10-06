Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1123CEBB7
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274153; cv=none; b=ZyhwSiY17PdiVAHgRb/6p40HZJ6YiNJTc5/X0oBYZWfuW0kSa+jufWRDSYEzK4OBWy2QeYocbWlaoSgF/QVusZPVr10bi2FagsonNYtElhQp59nLjYqhB1Fq0ToU5zeTsTTaA8h4XOLbr7aTn+mKKPUYvj5hd0ZoQbJLf2yotHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274153; c=relaxed/simple;
	bh=UXIUZGXDxpU9p35NU4Ygc0QdhCkmVkMiOs0jr83mSig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tYXKfkB11o30YAMc1f3qAvCiIK0TiQMQlZ63qU7Bq8DvHuB3sQyKDiHtHxLpFDYN0fMqjpUZGO8j0DhbFltTgIiQEray2aSAiVtbmrEGVgGhvLFGDKPZ8QwigDJI96phQaMA1YnM5Up2HUwkg+PGzinGuri4w94sW/KLMsIRCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXLEZOX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXLEZOX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165061F000FF;
	Tue,  6 Oct 2026 08:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274152;
	bh=Va99LV2q9hcYc4MPnUqxreznQK3nOMoirCf1D/rm6SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXLEZOX/96Wgxf5bNMVbbWMVRrH3pFxnvAPeSrHYmgEtFBI26gfmNr+DxuxRfDxtm
	 xVa6I7cpePXNhvA9HfrBzbQFW3+pOs61H4GS0VyGldl492tUyfuvhjEZqMSPJPygic
	 j2DyJt5lXxx7POFR2d7EVM9T7dfjAF1ZYpZolZ9VaU0VWrJ4AmtOM0ymM+BZXP7phT
	 AeSCQqZTdX6vUfvtfJNTCxDczPOp2jvwrZfhtw7c/jUdgUuw0/13FcG9TZoX9l94jS
	 xtd+TyccPAu8/EN/NhNAXm4TApiyWXrkrgJdSasIepu1ynp1MiD+OYwRwogU/U14T4
	 bemWClcK5h9TA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] perf: Require kernel access for text poke events
Date: Tue,  6 Oct 2026 04:09:06 -0400
Message-ID: <20261006080814.3620722-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100518-pronto-overplant-dd1b@gregkh>
References: <2026100518-pronto-overplant-dd1b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit 357e8a77a501d96c9517f01f4a211eed5e9c9184 ]

Perf events with exclude_kernel=1 can be opened without kernel perf
access. However, exclude_kernel does not suppress text-poke sideband
records. Every PERF_RECORD_TEXT_POKE is marked PERF_RECORD_MISC_KERNEL
and contains a raw kernel instruction address.

An unprivileged task can therefore open and mmap a task-local software
event with text_poke=1. Both opening a count-only tracepoint event and
configuring UDP GRO for ESP-in-UDP cause updates to inline static calls;
the observer receives the relocated addresses of the modified instructions.
For a known kernel image, any such address reveals the runtime kernel
text base despite KASLR.

Call perf_allow_kernel() whenever attr.text_poke is set, regardless of
exclude_kernel. Events that neither monitor kernel execution nor request
text-poke records retain their existing permissions.

Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Assisted-by: LLM
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/99131354c41e23188f778b92f90363775b482395.1790573390.git.zcliangcn@gmail.com
[ sashal: Adjusted context because the existing exclude_kernel check lacks the callchain condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e350e8d1fb188..fc2d2f2734459 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12427,7 +12427,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || attr.text_poke) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
-- 
2.53.0

