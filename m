Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575957;
	b=JuoTtyuHR1WX/IXa4XxhlBbpWUxA8qj0bXkztkBLolr0Y0J0vOSQi2zvO06fGmJRRCce
	 tOw1uCoXBFfuIY7UHDD69g4FXsESgkAL7Jdt52+Ha495B0OICQI3s8LRwq3qrm/jrcQxJ
	 RGmqytn2RzJyfClzDcCujg2xSctVVWOEya6EacUw2E8cg0ElNLgKJ35FrHPchzWQqk/OJ
	 H/2Hdu3fjlJN+VWfU+33hHJyL7u/8o/Z3gpJci/oSZTAOG8Isvr88xFrizzOOnkwb6gp/
	 4Ix1nx4Zt0MTAyeMyvOUc3BjsCqA5VMDPLN77WWlT8hngKmF1yLgBVdmSzeJwgEW9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575957;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V6G0bPzKPqW9y5CcOLYbTf+p7g3V14XBJCbAwz7OwwM=;
	b=xgZwzqfEuEUutxaXAaExCqrIm2DfNbRsCwNJJ4wW+DqhWd5JyaQdewJNYSEyf18Y1G44
	 H/flcUEKjBiaMp06ustml4cr0ABqp4jT2bl5I2fwTNl1QmcE7ja6Bl37VEztb7KOzi63N
	 ifLmqXMVkRNK4shJkRuLnhWe8N9zMcJXn2xlGvfJlWtLAoOgGlGo/dZ2122koe4Q48y7o
	 onwm+N95Kx9WlLHkZYbBlPMat6CsnRTK2GwxcDvAACEgsvWEOmgKtmFa+b1rmEmihz5zN
	 lxKamBRjvbl4pnPfTU8FOdw7zuZZYmBpcTzTGuBlCBkwDDM1WqMhjRlMEEx+R+9V4QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=X8cJyEAv;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A9606A330;
	Fri, 13 Nov 2026 13:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 881A9606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=X8cJyEAv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794575949;
	bh=V6G0bPzKPqW9y5CcOLYbTf+p7g3V14XBJCbAwz7OwwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X8cJyEAvdMWB71Tx5hYHbX9rgjIzRtn8e8WljOb6kbBjAJRhCppqLMlzblBT84BpS
	 5t5XEneMR04259TaXcu7brlD7exXU8OdKknO6REXSWgXX7zcAVeD3JF4/s1t/ZP0U7
	 jf/Ws0yxqDnkpjI4f3YE5RwDc/Wl6SOiodXJHhMjZ4INF+PIk/gbGt71GD8DLae5dU
	 ERyWsM3Aw2wIDyAi5wSFdKln0zJ5I5ty1Qiwv9D3OLerH+HQO6XVK2AuJOxOtunMdH
	 4udFKcw+CmrF1RqutBd3gAm7D6gvCufrIKUqxSVLdZRG8Xxf6ysWn/cx+PmhZHatou
	 pUO6qcX8nAbDw==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jQyWw64mfzPxK;
	Fri, 13 Nov 2026 08:19:08 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Michal Clapinski <mclapinski@google.com>,
	Andrei Vagin <avagin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Aniket Gattani <aniketgattani@google.com>,
	linux-kselftest@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Gellermann <christian.gellermann@codasip.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	John David Anglin <dave.anglin@bell.net>,
	linux-parisc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	linux-openrisc@vger.kernel.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arch@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Lutomirski <luto@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Boqun Feng <boqun@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	lkmm@lists.linux.dev,
	bpf@vger.kernel.org,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [RFC PATCH 02/16] sched/membarrier: Report only completed registrations
Date: Fri, 13 Nov 2026 08:18:49 -0500
Message-Id: <20261113131903.157186-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
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

MEMBARRIER_CMD_GET_REGISTRATIONS returns the registration commands
which the process issued.

Each registration has two state bits: one is set when the registration
starts and the "ready" one when it completes. The command reports a
registration when either bit is set.

The sync core and rseq registrations also set
MEMBARRIER_STATE_PRIVATE_EXPEDITED, without its "ready" bit. They set
it because their commands need the same scheduler barriers as
MEMBARRIER_CMD_PRIVATE_EXPEDITED. So a process which only issued
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ is reported as having
issued MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED as well. Yet
MEMBARRIER_CMD_PRIVATE_EXPEDITED returns -EPERM for that process.

A registration which failed with -ENOMEM would be reported the same
way.

User-space gets a wrong registration mask. The command was added for
CRIU, which saves the registrations of a process at checkpoint. A
restored process would carry a registration which the original
process did not issue. A program which trusts the mask would issue
MEMBARRIER_CMD_PRIVATE_EXPEDITED and get -EPERM.

Fix this by reporting a registration only when its "ready" bit is
set.

This changes the mask which user-space reads.
MEMBARRIER_CMD_GET_REGISTRATIONS no longer reports
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED for a process which only
issued the sync core or the rseq registration. The result of every
other command is unchanged.

Fixes: 544a4f2ecd45 ("sched/membarrier: Introduce MEMBARRIER_CMD_GET_REGISTRATIONS")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/sched/membarrier.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index cb957b8f1946..46e823a3d668 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -566,15 +566,17 @@ static int membarrier_get_registrations(void)
 	struct task_struct *p = current;
 	struct mm_struct *mm = p->mm;
 	int registrations_mask = 0, membarrier_state, i;
-	static const int states[] = {
-		MEMBARRIER_STATE_GLOBAL_EXPEDITED |
-			MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
-		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ |
-			MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
+	/*
+	 * Only the "ready" state tells that a registration command
+	 * completed. The other state of each pair is not specific to
+	 * one registration command: the sync core and rseq
+	 * registrations also set MEMBARRIER_STATE_PRIVATE_EXPEDITED.
+	 */
+	static const int ready_states[] = {
+		MEMBARRIER_STATE_GLOBAL_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY,
+		MEMBARRIER_STATE_PRIVATE_EXPEDITED_RSEQ_READY
 	};
 	static const int registration_cmds[] = {
 		MEMBARRIER_CMD_REGISTER_GLOBAL_EXPEDITED,
@@ -582,16 +584,13 @@ static int membarrier_get_registrations(void)
 		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_SYNC_CORE,
 		MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ
 	};
-	BUILD_BUG_ON(ARRAY_SIZE(states) != ARRAY_SIZE(registration_cmds));
+	BUILD_BUG_ON(ARRAY_SIZE(ready_states) != ARRAY_SIZE(registration_cmds));
 
 	membarrier_state = atomic_read(&mm->membarrier_state);
-	for (i = 0; i < ARRAY_SIZE(states); ++i) {
-		if (membarrier_state & states[i]) {
+	for (i = 0; i < ARRAY_SIZE(ready_states); ++i) {
+		if (membarrier_state & ready_states[i])
 			registrations_mask |= registration_cmds[i];
-			membarrier_state &= ~states[i];
-		}
 	}
-	WARN_ON_ONCE(membarrier_state != 0);
 	return registrations_mask;
 }
 
-- 
2.47.3

