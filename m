Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1D0374A0E
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 13:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784641629; cv=none; b=jtcd0MyMTAEfiIAzMiqPaFNVAUxip7KgKbUe/sRC66D2NKTzhdBaPe8aZsAnb0KcdW2bSZ761hL5Puium0LjoANQURD4Lyu4xt4NyhfYDAOxg3ebySUiqh4MwaevZL6b5Pms1Qv8sZkxcH5rsUUGDeDqCqNs1ikMiMBgk/vV6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784641629; c=relaxed/simple;
	bh=LaX1q5VWiR5x0tn/HSIQFSx/gGer/j4SLQAX2ipJwRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WqAYWLgcYUIpOgONLDdmVqjcrFjNXC3sZ1HZhl68fi3Qckn++tU2WQ1g29j8Vo1s2ToFL6S8/0RYZKN7aK+ZfocYioLfsjc0C8ehm4C4utJUOUPTVyOmXn+KZEM5GMUl68EZGux7av5aUDSLsvOdjHJy2U2mQSXAdTnaMUhdwwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UtzJP6FF; arc=none smtp.client-ip=209.85.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UtzJP6FF"
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6986557937eso6726779a12.3
        for <stable@vger.kernel.org>; Tue, 21 Jul 2026 06:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784641626; x=1785246426; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=45zSO8zldnJyRSwb0Rze7jbaf6ih9yPr5w2JS8HwOGA=;
        b=UtzJP6FFatIzPltU9coOb/6Fz4mB8KVZJNriHlIS97E+ul3yZEhlHxzF1iM7wEmxfp
         oF2DQNelHMcEdo6O1mGxN2GUNvP/rtRoMfnalMWqh76sokP570p51iXryYoi29p89D9G
         nmf4itJFZOJ4DaY23DSwodO+mWYU24ayw0q+YUKr2hew/RLeLJgW8zJEdqS4u/9WmvBE
         eWx1eSXsG4y6n/+eYG/nUfaI8udmLZBrTj+jh6WyJqL6NCawSsey2zUTLwVz1ZSDSHB/
         82pXx9xma6h7TBVlYqKy1BKOdcgiR27/wymfZ40+/+X7GII9E4ARFCDHMG713oegEc+z
         1DOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784641626; x=1785246426;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45zSO8zldnJyRSwb0Rze7jbaf6ih9yPr5w2JS8HwOGA=;
        b=nbfgBdmixaI3dOO5JyDTYPGLBYrrt1OczYIWP5j+j6DCk1eQZlzoCuYuceUoiQ8/2R
         KQqAXFGTdg1h5rSNRrFFy2yNBpJ+utwLxz7C/BxDrVAPS959eDR6DEeW135Vzzdl9DjD
         RcT3ZjrmVgAeC0pnj2/rPNnPYk9ZX11DQBnlSK+Ir4ZzgjzfxPzS9wrXppBi/eM1Ldpd
         o2/Nda/mAzbvi3rzcUJC8Ie3Yh+DwroluwT2BVB223jcxoYUcgGejM9MrbazpKlTiIZO
         1nhbQJt40GvYXiIC3mw1LlmD559tLgdMsIx8/IWKOnCFQsDIdXW76SkwLM2shKonYd26
         YDxw==
X-Gm-Message-State: AOJu0YyRTmF+7xyWvqeqlCtzzjEBFwsGQJRMPfBWveTldIbEzEo+5Iut
	G3VnR1HDZCNACGxD8lZEpcXiVZFIul10Cht8AbRRBqcLTbq8Q96/w1oYxwIliSxDMLrQEmD9JBS
	QvW8Xv/QN2F3jPw==
X-Received: from edrm24.prod.google.com ([2002:aa7:d358:0:b0:698:3e8f:5f8f])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:51c9:b0:695:f580:a66f with SMTP id 4fb4d7f45d1cf-69e652ddfaamr6834370a12.21.1784641625618;
 Tue, 21 Jul 2026 06:47:05 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:47:04 +0000
In-Reply-To: <2026072131-citation-reshape-587c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026072131-citation-reshape-587c@gregkh>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DK4AN7P1B5KK.15R8G3B5L5E85@google.com>
Subject: Re: FAILED: patch "[PATCH] sched_ext: Skip ops.set_weight() for
 disabled tasks" failed to apply to 7.1-stable tree
From: Kuba Piecuch <jpiecuch@google.com>
To: <gregkh@linuxfoundation.org>, <jpiecuch@google.com>, <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

I'm unable to reproduce the failure using the steps provided.
The patch applies cleanly. The code compiles and tests are passing.

FWIW, below is the patch after cherry-picking the commit:

Thanks,
Kuba

------------------------ 8< ----------------------------

From adc748e669cc1564255430299abf086b9ecd9b45 Mon Sep 17 00:00:00 2001
From: Kuba Piecuch <jpiecuch@google.com>
Date: Fri, 10 Jul 2026 14:43:41 +0000
Subject: [PATCH] sched_ext: Skip ops.set_weight() for disabled tasks

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
 
+       /*
+        * When switching sched_class away from SCX, reweight_task_scx()
+        * is called _after_ scx_disable_task(). Skip calling ops.set_weight()
+        * since the BPF scheduler may have already forgotten the task in
+        * ops.disable().
+        * p->scx.weight will be recalculated in scx_enable_task() if the task
+        * ever returns to SCX class.
+        */
+       if (scx_get_task_state(p) != SCX_TASK_ENABLED)
+               return;
+
        p->scx.weight = sched_weight_to_cgroup(scale_load_down(lw->weight));
        if (SCX_HAS_OP(sch, set_weight))
                SCX_CALL_OP_TASK(sch, set_weight, rq, p, p->scx.weight);

