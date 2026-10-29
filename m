Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306349;
	b=pt2o0sNJ9zSYt5Bq9TuR8xaMriIphoLqoJ5VW4PE9iMomTIqF/tPt3JX5ywIgiIKStNQ
	 LyzAYEsJkRRTU2BTNjZCdp+zSK/15ogwLtzlJd+Abh8nCthScdvXi+tlbDdyEsuPpQuZx
	 pq349Qx7Q1NBEQel1ghOmR4RswiHp7frHY15EmoUpAdgMXK6qqVUpZSF1r0zELCVlVYtB
	 pJIr7NJPGyCfRB5m24sIX9eViC/GwJN/839rcLke8HaegAfekGcJC6EKMk0YnsMFZQ+ZF
	 j6MSRvOiGhgtw+/auenNkfTBFP73NM8bhgLTh23uGdcuBih+/hn6AarlP6OUbUxCiGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306349;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=zVfPl9MgmcK9sfU4MC+6S2mU4/7MWZEGtGJA+Gf+TwM=;
	b=ALenkbTZgxt4975Mcnh+YLWU28reYVCYlNA+MBfUWsJUaA20RnqBUk+L+h5M41xzsT1e
	 D3HZVClVSKSr45n6yXxP69PyR5RClDy4WoW3yT5G31wJr7LjERIMrW9skgBa5nA/6aCOW
	 YHEi6qVG3pbM5Jek8PsY5b+/UbB/cZgOXY+j85hOar2IPPZZaQ6aa3Zx9EO1T4ag5MKwL
	 LIdEQDfD1RW95N5hOi2qfSp+g0VFCFSomOLTZdGeg28N7BT3dGe47UjLQLeKNkZSj2k8H
	 IFZOWJR8Le3exKpSPZrj66l6w7L0yJy8pBmzBjRLvhvwGVgVlAzpg1wA1+LzTk/Enmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kz2AvSL8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79132606A31F;
	Thu, 29 Oct 2026 20:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kz2AvSL8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA2931F01816;
	Thu, 29 Oct 2026 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793306349;
	bh=zVfPl9MgmcK9sfU4MC+6S2mU4/7MWZEGtGJA+Gf+TwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kz2AvSL81IHV86Y6xy2E2U1XsKVedZLudNnrvAi3R6LwSOiwulMVFEkdVCzj4b8mv
	 cJ/ZZkh2/Qx6UTpNE9wJoAwwaFh0wJfMLmQ0UiYfsRcVlWXuz1oEdtl2LTA6ma+W5x
	 3G1d5jMl2VufXF/QWz5sAP0Jlxt6/O4yznwAno24YQ7K4D9RBffWJ2vgS8qltPFrTW
	 3YgpmX34se9pgvw5ePx/p+4vJRq/wFoerwCOuFB1DR0jPYIlQXh2pB8yM2wDRftfk3
	 hBeJr9FkYgsni8V/+/N91Qkn21XvQjId4eyK8MYKS0mxlR97xpOYo7FctBaQluZQ+I
	 ZdiJ2oJGbuUng==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 21:33:18 +0100
Subject: [PATCH v2 23/47] mm/userfaultfd: write-lock the VMA before waking
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
Message-Id: <20261029-fixes_core-v2-23-a64ce7f83abb@kernel.org>
References: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
In-Reply-To: <20261029-fixes_core-v2-0-a64ce7f83abb@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=david@kernel.org;
 h=from:subject:message-id; bh=sxKVqTRFf7nv8Rk2AxGSEpTSCRWGcpA8V6JR+zulqqE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIer21/Yxakd+CiyJNQ2zmOll9uxhntdKtc5rXnK8v9R
 bvilHO3dpSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRU5MZGZpnb8kptntYn2z6
 juHxPK+NosJMz3KrSvRVGLyezRR/d5mR4eqGdRYB9WncadsXKvz9e8UqQCpxh9x/Pre6y5vCz0x
 2ZQAA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 928ad95eeb2b..3ca04b582329 100644
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

