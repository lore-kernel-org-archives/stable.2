Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370149;
	b=pBBBpc6GkUzGfV9Rvoz6f5RNaP1ZEvL70p/JONLn9R/P00KxemXNZ/dsFwqBLjM8vDf+
	 Q2pzpGE8UAKdIYaYcHkHWERDA546qy9ZIIIkfBFd3Tculck09LWrR98VfZlOAYIzH3VZu
	 ybTH9wm+cKN29HNZlIE3HuxQlu6kwbtIXX0uZ8iOJaoUeP1atYIxxwTKadshjVAX2NGJT
	 9gE3HBPqHgin1ya+udHRVbTENJ7aLrvR2LD/Qh/AC1k+FCpp/Vps8OUtYUsdPDIuWtfG6
	 8hsjvgji+qPE/SNBfK9EY2CHiJ7eMLHY9wxZqrwuOrZoQsbGzWSI2B0qZAu29Z9D4SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370149;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=N3xhcXsSlvYSSdBGEbF5oEiGoX8YAfT6Qkf5pEHEi5Y=;
	b=QyPqMx5LTdbCvYszT0S8M8Q+FfhgIPYD87vcZnpseXqmILIsr0yqqD7eZCadVxzKcd/c
	 E7mqdGCEI9uT3Cp6a/gHwbVXMi3sKaNxO5Wznq8dOR+Epk7QiURCTWoJ+QIkfJHPjZCvq
	 YdHIxpeDiIUxUSZKIWba/Y0K6/eyKhZnGMDUZbAfMIlbDOOy/Dd0KuIz/L1r/KZk556hd
	 VUct0PuKDqv2zszOtfGHgIGh0bKQMyLOU1U4hm+XMTUSQty25rkQxaCIxcugKgT0lThEn
	 Njl16DbObmqlKA8bAa2zq4LzPXOWqjP1IsJverK3vZFtKNhKWLOLMn7FmtlOET7PuHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70M07Wi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5358F606A32A;
	Sun, 22 Nov 2026 17:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E70M07Wi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EADEB1F000E0;
	Sun, 22 Nov 2026 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370148;
	bh=N3xhcXsSlvYSSdBGEbF5oEiGoX8YAfT6Qkf5pEHEi5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=E70M07WizowpCEjLIq8EGjssWfPz6RUqSLvLQ+xGLzrxDS3gylM+UH5yHjZHVFNmJ
	 VJHhy6enxQtOEZktlriYonxPaLLMky4Erj7SqufwBWKhUmk5XNixHuTx5K2FIsPLID
	 h/J9G5EN+9SKgTEtUoQ7HI2tfGmpwEI6VUvFudX0LFcNOXoS60WTR4nlUad9HPZVDg
	 ON7Uu2mgM9pvW+MfW46A7KTeEHCyqxJGE6beJEhEEladV6jPwuyfUUHeVWAPjXd7Bl
	 pHJNJChJ9nv9ev1pTrlLvXsFFRJZddluCoYLt76x3KZladhKWxmCZbdS9ZtoK23QPJ
	 I/F1jerZy5NMA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:19 +0100
Subject: [PATCH v2 2/4] drm/i915: consider vm_pgoff in vm_access()
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
Message-Id: <20261122-access_shite-v2-2-808d8d2aa700@kernel.org>
References: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
In-Reply-To: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1480; i=david@kernel.org;
 h=from:subject:message-id; bh=Z2XxG3ai9Ng99bmlt2CXgZf4H+3uo30xMSG9M6dIcuk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTritSS8jXWYJzwLms64t+6nzN4Ik9q9a55Wm533O
 825ncW+o5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIkE8jAyfPw6Uf5P+zZnV6ng
 +Ah5mzqdqbU9Wru2Hjj5MtBl1fNzyxgZOqeKHfmkpGDtfEt/XexU9o2vfmUXOJ8tYDKv71jiUij
 CBwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

vm_access() treats the start of every VMA as the beginning of the GEM
object. After a VMA split, vm_pgoff identifies a later part of the
object. Debugger reads and writes through ptrace or /proc/<pid>/mem then
access the wrong bytes.

Properly consider vm_pgoff just like the fault handlers already do.

Fixes: 9f909e215fea ("drm/i915: Implement vm_ops->access for gdb access into mmaps")
Cc: stable@vger.kernel.org
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
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
2.56.1

