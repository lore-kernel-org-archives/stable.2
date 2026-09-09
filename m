Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B713B2FC8;
	Wed,  9 Sep 2026 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936291; cv=none; b=cYGdkOl6o+GH7yY7O9WYFhhXp/xuuk3AIlQpM2yB5HtcPtlJtrfd1v9j91tqELTmtzSJwx4+whFSSeCnuhyry9w1eZav/flzX9p33sQzNvMkzQAjYQ/f/fV9TkQF9CMjATVk8yz9n6VY/k7SOH7oRcQO4mmfvyDYZ+47IrvbkNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936291; c=relaxed/simple;
	bh=h4FW0yyt3kzqUUclmpweY6GYhfksgxgNMuK6HAguxsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hwDebYtBYluUrQ0JCmOT8inT/ErSxzvoPYZPXC/oy8sXqXk2sl9YdFtXaNmhmv7Rmww/DsqbYEpXe39uuiv8RnnewHoUjlEdMItzzfU1jLhV8VuWWJasn/0k96WsBTJrrhxsRrk9qxnK1sDPmEYGVajCO2ergCNsMdrb5do3ktM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B5eJN4UF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x9eM+0Ro; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B5eJN4UF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x9eM+0Ro"
Date: Wed, 09 Sep 2026 06:44:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788936288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVDt0UNn4RbajPVRIH7apfIlI4lm22OL83huSlpNSKw=;
	b=B5eJN4UFdZL/zdPSZCScWwtKDsQ/vKYqXnSdVT7faJQj/1RVYykUZeEXF/zoOPKHe/rJWf
	sC3L1+0H1w9e+k4/H7PKwjoc0a8wx8+Txo+THDXjwK2uZLJdcsqg26909id3rEs5MrtXpl
	88rnuclRT0CxOP6mxgN3sg2esUskzivK6ywgz9o97dLumwM4JEclx7LJoHoXvuEl0T51ff
	QX2EB+7m861RxMARngPtKcXeYAK+4ckjI8KKPVB7UWAcU+lITERhIeGeUBcAP2CvPmV3/O
	IzPui0kajg1KHIygxCejWKqYQAOQewOvx/+3P7ac0yR9mS5scUC6gFezl/whiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788936288;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mVDt0UNn4RbajPVRIH7apfIlI4lm22OL83huSlpNSKw=;
	b=x9eM+0RosFYgTsCN24Ern1Oih3okaXSMXrOS7cFAaRXzndXu1+TXJA/valQb4VkdgO9vOo
	xC9neJ9QQlmuwsBQ==
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
Message-ID: <178893628651.623050.5611793532943336222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a1c7570cedd03372812a5b693732880867babbca
Gitweb:        https://git.kernel.org/tip/a1c7570cedd03372812a5b693732880867b=
abbca
Author:        Lorenzo Stoakes (ARM) <ljs@kernel.org>
AuthorDate:    Thu, 13 Aug 2026 12:01:24 +03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Sep 2026 08:38:56 +02:00

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
