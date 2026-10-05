Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AEB3EDE57
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235443; cv=none; b=eCgT365QQxPU+fNITPlmKYm/d0Aul8R9w0WoJj+E+f8n59UnDXltO5AbJ9j90zOLFK++jw5efY3Lvlk/gJ4/qS8/t5q9xbkNJSGL87JBpDBJA20/hTCrKFwvL/OPkxn9AP54iNF3MbuIU4GwIttnRSxjZEexo0PslU7LAmUO/VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235443; c=relaxed/simple;
	bh=Ne6syEfPdmQSlFwzA4IK8dOh/QhJbxx2f67ofMR3m3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u5yP5i70H5wCPgdses07wWRo0mn9KH25tbYsmqy1t9gY9Wd8GKzuB56eNxsBO2LY12qDvlY5NfMbvQd3CVbKuUQD0BQ2KvQDIqvo1dRFHwpyPuoUMkxAKAUGlNuOfbpX8GLUiQUicIcWZXR6GYCqKnnlfV8sj9bmUoT2EoOpk9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6DDbORq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6DDbORq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3361F00893;
	Mon,  5 Oct 2026 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235442;
	bh=DUpjtR3En+BvgSWK2hYjiwZrxHNUtG8REZMmQfB0i18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6DDbORq9wLfZKd2m2tASpajb9fcGxJanA0A/GbkPdURgT3kk+Zpsbwki2oHiCC4O
	 U5xBwzlYFNvf5PltW6fgbTRlSBJtEOLXtrdRYnY2ac+H8nJm59ouLBA2taHmvRhk7s
	 n/Xt4WC/nPvyOo3YcCDb7Xf2iQGc5EPgA9eXFHHeE2vV0UIa/3naxwo6vWdwr8V/tG
	 d1yO/x3ysxuG8HRSzmEdbnqlC4wDs4BFuP/2mNkp2jnW6B/ohhu1IMn6eHPdYc+LJ+
	 lSxmvBSSM7ysXByStJUfAt6mw1cvlWwfU0rv+B065TCF9a35bCAITRLr/B2PYym3WL
	 8+pKf8BIBa1bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhengchuan Liang <zcliangcn@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] perf: Require kernel access for text poke events
Date: Mon,  5 Oct 2026 17:23:57 -0400
Message-ID: <20261005212346.3373480-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005212346.3373480-1-sashal@kernel.org>
References: <2026100516-douche-preview-30a6@gregkh>
 <20261005212346.3373480-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c3166d50ec7b..4959b287f589d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13882,7 +13882,7 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel ||
+	if (!attr.exclude_kernel || attr.text_poke ||
 	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
 	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
-- 
2.53.0

