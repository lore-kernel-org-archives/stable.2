Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1607E31E822;
	Wed, 12 Aug 2026 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786538297; cv=none; b=NEf9KqDLnnxyhhOUAGha5IyCOABlj9TGq6VXzdlhuQhj7To5LIppAAIISX98g2zs/Moq417ln4ZLlYugHFQj1M8XOjJT6B2Yq7sLsxlqF72Qp/3lFT2qDr3pE6ZxOwOVZ+gczQghkS/Rc+oYWfkUrHBOLYJrgToOcIXDffSXCeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786538297; c=relaxed/simple;
	bh=CB8LZFTCvsM3JKBBSoJKDG9jfICMc0d5+Y9SHC4z3KA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KjoI+tIp8jKfdi5sYc3zXEzSBwj67a0BUAc5O6EJDckTlQB5fYTPOv2GRVtFZMwIEUXBhiaV+XIj4WUlxUAnNFn3OVS4vGnWOkW78c/BeCkFe2GLsWkq1BSQeeI9F76ElkvOEwpRCNoX80CBY2FtLwSqFknoR80+Nmjr29MNu/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IN94gjyl; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IN94gjyl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9x
	RPOW+2dXeqmq9ZEUsdLnwyD+zwy3KRbyJcD0BrbwU=; b=IN94gjylbwZLPkEP7v
	3KUVGbA+lBm2P/FIJYdm1J0ujjTekMDqM81Vzgx6TmU8gzAszQmJaKDymFsiv1rK
	Sqjg4twnLKbrW21bNQb9bqqyeHVvLCglBWvU4tdOCna2K5nDEHPkHy2+clXrQnRD
	GyqDA8KSY9G2ctF2AoK1pmR5w=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA30YXOaHxqys+pOw--.1274S2;
	Wed, 12 Aug 2026 20:36:31 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] sched/deadline: Fix DL server divide-by-zero for inactive CPUs
Date: Wed, 12 Aug 2026 20:32:54 +0800
Message-ID: <20260812123252.2355986-3-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA30YXOaHxqys+pOw--.1274S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW5WrWrXrykZFW3Zw15XFb_yoWrJF1xpF
	WkGa45Kr48try0q3yDAw47Xry8uwsrXa9Iqas3ArsIvF15Jw1rt3ZYgayagryjqr98uF10
	vF4j93929ayUtF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRiYFJUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwg8HZmp8aM-FvAAA3k

Commit 4043f5498416 ("sched/deadline: Reject debugfs dl_server writes
for offline CPUs") rejects per-CPU DL server parameter updates once the
target CPU is offline. However, during CPU hot-unplug, the CPU is cleared
from cpu_active_mask before it is marked offline.

This leaves a window where cpu_online() is still true while
cpu_active() is already false. A debugfs write during this window passes
the cpu_online() check in sched_server_write_common() and reaches
dl_server_apply_params() with init=false.

dl_bw_cpus() counts the active CPUs in the root domain. For an isolated
CPU whose root-domain span contains only that CPU, it returns zero once
the CPU becomes inactive. If the server bandwidth is attached,
dl_server_apply_params() then passes this zero CPU count to __dl_sub()
and __dl_add(), both of which divide by the CPU count.

Using CPU1 with isolcpus=domain,1 and a temporary local hotplug pause
hook to stop the teardown after cpu_active_mask was cleared but before
the CPU became offline reproduced the state as:

dl_bw_cpus=0 attached=1 dl_b->bw=-1 total_bw=52428 span=1 active=0

Writing a new fair-server runtime while CPU1 was held in that state
triggered:

# echo 40000000 > /sys/kernel/debug/sched/fair_server/cpu1/runtime

Oops: divide error: 0000 [#1] SMP NOPTI
RIP: 0010:dl_server_apply_params+0x39d/0x400
Call Trace:
sched_server_write_common.isra.0+0x1d2/0x2d0
full_proxy_write+0x64/0x90
vfs_write+0xf7/0x540
ksys_write+0x6e/0xf0

Reject DL server parameter writes when the target CPU is inactive, not
only when it is offline.

Also update root-domain bandwidth in dl_server_apply_params() only while
the target CPU is active. This second check is necessary because CPU
hot-unplug can race with the debugfs path after its CPU state check and
before dl_server_apply_params() updates the bandwidth.

Keep the runqueue-local utilization update independent of cpu_active()
so that the local bandwidth state remains consistent if the CPU becomes
inactive during the parameter update.

With the fix, a write during the same hot-unplug window is rejected with
-EBUSY instead of reaching __dl_sub() or __dl_add() with a zero CPU
count.

Fixes: d741f297bcea ("sched/fair: Fair server interface")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/anw7IML1xzHys6re@jlelli-thinkpadt14gen4.remote.csb
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 6 ++++--
 kernel/sched/debug.c    | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 200300043fa5..01adaba7ee3f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1928,8 +1928,10 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 		__dl_add(dl_b, new_bw, cpus);
 		dl_se->dl_bw_attached = 1;
 	} else if (dl_se->dl_bw_attached) {
-		__dl_sub(dl_b, dl_se->dl_bw, cpus);
-		__dl_add(dl_b, new_bw, cpus);
+		if (cpu_active(cpu)) {
+			__dl_sub(dl_b, dl_se->dl_bw, cpus);
+			__dl_add(dl_b, new_bw, cpus);
+		}
 
 		dl_rq_change_utilization(rq, dl_se, new_bw);
 	}
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 40584b27ea0c..ba60ff48dc3a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -416,7 +416,7 @@ static ssize_t sched_server_write_common(struct file *filp, const char __user *u
 			return  -EINVAL;
 		}
 
-		if (!cpu_online(cpu_of(rq)))
+		if (!cpu_active(cpu_of(rq)))
 			return -EBUSY;
 
 		update_rq_clock(rq);
-- 
2.54.0

