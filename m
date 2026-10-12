Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70A13A258
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 02:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791772184; cv=none; b=RjOrgPknrhEt7QOFQ4kY0ZrlFPTUs04wB8vAZCE1AhWf2+okOlXyBGffrmcwcxc9fc9F1/Vmg2kTu2GGx7h6FfTiXjWNkr4G4ShQ+yyarVxEtEbk2WUp5Sf3JKDyO5kM1ORJxdLruOHf7KU/icvRjx1/b0FFEXXLDZUGJK5Clec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791772184; c=relaxed/simple;
	bh=aNua3oUvGdiiyi0IaOm3Wy23ZZe5ewykSyJsnUaV4qM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJZJ/OFE8FjcEk0lFfwweTnUyb2CbFQxKEn0f1Rrwn/gsE/3F7E4i81s6zRt4ScR1zWugYaU3Qv8TyhCEP+FmGcmZ6uKJY2yCf0DHFsmzqZCv5U/YYZFOXyzr0Pl18JfAIDcOcNrazNIYw6yMFBk65dfq9aOTjnmeHqFAdby1BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g72fH5zT; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g72fH5zT"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e7e742a2c7so8764855ad.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 19:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791772183; x=1792376983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YUzX3KLBEtejWmrVDJ7UhZNCGyRwxK6E6dSqlqcUQmw=;
        b=g72fH5zTwhBHwK4XVyxvUDaaL4jNaOssXAqvpxTADvecwdqwpqjvwrVfPx5/qBzXR/
         lR/GU6n2TmnvNgWzpUYKJNHzCXLhUyP5bi/oDEghCyiKbLibZcx0wauGlXHGpbk43NfD
         GA7pg419Fl6B/TDxzaVSf7402OPFGnXMAJmwAmfYIVmtFnsqZaW6h7iuwsaTFXAZlLkR
         dTLZf8A3B3GGwOUcVoIFmbJMAI47Tf/czO04N5DKwbPc4ePsFhDhTGooNZgWszTBNjiI
         rXB6lOmyBZ6LV7lOnxprjB28xy9NvDm2l2HRrZcAgVCQBeYhUwP1a2sU2Y2+UPEKiNm0
         nyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791772183; x=1792376983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YUzX3KLBEtejWmrVDJ7UhZNCGyRwxK6E6dSqlqcUQmw=;
        b=rL82tVK3MFGh029cI6n10mmx4xxlVvIa7pQXow/OwtMcUn4ymcgxBX5F8jv5enIpZX
         8QhftgBY5fCIatn9p4PXYqqjXDEeNAqvNC8+B8E6Lo5ySd4Bl2ixuYst6kOmvqH38iXN
         7m1WuikWGzInPVciCjnO9S4OrXpx6Nfaw3QXPySsp20JYSRySqeIy+7HHoMNO7fq01TB
         s7yDB4MSp9u94JeeLuimvko7kpFcErXZ4aE9XCMJFbWt2YTXe7ApnF8ayC8AXg4qx7Gg
         /HO26g3KPT3GYKFgxBkwZsKDYTfI9nzCQAc3JxHzahX/wF/h31xLpbm+51oBO99//N2c
         rLWw==
X-Forwarded-Encrypted: i=1; AKwUvByrnAIj8mVzl7o7uNSB7d9RQbF3bvNmv5RrXbSqTY39DwuguTj/5xLSHsP3W/70QJnS9b0oMoY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbPx4fxT/J4I3H89pFFX9pD1hET2xYC8HulvckJfX6xJXQLiW3
	McalmQKIw4QzDAaWU3Ex93JExy6Y4Hr5zjD+BQRl80Y026tptxGl1q0L
X-Gm-Gg: AYBFou1XTW4ZbKaLnO71dSU9tYXZTjV7YgoIRdBTPlMdWy0t4odi8ft7kVHRoq3wYWK
	Foc89eY6ccBLG9ExQZnYfNgJDPMpUcEtWLw21j8R+jJEbwxXqVlyRByQp4kExHX50KmBuoIyR/r
	zIrs50AGvGZrGP6g5vvr7/An1Vzq2o0FKZ6soQTXIrFN/4b90aPAR4qkcRMgjB03WDflAV19X1c
	qgKeomg9AclhU+6SM3pySWesbVODrUHdEZUsV2dzNqwOvcFgRaARiAANug9RKgKfgkfB8FEshkg
	KlWaKg1Rb8InBhsntaCkWr43Q3uq/crLTp15sh8+QIAmOYW0CC+Wk7/qb3fV3StAZKglnQ+S8UT
	RZtyt1exDko2yJORTWbZBKpGdQxOtWhBRH/7BYp2mcmGTUjHsAy8/4GFnSsQJCDwqXfXuf0iq5J
	quthh1fM+TgYcuA8zQXYVkruYR3LUfhz6/k6tRAYan19SAmQSPx+jETmGYd9ybogUAkWG0urKVS
	xvEFngFZapS9g==
X-Received: by 2002:a17:902:ffcf:b0:2df:34c0:72fe with SMTP id d9443c01a7336-2e84054243bmr52558625ad.35.1791772182510;
        Sun, 11 Oct 2026 19:29:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e84219e6cdsm37873555ad.28.2026.10.11.19.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:29:42 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	kasong@tencent.com,
	qi.zheng@linux.dev,
	shakeel.butt@linux.dev,
	baohua@kernel.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	baoquan.he@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	ljs@kernel.org,
	roman.gushchin@linux.dev,
	dave@stgolabs.net
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: vmscan: don't count per-node proactive reclaim as memory pressure
Date: Mon, 12 Oct 2026 10:29:17 +0800
Message-ID: <20261012022917.1102467-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

When the cgroup has no memory pressure at all, writing to
/sys/devices/system/nodeX/reclaim triggers proactive reclaim on
NUMA node, causing increase in the writer cgroup's memory PSI.

Due to this reclaim is performed in the context of the write(),
accounted as memory pressure on the writer, like
commit e22c6ed90aa9 ("mm: memcontrol: don't count limit-setting reclaim
as memory pressure"). This is unexpected, the similar scenarios (e.g.
senpai) will continue to occur, only this time it is for the
/sys/devices/system/nodeX/reclaim knob.

The Documentation/ABI/stable/sysfs-devices-node documentation also
notes that "This interface is equivalent to the memcg variant."

This patch unifies the semantics of the memcg and node interfaces:
per-node proactive reclaim is no longer counted as memory pressure,
and the per-node proactive reclaim interface no longer produces
phantom pressure.

I ran demo[1] that performs per-node proactive reclaim 10000 times
in qemu, writer cgroup memory.pressure as follows:

without patch:

some avg10=31.53 avg60=13.42 avg300=3.31 total=10602985
full avg10=31.53 avg60=13.42 avg300=3.31 total=10602985

with patch:

some avg10=9.59 avg60=3.41 avg300=0.81 total=2686221
full avg10=9.59 avg60=3.41 avg300=0.81 total=2686221

[1] https://github.com/vernon2gh/app_and_module/tree/main/reclaim_node_psi

Fixes: b980077899ea ("mm: introduce per-node proactive reclaim interface")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
V1 -> V2:
- Check `sc->proactive` to differentiate between proactive reclaim or
  page allocation. (Thanks Barry)

V1 : https://lore.kernel.org/linux-mm/20261005062236.564210-1-vernon2gm@gmail.com/
---
 mm/vmscan.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 91295070ca33..2e9ca5e4c741 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7994,7 +7994,8 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
 					   sc->gfp_mask);
 
 	cond_resched();
-	psi_memstall_enter(&pflags);
+	if (!sc->proactive)
+		psi_memstall_enter(&pflags);
 	delayacct_freepages_start();
 	fs_reclaim_acquire(sc->gfp_mask);
 	/*
@@ -8011,7 +8012,8 @@ static unsigned long __node_reclaim(struct pglist_data *pgdat,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc->gfp_mask);
 	delayacct_freepages_end();
-	psi_memstall_leave(&pflags);
+	if (!sc->proactive)
+		psi_memstall_leave(&pflags);
 
 	trace_mm_vmscan_node_reclaim_end(sc->nr_reclaimed, NULL);
 
-- 
2.53.0

