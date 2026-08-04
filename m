Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B863E12AAF1;
	Tue,  4 Aug 2026 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834138; cv=none; b=Y8k7EBkSiB5Kzy6kwfL3fhHYLVXHSSRBAR2aVM3MgkaMElcd0jgpD8EuT8y9p9WE//6q3SZDcS7S9UjMyZquyZDhDlDFKQZyo0r2MjRbZmMssd0rFYqoqv0q1OZWT3ZYgr//7QvUZ8Hfytecf5Dksqf8dqDuvEuTgkdY2dhP1KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834138; c=relaxed/simple;
	bh=pFtB1KUClOJkpHCBb+AIWyZBao38WOjlgOqtTDbYOQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rEkhCGv/MHs5dtHCk5ELHX4aECTIQTbGAjtjYvpUfU//+hBBJBNOnRTHI7tGZ7k67tAbTzBeDygRabfxlAEG/nUKOSIAHGYLf2TD4pc3hNbyE3DqtTJqGVLN4ibh+vAU50aSkG34xFMZJtYHMD6HRgy7mft7yW+cYgRA3LfYrz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 2ce61cba8fe311f1aa26b74ffac11d73-20260804
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:454edc47-e2a5-4b30-9260-5b61c8f39ce4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:a5c355d906ce1370273447b2588f9356,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2ce61cba8fe311f1aa26b74ffac11d73-20260804
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 674569712; Tue, 04 Aug 2026 17:02:09 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com
Cc: linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] sched/numa: clear locality statistics on early return
Date: Tue,  4 Aug 2026 17:02:05 +0800
Message-Id: <20260804090205.712192-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A non-zero migration-failure locality statistic causes
update_task_scan_period() to take the slow-scan path and return before
the locality statistics are cleared.

Consequently, the same migration failure can affect subsequent
scan-period updates and repeatedly select the slow-scan path until the
maximum scan period is reached.

Clear the locality statistics before returning from the slow-scan path,
matching the cleanup performed by the normal path. This allows later
scan-period updates to use fresh locality and migration statistics.

Fixes: f307cd1a32fa ("sched/numa: Slow scan rate if no NUMA hinting faults are being recorded")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 kernel/sched/fair.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 78f8dc4cf5ea..676fe1c3356e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3518,6 +3518,8 @@ static void update_task_scan_period(struct task_struct *p,
 		p->mm->numa_next_scan = jiffies +
 			msecs_to_jiffies(p->numa_scan_period);
 
+		memset(p->numa_faults_locality, 0,
+			sizeof(p->numa_faults_locality));
 		return;
 	}
 
-- 
2.25.1

