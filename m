Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198820;
	b=VixFUng55k7x1mNubXjkNQgYTJo8Qnp7JzO0SKii0zzb08yBV4DMHPi6Cd3yUW1CDdif
	 FnrnyN1oOxXbekDy/RkUOE3sle9HYwgx5A/qwAG8r+Ol2FLkkh0bMQhc3TFmAbV0FWsIr
	 W2mEuY4nAjXss3k5iL53v9MZki/Bsqbayqd/AL+/zl9aEUmnxwaEdcBzR6mGJcCPCnvOu
	 63ZMPQJKMoehOoiTpW2eui58woGb3+++guDLbMUleJ8m7ZC4hO8bRSGsFN8oUqQNgMZdk
	 IU67ZEmFfI5kiBs3M5QCW/73vaMmD7T6zBsjmbZdy3gQgOvTSoYKrsh+kj3LUHhLYEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Xm4gBAjoi/87RyFMvAxqQNTLuj5YyKr9oL7G9qUbNSY=;
	b=NGMD2buNayH/6FK/LoP4RKCQVRtVfw3ilviT7TEHQN+Hd2s9hO0msKhssV0j6SUO1msu
	 kXPAE37fNLqxjzq3GQvxeYQh80P3tbcqswzYWn7sTUUZhFcbKLXpxB5SWBWaBGIAmAkI4
	 idZ9fR9FSUpQENyTEUL0ixRHTq2umlcOyERDT6xNYQzTxk/caLUErvzxswtc4tnckYD8M
	 Y6UwlQw/l5qIkZtzqTf1o/IUcnc697ivN+uYqD/vfEdVe73eeNcNLy/bMu2O21xqUSLBM
	 2771srAAMZUZX/uon64OHG1D+XyAsxDT7mUyBJZat2/VI0Nwcmnk6WKbiCVBNzQEA/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yc6g6M5K;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07F606B448
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD07F606B448
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yc6g6M5K
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso9969255e9.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198815; x=1795803615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xm4gBAjoi/87RyFMvAxqQNTLuj5YyKr9oL7G9qUbNSY=;
        b=Yc6g6M5KN+kuShBFHEoQJBcc77N9CbegUzcp0PLgIg/S37JK7a/of6x/EHEUu5QvKr
         KWBH1sF3KiPPb5QwF1NrITuEOOQSdMjvd0/kRy71hzpjM3Iu2O/ASsgNDWpX2aMu/9yP
         mySRbNA1tUlvCEsSsLRuaYO46DUyxAgMggoVsmgiZmbDB10d1HJTphOUzhTStYA0AkoW
         HGyFMHAXTCzff7MDtLUm82vmPRdcTxXcx2SpOsz5hGf+30EkoyYw6LKGvFgLZAu66uSZ
         GRavWY+9CqoZCbueCHQ448U8UBijvp9nf76zJD6ST7yKj721pFudV4z67eABW0tlwWzv
         SNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198815; x=1795803615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xm4gBAjoi/87RyFMvAxqQNTLuj5YyKr9oL7G9qUbNSY=;
        b=cQhUVEZi/ZOj+7QjyRGwrF2QLcgsx7+EJdUMFD1JW5tsPS+rNQ8IhdVrxPTHN4NjAv
         UICKpE+NOeqsUT7RTTA1OTtrZ60reHbi2BvHdwBq1QZEQ/OCkN6fNZCzaGRRVN6iL/o4
         kCWTWKjtc7EMOll3tQzy9ORZDa+nB1QVPi5Lk6kUR2212VDdwW4HeAp9O3+lhJV89MIf
         SMTkeOoG5z+vuLW14cA+GvM+laMDJDi7YkVKt3cPwFeIPW3g6l9mC01aDyl2vYzhmY0l
         8NFzdzC2HRTPF1xCtn7tfbqjjHoqg5w7TSOEF6lhC3Q6tHjezekt+Vg5GchlAUiVF09U
         ZTww==
X-Gm-Message-State: APuU4Z8zCDZ+o+24L52+/nNuB9ha1CU7jwhV9rBJYbJNMjUm1cOaJQRL
	87YuByC5zXObjLwfppMLu69Z/7u7TfGchZwuciQOfzgewfi+HATOybRlArue2A==
X-Gm-Gg: AYBFou3crIqmkSX17yPMPEf7pGymHmKgmSTMm/8BWqYcFyWtSbR8CpXpqzTCK0Ivqfw
	hyA3xCo3WwODCmKOI1hxn0Be82jL/ob3mjiXf2s3g5NhinXfS0mH6hNkRratc7BdUngud6VrQ7z
	nLqSvgFc8uhuEabvAZuWu8/bYVp7tAMnWCK9NLziQzqvku8FUbTJU0GYfVSXSnJ2XaG7Cio4obo
	bxoVslLEQyW68LPmlAo1ZpMPFSKa6y1c9fqD0rtx/UPHQZuZ6nrwfLeKoh5niG72fXutb/WX+GB
	/8BGTNDXdyr5WFqLswo4SGJJtWpmwti+PKRYrGK6nNzsyz8WNRszkfAYWLhktAciDnfnsP29WFD
	RzhHM0wMN6x/PCyvCn90TkzHaBYCeR1FGDKqOXaLZEc6aFol0+8FjQ4GyeBKBQl2yG3pPddmUuN
	MkzAPph8pO9CRPc3D1Hrnvp07C9qi1rEv35LygWoU0Wr2YaMlpM5LvvpWmXdPuZr0Dt3IPrz5wG
	/I4+4JrlBs3bdfeA0HkJ60swtAjNmsvL7LIsBZiZBdCK35TeCZE1C2SBsBg+/M+LwImH4OyHnpu
	Gt7y+DgEtgc6Tp4rpgv5hPqLt/yuQdoADmDZQNzKjHm8EwCagtl70+klIR3KJD3f1X168y2UDwE
	VUI5DKydxGmp5/2X3Acc9ASq5Ag==
X-Received: by 2002:a05:600c:a085:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb8881092bmr93717615e9.13.1795198814998;
        Fri, 20 Nov 2026 10:20:14 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:13 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 3/4] sched: Provide idle_rq() helper
Date: Fri, 20 Nov 2026 19:19:48 +0100
Message-Id: <20261120181949.7528-4-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
 <20261120181949.7528-1-fcarli@gmail.com>
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

From: Peter Zijlstra <peterz@infradead.org>

commit 1e0a2ba7afb1b60f02599093d84b72ce62ad11c0 upstream.

A fix for the dl_server 'requires' idle_cpu() usage, which made me
note that it and available_idle_cpu() are extern function calls.

And while idle_cpu() is used outside of kernel/sched/,
available_idle_cpu() is not.

This makes it hard to make idle_cpu() an inline helper, so provide
idle_rq() and implement idle_cpu() and available_idle_cpu() using
that.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
[ Florent: rq->ttwu_pending only exists with CONFIG_SMP in 6.12 ]
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 include/linux/sched.h   |  1 -
 kernel/sched/sched.h    | 28 ++++++++++++++++++++++++++++
 kernel/sched/syscalls.c | 32 +-------------------------------
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7f0fb62df..efee6139c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1895,7 +1895,6 @@ static inline int task_nice(const struct task_struct *p)
 extern int can_nice(const struct task_struct *p, const int nice);
 extern int task_curr(const struct task_struct *p);
 extern int idle_cpu(int cpu);
-extern int available_idle_cpu(int cpu);
 extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
 extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
 extern void sched_set_fifo(struct task_struct *p);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 598dd26fe..27de92902 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1390,6 +1390,34 @@ static inline u32 sched_rng(void)
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+static inline bool idle_rq(struct rq *rq)
+{
+	if (rq->curr != rq->idle || rq->nr_running)
+		return false;
+#ifdef CONFIG_SMP
+	if (rq->ttwu_pending)
+		return false;
+#endif
+	return true;
+}
+
+/**
+ * available_idle_cpu - is a given CPU idle for enqueuing work.
+ * @cpu: the CPU in question.
+ *
+ * Return: 1 if the CPU is currently idle. 0 otherwise.
+ */
+static inline bool available_idle_cpu(int cpu)
+{
+	if (!idle_rq(cpu_rq(cpu)))
+		return 0;
+
+	if (vcpu_is_preempted(cpu))
+		return 0;
+
+	return 1;
+}
+
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b51b39a10..f31fcdcfe 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -201,37 +201,7 @@ int task_prio(const struct task_struct *p)
  */
 int idle_cpu(int cpu)
 {
-	struct rq *rq = cpu_rq(cpu);
-
-	if (rq->curr != rq->idle)
-		return 0;
-
-	if (rq->nr_running)
-		return 0;
-
-#ifdef CONFIG_SMP
-	if (rq->ttwu_pending)
-		return 0;
-#endif
-
-	return 1;
-}
-
-/**
- * available_idle_cpu - is a given CPU idle for enqueuing work.
- * @cpu: the CPU in question.
- *
- * Return: 1 if the CPU is currently idle. 0 otherwise.
- */
-int available_idle_cpu(int cpu)
-{
-	if (!idle_cpu(cpu))
-		return 0;
-
-	if (vcpu_is_preempted(cpu))
-		return 0;
-
-	return 1;
+	return idle_rq(cpu_rq(cpu));
 }
 
 /**
-- 
2.39.3 (Apple Git-146)

