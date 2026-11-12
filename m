Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521367;
	b=Vz6JRIvkGvMrb4YugKs8L3KeW6KRkR0B+wKA2/shYhDDBqORzy7YDWirAFUfgluecMB+
	 epcq6Fwej1wlxaVnn0vouYiTlv7aMg4lfXycacuZ/OZcVhcK3Hw0lCwA6N3pGJBIE7SOl
	 hpjcNAx9xgxDJi3odlLz77zD+uanjrMoojLs5iO5E7CRIeOgxhwbjxU9DpFaEh9W+erzi
	 T7LN21AFPpetKHkn1x52JPvbD4Ztk88DPMRBDKyM2pdXPiFclVmvw683PEmW83pp/VKI2
	 NYQeuP+upVzX07E4Kx/MdpaF9uzGHUaxFMnlELwk77tZj+hrDQ740fkvdMpLmUpampQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521367;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=930N6QEOjUHirsduFLhsvXWNKJmMCsCwncwdA/i9tec=;
	b=Tc34Fk61t7MO66jyr0VPsbuKwARd7xuMgAehbTGO+JJ0TZUtGgi43yWTeqJLv2NlDxJN
	 38YQU4oCgVJsrWbswKXm1OOlMzGID+6K3+LlyIG4aC9rV1vHXFb+GvxEvHSXIucS5YYrb
	 FLzbdEUZsnIsBRNXa946US5YotSeBEVSReihk3+eKWmGWXkGJw8aejywYeGb3Cu2HF1Rm
	 ed49CTQ8Yez6PWsRt9yLoX76eU6raYHRRVxBa4jIhixbYA8UPt8FZfb1DiRKVI/hfu1bo
	 0y8JcQMBW9eDjl2uGDzBwqJ57IlZt/EX+38l1AIB1dkoNKHtps40mDZ1f7ich5xL6fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLhRjYTp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D67606A8A2;
	Thu, 12 Nov 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PLhRjYTp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BE11F000C4;
	Thu, 12 Nov 2026 22:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521366;
	bh=930N6QEOjUHirsduFLhsvXWNKJmMCsCwncwdA/i9tec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PLhRjYTpuVCEwDtQeQbEtcsKdTDD4Sr++WJShgqRPkO8U08CqZ+HAAAC1BKtceEex
	 +ShABf3NSFxi4EA6/i9nO14MOuL3QYZK4jNWj4pB4ivxpkNeAIEdvLVkUSiVC22SRS
	 HAPkNG60I9FMyz6ojt1gqm35PE5pYqb8siXMDA0df7NnSUIA4ZusDSdoAwhqNcyatw
	 KOakc8sMlWUc40XT7CnNd4OzM8pVL7XSfTE6f+BgfiH7WZ9S195dJ35iHDfRiD5oiM
	 MztehWcbZk5EMfmofYeuH1mGMoGM1KD+V45D9dNOEXxNIqLZyVKGmwpaahIp+Lf2x8
	 7/EMJQgtaFlNA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 12 Nov 2026 23:08:58 +0100
Subject: [PATCH 2/5] drm/i915: consider vm_pgoff in vm_access()
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
Message-Id: <20261112-access_shite-v1-2-988a5c470db2@kernel.org>
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
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1430; i=david@kernel.org;
 h=from:subject:message-id; bh=732UbEwrVg9H6cBI5IEtEOpt8rsKtwsfjrtc/ksVv/s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+WfwzFui7teDAdzGvmXXhs2YtOLerfuOEw82X/n+3K
 FgXz3xZv6OUhUGMg0FWTJElKPi+wcuX62qr3fiYYeawMoEMYeDiFICJTDRl+MO/pni27aQmQ5eM
 pjlcVpMMTh34tWiC9fsE8y17/pglmGQxMtzhnMYyW1mtOJO778z5SumEjPXhzB949iW6cz/dLxn
 zggMA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

vm_access() treats the start of every VMA as the beginning of the GEM
object. After a VMA split, vm_pgoff identifies a later part of the
object. Debugger reads and writes through ptrace or /proc/<pid>/mem then
access the wrong bytes.

Properly consider vm_pgoff just like the fault handlers already do.

Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 6b337684dbfe8..e3b24dc8e94f5 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -511,13 +511,15 @@ vm_access(struct vm_area_struct *area, unsigned long addr,
 	struct i915_mmap_offset *mmo = area->vm_private_data;
 	struct drm_i915_gem_object *obj = mmo->obj;
 	struct i915_gem_ww_ctx ww;
+	unsigned long obj_offset;
 	void *vaddr;
 	int err = 0;
 
 	if (i915_gem_object_is_readonly(obj) && write)
 		return -EACCES;
 
-	addr -= area->vm_start;
+	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
+	addr += (obj_offset << PAGE_SHIFT) - area->vm_start;
 	if (range_overflows_t(u64, addr, len, obj->base.size))
 		return -EINVAL;
 

-- 
2.43.0

