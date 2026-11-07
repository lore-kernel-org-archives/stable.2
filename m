Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046392;
	b=eXy32Iy1EBo+uJF6oqjePblRKN8D6aC2h75rov/OC80X+0BMsv7w+O7pGrVDfC7E+LZP
	 b5gzsXkrVFitmBF+g7wblcpUQ0rYagzVUnCyFGCs5sBgsbpgnoLVmAoSyKYNGj5zxPMd2
	 Jn16nRBROOfQiWwx6D9OJvi0NTeek5sTkNaHdsE6lvTQBX7titWnrFg0WC1eNG8chcvU4
	 jA8sOlW+ywxcuRnEDgbroXuaXpUukr/Iy36Inn0GvZhAAbmxJS81deEVI7489RfTkFeOi
	 E02pfGpff7vEbO0FDUSuog30fYUyX+68TEe1MVk+wi4dSJAkgvNc4FhVO/zkBcI7Y4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C3ypugLbMUF/vqiUl/eyuA73jk50U+Ws4EJFzjaM5ug=;
	b=iK75zCcqQ6ekLb9g0mmCwqpqV/iUS52xDpEZdS4CCX2AKIxBli2jWrDK8zgR3nT1Lt8D
	 9xKpwmFOhhTPAaw8q8b2J3A1251WVeDFahgUSjOZ6JYqn5aU5mDUrIrlpef3X7zsCjT1b
	 6k6BOc3cRnDat15RHvt5qJhhzv1fyPy9tVYVbE3qrxcDLqFST9ZEgHfo+T4KVdN1zn1Vs
	 KFfxi6ac0jf2JrwnlTGfajkRrLOFCKKU0SFOXqXUjxmzjBJumjWX0l9oWorsBGH0CEeA/
	 OkvRY8F2tr5JpRsmZOOXx16bH1B2Lg9LsjUk7mHZHjWrxk1SnGAUiJiD7sbV/WG4qAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqnG3FjV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A5606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VqnG3FjV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832C81F0089F;
	Sat,  7 Nov 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046392;
	bh=C3ypugLbMUF/vqiUl/eyuA73jk50U+Ws4EJFzjaM5ug=;
	h=From:To:Cc:Subject:Date;
	b=VqnG3FjVZMSgpXvTmh1+cTT/IJz+9oFAlvJ2r7OVg4eR2+u/lH6MEO/PdgEBQy305
	 X02drAHb5PA21+nC9ObrfvsMV+w1hwvQdyTur5h492SL2l+Wg8usp59wz0CyBHF9Nj
	 DYq4Bhn/sS+N4xgKXJN2hqHaEGNeE/VJvbUjd8m9jYVcrQG8iq5E85bFAeghzi34Jp
	 j1WdqjmjVOfjBatfsN0+mSpOgRtTb9q1yMqbpjSltfFMMyXGhghwr3velPCCC2bZ+g
	 vYtZ2XiKNfLqycFWKZcNNavR+Vt7mpuacdpsj6FA69f2N+PO3FhtoOrEPPCmUme4ln
	 lSlOMBl+QzDHA==
From: Sasha Levin <sashal@kernel.org>
To: wangyan01@kylinos.cn,
	lihaofeng@kylinos.cn,
	gnoack@google.com,
	mic@digikod.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] selftests/landlock: Fix snprintf truncation checks in test files" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:10 -0500
Message-ID: <20261107051310-failed-6.18-8e4c736cffdd@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8e4c736cffdd6b133f6498e0d40ba60dc6819d43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051310-failed-6.18-8e4c736cffdd@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 8e4c736cffdd6b133f6498e0d40ba60dc6819d43 Mon Sep 17 00:00:00 2001
From: Wang Yan <wangyan01@kylinos.cn>
Date: Fri, 26 Jun 2026 15:00:16 +0800
Subject: [PATCH] selftests/landlock: Fix snprintf truncation checks in test
 files
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---
 tools/testing/selftests/landlock/audit_test.c  | 2 +-
 tools/testing/selftests/landlock/net_test.c    | 4 ++--
 tools/testing/selftests/landlock/ptrace_test.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 72b5612375ddb..4bea8c880a4d3 100644
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
index 16afbfdf06bb2..50b637354b51d 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -2878,7 +2878,7 @@ static int matches_auditlog(const int audit_fd, const char *const blockers,
 		log_match_len = snprintf(log_match, sizeof(log_match),
 					 log_with_addrport_tmpl, blockers,
 					 dir_addr, addr, dir_port, port);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
@@ -3173,7 +3173,7 @@ static int matches_log_connect_bound(int audit_fd, const char *const blockers,
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 blockers, addr, lport, addr, dport);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 2644445a9d020..e0e7f95e889b3 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -305,7 +305,7 @@ static int matches_log_ptrace(struct __test_metadata *const _metadata,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, opid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_ACCESS, log_match,
-- 
2.53.0




