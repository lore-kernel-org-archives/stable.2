Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.223.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895626;
	b=5gLPvhgpVkV5FQf3wKWrtmJDzpf2+Pvbiw8oA+JfzICLb3ZDTRrJEYSO2CzqyZxSOY7D
	 5nRQ4F+w/ZqX28lCOuScl1bXKf0p3dAaAyyXywYKtCvsp1R72RehYmAxPT8iwotv+Ssa/
	 LAxNsZ2y48dDMUWCI9JsarNnNY+bjiAz0wJxTgFVX0Q275nGFnSLEo18cy7t0xY9cGLCy
	 3mQ3oStequEG29q5vvgZw/M9fjyT+SBBJNW+lxZDX9bgWu78ya+MVpof8w0TvnNJ78bmQ
	 W9Vs3tnhvvXYbpGgp8sXHdztIX5wkgMETIeyMmPJ5CmTRuLS9egrnK34sGNhEy9hKGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895626;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MailChannels-SenderId:X-MailChannels-Auth-Id:X-Abaft-Desert:
	 X-MC-Loop-Signature:X-MC-Ingress-Time:Received:Received:
	 DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=dDD/ET6/mYd5ZD6mib2tWPW3i2iT6NYNz9oOSEWFJiQ=;
	b=xYXu1m1UCrLcw/NTSPcqrykAAsopzbOiMhTbj+zVCXFDnb7szZtiuAxeCjlv4HG8NnAo
	 sR2UlV9sTeLm4FWBV/Ew9oHuQnGGSD8un+ZLgTN3VwaFpq5wB16EqXWLM9fcxD6aW5BMS
	 Lcknybb0+C83nY8ZHUb6nI+6RQ3RvrftvERhoMCWEdw8lhOPmXBD6YoLeg1k5Sl8guMKt
	 lJHM8+3ZRrRwDyQ0t6CHlLwux2BnsZYIOXmigP5QnKUT5xUD/jwv8RGj2+rnJ84b9oslf
	 eY2iYZsdqgIQgRfdxFrk0n42FvPFSrQMrbD2tLwrqwuZrBbdaVDCvrkF60qqOa49kqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=stgolabs.net;
	spf=fail smtp.mailfrom=stgolabs.net;
	dkim=pass header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=PL2zhSDK;
	arc=none smtp.remote-ip=23.83.223.141
Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C08606A332;
	Thu,  5 Nov 2026 16:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82C08606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=stgolabs.net header.i=@stgolabs.net header.a=rsa-sha256 header.s=dreamhost header.b=PL2zhSDK
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1C6A84616C6;
	Thu, 05 Nov 2026 16:20:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (100-99-198-86.trex-nlb.outbound.svc.cluster.local [100.99.198.86])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9C562461778;
	Thu, 05 Nov 2026 16:20:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Desert: 6a64af1d55728ab4_1793895618959_2500447647
X-MC-Loop-Signature: 1793895618959:3312503829
X-MC-Ingress-Time: 1793895618959
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.198.86 (trex/8.0.2);
	Thu, 05 Nov 2026 16:20:18 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4jL6wd2MdVz2x;
	Thu,  5 Nov 2026 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1793895618;
	bh=dDD/ET6/mYd5ZD6mib2tWPW3i2iT6NYNz9oOSEWFJiQ=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=PL2zhSDKwFY0tFJfzOl3vl+WBcnTU37CxGpGml/xnaciJDNKuLErF9gQbq2RhGZpU
	 I3xP4JLt8lh9tiPULAVXfpNmLZC7hWm/RV7b5qFwT/YoztcLOjGn5fYujDLdHoaCIX
	 Zpf4Yq/GtltBfrwl0YWJyWOOcEBrBB6Mn48/SpRMiWpYf0oKRLXjroS050ny2Wo6a3
	 vJXfvQFXuUtHe83WzxbjLGfeIPXsVQZ8p8BUDxD31H4DPGiDlv7BhrmlavBI9/nYO6
	 yqmxtTWIIBMavCQatFZj0jcHuRes1e53gm1Pg8BHc7SlqcP/+kzaaRZ+zM1L2aQeN5
	 KzjrZOjC9bJOA==
Date: Thu, 5 Nov 2026 08:20:14 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	=?utf-8?B?QW5kcsOvwr/CvQ==?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] futex: Canonicalize arm64 tagged user addresses
Message-ID: <20261105162014.ljayftn3g5lziow7@offworld>
References: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261030-futex-tagged-uaddr-v2-prep-v2-1-131eb7414bda@gentwo.org>
User-Agent: NeoMutt/20220429

On Fri, 30 Oct 2026, Shubhang Kaushik (Ampere) wrote:

>On arm64, a thread that enables the tagged address ABI can pass valid
>top-byte-tagged user pointers to futex syscalls. Such a pointer must
>have the same syscall behaviour as its untagged form.
>
>get_futex_key() validates the user address with access_ok(), but uses
>the raw address when constructing private and shared-anonymous futex
>keys. A waiter using a tagged address and a waker using the untagged
>form can therefore access the same futex word while hashing to distinct
>keys, causing FUTEX_WAKE to miss the waiter.
>
>Keep access_ok() on the original pointer so that arm64 retains its
>per-thread tagged-address ABI enforcement. Canonicalize the address
>afterwards, before it is used for futex key construction and shared
>mapping lookup.
>
>Add an arm64 64-bit selftest for a tagged private waiter woken through
>the corresponding untagged address.
>
>Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
>Cc: stable@vger.kernel.org
>Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>

lgtm

Acked-by: Davidlohr Bueso <dave@stgolabs.net>

>---
>Changes in v2:
>- Add the generated tagged-address test binary to .gitignore.
>- Compile the arm64-specific test implementation only for arm64 64-bit
>  builds.
>- Avoid relying on /proc/<tid>/wchan to detect that the waiter has
>  queued; retry the untagged wake for a bounded interval instead.
>
>Link to v1: https://lore.kernel.org/r/20261022-futex-arm64-tagged-uaddr-v1-1-84d8afbe7668@gentwo.org
>---
> kernel/futex/core.c                                |  2 +
> .../testing/selftests/futex/functional/.gitignore  |  1 +
> tools/testing/selftests/futex/functional/Makefile  |  1 +
> .../selftests/futex/functional/futex_tagged_addr.c | 61 ++++++++++++++++++++++
> tools/testing/selftests/futex/functional/run.sh    |  3 ++
> 5 files changed, 68 insertions(+)
>
>diff --git a/kernel/futex/core.c b/kernel/futex/core.c
>index a240638f69e5c65bd036434a15f3df680efb4638..dcc8ffca38595a5ea69f3672375ffb9f9c6766f9 100644
>--- a/kernel/futex/core.c
>+++ b/kernel/futex/core.c
>@@ -539,6 +539,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
> 	if (unlikely(!access_ok(uaddr, size)))
> 		return -EFAULT;
>
>+	address = untagged_addr(address);
>+
> 	if (unlikely(should_fail_futex(fshared)))
> 		return -EFAULT;
>
>diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
>index 7c39d10b38e4d86096d2d1ce5fe8d6036e8ca758..c64b93a683bd6e9f6b9d3e4f02397eb24cc5a0ad 100644
>--- a/tools/testing/selftests/futex/functional/.gitignore
>+++ b/tools/testing/selftests/futex/functional/.gitignore
>@@ -6,6 +6,7 @@ futex_requeue
> futex_requeue_pi
> futex_requeue_pi_mismatched_ops
> futex_requeue_pi_signal_restart
>+futex_tagged_addr
> futex_wait
> futex_wait_private_mapped_file
> futex_wait_timeout
>diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
>index a03bd5acba50319f08b04ff0904ef155c000fee3..8f7f6730285b725b483787362db4626c459d65c9 100644
>--- a/tools/testing/selftests/futex/functional/Makefile
>+++ b/tools/testing/selftests/futex/functional/Makefile
>@@ -19,6 +19,7 @@ TEST_GEN_PROGS := \
> 	futex_requeue_pi \
> 	futex_requeue_pi_signal_restart \
> 	futex_requeue_pi_mismatched_ops \
>+	futex_tagged_addr \
> 	futex_wait_uninitialized_heap \
> 	futex_wait_private_mapped_file \
> 	futex_wait \
>diff --git a/tools/testing/selftests/futex/functional/futex_tagged_addr.c b/tools/testing/selftests/futex/functional/futex_tagged_addr.c
>new file mode 100644
>index 0000000000000000000000000000000000000000..0b0e350eff11939e42b7b1aca01136b037ed7217
>--- /dev/null
>+++ b/tools/testing/selftests/futex/functional/futex_tagged_addr.c
>@@ -0,0 +1,61 @@
>+// SPDX-License-Identifier: GPL-2.0-or-later
>+
>+#include <errno.h>
>+#include <stdint.h>
>+#include <string.h>
>+#include <sys/prctl.h>
>+#include <time.h>
>+#include <unistd.h>
>+
>+#include <linux/prctl.h>
>+
>+#include "futextest.h"
>+#include "futex_thread.h"
>+#include "kselftest_harness.h"
>+
>+#define WAKE_RETRIES	100
>+#define WAKE_WAIT_US	10000
>+
>+#if defined(__aarch64__) && __SIZEOF_POINTER__ == 8
>+static futex_t futex;
>+static futex_t *tagged_futex;
>+
>+static int waiterfn(void *arg)
>+{
>+	struct timespec timeout = { .tv_sec = 2 };
>+
>+	return futex_wait(tagged_futex, 0, &timeout, FUTEX_PRIVATE_FLAG);
>+}
>+#endif
>+
>+TEST(tagged_addr)
>+{
>+#if !defined(__aarch64__) || __SIZEOF_POINTER__ != 8
>+	SKIP(return, "arm64 64-bit tagged address ABI not available");
>+#else
>+	struct futex_thread waiter;
>+	int ret, i;
>+
>+	ret = prctl(PR_SET_TAGGED_ADDR_CTRL, PR_TAGGED_ADDR_ENABLE, 0, 0, 0);
>+	if (ret && errno == EINVAL)
>+		SKIP(return, "tagged address ABI not available");
>+	ASSERT_EQ(ret, 0)
>+		TH_LOG("PR_SET_TAGGED_ADDR_CTRL failed: %s", strerror(errno));
>+
>+	tagged_futex = (futex_t *)((uintptr_t)&futex | (0x42ULL << 56));
>+	ASSERT_EQ(futex_thread_create(&waiter, waiterfn, NULL), 0)
>+		TH_LOG("pthread_create failed");
>+
>+	for (i = 0; i < WAKE_RETRIES; i++) {
>+		ret = futex_wake(&futex, 1, FUTEX_PRIVATE_FLAG);
>+		if (ret)
>+			break;
>+		usleep(WAKE_WAIT_US);
>+	}
>+
>+	EXPECT_EQ(ret, 1);
>+	EXPECT_EQ(futex_thread_destroy(&waiter), 0);
>+#endif
>+}
>+
>+TEST_HARNESS_MAIN
>diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
>index d1a681b798bd385570710e7c5f9bb28cca64de3e..620d13ee7171e7cc6061053750c9ff4cf525ff72 100755
>--- a/tools/testing/selftests/futex/functional/run.sh
>+++ b/tools/testing/selftests/futex/functional/run.sh
>@@ -46,6 +46,9 @@ echo
> echo
> ./futex_waitv
>
>+echo
>+./futex_tagged_addr
>+
> echo
> ./futex_priv_hash
>
>
>---
>base-commit: 3ac032ef6ca8e47bb06d1e189dfcf88fa0a09c75
>change-id: 20261030-futex-tagged-uaddr-v2-prep-63ea40b5a22f
>
>Best regards,
>-- 
>Shubhang Kaushik (Ampere) <sh@gentwo.org>
>
