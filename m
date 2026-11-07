Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048875;
	b=l/u2eNkcM7QWuAt/079N/iQAARzGSsai+IdXeWO4DxHcVBmcLMdeVZInAc1bPDVhoYj+
	 LL0yaSX0UnsgdSnqHyGq3Hm+NHi9M1LPURmnnZ6qnszD5wBvY7ly6WE4Uak2u7Nhdvvvb
	 4RuyNylgGTuAUF5rw4AO4q74uz4jol2RZnmSyHl+zbweZ+Gmyrol27KxztGMwGH7q+zIM
	 KvZightwREB8pi69+QNPggjsoqq24kMy2WVWNxy/b020J/EYcQO9vAXfWS9sACJJbj6eP
	 nifLo2fMG3XA5VyPJaZX7IAjCdH+WYwrYwul3D4dl7P8cryJzUduNzNgz9zZKKZj22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OfyReqbyyxiiLsp/o+mz7CLMT7XGFUETbpGTQDjx8lc=;
	b=nOz96vSOE9n1QkThGpJagd3o/SI1auz/LKDxHf7awPZE18bP66a2bxARGx3xmd8HxTJ/
	 fBh4gLAOCtO/rx4oUeRoHLSoV8PU9Kc+1CiCMsYzxgJDeen3oUE9Hyxob/gVHkGx5dBfh
	 z1o/Nj3IoVQXLYCnKT0gNLucTj6j2gmsmXSkOJKgbLuZGz1jJfs8TCYRVA0r9jcsutV88
	 VuWme6PgI9UaIK2QTf0Ccjdn5F2UaqFWfDAQj3v2Ec46Hid9hYZ4v+VFUPHX5QuOMQmpr
	 igYk/mQ3AaNU5R+Zq4AOoMF1RnLOepdTiHZ7MrjA5p6ia6Ovo9kj6P/ruKCeX9HjEDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neOndq9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5F1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=neOndq9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0DB1F0089F;
	Sat,  7 Nov 2026 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048875;
	bh=OfyReqbyyxiiLsp/o+mz7CLMT7XGFUETbpGTQDjx8lc=;
	h=From:To:Cc:Subject:Date;
	b=neOndq9qvu1cX2Qys8NxX4O8XXZx3EOOoM8qhOz9U+dZEg3aY6nUbH/jNmljTY2EM
	 UDFHPVsxpUBCRKWIux7oABAFLghhB0M0ODtbAkQiw/zoFhDpI6lGxDLx6dOHula2J8
	 cnoNVvmsOA3XZkiUhSiUPhFaZFnCVyVpmUZ/A96gAgHisZdPPf/o4/7sx8jsrzTrpj
	 Qt44ai+Er1O58FG8UeT4GImQVNpboRYkaCz/Zxvk4fjYAvBj0Q08C9v2MFl917lQru
	 z2CuVEiXQMmzJUVtY8bXnNxRs6AWibNxZk3FBDCAEiEDWK645jIARZsWPsq5q4Pwwc
	 5x5daD1X+/fkw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	akpm@linux-foundation.org,
	ngocthang2710.1999@gmail.com,
	ljs@kernel.org,
	rppt@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	benh@kernel.crashing.org,
	a.p.zijlstra@chello.nl,
	riel@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm: disallow ioremap'ing ordinary RAM in generic_access_phys()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:54:32 -0500
Message-ID: <20261107055432-failed-6.1-4590752e20aa@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 4590752e20aa393cc0d4fe538c0747d14a98c97a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055432-failed-6.1-4590752e20aa@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4590752e20aa393cc0d4fe538c0747d14a98c97a Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 13 Oct 2026 13:41:24 +0200
Subject: [PATCH] mm: disallow ioremap'ing ordinary RAM in
 generic_access_phys()

generic_access_phys() can end up getting called on CoW PFNMAP mappings,
resulting in it trying to ioremap anonymous folios, which especially
the x86 code doesn't enjoy, and which is in general just odd/wrong.

E.g., with a CoW mapping of a PCI BAR:

ioremap on RAM at 0x0000000045623000 - 0x0000000045623fff
  WARNING: arch/x86/mm/ioremap.c:216 at __ioremap_caller.isra.0+0x4c2/0x5f0
  Call Trace:
   generic_access_phys+0x130/0x4d0 mm/memory.c:7178
   kernfs_vma_access+0x1ce/0x280 fs/kernfs/file.c:437
   __access_remote_vm+0x58f/0x890 mm/memory.c:7256
   mem_rw+0x2a1/0x670 fs/proc/base.c:912

But more generically, we should disallow access to anything that looks
like ordinary RAM in the system: including allocating memory (e.g.,
alloc_pages) and mapping them in a VM_PFNMAP.

For pages with an online memmap, allow only pages marked as reserved
(PageReserved). This also includes memblock allocations, however,
distinguishing them from other MMIO is tricky, and nobody should really
be mapping them in a PFNMAP (except someone abusing /dev/mem, which we
do not care about).

So only allow access if there is no online memmap, or if the pages are
marked reserved. Reject other pages with -EINVAL.

Note that, just like other pfn_to_online_page() users, we won't care about
concurrent memory offlining; mapping memory that can concurrently get
offlined is highly dubious.

Link: https://lore.kernel.org/20261013-generic_access_phys-v1-1-b3963ef76e37@kernel.org
Fixes: 28b2ee20c7cb ("access_process_vm device memory infrastructure")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+49b1021becba70c1f3f6@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=49b1021becba70c1f3f6
Reported-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Closes: https://lore.kernel.org/r/20261001152524.171115-1-ngocthang2710.1999@gmail.com/
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Rik van Riel <riel@redhat.com>
Cc: <stable@vger.kernel.org>
---
 mm/memory.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index ed64455c73bdb..34e60a5baf7ce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7129,6 +7129,7 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 	resource_size_t phys_addr;
 	pgprot_t prot = __pgprot(0);
 	void __iomem *maddr;
+	struct page *page;
 	int offset = offset_in_page(addr);
 	int ret = -EINVAL;
 	bool writable;
@@ -7143,6 +7144,19 @@ int generic_access_phys(struct vm_area_struct *vma, unsigned long addr,
 retry:
 	if (follow_pfnmap_start(&args))
 		return -EINVAL;
+
+	/*
+	 * Reject anything that looks like ordinary RAM, including anonymous
+	 * folios in CoW mappings or allocated kernel memory. Note that we
+	 * cannot distinguish memblock allocations from non-RAM reliably, so
+	 * we cannot easily reject them here.
+	 */
+	page = pfn_to_online_page(args.pfn);
+	if (page && !PageReserved(page)) {
+		follow_pfnmap_end(&args);
+		return -EINVAL;
+	}
+
 	prot = args.pgprot;
 	phys_addr = (resource_size_t)args.pfn << PAGE_SHIFT;
 	writable = args.writable;
-- 
2.53.0




