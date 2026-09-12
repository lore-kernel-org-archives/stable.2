Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474043AE1BD
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789236520; cv=none; b=DEeqBbUrUgisRvf9ABLB7sohE3L5lZYYVD0IgjiJnD4fQ+Gvp3htqFJPg/kyzbOUr/9LQ2XGzdZGiWZOIe1CGvrKB7Mqvc2Nlvf13XRhKMfYwY0T+kR8X5yg3d4VV0Bzzk9AtZvvgxppxi+H8XasBNs0xjTSZ2LI8afNCW/h0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789236520; c=relaxed/simple;
	bh=YCGNqCzZatBNp9mkN8kezIg2lUy/SNtT8kMkmWxd92Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pg3pmY/KCoffQrFYD3IHRwne6dOW3+5cOdtnS1HhnI7+oRyCkyMj4cUaXxdK9KAMUwMnxqURxu2R+U5QQBAcMc+t3mCrbd/YRVV0WjYurfk8YnKJ5ForX2cZIbiyw5/vWW8lk+WefLdt3goB+4xoQko1ZmocSEh68h+9IVhbtRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mH3CYn0P; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mH3CYn0P"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ef1d1so14141611cf.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1789236517; x=1789841317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShtnYNWVoQX+/xNdTOnJtzhcZz7uw5CPa5C82dT5fA4=;
        b=mH3CYn0P5T/B1Bn68/AD7A9iuWGnFuEXirg0qUbm43pDULGacPtYIqnqLcgFl/NJa9
         CqhbRciQGsfMnqYVfEiKjW4lgQl0n776kNiJ4dx4BLhNmwO5iwFFvOf617ylBzXAaojA
         MXCpIGwQk3EiHdM6Kv8mC0DQmXwlWqyLm6R9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789236517; x=1789841317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShtnYNWVoQX+/xNdTOnJtzhcZz7uw5CPa5C82dT5fA4=;
        b=N1ZwGlcVJ5rG9flAQBuCpsAPrXZDHoqa2fo8FWwu9PD2aIn4cf+SPIeWSoHwv4lrh1
         2LvRj0t6AgGQXvU1DszGn4MPfrst6y98+5afHBSUK+W04y6Nl3fdRQConLsGSS9APGzI
         ue/+NqXsBwhgBGx9kOABUqs3ZF/swf9J7b/eL/WuDzW3h6vocNV1iqxg+5FSvfUX01za
         aLkbrxYOdb066/pqnhw7HOiDEtf496wvw4WDon0dGFtadtOI3xYMSeTvbzzogLxgW/6g
         oJWkcLb26/3LvWyH9H6VawjHFbMlI9lOzrrDjVpkm2ZjTGhuGmK9Lsa4F7gTzjaMcARK
         493g==
X-Forwarded-Encrypted: i=1; AKwUvByssmIeJk1DQ4vE50jNJ5PNuZ3fOLjo/duATIY7vwXFYWTR4sUIi8c8IsJ4Ne3WBG+KQzpeiGQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mAKacC+uBOVmtXOTqZU6FojnZB4Kmm9bxplFce0U6FZRCCAg+5
	L9H0lKAxVO94hQYa4h/d/X8Q/gn891CswowQA6JmNzv25iIS2/Whx6oruIlNb2WYMfcB+P+/3vE
	EJEANXA==
X-Gm-Gg: AYBFou1lxdRCSyIJaDUibSUEpxewLdSYmrTQIRmWPvioOHPjphnb4aKNhJ3Qx7+wPcU
	aoAG2c7BwGetofQ5xZfph+m2imBn7w+LHSEtoSzmmbuMuhWiPYlKdGDS/7xEnruagP0OVTUG9S3
	8tO+1sROuuoZkAR3Q5eNqvf5N0D6eLNa6gkqxgk03OswWcPsByDnPhEvI1AzCA6h2ba07/nGVjY
	WXDxDMLUhSCVp/POSBiAbQ454fgowwmp1RUjJhIILRoqVZ2+vGzrMus2A7S6m2pIO38pqh46irt
	rZWtDaFrEErtNCiWK+N0tnG3UfsAV5PRVMh1+CjWmDNv2ZvPqxekDSp4U2lNjmpKdgTX/9A5AUU
	mspnTdqjYJ6hGsv6AX59G8h6YQWmdb8f8uGUoMizmQEYK9EY86yImsRQrQnLe/hFfbC5o7RrInZ
	CIIC+9NldThDrjcq4Va2NEViXVVljyLTcNeJeF+0rPxMz+wLi+4Y6pEAZ5dqcYKt5LWoGWnAacN
	IEwneAek3ncy46cTpB7mZ2gQ/R5+Kg28k0/LtgxJoGEdKtNGQIRDWqvSPcXybat/dQylJOBMbuY
	HEh1vy+ZkDfmfenNxw3qw9U=
X-Received: by 2002:a05:622a:507:b0:527:631:8d6 with SMTP id d75a77b69052e-530c859b38fmr137612511cf.25.1789236516942;
        Sat, 12 Sep 2026 11:08:36 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120ef650a6sm52190296d6.0.2026.09.12.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 11:08:36 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net repost 1/2] net/sched: codel: bound the dropping loop per dequeue call
Date: Sat, 12 Sep 2026 14:08:30 -0400
Message-Id: <QDISC-1L5H.v1.20260912080102@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
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
index 2c1f0ec309e9..8f26132d45b7 100644
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
 				/* dont care of possible wrap
 				 * since there is no more divide.
 				 */
-- 
2.43.0

