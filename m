Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521390;
	b=xbbKF0MNvD8MolZUV9IfZDcKMAGUiekfCu2a/Y9Fm1isKdO86oDSn48sPYm+TZKl5oJP
	 jmpUs5HtlOWYazVUC4AsdpzlieHV+Yw8OwiFYam02y2IPy46z0E3qbZsbviAKdApJ9DSB
	 jqKIKhSOkseVUUTJWRZzaYAoGe7W+3zRvtn2/9oCNNHCEVLfKvFOVU0GFsZixqi+2hvxS
	 fYpjLtBaVBBjvA1cYfrmfw4faRnw+iQ0fCCZsoX/lf3j5heYlV63u1QyMlwhHXweI5pNZ
	 qTbB4ZUhIK50qEX3AisGcLV9Megojch7pAkAAzpwawTYO7gni2eTR4R2PeYFBHDC9uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521390;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8gsRbuJEJwCTcibbrdQQs2WldoOZg99Pqbz3RTzOTVo=;
	b=v49H6HHsWFpBYtwkcz1trLnbUbVGSr9KrZ+zSMqqxir/EfpN53QbaMyl4OCT4RhPP5va
	 QMAXjJcgd7syfeyPqXvCksCfEHd07DZoxwZirmyVmRNZcLsm3dNFI4aNAWCTwccgQrMDs
	 SEkiwAdkRPqcLNNaSnzr97nJ0plEi61u3QjDEmiVyJJ8tjv8TstD3cQ++2IfXkO929T/F
	 xnhInB160dblk2d5g1dBceA+p/5gFpQziNxR7I2zxWBxzZ6nhZUouHkdESYOXi+wDnSr0
	 mV08Azcj04rxWsheyBvdYkBNSSUvreRXskbXayphh8aiMy746Nnl48uwcNKjF+srZzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvnwKqpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E143606A31C;
	Thu, 12 Nov 2026 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvnwKqpc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365FB1F000C7;
	Thu, 12 Nov 2026 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521390;
	bh=8gsRbuJEJwCTcibbrdQQs2WldoOZg99Pqbz3RTzOTVo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FvnwKqpcKcEmQoEVSAantOP8U3nowBSKBswXy/Vr/QSEPlk1X0ZZdZLar0FQ88wsw
	 KDlF+Bz5dPMWSERxJ1zqJ10doktkm+0dbYjflp67dUutw1XEHjbllq+cSkwDBm6sEM
	 0f9kE/pM1lhAY7MHRP57/G2xZA1ZMLn7vR3Q1Fy7j/f94jocRIuv8SzIKm+kDNAVIH
	 W2AbY9cNRdpRMxwKO9wfnL7LPiHd0Lfnf+zzrN21K7bD4jjn3mVXuzvlDeqWRAuPf+
	 rSrIP3Wf/U16flzgKesDUi9UCP67ABHRto7bKZsh6V5Nav+ALWhllSRvdH23vWJ9fK
	 //489VV0Jz70w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:09:01 +0100
Subject: [PATCH 5/5] mm: check permissions and bounds for vm_ops->access
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-access_shite-v1-5-988a5c470db2@kernel.org>
References: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
In-Reply-To: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Willy Tarreau <w@1wt.eu>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 Shrikanth Hegde <sshegde@linux.ibm.com>, Rik van Riel <riel@redhat.com>, 
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>, 
 stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3284; i=david@kernel.org;
 h=from:subject:message-id; bh=rMQFgIk3QDIpBHKVD0wAYIXGnRD6cxdJbOe6QfU1m24=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfyXWNI/bfusvAaWxGWvQhmcd6d/KfNWsdG4HKLxR
 53BMNy5o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkoaTD8z+FZYK9gU7Xpzhff
 ncV3j5ZUmdun3LVefrx8vvRLHoYgFYbf7JOuhR7dwn5p26sZIjbvf4QH6rQu3+/Df+hmeXU32/4
 iZgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

GUP rejects VM_IO and VM_PFNMAP mappings early. __access_remote_vm() then
falls back to vm_ops->access without checking VMA permissions and without
limiting the request to the VMA size.

Consequently, /proc/<pid>/mem can bypass protections even without
FOLL_FORCE, or cross into another mapping without checking its
permissions.

Check VMA permissions before calling ->access and limit each request to
the current VMA. Implement similar access permission checks as GUP,
however:
 (1) Reject writes to CoW mappings because the callbacks access backing
     memory directly and cannot handle CoW.
 (2) Allow forced writes to non-CoW mappings with VM_MAYWRITE.

This intentionally breaks forced writes through legacy amdgpu PROT_NONE,
MAP_PRIVATE debugger mappings. The workaround in commit fa5239f2af98
("drm/amdgpu: workaround failed COW checks for Thunk VMAs") cleared
VM_MAYWRITE to avoid CoW, but debugger writes still succeeded by
exploiting the missing access-permission checks fixed here. Reads remain
supported. Userspace must use MAP_SHARED instead; ROCm 5.5.0, released
in May 2023, already does so.

Link: https://github.com/ROCm/ROCT-Thunk-Interface/commit/fea44fab6e84eda52fcf6b419b35600c18f4c022
Fixes: 272ddc8b3735 ("proc: don't use FOLL_FORCE for reading cmdline and environment")
Cc: stable@vger.kernel.org
Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Simona Vetter <simona@ffwll.ch>
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index d4370c1b331c9..9872f289c1e49 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7362,6 +7362,7 @@ EXPORT_SYMBOL_GPL(generic_access_phys);
 static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			      void *buf, int len, unsigned int gup_flags)
 {
+	const bool force = gup_flags & FOLL_FORCE;
 	void *old_buf = buf;
 	int write = gup_flags & FOLL_WRITE;
 
@@ -7401,15 +7402,35 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (gup_flags & FOLL_ANON)
 				break;
 
+			if (write) {
+				if (!vma_test(vma, VMA_MAYWRITE_BIT))
+					break;
+				if (!vma_test(vma, VMA_WRITE_BIT) && !force)
+					break;
+				/*
+				 * In contrast to GUP, we historically allowed
+				 * FOLL_FORCE write access to non-CoW mappings.
+				 * However, we must always reject CoW mappings
+				 * as we cannot CoW here.
+				 */
+				if (vma_is_cow_mapping(vma))
+					break;
+			} else if (!vma_test(vma, VMA_READ_BIT)) {
+				if (!force || !vma_test(vma, VMA_MAYREAD_BIT))
+					break;
+			}
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
 			bytes = 0;
 #ifdef CONFIG_HAVE_IOREMAP_PROT
-			if (vma->vm_ops && vma->vm_ops->access)
+			if (vma->vm_ops && vma->vm_ops->access) {
+				bytes = min_t(unsigned long, len, vma->vm_end - addr);
 				bytes = vma->vm_ops->access(vma, addr, buf,
-							    len, write);
+							    bytes, write);
+			}
 #endif
 			if (bytes <= 0)
 				break;

-- 
2.43.0

