Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.72.0.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400451;
	b=OOLpBsG/dba9K1mXem5+B4M306wbBrAS5jgavlDSaqKU/fOB8ndmb2KE+0MhksEkmP0T
	 BxMCdBviFJLv0U+/O0qZCCz9x4PEdauvEYs6GO0mKcM0Q0z7VVrYrCI8ctbWt9MeswRGy
	 xnFIV5jpgEKjrKCSGQAQZLw76j+XXnsYA9Nsp0aZmFaxP4Z16nQ7siNwudcxLGP2hiuI7
	 Qp/6dSiMrcY34w/k5BsCVZ+KHyIjBw+DyFl8PG3E9M33bWP2OFi5+rYd8mhlhI5wWb3VS
	 x+/cBdbFtSoY4iGAIQRGI8wRNMic0MVUGoTGriSm5HhnRImQNWESo8u2Y7d9RONMiBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400451;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=tKDzLJhYKbJR+X+k1vwgMCOk3SGsPhBqojG8RZdsFk8=;
	b=3+DdlnkK5U4BApYnK6PK77XZlK7e4781KSuPYSJSyhqxZOeeGWBm24trZySXBsGCtoL/
	 p9i5K/Z7zrFO5wX0opcVNZ5se+fzbChYIbOjo+XDqiWX1WcRbrlOd1NkjkdlwzVMD1RsH
	 uP3JeWIX93jFrfdnT76jaW0vmMriNxUyOr0zCvkg755SsyrYW2LqLPz3WnbbDlQd5QNYu
	 kvq2qp1ag8Y4wtG3FOvwvhKcXja59HkLr5zUlAe0Z2+ejS3zXfP7iPWoAT4mAvQgbDURE
	 O45pI+HSW01eJcnsuuEj/uvvsBfb736t8Q3V3/bJ8lQJq20WLkT+payBppl87tRPNaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gentwo.org;
	spf=pass smtp.mailfrom=gentwo.org;
	dkim=pass header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=J5RgqXy1;
	arc=none smtp.remote-ip=62.72.0.81
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB73B606A31D;
	Fri, 30 Oct 2026 22:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB73B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gentwo.org header.i=@gentwo.org header.a=rsa-sha256 header.s=default header.b=J5RgqXy1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1793400015;
	bh=ZMs2FNIcBMES5Rg/sKY//vE3KG0UYrjCWf/LHF+Ga0U=;
	h=From:Date:Subject:To:Cc:From;
	b=J5RgqXy1zDpOKb9UfxtpznEUhSRO9gGhLbcmmNBGpHD9KqpvGOfiEaVKyils1Fh93
	 L7/zoz8pUy8TmvhJOCKaIB/UpsBT3miZVWAi5VfM/ad8CWWgbSBRH2lo56/lZvNIbV
	 y1uCQgRfY7TZH0hyrGY6lOHXYi6yX0h+OsI/Dj3M=
Received: from sut02sys-r112.scc-lab.amperecomputing.com (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTPS id 2B05F402A4;
	Fri, 30 Oct 2026 15:40:15 -0700 (PDT)
From: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Date: Fri, 30 Oct 2026 15:39:59 -0700
Subject: [PATCH v2] futex: Canonicalize arm64 tagged user addresses
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
Message-Id: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org>
X-B4-Tracking: v=1; b=H4sIAL4c5WoC/6XOsQ6CMBDG8VcxnT0DB1bi5HsYhmKvpQOUXAtiC
 O9uIQ7G1fF/w++7RQRiR0FcD4tgmlxwvk+Bx4N4tKq3BE6nFpihzLMiAzNGmiEqa0nDqLRmmBA
 GpgFkQarMmrNCNCIB6WjcvOP3OrVh30FsmdQXifghFXey/IFzyKEqdaVMQxcpq5ulPj79ybPdB
 loXoufX/vyE28y/aL2u6xs6wH+5FAEAAA==
X-Change-ID: 20261030-futex-tagged-uaddr-v2-prep-63ea40b5a22f
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>, 
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, 
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Andrey Konovalov <andreyknvl@gmail.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 stable@vger.kernel.org, "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793400015; l=5966;
 i=sh@gentwo.org; s=20251010; h=from:subject:message-id;
 bh=ZMs2FNIcBMES5Rg/sKY//vE3KG0UYrjCWf/LHF+Ga0U=;
 b=ja6txryyLZ/C4E0k9cmXCj5fe92DM/gog19hgBK/XJn9of6noFlXXUV0e/VrdLnx9GaIhS7kU
 H82XOp78jg5AMyZ8iKUCGkF2dGolUSpKDN2du71Fn7Zl2nLbtDJCs+m
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
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
---
Changes in v2:
- Add the generated tagged-address test binary to .gitignore.
- Compile the arm64-specific test implementation only for arm64 64-bit
  builds.
- Avoid relying on /proc/<tid>/wchan to detect that the waiter has
  queued; retry the untagged wake for a bounded interval instead.

Link to v1: https://lore.kernel.org/r/20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org
---
 kernel/futex/core.c                                |  2 +
 .../testing/selftests/futex/functional/.gitignore  |  1 +
 tools/testing/selftests/futex/functional/Makefile  |  1 +
 .../selftests/futex/functional/futex_tagged_addr.c | 61 ++++++++++++++++++++++
 tools/testing/selftests/futex/functional/run.sh    |  3 ++
 5 files changed, 68 insertions(+)

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
 
diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 7c39d10b38e4d86096d2d1ce5fe8d6036e8ca758..c64b93a683bd6e9f6b9d3e4f02397eb24cc5a0ad 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -6,6 +6,7 @@ futex_requeue
 futex_requeue_pi
 futex_requeue_pi_mismatched_ops
 futex_requeue_pi_signal_restart
+futex_tagged_addr
 futex_wait
 futex_wait_private_mapped_file
 futex_wait_timeout
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
index 0000000000000000000000000000000000000000..0b0e350eff11939e42b7b1aca01136b037ed7217
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_tagged_addr.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/prctl.h>
+#include <time.h>
+#include <unistd.h>
+
+#include <linux/prctl.h>
+
+#include "futextest.h"
+#include "futex_thread.h"
+#include "kselftest_harness.h"
+
+#define WAKE_RETRIES	100
+#define WAKE_WAIT_US	10000
+
+#if defined(__aarch64__) && __SIZEOF_POINTER__ == 8
+static futex_t futex;
+static futex_t *tagged_futex;
+
+static int waiterfn(void *arg)
+{
+	struct timespec timeout = { .tv_sec = 2 };
+
+	return futex_wait(tagged_futex, 0, &timeout, FUTEX_PRIVATE_FLAG);
+}
+#endif
+
+TEST(tagged_addr)
+{
+#if !defined(__aarch64__) || __SIZEOF_POINTER__ != 8
+	SKIP(return, "arm64 64-bit tagged address ABI not available");
+#else
+	struct futex_thread waiter;
+	int ret, i;
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
+
+	for (i = 0; i < WAKE_RETRIES; i++) {
+		ret = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
+		if (ret)
+			break;
+		usleep(WAKE_WAIT_US);
+	}
+
+	EXPECT_EQ(ret, 1);
+	EXPECT_EQ(futex_thread_destroy(&waiter), 0);
+#endif
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
change-id: 20261030-futex-tagged-uaddr-v2-prep-63ea40b5a22f

Best regards,
-- 
Shubhang Kaushik (Ampere) <sh@gentwo.org>

