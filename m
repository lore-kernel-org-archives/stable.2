Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710472;
	b=mTTGlGnpi00QSniYzpUKdfVDtpR4Jz41KobzRb2aNgz78mUUyv1FkXjmb/IC6CmGVKDy
	 i9/RI7qnNE4hvUEWq0R1nmaFdPvdUxIypIn9fQyanwCnOkwhoQX3e7Hv8waJ8syJHQ6MQ
	 8PVnPAMYD757veTElzbgn6yc0TpLI9rGZPTXOwFj0X5EYJpOkDY6Mq/L0NYQ5dFcATIgy
	 BDjQ1El7o3PNcuhNre9dHIht+ZxZfQbqKCH1iDdV6FvwciGmqQVFvYseRoJ90y67NUts0
	 fnLo738SlimVjBqpz3GBP0O5uEqUenxaF4jyBkqjU2HThEnMk2++PKjxw2UcWpSaiPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
	b=v4HOCd3pbVshvQnNk/BQA9u2GxNkCmjyIoldzcGV1cqH6Ex2Cn0AMN94vbys4qO0fiXr
	 Fz5h39Zgy+vvflcnxybQ7fzkjKvHpT2hp8g2rtA31fTJ9GY6BkMeSUGsUQEo9ybVvDk+k
	 Pf7Jbl+9Yny1+gRe8d1nr5vQ5dXiv75EeQ3YQuhLkYKGTIkwg394/tjFGnAdWEIX6Jbm2
	 sxsy06Y78UJMKjD3Za2DeUcOuPBvFkO4ZRXwbhg8qyvexc2s1Uz+ShZq/AmZuDlZ7Vi1r
	 DVNMP9oYIw7Nd/wLsjMq401Ij8Q1cvLWPI29gNmIVkPAl2YGN+h3pSxrXBdZZH+pD2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meNKxsf0;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BF2606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:27:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04BF2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=meNKxsf0
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8d1aec63541so287005b3a.3
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 08:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795710471; x=1796315271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
        b=meNKxsf0pZ3kR0RW086wDMbOnaeIakjTWAMoOlh48L3u7FNKSTs9e8FGzNFrNUcnS4
         WSxLQBvcTzfno6a7bWm28vH18ezHEy99iLhjpv1+G2mCk9Nj+WIBIjN7FTiQZjlZlaV1
         wwi5TBa61LVuBBt/OcXQKw+WgiNkSev0foAiWiWPvgM84UmCQS9UPJRO7BTkjg9B+So4
         YCnjFmCl6BGz+DCTTahYnnz/I1uV5NuQ641gxKlJEoYkhbyabezgDj4UeFUoiNOkGi3e
         86m7DLNaBPD8UK2UDlPVQpWA0SH2hUQ5Xu2fJWgUxmtMXJTjDdmw9tEcJ0d5d8UFpsBq
         ZY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710471; x=1796315271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FP0roxHyrWk88AZNLgTy+sqCX40+tPZRlLLzxGj21Iw=;
        b=Eq34mTTq/YBaX5fqerhsvx7N0kyI1+grNyfGX0br1+AgjCLgXVxG+eDOV042PKn7fz
         zwYcM3mVLKmC6zQDRjeCoLbHKYBsYr63ga5UwEStOXxT1gr74q8d9O5RaO9qhpyiH5b4
         NvkZ+2e7lnvt7/TC7khlmq3AAM8hsweATmX6L5Vv0FEGcRJLIARgwWvHkrIWiA/aIeMd
         BQggRZIqaXByP4BMMhBQmffKbFgckjyWQhMG/DMPUisapt4z23fXNXdg3v93bkhTEcVc
         v18XOHqV4wi2HJKBboOUyZiKtVfOc1apdO+Bb+YnIA1zspQo0zbAhFR8RhT4wW68RJAC
         szDQ==
X-Gm-Message-State: APuU4Z83Netdpa6h/U+HXMExJvJlR8I2YOZA/MLFPXUhkMuxxRqQVZui
	hK2QLktrIZ39oSeqhYCVB/81dp+mt+v9G+yE4JM6jIMmY4GMp8NG/rUWYT2++G4g
X-Gm-Gg: AZFdTZc34wWqXK1xg6k+f0mG+S05X/qt7S5Y7CptqztJ0osLFEwG6vLVGLpAdHk090h
	gDa53TgzP5f/c6X8eeDK2QgPspEFi9UEdSh2xtqim4FwVZTmL5g5wih4CYzD7jzgNO74aCAshIm
	dgNBZWTtsiS3DLvT0Ng9HgnjAk1kOomJDa78Pm4SFp+InBS1J4fde0kPR1QblG2pKwNIq1LZNwQ
	atr2dfrnxCvGh34UpkF+eGUs/MdIx0yZ7UEDGesWqVSAywW882iEv8d1GVZREvoc4KgRcmq1/wL
	ly0mjEuU+CPBbrVjb6RLv5q83kfhloIcQYz6z67SeWRfs9iy0ujJXms92c9fYGzGSPYzVR2unPc
	qr2RSgb1d0UdgsB+tMN36dbIcBMo2KhUcuY0B8tVmAGbbA3T3+XDettvRkdTnpQ6iPn1eyFnUeT
	AXMNGXnLFn+eSS//nKcgFK86D07nZKsG3f2keaYYTylFKUgQHVn+XHt6QVlWItj6yNblKCbErJG
	2rPTs1gLM0R67pcKtQyl8v5XSwVIzaKCVVUDjfU2exCCGTFf6iZ6oNoCImz1pG9yN/4d0ZqFUph
	5t7NM8Q8rP5Uk1KYJszQVK+0AIlhjCsCNZEl3i3ILtARIhOxzntGwKy4PW+x5p53rDBld4qKLNa
	W8uYehQNJa4ZmZbo03p/ZBORQM5qqfaWDZgU=
X-Received: by 2002:aa7:930b:0:b0:8b5:f9b1:a8cf with SMTP id d2e1a72fcca58-8c87d32a732mr21318565b3a.51.1795710471016;
        Thu, 26 Nov 2026 08:27:51 -0800 (PST)
Received: from cchengyang.duckdns.org (1-164-86-80.dynamic-ip.hinet.net. [1.164.86.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87343f83dsm11037097b3a.39.2026.11.26.08.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:27:50 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Rahad Bhuiya <rahadbhuiya2021@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kang Chen <k.chen@smail.nju.edu.cn>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	sched-ext@lists.linux.dev,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH 7.3.y 1/2] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Fri, 27 Nov 2026 00:26:57 +0800
Message-ID: <20261126162700.22257-2-yphbchou0911@gmail.com>
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

From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>

commit 564405c424f49d70b13debe7fe5b550234ad6b84 upstream.

Tasks in SCX_TASK_READY are attached to a scheduler but outside the ext
class, such as RT/DL tasks, or non-SCHED_EXT tasks under a partial switch.
The scheduler's BPF code can still update their dsq_vtime and slice (for
instance, via ops.cgroup_move() as done by scx_flatcg).

Because __scx_disable_and_exit_task() currently breaks out of the state
switch for SCX_TASK_READY without calling scx_reset_task_fields(), these
fields are not cleared when the task leaves the scheduler. If the task is
subsequently moved to another cgroup/sub-scheduler and later switches to
SCHED_NORMAL, the new scheduler's ops.enable() sees stale dsq_vtime from
the previous scheduler's clock.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure SCX-managed fields are properly
reset when leaving the scheduler.

Fixes: 5771e79e461e ("sched_ext: Reset dsq_vtime and slice when a task leaves SCX")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ chengyang: 7.3 lacks scx_reset_task_fields(), so factor it out of
  scx_disable_task() ]
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 kernel/sched/ext/ext.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index cc8d09924fa1..1049a0914d60 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4159,6 +4159,27 @@ void scx_enable_task(struct scx_sched *sch, struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 }
 
+/*
+ * Reset the SCX-managed fields when @p leaves the BPF scheduler's control.
+ */
+static void scx_reset_task_fields(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+
+	p->scx.dsq_vtime = 0;
+	scx_task_slice_ended(rq, p);
+	scx_set_task_slice(p, 0);
+	p->scx.reenq_cnt = 0;
+
+	/*
+	 * If @p is runnable but not running, its wait started at runnable_at,
+	 * which ops_dequeue() didn't reset. Leaving the scheduler ends the
+	 * wait. Reset runnable_at the next time @p is enqueued on SCX, so that
+	 * the watchdog doesn't count the time @p spends elsewhere.
+	 */
+	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+}
+
 static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 {
 	struct rq *rq = task_rq(p);
@@ -4172,22 +4193,8 @@ static void scx_disable_task(struct scx_sched *sch, struct task_struct *p)
 		SCX_CALL_OP_TASK(sch, disable, rq, p);
 	scx_set_task_state(p, SCX_TASK_READY);
 
-	/*
-	 * Reset the SCX-managed fields when @p leaves the BPF scheduler's
-	 * control, after ops.disable() has observed their final values.
-	 */
-	p->scx.dsq_vtime = 0;
-	scx_task_slice_ended(rq, p);
-	scx_set_task_slice(p, 0);
-	p->scx.reenq_cnt = 0;
-
-	/*
-	 * If @p is runnable but not running, its wait started at runnable_at,
-	 * which ops_dequeue() didn't reset. Leaving @sch ends the wait. Reset
-	 * runnable_at the next time @p is enqueued on SCX, so that the watchdog
-	 * doesn't count the time @p spends elsewhere.
-	 */
-	p->scx.flags |= SCX_TASK_RESET_RUNNABLE_AT;
+	/* after ops.disable() has observed the final values */
+	scx_reset_task_fields(rq, p);
 
 	/*
 	 * Verify the task is not in BPF scheduler's custody. If flag
@@ -4213,6 +4220,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.56.0

