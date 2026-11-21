Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795249955;
	b=3ra/361GshYqG79M476PwQFUzUs0NLomNBZUNXPO3536uqkGSYot/WZRwjKAW+Vli5Dl
	 4cWYeeXNsD3pDOp6z/WGX9SxTXD+4jUbpsCVLjey8+H/Fno5Sm1pxEMOFiTkRGm8mEVsH
	 GzrStma+Kxmhfs/iVTXWp1I9jK6NqME2CuHSehqTyynv3KIe8MMkbeBswwKxABQ07cQoE
	 zOD3R1r2385BTYiSioocboRcLeGHPNrut+CL8fIxIhzEVUkWIvXme122xhpSwQNSneGVU
	 wCPcwsyBM//V7lskPUU61WML5mAFlgfDMHMr8ZZi6ptf27XwAfxfOCi68D8AIyGz3iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795249955;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MC-Copy:X-MailChannels-SenderId:X-MailChannels-Auth-Id:
	 X-Juvenile-Ruddy:X-MC-Loop-Signature:X-MC-Ingress-Time:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AuthUser;
	bh=U3QJzZioSMNb19niLTdHJqpa/pin/cGmv4Gv8E2Edm4=;
	b=GGLJ29oGSxHvPkmjM94J7cBouZLsLfsl5KpRaINkrZxfpiVa8rEG25QOoZFJmd8+4dJI
	 a6mpXT6KZpolEB/akO8E2wsbthOvxPJd9eCNBjZwJiRcqSRYpHerSi5/gosexgQnVws6A
	 0cp6AUzZf5Fh9wgxOu0JSBmA+GsRWdaxZ9bKvKDaMgQ+1WVIlsuURqjZq7sZLhNxjUk3q
	 sgRQgN4quK7zNRlCn6peY5wIybrg/Wp70YZcHzzszwj6jfV8MsltdnGLjfqKpqR0CzSdX
	 KwdaOsGDwKd1f+2wlP7u66Oi3XueA+TBmfMXQNBk7tuVU41lpUgq2MimVhRVj+eLYQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sim.vu;
	spf=pass smtp.mailfrom=sim.vu;
	arc=none smtp.remote-ip=23.83.222.37
Received: from cockroach.ash.relay.mailchannels.net (cockroach.ash.relay.mailchannels.net [23.83.222.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43582606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43582606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sim.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sim.vu
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 078AC600F3;
	Sat, 21 Nov 2026 08:32:27 +0000 (UTC)
Received: from cpanel-010-lon.hostingww.com (100-97-173-43.trex-nlb.outbound.svc.cluster.local [100.97.173.43])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id DF451629DE;
	Sat, 21 Nov 2026 08:32:20 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|brad@sim.vu
X-MailChannels-Auth-Id: instrampxe0y3a
X-Juvenile-Ruddy: 2530bb0949302cad_1795249946826_3700707252
X-MC-Loop-Signature: 1795249946826:3590204740
X-MC-Ingress-Time: 1795249946826
Received: from cpanel-010-lon.hostingww.com (cpanel-010-lon.hostingww.com
 [18.130.191.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.173.43 (trex/8.0.2);
	Sat, 21 Nov 2026 08:32:26 +0000
Received: from 162-195-230-196.lightspeed.wchtks.sbcglobal.net ([162.195.230.196]:35312 helo=epyc.attlocal.net)
	by cpanel-010-lon.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <brad@sim.vu>)
	id 1xUgWA-00000002cE4-01LZ;
	Sat, 21 Nov 2026 08:32:18 +0000
From: Brad Hawthorne <brad@sim.vu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org,
	Brad Hawthorne <brad@sim.vu>,
	Hajime Tazaki <thehajime@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/nommu: keep the maple tree in step when mremap() resizes in place
Date: Sat, 21 Nov 2026 02:31:39 -0600
Message-ID: <20261121083139.803682-1-brad@sim.vu>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: brad@sim.vu

On !MMU, do_mremap() resizes a VMA by writing vma->vm_end and nothing
else, so mm->mm_mt keeps the old extent.

After a shrink, [new_end, old_end) in the tree still points at the VMA.
When the VMA is unmapped, delete_vma_from_mm() clears only
[vm_start, vm_end), so that range survives and points at the freed
vm_area_struct. Lookups in the range then read freed memory (after the
munmap(), /proc/self/maps still lists it), and exit_mmap() frees the
VMA a second time. An unprivileged process is enough:

	long pg = sysconf(_SC_PAGESIZE);
	char *p = mmap(NULL, 8 * pg, PROT_READ | PROT_WRITE,
		       MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

	mremap(p, 8 * pg, 4 * pg, 0);
	munmap(p, 4 * pg);
	_exit(0);

It was first seen on an Adafruit Fruit Jam board (RP2350, Cortex-M33)
running 7.3.1. There, three rounds of the program's mmap, mremap and
munmap leave the process's vsize at 2133 KB instead of 64 KB, and the
next exec faults the kernel, in vm_area_alloc() or __kernel_read()
under do_mmap(): the double free has corrupted the slab. With this
patch on the same kernel, 11 of 11 runs keep the vsize at 64 KB and
the board runs on.

On mm-unstable at the base commit below, under QEMU mps2-an385
(mps2_defconfig plus SLUB_DEBUG_ON), run as uid 65534:

  BUG vm_area_struct (Not tainted): Object already free
  Allocated in vm_area_alloc+0x10/0x38 age=0 cpu=0 pid=20
  Freed in do_munmap+0x2ec/0x2fc age=0 cpu=0 pid=20
   kmem_cache_free from exit_mmap+0x7c/0x8c
   exit_mmap from mmput+0x2a/0x74
   mmput from do_exit+0x1f8/0x520

Clear the range given up on a shrink. Once a shrink clears it, a later
grow back into the region must store the VMA over its new extent, or
find_vma() would miss addresses that are mapped; so store it there on a
grow. Shared and overlay mappings are refused above, so the region is
this VMA's alone, and the grow is bounded by its size; but the range a
shrink gave up may since have been mapped again, by a direct mapping of
device memory at those addresses, so a grow into another mapping fails
with -ENOMEM. As before, a shrink keeps the region's pages, which is
what lets a grow back reuse them.

With this patch the program above exits cleanly, with and without
DEBUG_VM_MAPLE_TREE (nommu has no tree validation of its own, so that
adds only the store's warnings). A shrink, grow and partial munmap()
sequence also passes, and fails with the shrink half alone, which is
why the grow half is needed.

524e00b36e8c is where nommu find_vma() started trusting the maple tree;
the exit_mmap() double free above follows from 8220543df148 ("nommu:
remove uses of VMA linked list") in the same v6.1 series.

Not changed here: a private file mapping's place in the file's i_mmap
tree also goes stale on a resize. That predates the maple tree and is
left to a separate patch.

Sashiko's review of Hajime Tazaki's nommu series found the stale range
in July, and his fixes and RFC since then cover it [1][2]; review asked
for a minimal fix-only patch with a Fixes: tag [3]. This is a minimal
version of that fix.

The consequence was reproduced and this patch drafted with an AI coding
assistant (Claude, Anthropic): it reviewed mm/nommu.c, wrote the
reproducer and ran the board and QEMU tests; I checked the result.
Stable backports need adjusting: 6.6.y and 6.12.y lack
vma_iter_store_overwrite(), and 6.1.y nommu uses the ma_state API.

Link: https://lore.kernel.org/linux-mm/20260710021028.892645-1-thehajime@gmail.com/ [1]
Link: https://lore.kernel.org/linux-mm/20260813063401.1786548-2-thehajime@gmail.com/ [2]
Link: https://lore.kernel.org/linux-mm/an77pELeQdW-sTEi@lucifer/ [3]
Fixes: 524e00b36e8c ("mm: remove rb tree.")
Cc: Hajime Tazaki <thehajime@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Brad Hawthorne <brad@sim.vu>
---
Hajime, as you asked, here it is as a separate patch with you on Cc.
Earlier note, and his reply: https://lore.kernel.org/linux-mm/20261120221021.789792-1-brad@sim.vu/

 mm/nommu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index df99495c8..9221cd241 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1575,6 +1575,7 @@ static unsigned long do_mremap(unsigned long addr,
 			unsigned long flags, unsigned long new_addr)
 {
 	struct vm_area_struct *vma;
+	unsigned long new_end;
 
 	/* insanity checks first */
 	old_len = PAGE_ALIGN(old_len);
@@ -1601,8 +1602,37 @@ static unsigned long do_mremap(unsigned long addr,
 	if (new_len > vma->vm_region->vm_end - vma->vm_region->vm_start)
 		return (unsigned long) -ENOMEM;
 
-	/* all checks complete - do it */
-	vma->vm_end = vma->vm_start + new_len;
+	/*
+	 * All checks complete - do it.  The maple tree must cover exactly the
+	 * new extent: a range given up but left in the tree still maps to this
+	 * VMA, and once the VMA is unmapped and freed, to freed memory.
+	 */
+	new_end = vma->vm_start + new_len;
+	if (new_len < old_len) {
+		VMA_ITERATOR(vmi, vma->vm_mm, new_end);
+
+		if (vma_iter_clear_gfp(&vmi, new_end, vma->vm_end, GFP_KERNEL))
+			return (unsigned long) -ENOMEM;
+		vma->vm_end = new_end;
+	} else if (new_len > old_len) {
+		VMA_ITERATOR(vmi, vma->vm_mm, vma->vm_start);
+
+		/*
+		 * Shared and overlay mappings were refused above, so the
+		 * region is this VMA's alone and still holds its pages: the
+		 * grow, bounded by the region's size, stays inside it. The
+		 * range a shrink gave up may since have been mapped again,
+		 * though: a direct mapping of device memory can take any
+		 * address.
+		 */
+		if (find_vma_intersection(vma->vm_mm, vma->vm_end, new_end))
+			return (unsigned long) -ENOMEM;
+		vma_iter_config(&vmi, vma->vm_start, new_end);
+		if (vma_iter_prealloc(&vmi, vma))
+			return (unsigned long) -ENOMEM;
+		vma->vm_end = new_end;
+		vma_iter_store_overwrite(&vmi, vma);
+	}
 	return vma->vm_start;
 }
 

base-commit: d12eccbcb79a4fa35c3aa588eb79056af62eb859
-- 
2.43.0

