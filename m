Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793029702;
	b=lJRo/WmTrj6KgGfCiQ4RMG0rTFDmwI6NZuFsGhZJuzS1aoWRwYSyeergtdrLxOybPJDv
	 I/9Iygd6dADd8jPMzQYSqTuZrLEuwYZSYDJhPcuQojyYA2NxRBQcNxVMw2dsd8To7udbS
	 ROS6+UjEfjQVZnOEWPbhIj8J4nbbluujw8JGkAdJ7xatQdB0fvl99S8WTiheeUxal3pMJ
	 CsYkXIu5MkXroBjzUcpQq2xfV7Ebab8dfPgoebLFoDgnC9v44fFB8Q8xn1NDve+jV682W
	 y7owTIaBHtl+ifdM6F26yHSlEQriC04uVVdidJTU/o3HFrK2oCFTfWfMtJjHkRh1wrQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029702;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	b=drP6/UD/qUjetyH0EIiwIBvrVFVnjZAc6TWI5awZWNjuIsBigRDmdketxO1Z7RqWr+zN
	 jcYEzfDoz98qjPlhK1JX4VNZY9S3VPy0bZ2fBDRSw4xjQOA4d3UnXT4zy8cYQjGiWdNIs
	 sJGF9A/Jglj4EFsVskBdDggSBCT/fHuZGDVkMAP6aJJpq9qJ0ZMMwOZMxn8cRehcscis2
	 YCxSAeWkA5JyzXOe9QNk8ZxJ0ofyGe3IlkmP0CQsK5PFtQO3fPNDQPA6j+fFjBXBtJ22d
	 91bKHOQUQhPaXiSVtpKFKSh5Tg8X3yHOKuzZgLxsIL0GCJSrzsvxiqZ6HrtvOKDmOHg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONGsrzQc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558A606A31B
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ONGsrzQc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793029702;
	b=qsRDEUcepgEf2TkFozGzat9SKoPCtWuTPEAi1Dju+dK8hHQJquNxd8slqLkiWS5xz0xz
	 /Y2AMTxkQ2GJj+2xXdR4MHeSzY6gg2ErhnFf3YI/a4Gl0FlxE2Jq36ek4U+P5WcbrL4fj
	 l0CUukUzHLouwURZ3MLp2q0tLkJUNGFBOgbCQ2rsJIGxPOxWffiaH8fnMPCnOTkWvRlpW
	 JYQkopx+CH3YPChFuF4hO5JM+IsttpWJY3xSf8In2J9Dwv7JkOXQpS9TfZzNlmIUemfzF
	 b8NoIG0ok+ztnAXwEne+HTuXLNXRhYFC2YCu+9WqAIbUUbf2txB532wxnuYcPA54kNw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793029702;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	b=Tp5nxvG0zRFPl0p7xMId8kh1myyi5Z38u4hDFJCF27C0LzSthYRhA/LQbIcxh9Gihyzn
	 QloVhZ9IshylLNlaLvO7QsZRZGeXDIdApQT8AkJ+mip3HrZCS3pTWw2hb7K58uFstYjwG
	 svqPIWNf+M9OjLFa0cdwqWIce/pbFyxk8GJPrZS1JhMuM29cSVS9rQY5dAvG/cnLRTWR5
	 p46aPf2npl0+XoOj34SHNCgUQNQLItPPGPM5CSafzu2BTEN7IiG6cnrndVMjRMMWe/NO2
	 e5W4v8zyUSgsJTlZydWDV9kpQbHvZjAVqGRp59z/ISb+zLMSpnnCEbg/mi95ToyVJ1g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 801FD1F01829;
	Mon, 26 Oct 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793029702;
	bh=ypy55PQIRY/Gie/kAEltN807fD7sUXsm8MivRuhOtp0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ONGsrzQcYOzyk4QVZARYCwchakRKdSOQAfnhcxaooS9EgmsahKdLnSWgy/0ySXb3m
	 TSN+UQT8Y/QQYKSWeXWOnPCNjiyPfa6j3KISXKxAERsfgxn9/gMndEBfmxR58J6Sah
	 PC7wvj2Lt3sU/rkJc13xmnj6HV2hplzG+zCyt18Y8inVhWzjLVqd6iyj8Pv0ZAq6u5
	 L0Qjd6yUp2kMGt62J5dgiTJdZNScYSVHQ/fezoLvNnCcDJzqRVCf67nO9KP8TetJ/F
	 TrKgVJOT/lAu9YuMIOkkcefnHniMosbJAnNAQGv41cHCRdftIVqBZEpA8wJS/ndVIt
	 DLYohe8xd6b6A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 03F4A44D6A;
	Mon, 26 Oct 2026 15:48:21 +0000 (UTC)
From: Leno Hou via B4 Relay <devnull+lenohou.gmail.com@kernel.org>
Date: Sat, 24 Oct 2026 13:37:26 +0800
Subject: [PATCH PATCH 6.6 v2 2/2] mm: vmscan: fix dirty folios throttling
 on cgroup v1 for MGLRU
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
Message-Id: <20261024-fix-mglru-v6-6-v2-v2-2-6ca69ba6e9ae@gmail.com>
References: <20261024-fix-mglru-v6-6-v2-v2-0-6ca69ba6e9ae@gmail.com>
In-Reply-To: <20261024-fix-mglru-v6-6-v2-v2-0-6ca69ba6e9ae@gmail.com>
To: stable@vger.kernel.org
Cc: Leno Hou <lenohou@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792820248; l=3276;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=JnVRp/o3pn75fe9dOg9lgs8yva4bEL6E9tCoeF7HgKg=;
 b=Kdk0XSMQgD062IFU/x1MoDkC2el+132vXKVa378s+0pXFr14mbUwnqdmT1zxIr9JkZbkF9zdo
 EbuYxscaiQuA2GPWmmB9yYebFxWUiE0tl24j0dS+6SWUYdVAEAm1Z1G
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=
X-Endpoint-Received: by B4 Relay for lenohou@gmail.com/20260311 with
 auth_id=674
X-Original-From: Leno Hou <lenohou@gmail.com>
Reply-To: lenohou@gmail.com
Content-Transfer-Encoding: 7bit

From: Leno Hou <lenohou@gmail.com>

[ Upstream commit 13b6b620910436c29dea398382e83c9499fd13e4 ]

The balance_dirty_pages() won't do the dirty folios throttling on
cgroupv1.  See commit 9badce000e2c ("cgroup, writeback: don't enable
cgroup writeback on traditional hierarchies").

Moreover, after commit 6b0dfabb3555 ("fs: Remove aops->writepage"), we no
longer attempt to write back filesystem folios through reclaim.

On large memory systems, the flusher may not be able to write back quickly
enough.  Consequently, MGLRU will encounter many folios that are already
under writeback.  Since we cannot reclaim these dirty folios, the system
may run out of memory and trigger the OOM killer.

Hence, for cgroup v1, let's throttle reclaim after waking up the flusher,
which is similar to commit 81a70c21d917 ("mm/cgroup/reclaim: fix dirty
pages throttling on cgroup v1"), to avoid unnecessary OOM.

The following test program can easily reproduce the OOM issue.  With this
patch applied, the test passes successfully.

$mkdir /sys/fs/cgroup/memory/test
$echo 256M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
$echo $$ > /sys/fs/cgroup/memory/test/cgroup.procs
$dd if=/dev/zero of=/mnt/data.bin bs=1M count=800

Link: https://lore.kernel.org/3445af0f09e8ca945492e052e82594f8c4f2e2f6.1774606060.git.baolin.wang@linux.alibaba.com
Fixes: ac35a4902374 ("mm: multi-gen LRU: minimal implementation")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
Reviewed-by: Kairui Song <kasong@tencent.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leno Hou <lenohou@gmail.com>
---
 mm/vmscan.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a165f685216d..43b808e4e9f2 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5431,8 +5431,22 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 *  If too many file cache in the coldest generation can't be evicted
 	 *  due to being dirty, wake up the flusher.
 	 */
-	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken)
+	if (sc->nr.unqueued_dirty && sc->nr.unqueued_dirty == sc->nr.file_taken) {
+		struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+
 		wakeup_flusher_threads(WB_REASON_VMSCAN);
+		/*
+		 * For cgroupv1 dirty throttling is achieved by waking up
+		 * the kernel flusher here and later waiting on folios
+		 * which are in writeback to finish (see shrink_folio_list()).
+		 * 
+		 * Flusher may not be able to issue writeback quickly
+		 * enough for cgroupv1 writeback throttling to work
+		 * on a large system.
+		 */
+		if (!writeback_throttling_sane(sc))
+			reclaim_throttle(pgdat, VMSCAN_THROTTLE_WRITEBACK);
+	}
 	/* whether this lruvec should be rotated */
 	return nr_to_scan < 0;
 }

-- 
2.55.0


