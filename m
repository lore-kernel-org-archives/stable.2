Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594273D091F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780395672; cv=none; b=ftcZZgblPE+hdaZzGCgHHmTugf72Nw1v7/J5T3WLhJSwgMdYd4GfzHvtA753pLKDYSRkcPHE6cdXXNRXXROWwKJNwrobhTp8RVEKdwzwPL6WiY0++2Cf16I4UT7qARCGnjvg9g7u1z1j42SwoAswwFtBEuYxih9IdMfZ7Bir1Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780395672; c=relaxed/simple;
	bh=+4cHcDc8kuAJc5aNRNtmAM0yDMNGCgeOgwIdNSW4zwo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MQUSlxtQFBmN0662lwAamXSQEy78sUDnty3IWzPAc+i9iC3J4srLBPEdvE7oud0qE8Yxip5b6EF+BjvPU2uk7BSWa5qVVe+QcWNNsgoPMtagHpjirt9xYGGMMBafIYzg+WjlPivPDbQIojCueJvxrHWoZpN8OQ2fmHz52ld4qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgq40C9T; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgq40C9T"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so16340625ad.1
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780395669; x=1781000469; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikY1El5docE8q+sLqTg4r7/Wm1ohIOfVrhz9dhSUA/E=;
        b=fgq40C9TYIWL+fv6LbkJpmGDIES7/9bEpbivS4wivAPUci37biZSP+rPFqqaIMxhS6
         qnIUtqObTORqhzVwkpuXuaOI2ez/UPLocoqASPhZsIiyN3YzKUiEMX8TmK35BWmofEI4
         lfZ7sC/hTGwzDe0JDm8GPtF4Q+9emyjx+K/RGNKMT27PRU8UgTtKo0vpCYuL+vVp/L5L
         NOLo85kmNenkdZE0O8MDxw4NFcyoYT7pgeLyrOSUPtqGpdbqZf04bU6undTc6zsh5y1k
         fs57pfvYZWacYIfqwr+JdxGTcGy9oW5naS9jpJ9NEZgxFV0KcwGN6EmnKyI2z1/1BUSo
         guOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780395669; x=1781000469;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikY1El5docE8q+sLqTg4r7/Wm1ohIOfVrhz9dhSUA/E=;
        b=qmotv93/wdYFFaf7BV8yIwpvHmm5Z0WVh/D4q9x33mdGwIPQY5Uq6pCIugl42wq/J9
         JFnhwmTNXilnLLX/GteHo5NBqWpercFrG57BDIVfMX1o6WF/TqK7EBtmz8NKjYMQcx2g
         AJCIrporolNDwDU/HUofrWtWR2Nz4oiBEG4IlBQYOCpuBZAaFa3tKQnmKHau/k6iGwWy
         91fS1sS91JakWQiitONnenRFK5YiKK1PDLwVw6ZJo+Fi1NQoW8wavwlbyW3kFwqypC64
         OlzplY69Ls3FTwjKaPWcMZtl9xR8w5Tbin7EZlmwMsvL2lTud+b3JYEYXG2/gFV0hkb+
         iXfw==
X-Gm-Message-State: AOJu0Yy1irPGRUs6UkCmHeIM34K5YMeV/xUqMRa3nL2WmFScbKpCI+CX
	mSIr/cMhovmK+bejz3hdCSc3fsDPMWRUblysW0HiovugiN4N1VbH/TN2ByQXIO2o
X-Gm-Gg: Acq92OEb3RBNzC8CJaSZvCM0l89OBRevwe6FPEN75U62L4kt3HqfUTlHjyGpzmN5NkA
	hTN1XtQ1Rsxf7Fpb/hH+Hw+QgpBQ8nWOzn07qgXBknwm/cnuf8vBgXwz0ObTw7Wf1JxstSgrahh
	KZHI6YSRvqb4atJC7bROq+U5e9JQeBHl1am0Ocu7pOGOAvpnbHRoJSpGsV/J2+F9dqTYmjKfuQC
	M9Ht8f9E8AjR9z7w3ZjyAWW/ziY3i8LjwUaOFMKwcjadzn6qfekhGekfWEZwmnXpdsT7RKnfuJS
	In3JY/sfwvblU6mVXMSk1rEv4DcJEfL0ACfn/iXOE+CGvupNpiU/0PTkaFtC8P53k0zD3kfXDNj
	G2QaAW0PN0tWgHnWBNZIsIlKU4MApI76jFVvioEbGDOK9g1V1sgNdDK9zi+IqB3B6kzQ/8QKcvt
	JB2P6BtWzNh41zUKEIIAsMl9hvOsbQlNO9StZCPUjggZndjMV5FqiR/gIfA0TnEXgx
X-Received: by 2002:a17:903:1c6:b0:2ba:25ca:b49f with SMTP id d9443c01a7336-2bf367d6cf2mr167163525ad.17.1780395669392;
        Tue, 02 Jun 2026 03:21:09 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a2dbfbsm131215415ad.37.2026.06.02.03.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 03:21:08 -0700 (PDT)
Date: Tue, 2 Jun 2026 19:21:05 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net v2] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
Message-ID: <ah6ukYq5G98LshdA@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
flushes every fragment queue that is not yet complete using
inet_frag_queue_flush(). That helper frees all the skbs queued on the
fragment queue but does not set INET_FRAG_COMPLETE, and leaves
q->fragments_tail and q->last_run_head pointing at the freed skbs.
The queue itself stays in the rhashtable.

fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
but it cannot stop a fragment that already obtained the queue through
inet_frag_find() earlier and stalled just before taking the queue lock.
Once that fragment resumes after the flush and takes the queue lock,
it passes the INET_FRAG_COMPLETE check and then dereferences the freed
fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
that pointer and, on the append path, writes ->next_frag, causing a
slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
share the same flush path and are affected as well.

Reset rb_fragments, fragments_tail and last_run_head in
inet_frag_queue_flush() so a flushed queue no longer points at the
freed skbs. A fragment that resumes after the flush and takes the
queue lock then finds an empty queue and starts a new run instead of
dereferencing the freed fragments_tail. ip_frag_reinit() already
performed this reset after its own flush, so drop the now duplicate
code there.

Cc: stable@vger.kernel.org
Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
Changes in v2:
- Move the queue pointer reset into inet_frag_queue_flush() to remove the
duplicate reset in ip_frag_reinit().
- Drop the INET_FRAG_COMPLETE setting since it leaks the queue on the
fqdir_pre_exit() path.
- v1: https://lore.kernel.org/all/ah1Sw2g-I89BRRiT@v4bel/
---
 net/ipv4/inet_fragment.c | 3 +++
 net/ipv4/ip_fragment.c   | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 393770920abd..1127519b8416 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -328,6 +328,9 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 	reason = reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
 	sub_frag_mem_limit(q->fqdir, sum);
+	q->rb_fragments = RB_ROOT;
+	q->fragments_tail = NULL;
+	q->last_run_head = NULL;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 56b0f738d2f2..c790d2f49487 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -250,9 +250,6 @@ static int ip_frag_reinit(struct ipq *qp)
 	qp->q.flags = 0;
 	qp->q.len = 0;
 	qp->q.meat = 0;
-	qp->q.rb_fragments = RB_ROOT;
-	qp->q.fragments_tail = NULL;
-	qp->q.last_run_head = NULL;
 	qp->iif = 0;
 	qp->ecn = 0;
 
-- 
2.43.0

