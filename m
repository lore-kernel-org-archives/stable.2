Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7F3A83A9
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187576; cv=none; b=lvFyP1nr8H8gjN3ygTOsjtkyhQLYK1fFXJRCdQQ1xppt2t5BSbjgEO3bhj4lVMuI2Us6bunkM6a3f8fsZdrQ4LSC0cI+HVy15NmbAsPkbsEVYC47hXkC2f7Ti5pwYdaOLqKETQ+Rt6oXt/G5PDu6HC/jTQSmf7s+y1HbTZmHuWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187576; c=relaxed/simple;
	bh=y/JhJhY29krL4U6BfMgMK2NzqKyMT9K7xL8MkJojnqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUXgmBDk/DcMze2POKrTITKlmOjAagqbx8VX8+YQSnio8SYPDZBVUXUoxfi9BulHi2ZpcGz30NxXvAt8GgDCs80SdKzeSZb4F5wIZd4D9Q9C6lS9kqy+qfvtphr48nsint8VVP+P7/3GlH/9NgOIC18gmE/P2ALWetbjTjCXhd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRj4uZfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRj4uZfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159D51F000E9;
	Sat,  8 Aug 2026 11:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187574;
	bh=QXAcVPdvRgxz67Pt3V8gFOHXA3lEsI87xTr09csR0U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oRj4uZfjVC3Q33EMJVpjYkwZPuXNZewlCzCtHaj2aGszTHvOqJmN1BDzv2NMmBbAs
	 wJX8W634ar5Z+NekbSIuyCJ612XxgrzrvF6dQmUnfTxDvXLhiA4/jddJ5YoPjD+oQD
	 OnY6uxgCkYutj1S0rKxjN4ESB/LscLpx4aSS0HHt4rMTyD9+N17ZPs1oJfJWs5aHMG
	 OHnMkZ+D31h2YfOjP9LeVRZqpdlhnU5RCQRySLNAAGxfVuvhDEOUbYAuV4Aw9QOaJO
	 ZcchvuWlG7Z1CnG+XJKB/Ff+ouILYGwacGU258B8jVkE6npyfMVr981rGwiTzY9pF5
	 2EMCDT0NOgw7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	David Hildenbrand <david@redhat.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Jones <ajones@ventanamicro.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor@kernel.org>,
	Deepak Gupta <debug@rivosinc.com>,
	Jan Kara <jack@suse.cz>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Xu <peterx@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Yuanchu Xie <yuanchu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] mm: userfaultfd: add pgtable_supports_uffd_wp()
Date: Sat,  8 Aug 2026 07:12:48 -0400
Message-ID: <20260808111250.94416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072906-plank-status-52f6@gregkh>
References: <2026072906-plank-status-52f6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>

[ Upstream commit f59c0924d61aa2a2bb85936a593140f327112787 ]

Some platforms can customize the PTE/PMD entry uffd-wp bit making it
unavailable even if the architecture provides the resource.  This patch
adds a macro API pgtable_supports_uffd_wp() that allows architectures to
define their specific implementations to check if the uffd-wp bit is
available on which device the kernel is running.

Also this patch is removing "ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP" and
"ifdef CONFIG_PTE_MARKER_UFFD_WP" in favor of pgtable_supports_uffd_wp()
and uffd_supports_wp_marker() checks respectively that default to
IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) and
"IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP) &&
IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP)" if not overridden by the
architecture, no change in behavior is expected.

Link: https://lkml.kernel.org/r/20251113072806.795029-3-zhangchunyan@iscas.ac.cn
Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Jones <ajones@ventanamicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>
Cc: Conor Dooley <conor@kernel.org>
Cc: Deepak Gupta <debug@rivosinc.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c58f641e813 ("userfaultfd: prevent registration of special VMAs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/userfaultfd.c                   | 20 ++++++++++----------
 include/asm-generic/pgtable_uffd.h | 17 +++++++++++++++++
 include/linux/mm_inline.h          |  7 ++++---
 include/linux/userfaultfd_k.h      |  8 +++++---
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 49f0742625981..0ebdf3c2c9ee6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1354,9 +1354,9 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MISSING)
 		vm_flags |= VM_UFFD_MISSING;
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_WP) {
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-		goto out;
-#endif
+		if (!pgtable_supports_uffd_wp())
+			goto out;
+
 		vm_flags |= VM_UFFD_WP;
 	}
 	if (uffdio_register.mode & UFFDIO_REGISTER_MODE_MINOR) {
@@ -2068,13 +2068,13 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	uffdio_api.features &=
 		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
-#ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
-#endif
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
-	uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
-	uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
-#endif
+	if (!pgtable_supports_uffd_wp())
+		uffdio_api.features &= ~UFFD_FEATURE_PAGEFAULT_FLAG_WP;
+
+	if (!uffd_supports_wp_marker()) {
+		uffdio_api.features &= ~UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
+		uffdio_api.features &= ~UFFD_FEATURE_WP_UNPOPULATED;
+	}
 
 	ret = -EINVAL;
 	if (features & ~uffdio_api.features)
diff --git a/include/asm-generic/pgtable_uffd.h b/include/asm-generic/pgtable_uffd.h
index 828966d4c2811..0d85791efdf77 100644
--- a/include/asm-generic/pgtable_uffd.h
+++ b/include/asm-generic/pgtable_uffd.h
@@ -1,6 +1,23 @@
 #ifndef _ASM_GENERIC_PGTABLE_UFFD_H
 #define _ASM_GENERIC_PGTABLE_UFFD_H
 
+/*
+ * Some platforms can customize the uffd-wp bit, making it unavailable
+ * even if the architecture provides the resource.
+ * Adding this API allows architectures to add their own checks for the
+ * devices on which the kernel is running.
+ * Note: When overriding it, please make sure the
+ * CONFIG_HAVE_ARCH_USERFAULTFD_WP is part of this macro.
+ */
+#ifndef pgtable_supports_uffd_wp
+#define pgtable_supports_uffd_wp()	IS_ENABLED(CONFIG_HAVE_ARCH_USERFAULTFD_WP)
+#endif
+
+static inline bool uffd_supports_wp_marker(void)
+{
+	return pgtable_supports_uffd_wp() && IS_ENABLED(CONFIG_PTE_MARKER_UFFD_WP);
+}
+
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_WP
 static __always_inline int pte_uffd_wp(pte_t pte)
 {
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 96b1c157554c0..4fbf25c45ec91 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -547,7 +547,6 @@ static inline pte_marker copy_pte_marker(
 
 	return dstm;
 }
-#endif
 
 /*
  * If this pte is wr-protected by uffd-wp in any form, arm the special pte to
@@ -565,9 +564,11 @@ static inline void
 pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 			      pte_t *pte, pte_t pteval)
 {
-#ifdef CONFIG_PTE_MARKER_UFFD_WP
 	bool arm_uffd_pte = false;
 
+	if (!uffd_supports_wp_marker())
+		return;
+
 	/* The current status of the pte should be "cleared" before calling */
 	WARN_ON_ONCE(!pte_none(ptep_get(pte)));
 
@@ -594,7 +595,6 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
 	if (unlikely(arm_uffd_pte))
 		set_pte_at(vma->vm_mm, addr, pte,
 			   make_pte_marker(PTE_MARKER_UFFD_WP));
-#endif
 }
 
 static inline bool vma_has_recency(struct vm_area_struct *vma)
@@ -607,5 +607,6 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
 
 	return true;
 }
+#endif
 
 #endif
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index ac8c6854097cd..fac0f3d0deb9a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -166,15 +166,17 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	if ((vm_flags & VM_UFFD_MINOR) &&
 	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
 		return false;
-#ifndef CONFIG_PTE_MARKER_UFFD_WP
+
 	/*
 	 * If user requested uffd-wp but not enabled pte markers for
 	 * uffd-wp, then shmem & hugetlbfs are not supported but only
 	 * anonymous.
 	 */
-	if ((vm_flags & VM_UFFD_WP) && !vma_is_anonymous(vma))
+	if (!uffd_supports_wp_marker() && (vm_flags & VM_UFFD_WP) &&
+	    !vma_is_anonymous(vma))
 		return false;
-#endif
+
+	/* By default, allow any of anon|shmem|hugetlb */
 	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
 	    vma_is_shmem(vma);
 }
-- 
2.53.0

