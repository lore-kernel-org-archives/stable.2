Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710476;
	b=oZ5kcIL2TlaiAblEiQmxTUiy6flVwCvpMKFVAx5zQPmMBieMA8AO4astxVOnJtCmqYd6
	 +GVTqM76GLh+/GBQItVcvqGO6s/O/NNeiVuJMlnexPMCuOqf2ENfofJ8AuzXGeDsGCZq5
	 VWbGRzrfXeJ9zuRIJiOfcAe1TzGrIy7nGlqu3So86wkwVe5T8xHl9iQDK659g2MI/d2Wi
	 KdLMjFqKArYahL52LkvOIjGopi4Q1n38UAk8k/NnAIxkwF3Z5VrIrqJIrOYo23MxNBxrp
	 MsFR/88Dc0l4ud4feBULCi3bkWOvEuYJWDKSGIqeaYQfC/pr/krc/zsP+kL481ncpCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
	b=BJr15Aoa+aLQucOWgxB8b9dQcZMPBl6m/+TXFyaX4qswU08jNodvKhpkNdNyo7UEckx7
	 UB696y2BEZ/1McOchsi+WGYsmBF0y8Sj1zSks3mlcaTs4aPQR4STKLlm3egZLjdq1doe8
	 9GMT4qU3L5GfZvlsMsUYcVdbTGt5WQgOZ/vNe27mZrH46Ge/S7+tnOizIeWkiD9NDMiMd
	 ha+DpmFSPOoYrqrTlJSwtrraJhKrnqOFyNTF+iiy1KGMP6PKzZX3gjkNGOJP7uxmMsOKe
	 W9vMP/7LxYoiZMbUhTczLqHeolM+By804RN6TdxnPdbKK+WtGtPOu/DOY0Yj98qvGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w74SYXQ+;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E20606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06E20606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w74SYXQ+
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a070781f63so3493752b3a.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710475; x=1796315275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
        b=w74SYXQ+g/qF2bdj8ZxUZKK4NAUdYeZHIEVKUmUQeP+bGn80Bg5YSY5XyVi38ON+HC
         XpJOoptFvuFDcEfSHPc0xXEI70TVGw15HHW6oUktzr7eJdt74VnoTWEc3Tg1AJYiboA8
         cOz2aIy6OUpKbc6Iuu8WcVlM8Lxjw4D/ymaX4ikge54ngjcTIBbFH6qGKXai05be+UfF
         3eJekkMZpakpo0WAHTFORX8gSLTzuO/S+vIgckNvf7KhcqSKS6hoZAQvl5xKVA70XDJR
         QG7n88mVq/MAKgk6bj73wLHOVR1iTlJJd18qKyOBwphj9GDInxJJpS23vxsBU9lS3tFj
         SJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710475; x=1796315275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zx2PX5ffkPJPf6TzIozB55NAQJzc9RQ5Aq9V1KvYSuQ=;
        b=fnOu4C/6b6mt7+rnI4PwvWzAcWL92hXTdJPf5L5DCV0JQBdxgibIafjDVM1egyEL71
         vxHfysUwOReoDFLOyVP4YFOaFwKcJ2rRBtsVSFKzgiMgBs5SyGqSMFv380rVbXbYPMuv
         MIaXP7ktGJlfD8QrWcOflrtlAIPNucjbWoz1CxNcN/Plg69wMheUXpE95hvMnEJwFkkc
         9HrAt34Sw8Oqbt5sWrms+nadWp5rMIsPT0DtWCg9zAiq2w/lS3HadZWOF8LSQiUHgMj1
         f+xyMrIBdmEZ/cM/W+rvdMk63zJdxWZGlcEe9ZfQZqMNA+flJFpHSM5A2kSK32OnJRMh
         +UtQ==
X-Gm-Message-State: APuU4Z8W518CmmkWblkLdzrVHYMKX9zXzAxT7AMwu3T8NXxI7uPWHO8I
	oI4xs7JFiWc+HFBR99v3hoaDSOCDUjDOf/taq920Zt9J7gEWMBcmRoFMCuI9m/9f
X-Gm-Gg: AZFdTZcsRQ5rcXIKQqRAsq9Tgfn048idI2D9Lun0MzGWx+F3LhrWc1PA07yeHZTouIZ
	9UnztEIJ3okVW3ww6Uou74jI8KHpCrJT9tQ9qPkrqvb9XuzgCrv9l9gbOGo+pZlkBOT3dvzXPlS
	5P2s6QBArZaZ5U3Ztd0u1xPv4zXPNF3/yTcfAfRz3Ut1kUG7Kc57sM0WFE8vEVaxHml3QH7NHM+
	+7uCUNvLn1bhoAgIFYQ4TACzNe7YKPxSX1Nz45VvBTWEfwBqZWyw9ynV9OephirniEDHH2er1z2
	ZrcA5ED9gK/HlLC0PW9h8IO63w053DlbjohuEoGox2dW6VapXMsdlapvNz8boq6CpUyZHpYS8G0
	/PaMJLuWo81UVmChI1/MHV+aBP9quK0U2epxVmQniFk40LWSXGdow7G6pTbneC2LZdtj+y4SUT+
	T/fQvUti/RBbqPyjbnRsMFiEfks2jD4ThVnV854BjdnSRWtUrKal2YoxHbe3MGiArBM6vtoFZht
	PXNJgIkOe5vIv4D1RsN72DoNakbZ9E8XgT7kYGwZrEXgb0e7TAh0g3rgcLAF5+tws4SWvfKdr3l
	ztuS3YiW/uYJJaC8U+kh0g4U93HPrxKKmY/s7Kvw8/tnOQyVgcQ5V+dIwxaK6b8D5O5BmfHjQFO
	teIqGcLLc0SL/ILaC5IJ58lWewBtRVMBuuQ==
X-Received: by 2002:a05:6a00:14cc:b0:886:a52a:316f with SMTP id d2e1a72fcca58-8c8792b6925mr19988696b3a.4.1795710475202;
        Thu, 26 Nov 2026 08:27:55 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:54 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kang Chen <k.chen@smail.nju.edu.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 7.3.y 2/2] sched_ext: make DSQ iterator stay drained after NULL
Date: Fri, 27 Nov 2026 00:26:58 +0800
Message-ID: <20261126162700.22257-3-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126162700.22257-1-yphbchou0911@gmail.com>
References: <20261126162700.22257-1-yphbchou0911@gmail.com>
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

From: Kang Chen <k.chen@smail.nju.edu.cn>

commit fcbff7b56a881bbe041b6c5ba12831a3c1ac1bb4 upstream.

nldsq_cursor_next_task() unlinks the iteration cursor when it reaches the
end of the DSQ.  A later call sees list_empty(&cursor->node), starts
from the DSQ head again, and returns the first task of the same
iteration.

The verifier relies on the iterator contract that once next() returns
NULL it keeps returning NULL: process_iter_next_call() marks the
iterator DRAINED and treats the result of later next() calls as the
constant zero.  A restarted DSQ iteration therefore hands the BPF
program a task pointer while the verifier believes R0 == 0.

Remember the drained state in the cursor flags and return NULL on every
later next() call.  The cursor has spare flag bits and the BPF-visible
iterator layout is unchanged.

Fixes: 650ba21b131e ("sched_ext: Implement DSQ iterator")
Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ chengyang: drop __SCX_DSQ_ITER_HAS_REENQ, which 7.3 lacks ]
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 1049a0914d60..6db6ca912bb3 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -492,11 +492,13 @@ enum scx_dsq_iter_flags {
 	/* iterate in the reverse dispatch order */
 	SCX_DSQ_ITER_REV		= 1U << 16,
 
+	__SCX_DSQ_ITER_DRAINED		= 1U << 28,
 	__SCX_DSQ_ITER_HAS_SLICE	= 1U << 30,
 	__SCX_DSQ_ITER_HAS_VTIME	= 1U << 31,
 
 	__SCX_DSQ_ITER_USER_FLAGS	= SCX_DSQ_ITER_REV,
 	__SCX_DSQ_ITER_ALL_FLAGS	= __SCX_DSQ_ITER_USER_FLAGS |
+					  __SCX_DSQ_ITER_DRAINED |
 					  __SCX_DSQ_ITER_HAS_SLICE |
 					  __SCX_DSQ_ITER_HAS_VTIME,
 };
@@ -10255,13 +10257,24 @@ __bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
 __bpf_kfunc struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it)
 {
 	struct bpf_iter_scx_dsq_kern *kit = (void *)it;
+	struct task_struct *p;
 
-	if (!kit->dsq)
+	if (!kit->dsq || (kit->cursor.flags & __SCX_DSQ_ITER_DRAINED))
 		return NULL;
 
 	guard(raw_spinlock_irqsave)(&kit->dsq->lock);
 
-	return nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	p = nldsq_cursor_next_task(&kit->cursor, kit->dsq);
+	/*
+	 * nldsq_cursor_next_task() unlinks the cursor and starts from the DSQ
+	 * head when it is called again.  The verifier relies on an iterator
+	 * which returned NULL to keep returning NULL (see
+	 * process_iter_next_call()), so remember the drained state.
+	 */
+	if (!p)
+		kit->cursor.flags |= __SCX_DSQ_ITER_DRAINED;
+
+	return p;
 }
 
 /**
-- 
2.56.0

