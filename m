Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF1051AFD9
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 18:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754952; cv=none; b=lbngkuEPdSQS4qxN4ujRGax3cdLrpwFgh5/01fSlXWfLPlgcA/xwraNbMuPobjWnyfdCSYXKxMbUs/0Pwgap9/8i0vq1wmg2+2mDgUIl2vrTTyoLSoCpjalD3qEr68CWMyfOHkr7hN/czwheklyg2mFvvMnE2kLfhS33ZJUBn78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754952; c=relaxed/simple;
	bh=KoB3CfPk8XoAb1R9HLIOdJG6i5FfWlh5MAcBZ8vCVZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oci5JBt48hN9H2hGFwK8CcYTYzzeiko0sJCcj5NWCHYn/itN6m7F2dERcBbElDkvkA2OdetP88RkEY4F0kUr5maS+MVc11Ymx8iJ+tn01eNJePe/tHCbc2x9UMLDyTC1qJOwSlNbsolEedgKM0oS+z4ZnWl9QRJtOQMnsdWj6Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxBfG74O; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxBfG74O"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469b355ffso704790b3a.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754950; x=1790359750; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2C0KV4/HRdK46P+ZHWeIOsptd+6n2Iq6zskV4JcAQVA=;
        b=WxBfG74OVmbL8J16lP15iQ5u2Tr3K/yG1+2J2OfnjSKkTr2V5N9MLHuszJ0g4FBbrQ
         uaLTm0oHWYK6Hd4zzlzfuzFgKwTePqZonxRw10NXafD8OWIHOt+eJzgHrDgNigN7lWDG
         cLemRKIma10TegqXp5DWEkhB+Et2ftZ5+VuyWrumZzMB1rOUd6D3ST1EpDL49w8Hs6z2
         SfWNMaHp/ZY2XIxdi81tfX2QqhZh0ptaqMw9p1S/AYXk6+tEs7GkIAoQIUp2R5stJZ+p
         nolNtM4kS0S+fqhIBIgeY5qZsznaaxZMcm9AkgM54se/iBWZ2MZNVbqbX8JvF2Sum/J2
         f42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754950; x=1790359750;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2C0KV4/HRdK46P+ZHWeIOsptd+6n2Iq6zskV4JcAQVA=;
        b=hKTFm7uPUacZdwmoF2Z0Aswi896dRvZoHHaSoK6XRJ+DLMqcxpzOD+R4iVfCTxCAYU
         JhlWypx3CJ07MXH/UjWRQG6otgZcIG04nSKfLbrwbba6wNlc1pmc6qSvdTT0V72hnfFI
         we9sYlk1AnIh9x7Qv5xxFwX0ml+L2j2oWfkpgPOGlyDo0/u2eZkIozwXbDdhw+WIIRTn
         WAiYCm5A+mt/39MF5sLIJr/sqBg6yhpVDnqsPK0L/nBfwMvD9kCRrwMwMY9GmmaJyXEs
         4qQTm4kA5uC7cVWaqjpQU/iUtTenTdPIrxL9Ewi2yqOQJ/mixRZm5X+LbqE25t3BPHfJ
         pnag==
X-Gm-Message-State: AFuF++lFnTxThw71lhhe0f52VPhbnHntDTCdJ2MskHDclNbcFLDZS160
	bGr4jZgbNEoBk8EIVaIvywVhS/Mr8zDZeGIc4pl0GCaOapQJDjp3SUmL
X-Gm-Gg: AYBFou1k7T17E/CuewtA/nU5YFLesRXJ0WgHqp+8j2W5ZAErhrFeh4rjOs8Z45fd4X9
	J8T1bKZtUxiv9vLulZFyNlvyUU9slVmVcICGEn3E7x5iP5Dee1azx0I5OftZrkkyQxubf7mfOsa
	n+Fjycke148+DKQ8TeLUO6VrjoFXLM1Q00zqh7oMJj0uucchUmaAX1QBdJxxrVFYvwIRpoXsWkp
	rsjzQZd9BqlpS4OyNDau2AzhyX3AHinob5qAivJUZBvgU0tcWgi130ZjValZgvOEZPVkFNnAos2
	nqIyUe0G9z4DpfCrNnTBdzukeRQn6xgaIv2sUmEEmmR6hFbWyK2kCJqfXQuD4APhdGtVy3s4VsF
	UypT/6CIO/RSEpGpQ85v1XZfrTPjFrdgCO8gXQMWwmUHILolywWw3OC9VuguQD+/nX+AOkLr/Fp
	fY+11oF5Pp667xcQtSRYFWPBWuKJGZQvKYk2sm0yukfsywuhCvSKUXnRm+2E9oj8mMTAHykBaU1
	JmAKGM1E7FpqTRAdci6JT25
X-Received: by 2002:a05:6a20:914a:b0:3d3:aee4:66f3 with SMTP id adf61e73a8af0-3dd8c55deb6mr6636401637.25.1789754949710;
        Fri, 18 Sep 2026 11:09:09 -0700 (PDT)
Received: from localhost ([124.79.30.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm166722b3a.2.2026.09.18.11.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:09:09 -0700 (PDT)
From: Leno Hou <lenohou@gmail.com>
Date: Sat, 19 Sep 2026 02:08:49 +0800
Subject: [PATCH 6.1.y 2/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260919-linux-6-1-y-v1-2-577b5191263c@gmail.com>
References: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
In-Reply-To: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
To: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Yu Zhao <yuzhao@google.com>, Steven Barrett <steven@liquorix.net>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Suleiman Souhlal <suleiman@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Leno Hou <lenohou@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Wei Xu <weixugc@google.com>, Yuanchu Xie <yuanchu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789754932; l=3251;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=KoB3CfPk8XoAb1R9HLIOdJG6i5FfWlh5MAcBZ8vCVZI=;
 b=K7exehw++ibukVqJp0Ulx5sl11S8pNtNy8mnvRrz094bzpkmBy2BvJuQnw8YS6OuBP7YGR1iD
 eXEWUQE7C7hBtpUDDenv/FV75pKZFDf4wenYdrdieVK0nzx/2e15YVv
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=

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
index 03fbe8b2035b..70da681218bb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5255,8 +5255,22 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
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
 
 
 	/* see the comment in lru_gen_age_node() */

-- 
2.55.0

