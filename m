Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B30480973;
	Wed, 29 Jul 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336312; cv=none; b=R+qPIs6zX6+c13wm93hgexuxxFAaj1FkG08L/yFGD0exm+uTjkZkGpPNX295e04NDpBSuoEsLNW2/SzDJq84/CrkaCeGU6WXXcixOjBAaxFcv5ts957mwhXfzmeluTwnz35pVbL8EAC0KMGSF9JpmZFtRoE5HZGfAYz42//WKoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336312; c=relaxed/simple;
	bh=bXWHlNFFqWc8hoUa1BhjixQ+su1V7I+cc3/IV3jnf7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IEuxYV2r3wT9EOkp9xgyxbbBSF2lHzaKHGN07dkqKJsdcYCkotOTGvbNwAkfsVJ0yk5pFOecPRHpRFbl5ZWiZV4Rpqr2ai9lR3ykogwQdrl3E73Ntfl3nyfnwsjKLjo7f57HyeUfclqLmYySY2NgHol2sQEZHlejLPL7iRIwmCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=KpQCwMoP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="KpQCwMoP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=cedqOYtFSfQFA+PIn+vDDyLZ60Xw1oFxndd4sPmxa48=; b=KpQCwMoP+r7S0f1yKSjaXwmJpZ
	kQUoXmioOZDbpLhFxgsbBrl+A7dw1C4BhIRv+HiGIDsOci1kxWtYz1dvAqfXqnQn+KBUOWGusOXph
	cshLs27zveHzaKIz8jg5eNi0OApmnm4pWG/zwtSHwChvuzQSdQNwiZ/wStjt1xHAPmBXiSpWp07Gq
	hDo/1AOXt+hRc22pWqawHE8kIAHE+DzskX1K3eJRL+m9f5cNINcORFxmPTLswvqj6OWhtKnDuL5Zw
	Ubj/YRZf+7hymFWKyCqMGe6fwV8/HCjewxITTzFtYUpQl0XL1T9hizNPHGDXnmSZQPrBeKCm1eG6J
	VlEoMtIA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wp5Wi-008WbI-2i;
	Wed, 29 Jul 2026 14:44:57 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 29 Jul 2026 07:44:40 -0700
Subject: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-uprobe-v1-1-61896b87c867@debian.org>
X-B4-Tracking: v=1; b=H4sIANcRamoC/x3MSwqAMAwFwKuEt7ZQ479XERdWo2aj0qII0rsLz
 gHmRZSgEuHoRZBbox47HOUZYdrGfRWjMxyBLde24c5cZzi8GJ+X7G1bF1XDyAhnkEWfP+qHlD5
 cBmAuWAAAAA==
X-Change-ID: 20260729-uprobe-b142b0863572
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Andrii Nakryiko <andrii@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com, 
 stable@vger.kernel.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=leitao@debian.org;
 h=from:subject:message-id; bh=bXWHlNFFqWc8hoUa1BhjixQ+su1V7I+cc3/IV3jnf7o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqahHkGn6PxPpFigsr9bK4vbcC8PQ0EnL1VvSK0
 NkX3M5f6yaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCamoR5AAKCRA1o5Of/Hh3
 baAgD/9Ydp2V9zy3Mo26lARnfy9qe7whhZLkeqiRR2Y01NUAzkpNUOFziR6m5269h6RG6LF7Ri5
 Pvtg3HS4alk1MEKldOjDm0pERODyOMWEr/a2SemKL1bL9o+WGuwiVZvNBb1v26IOgxidxfhVzt2
 x83XIkxPVEAhW7PWOeMi2EwXTK1HFVE0k2mjSiK6WDYpK/ZsvkSCSP/GIABeAsWQKs1fEu66s6O
 yYq+iQUyNgVtMhUuLALmuyPQwmn7bqMxu37h5E2TpvHGC6rOWXi4C+79lxFMN2q+6jbqFykt4jh
 o0Do9ZCi4S98HyiGOTtFxEd7Vj7SIg+RqCjfJbfy1k52PSt4ycpkxdbtZyxTUDPpMIE1k9/0BYM
 t1BA0/UtNor0h+FfBpXjJcV39+PzBt/HLr2zN+G1Lb6xB/Z0qcRzVotRoxaIRmDmHPg3PHEd35f
 1O4JhihAnPtXwEHjiNOxbafDm5iDXvtpd7jQThA95bhCa7H8xFWth4/3/Ob9+xXFdF3ZqjZ8Nqz
 pv4qFD7+a9nihXFbmMhW0PAsS51+bKjd6V3F5+6TvL1nkhmlXdrgA5Nsm1CLHBid5QcLQ4IEOkd
 Y6cP40CN8nnj8zluQjarzrXsljDNnFmSMiaWkb7xtfd302gQhr78D/RoWId511Afug5B0bEn+At
 BYnW8kM62PAN/4Q==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Forking a task that has a pending uretprobe can oops the kernel with a
NULL pointer dereference in the clone() path:

  BUG: kernel NULL pointer dereference, address: 0000000000000018
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:hprobe_expire
  CR2: 0000000000000018
  Call Trace:
   uprobe_copy_process
   copy_process
   kernel_clone
   __x64_sys_clone
   do_syscall_64
   entry_SYSCALL_64_after_hwframe

This was found on real hosts on Meta fleet.

I've got the impression that this is what is happening:

  CPU 1                          CPU 2 (traced task)
  -----                          -------------------
                                 hit uprobe, prepare_uretprobe():
                                   hprobe LEASED, refcount >= 1
  uprobe_unregister()
    put_uprobe(): refcount -> 0
                                 fork() -> dup_utask()
                                   hprobe_expire(hprobe, true)
                                     try_get_uprobe() -> NULL
                                     get_uprobe(NULL)   <-- Oops

Only take the extra reference when the uprobe is non-NULL; a NULL means
it is gone and is the correct value to return.

Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with timeout)")
Cc: stable@vger.kernel.org
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 07f69dd3093d5..950108f92079d 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -832,7 +832,7 @@ static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
 		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_GONE)) {
 			/* We won the race, we are the ones to unlock SRCU */
 			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
-			return get ? get_uprobe(uprobe) : uprobe;
+			return get && uprobe ? get_uprobe(uprobe) : uprobe;
 		}
 
 		/*

---
base-commit: 3652b49adac266a3d27cb41cdfdb7d8790fc3633
change-id: 20260729-uprobe-b142b0863572

Best regards,
--  
Breno Leitao <leitao@debian.org>

