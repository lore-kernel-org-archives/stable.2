Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529544;
	b=VdL0xA5xDRxDoyPKEMKFPFnNvViixomqLKTf7M7alCb1uSgWnoG4hek9VuxQVrXWhFc9
	 QqPq2ADNml2WgjSQgndg2k1EGj15ebMLdMOpFnK29ePRON2OkNEiMqk+6InkiYh7O/of6
	 +bDnpmTeYvqwoxulyl4meFru4zunStyqiboX9hVUSVoLYykalic7st/HubCvzoNsdkQ1w
	 KEvI9mr/FLKhfl9dSONzuBAk2N/6fLssz3bdKwxb47EWB85RZM6J8IsL9w431w/ifDSuF
	 fBP3flOzbobBcs18NcZO8wvIEpgilq7MqwAj/Drk94/6ztN/nKMF2zkopEZ/idfB4IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529544;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EovoqaRDTWnD9Kr5EZXAP4uK3lXAaBTnVe0iFSjrQkw=;
	b=eLdZZXSu3IHN0WqWRVMizn42zasonXajYrtywUhF/y28+32yP4Oz4HFUEg1Hn7kYZNNc
	 j1jKM+ceaZo9Wl9R9+T8pLQugpDrh85AMLJVL9iwVvwNGOqELobMeOXllh53HOk19mWCP
	 mfygCUmAROYeOD/vOwKB6EAzHoQgzheF8WTFXNNO+2gmejOZkQYPvFRcvy+CXRiFVFOer
	 25vtD27qh/+an9FtHej+cYk3E02OKPZRVHmGmf1j/2+3bpgPOSJhNRF9bw4e6+4+p4vKD
	 0gBUuFMRRxVwW1lGbfo2hPKK7XnnhoExTiKxrpkXfU98h13oDHnFLRSUtPaof+wYMHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FkU25OEq;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA870606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:12:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA870606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=FkU25OEq
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so7276742a12.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795529541; x=1796134341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EovoqaRDTWnD9Kr5EZXAP4uK3lXAaBTnVe0iFSjrQkw=;
        b=FkU25OEqp+wU+Gr7OhSA+5/f5tf3ihA6xs4/0LtvpHQq+ej45VEw6DIM5ft69BqS7P
         hm0CG8GodX1XcLNgqTyw+Y+mNP2rRwrjjrPiyjaT3EHylyL7B5munqnGJGgA7zsnr7nC
         BVQEr5qir30t+vC7LRWxxjiG2tmlYqpV11zwU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529541; x=1796134341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EovoqaRDTWnD9Kr5EZXAP4uK3lXAaBTnVe0iFSjrQkw=;
        b=jVTaMH4HtXiUufkPQFuxON5SWg0WM3j+BnD/i24ThZdy4TFRn/2buuHoBAbr2CIGoY
         vpxopXQdwQ1yk4pMZDI+oq0xp1HvwcjWq6cqcbk0GVYGUv6tyL5RvhfiT9HM9+VnJmx7
         IQk72yU+QqVmuyVQA4XkIgCRXtkHyy7tpqjEF7NmtYbPK9JJyzfiy9aKhPQ9BcJFlNPe
         vbBDgqkXkk+fgd3+uLr46ZUVIrU5FacztMGgsR/QbFNgvlO2Hb6oIVdFr8FmOVOJMRZT
         XW6J1gvwdeYhNiJZwNvdSWix9fhPXLWT5XrsBkQR3zE+uR/DU1KmnMkSjH33f/DTQSKI
         6ERw==
X-Forwarded-Encrypted: i=1; AL+hErGgeobIE8HZqdM+w45nPChNR4CD9kr7sCsowiKrEXpDLArQ6jrnRhrr6aIDLnBTMxkE1PggDEY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bYutIW8TL12xPO7uGJS+ZDWtk1VvbENtTwZELojLbg+5HXVNn
	FZUbbz5vD/G7zK1Y5NowPkBbjsljS6agu/Olz2zBcvPX0k4V4hCQtSZZd/zOvdrZ+Q==
X-Gm-Gg: AZFdTZcpZJKPCPjzYaqrxlD9/WrRbNHfyd2WNguwmfgGxmFOyfUTwQsWt6OZPHekX/9
	ly2a1Lzg4tDzwXh9RU0BmOHSqRqQnZBs8kp4u+U8yrZ7jOrUp5q26Pt6ETTa5rF8lJJg3qnk28O
	i4IZDFbK//YdBtIhrfMONa1AyPEbdAKHkmUGvIQUqrfyuH0fJWq/mzleCOAdFK/3/ptG2ut6EUE
	4nzt+aTERKeXvYTnkFt/CFHRCnHPZCoYYxKeb98sQvhTtkUHzqerht7Gt1NoID8klaUxdfUxu7p
	kBzeRgmRgpoubVBtCRC/M87n+wPCTbNpfTZeNryrep3jt8KdjV4Ewb/nnzClu1fV1+FtsjNFdzt
	rM1lNj3kcLUZaQwJdhAjAcbP7aNIZpT0MueOIQweaLzZfaognZTc/qsz3FhYfqCGtEG0fgKuQt1
	i+I2Q/RwO5nl3FFFi2fsbJt+2HtRgPpBq6A9quEoWbzi/irCet0bo5yUDbjxO+TzP+N88HYcEeI
	xniu1dQMtIm/dBngF/l2v9lcI06hUeinto4VsKrLc+JQsv+N7vw9oJS987bv/CnYBmJ120R1Y2v
	GE04/g3ZdsKizjEvS5Z5K4S59GJEcbrXsLO2z5cxS4PyNUcPvMWzLUBy9GDV0TOjC9OsxYpkzfM
	=
X-Received: by 2002:a05:6402:3225:b0:6b8:6d59:5f2d with SMTP id 4fb4d7f45d1cf-6ba37e6e1f1mr12466615a12.31.1795529541297;
        Tue, 24 Nov 2026 06:12:21 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm5032739a12.36.2026.11.24.06.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:20 -0800 (PST)
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
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Po Liu <Po.Liu@nxp.com>,
	stable@vger.kernel.org,
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com,
	shaos <shawnq1@163.com>
Subject: [PATCH net v4 1/3] net/sched: act_gate: bound the cycle time and start time arithmetic
Date: Tue, 24 Nov 2026 09:12:08 -0500
Message-Id: <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com>
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
TCA_GATE_BASE_TIME and TCA_GATE_CYCLE_TIME are u64 attributes read into
a signed ktime_t, so a value above S64_MAX turns negative and the cycle
arithmetic that follows wraps instead of saturating.

With base_time = 1 and cycle_time = 0xffffffffffffffff the computed start
time comes out as 0 instead of the next cycle boundary, so the timer is
armed in the past.  Every expiry recomputes that same past time, so the
softirq never finishes and the installing task spins inside
_raw_spin_unlock_bh() until the watchdog reports a soft lockup.

Reported by syzbot and independently by shaos; the request below
reproduces the stall in our test environment.

The Fix:
Cap base_time and cycle_time at KTIME_MAX in the policy.  Both keep
NLA_U64 and 0 stays accepted, because a 0 cycle time means "derive it
from the entry intervals"; TCA_GATE_CYCLE_TIME_EXT does not drive the
timer and is deliberately left unbounded.

Work out the part of the cycle still ahead of now and add it with
ktime_add_safe(), so an unrepresentable expiry saturates in the far
future instead of wrapping into the past.  gate_timer_func() reuses that
helper, stores the boundary it computes, and restarts the walk at the
first entry: the next expiry measures from the boundary that was armed.

Conditions to recreate the bug:
CONFIG_NET_ACT_GATE=y, and CAP_NET_ADMIN in the initial user namespace:
tc_ctl_action() tests netlink_capable(), which checks init_user_ns, so a
user namespace of its own does not help.  iproute2 parses cycle-time as
__s64 then through strtod(), silently rewriting 0xffffffffffffffff to
0x8000000000000000, so tc cannot produce the input.  Build the action as
a raw RTM_NEWACTION message instead: index 1, TCA_GATE_BASE_TIME = 1,
TCA_GATE_CYCLE_TIME = 0xffffffffffffffff, and one schedule entry of
1000000 ns.

The send never returns and the CPU stays in the timer softirq.  With
softlockup_panic=1 and watchdog_thresh=5 the kernel reports

  watchdog: BUG: soft lockup - CPU#0 stuck for 13s! [poc:832]

with tcf_gate_init() and _raw_spin_unlock_bh() on the stack, then
reboots.  The same message now fails with -ERANGE.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Reported-by: syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0054fed3dc9085390f51
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/netdev/20261022144732.61188-1-shawnq1@163.com/
Link: https://lore.kernel.org/netdev/20260827191547.4004973-2-kuba@kernel.org/
Link: https://lore.kernel.org/netdev/20260827121751.33dac8aa@kernel.org/
Link: https://lore.kernel.org/netdev/DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com/
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3 -> v4:
- Bound base_time as well as cycle_time, and bound both at KTIME_MAX
rather than S64_MAX: bounding one attribute's value does not bound the
start time the timer is armed with, and the v3 range still computes a
negative ktime_t for some accepted pairs.
  (Sashiko review of v3, forwarded by Jakub Kicinski)
- Keep NLA_U64 for both attributes and carry the range in the policy,
instead of changing the type to NLA_S64, and drop the unrelated
blank-line hunk.
  (Jakub Kicinski)
- Saturate the start-time computation, use the same helper from
gate_timer_func(), store the boundary it computes and restart the walk
at the first entry.  Bounding the inputs alone does not stop the old
expression from wrapping, and a boundary recomputed from a later now is
not the boundary the armed timer was measured from.  The shape is the one
Alexei Starovoitov sketched on the syzbot stall thread.
- Add a 10 us floor on the schedule entry interval, derived from the
measured cost of one expiry.  The tdc coverage pins both sides of that
boundary, the refusals, and the largest accepted base time and cycle
time.
v2 -> v3: reject an out-of-range cycletime through the netlink policy
instead of a runtime -EINVAL test.
v1 -> v2: reject an out-of-range cycletime with -EINVAL instead of
clamping it.
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
2.43.0

