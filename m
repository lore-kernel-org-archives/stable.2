Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D64B2021
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788444373; cv=none; b=C17BW3yGB8gUqobCZAnAvXMiBtGen/vYVkz1Hx1mgCx6kDK+VsAq+SeK0NYeElZbqbP6C8/lDuDBznGP919xu1XV+mE67VjJLvQimCfSUA5KQgQj5OtWzlbd2kda868KkRAR0xO1gjXuaXf5KmNoZPuw1Lkh0MsW/NBZ1nsi8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788444373; c=relaxed/simple;
	bh=CNuwqRLjJi+F+f7dgZpF1YRruhs+cS4JLeGCLOEd144=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Ut7SOD6618FYdcfHdKoWPJQpJhuUzZ+D4LJBDA/glBn0P7lpR4eyqpuB0PwS4EG/sQSkPHhFyAubNJAYxxVzVOPraMMZbupAC8uuzQiiLoBtmpYKJomuovWWy7ambCYCCykzfeP/5XCitWxmDjq2Xawn1kgL1tmrag+MbMOulUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sjt1mpcP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sjt1mpcP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F4F1F000E9;
	Thu,  3 Sep 2026 14:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788444366;
	bh=dNWGHyqp+xuv+Uxplql2Dswgg5DSISHiA1yqRzWUGjc=;
	h=Subject:To:Cc:From:Date;
	b=Sjt1mpcP6ZHr8rYQJeUKF7LodLTvVMTUNyU3ozML5a2fkJdeqjfaCAz5eIxt4hUFa
	 UGBwUBvLwWrsVqtogoEzX9ziq11lAvntPyodiFzJd001ORGW2MR86d+TlobJhYjDla
	 AUc+iv0m8b2gSaYRr73FNtB/E1NCADs7DaZGWH7s=
Subject: FAILED: patch "[PATCH] arch_numa: avoid false positive fortify warning in" failed to apply to 7.2-stable tree
To: nathan@kernel.org,akpm@linux-foundation.org,justinstitt@google.com,kees@kernel.org,morbo@google.com,ndesaulniers@google.com,rppt@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:45:12 +0200
Message-ID: <2026090312-geometry-relax-b127@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x f2b1cb39d5ccab090d8353788f186f7e7a1fffd4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090312-geometry-relax-b127@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2b1cb39d5ccab090d8353788f186f7e7a1fffd4 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 13 Aug 2026 20:12:55 -0700
Subject: [PATCH] arch_numa: avoid false positive fortify warning in
 setup_node_to_cpumask_map()

When building ARCH=riscv using clang with CONFIG_FORTIFY_SOURCE and
CONFIG_UBSAN_BOUNDS enabled, CONFIG_NR_CPUS > 64, and the default value of
2 for CONFIG_NODES_SHIFT, there is a compiletime warning from the fortify
routines.

  In file included from mm/arch_numa.c:11:
  In file included from include/linux/acpi.h:14:
  In file included from include/linux/resource_ext.h:11:
  In file included from include/linux/slab.h:17:
  In file included from include/linux/gfp.h:7:
  In file included from include/linux/mmzone.h:8:
  In file included from include/linux/spinlock.h:60:
  In file included from include/linux/interrupt_rc.h:17:
  In file included from include/linux/smp.h:13:
  In file included from include/linux/cpumask.h:11:
  In file included from include/linux/bitmap.h:13:
  In file included from include/linux/string.h:383:
  include/linux/fortify-string.h:430:4: warning: call to '__write_overflow_field' declared with 'warning' attribute: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Wattribue-warning]
    430 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  include/linux/fortify-string.h:430:4: note: called by function 'fortify_memset_chk(unsigned long, unsigned long, unsigned long)'
  include/linux/bitmap.h:248:3: note: inlined by function 'setup_node_to_cpumask_map'
    248 |                 memset(dst, 0, len);
        |                 ^
  include/linux/fortify-string.h:462:25: note: expanded from macro 'memset'
    462 | #define memset(p, c, s) __fortify_memset_chk(p, c, s,                   \
        |                         ^
  include/linux/fortify-string.h:453:2: note: expanded from macro '__fortify_memset_chk'
    453 |         fortify_memset_chk(__fortify_size, p_size, p_size_field),       \
        |         ^
  include/linux/fortify-string.h:430:4: note: use '-gline-directives-only' (implied by '-g1') or higher for more accurate inlining chain locations
    430 |                         __write_overflow_field(p_size_field, size);
        |                         ^
  1 warning generated.

In this configuration, MAX_NUMNODES is 4.  clang unrolls the for loop in
setup_node_to_cpumask_map() past this, which triggers the fortify check
when accessing node_to_cpumask_map on the theoretical fifth loop iteration
because it would be an out of bounds write.

Make it clear to clang that nr_node_ids is bounded by MAX_NUMNODES due to
the logic in setup_nr_node_ids() by early returning in
setup_node_to_cpumask_map() should that condition be violated.

Link: https://lore.kernel.org/20260813-arch_numa-avoid-fortify-warning-v2-1-093ad97a78df@kernel.org
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2174
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/arch_numa.c b/mm/arch_numa.c
index 442ea239bba7..459fa60a5621 100644
--- a/mm/arch_numa.c
+++ b/mm/arch_numa.c
@@ -105,6 +105,18 @@ static void __init setup_node_to_cpumask_map(void)
 	if (nr_node_ids == MAX_NUMNODES)
 		setup_nr_node_ids();
 
+	/*
+	 * This check should never be true but it makes it clear to compilers
+	 * that node_to_cpumask_map is bound by nr_node_ids, avoiding false
+	 * positive fortify warnings when accessing node_to_cpumask_map in the
+	 * for loop below.
+	 */
+	if (unlikely(nr_node_ids > MAX_NUMNODES)) {
+		pr_err("nr_node_ids (%u) is larger than MAX_NUMNODES (%u)\n",
+		       nr_node_ids, MAX_NUMNODES);
+		return;
+	}
+
 	/* allocate and clear the mapping */
 	for (node = 0; node < nr_node_ids; node++) {
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);

