Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932243;
	b=27Z6RM13Fj5OaBKQstxQA/TgVL9YgDRxmU0MA6MCQzeKQpYR4AYxrsA6/2xG8+Nbelir
	 SWP3Fan8I7zdfzcGLOYzVfWNLtNcfC+So4lOYJgVTB/JC5KYusiqvBhvf8WkxbFQ6FGLJ
	 XEMOiqBVd0paL+3A44C30hHZj3bDNjxFgmjxyvjbJ7j1IOf38L8adfZtPvkXvDVnj2iUE
	 iMXjMykboFjL88lENjJDD9Q9FC+ADe8gr9AuFB9w/IuBh5X+OeI0TWcEfdziwq5PqGKis
	 hfzpiAzStSbdp3NiBxnWtPRXdNU1lpghvH4Z/jam3M7rx3ei2BMBF5gwb+Et45noCHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932243;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BNeXdPblFT6nrj2baxWLtBPVceCtM0s58uH/6Q+lFQs=;
	b=cXgiy1lwT/iruxUA1sXgXdFE/oisDcVSlBBOOp9qkViOP99mvnDE2b2XJxccwvVrYV/B
	 K6ZfquBpqAb8+Za8UftC/3/Yq2LkusAHe8XsOU3mLm+fxq1UvO950SOXEYH84zQcp8Hyw
	 pHw26wOaHXemvcYA56S9l+g5dL0ZmlCcrTznFU5SQTYT/lv7SPz7dkeZ0KlaGRWz/Jn2U
	 YOHtkeS0wBFaR4F7C+GLDISEmKo6dfXQXcQsZK85xb7AIjPG+nV+q38EXecmsXLkOUnMu
	 i0kTTwr3MBodJmJMTfeV+lylzT1CyMGJLrk70LufAVwblK+1/Qb2K7sfJDcNnZABUXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=YosMGajV;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC94606A31C;
	Tue, 17 Nov 2026 16:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CC94606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=YosMGajV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794932241;
	bh=BNeXdPblFT6nrj2baxWLtBPVceCtM0s58uH/6Q+lFQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YosMGajVdr8bTyARSt14kbBXxvqSLwIkBzVVm2iFc2dB8LzONr4+DOO6kMyHMraZM
	 HLKsDFwyYbKp1xFvRvE1bkMBPGBH+BLhOmAtqk/XLaenm0e5siruQORsZ3FVHPgQX8
	 o0zmCt1KnhHrXRuGIQJHjydUj7lpQdmvQ+IMBt9XhF3Fl2sYHs/eXvC1fdtq36jUqM
	 fertguGTxjKDGkk8w+3AgKjWiK51C4xlXqCXHrI5Y2Bvyl6PShOM2rwQX6gPcNECAX
	 iHvJ3bdS7vc3BXbU9V6OjzmbnWsX7xUeRlEzgk0D/CYqsV7Z4J1GC0TUgkD9ONx8JG
	 vO1OFuFnKMkTg==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jTVHj55RDzRKW;
	Tue, 17 Nov 2026 11:17:21 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: tglx@kernel.org,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	paulmck@kernel.org,
	boqun@kernel.org,
	shuah@kernel.org,
	kees@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	oleg@redhat.com,
	bestswngs@gmail.com,
	xmei5@asu.edu,
	xujiakai24@mails.ucas.ac.cn,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 02/17] sched/mmcid: Give no concurrency ID to user workers
Date: Tue, 17 Nov 2026 11:17:02 -0500
Message-Id: <11039c504295ef6ee0eef55981993d8f5d1f40ce.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
References: <cover.1794932121.git.mathieu.desnoyers@efficios.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The workers of io_uring and vhost are PF_USER_WORKER tasks. They are
threads of the process they work for, created with CLONE_VM. They only
run kernel code: copy_process() gives them a kernel function that ends
in do_exit(). They never return to user space and have no rseq area.

sched_mm_cid_fork() still makes them users of the CIDs of the mm, like
every task with an mm. A worker takes a CID whenever it runs. It also
counts as a user for max_cids and for the switch to per CPU mode.

Nothing reports the CID of a worker. But it is one CID fewer for the
threads of the process, which then get larger ones. The added users can
also switch the mm to per CPU mode. A process with io_uring workers
would then read mm_cid values at or above its number of threads. This
was found by reading the code, and has no test.

Fix this by not making a user worker a user of the CIDs. Kernel threads
are already left out, as they have no mm.

Fixes: af7f588d8f73 ("sched: Introduce per-memory-map concurrency ID")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f2a981d418eb..7e213e88ac28 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11000,7 +11000,11 @@ static void sched_mm_cid_fork(struct task_struct *t)
 	struct mm_struct *mm = t->mm;
 	bool percpu = false, flip = false;
 
-	if (!mm)
+	/*
+	 * A user worker (io_uring, vhost) never returns to user space and
+	 * has no rseq area. It needs no CID.
+	 */
+	if (!mm || (t->flags & PF_USER_WORKER))
 		return;
 
 	WARN_ON_ONCE(t->mm_cid.cid != MM_CID_UNSET);
-- 
2.47.3

