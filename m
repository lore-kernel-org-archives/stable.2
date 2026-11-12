Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521351;
	b=hdukmzJzIJe9kc39RHTPSyYgb/t5Jlfle6LJsiEUsEeVeNPIla5Jf/Fv0RRkMi8YwMwu
	 Adjs7vfRBOrxD8VZr/YC5pkoTiPwnKxc1Ps0lqsSYXygCiSslX7ys54fGgL7b8isPp3DX
	 JC9ghtDCZkZgSo8/SxGlgKX9ZtlQHuHd0XTHmHSRXXD9BkTtF0nbTipA1mPS5B/LEfJTI
	 AEIPDrE4KCuJoVNSOyQivph2z1IvwuEzAhOcG/9NBoWZ1oUi++BNNtYf8Yo0kZ9XgvC6O
	 2TiUGHGnAmE/un0Slt7U3qbkyPXzykGeF0YK6jt4uVRSPBOX12VwjlIcUJIhFESwnCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521351;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=YdaqQU5UQrIE7jz+L18q1ofvhwJPYfk/YgBxfo4uzJ8=;
	b=B6gjNM62eIK3GvEwyBZonuJJkVx5EyyiBWh+rc//MYnzbV1QPagNX727y0TSdb1Z0HOf
	 /Dims9X9Vu3xUQ+pKVqsQDx3yd+qVjT7eWknwEAEpxjt3t/J0iAzdg7TUFbcpcUoo/5YD
	 16dfZof/KVu/uFVfGPFqTMT/QLXzMZJ+8QlGbN6Bq0jZvvo7dKoL+cXGiNFhBq71ZtMeG
	 cVXDDEKfgTbLc7e9bWpFRvZsQoP9YLus9mqfrn+Xyy+Mj38HAPaf0rZAQRN/fDQtFLzjd
	 lKr/xfOeoyb4rt60zP6axOU9oGIeDILMVYunzesM0rNuDx148KfH1aj4Co/B1QD7jXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UtSf8AS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E51606A31C;
	Thu, 12 Nov 2026 22:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UtSf8AS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94D01F000C4;
	Thu, 12 Nov 2026 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794521351;
	bh=YdaqQU5UQrIE7jz+L18q1ofvhwJPYfk/YgBxfo4uzJ8=;
	h=From:Subject:Date:To:Cc;
	b=UtSf8AS/2vkBzFQsYMRwuG1chkyE3t6cf92PIU1mH6Zccmm+N7wlrDPMvoqYVIzeg
	 JaLGGZUy2+KPrln/QsrIgnjuKFaGDX8Ul4e5+R6J9wuhUlJxYqeuFzFJkhawftra1r
	 7SRhv9cNjIbSPkFZlJNY1RkXOEYclnV9rxg6sieR55Lx5ecY0vkYsZqBeGZ/uxLJlF
	 Qrc4sbjJPGk5oW5iS/G1qEymWrpXDPeK65SVHwwPX1ALJNiO4mLgB9nfDeBE6PPOAh
	 LYb0r3Ey8u0d2JvuAPbuxNQZd5+VkItHekuWndG07g9VEf+lahJlbpgVYIRfUGeslY
	 O2MPZl+vhSR0w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/5] mm,drm/i915,powerpc/spufs: vm_ops->access related
 fixes
Date: Thu, 12 Nov 2026 23:08:56 +0100
Message-Id: <20261112-access_shite-v1-0-988a5c470db2@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAPg49moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Mj3cTk5NTi4vjijMySVN0Ui0QTc1NTS1Nzo1QloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAywJpcnAAAAA=
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
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1463; i=david@kernel.org;
 h=from:subject:message-id; bh=WdwVU4D50DJi588gxgEao7aVctqzLO6VANAj2lIv6bs=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+Wfx957ddpWa78tHiMrVrJ99FeK1a/GtDtFr8v2eVG
 8tPF86K7ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiGw8x/JU5HnSJ1W7u5NdB
 n0Tf3ezdkWO74I2I2MJ5z7NfhK+8ermJ4b+bh3bR4pbPQQmrj9+Vd5eZuOcZt0PR6/sme6cfFHx
 xYxU/AA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

While working on vm_ops->access related fixes in core code for FOLL_ANON
and VMA access permission + size handling, I stumbled over two driver
issues. Also, I have to update one selftest that specifies PROT_WRITE
but actually wants read-access.

Fixing it all in this series, because it's all intertwined.

In patch #5 we break a debugging use case for older ROCm versions, where
the amdgpu driver hacked around it by exploiting broken access checks in
core-mm.

Tested as good as I can with selftests. I cannot really test the
i915 and powerpc/spufs stuff on real hardware.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
Chris Mason (1):
      mm: do not call vm_ops->access with FOLL_ANON

David Hildenbrand (Arm) (4):
      drm/i915: consider vm_pgoff in vm_access()
      drm/i915/selftests: request read access for mmap access tests
      powerpc/spufs: consider vm_pgoff in spufs_mem_mmap_access()
      mm: check permissions and bounds for vm_ops->access

 arch/powerpc/platforms/cell/spufs/file.c           |  3 ++-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  4 +++-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |  3 ++-
 mm/memory.c                                        | 28 ++++++++++++++++++++--
 4 files changed, 33 insertions(+), 5 deletions(-)

---

base-commit: cc06c90c164a389d51444a7df5056a8460d26d5b

change-id: 20261112-access_shite-d8a47559572e

--

Cheers,

David

