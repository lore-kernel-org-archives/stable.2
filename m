Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D91385509
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991165; cv=none; b=eyMwbVkJtj45OAdLFJ/hoFyAq6+R5rlovu5//Cmh7UsnrYxwewnYQW/in/raGFl/AiymQyyOxuzgzLygihB78fxxgrlotZb90OxABiETNJtRgVf06Zdk2JHbK3m4e1AdvfdzBcQnxLEI0V9MCsnF8VyiLbT0nacOHXdrctzIagE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991165; c=relaxed/simple;
	bh=eNjnF9KlBa3ZOuQ34ZlHZHotf1GzfNMkQ8oBzZnw00Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTR0e85N/fObo490eEGrfnT8lA7FE+w/GkuzeobfDdzIJJ2UJENB7Usqq7nAqW0HVo+13a0v3M6k76JHhXBCvfpCDTvr41js+ie/jO6y+KhoAdOSfm/qT7iHaVg2hxKykLOAA3mUWNfswN5TVQ+2hDgH0thCAZwqrmAqJXZXUr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=grJQwaDH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="grJQwaDH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93900ed2925so143138585a.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991163; x=1788595963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7hvWUJoJvnXpjqhu3W0EwadWbrxUFdGuL3OAyMAegJ0=;
        b=grJQwaDHrSnNZ0BHGyO8PeQmhbj+yFbMhfB2FsUTwZ7CXJfkpQlxGuCMOllhj+AC5Y
         tXuyLDpLVhda2k//ZElTcbQ9tgJLGupesscZw+15M9Ed/1mVAEpfG5LfJYIzmGvbdjiw
         0LJYhFjGkAtB4J6nr1Q80v1uwotbfWms2vI1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991163; x=1788595963;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7hvWUJoJvnXpjqhu3W0EwadWbrxUFdGuL3OAyMAegJ0=;
        b=esmUjhHoFXBvKztsnklXlC9B2FRakr7/kxZkwl4WCCy6icsJ32/67msna9YksJfpCz
         fpy4hMBewlz5yfA9MTz4MsYLSa5RA2m26ajTzVWenCGCY8UPtaBik9DB6CVjBsTrS6U8
         Vy02Qe/3rjNRa/rZHEz0PdKqHZQgYXQFFlRRPLWY96xBjkB9N+EbNxeCVdbdw6iAQb+5
         B636vr/i8RmQ1ilEWqcmTmp+F/LpQa8Nv3rnh2OwlomuEHzkGnNXmojpaw1GLaaOy91R
         9i7VT46K1achXjhoQbToRZZ8zxt669sN6hEf7y+AiLU5Gi9jv8a197PZAwOlqcTqus5d
         5Qzg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Q9XhxpMxV03vqywQtql9R3FHOVTeNX5NznNZaF12OX4pDjMSEJmYRkyBQaQASBDB8CwDmD4=@vger.kernel.org
X-Gm-Message-State: AFuF++mGoMfT9z24wg/btvSTirjUnBVVqKXxrsLhO0GWr0eUAXf15gbS
	xC0s/mxUDCaWyKs5l64Yw/HbOUfqEEscQzpMNfpnJtInpWSVnbEgce1SBLOAjGFJSQ==
X-Gm-Gg: AR+sD12X4FGutlQxSNQNJOfgbzdeuzH2eQdMtpZc5sQrW0EI4cJlavrntH5Pib+C7eL
	P18wx6FTHGzVS8oo4HyczBrLordHFRHwu7n8Rt7nLWBDLnxkpVRMcI5QjOInAhOe+1BdAxA+Fxq
	Y0CDnGc7qTKib/Ia1WKbipBL2e2m8yEn8cPPDK4Ny9Fr44Lpv/E81G6Y0H1H88YHDooeH20m8cI
	lRpqdjWTgI7nNHvv3P67dkt3ODFCO1v0rRthr0Z8ct2WUjj/OW0WdlEM5W5V7YSMb6wvbJWvXOI
	htsPSRtGyqpHnp4uVniCAuYRs6Iflu9C4Q7QB47mh4dJljYGZqe2N+MhlBSSs7GIoPd7c8DncRX
	SLwoSSeyF7E0ijLAuWtP0WdKNTTrq6NIOG1caMHWzZmxl6Bp200b3m16h3QpnLDiN8OlSuzVj1T
	f9LFaLJpya3vK1r6JtOwqe21uUZ+CyfCwmhVzhqFBBbYPPlFbqTG5gRrQJ8xCi0ZbmNRUWNJaA5
	cD1DXuypRTxvM2BL6yJ/fz5zIDXTPIoBX9pTOX/p1+zNKil9rAvJoLG1u0sIRZMJtGR0rJOd9Cc
	pXm+1Fku5r7xXLFUr+1EQRP6oew=
X-Received: by 2002:a05:620a:4011:b0:939:13aa:1ba1 with SMTP id af79cd13be357-93913aa1d9cmr1221864885a.5.1787991162780;
        Sat, 29 Aug 2026 01:12:42 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:41 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Victor Nogueira <victor@mojatatu.com>,
	vega@nebusec.ai,
	stable@vger.kernel.org,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	petrm@nvidia.com
Subject: [PATCH net v2 1/8] net/sched: fq: clamp quantum and initial_quantum in change path
Date: Sat, 29 Aug 2026 04:12:22 -0400
Message-Id: <20260829081229.81708-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260829081229.81708-1-jhs@mojatatu.com>
References: <all>
 <20260829081229.81708-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The fq change path accepts TCA_FQ_QUANTUM in [1, INT_MAX] and
TCA_FQ_INITIAL_QUANTUM up to INT_MAX, while fq_init() already clamps to
[1, 1<<20]. A user can override the init clamp via tc qdisc change,
restoring the small-quantum deficit spin that the init clamp prevents.

Narrow iq_range.max to 1<<20 so TCA_FQ_INITIAL_QUANTUM is rejected at
parse time. Clamp TCA_FQ_QUANTUM to [256, 1<<20] in fq_change() and
fq_init() quantum to [256, 1<<20] for tiny-MTU devices.

Conditions to recreate the bug:
  CONFIG_NET_SCH_FQ=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root fq
  tc qdisc change dev dummy0 root fq quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: 709f34f7c28d ("net/sched: fq: add overflow bounds to quantum and initial quantum")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_fq.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 6144b5686f13..35f940b2205d 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
 }
 
 static const struct netlink_range_validation iq_range = {
-	.max = INT_MAX,
+	.max = 1 << 20,
 };
 
 static const struct nla_policy fq_policy[TCA_FQ_MAX + 1] = {
@@ -1106,14 +1106,10 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_FLOW_PLIMIT]));
 
 	if (tb[TCA_FQ_QUANTUM]) {
-		u32 quantum = nla_get_u32(tb[TCA_FQ_QUANTUM]);
+		u32 quantum = clamp_t(u32, nla_get_u32(tb[TCA_FQ_QUANTUM]),
+				     256, 1 << 20);
 
-		if (quantum > 0 && quantum <= (1 << 20)) {
-			WRITE_ONCE(q->quantum, quantum);
-		} else {
-			NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
-			err = -EINVAL;
-		}
+		WRITE_ONCE(q->quantum, quantum);
 	}
 
 	if (tb[TCA_FQ_INITIAL_QUANTUM])
@@ -1232,7 +1228,7 @@ static int fq_init(struct Qdisc *sch, struct nlattr *opt,
 	sch->limit		= 10000;
 	q->flow_plimit		= 100;
 	mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
-	q->quantum		= min_t(u32, 2 * mtu, 1 << 20);
+	q->quantum		= clamp_t(u32, 2 * mtu, 256, 1 << 20);
 	q->initial_quantum	= min_t(u32, 10 * mtu, 1 << 20);
 	q->flow_refill_delay	= msecs_to_jiffies(40);
 	q->flow_max_rate	= ~0UL;
-- 
2.43.0

