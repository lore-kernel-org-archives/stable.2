Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792721813;
	b=AntooN8UmECUoouRPMQ1Izv9r3ysQ486R1z8N3qb9maF9W3Qi7gQok/Tjo2CpO7rnh8U
	 UpGKKl3CiHPfCIDhIWXX18Lp8iI++H1NjXsmARybPDGVWfBAcL8eQF7vkcrSU23YeyWvK
	 TjZ1v1AhQMtarQw66lj2N4vUyuV3nTPp11mC595lRPxEbUXE4Zr6azMDUx1k/1OnuWEIA
	 TizQODm0mulnJ+9LGhI0YqvmWA0X94PjzuXNkZa3u2GPhBBwCc9VONGoY9MvTtsI4bxIL
	 96akbmW5zsp8exX3QrrQkI1JUzvR20JWDNLQDJh6LTchTNTYecfk0gzXaArJbVZs0qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792721813;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=j5w3UaJh42S33xuxvox41IYKnoykSVPS5LfBwIOC1Bo=;
	b=PblWv9jAUyvXx+BLm8VvwKKolAmR5U4dIwjSqsceWROrFRNBLrmCrIEA/ftwwKTTkQW8
	 Ujp8C9JBwihIxDhpoXL51EWXdWwchS7W9IwvtfFa4vvKhYe2CEXGytJ6+D+sudPbAGFt4
	 eq6d5rQ++clTUYqQ850lmcj2lqUpXtP1vskNa1hbsSJwxugA+3+cQbfzXR+ecmCO5vx7d
	 JjgGNe3+lR3IRi5pdeaFdVAv7q8c4ERKETWiLgHgDzIqVdhdoFnk/36miI9oJ/QTkjQ/H
	 YGoxlg2xn7R/dhT1m5Parz8JhaVTQ2yH33uskOsHaFtrkB62DTqHLmEXWyzAo/JCFgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=OMZce5Iu;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EABB606A319;
	Fri, 23 Oct 2026 02:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EABB606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=OMZce5Iu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1792721163;
	bh=JfHhmz/ZMAseVLQWvLkDHdFajTFk05d8JaKdubprIbQ=;
	h=From:Date:Subject:To:Cc:From;
	b=OMZce5IuJveys/8MSa0quA2+2eqnIy9I+Xqwj7/0Ea9triWKXgJDt4eCydpAuu8Cx
	 +Pug+3qWN0Ks2iStZx432jDj1aXjgd2DtnuGSXcXRTpdQ/TehClYJaIly9sTAPpHO+
	 bkRXNGACyCyG7jhkYyh7pHwilkgpww0QXtKwKoTU=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 89898401A2;
	Thu, 22 Oct 2026 19:06:03 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Thu, 22 Oct 2026 19:06:02 -0700
Subject: [PATCH] futex: Canonicalize arm64 tagged user addresses
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAAnB2moC/x3MMQ6DMAxA0asgz1hKLJqhV0EdTOKkHpoiByokx
 N2JOr7h/xOamEqD53CCyU+bfmuHHweIb65FUFM3kKPgHRHmfZMD2T5hwo1LkYQ7p2ToY34Enmi
 h6KHnq0nW47+eX9d1A5QcMNhqAAAA
X-Change-ID: 20261022-futex-arm64-tagged-uaddr-1cf56a42b2c1
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>, 
 Kees Cook <kees@kernel.org>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792721163; l=4933;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=JfHhmz/ZMAseVLQWvLkDHdFajTFk05d8JaKdubprIbQ=;
 b=ihJS3fv6DSvzSVkQrRn7u6eFELOA/yllpW5WbyiWKLt6x3hRf04vWABxymhM2mgEyO6Px983p
 68b7W/dIaQkDjuGLy66jM10sCQyXOcKA+IK+zCG9sHihTTd8VlKYnDz
X-Developer-Key: i=sh@gentwo.org; a=ed25519;
 pk=jc8YIRvxPSyJaBRe5y+a4N0RXKBUEcAh8+OFhlROXPY=

On arm64, a thread that enables the tagged address ABI can pass valid
top-byte-tagged user pointers to futex syscalls. Such a pointer must
have the same syscall behaviour as its untagged form.

get_futex_key() validates the user address with access_ok(), but uses
the raw address when constructing private and shared-anonymous futex
keys. A waiter using a tagged address and a waker using the untagged
form can therefore access the same futex word while hashing to distinct
keys, causing FUTEX_WAKE to miss the waiter.

Keep access_ok() on the original pointer so that arm64 retains its
per-thread tagged-address ABI enforcement. Canonicalize the address
afterwards, before it is used for futex key construction and shared
mapping lookup.

Add an arm64 64-bit selftest for a tagged private waiter woken through
the corresponding untagged address.

Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
Cc: stable@vger.kernel.org
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Testing:
  - futex_tagged_addr: PASS
  - Standard futex functional tests: PASS, except RT PI tests when run
    without real-time scheduling permission
  - sudo ./futex_requeue_pi: PASS (24/24)
  - sudo ./futex_requeue_pi_signal_restart: PASS
---
 kernel/futex/core.c                                |  2 +
 tools/testing/selftests/futex/functional/Makefile  |  1 +
 .../selftests/futex/functional/futex_tagged_addr.c | 47 ++++++++++++++++++++++
 tools/testing/selftests/futex/functional/run.sh    |  3 ++
 4 files changed, 53 insertions(+)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index a240638f69e5c65bd036434a15f3df680efb4638..dcc8ffca38595a5ea69f3672375ffb9f9c6766f9 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -539,6 +539,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 	if (unlikely(!access_ok(uaddr, size)))
 		return -EFAULT;
 
+	address = untagged_addr(address);
+
 	if (unlikely(should_fail_futex(fshared)))
 		return -EFAULT;
 
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index a03bd5acba50319f08b04ff0904ef155c000fee3..8f7f6730285b725b483787362db4626c459d65c9 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -19,6 +19,7 @@ TEST_GEN_PROGS := \
 	futex_requeue_pi \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
+	futex_tagged_addr \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
 	futex_wait \
diff --git a/tools/testing/selftests/futex/functional/futex_tagged_addr.c b/tools/testing/selftests/futex/functional/futex_tagged_addr.c
new file mode 100644
index 0000000000000000000000000000000000000000..81224f024a375d08e1dd4fd12ccf548f23126f27
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_tagged_addr.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <stdint.h>
+#include <sys/prctl.h>
+
+#include <linux/prctl.h>
+
+#include "futextest.h"
+#include "futex_thread.h"
+#include "kselftest_harness.h"
+
+static futex_t futex;
+static futex_t *tagged_futex;
+
+static int waiterfn(void *arg)
+{
+	struct timespec timeout = { .tv_sec = 1 };
+
+	return futex_wait(tagged_futex, 0, &timeout, FUTEX_PRIVATE_FLAG);
+}
+
+TEST(tagged_addr)
+{
+	struct futex_thread waiter;
+	int ret;
+
+#if !defined(__aarch64__) || __SIZEOF_POINTER__ != 8
+	SKIP(return, "arm64 64-bit tagged address ABI not available");
+#endif
+
+	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
+	if (ret && errno == EINVAL)
+		SKIP(return, "tagged address ABI not available");
+	ASSERT_EQ(ret, 0)
+		TH_LOG("PR_SET_TAGGED_ADDR_CTRL failed: %s", strerror(errno));
+
+	tagged_futex = (futex_t *)((uintptr_t)&futex | (0x42ULL << 56));
+	ASSERT_EQ(futex_thread_create(&waiter, waiterfn, NULL), 0)
+		TH_LOG("pthread_create failed");
+	ASSERT_EQ(futex_wait_for_thread(&waiter, _metadata), 0)
+		TH_LOG("waiter did not enter futex wait");
+
+	EXPECT_EQ(futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG), 1);
+	EXPECT_EQ(futex_thread_destroy(&waiter), 0);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index d1a681b798bd385570710e7c5f9bb28cca64de3e..620d13ee7171e7cc6061053750c9ff4cf525ff72 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -46,6 +46,9 @@ echo
 echo
 ./futex_waitv
 
+echo
+./futex_tagged_addr
+
 echo
 ./futex_priv_hash
 

---
base-commit: 3ac032ef6ca8e47bb06d1e189dfcf88fa0a09c75
change-id: 20261022-futex-arm64-tagged-uaddr-1cf56a42b2c1

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

