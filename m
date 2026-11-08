Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147244;
	b=g4KFJqvteje0IiRtf/qF7M5bhFDdrlesNsrOHvKDUNdWKewM10/aUl6wUUiOtsbwRkTO
	 tn9YGxt2JA+G2K6yhd7xrX+WVz07ssqkJ+gZi4BlOntSyelR3rcXiUiih1KyK/CijM384
	 DML10zw9i4nnvPLSYZlZaiyHcy3Q1IA7JarOQ7ScPgpAzyqBV5ZCNE6MwlCAl1NsQyoJL
	 gYIB/nATuM8wzCu5e6O9LPoyOYDDqnTqPucpVPQ5jYxvbPpdf/rJpUJWUNee+DqR68flH
	 igy+kJTu9TE0dCYCiqVLbjC/WCYdP5wglT/aTF1fyEi6R6cNKP3b9SEMy4FKPsepYrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147244;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h8s6nmFm+RsIWIhAVOuIlw/yFPNzlJaIkvBq9t4WkmA=;
	b=M8bB6NzWqBP/exUNtXzgU1ZB/+zUK5d6wp2ASjoB53rT2GjYZ6lxdPvopRALkoUnUgMA
	 I4nX0tsB7rAkXpo7oH2ILaDHHvg/TVpVHCLH+TjOoIdW4/YUbCULEQH3zutVAxd8ANAEm
	 ZFNUyeaH9jyft3vwmbk322G361MpQ45zPpP8N2ab2qOe+58m1OqMLdEv2O+LWYPGOp+Zc
	 n1y+zMKRS/jSfA8+WRDLx3V7sztekU8IvuTKV/sdsUD5SXB1qok7D4N+SgJuL7OTRKsPU
	 d5UMOWG+YmODcHcoO8ynG632AXUOOjdlggbinYGqrdcSJ6vEfRU0wQ45K0+CfNhVXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=A6ad49nu;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EAD606A31C;
	Sun,  8 Nov 2026 14:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EAD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=A6ad49nu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1794147236;
	bh=h8s6nmFm+RsIWIhAVOuIlw/yFPNzlJaIkvBq9t4WkmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6ad49nuALe0zrdiK18wGCzcYFFqY30IpzJcNar+uR/9Eua1IWtW6Fnem5DeMXiXQ
	 ki05srD540W46OFzWwu8ZDEOIByRIgqNJJOHYYb2tXZaPWtVQpzdVKWfGIZ2Dqrb3P
	 xtf28uMfEO5ALqErCTkksCYrQxjAI18tfyP7BMOkFauuqa9wPLwpZgf1+iMSXie5Qg
	 D3q98D9URCNABh+eq/qBhN9TwwfTacXntbGng5ghQSvnaDSMUWnF9s4I2C3iUUeT7B
	 JLKXozRaYD0JkX7CptSF/v0InrEEjwKrmj98IFdXTpnb06o2ObG8zE2cSi7MNYbsfF
	 TJYUgal9dtx6Q==
Received: from thinkos.internal.efficios.com (unknown [64.58.40.251])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jMvzS2gDzzMqh;
	Sun, 08 Nov 2026 09:13:56 -0500 (EST)
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
Subject: [PATCH v2 2/5] locking/rtmutex: Initialize the ww_mutex context of a waiter
Date: Sun,  8 Nov 2026 09:13:44 -0500
Message-Id: <20261108141347.1525532-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
References: <20261108141347.1525532-1-mathieu.desnoyers@efficios.com>
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

With PREEMPT_RT and CONFIG_DEBUG_RT_MUTEXES, FUTEX_LOCK_PI reports no
deadlock. Two threads that each block on a PI futex the other holds
sleep forever. Without PREEMPT_RT, the second one gets EDEADLK. A chain
deeper than max_lock_depth is also admitted.

With PREEMPT_RT, ww_mutexes are built on rtmutexes. They can create a
cycle in the lock graph legitimately, and the wound/die logic resolves
it. So the PREEMPT_RT chain walk turns deadlock detection off when it
finds a waiter with a ww_mutex context, waiter->ww_ctx. It also drops
the -EDEADLK of a walk that started from such a waiter.

But rt_mutex_init_waiter() does not set waiter->ww_ctx. Only
__rt_mutex_slowlock_locked() sets it. So the waiters of PI futexes and
rtlocks keep the 0x11 poison of CONFIG_DEBUG_RT_MUTEXES. Without that
option, they keep what was on the stack, unless the compiler zeroes it.
The chain walk then takes them for ww_mutex waiters.

The ww_mutex build of the chain walk can also requeue such waiters. On
two of them with equal priority, __waiter_less() would dereference the
poison.

Fix this by clearing waiter->ww_ctx in rt_mutex_init_waiter().

With this patch, the ABBA and the deep chain both get EDEADLK. The
futex_lock_pi_inherit selftest added later in this series found this.
Its deadlock and max_lock_depth cases cover it.

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

