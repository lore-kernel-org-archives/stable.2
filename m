Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794009594;
	b=P/oA8UPOloA/yQAso5VqVDTWEXxzmcIhj1p1tPI1bUMC+KT7km/nUGoWcFNe//ynEy4i
	 zzE685vFpx3btgWVXDI4tlkEkSHuettVkfPin+W/sTgDJUocaZFCdDGF2fS9VRU60Troo
	 mzTOcIHIFG/YmU9d4dJrxuOGtOndd3wChk36ZXmInx01Q6NxFSIHIiR8e3SvjQK8xRUQz
	 HA4G2UL+/um0xkiE11by9/pP9P+ueoLQI1hb1XLTHxBR/eyT8mEa+z+UEeFxJOR243V4w
	 Y3kgHHWjEaQuG8nB+CdT1++fEhVe6Q9Nv4cliN/X9FPEHE9PH1J63De76xJbQfbsrNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794009594;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZtSP315h1jfv38CZ6cYSrE1w5G6yyFXhvnyeuge3Fxw=;
	b=o4GoAeaTKBgFiP85vxl+l/53CgzoIj4HzsdmXSDmYYLX6e+1EpTg4Cpc6taxf0nYlTV4
	 3sILHfnEKg8D+skmf4gkasxmNgb1xiLwAnELKk1DJOJY1h8o2KcRXe07G2aKxiy7jNd87
	 duVaJegDXgVMpygrxlvdZ1VpR90jwv2N6jv18w42v2ndZbTgQFUi6vcWalnpPesoVid/X
	 x8vmyznjRt57VmRzZ8kCawkZLMgJVVBJGec81ZC7a9ja4Yj8qLI+0ImtO8yq45A62nh2c
	 qrzBYLg3zyVr6YaLtqK4iPrAbAD0VROotD2iIAiRvtDD/PlBXf6AcqWdqwTMjrPRk8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b="gd/mJhXc";
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A1B606A33E;
	Fri,  6 Nov 2026 23:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A1B606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=gd/mJhXc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794009587;
	bh=ZtSP315h1jfv38CZ6cYSrE1w5G6yyFXhvnyeuge3Fxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gd/mJhXc4W6hxd+g++AJO9czLpo024pAXEPK3Id/yvXzIAW7KyJdNjG8Yvo/FSnGL
	 x+EpX0dHk1j19oeSyG4DUaDsKY09yYRo68cSFGn0TAtD3mzUdMWRZHKK8LBI5ZwyfX
	 ImF+m8+lg017cBOgBL3vbLtBkM3o7LlwDLfG+cQ5GXciSgRJBmNa3HizzpUmf4HHix
	 5O5bNraRCQA6gHedDGOosszvyGq2brC6NeZ7b+ArTPYZ3W/QTpBH1INF7Aq5tDH85Q
	 VfynwuMKkex+rIVpliAvlrPwDX6qXbmEqlWlikPexh6v6MG6kOE1Hqsu+1+ciCPzWL
	 OM7pRUkM9J3iQ==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jLx4L6K0vzMF6;
	Fri, 06 Nov 2026 18:59:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	dvhart@infradead.org,
	dave@stgolabs.net,
	andrealmeid@igalia.com,
	shuah@kernel.org,
	juri.lelli@redhat.com,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] locking/rtmutex: Initialize the ww_mutex context of a waiter
Date: Fri,  6 Nov 2026 18:59:28 -0500
Message-Id: <20261106235931.1478800-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
References: <20261106235931.1478800-1-mathieu.desnoyers@efficios.com>
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

With PREEMPT_RT no deadlock on PI futexes is reported: two threads that
each block on a PI futex the other holds sleep for good, where
FUTEX_LOCK_PI returns EDEADLK without PREEMPT_RT, and a chain deeper
than max_lock_depth is admitted.

rt_mutex_init_waiter() leaves waiter->ww_ctx as it finds it, and only
__rt_mutex_slowlock_locked() sets it. The waiters of PI futexes and of
rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES, or what the
stack held unless the compiler zeroes it. Since
commit 6467822b8cc9 ("locking/rtmutex: Prevent spurious EDEADLK return
caused by ww_mutexes"), the PREEMPT_RT chain walk takes a waiter with a
context for a ww_mutex one: it turns deadlock detection off and drops
the -EDEADLK of a cycle. The ww_mutex build of the walk would also
dereference the poison, in __waiter_less(), on two such waiters of equal
priority on a lock it goes through.

Clear the context with the rest of the waiter. In 8-CPU VMs with
PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, v7.4-rc1 lets the ABBA time out
and admits the deep chain, in 2 VMs of 2; with this patch both get
EDEADLK. The futex_lock_pi_inherit selftest added later in this series
has the two cases, deadlock and max_lock_depth, and found this.

Fixes: 6467822b8cc9 ("locking/rtmutex: Prevent spurious EDEADLK return caused by ww_mutexes")
Cc: stable@vger.kernel.org
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 kernel/locking/rtmutex_common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/rtmutex_common.h b/kernel/locking/rtmutex_common.h
index c38b7bdea7b3..1f56d40c3e66 100644
--- a/kernel/locking/rtmutex_common.h
+++ b/kernel/locking/rtmutex_common.h
@@ -218,6 +218,7 @@ static inline void rt_mutex_init_waiter(struct rt_mutex_waiter *waiter)
 	RB_CLEAR_NODE(&waiter->tree.entry);
 	waiter->wake_state = TASK_NORMAL;
 	waiter->task = NULL;
+	waiter->ww_ctx = NULL;
 }
 
 static inline void rt_mutex_init_rtlock_waiter(struct rt_mutex_waiter *waiter)
-- 
2.47.3

