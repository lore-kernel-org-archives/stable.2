Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF92430CE3
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240053; cv=none; b=gO2uxth/WnIr5sxo7zn+9jSKiHY6coTPFDS8eJX9nvjsM+jOJFNPzA5RK3oYxhrr6Llv49iRVxCDtdqhXTXIpHBmYiP86KRpxwLVpktOEa76pgzHRpz2GXHtCbyL/5mH6uoq3Bx+CneqYilZA9eWWTN4cVqQgv7s93GUJccZpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240053; c=relaxed/simple;
	bh=fJlbScjmtyEtvIYTXjt3WjCSOyEuLft4sXnqsrxFAlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keJmfNclNgUt4vcUtmpFI1lWEIbU/KJLfxGAeS90mozCzlUNytIH/bmO/bdSmXYtq0NFh7EvEJcCx4sQZ6wOVOYydVHCntheJhuQMYtiO/4FyXiRDdB9J2Ub91/4RpW+A1o6UGaBMDkWPe5qPr+uWMRlPtsZr9qu9QSwJF8Bgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG3a35fA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG3a35fA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C451F00898;
	Mon,  5 Oct 2026 22:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240046;
	bh=BevOX2qaHxTT69qFnlf1/gkv6Cp5fHZz0K7MjeTd/QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HG3a35fARECRDEl6ProKZX/J+LpAlSqanuGi7KWy1oWPlgK8X3QOtyNuLYdbwRov6
	 gQ0oRDdAZl+zc6T4bu1vOoBzAproJagRdIUSzkQ2404X40C3FpSUjPHkm3mMbLXLQF
	 qCWn5zrWdG4xaJSdh0CsF7IIQFLSpNJ6GJWRdhZ6jIS5KJFQzBPsK9zqCuSq/4pf2Q
	 CRfloY9oq4nUqDjaC2y8QQApY34DR3uz2IVFU1oQNiuYnDWe4ih0f1bMM4wBKpjwiO
	 oCVE5H32UqSUkUsHqho5w6EPZ9eBYSK0dGbb+M4mNpY+wCaAgFDJaEYQjrR2admB1i
	 k2KMlc0lGYuEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] perf: Require kernel access for text poke events
Date: Mon,  5 Oct 2026 18:40:42 -0400
Message-ID: <20261005224004.3467502-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100517-unfixed-scale-50cd@gregkh>
References: <2026100517-unfixed-scale-50cd@gregkh>
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
[ sashal: Adjusted context for the missing kernel-callchain condition while retaining perf_allow_kernel(&attr). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a986ed1ad221a..3169742fd98ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12647,7 +12647,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || attr.text_poke) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
-- 
2.53.0

