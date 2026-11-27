Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795779824;
	b=SemNQyWnad0DHzpY4BJczk0FnEdDkSoQXm9kJiQ3pZE1dM7t/dkjQo++PSiBiKML6D3d
	 AmealEV8xRMWrF1PrWqLW39aoGS9R2Fcato/IbkchvYYcg45j44DATZj0bP+hhFj/WN50
	 UlpdvJmkktcMC6mNubw6bUpB14NGPtlpP6K3BOFiGCK/GUkvpeTFunIaP8Y0o4Qu23J7B
	 1pClvILRF5sZAdHTkzbVmaUb0I/zLFcwhddbxrDRN6QRh5nC8w8zNaiHdjrtlFi/cvaYD
	 RIKdRbvRNyOOHd+SMg0raQT13swgDZNWODfXRk53mlBGlhCMDFHdLSkfXifEx4L/lXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JfxRl6ryEk0iwVbD04Ub39VkD0Z3xzoRKlXr5gXHJv0=;
	b=B3IKvOHbvw+KT0/0ROUjbKwk4/YiddNRzV0hhOypYPpu/KB1LUeEuirgt2OBPIpYDQ9n
	 CFkDhtajSGd1el/CgrcTAeW0Io9mRtDbKAtY6sRMW0yQdoTNvzTUKBMnx6bhDn97V5vWw
	 GgxPLaXEnuYtSewR/w4WgI5tMLkmRvoZMsB+lYvFt3si/QSOoB/ylSs43Xy7B93Y1megZ
	 GEym63yvSoEA5hwq6NUQ+VtZeWiNhChkKOQSlCIf3VOGOYKhNay8BYiJvvLpqxI0img8i
	 03SKUfg1kgnDPsx3ZAiYltRgq6lnt03NmUAq6PexVY0Qa+fzIORcgJ3Lf6uI9SFQL7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jCR84be7;
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B606A330
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A359B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=jCR84be7
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-55d6deecef6so79916281cf.2
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795779822; x=1796384622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JfxRl6ryEk0iwVbD04Ub39VkD0Z3xzoRKlXr5gXHJv0=;
        b=jCR84be7XA8oSEuPkLrJ+XhPbVZu3iN0q0fVhNVcpnJU9K4EwSBv+f9660N+nsGW0s
         lWriJt8LrZ9Q2yCi3lOftj9TIcDZ6lQo73wYpRhmVzJu4szkB/qOStvd/kQ+F//YLZws
         UCo+z7V/AnfLLtTfj0bAABKZ52lgqS0GNPxwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779822; x=1796384622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JfxRl6ryEk0iwVbD04Ub39VkD0Z3xzoRKlXr5gXHJv0=;
        b=wjVpnCy92vGsW7nEGvy1601laLLtFSRe+2PH8girpSatbvx1lBr7tJrCoQnJJTI8gt
         /FhFPWRifCuS4DkDvrDsTX4FdNQ+Bs8XjOx8T3GQFDwUZuZOM2wT5h43xV4jK7dBIamx
         4YZxfqNnf49kL5CcXT4+kbdcCRIIZAi0gT4V23wW0Rw8W7W0GqBYI4K140FF9GB+7mnS
         /psOC3fs+vF+vUVzQsPFIkaTiAHpL4Xb4bMpAW+2UX/O91unjl2JwFeU4mhghCEn4FlQ
         1IIOJSb2m7J+MoA6BXPDP9BsILUUfeYJ1JWEsbx84NsSfpkWBiSNuAxuO7yApRJPfPvJ
         B4vA==
X-Forwarded-Encrypted: i=1; AL+hErFl0sHJpW6D3Wkg5A/hLT1+TdWJRhXM7pymApkDeAwA+bAUVbZT5BYl+f6DS7VuVprJrO97TJ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/D1/Kqq5mFP8TAxyQ2LIKW7aBl6cUVpBA7ub2eddcAyl4g9c2C
	2Dpx9XzOx8E9h+54UtABin6Up8Gml68gpBsf3XOyAiduj7r5DwXJWO6K2+7t/APZIg==
X-Gm-Gg: AZFdTZci60syxhTyNWK61QI3YQ3mzUOF2tsjvnmQJAmID7tg73jsfJ/0kwkeFZF1E7m
	1gPb/RX3Uy/mzc0lmTrZwV1xy2+3JvbeBJtMHPW/LCrBkqbeVx2tg+RFmDISnilpy+nlvjlwCTO
	nDf0vLaW7frP1Z7d3mw/AMQrGDVfousTUpCrr1dgifhFUvmE9u9WSUt5iAf+ES7VC6WUzT35BZX
	0+oMHcrYcdBf98dQmrjwmqyiUAOc0DC5ZmfvbBuoX9kjfDAwPN0e7Gns8yqV8IwnBbcWXitlYLv
	kXHMdy32pePUMwtJdmd7V33un8IawpBAOyW5qDsHwLSi1fIbzWcxjHF7xTyGI/R4Me1VrEQvXIi
	FJs0zYUH+BmuED3acciRdZ3u/oEW3F0hbw6iofZR1Dc5aN7JH/n4vyDXFLUeeTLQxW5js6NZoZq
	GstQ0lnx2AQ911J4Uzs8XpwLF+9+8/uXByygjsiwCrfQTIyE0Db8TRhma0s6XonLRX9sbX+7RUh
	Saxfi0eMG4x6hvYmKI+Wr6cM9MsG1Hg1Pf3W+4zP/c6EZOVLzn0Z7kAWDHE6VTTLx1ez+hQLudX
	WSNT81gwWmmQd0l2NjtCfZg0ZtomcHlzCnZhIYKIzDiWvYTC0qCQPs55Abm1bT+Iq/NUWIh87gv
	PnZVX9/hl22q3jDk=
X-Received: by 2002:a05:622a:413:b0:55d:3347:8138 with SMTP id d75a77b69052e-55d76a5c564mr448911711cf.44.1795779822454;
        Fri, 27 Nov 2026 03:43:42 -0800 (PST)
Received: from localhost.localdomain ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55dcdd1a2c6sm16652551cf.20.2026.11.27.03.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 03:43:41 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	shaos <shawnq1@163.com>
Subject: [PATCH net v5 1/2] net/sched: act_gate: bound the cycle time and start time arithmetic
Date: Fri, 27 Nov 2026 06:43:34 -0500
Message-Id: <ACT-WEXM.v5.r0.20261127063407-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-WEXM.v5.r0.20261127063407@mojatatu.com>
References: <ACT-WEXM.v5.r0.20261127063407@mojatatu.com>
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

The issue:
TCA_GATE_BASE_TIME and TCA_GATE_CYCLE_TIME are u64 attributes read into a
signed ktime_t; a value above S64_MAX turns negative and the cycle
arithmetic wraps instead of saturating.

With base_time = 1 and cycle_time = 0xffffffffffffffff the start time
comes out as 0: the timer is armed in the past and every expiry recomputes
it, so the softirq never finishes.  Neither attribute has ever been
bounded, so one request stalls a CPU on any kernel that has the action.

Reported by syzbot and independently by shaos; the request below
reproduces the stall.

The Fix:
Cap base_time and cycle_time at KTIME_MAX in the policy.  Both keep NLA_U64
and 0 stays accepted (a 0 cycle time derives from the entries); the _EXT
attribute does not drive the timer and stays unbounded.

Work out the part of the cycle still ahead of now and add it with
ktime_add_safe(), so an unrepresentable expiry saturates instead of
wrapping into the past.  gate_timer_func() reuses that helper, stores the
boundary it computes, and restarts the walk at the first entry.

Conditions to recreate the bug:
CONFIG_NET_ACT_GATE=y.  The action can also be created from a filter,
where the only capability check is netns-scoped, so a user namespace of
its own is enough:

  unshare -Urn
  ip link set lo up
  tc qdisc add dev lo clsact
  tc filter add dev lo ingress matchall action gate base-time 1 \
      cycle-time -1 sched-entry close 1000000

iproute2 parses the attribute as a signed 64-bit value, so -1 reaches the
kernel as 0xffffffffffffffff.  The raw RTM_NEWACTION path also tests
netlink_capable() against the init ns; the reproducer writes those values.

The send never returns and the CPU stays in the timer softirq.  With
softlockup_panic=1 and watchdog_thresh=5 the kernel reports

  watchdog: BUG: soft lockup - CPU#0 stuck for 13s! [poc:832]

with tcf_gate_init() on the stack; on the fixed kernel both requests are
refused.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Reported-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0054fed3dc9085390f51
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144732.61188-1-shawnq1@163.com/
Link: https://lore.kernel.org/netdev/20260827191547.4004973-2-kuba@kernel.org/
Link: https://lore.kernel.org/netdev/20260827121751.33dac8aa@kernel.org/
Link: https://lore.kernel.org/netdev/DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v4 -> v5:
- Split: this posting carries the regression fix and its tests; the 10 us
  entry-interval floor and its cases moved to net-next.
- Conditions: a filter reaches the same code with CAP_NET_ADMIN in a user
  namespace of its own; the earlier text claimed the initial user namespace
  was required (reported on the list).
- Changelog: KTIME_MAX equals S64_MAX, so the bound is the same value the
  earlier policy carried; name what removed the wrapped start time, the
  base_time bound and ktime_add_safe() (reported by Sashiko).
---
 net/sched/act_gate.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 711cf2443540..4835f6543901 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -45,8 +45,8 @@ static void gate_get_start_time(struct tcf_gate *gact,
 				const struct tcf_gate_params *param,
 				ktime_t *start)
 {
-	ktime_t now, base, cycle;
-	u64 n;
+	ktime_t now, base;
+	u64 cycle, rem;
 
 	base = ns_to_ktime(param->tcfg_basetime);
 	now = gate_get_time(gact);
@@ -58,8 +58,8 @@ static void gate_get_start_time(struct tcf_gate *gact,
 
 	cycle = param->tcfg_cycletime;
 
-	n = div64_u64(ktime_sub_ns(now, base), cycle);
-	*start = ktime_add_ns(base, (n + 1) * cycle);
+	div64_u64_rem(ktime_sub_ns(now, base), cycle, &rem);
+	*start = ktime_add_safe(now, ns_to_ktime(cycle - rem));
 }
 
 static void gate_start_timer(struct tcf_gate *gact, ktime_t start)
@@ -94,8 +94,8 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 	gact->current_entry_octets = 0;
 	gact->current_max_octets = next->maxoctets;
 
-	gact->current_close_time = ktime_add_ns(gact->current_close_time,
-						next->interval);
+	gact->current_close_time = ktime_add_safe(gact->current_close_time,
+						  next->interval);
 
 	close_time = gact->current_close_time;
 
@@ -108,13 +108,10 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
 	now = gate_get_time(gact);
 
 	if (ktime_after(now, close_time)) {
-		ktime_t cycle, base;
-		u64 n;
-
-		cycle = p->tcfg_cycletime;
-		base = ns_to_ktime(p->tcfg_basetime);
-		n = div64_u64(ktime_sub_ns(now, base), cycle);
-		close_time = ktime_add_ns(base, (n + 1) * cycle);
+		gate_get_start_time(gact, p, &close_time);
+		gact->current_close_time = close_time;
+		next = list_first_entry(&p->entries,
+					struct tcfg_gate_entry, list);
 	}
 
 	gact->next_entry = next;
@@ -173,13 +170,20 @@ static const struct nla_policy entry_policy[TCA_GATE_ENTRY_MAX + 1] = {
 	[TCA_GATE_ENTRY_MAX_OCTETS]	= { .type = NLA_S32 },
 };
 
+static const struct netlink_range_validation gate_time_range = {
+	.min = 0,
+	.max = KTIME_MAX,
+};
+
 static const struct nla_policy gate_policy[TCA_GATE_MAX + 1] = {
 	[TCA_GATE_PARMS]		=
 		NLA_POLICY_EXACT_LEN(sizeof(struct tc_gate)),
 	[TCA_GATE_PRIORITY]		= { .type = NLA_S32 },
 	[TCA_GATE_ENTRY_LIST]		= { .type = NLA_NESTED },
-	[TCA_GATE_BASE_TIME]		= { .type = NLA_U64 },
-	[TCA_GATE_CYCLE_TIME]		= { .type = NLA_U64 },
+	[TCA_GATE_BASE_TIME]		=
+		NLA_POLICY_FULL_RANGE(NLA_U64, &gate_time_range),
+	[TCA_GATE_CYCLE_TIME]		=
+		NLA_POLICY_FULL_RANGE(NLA_U64, &gate_time_range),
 	[TCA_GATE_CYCLE_TIME_EXT]	= { .type = NLA_U64 },
 	[TCA_GATE_FLAGS]		= { .type = NLA_U32 },
 	[TCA_GATE_CLOCKID]		= { .type = NLA_S32 },
-- 
2.34.1

