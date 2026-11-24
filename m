Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795529547;
	b=1ekkQVnhvbrjwJyxoMi+l8qUiOdXEKLpbHRAArqfqOz+X2wj2oyploahnE63GOvHsu25
	 LezvV9JWg4rKL0awLjBvZ3A4wKcvT3goV0iaDQ0KXlh7hwC9uSnLlnzXQVYped8yYu837
	 cAH/6fu5qKyp7qj9L7CMxQWJHGwLvh7Fwr2BxkVXgHyznr5JeKjbuMZFdpqkcPBd5QmfY
	 U9z5/qPTUp9CtOAWdRRD4RFRMQy2qLQDKxkG7gKvhIRiCWsGiBd14oPvmhtRFezCANhJQ
	 F3YRPpUhD4KDt0ExUt3YZDTtRBdgEzKo5jtJxN5NT9yljMPwrMUmyk0q0mvIrlB393w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795529547;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
	b=g2urFQUeOdUvCwA3ucJGCn2MyunaMQz+uYC+2oEHFNvPk/JXfZKCbyrME5VCybA10Lfu
	 2xJXHuxyAz3cv/F7svlQOaS49mhVk4GXb7ZiULM/skBRSxr8LflzobfGXbELXAzw2xuHi
	 eBtIf37BhkQMbS9Kl1AoZj8hVhCxRccy+qmb+RvcswIgW2yuRDB3ixlxHy8i2L21Fx9pI
	 B/zM3rXswELRGIpUw0x3OwvVJwz7TrrGfnzPIhK7C0OKNrOwsB5IEsYGm3pPIqYchqRKc
	 dZxLqF2pSjLwy9tcK7vRXFQ5zb/bLZRxt5E7E7FMBLfS/UnRLXeGerRitmm0z4xAfuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=uis4V8ye;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340E606A33A
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B340E606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=uis4V8ye
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6ba38c41804so5230081a12.3
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 06:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795529545; x=1796134345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
        b=uis4V8yeb/qTxc4bubBEs9VnJacXPlg5J02zHhTig087RA5WXyILFdTLn2SfWRbo9z
         RJwUc9CLY0tElT8DvuxOGHTJBwt/N5M+Xhu8LMPBaucPYnR5z44cSgsceeY7wI2G7ttX
         Gx/FDKOeqpKaHyS8qZ6wCzwqjG6ZJL00hXDv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795529545; x=1796134345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=phUozZ9UmERABn/pPGUaQNiwGGv5ztLQHvi9xNV+FYI=;
        b=fcEfP0UmqpOTsA3A1XY/dKvih1yoa0jTEKoWPJMN28mwDXjDHvVTGlWWcC+fDbLVRb
         Tt6BU9MgEquN+eU29CE5Tx3wIbrp3aX70nAvG/sbsW1/25HZfqM4tgZS5Ixfp1ETeFvP
         ue0duMxIFnHDMw+LGmtHVsJaY+FwCD9kO4fCWMEDxa4ZdKivlguULX9CHzQUZ9ln35KY
         NAr7o8aygQVJPaSRJiK86xqR42Ux8XWMSri+qYd1EKHEitN6GqTDd0ubzXYr9lWtnz9Q
         bqeBZ1HBkb2NUHqGVVBCH64tSKr2ZEbS7tEqbWHTBuOw/yMVl81P1vQC727A9YZEBX5U
         nGXQ==
X-Forwarded-Encrypted: i=1; AL+hErHRpIm5GQSVK1/5wXQ6YbPjm3m9VivUAzNP7FGLmdB72VbO0QWfL5y0Mi1ss/qC7PZ5eg0efrY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9lCT5UafGgdKQmYliSQ82QodJg67eWHMcvDqpFfMkvtFLbVNSd
	zRQXxvfUF4o9BIBHRD8k+0YScmAXAFqMRbidvLeJKVfVU510d5zDR3WhJT+d2D0L6A==
X-Gm-Gg: AZFdTZdWiYTizpOIH/vZqOh6JUb7vtkdmWpxseJ4Y4ANsPxB1UVqNvng6tzKyK0r/iM
	nT6pkwc9V+P7R8eO9IdyTG1VLCvF4NDHwsNcs3AcmqRWXhLfTTutR6JfvfUYx/tWr0We4DjQ8K+
	2KHCgOqm2KLig5UoGvEwntZQFO44GnIJRWYzaIyASM2AhI/3W6Jizz48GtyHPzhlKmsAMHEOZqY
	W8NpyfwX1vW6cDmSmXT3yowswNes+P39GdUTbG81r02NJVv5G4U9UN1+jElQ55nakAgSUQ+Hzn0
	R7e7EHhtbKnMujU0dv4Nb07lWZ4H5/fU4YCzVPsao0frewwkbxOUBiuzD07VgoBTF1fn4qYn69x
	spYhUbZ38Hb57AEJHaRcrtf7g2QdbHbwSX3qJjZ0FzfEE+6NLmMA2m6mhG9XpDR0HGQ0tdW8tZ8
	6d1zt2gK1gYgiN2sMJGOTiTUgM2b6boowjMmAmEYsCEXENDd72aaMwgCm6ht0VyXc81Feh2G/FN
	uiE5vYaXc/2Z4laKdzgR95v//et30PRdUQBeK25t1Nifb1ZCIsmIObciE+JdmNpd3oRMdBpQ286
	1j2LMi1iwPIhJaNye2D02smVIJOrpRhecTAQuKKBfYYMo4Q1emDB19pUASLUc171o68Ys+N5ZSC
	YVkVs9knvoUNPSlGld6kl
X-Received: by 2002:a05:6402:210e:b0:6b8:50e:3bb0 with SMTP id 4fb4d7f45d1cf-6ba37ec6490mr11204252a12.43.1795529544904;
        Tue, 24 Nov 2026 06:12:24 -0800 (PST)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba7b9570e9sm5032739a12.36.2026.11.24.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 06:12:24 -0800 (PST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Victor Nogueira <victor@mojatatu.com>,
	Po Liu <Po.Liu@nxp.com>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries shorter than 10 us
Date: Tue, 24 Nov 2026 09:12:09 -0500
Message-Id: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
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

This is a followup of commit a51c328df310 ("net: qos: introduce a gate
control flow action") as reported by Sashiko.

The issue:
fill_gate_entry() only rejects an interval of zero, but that interval is
the period gate_timer_func() re-arms the hrtimer at, and a few
nanoseconds is below the cost of servicing one expiry: the next is due
before the current one finishes, so the action holds a CPU in the timer
softirq for as long as it exists.

On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a core,
2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to a
few percent and it reaches zero by 100 us.

The Fix:
Require at least 10 us per entry.  An act_gate schedule is not tied to a
device, so unlike taprio there is no frame time to derive a bound from;
the bound has to come from the cost of servicing one expiry, with room
for a kernel that services it slower.

On a 2-vCPU guest one expiry costs a few hundred nanoseconds, so 10 us
sits 25 to 50 times above it, and that margin is also what holds on a
debug or PREEMPT_RT kernel where the cost is a few microseconds and a
floor at the 3.5 us knee would slip back in.

That is what the withdrawn 100 us taprio floor got wrong.  It refused
schedules that cost a fraction of their own interval, a 250 us cycle
split into four windows among them, on a margin over the measured cost it
never explained.  This floor admits those windows and states its margin.

The interval == 0 test is subsumed.  A change cannot bypass the floor: a
change carrying a list re-validates every entry, and one without a list
copies entries the running kernel has already accepted.

Some context:
The request that reproduces the cycle-time stall also carries a 1 ns
entry interval.  With the cycle time derived from the entries, that alone
sets a 1 ns timer period: the report covers both defects.

Conditions to recreate the bug:
CONFIG_NET_ACT_GATE=y, and CAP_NET_ADMIN in the initial user namespace
(netlink_capable() checks init_user_ns, so a user namespace of its own
does not help), in a new network namespace:

  tc actions add action gate index 1 sched-entry close 1

The action is accepted and the CPU running the timer softirq stays busy
for as long as the action exists.  An entry of 10 us or more still
installs.

Fixes: a51c328df310 ("net: qos: introduce a gate control flow action")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_gate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 4835f6543901..797562dbde69 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
  */
 #define GATE_ENTRIES_MAX	1024U
 
+/* An entry shorter than this lets the next expiry land before the softirq
+ * servicing the current one can finish, so the timer stays permanently behind.
+ */
+#define GATE_MIN_INTERVAL_NSEC	10000U
+
 static ktime_t gate_get_time(struct tcf_gate *gact)
 {
 	ktime_t mono = ktime_get();
@@ -199,8 +204,10 @@ static int fill_gate_entry(struct nlattr **tb, struct tcfg_gate_entry *entry,
 	if (tb[TCA_GATE_ENTRY_INTERVAL])
 		interval = nla_get_u32(tb[TCA_GATE_ENTRY_INTERVAL]);
 
-	if (interval == 0) {
-		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
+	if (interval < GATE_MIN_INTERVAL_NSEC) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "Entry interval must be at least %u ns",
+				   GATE_MIN_INTERVAL_NSEC);
 		return -EINVAL;
 	}
 
-- 
2.43.0

