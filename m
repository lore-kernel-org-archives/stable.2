Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D271468C35
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 20:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788468990; cv=none; b=ddwHTb+Hhm59Ecozvcv2QF6fVLZ6i2LssaR/4LxN+Zgz3mfIdi+rQd+vml08OUTcPaVxjRSOYs202UOAzR2bjtmO6bzt84GofbX7baclMhbOIiieSwVMBzXMxrexbH3MB+Q7e7Q3UJu/inZYe0NmLrHyVCQErRP783z/lRzStHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788468990; c=relaxed/simple;
	bh=asM3u2jh2/97ma/RigKr/jhcfK2a1T/GQYGyli6hKw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iJs8b4x5VU/X9UThaYrtPcv8uq7isTY+z7IpOJ5lJlcIYhNtgHNL0ozEUq5/r03qge3/X0DM9ih/L/RVYjIL7Wxc3HQeZbK40SBGzVWFxrgSOXQmpN3fTosrTaEuGiinODwnGqxIIJW9RxjbBv1tEFn3fcQ/OjWU7KO2t+pg35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=oybCd1ev; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="oybCd1ev"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-52d5bfa4bafso5051071cf.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788468981; x=1789073781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=omcuQrXyWn92mT7/l5cfyeWdZD8VtU1sSuEMsPrFlZA=;
        b=oybCd1evk4sAK+iGb2ojUB9x+GtRbYMjyKcG5CdCgfMiCGLieM3mKh9/digSW31lyO
         y76otpy2sV37+9OE+fzYDzVB65TDOfzo/CJjdGXgZUDDk2Xuhay1nyN8nt6YD+yAk8qG
         VWeIATpbzMWK5B2O8zbJtj/n7hjY1CJiskFL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788468981; x=1789073781;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=omcuQrXyWn92mT7/l5cfyeWdZD8VtU1sSuEMsPrFlZA=;
        b=skh2GwXrzWFktseLRkrI7jVG8KsO2y20q9FUdlVPIB1juIefJvQAJjq89dkxB54Ok6
         84jLdpgiyND3odzm/Kh5m9l5jM/l4afxVDptNN0GmadpOTZGIImLYZINMEDEUw/3ccJp
         eiZCCetf+YqfcoeL6nyWgJopNG3bJkrmCM/Eb3kMP9ffC2yFN7JGy0METOin5PsZTfHD
         IEeRzdmhYYWPxM7hfU2+hOiIgL7yHuf7AhQNLZSWwzADPuegtaPtRtIknuS89l6J9y+M
         Znaob3UIuFDo5g1BlZB/H+qcnogbtTKPouTENY3/mJmnoT9XFn3r6ylUJ5ymRTJqu9t8
         sGXA==
X-Forwarded-Encrypted: i=1; AKwUvByG45vrvb1lhfvnO4YIRzUrZs84FLuQMj/8w72j61nPn7LDuBaDGNXv4Ytg3qvHr8PQbugFlpM=@vger.kernel.org
X-Gm-Message-State: AFuF++lOBhLAtPaOadtTgSnn3zqehSOp+dbyyns7cJrWJvISi8rmqSKd
	/V/SZj0L1eSJFhSXZP0Wewgm3jyzzjN2UCzMl4iyvCRlsCvCTC39MkSewcEtBqZqiA==
X-Gm-Gg: AYBFou3F1MDbBOI9QRR/E4Qi2lgibbPmPV45zb5av3/OezhM/dtQh+PYFMBN+l2HRZ8
	OJ8eu62+guxjztXbl7JNzSEOIqY8WRh108nt6kvPjX6i8ot1lzW9C64TuEqJf9J1FbDV0yk5Z+w
	HHs4EsLumOqa6uShkA//aMhQKdLyVxg8iUl4qXi/4kEzfVV8g46gcBI1fw6TcCjKC9O1S7FL3/8
	EoCkD6PjYD+EdJMHZZOEhQ3IiWjak6kbt2aAy8BV/cPUO5wRIrUT0N0tG5xLrxC/GicdPn/QzE0
	5oc1cjgBWPR5Aly0MDrxB+gvKITVJDB9djoqKYXuMtgGMPNB6CK6gDPxD6rn79RtN1vbFia4S+T
	pOQ2QdwQLLVNppEoLx8tlnzkXG4QI2PRH9EsnJP/PmLl7MR/Iz7JU2pP2gskX0NuYjmbSVopBwr
	nEFdIz5QRy/i0Ku5CVYgE5rA2YBOiE43jxOcC+xMe0xDsX7DSf90cbhrmfnJ3qQIyKghZOXurIN
	Svm3wNCszz29+e2t/J1kVttYJF57sTgqqp76oTaYaqJuCQtM2Vq0t+Fhv5lxsXzLscKuXfssi+m
	bTY1Cgod0y5A
X-Received: by 2002:ac8:7f0f:0:b0:52f:b9ad:9dc1 with SMTP id d75a77b69052e-530548ea102mr18677551cf.20.1788468981102;
        Thu, 03 Sep 2026 13:56:21 -0700 (PDT)
Received: from majuu.waya (pool-174-112-106-84.cpe.net.cable.rogers.com. [174.112.106.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5305422fc07sm5509881cf.31.2026.09.03.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 13:56:20 -0700 (PDT)
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
Subject: [PATCH net 1/2] net/sched: codel: bound the dropping loop per dequeue call
Date: Thu,  3 Sep 2026 16:56:15 -0400
Message-Id: <QDISC-1L5H.v1.20260903184552@mojatatu.com>
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

Conditions to recreate the bug (repro from vega@nebusec.ai):
  - tc qdisc add dev lo root handle 1: tbf rate 1kbit burst 2kb limit 1000000
  - tc qdisc add dev lo parent 1:1 handle 10: codel interval 2us target 1ms noecn limit 1000000 (same for fq_codel)
  - unpatched kernel: tc accepts it; a UDP flood under the 1kbit tbf
    soft-lockups (watchdog: BUG: soft lockup) while one
    codel_dequeue() call drops the backlog under the qdisc lock
  - patched kernel: same setup, at most 256 drops per dequeue call,
    no soft lockup

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Reported-by: Vega <vega@nebusec.ai>
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
index 2c1f0ec309e9..9e779cd4d6de 100644
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
@@ -156,6 +161,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	struct sk_buff *skb = dequeue_func(vars, ctx);
 	codel_time_t now;
 	bool drop;
+	unsigned int drops = 0;
 
 	if (!skb) {
 		vars->first_above_time = 0;
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

