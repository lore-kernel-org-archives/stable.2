Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763282;
	b=nZP2RQjZyVRDiGb0mm3r8yaSjm016V8VGF8YM+7dKd45494NdgP47ENl+bqRmJqtBXw4
	 WiBKJzkhU/81QvQ9IqyLnmXN+kcLO8YWcS7j+baHHLLQBOxc3EXwsYl3xC0foGSDE0p2a
	 5fK5LHweuW0sLBL6bVNgb8EfQsZFejk42MTMmM0ffR2jL2GY5EAzm0Anz4mClp/Tpckjs
	 zP/U4CXU6ai1ZJTcNuNPLU4r+AL3GLH6+op6zsHsz3GUSrxPSZKCZQdbLcKqyY1jMwNq7
	 MMjxI5jL3HM708+L3JBA5bu1gar++cyjhCblrRz+AEjMv7r3YiCc3u4+4pE1yjdOLxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763282;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=DjY0J1rY8s6eI0pi00146/qxLG5XIFRaa8H6rSeRSdI=;
	b=pOiq2YJ8ESB/dC3jVMw8gLPnAJMUFZellSxVPEhTipF/eitiEhFCGpj0Hqb2XKfR63pd
	 uq494Tc1IuwabK3D2K44Yj3oq3VzL1tFNgaB6/X32LJwPxIzQ/Ou2UDq0lgDEFRA1tlKR
	 tVtSgSGWxYVa78Pls+Fb6ICVFW+KJtl74LRSIC+8YrQSpdenyrW3QT0MlsjvsxU/bULAk
	 jg7OFL1f3oByhcCFXmDFg/RnUDwMHZZES696sgrkcU1S/fF/J8uSjHttQeCGhSlwsTNL+
	 ZhWO87vbdzqKBeGUJz6MyhkOB4bs5zd9WenaxgEGQ4MwFyVw0I7KKAPNrkF40DyOa1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfqKVI6g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20733606A32C;
	Fri, 23 Oct 2026 13:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dfqKVI6g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E311F031E1;
	Fri, 23 Oct 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792763281;
	bh=DjY0J1rY8s6eI0pi00146/qxLG5XIFRaa8H6rSeRSdI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dfqKVI6giPzt5zbodp+Y1rpDLUD/m3efycWZdeUMPGiIL7r5+EnNhAsnZJ5ftfgo7
	 Cien+WUpFTsX+Uvqev3Z7aqzdnx1iXRYPHn5ZfYwDzI1SY0IBLtpUV1LGL20y7e+fp
	 7vtGVZh5y+n9V4m6Vfy2RbW/ErwbMmvcFmOCEQa8ItSKJBZREYjLj9Be23Oq67oaJx
	 NH/Y4GI346SxjhQckJ18s/BSiXQVHtFP/TXTtZp1HiIgNcoHz4e2L+0AJHiFBAIAob
	 F9QyxgcB91Bw7/EQ3JJ6GD9ijywRpjS+93OHzjDqXBw4AgE7d6Y7JcY8iEJxP66SaP
	 LaSiL8GJz7WLw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 14:47:28 +0100
Subject: [PATCH 2/4] mm/vma: write lock source VMA before duplicating it in
 __split_vma()
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
Message-Id: <20261023-fix-vma-atomic-v1-2-8ff4fae1fc85@kernel.org>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
In-Reply-To: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2019; i=ljs@kernel.org;
 h=from:subject:message-id; bh=pBDKonRJs5TA7YWHg4RHbXCo1gcPUiIEkJW4rM9Bgss=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJup7ZwnTcrklmpLv+v7b5ZTk5rgu3W38Kusn8WXX+/P
 +DA96yYjlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEzk52GGvwI27BPt4hz1fVt+
 GIvef1ex+25XdOuMn8UV36YvjTrWIM7I8NIhpL7vNP/EEvbTHnKC/83mnWg2v2t7j23qWYOY0zu
 XcAAA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: "David Hildenbrand (Arm)" <david@kernel.org>

__split_vma() duplicates the source VMA before taking its VMA write lock,
and until the VMA is write-locked, a concurrent thread might set
VMA_MAYBE_GUARD_BIT, resulting in the duplication missing the flag.

If this happens, then fork may fail to duplicate guard markers and, if a
file-backed mapping, THP collapse may also discard the markers.

Resolve this by taking the VMA write lock before vm_area_dup() and, since
all callers of vm_area_dup() now hold the VMA write lock, assert that this
is the case there, and add a comment to explain why it's needed.

Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ ljs - add VMA write assert in vm_area_dup(), commit message touchup ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c      | 2 +-
 mm/vma_init.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 1be613044b4a..aa59005e2f42 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -538,6 +538,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			return err;
 	}
 
+	vma_start_write(vma);
 	new = vm_area_dup(vma);
 	if (!new)
 		return -ENOMEM;
@@ -568,7 +569,6 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
 
-	vma_start_write(vma);
 	vma_start_write(new);
 
 	init_vma_prep(&vp, vma);
diff --git a/mm/vma_init.c b/mm/vma_init.c
index baa7e82f47e3..d661f229a734 100644
--- a/mm/vma_init.c
+++ b/mm/vma_init.c
@@ -127,6 +127,9 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
 {
 	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
 
+	/* Must hold a write lock to stabilise atomic VMA flags. */
+	vma_assert_write_locked(orig);
+
 	if (!new)
 		return NULL;
 

-- 
2.56.0

