Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECD7423142
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539882; cv=none; b=hMQY7uoDHDcACNiJwIHhdkvNBgVg0/FLmlL931EpAFMI6fOOUXNPEvgMHBK3RhR7DK+IFKSNa8n/FiEZj1Aq1rTv5a+Osv0rHEmhkdVyoT7X+nFgIQeNKz/rwU42IVx+VmDO0rdvPROHt414oV588ByrKZDH8xjwfNNm3huwMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539882; c=relaxed/simple;
	bh=MmxSoy1Ldx48YUo8MsAo/KbNJ+p4Y7y0niSVM7aQVxU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Slnj6vLCcnB3L+DTYb7kyNNgyD2K1jyMfXy4VTWqDgaGlzm7Q/AZskgI3m207mOySrD9qLEcRShSr6i36umuT6eB+Xo2YO3TEcKrKrQtI7yiY4lnVVhGnPYVVPdgxI3b4e01FY5Dj7Y1EV94vXFT4QHGN/eZbepSYkF1+agW838=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHwsnv9H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHwsnv9H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCB81F000E9;
	Mon, 15 Jun 2026 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781539881;
	bh=H6IUnVGSjcHElJ1IWZxgR/mpsTPJACx80z8lCvZGCFI=;
	h=Subject:To:Cc:From:Date;
	b=gHwsnv9HwJBOFRaRyqXqa8iFD4mLkXxMXSZ6PfPPH7fHNVa6VEGhbVg0+Ze63AgLB
	 zUndc4pH+qO25z9aLkKSEvAocQmycK6bJeYnYd27zt9+U7G/6jh+vDGMXB6dDPPCQm
	 64z0rvaIXhfmKRGZJ7DUremztRkiCVjnkAFHQP/0=
Subject: FAILED: patch "[PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas" failed to apply to 5.10-stable tree
To: muchun.song@linux.dev,0x7f454c46@gmail.com,akpm@linux-foundation.org,david@kernel.org,fvdl@google.com,liam@infradead.org,ljs@kernel.org,mhocko@suse.com,mina86@mina86.com,osalvador@kernel.org,rppt@kernel.org,songmuchun@bytedance.com,stable@vger.kernel.org,stefan.strogin@gmail.com,surenb@google.com,vbabka@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 17:54:09 +0200
Message-ID: <2026061509-even-tapping-4630@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c0ca59beb5252ea2bd4fdaef009d003dedc2030e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061509-even-tapping-4630@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c0ca59beb5252ea2bd4fdaef009d003dedc2030e Mon Sep 17 00:00:00 2001
From: Muchun Song <muchun.song@linux.dev>
Date: Wed, 20 May 2026 14:10:25 +0800
Subject: [PATCH] mm/cma_debug: fix invalid accesses for inactive CMA areas

cma_activate_area() can fail after allocating range bitmaps.  Its cleanup
path frees those bitmaps, but only clears cma->count and
cma->available_count.  It leaves cma->nranges and each range's count in
place, so cma_debugfs_init() can still register debugfs files for an area
that never activated successfully.

That exposes two problems.  Reading the bitmap file can make debugfs walk
a freed range bitmap and trigger an invalid memory access.  Reading
maxchunk can also take cma->lock even though that lock is initialized only
on the successful activation path.

Fix this by creating debugfs entries only for CMA areas that reached
CMA_ACTIVATED.

c009da4258f9 introduced the invalid access to bitmap file.  2e32b947606d
introduced the invalid access to cma->lock.  This change applies to both
issues.  So I added two Fixes tags.

Link: https://lore.kernel.org/20260520061025.3971821-1-songmuchun@bytedance.com
Fixes: c009da4258f9 ("mm, cma: support multiple contiguous ranges, if requested")
Fixes: 2e32b947606d ("mm: cma: add functions to get region pages counters")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Frank van der Linden <fvdl@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Stefan Strogin <stefan.strogin@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 5ae38f5abbcc..523ba4a0f9f7 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -205,7 +205,8 @@ static int __init cma_debugfs_init(void)
 	cma_debugfs_root = debugfs_create_dir("cma", NULL);
 
 	for (i = 0; i < cma_area_count; i++)
-		cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
+		if (test_bit(CMA_ACTIVATED, &cma_areas[i].flags))
+			cma_debugfs_add_one(&cma_areas[i], cma_debugfs_root);
 
 	return 0;
 }

