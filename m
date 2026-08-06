Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3344C9579
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786044770; cv=none; b=aWESraImaLuabf07hz48niYMFYUK78Id+ev4qh7Yei9stZkkMDxTEH+sf08TxJ2ShUUP1altkMgtSfiHbCsk5plCPR6XVSAStbUmpQjLCts8L9hrBERwOIySyzJ+wo9NcpuvAFb5xqigPuOf6HAkPFNXJmPyL2GAj4uglNJwK+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786044770; c=relaxed/simple;
	bh=NNxzFXI7pN1Y/78YNlfVXVgkFP6QpAm2AZETnXcEq4g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kZliGtakW3r5C/JgwZvReTNQA1/XC0SVFAjcwXKG5zkjqFPYyeRim0Vi2oBMwrCze0tSkQQUw/AqFMqBWM06Mq16qiNPTNWx2xSq6BjEej9cF4B6eVjihVW3ebRoCmh5qYcV3CQ5go3Jy21p0illGFmPgHdR8oPses4ptzxFF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z8sGdIHN; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8sGdIHN"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1693389f8f.0
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786044767; x=1786649567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4TlLU3iudfDSh37R1MgKEhJzdbfc94lN89q/rnC4V6M=;
        b=Z8sGdIHNXu/swaImZVfasvHchMwfFf1q6+nguTmRuEOfMSJg4rurSDBx8zW8ug/CdS
         AjX6Gpv07XhE9GQvjFAssOYMImCgdpOzwFkaLe8KcvO/qCAbPd88aP68pYVdfSzbNHiK
         kCcAn7PQ/sQLq8miXT4VO0U6Vqmp9nZYSDoj/O9KjGQDWbnqTlroY+bAokwwVzPxPPR9
         tji4654imjtFqNNVRallg3boa/NpPKDyLVd8mZMUV4fwp9Y5CTXr4uDnkRmDBumd1CAW
         5/l8oSOLJDuCAbLRyj5qGiwau4NQbdnVmAaywuHV+M9vwAY78tVCaRQaawD/SY4vnlpN
         R03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786044767; x=1786649567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4TlLU3iudfDSh37R1MgKEhJzdbfc94lN89q/rnC4V6M=;
        b=iY1d5FMzoYz0kZI0Sx6RJ/wgwUR/6zI8bTCpoNIqXWvhkH9ZxrA2axjSQG7XVBbJMA
         0v1d6zm/+jpNzZcQWLH0j44Yd0kHfno9zreq0X1gqYOdyOTZRnFL8LoHepIu06Cgt6eb
         RGOEUiBjLsh2eQn2SbaCNSdp0bmwBMac+bly3MOWHNHMiM4jfQK85LPkk/crvk4Q0R3s
         jVxNW/kYJC4u/uTsFg3NxKrBS8qiToztdvVJ9/xCJX1RZ4LuQ+CF8QIvZMCkYvomaiGv
         SnBuXW1LTMdmYToixSLJYyjmnDdVRA9xL28F4UPw7xzjjrPmx/Sb2WhlBBcw1o8tk0Bc
         fCcQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvIYzZGOKl3cEZE7FH6wedNTNycDrZ883VuRNFmLl/1CaAqm5CmSVyyZ+8fon41zQP8srov1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOSJg6fsA9fcekkHaWU0UgKiKUBWOq4RZeVKTacLq6IP+8Nzbs
	dySZ//6qlOv1IfmPa82Q0gyaSKERDK/SiLglZFDA6fNY3wAkR3wro/9s
X-Gm-Gg: AR+sD13G5Tw8pc2S8654PrC2cVLM0zLlJFQQIFcaG347tm9eds8mDvG5+9B5qGQN2Os
	Z151h6jXH7Kq2dGRxIRVYjt8itahjAK4ImXbZ60sYKMw5JWmPo9JXHlQRITjZWNBkIq/mvJHiEG
	3ML2nDp+phSGJxrDzkn0tg8EMmhhgDfrWPZQnCC4CbcPjRqhjTNf9oiEWg7cqZjPgnqrmjeDb5T
	0IpdSjGmKNozDAnKAbvwsv4iaRIlrRUIofubIJwWNRs99q83Q289FUUrk9G/xmTe5yFY0GtEYs7
	sL6r0WFv+RW2zVMgQlZyTe7XKFWgxHQgso/etGowapZbnD1bFWzgE2TNqDgOQCfZGVJGufzkKtt
	RCnud2D2q/pnuJvY6SyLCCq3oMppNFcNSJYhtwsEhFtbMrV4/jx5mZ6SFi0h7L3Y46I6KYzNZo8
	bHEEuvidS6seFaQiCr5y6VOi9Kvaj/v+PyiJRxZRtbpXLeU8e4SiLWck+Gw3fI3EdinbuIElF5n
	zua+Qp8qMCg3mKGayD4duvBBxe/y0lZBU/00I5iZovfHgumiTe7hTxPqFjobZh1mxnfyX0ZbibI
	emLs5T4hbgjAbdu1dCbRjpWNUAlak9m+obBhlfUMGfvQrEAM0it9JDo4I80gzJQp0ik6FWbKig=
	=
X-Received: by 2002:a5d:67cc:0:b0:47f:6dcb:3737 with SMTP id ffacd0b85a97d-47fec64be03mr19894812f8f.29.1786044766987;
        Thu, 06 Aug 2026 12:32:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff7b250cfsm8782322f8f.28.2026.08.06.12.32.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 12:32:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andy Chiu <tchiu@tenstorrent.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] riscv: vector: preserve state when scheduling at nonzero depth
Date: Thu,  6 Aug 2026 21:32:41 +0200
Message-Id: <20260806193241.10552-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IN_SCHEDULE shortcut lets __switch_to_vector() discard Vector state at
a voluntary schedule point, where Vector registers are caller-saved.
Switch-in can then enable Vector without restoring state.

An interrupt or fault can also schedule at nonzero Vector nesting depth.
This triggers:

  WARNING: arch/riscv/include/asm/vector.h:376 at __schedule+0xfbc/0x10b4

The shortcut is then also taken on switch-in, so it skips NEED_RESTORE and
riscv_v_context_nesting_end() resumes with stale Vector registers. In the
vector usercopy loop, an interrupt between vsetvli and vle8.v/vse8.v can
therefore resume with another task's vl, vtype and vector registers. The
scalar loop state survives, so the copy can use the wrong vector length and
silently corrupt user data. A sleeping page fault in vectorized usercopy
can reach the same switch without CONFIG_PREEMPTION.

Use the shortcut only at depth zero. Nonzero-depth switches retain the
existing save and NEED_RESTORE protocol.

Fixes: d1049fc0de81 ("riscv: vector: Support calling schedule() for preemptible Vector")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-luna
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Reproducer:

Originally caught by syzkaller fuzzing:

  [   75.067010] ------------[ cut here ]------------
  [   75.069361] WARNING: arch/riscv/include/asm/vector.h:376 at __schedule+0xfbc/0x10b4, CPU#1: syz.4.788/3533
  [   75.072830] CPU: 1 UID: 0 PID: 3533 Comm: syz.4.788 Not tainted 7.2.0-rc5-g11f985de3fef #3 PREEMPTLAZY
  [   75.075177] [<ffffffff810cb124>] __schedule+0xfbc/0x10b4
  [   75.075572] [<ffffffff810cb41c>] preempt_schedule_irq+0x2a/0x76
  [   75.075753] [<ffffffff810c6a06>] irqentry_exit+0x260/0xd48
  [   75.075911] [<ffffffff810c666a>] do_irq+0x34/0x48
  [   75.076076] [<ffffffff810d4f82>] handle_exception+0x146/0x174
  [   75.076380] [<ffffffff810c5654>] loop+0x4/0x26
  [   75.076505] [<ffffffff80749838>] copy_folio_from_iter_atomic+0x2d4/0xd64
  [   75.078599] ---[ end trace 0000000000000000 ]---

The following standalone workload exercises the same vectorized usercopy
path. Build vector-stress.c into the initramfs and mount debugfs before
running it. The kernel used CONFIG_PREEMPT_LAZY=y,
CONFIG_RISCV_ISA_V_PREEMPTIVE=y and CONFIG_KCOV=y. Run it under QEMU TCG
with:

  qemu-system-riscv64 -machine virt -cpu max -smp 1 -nographic \
    -kernel arch/riscv/boot/Image -initrd vector-diag-small-memcheck.cpio.gz \
    -append 'console=ttyS0 earlycon=sbi rdinit=/init'

The stress program checks every byte read back from the pipe. With this
patch, the workload completed with failures=0 and no Vector warning.

Testing:
  checkpatch.pl --strict, git diff --check, Image builds with
  CONFIG_RISCV_ISA_V_PREEMPTIVE=y and CONFIG_RISCV_ISA_V_PREEMPTIVE=n, and
  QEMU TCG one-vCPU stress runs. The patched workload completed with
  failures=0 and no warning.

No conflict with Andy Chiu's pending "riscv: optimize Vector context restore
on syscall" series; both apply independently.

vector-stress.c:

#define _GNU_SOURCE

#include <errno.h>
#include <fcntl.h>
#include <linux/kcov.h>
#include <pthread.h>
#include <sched.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <unistd.h>

#define WORKERS 4
#define ITERATIONS 2000
#define CHUNK (16 * 1024)
#define KCOV_ENTRIES (1 << 16)
#define KCOV_BYTES (KCOV_ENTRIES * sizeof(unsigned long))

static pthread_barrier_t start_barrier;
static atomic_int failures;

static int kcov_start(unsigned long **area, int *fd, int id)
{
	unsigned long *map;
	int kfd, saved_errno;

	kfd = open("/sys/kernel/debug/kcov", O_RDWR);
	if (kfd < 0) {
		dprintf(STDERR_FILENO, "worker %d: KCOV open: %s\n", id,
			strerror(errno));
		return -1;
	}
	if (ioctl(kfd, KCOV_INIT_TRACE, KCOV_ENTRIES) < 0) {
		dprintf(STDERR_FILENO, "worker %d: KCOV init: %s\n", id,
			strerror(errno));
		goto fail_close;
	}
	map = mmap(NULL, KCOV_BYTES,
			PROT_READ | PROT_WRITE, MAP_SHARED, kfd, 0);
	if (map == MAP_FAILED) {
		dprintf(STDERR_FILENO, "worker %d: KCOV mmap: %s\n", id,
			strerror(errno));
		goto fail_close;
	}
	if (ioctl(kfd, KCOV_ENABLE, KCOV_TRACE_PC) < 0) {
		dprintf(STDERR_FILENO, "worker %d: KCOV enable: %s\n", id,
			strerror(errno));
		saved_errno = errno;
		munmap(map, KCOV_BYTES);
		errno = saved_errno;
		goto fail_close;
	}
	*area = map;
	*fd = kfd;
	return 0;

fail_close:
	saved_errno = errno;
	close(kfd);
	errno = saved_errno;
	return -1;
}

static void *worker(void *arg)
{
	unsigned long *area;
	unsigned char *buffer;
	int pipefd[2], kfd, id = (int)(uintptr_t)arg;

	if (kcov_start(&area, &kfd, id) < 0) {
		atomic_fetch_add(&failures, 1);
		return NULL;
	}
	if (pipe2(pipefd, O_CLOEXEC) < 0) {
		dprintf(STDERR_FILENO, "worker %d: pipe failed: %s\n", id,
			strerror(errno));
		atomic_fetch_add(&failures, 1);
		goto out_kcov;
	}
	buffer = aligned_alloc(64, CHUNK);
	if (!buffer) {
		dprintf(STDERR_FILENO, "worker %d: allocation failed: %s\n", id,
			strerror(errno));
		atomic_fetch_add(&failures, 1);
		goto out_pipe;
	}
	memset(buffer, 0x30 + id, CHUNK);
	pthread_barrier_wait(&start_barrier);

	for (int i = 0; i < ITERATIONS; i++) {
		size_t done = 0;

		while (done < CHUNK) {
			ssize_t n = write(pipefd[1], buffer + done, CHUNK - done);
			if (n < 0 && errno == EINTR)
				continue;
			if (n <= 0) {
				atomic_fetch_add(&failures, 1);
				goto out_buffer;
			}
			done += n;
		}
		done = 0;
		while (done < CHUNK) {
			ssize_t n = read(pipefd[0], buffer + done, CHUNK - done);
			if (n < 0 && errno == EINTR)
				continue;
			if (n <= 0) {
				atomic_fetch_add(&failures, 1);
				goto out_buffer;
			}
			done += n;
		}
		for (size_t j = 0; j < CHUNK; j++) {
			if (buffer[j] != (unsigned char)(0x30 + id)) {
				dprintf(STDERR_FILENO,
					"worker %d: data mismatch at %zu\n", id, j);
				atomic_fetch_add(&failures, 1);
				goto out_buffer;
			}
		}
		if ((i & 7) == 0)
			sched_yield();
	}

out_buffer:
	free(buffer);
out_pipe:
	close(pipefd[0]);
	close(pipefd[1]);
out_kcov:
	ioctl(kfd, KCOV_DISABLE, 0);
	munmap(area, KCOV_BYTES);
	close(kfd);
	return NULL;
}

int main(void)
{
	pthread_t threads[WORKERS];

	pthread_barrier_init(&start_barrier, NULL, WORKERS);
	for (int i = 0; i < WORKERS; i++)
		if (pthread_create(&threads[i], NULL, worker, (void *)(uintptr_t)i))
			atomic_fetch_add(&failures, 1);
	for (int i = 0; i < WORKERS; i++)
		pthread_join(threads[i], NULL);
	pthread_barrier_destroy(&start_barrier);

	printf("vector-stress complete failures=%d\n", atomic_load(&failures));
	return atomic_load(&failures) ? 1 : 0;
}

 arch/riscv/include/asm/vector.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index 00cb9c0982b1a..1766bb7494d3b 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -372,8 +372,8 @@ static inline void __switch_to_vector(struct task_struct *prev,
 	struct pt_regs *regs;
 
 	if (riscv_preempt_v_started(prev)) {
-		if (riscv_v_is_on()) {
-			WARN_ON(prev->thread.riscv_v_flags & RISCV_V_CTX_DEPTH_MASK);
+		if (riscv_v_is_on() &&
+		    !(prev->thread.riscv_v_flags & RISCV_V_CTX_DEPTH_MASK)) {
 			riscv_v_disable();
 			prev->thread.riscv_v_flags |= RISCV_PREEMPT_V_IN_SCHEDULE;
 		}
-- 
2.53.0
