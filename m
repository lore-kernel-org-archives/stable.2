Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805905;
	b=zsNsGRUiZT7WXDGuxDV3JAEA1uml4zAfaaVJXnHemCraysgFPvzWr3qn2Pnd7aK61g07
	 x31J7Nu4ZfNzrjJP7AO7i+ngzWqFX8p8FX7ra8nScwBC3xWgupHFl4+rj5vjieeLxus4e
	 cJeaLTmrRTC5l3EpVgncIMLUO4mpha/fojYKgyukwmZ29aJ+HpkLeNmu4wxZZx1s13h48
	 Fs2n1qNgNfn4uPf2GS+JxNB8N6gR2xUnUkUxFcZfPbBX59oFezZZdZ2tFbLtTzCNA9kpG
	 ImE9w/YMblcc1E/4sQN8mVjxaTpQMW5vLYeYC1jzdMzu1oyu2RH7yDGDYXmKx3n62og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805905;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Aa+Ay1/zkX9mW1dHapCcJ29KkN3LrR+HogZO/SC57M4=;
	b=OGXZSxPKNzdoyno7wd8vy5+GZUnv92FzpWbu2YGyTaijngqgJBZSUbmIBSFDfWjoewGR
	 aE1Ft+a7R2AAI0XeCJATqnmvttCAiGCyVc1G3hSpbUlV/k5kQSAKjkd0mRJZ+YvM4UnF3
	 w7dQ6sb6v/ENwNys5kX02jxjCkpnFd5qCujOf57EUfBhjx7tNp5JAFUZcSLvsYMFPrmvJ
	 BnEgpgGGlmP2yXS7kx52bX7JQt5KvUSDzhxiy8M5hQgf04OQn01i5QE2RvNt+Vl4EhrVV
	 sQx7FMtL5wPXCZ3KGzVLrRhgx+FvzoliUTRmWQ4I2pPDlh+zXuEgM+zFBsRHII9WMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ImjIGOm9;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC448606A31C;
	Fri, 27 Nov 2026 18:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC448606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=ImjIGOm9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795805904;
	bh=Aa+Ay1/zkX9mW1dHapCcJ29KkN3LrR+HogZO/SC57M4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImjIGOm9KBmBZq1yg97FtzfwnbsEC39679+1JVcBe6Ue12OL169nn8f3I/uvs2PAU
	 C9N7qLzKlqyTIRKhDiIkhC+l38b26VOQeryebzOMRZnUY+U4/YXmta9LEUajsbv/aY
	 Qjr+rv35GACypyc9mz3Dkhnj9er9tYSRzXi5nwzOKhA8MgpbAGsLL9QGnQHDsN7Sxe
	 loQ3rwokmaYe8FPP/u1ymQk5tNsJcClWfRE8XLA0id0ErQp+OqaWfJ7B1XOAIisyJM
	 uEZhFmAkEdqtd+9Ty03GMomM6dXWwhY327uyikdxdyFtq9iUlqJge81PormiuSmtYM
	 1m5CQxv83xB1Q==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbjNw0t5nzXWw;
	Fri, 27 Nov 2026 13:58:24 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 04/16] selftests/membarrier: Issue the sync core command in its test
Date: Fri, 27 Nov 2026 13:58:09 -0500
Message-ID: <20261127185822.158216-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test_membarrier_private_expedited_sync_core_success() is meant to
check that MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE succeeds after
its registration. It issues MEMBARRIER_CMD_PRIVATE_EXPEDITED instead.
No test issues the sync core command with success.

Issue the sync core command.

While at it, pass the third system call argument. It was left
uninitialized.

Fixes: 460e8c3340a2 ("membarrier/selftest: Test private expedited sync core command")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index b4dcbb32538d..4b9d1771916e 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -13,7 +13,7 @@ static int registrations;
 
 static int sys_membarrier(int cmd, int flags)
 {
-	return syscall(__NR_membarrier, cmd, flags);
+	return syscall(__NR_membarrier, cmd, flags, 0);
 }
 
 static int membarrier_get_registrations(void)
@@ -221,7 +221,7 @@ static int test_membarrier_register_private_expedited_sync_core_success(void)
 
 static int test_membarrier_private_expedited_sync_core_success(void)
 {
-	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED, flags = 0;
+	int cmd = MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE, flags = 0;
 	const char *test_name = "sys membarrier MEMBARRIER_CMD_PRIVATE_EXPEDITED_SYNC_CORE";
 
 	if (sys_membarrier(cmd, flags) != 0) {
-- 
2.47.3

