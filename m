Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F40430F927;
	Wed, 17 Jun 2026 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667518; cv=none; b=MKavQIYUtIuZpQ0n64vkZ5mqzeswkDAgtp2hLIiLax0/qID3JWsEOZ4I5s00jFe6o4JPOrBjA6R71JjXJFGpR/gMLnDhjg+L4EbFk02c3MqOcUn5hejUFc4+iSc0JF+WK4hka0MP6SmkzAJ7sc3l+uxcf1fFgppdUFW77ExlQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667518; c=relaxed/simple;
	bh=0yqpe+lm26W/LP+lHFCj4JnBMx0WRaxSZRm9RwmCSVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYmTLKxaC5yxudgNrthGGHIItg00Nq5xmV8SY5rGgOtMAVAAYzu62pXYhgVOCfxRRYydpKUQnLTPy9eS9D5UOmUkXeVNWL3Kr55kOGONJETNrkEAds+QyFfAqzjxEcog66Jj+KTU6b+iG51MlXGYn/bCVDVlmg3VE3AEOK7219Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qS885WPE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3KdvkCE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qS885WPE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3KdvkCE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781667515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECbGHWtQ+jrzHJRs4USa5UszLEQs+i/gsj0NHZu3sqc=;
	b=qS885WPEJYfEIVB87uVsb2/mCKzMsYdlADE/ymT2IShEbcDn2tpcYm0KZERQlYOKqvD49/
	sw7SIUfCEfKKKYx+clC7SgC+rZd60cwRe3TcZfcJAtg8gVvoAFUJrQzSg8H5hLjQwM4XIv
	GTOPY574yORpm3RH0+CH4iZJQQtOsBa+HqTkMd8OxErdn1qMIGswHa0NnvSN8glkLg0zpe
	uKpwJ+FOB+u52EyCSQvoH0xRLaBrwynwI+m2L5fiwqFMXqOutCu3GubEgnY2DDZc+MRXvg
	HypApqDw8IqAdEfpHxBNneaTyI14qdV5bbd8LV6KW7+siNaJYZVrKoab9aL4/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781667515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ECbGHWtQ+jrzHJRs4USa5UszLEQs+i/gsj0NHZu3sqc=;
	b=P3KdvkCETGCEdPuE/2MX5ipRPf2qck+mhr2XAqJLzCfybFn97nnATBrc5vnHbsRHZO/KIw
	HVPU8jJ+Jk4W1vAA==
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@oss.qualcomm.com>,
	Jingwei Wang <wangjingwei@iscas.ac.cn>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] riscv: unaligned: stop using kthread for check_vector_unaligned_access()
Date: Wed, 17 Jun 2026 05:38:24 +0200
Message-ID: <1c378963f27c5960e8a57c50b8b444d30954cb54.1781666867.git.namcao@linutronix.de>
In-Reply-To: <cover.1781666867.git.namcao@linutronix.de>
References: <cover.1781666867.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A kthread is used to run check_vector_unaligned_access() to optimize boot
time, allowing the kernel to continue booting without waiting for the
unaligned vector speed probe to finish.

However, this asynchronous approach introduces several complications.
First, the kthread may not complete before a user reads vDSO data,
resulting in incorrect values. This was previously addressed by
commit 5d15d2ad36b0 ("riscv: hwprobe: Fix stale vDSO data for
late-initialized keys at boot"), which added complex synchronization
between the kthread and vDSO reads.

Second, it was discovered that the kthread may not finish before
vec_check_unaligned_access_speed_all_cpus() (marked with __init) is freed,
triggering a page fault.

These issues raise the question of whether the kthread is worth the added
complexity. A past boot time regression report was actually unrelated to
synchronous probing; it was caused by the probe running serially. Since
switching to a parallel probe, no further complaints have been made.
Furthermore, the unaligned scalar access speed probe takes the same amount
of time, runs synchronously, and has caused no issues.

Testing shows no noticeable boot time slowdown when running the vector
probe synchronously (0.464474s with kthread vs. 0.457991s without).

Remove the kthread usage and run the probe synchronously. This simplifies
the boot flow and allows for the revert of commit 5d15d2ad36b0 ("riscv:
hwprobe: Fix stale vDSO data for late-initialized keys at boot")

Reported-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Closes: https://lore.kernel.org/linux-riscv/20260612-vec_unaligned_drop_ini=
t-v1-1-df969210ae34@oss.tenstorrent.com/
Fixes: a00e022be531 ("riscv: Annotate unaligned access init functions")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 arch/riscv/kernel/unaligned_access_speed.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/arch/riscv/kernel/unaligned_access_speed.c b/arch/riscv/kernel=
/unaligned_access_speed.c
index bb57eb5d19df..6e35bca568de 100644
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -6,7 +6,6 @@
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/jump_label.h>
-#include <linux/kthread.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/types.h>
@@ -288,18 +287,9 @@ static void check_vector_unaligned_access(struct work_=
struct *work __always_unus
 	__free_pages(page, MISALIGNED_BUFFER_ORDER);
 }
=20
-/* Measure unaligned access speed on all CPUs present at boot in parallel.=
 */
-static int __init vec_check_unaligned_access_speed_all_cpus(void *unused _=
_always_unused)
-{
-	schedule_on_each_cpu(check_vector_unaligned_access);
-	riscv_hwprobe_complete_async_probe();
-
-	return 0;
-}
 #else /* CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS */
-static int __init vec_check_unaligned_access_speed_all_cpus(void *unused _=
_always_unused)
+static void check_vector_unaligned_access(struct work_struct *work __alway=
s_unused)
 {
-	return 0;
 }
 #endif
=20
@@ -387,12 +377,7 @@ static int __init check_unaligned_access_all_cpus(void)
 			per_cpu(vector_misaligned_access, cpu) =3D unaligned_vector_speed_param;
 	} else if (!check_vector_unaligned_access_emulated_all_cpus() &&
 		   IS_ENABLED(CONFIG_RISCV_PROBE_VECTOR_UNALIGNED_ACCESS)) {
-		riscv_hwprobe_register_async_probe();
-		if (IS_ERR(kthread_run(vec_check_unaligned_access_speed_all_cpus,
-				       NULL, "vec_check_unaligned_access_speed_all_cpus"))) {
-			pr_warn("Failed to create vec_unalign_check kthread\n");
-			riscv_hwprobe_complete_async_probe();
-		}
+		schedule_on_each_cpu(check_vector_unaligned_access);
 	}
=20
 	/*
--=20
2.47.3

