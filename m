Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054413B71DC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276170; cv=none; b=JQSikLJmkgPdGV5r4s59j4eMTQ28YUBL80y/aB2Lpb5y49ZESmvgyh+DcsOrCctEDpZzd5QcJBeNfvcfeq4KngHhjtA90CgAPXLoc7Z4QlBcI4kKv9mGue7E3N7IxP7l6EiP1GobWWRaXSn9dkfpwyjc54iEQpsS7JsrezY7su0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276170; c=relaxed/simple;
	bh=yfEgCaOTIHbJUfF3+F5zbkzUHR62U4imp7kmqLi9MS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHnOfC4eixZSyON23sHdTUAa6mAYz6cSR+YNL2tAds3yhWTxVNMCcjYaWNFEZFEb5clhv5Il6df1YElaN4pBd1YfBr1guUAcOOcqHj1a1HigUBB72a7/8ZSi3ySJLhTKSUbcsn6LulHNRAhYQM025E0epVfzXFK4qJI/OK7l2Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/c7/XhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/c7/XhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9F11F000FF;
	Tue,  6 Oct 2026 08:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276168;
	bh=yb7lAQCnwWtdeRAU6rviCdekHQcxcn9H7Mo8FaYo5R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j/c7/XhAgqNfbUv+MJ52mJ9JNtNTpZCZ+SgcrSI3l4QuUXJxUBjWsuAqdXG0LyHct
	 z+aCldd5LFiP3Ex9BUZQq0CnzR+23iWE9iojmV2twtIL47iP+j04mke4HJwMBJlhlx
	 BBr9mfZ329ZClysVSISR24ySODU4L+Ufx+Cn5Nai8gQ07RVlkUyy098x1dpSoP7ApW
	 Nq+eEXRsy4CwTV+hug6++LYxhlG/rS73LCu7cK3uNH4f+euDzeNnLuipp4jdFGjjpu
	 fmzBhZFl0sn9qcK+IBRujDVn7dvT4BoP3tyGcxL7eQ2J4078R8N+CvZaNEV1xvjJBz
	 MCXMbzyIlgAwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] perf: Require kernel access for text poke events
Date: Tue,  6 Oct 2026 04:42:45 -0400
Message-ID: <20261006084154.3863735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100518-claim-liftoff-8d9a@gregkh>
References: <2026100518-claim-liftoff-8d9a@gregkh>
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
[ sashal: Adapted the condition to the existing exclude_kernel check without callchain checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 68df0d569f4c2..d08c276dffa83 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11936,7 +11936,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel || attr.text_poke) {
 		err = perf_allow_kernel(&attr);
 		if (err)
 			return err;
-- 
2.53.0

