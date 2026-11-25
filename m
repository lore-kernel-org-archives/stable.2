Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639736;
	b=UoOAMCf5qLe1BwrcGBQIz0MdObLuuf77okzJfCYquTXDalyEdY2zVo4c7+bofjBzdjM3
	 hLp6mQi2UoYntzFE37wp8MTfcX4LEHZvoKCcURXSReIDTsDjv0ai4kaYacHAeMraTx9u2
	 bohgCob7YAQQTi+REa4rf55OU5YUD4dxTk1gF2U+5xScSiKkvc+ZCZiwaAKTr0Tn1RwlB
	 etPiYjr+H0vgBB3NA7Zf4DGL4mfQClQwjGoBkh+6GssCNv+7snwBEV/dlYfeW45eeR8gM
	 eWLGvoSJLAB8gA5kxNKlh1SZ65fHdoxRH65wRyJikIRj0NvgQ/HJr8+0gOgChz0JoZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q+068W+2xD4+j1OAnHhDnS+1yL4RhJkPVo+pu0EaQNs=;
	b=dbOlIVoZk3RL/aW+/uvk3v4abhWRQDPi68opvQ/bl8KRE+hqhdRMMhGDoziD4m+11fiu
	 0ks+HhyDLFnbaY1CiBrzCKb9QAffhEmhoXGInXbawDw91yS/13q1WnFTRa78uBe/xRVz0
	 8wAqDkBOEn65ceIfDfCmJqqYnN8QXy5N4iOLlAilsZP6iIQBaBHchyCz5kx73vUTPMs6V
	 ImmKacVDoMclWijw5iYUZy8PyncT4RE4uXdrfepnFqO/3e84Y2aBvsMD7sTNOLym7jeq3
	 zW0+mvGHv90q//SlsJ/CV/i6eSegS15ljoFgOkMCL+8Oxr05+RMNAj4tbDDKL8Z/iuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=trailofbits.com;
	spf=pass smtp.mailfrom=trailofbits.com;
	dkim=pass header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=CW9zVKAt;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3646606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3646606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.a=rsa-sha256 header.s=google header.b=CW9zVKAt
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5053386c88.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1795639735; x=1796244535; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q+068W+2xD4+j1OAnHhDnS+1yL4RhJkPVo+pu0EaQNs=;
        b=CW9zVKAtImhk98ywj0qR/nTojo3KfaibXbVblBTmXfJmQnc6Du6KEV0824RynnAIll
         wB1qKIHY86HGJf80wT9yXXYVYlPvcqYTW3pncS+LOguC2vpLK0JO7eCco0nz1mUWHlqa
         KmwRqnZQtSVGj1byIOqqlgqMWFfLmPAVFHvEzEUE9PAAx1cUG2mHWMnPlcE5V5XZyIXb
         HLpdGUovRvVKyHqNEpeJYb9SdZza7hJLuK5ekNtbxwv0j94Gtj/QqBkiH+CLu40rGCOk
         NVh0coAeJjIdezcLQaKd9+ATBsNISAEk7swhrJRoeQebpgehoS47SDIVXUNTg09nfBtP
         lOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795639735; x=1796244535;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q+068W+2xD4+j1OAnHhDnS+1yL4RhJkPVo+pu0EaQNs=;
        b=L4+O6yHlxcGOcOEk9mPzQ/795kpf9cW3JX7K2tHDglMkT/0GZYoR3qDs1/IRletBrI
         t7nSuBU6m5i74za8d+7CdE2xRB/zI/XgMn8zz2g5CYxzLye+/tkMgF2oCR3l5vh1h/sl
         Uj2f42C3MsZK7kx8fPSIE0zWyctNrMv3PYxzZg+75VvuFHg44UDdQ6gIPTl56d+yzqOy
         6U8QldGZ/mUeJbv8uIohLjXv9MVaNErnSev1Gf/PaZT1rw15IboMA8AK/SaLrxa0+tSj
         44E9WszZkbmODxYpYJ5rMz4qWsuViBrugOl1Gy5vrNvkfCiTdiaddW/6CAWtr+e3r6cv
         jYIg==
X-Gm-Message-State: APuU4Z8iGlRyq1SJVfm/92gAfTEmQZirYhrz1ao1EzuFkRB/ws0+epzC
	GP/onibRP1j1XFW+suUS9kIPAPFeHUKiU68uKCgLpVToeAPEJmy8dZ+06IxH+2s/vtYG39DzWWj
	6wY13NIY=
X-Gm-Gg: AZFdTZdDuV3omKjtKxw8ugTG2b1tObeg3DaXQeFdWmnMfyZRf9T5N+WLkrFNVtGIdel
	+u/iY3M1L+6ST5bxsmwPnTO86m9BQswO2U2KVGvTV2G0QdDttdyW3tH1aslSyNHAr/7Gm6BQ4ZU
	d5PDX46uEkpJ37nlafj+OE59UCL8cVW5PyfH6Y+/Q+aPUXMa31lYm2NrMiwEnPHq9iDt3VjML5s
	a3Q40yWT0nro6CE38pUhHehE6n+HOSMRybif26ryAAnE6ydpgT65w09c/BYDe5i1suAfYTPzXJ2
	jJajI9cHLTR90XYIK39ttXaATYRWOvWPih0w26OKNvMvN3QxW1MKQCh1QGv1ZNIzxIv76e6Tte1
	NFWyq47bDrpNYbsSEw0y7pIN2607yhz4tCmgWophylptYZv1SEGo1yORIkidY/98yn+3ugTSrpr
	zsk6te6nf+8WkLqDJdxr/SD2WvCXxAn+RKBnKp8RuzVta+tE9+A8YRJwtt8mlM2M28smJtnCTUl
	Wl0ngZDIQckiKd/WuBgWjvA57MQACwGnrKf9/rYatq1c36MS5b4OZDi20wSzoL5FCzf7FJOSmyV
	saHdufGM7nSOwhLnSbxxtsroSQmK7IscVwoAuZBng/FpwAWBuRTjmQ6neaMWGDLgh6w/M4Z5uIG
	dYOBA5ztpUZr9ib8J0IRgPMkY2A==
X-Received: by 2002:a05:7022:3f0d:b0:1b5:58d:fd9b with SMTP id a92af1059eb24-1b5568f03b6mr20664947c88.31.1795639734644;
        Wed, 25 Nov 2026 12:48:54 -0800 (PST)
Received: from localhost.localdomain ([2603:8003:6d40:6669:75a7:83bd:63db:baa9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5566c1142sm42891258c88.2.2026.11.25.12.48.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 12:48:54 -0800 (PST)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jhs@mojatatu.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	toke@toke.dk,
	victor@mojatatu.com
Subject: [PATCH 6.18.y] net/sched: codel: bound the dropping loop per dequeue call
Date: Wed, 25 Nov 2026 15:48:50 -0500
Message-ID: <20261125204850.72393-1-artem@trailofbits.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 12 Sep 2026 14:08:30 -0400

[ Upstream commit 7f4a5ec6258fd7c92633ec4b0493fc51166d9398 ]

The CoDel control law schedules the next drop one interval/sqrt(count)
after the previous drop, using the configured interval
(codel_params.interval). For very small intervals the scheduled step
rounds down to zero, so the dropping loop in codel_dequeue() never
advances and drains the entire backlog under the qdisc lock in one
call - an unprivileged user can trigger a soft lockup this way.

Fix in the shared codel code used by both codel and fq_codel:

1. Make the control-law step at least 1 tick so the dropping loop
   always moves forward.

2. Cap the dropping loop at CODEL_MAX_DROPS_PER_DEQUEUE (256) drops
   per codel_dequeue() call, resyncing drop_next to now when the cap
   is hit: the catch-up owed to the loop grows with the idle gap and
   the backlog, which no interval threshold can bound. This is a
   deliberate behaviour change after long idle gaps.

The cap applies to fq_codel (4b549a2ef4be) and the mac80211 TXQ path
(fixed interval, cap only).

The target sojourn delay (codel_params.target) is not validated: it
does not feed the control law, so a sub-tick value is aggressive
rather than deadlock-prone.

Conditions to recreate the bug:
  - tc qdisc add dev lo root handle 1: tbf rate 1kbit burst 2kb limit 1000000
  - tc qdisc add dev lo parent 1:1 handle 10: codel interval 2us target 1ms noecn limit 1000000 (same for fq_codel)
  - unpatched kernel: tc accepts it; a UDP flood under the 1kbit tbf
    soft-lockups (watchdog: BUG: soft lockup) while one
    codel_dequeue() call drops the backlog under the qdisc lock
  - patched kernel: same setup, at most 256 drops per dequeue call,
    no soft lockup

Testing: claim reproducer and interval 2us/3us variants run clean;
tdc qdisc category passes (see the selftests patch).

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Reported-by: Vega <vega@nebusec.ai>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@toke.dk>
Link: https://patch.msgid.link/QDISC-1L5H.v1.20260912080102@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 6.18.y: context adjusted in codel_dequeue(); 6.18.y lacks
  the upstream WRITE_ONCE() annotations of the codel state. The added
  code is unchanged. ]
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please apply this backport to 6.18.y. It fixes CVE-2026-98427.

The fix is in 7.2.8 and in mainline since 7.3. It carries no stable tag
and so far has been backported only to 7.2.y. The upstream commit does
not apply to 6.18.y because of context in include/net/codel_impl.h. The
selftest patch mentioned in the changelog only adds tc-testing cases and
is not included.

Compiled net/sched/sch_codel.o, net/sched/sch_fq_codel.o and
net/mac80211/tx.o for x86_64 with CONFIG_WERROR=y, both on 6.18.65 and
on 6.18.65 with the queue-6.18 patches at stable-queue 42799ba370. The
patch also applies to the current queue (0fdc4475764), which adds a
net/mac80211/tx.c change; that tree was not built. No kernel boot or
runtime test was performed.

An LLM was used to prepare this backport and to check applicability and
stable-queue history; I reviewed the result.

Thanks,
Artem Dinaburg

 include/net/codel.h      |  5 +++++
 include/net/codel_impl.h | 16 +++++++++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/net/codel.h b/include/net/codel.h
index aa80f744826c..183d43c2bd43 100644
--- a/include/net/codel.h
+++ b/include/net/codel.h
@@ -140,6 +140,11 @@ struct codel_vars {
 /* needed shift to get a Q0.32 number from rec_inv_sqrt */
 #define REC_INV_SQRT_SHIFT (32 - REC_INV_SQRT_BITS)
 
+/* Cap on drops per codel_dequeue() call: the loop's work depends on the
+ * idle gap and backlog, both outside our control; resync when exceeded.
+ */
+#define CODEL_MAX_DROPS_PER_DEQUEUE 256
+
 /**
  * struct codel_stats - contains codel shared variables and stats
  * @maxpacket:	largest packet we've seen so far
diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index b2c359c6dd1b..4d5e471472f6 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -93,12 +93,17 @@ static void codel_Newton_step(struct codel_vars *vars)
  * CoDel control_law is t + interval/sqrt(count)
  * We maintain in rec_inv_sqrt the reciprocal value of sqrt(count) to avoid
  * both sqrt() and divide operation.
+ *
+ * Clamp the increment to at least 1 tick: a very small interval (or a
+ * large count) can truncate it to zero, stalling the dropping loop.
  */
 static codel_time_t codel_control_law(codel_time_t t,
 				      codel_time_t interval,
 				      u32 rec_inv_sqrt)
 {
-	return t + reciprocal_scale(interval, rec_inv_sqrt << REC_INV_SQRT_SHIFT);
+	return t + max_t(u32, 1,
+			 reciprocal_scale(interval,
+					  rec_inv_sqrt << REC_INV_SQRT_SHIFT));
 }
 
 static bool codel_should_drop(const struct sk_buff *skb,
@@ -154,6 +159,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 				     codel_skb_dequeue_t dequeue_func)
 {
 	struct sk_buff *skb = dequeue_func(vars, ctx);
+	unsigned int drops = 0;
 	codel_time_t now;
 	bool drop;
 
@@ -180,6 +186,14 @@ static struct sk_buff *codel_dequeue(void *ctx,
 			 */
 			while (vars->dropping &&
 			       codel_time_after_eq(now, vars->drop_next)) {
+				if (++drops > CODEL_MAX_DROPS_PER_DEQUEUE) {
+					/* fell far behind the schedule */
+					WRITE_ONCE(vars->drop_next,
+						   codel_control_law(now,
+								     params->interval,
+								     vars->rec_inv_sqrt));
+					break;
+				}
 				vars->count++; /* dont care of possible wrap
 						* since there is no more divide
 						*/
