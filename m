Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69272431A3E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 18:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236566; cv=none; b=XEjb1gbHVwHH7RB04CIlP0NvTCzmtSrmnpvlp4vNdNF4bNQK08C4GnHZ7XFi/P9GuYO1Rbt3lPF934gjT03Ot/W7HTiZ6Tx361zKPG1y+DYf1mAfn5J5SV18g1Kn7DE0Sya2Iuh+oNwAWe0A+kdlElwgqabxO6BUQ5SZEhc8jh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236566; c=relaxed/simple;
	bh=NinSsXmfOfgPvxnBoe7vC+IiUfHvMJVbWS0gsHPYMJE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfAQ57yHccWVW+9jvvh+H4+UETCNeYJUFOs2uakICCYVgktke/bp9SAD5TBzoLw1HfA0ghknueTL4CEzWh5vMwwQY7iDD78QjTtMbLmRCT4LQthbo8gXLy1uNe8dCMxLmj1+yP5eoMK7m4YGtNQgrFRanXKn4Lx4CvpZCE63P6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=O/aQMIwP; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="O/aQMIwP"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91064d2d54fso9176776d6.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789236564; x=1789841364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRBaZYE5z7xsuSNFqidS68BnKXd+kuHah3BsDyd5EZg=;
        b=O/aQMIwP+urfIINCnlfLfXO/hoNh8ErszlX1Q+0lQJpY0sdW3mInHYoZHtuQHBhjsH
         acaHL/AodHw9nC2rdS1bKQCOw3MkpjOt963X4ur5hUq11YLJLj92A+oCGRZizdUeXDOm
         4mKahZBHkqgTFfRzcpxUFsspLNMfNkRvh3m68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789236564; x=1789841364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRBaZYE5z7xsuSNFqidS68BnKXd+kuHah3BsDyd5EZg=;
        b=N0O7stRTDt7z/WRyDXlRzjfFnluexCWk7Zs+LCyGmOWI9NsK7Cs7f9It1Tq8+GLjJl
         HpNijp0amZ4qImUI4NevAFO2NE+o1rTsvG8DPf1qcGG/Y36Nt8ufo4B0EEN/jQE19qMo
         t8Gf79dlWK7yV5EB6aBVXkbYoxdM6Pd1NGzeDURCeIW81QUyd3mXChf8tVOGvayiehLc
         sNH6B0GNtqkofjrDFodELF9RE33xcVhEfmN/34C/mgtBMtnrrHXEfoeBppwGxFPsi59a
         /7lyyI0Ed+NvbUuKrUCIjdTLK75870W0cADKde9N+IHZ4x/9dTW0EnAF507pNC+gGdZM
         fJDg==
X-Forwarded-Encrypted: i=1; AKwUvBw8zLaI1+K1w3JkYVfC0VOmYEdBpoG5Hvqhu7xToWLeZWP1GDzwqzbCK3m3RjR4Ow/7TLRFY2A=@vger.kernel.org
X-Gm-Message-State: AFuF++m79kJa90RtlOX5vQle2csGJw8te2agdutYfq74G6Z+1QwUylym
	RLuMJJDzzlKvs0p3U8EXtYBYxXPx3+DdVtd/JvelM/uriNyJb394Z1x30jwS1R4PtA==
X-Gm-Gg: AYBFou1oBdO1FpDop1gEaMRy+gvmTK7UIMkjC9aLR/THbk44K1UOg/ATVj78OWUn7tH
	36TnJMCyfm3Rmqx3Mk9zPIxoQeYqA6klcnfhai14OatlVGAOpZY76dTVOFAjHj6my48qLb/Pel7
	mbn49MzWAXhiHYMV+qC7ZYc+sO3C6KBN0HvH3wjFM54TUAPYAFNW6aFe1mFegVUPqfTy3stOmd9
	IWFI5hCwvjDtQvR9GXHo/I+efOe87K6Q/LSDUpvnhqWPSgD0kDeOTF9E4H19WmhIBJpMZmbHAeY
	zPW9cwEuYomz3aQ+aOmA5jwJ7rqT1slolMdxoZZIlWjiUQVWdwO47iaABxUT71gdTAtQ+C8DChf
	0cElx/2X4DmoOftnGq1yy7H0d6crLHA5fV8+JmzDos3/3rwufu2FOMkOISL7OQAAAE6O8M0oYFV
	DLmKkLAHOTTE4rbJR9fMbmT56mGNqymSZh6EqUPbfol2b1AvS02Ak6WDcr9a17nJh6mi+Q5Tb8F
	g69mQa9Bl94Te8V9ljAz+YurBLB8OPK2wezJxBE9N7zU2kzkAaKtlibNAN7m3LKdlbQst/01bC9
	4URFbBwnnWy1jw+KzQrr6+Y=
X-Received: by 2002:a05:620a:2b42:b0:939:16f6:4d01 with SMTP id af79cd13be357-93a03673558mr519299785a.21.1789236564218;
        Sat, 12 Sep 2026 11:09:24 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e811cffdsm549888285a.46.2026.09.12.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:09:23 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Terry Lam <vtlam@google.com>,
	stable@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	hybris <hybris@mojatatu.ai>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
Date: Sat, 12 Sep 2026 14:09:19 -0400
Message-Id: <QDISC-B855.v1.20260911153152@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hhf_change() stores TCA_HHF_HH_FLOWS_LIMIT with no upper bound. A huge
hh_flows_limit lets each new heavy-hitter flow pass the
hh_flows_current_cnt check in alloc_new_hh() and forces a fixed-size
kzalloc(GFP_ATOMIC) per flow under spoofed traffic, for unbounded memory
growth.

Bound the attribute with NLA_POLICY_MAX() at 2*HH_FLOWS_CNT (the
hhf_init() default) and report the rejected value via extack. The
deprecated nested parse is kept: legacy tc does not set NLA_F_NESTED on
TCA_OPTIONS. Configs relying on hh_limit above the default were relying
on unbounded, unsafe behaviour and are not supported going forward.

hhf_init() also ran hhf_change() before setting the default
hh_flows_limit, so a user-supplied hh_limit at add time was clobbered
back to 2048. Set the default before hhf_change() so the configured
value sticks.

This is a follow-up to commit eb56a495f59b ("net/sched: hhf: clamp
quantum in change and init paths"), which bounded the quantum of the
same qdisc; the hh_flows_limit bound is the remaining unbounded knob of
that series' scope.

Conditions to recreate the bug: CAP_NET_ADMIN in a user namespace;
tc qdisc change dev X root hhf hh_limit 4294967295 succeeds and the
value is echoed by tc qdisc show, unbounding heavy-hitter flow
allocations; also tc qdisc add dev X root hhf hh_limit 500 stores 2048
instead of 500.

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Cc: stable@vger.kernel.org
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260822195509.112717-1-jhs@mojatatu.com
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Tested-by: hybris <hybris@mojatatu.ai>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index fc72f825fbd9..5dec1ed969ad 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -527,7 +527,7 @@ static void hhf_destroy(struct Qdisc *sch)
 static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] = {
 	[TCA_HHF_BACKLOG_LIMIT]	 = { .type = NLA_U32 },
 	[TCA_HHF_QUANTUM]	 = { .type = NLA_U32 },
-	[TCA_HHF_HH_FLOWS_LIMIT] = { .type = NLA_U32 },
+	[TCA_HHF_HH_FLOWS_LIMIT] = NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT),
 	[TCA_HHF_RESET_TIMEOUT]	 = { .type = NLA_U32 },
 	[TCA_HHF_ADMIT_BYTES]	 = { .type = NLA_U32 },
 	[TCA_HHF_EVICT_TIMEOUT]	 = { .type = NLA_U32 },
@@ -546,7 +546,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	u32 new_hhf_non_hh_weight = q->hhf_non_hh_weight;
 
 	err = nla_parse_nested_deprecated(tb, TCA_HHF_MAX, opt, hhf_policy,
-					  NULL);
+					  extack);
 	if (err < 0)
 		return err;
 
@@ -624,6 +624,9 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
+	/* Cap max active HHs at twice len of hh_flows table. */
+	q->hh_flows_limit = 2 * HH_FLOWS_CNT;
+
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
@@ -639,8 +642,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 		for (i = 0; i < HH_FLOWS_CNT; i++)
 			INIT_LIST_HEAD(&q->hh_flows[i]);
 
-		/* Cap max active HHs at twice len of hh_flows table. */
-		q->hh_flows_limit = 2 * HH_FLOWS_CNT;
 		q->hh_flows_overlimit = 0;
 		q->hh_flows_total_cnt = 0;
 		q->hh_flows_current_cnt = 0;
-- 
2.43.0

