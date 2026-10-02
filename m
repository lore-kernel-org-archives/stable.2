Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084C1406269
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790969430; cv=none; b=YbEDOG+nVjR3ENFeqW1jVeJrUvY2nT4mK6hb7kUegb8lNwZnGYBn/UhHCQzHaewQ/RySMvgDtqDRnCj3TNf4DzX+J14xyz1FGc5eP+vFL5EkHes/JdhrZR276xfcw4R7zauU9VE9PGsc2nwpWzrOXaJ4FoNDHwekfG3zRCC7ZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790969430; c=relaxed/simple;
	bh=RdRAfa5PQ+3S2ZwHYuDJRj8JXQQshiW6S4oybDGB7cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi5z+VNc/AmqF1VZjT+rbzWLF45hnIBBBy4aw0sjvGLQ5CRsqot+Ea0sJThLsJMNS7YxhVcEnMUB5bfuQ81g52wc3wfiy3g+FsZTbF9CM/j7lmA7uAVsa7icZQaQlz0jvRzRb+T/nRRSsSeUg9vS7PDyMGsBlwx6o3xSGfpPSiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OXJaxPpn; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OXJaxPpn"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33c11ef641aso8252292eec.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790969428; x=1791574228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rp2rNOmlrbAk87IYPgLJrfxB1fngpvriGLhOL3sWc1s=;
        b=OXJaxPpneXVg6YDXE2lFSYan8pxmODqAsJg6sdb2syAhCGetCVUV+NsAClWhgIQXGv
         PDDdUGSynxSqLhRTDyRXsO0OjlOuEYCgWxp6uC3RXEZepILgv4kwnUh1o9R65sds0h63
         kYaKfHhG2CNCc5qOC4197WMb6ENF8vx8cvZWWtRurH7IwU1bueTN08Q9ZY+7MvJQBWJV
         qPKqYtA2buh+OkhJrlhDfKgIRescePV4EB9Bhlmsr8b2Kpy4yN4ahrB0xD6hLpktcdLU
         iBWMyhu0hpvZI58Whzi7jxSavwIR8N23qMvJ7grWCZC6chpD9eqRY/Ekn5/xHQpFWd48
         m3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790969428; x=1791574228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rp2rNOmlrbAk87IYPgLJrfxB1fngpvriGLhOL3sWc1s=;
        b=rJ5f6a8xCq5TByqm06xLXnpUExtSIYmDTE082ucevzOsuMuOzwGj88Ao1PHvXzPd+z
         hVaueuS6dEAdSYtkDlm4qNVMuVp2Elv+ZxsG769++dpnVE9K8ZF4oNvKu+rjRDQvVEuK
         q5jimT7j+sv+Ded2lvEgtSaTmbWtXnqMERLgrKd2Dy2OA7b9qKBdjh2KRAicXjnpNNhA
         KgmynRWk6nw3IpvqYy26ic7UVH0vG1Y4AoZAVpMhSTIRiqGX/NQJzi29rJeMzukrX8vP
         n5cYQ1MklhDd+1iiWfVJ4c4nUd00yB/6J/nNrZ7Ur4MHWuyPsuw6A8+HG8MyzCgfzdgg
         GMcA==
X-Gm-Message-State: AFq9FYIOEvgMkppKEe8odhB1B8Hqq7+VATRvHQulL7XK6IcU9WDreX2k
	iY9MWkdZwt96P8lK2ccrCg/q80N/pOHh68kAMQf6HkUQD08EKJzfeOyK6P4A/GQvELUOg3ogf6r
	WX/wCWtqUgA==
X-Gm-Gg: AYBFou2NI7qigjqEaIr39qpUKRbI/QO3ApwmO6slvKtQ2EfxThY1oU92uTgs9huSZhF
	xJWcr5Ge34/ioMTobokYZI+dqfEC5kmhxUR+BxaWZGpb+Zo4sf0WnDfrK1SXpkBnrjKgF9cWUxD
	QLlKpfSVZM5ybFPQvbZjbiNcabhuKztDtQxtCJ/zH6LKczKI7iqKli4TaWDG9SOEQpFF4iYv5Ap
	Q4AZACGi/rtHrZLuDNYOB5siGGuCBqx3JI6LYaBXoFT2te4cYn147OHT261NMmTsct/7yq0lwj8
	l5Qzg92hmndcvpbS6oz7Uha6nGRUnoDgzl+fOW8edEgYBBjSy56JeAt9z1i09AqdEwQJL16ANUO
	B51QW8mbfggMr/urTqNNtQGgbzx3x0CzzEqLIdN1I15rB+nvJI7iPwgcPuRBYyt1S68bSB81hT0
	iXDpXalNSHtkDbgBmYPs5YXYKGPM1Y/U7QP9kQNzPTMliVqauvGRuU67mms/bLY/Bile5hlfYgz
	vZfnTyRdjBcxKp3RFSswxuiH3M+s1cXUIthn6HzsiLIgpUPKpFSE6v9VplbexWVJhEiyzs=
X-Received: by 2002:a05:693c:2516:b0:34a:cb0e:f4e5 with SMTP id 5a478bee46e88-34f21994ab3mr4511572eec.40.1790969427854;
        Fri, 02 Oct 2026 12:30:27 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bcf9:6140:24a9:d1e7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f660f1sm8427448eec.13.2026.10.02.12.30.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 12:30:26 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Dohyun Kim <dohyunkim@google.com>,
	Neel Natu <neelnatu@google.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	toke@redhat.com
Subject: [PATCH 6.1.y 1/2] bpf: Fail bpf_timer_cancel when callback is being cancelled
Date: Fri,  2 Oct 2026 15:30:16 -0400
Message-ID: <20261002193020.19392-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002193020.19392-1-artem@trailofbits.com>
References: <20261002193020.19392-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit d4523831f07a267a943f0dde844bf8ead7495f13 ]

Given a schedule:

timer1 cb			timer2 cb

bpf_timer_cancel(timer2);	bpf_timer_cancel(timer1);

Both bpf_timer_cancel calls would wait for the other callback to finish
executing, introducing a lockup.

Add an atomic_t count named 'cancelling' in bpf_hrtimer. This keeps
track of all in-flight cancellation requests for a given BPF timer.
Whenever cancelling a BPF timer, we must check if we have outstanding
cancellation requests, and if so, we must fail the operation with an
error (-EDEADLK) since cancellation is synchronous and waits for the
callback to finish executing. This implies that we can enter a deadlock
situation involving two or more timer callbacks executing in parallel
and attempting to cancel one another.

Note that we avoid incrementing the cancelling counter for the target
timer (the one being cancelled) if bpf_timer_cancel is not invoked from
a callback, to avoid spurious errors. The whole point of detecting
cur->cancelling and returning -EDEADLK is to not enter a busy wait loop
(which may or may not lead to a lockup). This does not apply in case the
caller is in a non-callback context, the other side can continue to
cancel as it sees fit without running into errors.

Background on prior attempts:

Earlier versions of this patch used a bool 'cancelling' bit and used the
following pattern under timer->lock to publish cancellation status.

lock(t->lock);
t->cancelling = true;
mb();
if (cur->cancelling)
	return -EDEADLK;
unlock(t->lock);
hrtimer_cancel(t->timer);
t->cancelling = false;

The store outside the critical section could overwrite a parallel
requests t->cancelling assignment to true, to ensure the parallely
executing callback observes its cancellation status.

It would be necessary to clear this cancelling bit once hrtimer_cancel
is done, but lack of serialization introduced races. Another option was
explored where bpf_timer_start would clear the bit when (re)starting the
timer under timer->lock. This would ensure serialized access to the
cancelling bit, but may allow it to be cleared before in-flight
hrtimer_cancel has finished executing, such that lockups can occur
again.

Thus, we choose an atomic counter to keep track of all outstanding
cancellation requests and use it to prevent lockups in case callbacks
attempt to cancel each other while executing in parallel.

[ Backport to 6.1.y: mapped the atomic cancellation guard directly onto
  the pre-refactor bpf_hrtimer layout. ]

Reported-by: Dohyun Kim <dohyunkim@google.com>
Reported-by: Neel Natu <neelnatu@google.com>
Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20240709185440.1104957-2-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and bpf maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-42239. It detects callback-to-callback timer
cancellation cycles and returns -EDEADLK.

The fix is already present in 6.6.y, 6.12.y, 6.18.y, and 7.2.y, but not in
6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-42239
Upstream: d4523831f07a267a943f0dde844bf8ead7495f13

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 kernel/bpf/helpers.c | 37 ++++++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index cf422c80b30b30..af16711a731ffe 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1108,6 +1108,7 @@ const struct bpf_func_proto bpf_snprintf_proto = {
  */
 struct bpf_hrtimer {
 	struct hrtimer timer;
+	atomic_t cancelling;
 	struct bpf_map *map;
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
@@ -1202,6 +1203,7 @@ BPF_CALL_3(bpf_timer_init, struct bpf_timer_kern *, timer, struct bpf_map *, map
 	t->map = map;
 	t->prog = NULL;
 	rcu_assign_pointer(t->callback_fn, NULL);
+	atomic_set(&t->cancelling, 0);
 	hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 	t->timer.function = bpf_timer_cb;
 	WRITE_ONCE(timer->timer, t);
@@ -1329,7 +1331,8 @@ static void drop_prog_refcnt(struct bpf_hrtimer *t)
 
 BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 {
-	struct bpf_hrtimer *t;
+	struct bpf_hrtimer *t, *cur_t;
+	bool inc = false;
 	int ret = 0;
 
 	if (in_nmi())
@@ -1341,14 +1344,40 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 		ret = -EINVAL;
 		goto out;
 	}
-	if (this_cpu_read(hrtimer_running) == t) {
+	cur_t = this_cpu_read(hrtimer_running);
+	if (cur_t == t) {
 		/* If bpf callback_fn is trying to bpf_timer_cancel()
 		 * its own timer the hrtimer_cancel() will deadlock
-		 * since it waits for callback_fn to finish
+		 * since it waits for callback_fn to finish.
+		 */
+		ret = -EDEADLK;
+		goto out;
+	}
+
+	/* Only account in-flight cancellations when invoked from a timer
+	 * callback, since we want to avoid waiting only if other _callbacks_
+	 * are waiting on us, to avoid introducing lockups. Non-callback paths
+	 * are ok, since nobody would synchronously wait for their completion.
+	 */
+	if (!cur_t)
+		goto drop;
+	atomic_inc(&t->cancelling);
+	/* Need full barrier after relaxed atomic_inc */
+	smp_mb__after_atomic();
+	inc = true;
+	if (atomic_read(&cur_t->cancelling)) {
+		/* We're cancelling timer t, while some other timer callback is
+		 * attempting to cancel us. In such a case, it might be possible
+		 * that timer t belongs to the other callback, or some other
+		 * callback waiting upon it (creating transitive dependencies
+		 * upon us), and we will enter a deadlock if we continue
+		 * cancelling and waiting for it synchronously, since it might
+		 * do the same. Bail!
 		 */
 		ret = -EDEADLK;
 		goto out;
 	}
+drop:
 	drop_prog_refcnt(t);
 out:
 	__bpf_spin_unlock_irqrestore(&timer->lock);
@@ -1356,6 +1385,8 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_timer_kern *, timer)
 	 * if it was running.
 	 */
 	ret = ret ?: hrtimer_cancel(&t->timer);
+	if (inc)
+		atomic_dec(&t->cancelling);
 	rcu_read_unlock();
 	return ret;
 }
-- 
2.39.5

