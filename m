Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795277021;
	b=iQX509OTh0r07PqBoYx2PfpikGAHvT7l7/PQ7iDobH4qhmnHV/aV+ELirMs9Xt4MdSsv
	 11WQnKDSDxfLfZgtPyxxk3Mh0E7MbN5AHS7WBdn7hvUntHr4In8+vvIu64A0qHfGQH1pH
	 LcGIGlVJDonLz0AZsN48G++HeZjzsrjKyCELgg+bTaYK6gDDUtFDqtIK63Ly5u0r57iBZ
	 KaX7LWabp4IR2LMm30bqroaJhQemH15SCce2vFcPPeyPvU3T+NzeVkwncwrf9wxOK5r43
	 Zy1RTyKldT/V9xrT6UNpnZTrgBZP2m22ciUFnJc6JhuKSJ1yUVsz5uVl0/wjGZN1xJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795277021;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=+C9l+IS7SCxPcSHtzeCDE4TxFlpud6Kg+iAbboFgMPs=;
	b=iwExc/U7Sa1PRSt0heuiQojsKgnJb23Wj7zkiPUZ/IhL7DaqUMjBXKVflgloiIhsrxAr
	 MNc+AzTmzakorWP3bSNnFr5L3A1VYZLQqxK6mSsEw9Fn0ImJ1AtN8pR2jboU/qc0AeIM6
	 4sB16hGUAU1PVCLtIYpssXAlsHPCgt+k5G2gLbGowZARb/S/2Q3m7f3j+9LvtdaaLvhAk
	 WqIcpfpRtYxzpeA5/eAVhiUvAqhSoLM+eZW/vr9FPt2J23WX3SQUxErxW3eRUwR5UWPie
	 kogAN1d/h48jP6X/PX/Lwz7S2XovhLC0UqqXJ7WO3QJUYy5dGBMCoZ8mxg1Tx6zdpzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OflyxjEh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B149606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OflyxjEh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE49E1F000C4;
	Sat, 21 Nov 2026 16:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795277021;
	bh=+C9l+IS7SCxPcSHtzeCDE4TxFlpud6Kg+iAbboFgMPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OflyxjEhoD0voCnNCY2R4mds+3ZOkH1KDw1OHvIBpX7XBt8KynH5tr+nm8jt49Ghb
	 Bm9B6MvN3DhyFx/reQttoZW5upnQ5lvbQKTOh+Dqt2M9lb10xyOTI4bI9lbRz0DcN7
	 zs21McIaO1VBXKcQgDPu9rEfWhU7unsQXE+KMBb20r+kTYbZNyisZw8K3XY7Gz+zQt
	 CPOdbOMwp17PxlU/HZrLW9K8RRFLS1EBzPNDhfKzt2+W/0XBwT4z3I6eCcFACiW26q
	 2EzDsXttSK4pv9ihhDuY4rA98g+k+MhZxiuyy9TOXYpo5dhy7HX7/GyTzibWRnsfsR
	 55PQ3x1aIrESQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 21 Nov 2026 16:02:31 +0000
Subject: [PATCH 5/7] mm/mremap: apply the mmap() offset limits on expansion
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3113; i=ljs@kernel.org;
 h=from:subject:message-id; bh=xSyHxzLxvrEBvMH92UdZdyEHtxwSf4VUzODUn24kk2w=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2wPe/IvvkVZ3OyvcOL8yLWGMYF83nuDn+WdjzT5a
 cKsHKTeUcrCIMbFICumyPL8i/j+IJGweZ0X/N1g5rAygQxh4OIUgIn4rGZkuLD8SQu3kt7505qV
 xh7Hl8k8+Rhsrarnt+nBz+sMd1P1Mxj+O7ZJ7zqblJytsv7+3jPez75w8p/y2Hfg+Su7xENT7z9
 34gQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

Commit be83bbf80682 ("mmap: introduce sane default mmap limits") made
do_mmap() reject file mappings which extend beyond the maximum offset the
file can support, via file_mmap_ok().

However mremap() can expand a file mapping and only checks that the page
offset does not wrap, so a mapping can be grown past the limit that mmap()
would have enforced.

Fault handlers rely on that limit. For instance dax_iomap_pte_fault()
converts vmf->pgoff into a loff_t, which overflows for such an offset and
defeats its i_size check.

Fix the issue by applying file_mmap_ok() to the expanded range in
check_prep_vma(), failing the mremap() with -EINVAL if it exceeds the
limit.

This means that mremap() now refuses expansions it previously permitted,
however no file can have data at these offsets, and mmap() already refuses
the equivalent mapping.

Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: fixed up commit msg ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/internal.h | 2 ++
 mm/mmap.c     | 4 ++--
 mm/mremap.c   | 6 ++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a09dbdfd615d..aa7fba0a1c41 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -941,6 +941,8 @@ extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
 		unsigned long end, bool write, int *locked);
 bool mlock_future_ok(const struct mm_struct *mm, bool is_vma_locked,
 		unsigned long bytes);
+bool file_mmap_ok(struct file *file, struct inode *inode, unsigned long pgoff,
+		  unsigned long len);
 
 /*
  * NOTE: This function can't tell whether the folio is "fully mapped" in the
diff --git a/mm/mmap.c b/mm/mmap.c
index 7618e72766a5..79702841c06c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -264,8 +264,8 @@ static inline u64 file_mmap_size_max(struct file *file, struct inode *inode)
 	return ULONG_MAX;
 }
 
-static inline bool file_mmap_ok(struct file *file, struct inode *inode,
-				unsigned long pgoff, unsigned long len)
+bool file_mmap_ok(struct file *file, struct inode *inode, unsigned long pgoff,
+		  unsigned long len)
 {
 	u64 maxsize = file_mmap_size_max(file, inode);
 
diff --git a/mm/mremap.c b/mm/mremap.c
index fff0465f5e06..8043c425b5df 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1791,6 +1791,7 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = vrm->addr;
 	unsigned long old_len, new_len, pgoff;
+	struct file *file;
 
 	if (!vma)
 		return -EFAULT;
@@ -1870,6 +1871,11 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (vma_is_fixed_mapping(vma))
 		return -EFAULT;
 
+	/* The expanded range must obey the same offset limits as mmap(). */
+	file = vma->vm_file;
+	if (file && !file_mmap_ok(file, file_inode(file), pgoff, new_len))
+		return -EINVAL;
+
 	if (!mlock_future_ok(mm, vma_test(vma, VMA_LOCKED_BIT), vrm->delta))
 		return -EAGAIN;
 

-- 
2.56.0

