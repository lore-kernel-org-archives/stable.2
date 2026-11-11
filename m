Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363470;
	b=IwlwtAuwcG4lYinwi4U2Dc6lZmnr0RKKAbtDxL/NqMT5rvHyiuvC9mtzlye4jx7kVSHb
	 lDjQAvdaWGX9az9jz2Oy+WvI7TOFZI5i/VQrjIuNmZzwJscyTke0Jq/K5ZQ9ji9Uk2Hhk
	 JwHSNkeAdeJMUz5WO9r4AM/7/j0TwOAlCO+xkjOU304jWKwyN6SWzy6kCRN/4aCkU54f+
	 2t0NkBm1E9eG3rAo9ZPbBIwE6GOw4F0vwDkZkP2PRtuxnqZcWLaaAUgtlLaoNCkUfXEaC
	 1RmELqMYjoBth9H8PpH0lMWHx1WjsSysIAvZohGkG4Ts5gIMvzGxqE0Ko8dhlfjxAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ksDU/Y1MWfurb2GeFecfvWbJc/mkRwabChNgwUrLKP0=;
	b=PZ6b/64wx5pScDQd3Xdhu71NB5tS/1RGXWkkHPGfiw6/m1pb1JEMq3ZX3gPJr9uimjbQ
	 6FwDeHu8GZXDmi5mdrl23cDqBawTU60enmKM6fz7SMRr4aPQ/m/mPmverU1bo3AINlpT2
	 sfD1NzkLMA6QSyWGFZuWdkiPxdQK9wzLLYQUIAPamzi4jpqO+5AVekfqafsGiD3AX1rqz
	 JqGik7vXOs7IpENPcpltv/F/9r11qLH3Z495eCf7ZOb0qc8A1kZ+K7m7X3wvUhJwMctK8
	 I6AUIvqqFWneziXktpqsVUIYKQ63XpoMCKOmAAky0COOMpka231eKQmPtPOGrYXT7xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dt7S7Vuz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90177606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dt7S7Vuz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ABB1F0089F;
	Wed, 11 Nov 2026 02:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363470;
	bh=ksDU/Y1MWfurb2GeFecfvWbJc/mkRwabChNgwUrLKP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dt7S7Vuz71FX3/38fRN43dah6Bk8CpjwMg+eLB7X6BDKKsvuzmEEn7kgTSFhYATRN
	 D0pR4h5wZ65qfg2KHQfU0c6ACCuVRtOpXG6FC0yaiMaRL89amHMkDTdcBLAXKN5BT4
	 kQS8SclrEd+FTSLmvPE1pI2HcIUrVP7wJSfDuRtklgDyBTgbZqewBGhe7GZXoTxJ2+
	 WzqiN+rHSWIObOm7zgO7A4BL9mPJEU2QTUNuhjUfV6Za1LjiVP/Uh+BeDJ8Hn8dwMo
	 IqzqUw9XSPsNyh5gvkNg+qVEohstrb6iBu7boQ+vyjSo9hvx4GjsaWjwbjks+/KfEM
	 BRSJ0E8jvlZ+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wang Yan <wangyan01@kylinos.cn>,
	Haofeng Li <lihaofeng@kylinos.cn>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] selftests/landlock: Fix snprintf truncation checks in test files
Date: Tue, 10 Nov 2026 21:17:48 -0500
Message-ID: <20261111021529.581496-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051310-failed-6.18-8e4c736cffdd@kernel.org>
References: <20261107051310-failed-6.18-8e4c736cffdd@kernel.org>
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

From: Wang Yan <wangyan01@kylinos.cn>

[ Upstream commit 8e4c736cffdd6b133f6498e0d40ba60dc6819d43 ]

Commit b566f7a4f0e4 ("selftests/landlock: Fix snprintf truncation checks
in audit helpers") fixed the truncation detection in audit.h by changing
the comparison from ">" to ">=" to correctly handle the edge case where
snprintf returns a value equal to the buffer size.

However, the same pattern exists in ptrace_test.c, audit_test.c, and
net_test.c and was not fixed.  snprintf() returns the number of
characters that would have been written, excluding the terminating NUL
byte.  When the output is truncated, this return value equals or exceeds
the buffer size. The existing ">" check therefore fails to detect
truncation when the return value equals the buffer size.

Fix these remaining instances to use ">=" for truncation detection,
matching the fix in audit.h.

Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
Signed-off-by: Wang Yan <wangyan01@kylinos.cn>
Reviewed-by: Günther Noack <gnoack@google.com>
Link: https://patch.msgid.link/20260626070016.61049-1-wangyan01@kylinos.cn
Cc: stable@vger.kernel.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[ sashal: Adjusted context for the earlier TCP-specific audit helpers with their existing names and formatting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/landlock/audit_test.c  | 2 +-
 tools/testing/selftests/landlock/net_test.c    | 4 ++--
 tools/testing/selftests/landlock/ptrace_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index dcf63b2f822e9..aa6df1b4d42e6 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -31,7 +31,7 @@ static int matches_log_signal(struct __test_metadata *const _metadata,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, opid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 8f3a780d354b7..822c23425d15a 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2067,7 +2067,7 @@ static int matches_log_tcp(const int audit_fd, const char *const blockers,
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 blockers, dir_addr, addr, dir_port);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
@@ -2192,7 +2192,7 @@ static int matches_log_tcp_bound(int audit_fd, const char *const addr,
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 addr, lport, addr, dport);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 4e356334ecb74..22133c5ae6c56 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -446,7 +446,7 @@ static int matches_log_ptrace(struct __test_metadata *const _metadata,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, opid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
-- 
2.53.0

