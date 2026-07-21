Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A953FA5D9
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 15:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646265; cv=none; b=tSwxfHYMYJxB2UoZ6DYxwSYvNjznMtAI/IRCOhavTC/YxzkAqcBHtp0r2CApXIvME/o/DcQ2yzvRd7noYg5HpqtYmWxQelEXw36/yHYjAXIGofplrCarr/hNYAf9UeJ0LHZ5cNFEJRE8hFVfcM1uAxMNDzbYyYo0Hv/u920ZIl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646265; c=relaxed/simple;
	bh=ESBt2axBKrVR0udVQ3Y5ZltJFCjr8Mty7mdhFuyuEm0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opSL8d9q3xSN1Rnyj1U6soAeUpVhh4vTwd6AtYIL709KXa78dcpGaPVmMgBFr6ck8dZChGmooGthqPZHWxVAQ+oZBFo+IVgmhnycwUmFlc5/Swfe9HDe9oIOUiGJBqyT59+4gtlRveWLyHExY0i82LN0tiQ5QkRjC3V3j153oTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nWOkcaDN; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWOkcaDN"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49560dddaa4so11268205e9.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784646261; x=1785251061; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=knCaavhIORphHCroX5A9QpUfpRhRvM7KxVNhbgc74GY=;
        b=nWOkcaDNnvpGiVeM2tyJKVMqubsX5Ve167nMTb0l6b32CJlYIUsUeBAoDajs7FmpAl
         Hggk8CFHHFD2TAlK/rZYNlBcSxlMwYouBNhNaNueXn79AzEWIw6Y1zw/oEkcqGk6VBzE
         82OFyPBYa292FZ5bCVlxC5mnTPs5MrxcjkboKtiscbF1K3xTG+0OltYsUE2UVzR96j6K
         z1Srq8qofiGjJ8rMCQgWnWdoHIDbhhtXtPyRcovGcde85+yboi5UihrLT77X79yegsCw
         Yv0f1DoaCMFFCxh78F6GcVmrXNHbYW5K/6cJK4sLlsdUJkTSWWkxgxEvIomP0Nqe4uzb
         dklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646261; x=1785251061;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=knCaavhIORphHCroX5A9QpUfpRhRvM7KxVNhbgc74GY=;
        b=sjaSkwV6WpH5fMPj+bAEjMHdA1l0K/5uzmNGypj9iJ9F3GMmvwfAega+6yaP5qLGvW
         oAb5+wbFCjcsR+zakA9uLHgO8YKLWT7BtVAk5HGbnnt4yJ6NtwjwBHXnxHc7ozvPiaCr
         6DyJiSBBgEt1u89nIpJVR+puybb8gSxHbHx6YZXtPR5OGRXMTmjASZQd9jozmtfHn5+Q
         kpewRNC6MB1SYWkm+v0UQG407zRWmDraQSuCd1P7A0zDC8VwYNh/MpfmkQGIwCOPdpq/
         Ed7CEvu8M1J0lN0kdgCPWerPEZZiEvkMGR5/XhhOnPtlT2UetXZCiUo49f4bBGXh0jos
         XbcQ==
X-Forwarded-Encrypted: i=1; AHgh+RoFreOGFSFNKbWY9Rt0/yKhwnCjssRs8O2Xo0mmSe0k1YNE7EjRszNZHlEQyO8eY111LQf+TKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBmuRzAh8s2mUUh5wZlP4YFUScj3WfG6TohiffiAx3khker/v7
	ASi2eA93qfFM8wskbJV1zLHMvlfWM3xhItED3fOtFEjUENcF8E10IF3jAhLD6hMT8u4dMunZmif
	AgW/pjvlQadGGUA==
X-Received: from wmpj33.prod.google.com ([2002:a05:600c:48a1:b0:495:4b69:ac4c])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470a:b0:495:69bd:17f7 with SMTP id 5b1f17b1804b1-49569bd1862mr9487595e9.32.1784646260635;
 Tue, 21 Jul 2026 08:04:20 -0700 (PDT)
Date: Tue, 21 Jul 2026 15:04:03 +0000
In-Reply-To: <2026072139-phrasing-scroll-e4fa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072139-phrasing-scroll-e4fa@gregkh>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721150403.3680077-1-jpiecuch@google.com>
Subject: [PATCH 7.1.y] sched_ext: Skip ops.set_weight() for disabled tasks
From: Kuba Piecuch <jpiecuch@google.com>
To: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When switching a task's sched_class away from sched_ext, we get the
following sequence of events in __sched_setscheduler():

sched_change_begin()
  switched_from_scx()
    scx_disable_task(p)
      ops.disable(p)
__setscheduler_params()
  set_load_weight()
    reweight_task_scx(p)
      ops.set_weight(p)
p->sched_class = next_class;
sched_change_end()
  ...

Notably, ops.set_weight() is called _after_ ops.disable().
This violates the expected semantics of the callbacks, the expectation
being that ops.disable() can only be followed by ops.exit_task() or
ops.enable().

Skipping the weight adjustment for disabled tasks should be harmless
since the weight will be recalculated in scx_enable_task() if the task
ever rejoins SCX.

Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
Cc: stable@vger.kernel.org # v6.19+
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6)
---
 kernel/sched/ext.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 5d2d19473a82..8429bebc21a1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3904,6 +3904,17 @@ static void reweight_task_scx(struct rq *rq, struct task_struct *p,
 	if (task_dead_and_done(p))
 		return;
 
+	/*
+	 * When switching sched_class away from SCX, reweight_task_scx()
+	 * is called _after_ scx_disable_task(). Skip calling ops.set_weight()
+	 * since the BPF scheduler may have already forgotten the task in
+	 * ops.disable().
+	 * p->scx.weight will be recalculated in scx_enable_task() if the task
+	 * ever returns to SCX class.
+	 */
+	if (scx_get_task_state(p) != SCX_TASK_ENABLED)
+		return;
+
 	p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
 	if (SCX_HAS_OP(sch, set_weight))
 		SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);
-- 
2.55.0.229.g6434b31f56-goog

