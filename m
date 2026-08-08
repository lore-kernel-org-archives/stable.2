Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BC53002A0
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187578; cv=none; b=omPY0wTY/E7XYootM4meWAVcenWMduiT37BjOzewsg5cZ8fgu3HzfmxBVzxb6HJrANEuKNTiyVUfUE2Bxk+FHYfQdonW88sCFhRQdzMCvpb3NS0yUpqwcoPSM8cbeJUZ/xmFiCiH5SwWmaCF0Ei22d740xdyWyOJSYT1lXL8QJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187578; c=relaxed/simple;
	bh=fYtdSDarUZEzhPkwpg0fGk8S7+vr+Sew9zujkItkRhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D7R8VVn6GNjaweQZckR6xs4OFcPoXuTvWv6exYek5UynNmYMRNbOg6+3XV+H/nSfiHXNMuL9GUaApvpiFaLzgQvpi3+VCbLPH26pitzd/P3PCZtXvdmd/fbF384hwIPto7zqvyG3NeeGOI6Twp6wI+HnuvyjSkoIxN3ugWf8ViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALwrP/As; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALwrP/As"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06EA1F00A3E;
	Sat,  8 Aug 2026 11:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187577;
	bh=yyV+AcDgw/V23j3pteFsxpqlDVNO5RzrlvCgaIEQHwc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ALwrP/AsHh7r8Qx+Tfzc3qf6H8mNnByv8f0MKc3Y2qtncy8pWgk6FZgItl5V6PKSM
	 Dvp9dQmh1dIPxlF2+nzsffNoq8dOAA1yx9FEU7Ose95KzQFGoVuiPefw/gjrNud50j
	 L9Jb5fFdAbjaaXQhuuj3jWNoxiM9mskF52VPjrwbIQeHlNMtgApuMfKBbZuRx8Blv5
	 TajN54BjyB5CU2R0iXlspY1yNSuVAozDRJABu5XFHJq0w2y/pCo3VIp2MpQF/o8y26
	 AuvXFjT/TqENaS5lD6OHFwB14EadUEKKevr9o76l4uQgRcPjvLQ+DSsv0305JbARnA
	 UWmb34EH3zWOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Harry Yoo (Oracle)" <harry@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	James Houghton <jthoughton@google.com>,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Nikita Kalyazin <kalyazin@amazon.com>,
	Oscar Salvador <osalvador@suse.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Xu <peterx@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] userfaultfd: move vma_can_userfault out of line
Date: Sat,  8 Aug 2026 07:12:49 -0400
Message-ID: <20260808111250.94416-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808111250.94416-1-sashal@kernel.org>
References: <2026072906-plank-status-52f6@gregkh>
 <20260808111250.94416-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

[ Upstream commit a5bb8669872b6b8463b8777a7a259a8305060016 ]

vma_can_userfault() has grown pretty big and it's not called on
performance critical path.

Move it out of line.

No functional changes.

Link: https://lore.kernel.org/20260402041156.1377214-7-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand (Red Hat) <david@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrei Vagin <avagin@google.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Harry Yoo <harry.yoo@oracle.com>
Cc: Harry Yoo (Oracle) <harry@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: James Houghton <jthoughton@google.com>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nikita Kalyazin <kalyazin@amazon.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: David Carlier <devnexen@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 3c58f641e813 ("userfaultfd: prevent registration of special VMAs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/userfaultfd_k.h | 21 +--------------------
 mm/userfaultfd.c              | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index fac0f3d0deb9a..67ff2889374f1 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -160,26 +160,7 @@ static inline bool userfaultfd_armed(struct vm_area_struct *vma)
 	return vma->vm_flags & __VM_UFFD_FLAGS;
 }
 
-static inline bool vma_can_userfault(struct vm_area_struct *vma,
-				     unsigned long vm_flags)
-{
-	if ((vm_flags & VM_UFFD_MINOR) &&
-	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
-		return false;
-
-	/*
-	 * If user requested uffd-wp but not enabled pte markers for
-	 * uffd-wp, then shmem & hugetlbfs are not supported but only
-	 * anonymous.
-	 */
-	if (!uffd_supports_wp_marker() && (vm_flags & VM_UFFD_WP) &&
-	    !vma_is_anonymous(vma))
-		return false;
-
-	/* By default, allow any of anon|shmem|hugetlb */
-	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
-	    vma_is_shmem(vma);
-}
+bool vma_can_userfault(struct vm_area_struct *vma, unsigned long vm_flags);
 
 extern int dup_userfaultfd(struct vm_area_struct *, struct list_head *);
 extern void dup_userfaultfd_complete(struct list_head *);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 92fe2a76f4b51..82aeaa936f019 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -891,3 +891,23 @@ int mwriteprotect_range(struct mm_struct *dst_mm, unsigned long start,
 	mmap_read_unlock(dst_mm);
 	return err;
 }
+
+bool vma_can_userfault(struct vm_area_struct *vma, unsigned long vm_flags)
+{
+	if ((vm_flags & VM_UFFD_MINOR) &&
+	    (!is_vm_hugetlb_page(vma) && !vma_is_shmem(vma)))
+		return false;
+
+	/*
+	 * If user requested uffd-wp but not enabled pte markers for
+	 * uffd-wp, then shmem & hugetlbfs are not supported but only
+	 * anonymous.
+	 */
+	if (!uffd_supports_wp_marker() && (vm_flags & VM_UFFD_WP) &&
+	    !vma_is_anonymous(vma))
+		return false;
+
+	/* By default, allow any of anon|shmem|hugetlb */
+	return vma_is_anonymous(vma) || is_vm_hugetlb_page(vma) ||
+	    vma_is_shmem(vma);
+}
-- 
2.53.0

