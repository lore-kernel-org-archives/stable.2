Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793439974;
	b=ufFhD3tTGIidNsejAfPdLvNaZELteVafx4TYLPuF6P8EWGrEGVAWn29Rk9EfJgG9HBPi
	 Pn3p14/IwgJpPv/f9j5S1JjYecwrdGa6Zt693x4AyvPM5Zr9dqfQ5q2DlxRmk4CITS9NW
	 7NLVvt2Qn0SgNy6k57eLs6diWgok0NI2ppCpC9bXRS1lOWoP88zV8ctQoKiaDddOnlCD+
	 PJejQYAaR23xy6PsrIIJv9c/YYXUx1TngjupUvQNcTQbhGcKv6kd8mVdBlbIj3qKwRIDI
	 AK00QhDWB42M0T3LRz3R1NYaTBEtfRGyz4ktGwvvzhsMeNcl8vG3cCL95Imu9W3LP1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793439974;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=4sgsef0PgIF0cfrADdJuNAAJq268avrj1EIWVyDlN9A=;
	b=AzN3tPvw/Y19J/eGQq7YPFjRKC7NSLuC8qzaSJZdkHl2HXwhnMb1BFEIIrpMmeJHIkD/
	 73xztfNsdy/Fq8SAplMjBWrFvRgYcxe4ldvDJNpNL/8+JprtPrshwZiO1YGkAfzLP2llN
	 XZGp8fjLriV+2B4YU5dydVWvVQhEqcmx+te116ZWw7k/zo34o6xuc67Uor0o+0mD5Hbgr
	 5BUhS00y88iHaj4AohDxEf+c6819LkbTi98BLYW74gbp7KSAnPt9jKtE96icrU4AQlHjS
	 EzziJVRGbzTfQB2La5bzYKmCJQQAyYbDx4wCKJBOs2Em6e0oUWjEip0KLsYusnYJBLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6CFfneP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48082606A321;
	Sat, 31 Oct 2026 09:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6CFfneP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6136E1F000C1;
	Sat, 31 Oct 2026 09:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793439973;
	bh=4sgsef0PgIF0cfrADdJuNAAJq268avrj1EIWVyDlN9A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d6CFfnePukIWxq1RflVVt4wxWBc+6vCaK03YtXkPiVGAT1MLhmGttqbCKpZC8CMv0
	 ykZG9YuZhqJBGj8aR09OSLgRuWTYMZWKwLUnOtAFD0NmRWhh/hkNYdyjvdkGrtM/HC
	 NvXMCLg235yYjJ1P9mJHTNNH7LQX4WGY6VQxjXRLERdE7L37vvhfQideQle/aO4CF2
	 rz9IJxRxQ+TD0DOdP47cmawMrJuPX8KczA2npuhKSEktnAwI/DZutaxbl1koK56PVe
	 4Qx6oqX4wL1+I/FemH+A6y6sdwfYTdtWxi7NEEoGuMBtRUXETKv8bzi+XlHEkQntS7
	 4jzXemYA3bcMA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:52 +0100
Subject: [PATCH v3 23/47] mm/userfaultfd: write-lock the VMA before waking
 waiters when unregistering
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
Message-Id: <20261031-fixes_core-v3-23-d6437171ecc3@kernel.org>
References: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
In-Reply-To: <20261031-fixes_core-v3-0-d6437171ecc3@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=david@kernel.org;
 h=from:subject:message-id; bh=wm0iwUtDDosDLjqj9xBcxV65LFmKykeK8WHMHyZPLHw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLKebs+QOvwkeiXTRJbcv69PJk23spi0JO3lV54Jugxc1
 +3fPj4R2VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEXhkw/K8Jnfd9x5bTzUxX
 pftZNxgezJ8YN90hhLtU3enYreUr/mQwMlwUz5Tcc+IGq0Txmea3//4c6PzmP2uueYjKLiaP75X
 zrrMAAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

userfaultfd_unregister() wakes pending missing faults before clearing the
VMA's userfaultfd registration. With per-VMA fault locking, holding
mmap_lock for write does not prevent another fault from queuing after
the wakeup but before userfaultfd_clear_vma() write-locks the VMA. That
waiter can then remain asleep indefinitely.

Call vma_start_write() before waking waiters. Existing fault handlers
queue themselves before dropping the VMA read lock, and new readers are
excluded until mmap_write_unlock().

Fixes: 29a22b9e08d7 ("mm: handle userfaults under VMA lock")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 928ad95eeb2ba..3ca04b582329f 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -3991,6 +3991,9 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			start = vma->vm_start;
 		vma_end = min(end, vma->vm_end);
 
+		/* Prevent new userfaults from being queued after the wakeup. */
+		vma_start_write(vma);
+
 		if (userfaultfd_missing(vma)) {
 			/*
 			 * Wake any concurrent pending userfault while

-- 
2.43.0

