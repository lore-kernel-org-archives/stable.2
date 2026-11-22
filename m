Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370140;
	b=ZII2MM44Nuet+It6JGrfMn5IaCCHoDy9ndELxwrPZmfVg16BI3ikGY6dnmRttldMjjCE
	 WhekwMMdCPV9dzJk30q+wNbaW2q9B1s5eDr7/qOn/qjQpprGC0rNgou6nOPTbRHwtk6Y3
	 wWSo25uKvnWfF7hULerXAy5kht3C/UgUqsY7uPJgeFSrRc/G201Gg6w9nVUcF7RVS83E9
	 Aj9mHO38SRfvXiqD8jWuolHZmqatPvRTwTgD5Uu9qQX9k2We3wehcf9howM/TZHA4m6Sz
	 jbkgGACy19g0s6WFu2ZA8O3zgW3cTTyRbUNycUCuBOgWx2yOgx51gAaJ917kM7JDJ7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370140;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=UAlvlm6XIkjF3CVGuekihGQ4derGbHtU5YfuFOl41qQ=;
	b=z1Jx5UDZbuTgf9p3xtFGP60pKk19B6OYnhMdeGIxal3KhuPLvi4YFnSqWAddDT7eZE0z
	 oimoXt6b8YyoA0fI/Sv6SJDWJiwUx3S02HhZqMMsSeROjcat294+2BdZPKXyK9g34ePd1
	 NXzxSHjEf/O3amUhVSyi9quw9y0IoRECyi+vd3Up21tQ9SEzmYfoxYkGFLvtK55teJBre
	 mBmK3dSMOs+fi1GNd9DeNyn4lvc6whBOffheWEPx/3AYKoaX+hkom97+/EA9LISbIIsqL
	 A9oht+9mI5Gq8pIqEKVaroVkSQlkBjkSdDCktvphfOrtZCyeS/UzHOgbSoce0QCi4wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnQSCvxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63315606A320;
	Sun, 22 Nov 2026 17:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnQSCvxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0B71F000CA;
	Sun, 22 Nov 2026 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370139;
	bh=UAlvlm6XIkjF3CVGuekihGQ4derGbHtU5YfuFOl41qQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fnQSCvxHNo6ERlskR5pyD0RirUHJHoMwYscn8zEwfhOm9qyM/LS5q0it778nXObyH
	 SFAoOYjlOjFY5vXKOdLIVVvhXhoGFLbxI9dKLWclz9Y+vELX6BSItyyKQCjZEhh73b
	 10FztGFeJtlA7TjtRykt5PquRo8ffQfsvW8vgg5YPWh1gTjYgtRk/9zBWoMaOYQyYK
	 +EWwSmhu5H9+l5Ov8IJ+BxLNt/hV2vqgTdn9JMlKNSM85QVslyyH4cAPWwT/+J4LZO
	 8VjJz3ZemsMNeHxwk3c/4OJET3WCmIek09eFjsE5DOZpRMzhb6ZRllFEB3+qtHYI5V
	 pz0ICmqsjK+7A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sun, 22 Nov 2026 18:55:18 +0100
Subject: [PATCH v2 1/4] mm: do not call vm_ops->access with FOLL_ANON
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
Message-Id: <20261122-access_shite-v2-1-808d8d2aa700@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=david@kernel.org;
 h=from:subject:message-id; bh=lBTEaJm0bEVMUkiJfmMuzjRSMI6nwi0rCciXc1cDdUU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdToqLJWbiudm15yqnu0Qrr+968s6pakJN3untk3iS
 p1okT6to5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIn4hDP8FTc+nBUYp1uw+alk
 Y2JYAP/y+/9uzzzC9WG/Zv2nxLKg4wz/65dyaF1cE7M41Uy+dOqfLXMCLrAu2vmRMTRvgXD485Z
 0TgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

Reading /proc/<pid>/cmdline or /proc/<pid>/environ can block in a device
driver, or read device memory, if the virtual addresses point at a device
mapping.

Ever since commit 7f7ccc2ccc2e ("proc: do not access cmdline nor environ
from file-backed areas") we use FOLL_ANON to only read from anonymous
memory. While GUP properly handles FOLL_ANON, __access_remote_vm()
will fall back on GUP errors to vma->vm_ops->access() without similarly
considering the flag.

Fix it by not calling vm_ops->access if FOLL_ANON was specified, to
truly limit it to anonymous memory only.

Fixes: 7f7ccc2ccc2e ("proc: do not access cmdline nor environ from file-backed areas")
Signed-off-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org
[ david: simplify description; slightly rework implementation ]
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 6a23198c1c67f..5d0d58aeff3cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -7448,6 +7448,9 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 				continue;
 			}
 
+			if (gup_flags & FOLL_ANON)
+				break;
+
 			/*
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.

-- 
2.56.1

