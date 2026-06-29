Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FBA3655CD
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728534; cv=none; b=lhiaGbKS953eI/M3X68ISy4aTca1ulI3k1f0oGgQEv/wPKQy/OICaE1XvHYI/emHrErlWwHgqy2qUgD7g7vqWNRpf8oMrFHndsOG/vJhex1Qs8zeGzoaf+A0dOiPV6jPBmivrl9OJMG1IbU2VXduHOMvyFpEV+XjVxX9biyXxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728534; c=relaxed/simple;
	bh=jwLgLR3nYwBK3/BuT+gD2ATqKLN7xJeOS1tgrZOALpE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oTbzU1n2UJN14RZVXIgr8f3gg9BPXTMrP9+CuGhV0D+47c39Zy6fYKDaoKDss4qEDA7EA/zuQSzMF65uv9ChRZqZK46fqT6JZP4Z/vXPG+A0R5rO0rBl/mChG2Lhiz0kFjaAjYLJ25RffsnAHmAk49im6JLzI83yM3J5pPomgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ggLBy4V1; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ggLBy4V1"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8edda5d56a5so29608426d6.3
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728532; x=1783333332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=ggLBy4V1W0LbmCKi/2CazVXEZUlnFpJGI7IpQ8C6hf43LMGWg/y7xDO/AhVIeGzdo1
         dzRfWThPGyMVVqXzjBzn3MXV6fAAhGbtBNGSrW857aOqnM/vmGhwBQGTVuz78M5HnBVE
         NmOVH3a8r94j03HImkuz6qObCE09I1qRiuT+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728532; x=1783333332;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o6OASslZi7YxFlKXAz00T8+s1qFuKwk4pzWc3ZIqweI=;
        b=enOV/QlPDo18tjBV9w36Fu9Y2FqrLoK4kYhgzgXu+9eEUX0nkuxAN3p38YzhNZkOyG
         RmVOX8GI68MraHkFHNsPVR3yNN/Y9bCPisdnQOTSj3dzbLAk2A0nRZsm0WAf8OaQNBCH
         8bdcBhWYCYhTa5vftZwuOx9EIyLxcgRkYwJsxKEMhVs8iNlmU/61fLa1FZkoMDs21HmI
         hiRfGJorhLT6iDxH+L0sgWWT4cOiDzMZmx8pZwnRYsHJPLEo4nGFnffkdTakEDP4o2At
         hsiw6ztwUW4wZ7Rzi9mBazHcBxqgn58I/DcyTaJ0lQSjSkzn4ZKwYiHVvb5Ik4JOy0sp
         tnJQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNzvcevXPUuBau7gQdzsrmOcF2VotVfrF4jI1evi1RqRBEs0HiaC+8L5t3r7tps/KTjgqcl3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYDKtouKVhjsnbQdmDtXFGL1AlPBdpgiJWyLR2ri4g7gGimpYL
	ZXpqpaIrJAfX4HF41X/ZK18fvF8/6lqqBio03DkEBtfWPZB1ULgh0T1wMwzuDq78ug==
X-Gm-Gg: AfdE7cnALxSJtXyrTRBRd299N0Zw5/HKUxm1UTArCiWgibW8y8nh1AGo0iyRXHyrTHz
	5qULFXL6t+uh1CQkEz3JjbDeZJyYThZtV1gyLZmRqK/Z5NDsQZQsUv4uAJ4Lqpu595h+sJXSvzV
	LXbiIwUKsCxtM/+AmmeJuepF1PIsOwBVQGz8uZcWUPaPi43cvezRCRGevRDGTqMg4PHJl46grxL
	Ks2Z3g6q+G8LbETjGYKiJVoC91gdbfZ8/pP6x0CuujONyhYVPCj3gtpRA3ybH5y7B4HT3F+k/iE
	7RcJdE3VdFTFVyM4QeRy0EzSUz3pTuVVLVmFQ70j5iD4zYOXH2NIqYY6yW7TY7I/1cGBn8db7I+
	qebBE4lkWHKqFfAaNHg2lEbvS4bSC8x0Fiamd69E5EylvLzMDc8ManTbcvnneKrVUSPJciQqYyK
	x70oQNOQ==
X-Received: by 2002:a05:6214:194c:b0:8ee:df58:e5c5 with SMTP id 6a1803df08f44-8eedf58e938mr95782096d6.20.1782728532334;
        Mon, 29 Jun 2026 03:22:12 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 0/3 v2] Fix broken TC_ACT_REDIRECT
Date: Mon, 29 Jun 2026 06:21:54 -0400
Message-Id: <20260629102157.737306-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When sashiko-gemini[1] reviewed commit a8a02897f2b4
("net/sched: cls_api: Handle TC_ACT_CONSUMED in tcf_qevent_handle") it
 correctly pointed out the following:

"
This is a pre-existing issue, but does executing a redirect via a qevent
filter cause a NULL pointer dereference?
When tcf_qevent_handle() processes a TC_ACT_REDIRECT, it calls
skb_do_redirect(). This eventually calls bpf_net_ctx_get_ri() which
dereferences the task bpf_net_context:
include/linux/filter.h:bpf_net_ctx_get_ri() {
    ...
    struct bpf_net_context *bpf_net_ctx = bpf_net_ctx_get();
    if (!(bpf_net_ctx->ri.kern_flags & BPF_RI_F_RI_INIT)) {
    ...
}
Since qevents are evaluated during enqueue, which runs within
__dev_queue_xmit() after sch_handle_egress() has already executed and
cleared the bpf_net_context pointer, will this dereference a NULL pointer?
"

That issue is fixed in patch 1. See the commit log for details.

Upon further investigation it turns out that TC_ACT_REDIRECT being returned
from the egress qdiscs never actually worked. When an action returns that
code we would silently loose it and the packet will never be redirected.
After all those years, if nobody complained, my gut feel is it was never
used by anyone with serious need for it.
Patch 2 fixes it by 1) putting a warning out when someone does and 2) asking
the core to drop the packet. At least this would help whoever is
misconfiguring to diagnose the issue much faster.
I had initially attempted to "fix" this and make it work, but unfortunately
it's a bit ugly so i left i didnt think it was worth fixing

Apologies for the shotgun Cc - its what get_maintainer.pl told me to use.


[1] https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

---
Changes since v1 (address 3 sashiko comments):
1)Patch 1: Address pre-existing issue to cover asynchronous qdisc enqueue
  operations in particular if bpf_redirect() is invoked from an attached
   ebpf program (the helper invokes bpf_net_ctx_get_ri())
https://sashiko.dev/#/patchset/20260620130749.226642-1-jhs%40mojatatu.com

2)Patch 2: Explain in the commit message that it is actually design intent to
  remove TC_ACT_REDIRECT from tcf_qevent_handle().
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=2

3) Patch 3: be explicit with $EBPFDIR
https://sashiko.dev/#/patchset/20260626165156.169012-1-jhs@mojatatu.com?part=3
---
 net/core/dev.c                                  | 31 +++++++++++++++----
 include/net/pkt_cls.h                            | 13 +++++++
 net/sched/cls_api.c                              |  6 +---
 net/sched/sch_cake.c                             |  2 +-
 net/sched/sch_drr.c                              |  2 +-
 net/sched/sch_dualpi2.c                          |  2 +-
 net/sched/sch_ets.c                              |  2 +-
 net/sched/sch_fq_codel.c                         |  2 +-
 net/sched/sch_fq_pie.c                           |  2 +-
 net/sched/sch_hfsc.c                             |  2 +-
 net/sched/sch_htb.c                              |  2 +-
 net/sched/sch_multiq.c                           |  2 +-
 net/sched/sch_prio.c                             |  2 +-
 net/sched/sch_qfq.c                              |  2 +-
 net/sched/sch_sfb.c                              |  2 +-
 net/sched/sch_sfq.c                              |  2 +-
 tools/testing/selftests/tc-testing/action-ebpf   | Bin 856 -> 9072 bytes
 tools/testing/selftests/tc-testing/action.c      |   5 +++
 .../tc-testing/tc-tests/infra/qdiscs.json        |  32 ++++++++++++++
 19 files changed, 87 insertions(+), 26 deletions(-)

