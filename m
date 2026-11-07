Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047581;
	b=H9cbPkTCoWMkhz71AAuCWFHNu+PFAsZ3ngnHMftrYnlMV4poDiHueOZr5rWBII5DgKb4
	 lqFYIWBLR6+CYadgiJl6A4BMEn7Shbm5G/EGj3zUGV83Iibna6xF0HMnnqgkepFtk2NpK
	 Hld59RCpqhfI0X+28wjTmuGrTh1EdAxE5gBGYcbNpzWqfMQWHh84gJEUztjOAknZu272s
	 Ldqbz/kSe+C1U7ABnHWsNSk+/xu0ai+//ZiIgVt5OSSzYeT+EOohPNli5MqwPI2clTlr8
	 8mahmjzVpr2BwvknApoihPrrm3j73BmLJuLVR8bDaw6BEWPiHW4ZCKpiWS6cTuEi4Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XY4d4WXzs8UuiFBvvYVoFw6EKYdQPjvaVN34IOWgkQU=;
	b=ka2OOy2Lyorf0Ccer6JRMSlXo1H7idjW/vLcC3S07P7Dc9gQwULe4hgIuqYqGb15PvUm
	 unnyikKd0j8a51CqeYkMmz4c8GzRVlt1U2f2cdUEa6kxAOv0W7DSK2EmVFsRmWF/QQTST
	 JkTdiOaL6rH5rKsZQsqKsj2vhQfovSLZiz81jxTptixU4H/TuvptermLrOUnG/YcG61dx
	 VJ+1tWAmb2WqzWSwA2hb/aCIo7iZC6ejJarvH4m2PsaNdLj0FCZVN6r+sz68fmzLYyfI6
	 VWufq+wlalS7khMCacIkucaHuMzshr9JIFqyPVQGvmX+ilQv+Y0q68tQI4EO1QtOSPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3fF1AJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098B1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3fF1AJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640381F0089F;
	Sat,  7 Nov 2026 10:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047580;
	bh=XY4d4WXzs8UuiFBvvYVoFw6EKYdQPjvaVN34IOWgkQU=;
	h=From:To:Cc:Subject:Date;
	b=f3fF1AJbY9xwO10Mxhs5S3Irp8W7PkYBaNNtwdgKQ34ZskLSTaXPUqI+7NNG6mtro
	 5MZgwnmWD7z/Ps74JBpIygHne0hoprOLAda++IcpFQRLYRjBvF5bJtzrPaykq5sTKB
	 VRjfAcOlE8HZtbXAb/jMv5PuEShnl5jCY87vfOdWvyZDGYsCO9JS07Sw6g3wdNJjA4
	 XJvnzUrIg3ProE6Kz0ThJxdQuB3uCgXAfTenZNe56O+4bqelPddVs4FPXrSUhUk2TT
	 p7+cfDxvE5E3S+Kh0dQKjaRwZDMUsZBgGxWeJI0ELbUf0HEbtTuyoHXBKHfIklZWK1
	 umKkEFpA1ruRA==
From: Sasha Levin <sashal@kernel.org>
To: rakukuip@gmail.com,
	weir@nebusec.ai,
	akpm@linux-foundation.org,
	vega@nebusec.ai,
	david@kernel.org,
	notasas@gmail.com,
	liam@infradead.org,
	ljs@kernel.org,
	mhocko@suse.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memory: constrain generic_access_phys() to page boundary" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:58 -0500
Message-ID: <20261107053258-failed-6.6-ae0298a5fbef@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ae0298a5fbeff32951c0d31398ccec97ec6aa0ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053258-failed-6.6-ae0298a5fbef@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ae0298a5fbeff32951c0d31398ccec97ec6aa0ea Mon Sep 17 00:00:00 2001
From: Luxiao Xu <rakukuip@gmail.com>
Date: Thu, 10 Sep 2026 11:42:50 +0800
Subject: [PATCH] mm/memory: constrain generic_access_phys() to page boundary

This patch addresses an issue in generic_access_phys() where accessing
memory across page boundaries in PFNMAP VMAs assumes physical pages are
contiguous, which can lead to accessing unintended physical memory or
exceeding VMA boundaries.

generic_access_phys() improperly validates the memory access range: it
only validates the start address using follow_pfnmap_start() and passes
PAGE_ALIGN(len + offset) to ioremap_prot().

This poses two problems:
1. In PFNMAP VMAs, consecutive virtual pages are not guaranteed to be
   physically contiguous, and individual PTEs may have different access
   permissions or writability.
2. The mapping may cross VMA boundaries if len extends beyond vma->vm_end.

Constrain the access in generic_access_phys() to at most the current page
boundary (PAGE_SIZE - offset) and map only a single PAGE_SIZE via
ioremap_prot().  Since the caller __access_remote_vm() already loops over
the requested length and handles partial transfers, it will naturally
iterate over the remaining pages.

Also add a missing (resource_size_t) cast during PFN re-validation to
avoid truncation on 32-bit PAE systems.

Link: https://lore.kernel.org/e06e28a46c2a176238f03b5740df0913e57c2861.1788842306.git.rakukuip@gmail.com
Fixes: 9cb12d7b4cca ("mm/memory.c: actually remap enough memory")
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Vega <vega@nebusec.ai>
Suggested-by: David Hildenbrand <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Grazvydas Ignotas <notasas@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/memory.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index ec63dd6212ac5..926276d419202 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7131,6 +7131,12 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	bool writable;
 	struct follow_pfnmap_args args = { .vma = vma, .address = addr };
 
+	/*
+	 * Limit access to one page at a time, as that's what follow_pfnmap_start()
+	 * guarantees; expect the caller to retry to read larger ranges.
+	 */
+	len = min_t(int, len, PAGE_SIZE - offset);
+
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
@@ -7142,7 +7148,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	if ((write & FOLL_WRITE) && !writable)
 		return -EINVAL;
 
-	maddr = ioremap_prot(phys_addr, PAGE_ALIGN(len + offset), prot);
+	maddr = ioremap_prot(phys_addr, PAGE_SIZE, prot);
 	if (!maddr)
 		return -ENOMEM;
 
@@ -7150,7 +7156,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 		goto out_unmap;
 
 	if ((pgprot_val(prot) != pgprot_val(args.pgprot)) ||
-	    (phys_addr != (args.pfn << PAGE_SHIFT)) ||
+	    (phys_addr != ((resource_size_t)args.pfn << PAGE_SHIFT)) ||
 	    (writable != args.writable)) {
 		follow_pfnmap_end(&args);
 		iounmap(maddr);
-- 
2.53.0




