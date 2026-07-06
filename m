Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC83AA19B;
	Mon,  6 Jul 2026 03:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783308335; cv=none; b=K/uPPd1Xe83TwdfoRahNCoXShQw69j4Jhpk0BMqlQDdQ/UF8Uye/1TF9ig1yir20/SvEExStJHTJOplZMDp3Idcl3FauvRDP/AqVb6xREGa20K4OiUBOjMxBKt5C10P40zr1+MmfQrot3o9fnuPekdH6Wo9s41MZKfjHCFr3Uqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783308335; c=relaxed/simple;
	bh=lYerO4A/a4J7kBn5242MFojwA3B5A1pKWFOd9bUDyYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lb/of3I7r/bbfJweC80l2WPxBXG7zqGLfeMKM02gINsGe6Jf3v5bxgMgzBk5bpZ56v1PfodPa9aBzyULZssr3vRIHrK9yLdeHhklRe3jsAv+MrsMDmKLNtHwqEHoCwEFEAwvcAB/DB8v455DoAQ5zjFHmdJhQleE8rAOY6dGFQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=c7HajMXj; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="c7HajMXj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1783308323; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=rfnZ/lC4Rb2GAMPajAZjxcZCPKg4CeTNBMYP2PQYiAY=;
	b=c7HajMXj9wrMpz+AnAiIM1wf+gK1W9ArW7fsg94AeUKbFSOY9eBqF49ZDNLHw+xFwGKCw+W1Pl1EDelbxLB0h2lDivp9zK3FDFYM1RJlC8U52o/8nST3TuzxdHjchN2iAmFvS8ar4uMmvtuk3TNi2Q19TgohXDgZLe+ctFbFqIg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X6PRHzq_1783308322;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X6PRHzq_1783308322 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 11:25:23 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	stable@vger.kernel.org
Cc: kasong@tencent.com,
	baohua@kernel.org,
	machao26@xiaomi.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] mm: shmem: fix potential livelock issue for shmem direct swapin
Date: Mon,  6 Jul 2026 11:25:13 +0800
Message-ID: <173f3fd983d735155d47e9e39d27f0c2d62a7c31.1783307463.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When skipping swapcache for synchronous IO swap devices, swapcache_prepare()
is used to prevent parallel swapin from proceeding with the swap cache flag.
However, on PREEMPT kernels this can lead to a livelock, as reported by Chao[1]:

Thread A starts direct swapin of a shmem folio and calls swapcache_prepare()
to set SWAP_HAS_CACHE. It may then be preempted inside workingset_refault().
Meanwhile, a higher priority thread B also attempts direct swapin of the same
shmem swap entry. Since swapcache_prepare() already marks the entry, thread B
repeatedly gets -EEXIST and busy-loops waiting for thread A to finish. But as
thread B runs at higher priority, thread A cannot preempt it, resulting in
starvation and a livelock.

Fix it by yielding the CPU with schedule_timeout_uninterruptible(1) when
swapcache_prepare() fails, following the same approach used in commits
029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead") and
13ddaf26be32 ("mm/swap: fix race when skipping swapcache").

Note that mainline does not have this potential issue, which has already been
resolved by Kairui's swap refactoring work[2].

[1] https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
[2] https://lore.kernel.org/all/20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com/
Fixes: 1dd44c0af4fa ("mm: shmem: skip swapcache for swapin of synchronous swap device")
Reported-by: Ma Chao <machao26@xiaomi.com>
Closes: https://lore.kernel.org/all/700a2cbf90a2484f979aac858f08f5d4@xiaomi.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Hi Chao, could you try this patch to check if it fixes your issue? Thanks.
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 94c5b0d78ac3..d4cb57b3b0ef 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2066,6 +2066,8 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	if (swapcache_prepare(entry, nr_pages)) {
 		folio_put(new);
 		new = ERR_PTR(-EEXIST);
+		/* Relax a bit to prevent rapid repeated page faults */
+		schedule_timeout_uninterruptible(1);
 		/* Try smaller folio to avoid cache conflict */
 		goto fallback;
 	}
-- 
2.47.3

