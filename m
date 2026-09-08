Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DC65A515B;
	Tue,  8 Sep 2026 22:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907925; cv=none; b=Zr4CQDrNoqXoeBYXY17Ph0Cfnhb8ug82r0GxWAH68P7SBUSfFqL9v8SL6J7TlhHQNTel60Q44xqOhI3DkZ4w/CrxbD4jI+f+iqP6785gF+LVzMvO2eIeDBo67aU8acAtOwmWvLPNGoCJluu5v3yFwboab/MOfFSrkhVad4kuIjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907925; c=relaxed/simple;
	bh=5xCeHzXMQpNoIZndgrIC9Sc1YIKYhzui75tgjkSjZag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iIQiaFwgCepyzK/R3lUgpMe1Ddvs7NYrmcIKVmq2kBp4izDVviXit5W5A0l+RnXuPNiIMmIh3b8LTNB1343S4fx8nJXqM/sEv3mGu7QCUOv6zRi0LoCNyAnUk0GjWzhQ6WE/IeysSLb2aWW0bGVVtfl+5d8+1GVmxl8o+ALFNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M5GlOX05; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3TcH0ab; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M5GlOX05";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3TcH0ab"
Date: Tue, 08 Sep 2026 22:51:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788907919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBlg+UTnNUkPla0/9iWkJIwrLs8C+IgP+h2pwGe8nvo=;
	b=M5GlOX05Bm0vgGgxPfQSJsFT67jrzyCs3UncJLbOCjboGU6S0HLu1/3THiuViE5K2ODZpv
	2JEe/E/WxCM5eGeEWtGBbq9E4JSZ44hDjYKG5eUzLscNK+CmOvAD4Bk4x57VNEO3kTviSy
	xlGIANNiNJY6T3LjG2lUR9UiJq6QtXh6ShwrEj/jqowgXq/SHZU5r+ByAEfipkqjg+itjW
	pG+TFDQX9w1hAGc5swRZLHaRbUBPW9ca4BSP996Z9QzmhxyL9eozheQtky5SojYwCzCumG
	a14lVQ9C9b4bT6t6jcvMxm8iqYSl+lxfhGRYiNyNRe9aR2EHW0xNv/dg4oSH7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788907919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BBlg+UTnNUkPla0/9iWkJIwrLs8C+IgP+h2pwGe8nvo=;
	b=g3TcH0abUVLhzhKxOYXny/qhLznlBrSL+iE4ZbSFZ/+VoGiliX+FFfeDfVwN1SVsYDfNDW
	ExPm7yHI/Hr1zpAg==
From: "tip-bot2 for Lorenzo Stoakes (ARM)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on collapse
 to avoid UAF
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Will Deacon <will@kernel.org>,
 David Carlier <devnexen@gmail.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178890791825.623050.17721262309148914501.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e65d3f0d78b79cf933b8755417846b172bc8a05d
Gitweb:        https://git.kernel.org/tip/e65d3f0d78b79cf933b8755417846b172bc=
8a05d
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:24 +03:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 08 Sep 2026 15:43:06 -07:00

x86/mm/pat: Acquire init_mm write lock on collapse to avoid UAF

x86 implements page attribute modification using its Change Page
Attributes (CPA) mechanism.

This tracks properties of ranges such as cache mode through x86 page
attributes, and as part of that logic manipulates kernel page tables.

Since commit:

  41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")

ranges of kernel page table entries can be collapsed into
huge page table entries as part of this logic.

As part of this collapse, it frees the page tables which the collapsed
entries previously pointed to, and it does so without any relevant locks
being held to preclude concurrent kernel page table walkers.

The only way this code can be reached is if CPA_COLLAPSE is specified, and
this is only set in set_memory_rox() via:

set_memory_rox()
-> change_page_attr_set_clr()
-> cpa_flush()
-> cpa_collapse_large_pages()

Notable users of this are execmem and BPF when manipulating executable
mappings.

However, this is problematic for ptdump as it walks ranges it does not own
and thus runs the risk of a use-after-free on page tables freed underneath
it.

In addition, concurrent CPA collapse operations are possible which can also
cause races.

Resolve the issue by acquiring the mmap write lock on init_mm across the
whole operation.

It is safe to acquire a sleeping lock as all the callers invoke
set_memory_rox() from process context and in any case,
change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
mutex, disallowing atomic context here.

Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation=
")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Will Deacon <will@kernel.org>
Reviewed-by: David Carlier <devnexen@gmail.com>
Tested-by: Atish Patra <atishp@meta.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Cc:stable@vger.kernel.org
Link: https://patch.msgid.link/20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org
---
 arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
 include/linux/mmap_lock.h    |  2 ++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index c38faf3..4abddd7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -22,6 +22,7 @@
 #include <linux/cc_platform.h>
 #include <linux/set_memory.h>
 #include <linux/memregion.h>
+#include <linux/cleanup.h>
=20
 #include <asm/e820/api.h>
 #include <asm/processor.h>
@@ -409,7 +410,7 @@ static void __cpa_flush_tlb(void *data)
=20
 static int collapse_large_pages(unsigned long addr, struct list_head *pgtabl=
es);
=20
-static void cpa_collapse_large_pages(struct cpa_data *cpa)
+static void __cpa_collapse_large_pages(struct cpa_data *cpa)
 {
 	unsigned long start, addr, end;
 	struct ptdesc *ptdesc, *tmp;
@@ -443,6 +444,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cp=
a)
 	}
 }
=20
+static void cpa_collapse_large_pages(struct cpa_data *cpa)
+{
+	/*
+	 * Take the mmap write lock on init_mm to:
+	 * - Avoid a use-after-free if raced by ptdump (which takes its own
+	 *   write lock on init_mm).
+	 * - Serialise concurrent CPA walkers.
+	 */
+	scoped_guard(mmap_write_lock, &init_mm)
+		__cpa_collapse_large_pages(cpa);
+}
+
 static void cpa_flush(struct cpa_data *cpa, int cache)
 {
 	unsigned int i;
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index bec0eab..b8a13b8 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -630,6 +630,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
 DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
 	     mmap_read_lock(_T), mmap_read_unlock(_T))
 DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
+DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
+	     mmap_write_lock(_T), mmap_write_unlock(_T))
=20
 static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
 {
