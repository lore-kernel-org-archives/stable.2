Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062C939EF24;
	Mon,  3 Aug 2026 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785741318; cv=none; b=IEVk1k44wVuI9vrTmC0oJm/3+kSOxy0zoLhS8CxiS7gjYXUVOUQFi2r7IUX1l3+3IlC6ieYPU1qPlo6ZJbRZjGgOSZP7tF4HpuZSW6HqC5TBMtQoXfQM8f6K1PxYyzFhG4Im+Lb5aEENLjSKlAZKph8Fz8r3gvWK1GmTy1cXaNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785741318; c=relaxed/simple;
	bh=CSXC3MRl+fr5K535DZhZ1ieZPxaiUMr+iVKFoRwzN5o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gmrBHkz8iLiOlY3xNqdCf+OEhOP2q6fFeKVVrpmE8id7hTXKFt+9HHAXIHFgv8rcjqfS/sPXCp+Zd50vcLv2D9aFEQgRnbGVE14Yu4OU1JKOtqz6B3YO1QF1jG7LnCq/zUM9KAYu4+Et+gyrzMzUi4D6ODQMGGt5Tb+ta1KAGCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpFxADqY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpFxADqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09371F000E9;
	Mon,  3 Aug 2026 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785741316;
	bh=lOw5vekGbjNw6ykDt0fzbiYJA2c7NYGfZyY2lgJKOak=;
	h=From:Subject:Date:To:Cc;
	b=DpFxADqYOi+VHQ+Hrpil882FXtGQulPwbpCRjtbBGElPW+ao4/mQfksudQQLthqF5
	 pkVTVUYOo5vZhYepoOIxvvFHOtkoPHMo/dz57XR7S4sxJlyoo9A+w2q3TJou3wKf9U
	 /AQhkfpmmahTv41Cm0E5We5ZQiFqkL1bhX55rKzwMVJrb+NUrLf59e51n0xMXGD/Hz
	 xDMCGpqeCUp0V6KrAcV6FiqZLg5sC6G1QlFj//4EYFd3DMno52+L34cmZHx+tz/qWw
	 WM7JxxUZlbEz2fzVoZZgGa5+tV3uZ7QPEakf10G1xJ7OLUMr8rSAv+EgrxhPs+8xDU
	 RgY5si8IGAFpA==
From: "Harry Yoo (Oracle)" <harry@kernel.org>
Subject: [PATCH 6.18.y 0/2] mm/slab: fix unbounded recursion in free path
 with memalloc profiling
Date: Mon, 03 Aug 2026 07:15:09 +0000
Message-Id: <20260803-kmalloc-no-objext-for-6-18-y-v1-0-8b01d1021f0d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ6CMBAAwK+QPbukrbEWv0I4lLLAKnZJawyE8
 Hcbj3OZAzIlpgyP6oBEX84ssUBfKgizjxMhD8VglLHKqSu+3n5ZJGAUlP5J2wdHSWhRO9zxRqa
 5e9cPTdBQijXRyNu/b8HW2tU7dOf5A0OcH2x2AAAA
X-Change-ID: 20260803-kmalloc-no-objext-for-6-18-y-5e297a8bd9c1
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
memalloc profiling" series [1] for 6.18.y.

The last patch has a slight functional difference compared to mainline
due to lack of SLAB_ALLOC_* flags. I described those subtlties in the
backporting notes in detail.

The first two patches from the patchset are not backported to 6.18.y
as they are no-op in 6.18.y.

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

 include/linux/alloc_tag.h |  3 ++
 include/linux/slab.h      |  8 ++++-
 lib/alloc_tag.c           |  9 ++++++
 mm/slab.h                 | 28 +++++++++++++++--
 mm/slab_common.c          | 13 ++++++++
 mm/slub.c                 | 76 +++++++++++++++--------------------------------
 6 files changed, 82 insertions(+), 55 deletions(-)
---
base-commit: 2fe596715f840d053aed5cee5455f701bdcd2b50
change-id: 20260803-kmalloc-no-objext-for-6-18-y-5e297a8bd9c1

Best regards,
-- 
Cheers,
Harry / Hyeonggon

