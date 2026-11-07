Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794058752;
	b=yOMw2LZrjODhB5+FY3p2G6IcXNmjxCO4evXTIsS1WwJtQgcjh2wTfRWQe2I5v7DZ7b8r
	 /VfVKvi+z8EMt3rO218siH3PCuRYzWJqBMvIv+IPBPdPTW9/S35OHVOWfI7DlL+ATIFyv
	 I0hCFXcRUEBJNKkqYdIz7pZq3VimrjaodmHpU4ycrgD3wfCwM+MBVFVqU0lxkDJZpfuj8
	 vZRg1n9rgPEfuO1R3UC964hPinaAtOzYhEylDELJjzc3Xjiu4q1UqS0dnuclZNPQBo4Ka
	 U6K6CvBlsphhZy1iRqGQ5QpT8NUAq3ZxlXtWJW/eqY0W2/OPlzSTLlqLmY1waBnXTmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794058752;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=dJYm2TImWbj5dfwHqPoqbjQsYL/GbiBHCiSucATnMBU=;
	b=JtELrb9Dtl6RTWfHiUX65J+fP/unsgCC7EZce4rOshMqBiZC98kGnFnNdqTk+itGt/gs
	 2U1dS6yJckFS54dSCUqT7sb8LneIHzPhLqUY0Ob5eUnrER1XtQm1B19JLI6QR+xtlqJOl
	 H/jBYrsXfdnvFJeaTzPddupOyagcOZXLOiJ59nUqsiclxWCeeNnGswHypVwPQIjDW9Dwa
	 /9VULGubmCl+sARv8NO9GBKx+Pcz9fNR2+0Pf1MXJfiUPcFtWfKkBYxJg8UpurwJbdV11
	 /GYcc0Q5nP61fZ6y6CRqUWIB/8gl8I4jk2eHpvHHM0kesXScy/UT2DfKOc8lZdy2npQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B620606A326;
	Sat,  7 Nov 2026 13:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B620606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jMHFZ0R10z55y2J;
	Sat, 07 Nov 2026 21:38:58 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A7DcrEa017445;
	Sat, 7 Nov 2026 21:38:53 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 7 Nov 2026 21:38:56 +0800 (CST)
X-Zmail-TransId: 2afa6aef29f0f9c-e49ea
X-Mailer: Zmail v1.0
Message-ID: <20261107213856462Jx8pIdgdtLvPLfOFTwV4X@zte.com.cn>
Date: Sat, 7 Nov 2026 21:38:56 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <akpm@linux-foundation.org>, <david@kernel.org>
Cc: <linux-mm@kvack.org>, <ziy@nvidia.com>, <matthew.brost@intel.com>,
        <joshua.hahnjy@gmail.com>, <byungchul@sk.com>, <gourry@gourry.net>,
        <ying.huang@linux.alibaba.com>, <apopple@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBtbS9taWdyYXRlOiBmaXggc29mdGxvY2t1cCBpbiBkb19wYWdlc19tb3ZlKCkgd2l0aCBodWdlIHBhZ2UgYXJyYXlz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A7DcrEa017445
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 07 Nov 2026 21:38:58 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEF29F2.000/4jMHFZ0R10z55y2J

From: Shao Mingyin <shao.mingyin@zte.com.cn>

mm/migrate: fix softlockup in do_pages_move() with huge page arrays

do_pages_move() walks the user page array one page at a time.  For each
entry it performs two get_user() calls, an mmap_read_lock()/unlock()
around a folio walk, and an optional store_status(); none of them has to
sleep when the arrays stay resident and the rwsem is uncontended.
move_pages_and_store_status() returns early while the page list is
empty, so an array whose entries all resolve to the same node can run
the whole loop without any scheduling point.  nr_pages comes straight
from move_pages(), so a huge array can hold a CPU past the watchdog
threshold on a non-preemptible kernel; with KASAN and function tracing
enabled, ten million entries can exceed it.

Add cond_resched() so that long calls yield periodically.
do_pages_stat() has the same problem and is being fixed separately.  In
current mainline only alpha, hexagon and classic m68k can still select
PREEMPT_NONE, and they cannot enable CONFIG_NUMA, so this mainly
targets pre-v7.0 stable kernels.

Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 mm/migrate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index 875079464930..3122ecb85270 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2372,6 +2372,8 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
 		const void __user *p;
 		int node;
 
+		cond_resched();
+
 		err = -EFAULT;
 		if (in_compat_syscall()) {
 			compat_uptr_t cp;
