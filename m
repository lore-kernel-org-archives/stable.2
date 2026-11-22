Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370131;
	b=f1mhZxJGlHFKh64Xx4ONzmEQjPxkxMZv88+JxJneg4/McD3jkGXcZf3RlYcWiBj5QK4g
	 CMcYyz1OLuN13HtE8mv7s5fV82hUIMHnMaQI/M4AuN9ualgE2hmT8xd6qxn2Gc2zeLfWX
	 eS1wZI03fqtxabEg2gXJe/hMBQayn/MVrJFu0JLRqxeVNXeVp6dGo9jBgeGlYc+DKvWCz
	 a0yPGpqqsydFC5PIx/bcbVmbOX7uWUVeQ1NTPoI63XoS21OEEQ3f4r1z4oUyD21boZ/Lu
	 C+HcqT/v/sj+jF4omk5uj/oyDxgE6YGNNDbS6CLVXcN+tOwTwZb8W4p7jw9KkqimeGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370131;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=h/5Vl306LS0GA0rcZKJVnl2ctvPVB3+FArNa0w73Yro=;
	b=TZzQjTEqSouL4tFKBtJmD3g7IvY6ICiOLbgBfQ13i2jdh3BbDApgPntxP05cfcfAH0IR
	 Q+1pDEO8gocJZoqCk+P+j/6kv/SJUQmpe9IfL2EqjEWZfLuO9JcSNtx18HUjEtqKZ4Am4
	 LYnhnQXUcVXuxeRaRd7ucRspbKEFo/l1jDVshpmM7nOVT6UBz6K4o28kSOsQNZ9OoS9xk
	 5uO+8JWh0yXQs5prYDzVHnvvpp626+Hc9WFkTLw+ZyApn5biCoNCCgPUlaQiYxzzpFNzZ
	 cIp6FIyGMybHO+cJ8imnTPG40Jr1etH9euSceneUw7u3xA9r46YNAtojF6+iOF1zbSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxKByMB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E59606A320;
	Sun, 22 Nov 2026 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=duxKByMB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB00D1F000C0;
	Sun, 22 Nov 2026 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370130;
	bh=h/5Vl306LS0GA0rcZKJVnl2ctvPVB3+FArNa0w73Yro=;
	h=From:Subject:Date:To:Cc;
	b=duxKByMBP2+mJiLV3lYRrKPgtiowdBAgsPJIOTGZnzS3p58QFIkq1X5nGMYdJsfNM
	 evxhcz1FhYwz1khpDyo/kjMElsksWA2DAYZQuW8yjfOdJAxaqT0kTk/dgJJ3L1YxVs
	 b6bYv0n/0CSza4S099LFxlPG+mjLC99FtaqxP3vqrBOe/KvmCEPggXwrzwtj46PdmL
	 zH6u2jCXro9fXxatJHgHkzEGA/pN1yUrjpGfmhjk4zzw2xpr1FXG85n8DZwRqVtmMo
	 V+B3/ylL49xlmJ3nEPH164nYwknJC3q/uMxMWHQy9Ay2j4bmQ9J6Pw8r1EqMWgOcjr
	 75F1hXUdF5+Pg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH v2 0/4] mm,drm/i915,powerpc/spufs: vm_ops->access related
 fixes
Date: Sun, 22 Nov 2026 18:55:17 +0100
Message-Id: <20261122-access_shite-v2-0-808d8d2aa700@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/3XNQQ6CMBCF4as0s6aGNtSWrryHIaaUEUZNMR0kG
 sLdDbh2+ZI/31uAMRMyeLFAxpmYxgRe6EJAHELqUVIHXoAu9VEppWWIEZkvPNCEsnOhssbUxmq
 EQsAz45XeO3dufptf7Q3jtBlbMRBPY/7sf7Pauj/0rGQpa+eCiZUtu1af7pgTPg5j7qFZ1/ULK
 L5wnLsAAAA=
X-Change-ID: 20261112-access_shite-d8a47559572e
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1784; i=david@kernel.org;
 h=from:subject:message-id; bh=uurjwnOfWQkMhoYI4DMjJoIthu1xPIvQvDdbePa+8Rc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKZdTqylvaopj9aMl99cWW602yfrivn5ySohf55fPZ2/
 JqtOX7rO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIaSvDXynr1g/nX69XZbd6
 ZcFsH2J4UpZD8tdum/4+6S3KwvFF1xkZbodO7b9SyfMl4R/TSwnD7cnx3999jJ+ippmflWjJ++8
 BIwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

While working on vm_ops->access related fixes in core code for FOLL_ANON
and VMA access permission + size handling, I stumbled over two driver
issues.

Fixing it all in this series, because it's all intertwined. Only allow
FOLL_FORCE to bypass VMA permissions, similar to what GUP does for other
VMAs.

In patch #4 we break a debugging use case for older ROCm versions, and
forced writes to mappings of read-only files (e.g., DMA-bufs). Current
ROCm no longer relies on it, but old setups (e.g., MI100 with old
userspace) might break when updating the kernel.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Changes in v2:
- Drop "drm/i915/selftests: request read access for mmap access tests"
- "mm: check permissions and bounds for vm_ops->access"
 - Allow reads of write-only mappings, as we historically did
 - Combine the permission check comments into one
 - Mention breaking forced writes to read-only files
 - Extend patch description
- Pick up tags
- Link to v1: https://patch.msgid.link/20261112-access_shite-v1-0-988a5c470db2@kernel.org

---
Chris Mason (1):
      mm: do not call vm_ops->access with FOLL_ANON

David Hildenbrand (Arm) (3):
      drm/i915: consider vm_pgoff in vm_access()
      powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      mm: check permissions and bounds for vm_ops->access

 arch/powerpc/platforms/cell/spufs/file.c |  3 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c |  4 +++-
 mm/memory.c                              | 29 +++++++++++++++++++++++++++--
 3 files changed, 32 insertions(+), 4 deletions(-)
---
base-commit: 76d96c9641d0c1c0d0e92013a30bd887f8d2dbfe
change-id: 20261112-access_shite-d8a47559572e

Best regards,
--  
David Hildenbrand (Arm) <david@kernel.org>

