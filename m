Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE8D330B0B;
	Thu,  6 Aug 2026 05:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785994676; cv=none; b=LmI3mpNDCjq0C1n9PBLO+GSuaZnNLEV71RiNvnjRSgfCQf2UT5yt6BgWDxLfJ9ElH/ZAPUY1SKLTtd+AnZ7JSPCLfqug4es9eKVwvdDIJvTrUbHSgS/VelTzUdCnCN7ye1OSyRQKlMDr0Yb9ZVPF3iIBVLTi7+P5JFRgrlPSljE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785994676; c=relaxed/simple;
	bh=VDuCB5XNDhi7jcDu37DsQ//ihVipCo1vTOb8lc7wTIU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hJTurwtlOsg/80ZA6UQf+GQTjJIRb/ObeBmhmBJd3NPxoA0Fi8K4FO2iKnzQdyWYWp6Qn3yHFUt/WZdX0Z6Nfhl6C/GHt/3KYYswYfQmPlxFbT5geUfP8NBfG4xxmQMJau4TwV53MjSV4cY6t9mmEy3HfO4h9+L6apE2zwBAkZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PR7aSNsl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PR7aSNsl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A521F000E9;
	Thu,  6 Aug 2026 05:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785994674;
	bh=2MLbXsduJEAILuzhNfI62PQO7YBQ2k1YhAQHL9snXWs=;
	h=From:Subject:Date:To:Cc;
	b=PR7aSNslmo6nqBUf9z+O67zC0AC0EWNlTATHtsZtWWKJ/kUPN/Ljv3gB6Gp1JIxsc
	 3y3UMScND3Tv4jYKfE/SNAJ4zZrSJiFqssI6yTSjn2ifWLZ8Dz5SEWFOzffVkKwkzx
	 TR1C7Eka/9EDOJfWP849T195eFiHKAWsNvwhQEU5x8Ay3MODZlXqSGLkyxTNiztwDX
	 bJJvwaY1b26Ai17wStHrLzqFkeh6/U0HcCauskihSUQQcdnsPBGsCSp8HKv9ileNQ/
	 Yg21ZdTHOMOCGCDkA+zOwt9BtAJ++MzC2Jq8RVpAUWVpzTjgEIdGkaYr42ucLlcfdf
	 OTZihc1bk3Kjw==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Subject: [PATCH 6.12.y 0/2] mm/slab: fix unbounded recursion in free path
 with memalloc profiling
Date: Thu, 06 Aug 2026 05:37:40 +0000
Message-Id: <20260806-kmalloc-no-objext-for-6-12-y-v1-0-036dfc3273fc@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQrCMAwA0F8ZOZvRBleKvyIe2jXT6GykFdkY+
 3fLju/yNqhchCtcug0K/6SK5gZ76mB8hHxnlNQMZMgZb874eod51hGzosYnL1+ctKBDS7hi5JQ
 8+4ECR2jFp/Aky9FfwfWW+hVu+/4HRIqj+nYAAAA=
X-Change-ID: 20260804-kmalloc-no-objext-for-6-12-y-bedd8e852aeb
To: Suren Baghdasaryan <surenb@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 David Rientjes <rientjes@google.com>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry@kernel.org>, 
 Kees Cook <kees@kernel.org>, Danielle Costantino <dcostantino@meta.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Hao Ge <hao.ge@linux.dev>, 
 Hao Li <hao.li@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 "Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

This is backport of "mm/slab: fix unbounded recursion in free path with
memalloc profiling" series [1] for 6.12.y.

The patch 1 was adjusted for 6.12 as mem_profiling_support is marked
__init in 6.12. I simply resolved this by marking
mem_alloc_profiling_permanently_disabled() __init since in 6.12 we need
it only when creating kmalloc-no-objext-* caches during the boot
process.

Patch 2 has slight functional differences compared to mainline
due to lack of SLAB_ALLOC_* flags, sheaves, and kmalloc_nolock().
I described those subtlties in the backporting notes in detail.

The first two patches from the original patchset [1] are not backported
to 6.12.y as they are no-op in 6.12.y:

 - mm/slab: fix a memory leak due to bootstrapping sheaves twice
 - mm/slab: decouple SLAB_NO_SHEAVES from SLAB_NO_OBJ_EXT

[1] https://lore.kernel.org/all/20260713-kmalloc-no-objext-v3-0-47c7bd138de7@kernel.org

To: Suren Baghdasaryan <surenb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
To: Vlastimil Babka <vbabka@kernel.org>
To: Christoph Lameter <cl@gentwo.org>
To: David Rientjes <rientjes@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
To: Harry Yoo <harry@kernel.org>
To: Kees Cook <kees@kernel.org>
To: Danielle Costantino <dcostantino@meta.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
To: Hao Ge <hao.ge@linux.dev>
To: Hao Li <hao.li@linux.dev>
To: Pedro Falcato <pfalcato@suse.de>,
To: "Liam R . Howlett" <liam@infradead.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org

Signed-off-by: Harry Yoo <harry@kernel.org>
---
Harry Yoo (Oracle) (2):
      lib/alloc_tag: introduce mem_alloc_profiling_permanently_disabled()
      mm/slab: prevent unbounded recursion in free path with new kmalloc type

 include/linux/alloc_tag.h |  3 +++
 include/linux/slab.h      |  8 +++++++-
 lib/alloc_tag.c           |  9 +++++++++
 mm/slab.h                 | 28 ++++++++++++++++++++++++++--
 mm/slab_common.c          | 13 +++++++++++++
 mm/slub.c                 | 34 +++++++++++++++++++++++-----------
 6 files changed, 81 insertions(+), 14 deletions(-)
---
base-commit: 833291ee77846538926c990bcb468f6f54e9af50
change-id: 20260804-kmalloc-no-objext-for-6-12-y-bedd8e852aeb

Best regards,
-- 
Cheers,
Harry / Hyeonggon

