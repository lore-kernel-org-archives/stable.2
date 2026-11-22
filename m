Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795370707;
	b=yrSb5zP+x1MaEc7iBahMBeNXovewsZta/qASyOPAlMt1lkkCFgTUJunUJjwEdklZcT7y
	 6WtC6GyK2tr44cZFkQLv69fvaIgLW/xH6iASfLjyR2QDR6cFuEcZg0yFK97CH1W1zWREB
	 heSEHUZ7v3E7mPNAlJSZyaNQKU+YYSVRKDq2xXVOwXKVz8LoXj0pl86UxU2EiwK8NOGxg
	 +li0Rv9x2b4JILdIkvEAf+GoFThQAIu5OzlaR9ehQ46sfM/U0GzTx5N6jPHQhhAyr+Oaj
	 tGc8oq1j0obeDxIyunwtHs10BYgF8GMFBKidsOg+s2L8O4DXWisnpQq3n6Eb3ZdWyRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370707;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5IC0wtyklb4BpJ6EaZGBZO0mWv0eBKLD9k5du0ATYzM=;
	b=dtwCBVPERyldJqa7lxWZ/JXtWj3ccSGPpjJ3dX9rM9+Nx55dtXzWwwiKkzSOQkQa1cS8
	 zCOzBUEtuuzzdhctDWgQY2UpaR0i+zrShR+6Mka+NlPu1RLnus2+VBTQ2+U+G0+nJ0YuK
	 9qf+RGRRkFBanJ4tA+FIm5hNio4bpsthW3aauYbml7hEKkFb0oci7Nxwki3MA8qPrFKpe
	 f6ccRkZbUjjViWWl4Knoso8/7c+YS9oIewB9TxeLILt1mjhdkY7HcfL9/fmYgCQdWJ5wy
	 cKw1qeMex0kr8VG79w0V8oLR7JUFGXOjO0pQIe3qdxDw9m2UAUIbJMNNb90W6VN7FEA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQ8srfgI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7F4606A32A;
	Sun, 22 Nov 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQ8srfgI
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795370706;
	b=O0nh7mgrtISeSKrk10ojV4BadMMzLuSz9Tz9olXMF422o99UzCAX1xf6ylAqfJmy+ui7
	 S8e9fANK8nVm7nLzUU4DTSgakdSjwSxjyk926Aorzb6+vw+4Nm7DRNwBVDTd7hIftzAbI
	 AUguwHow9ee2MNjtPjch5SOwRHOYyemyS15bjqAXM5zK9RojahtRTi7Ca1eqQen4NvOi8
	 wGAOWnY0KDiLhgYtbbWMjzgDkYHfketp4mCP34XHT9alNQ3+bMNKBJqExTYnwheeDBEHc
	 xokl8dg2sDQzfN9Q8S12hIj7Tne5itDpv1q4899ejxu54X5vXdupxoNRo1NdY6OUEtg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795370706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5IC0wtyklb4BpJ6EaZGBZO0mWv0eBKLD9k5du0ATYzM=;
	b=T6eEOT5K/Di+08gNRwWDCejVNiVVP9px8FgZ54yAmVaHKfe1WkLo/y6w4RQ02UmlUeyz
	 jWme43sprDFXU9c3hUezcPyutxCmiM3scTczQcE+uJDl7R8MkI/AefcF37Nr0yS8yGNwC
	 jhcp4V/xfjr3W8QnCetjmL/7YPCh2B9hgOFU+hWDykdRm/TiqdxBHC+6/kP28lF2dVFBk
	 4gS8tvx6O/BSbssFlMlFJ6JSO2sEVwx1HP2liBjfxfPjBk+CDvpep5iTw90aJ0BhBmIL5
	 csLQTe7cNOJsApkl17bZAotQjM66somEkj4DtCenBfIxeDrKqRGRtnElc3ekEbzFB8w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 339451F000CA;
	Sun, 22 Nov 2026 18:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795370706;
	bh=5IC0wtyklb4BpJ6EaZGBZO0mWv0eBKLD9k5du0ATYzM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FQ8srfgIqCiw6cKrs2mvO4/DLyeGXE26y6WvUAiP8DC9/cAW+SL+OPZOpcsM1aLd7
	 F/GYeNMm4TOun+6SY5RHkkfX1Wuqsr+a6Lchi9i8KFnuNmzVpQCZzbTZpBTCTPNo4z
	 wMqikj9bFG3RXnzf+LcUd+QNNhHzy966wZZK29TtNnEZAJQc9V/vpx/LEv2ROW0J+m
	 x+AcF3TyuIkOdj3+PLZtNyQFhszq1DfDmhmHrCN3q1TlBiebE51w2OiTeqHPz004po
	 UTMx/kH0WzsM1KUe3SQo5K5P1VKj0GKKGAHoGKJMQRKbB8s9OEcAGeFUVcEtbCuMNp
	 rBO/GOsZr8/Bg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AEF9C4C168;
	Sun, 22 Nov 2026 18:04:57 +0000 (UTC)
From: Hang Zhengyang via B4 Relay <devnull+hang.zhengyang1010.gmail.com@kernel.org>
Date: Mon, 23 Nov 2026 02:04:54 +0800
Subject: [PATCH sched_ext/for-7.4-fixes 1/2] sched_ext: Attach fair_server
 before tasks fall back to fair on disable
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
Message-Id: <20261123-scx-dlsrv-v1-1-87c342d8246e@gmail.com>
References: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com>
In-Reply-To: <20261123-scx-dlsrv-v1-0-87c342d8246e@gmail.com>
To: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Hang Zhengyang <hang.zhengyang1010@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795370696; l=3219;
 i=hang.zhengyang1010@gmail.com; s=20261008; h=from:subject:message-id;
 bh=nZIUfbuOGTYsYcOP54zg7VH1iW7P5BzO0zfHVPDdacg=;
 b=7CgecdzBpDWmPQ+JV4LPQHJrvsL1ONJxu379+NJXAPNuMCNvriXWfwRcK17nY+MFZqjKpgDXt
 46jlWcEQPI/DB1jd/NwyIKYhksNo0Qiz3wPBRIFzQWfYIPednQV7g+U
X-Developer-Key: i=hang.zhengyang1010@gmail.com; a=ed25519;
 pk=5drRny3PqRPLhKVB0YIQXN5YyD8miKCpXWhnEPvafAI=
X-Endpoint-Received: by B4 Relay for hang.zhengyang1010@gmail.com/20261008
 with auth_id=1133
X-Original-From: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Reply-To: hang.zhengyang1010@gmail.com
Content-Transfer-Encoding: 7bit

From: Hang Zhengyang <hang.zhengyang1010@gmail.com>

In full mode, the enable path detaches fair_server, since no task runs
in the fair class. scx_root_disable() attaches it again only at the end,
in the dl_server_swap_bw() loop. But tasks fall back to fair well before
that. New forks and sched_setscheduler() calls do so once
scx_switching_all is cleared, and the switch loop moves all other tasks.
Until the swap, fair_server can't start, so an RT task that keeps a CPU
starves the fair tasks there.

Meanwhile, the disable path waits for RCU grace periods in
percpu_down_write() of scx_fork_rwsem and scx_cgroup_ops_rwsem. A grace
period can wait for a starved task, so the disable doesn't finish until
the RT task stops. The starved task can be a reader preempted under
PREEMPT_RCU, or the grace-period kthread itself. While the disable waits
in the scx_cgroup_lock() after the switch loop, scx_fork_rwsem and
cgroup_mutex are held, so forks wait too.

To reproduce, load scx_simple, pin SCHED_NORMAL tasks (/proc walkers,
stress-ng --fork) and a SCHED_FIFO spinner to CPU 1, and unload the
scheduler 50 ms after the spinner starts. The disable can then get
stuck in:

  synchronize_rcu_normal+0x1da/0x1f0
  rcu_sync_enter+0x56/0x140
  scx_root_disable+0x230/0x420
  kthread_worker_fn+0xf0/0x270

until the spinner stops.

Attach fair_server before tasks start to fall back, the same way the
enable path attaches ext_server before tasks switch to it. If the root
domain can't fit both servers, the swap attaches fair_server as before.

Fixes: e7b63427fdb4 ("sched_ext: Auto-register/unregister dl_server reservations")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Hang Zhengyang <hang.zhengyang1010@gmail.com>
---
 kernel/sched/ext/ext.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index e8c30a21e03e..23294897dd6e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -7576,6 +7576,21 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	was_switched_all = scx_switched_all();
 
+	/*
+	 * Tasks fall back to fair from here on. Attach fair_server now, or an
+	 * RT task can starve them while we wait for RCU grace periods below.
+	 * If its bandwidth doesn't fit, the swap at the end attaches it.
+	 */
+	if (was_switched_all) {
+		for_each_possible_cpu(cpu) {
+			struct rq *rq = cpu_rq(cpu);
+
+			guard(rq_lock_irqsave)(rq);
+			update_rq_clock(rq);
+			dl_server_attach_bw(&rq->fair_server);
+		}
+	}
+
 	static_branch_disable(&__scx_switched_all);
 	WRITE_ONCE(scx_switching_all, false);
 	WRITE_ONCE(scx_task_switch_enabled, false);
@@ -7626,8 +7641,8 @@ static void scx_root_disable(struct scx_sched *sch)
 
 	/*
 	 * Re-balance the dl_server bandwidth reservations: detach ext_server
-	 * (no more sched_ext tasks) and reinstate fair_server if it was
-	 * previously detached because we were running in full mode.
+	 * (no more sched_ext tasks) and attach fair_server if the attach
+	 * above failed.
 	 *
 	 * Unlike the enable path, this runs on a recovery path that cannot
 	 * fail, so we use dl_server_swap_bw() to atomically free ext_server's

-- 
2.53.0


