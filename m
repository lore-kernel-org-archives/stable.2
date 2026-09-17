Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799874A2624;
	Thu, 17 Sep 2026 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641795; cv=none; b=HpbZSPqPJf8nanw0kMNxEOAR2/YlrWWNSsU4bAXtoeyqmAOFwSGi5361d0U7XMH0PtuYayfdSoLXha1QCLDvtX4obApklDpsta9ur0s4612Vyyme/mWE4MasJZsDzBA++nXU3oQU+cTyZTYdW2TkGqv/nSawAQUmh3wQaRRa7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641795; c=relaxed/simple;
	bh=VOhzg+gblLOBw4OVoCllX8dkGXylrawVAylaR3u51YI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QL3essurgH4sU0czLeyRp577j0e39AC5ukKDZgxG2IxHmjy/sL38ckVgqG/oKfq+bBWQ+GnDHXnDNcgMPh+gA/fQ+DeGuNQa+xnsrqBrBzYUx8UI9P04/LgZzRYGCTr0/vKLUBnEPebwd6OE2UECEssGpybp7DCOKK5Y5Nxfuio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=FzQAq629; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="FzQAq629"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789641788; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Bo0YwhChUTfjanazEQ/XjWIIB/7+7ZRtdBdoM6WlOHw=;
	b=FzQAq629ozMuMt8okGv1PHfgJW7l63PzGv+NIbAsSyOjEEQvxA3tN05LUQ7MOgax1RHxPHjwO+0tvzMlm6mZKohuhpV9gqSV9qxZA1tuvXtEsRIXWvSZpjd4CfJfs8MEGIZkuFuIsFfh5QF938eKrasVHrg3H8nGLkkSJGELrB8=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.04445032|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0250665-0.000769304-0.974164;FP=15466861361468757341|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=fangxy@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jFn5yNH_1789641787;
Received: from localhost.localdomain(mailfrom:fangxy@xiaopeng.com fp:SMTPD_---.jFn5yNH_1789641787 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 18:43:08 +0800
From: Fang Xieyan <fangxy@xiaopeng.com>
To: akpm@linux-foundation.org
Cc: andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	tchibo@google.com,
	elver@google.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] kcov: ignore an out-of-range comparison count in write_comp_data()
Date: Thu, 17 Sep 2026 18:43:06 +0800
Message-ID: <20260917104306.22145-1-fangxy@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

write_comp_data() reads the comparison record count from area[0] and uses
it to index the coverage buffer:

	area = (u64 *)t->kcov_area;
	max_pos = t->kcov_size * sizeof(unsigned long);

	count = READ_ONCE(area[0]);

	/* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
	start_index = 1 + count * KCOV_WORDS_PER_CMP;
	end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
	if (likely(end_pos <= max_pos)) {

The buffer is mmap'd writable into the collecting process, so count is
under its control and end_pos <= max_pos is its only bound. A count that
wraps the u64 multiply leaves end_pos below max_pos, so the check passes
while the record store lands 24 bytes before the buffer, in the unmapped
vmalloc guard page, and faults:

  BUG: unable to handle page fault for address: ffa0000000b60fe8
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:write_comp_data+0x7e/0xa0
  ...
  Kernel panic - not syncing: Fatal exception

Bound count first: only max_pos / (sizeof(u64) * KCOV_WORDS_PER_CMP)
records fit, so a larger count is not a valid index and is dropped.
kcov_move_area() bounds the same untrusted count this way, and no count
the end_pos <= max_pos check accepts reaches that limit, so no valid
record is lost.

Fixes: ded97d2c2b2c ("kcov: support comparison operands collection")
Cc: stable@vger.kernel.org
Assisted-by: Hawkeye:GLM-5.3-flash
Assisted-by: Qoder:Qwen3.8-Max
Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>
---

Found by reading write_comp_data() in kernel/kcov.c. kcov_mmap() only sets
VM_DONTEXPAND, so a process that maps the coverage buffer PROT_WRITE controls
area[0] and its record count, which write_comp_data() trusts. kcov is a
root-only debugfs file (debugfs_create_file_unsafe("kcov", 0600, ...)) and
write_comp_data() exists only under CONFIG_KCOV_ENABLE_COMPARISONS, so this is
a local, debug-kernel robustness fix: the process corrupts its own buffer and
the kernel oopses. It crosses no privilege boundary.

Reproducer: open /sys/kernel/debug/kcov, KCOV_ENABLE with KCOV_TRACE_CMP, mmap
the buffer PROT_WRITE, store 0x1fffffffffffffff into area[0], then execute a
comparison so the callback fires. Unpatched, the wrapped end_pos passes the
end_pos <= max_pos check and the store faults; patched, the record is dropped
and collection continues with rc=0. area[0] keeps its corrupt value, so later
records are dropped too until userspace resets it, as with a full buffer.

Both cases ran on 704340f1cd0d (9 commits past v7.3-rc3): x86_64 defconfig
plus CONFIG_KCOV=y, CONFIG_KCOV_ENABLE_COMPARISONS=y and CONFIG_KASAN_GENERIC
(with CONFIG_KASAN_VMALLOC=y), gcc 13.2.0, QEMU under TCG; the unpatched and
patched kernels use byte-identical .config and differ only by this patch.
write_comp_data() is notrace and kcov.c is not KASAN-instrumented, so the
out-of-bounds store is a bare #PF on the vmalloc guard page, not a KASAN
report; KASAN shows up only as a build flag in the Oops line.

The fault address is not reproducible byte for byte: the kcov area is
vmalloc'd, so its page moves between boots (the quoted splat faulted at
ffa0000000b60fe8, a later re-run at ffa0000000b10fe8). The invariant is the
low 12 bits ...fe8 - the store always lands 24 bytes below the page-aligned
buffer, into the guard page.

 kernel/kcov.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 35420f0..54eaae9 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -253,6 +253,14 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
 
 	count = READ_ONCE(area[0]);
 
+	/*
+	 * area[0] is writable by the collecting process, so count cannot be
+	 * trusted. Bound it to the records that fit, as kcov_move_area()
+	 * does, so the end_pos multiply below cannot wrap past its check.
+	 */
+	if (count >= max_pos / (sizeof(u64) * KCOV_WORDS_PER_CMP))
+		return;
+
 	/* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
 	start_index = 1 + count * KCOV_WORDS_PER_CMP;
 	end_pos = (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
-- 
2.50.1 (Apple Git-155)

