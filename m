Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB853DDB18
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048699; cv=none; b=NSpGwHXtK5KqK5AcpZo4GW7G8WPQVwpSNMtGI6lCNamphXGQcnYc6fhQc3MMh1NHdOk5jOPXmTaec3frL7g6FsgnqKukABXyZNqnmk/yhDw9jCGtNr7MW/T+Etq48acGowvldbQ2Cnr0+HutE9pM7oDncpyDAjPjwHsfqOAek7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048699; c=relaxed/simple;
	bh=PsZSjY3nKTv0UBfsn+/xUSAeSFImVT8zFG7CaYg5bck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gyliEKg3yUzYzqtvg7OnfhgiK+WbiNCTjkuAJ1qGcF1tYfxPLRvjK9bbb9c1FtOgcsuYkXnd3p6EgwWcG7+WgL6ORH3eyzWETojcw0tysMcl3YK+orgi69E6QGjWyr3xbTX1GjpCSp+7F9cKXfiyn3KlfV5oUAFcIT0P/FCgCHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cu9SdKwH; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="cu9SdKwH"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4560d6f82edso3132622fac.3
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787048695; x=1787653495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uXLEFrJeiYa1zJxHzcs8UOhualbeMtxu7j0/N8xRs0M=;
        b=cu9SdKwHuIzkjfSPh4owFiITl09M6xWBdIi5zQ9DTFanXL+n8DOfvLgiq6WYdTWPLk
         JshdCA+GJPEHBMMLPkEIws7NLvwcssC9URsOEaFijcXFWiajCuxOHiNKd1IK6oHCSqLD
         b5qNzCe2usSLCjqAy3zPDlS9H/C9xAFdu9q+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048695; x=1787653495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uXLEFrJeiYa1zJxHzcs8UOhualbeMtxu7j0/N8xRs0M=;
        b=pPtfhQZHt9Hq8+Rknye9r5Ki6gD6D2/13rwq1wolK5GEFJctNVVLOxN+QKhv2ZOr+y
         mq7DlCirWMgW61mkJDYRSw6/NxDVEqCY7bcOzIZtiAKsFAwAMzlK6tqRnrzguOwY43nG
         pexWlv1ivNZnTw062qZm/1yeHEFAh7DhcaSPU5plSmhDZyiXz78FrwifbZelo7dbF4Zo
         vFYgBefiOhsvTXzz4JKKqFP5jaRbMfmlE81cAlohoZJr5wg0ZR2kUX2Ny5vpGkiglQub
         2s0DK0hHvqIE5tekIOEdeowJeSbepQy8xdWbI4cS0XMSWyaj0uP1UXmyBkFF3ST2z81Q
         A6BA==
X-Forwarded-Encrypted: i=1; AHgh+Rq4tCJ1InQwNcNVOiqJ+XQJF1vhtJkGWqyJWYlD2wcE0Tyweo7AmaoxBjojrntkeg1v8IpBPMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDuHwJluYu/mFoIDiRmC/Cr/Zq73Nlv0EjjLeSZSlY+M7NTSwc
	15XPUJkzPsFweQJLO5RU+JKclvcCMifWB1sP5lPiwwJzS3HkgX2DYXuf9LTFlGzMhwoF5TbcB62
	jdA3iyw==
X-Gm-Gg: AR+sD10gYr9dL7z09rfjYmWTFgy/9uT8wYy/2fYWSQYyPb69Wi9c/mex8X0TpF/FtWH
	tceqaHAaCV9Z3jq0ZxNLo4PerneM2KfLjT03GstiOWFDMoI0dUCO4Xkf1e8H+4fRVmHG9pl6DSr
	zhQozkOUyewQyluXU5Em7O7vVSbo2NlLqwlCFDOxsohqJ1Ue8ba0dUgjzGpNkWUMDVN5NdgIq1J
	rSfThz1MO2g3DKlbKA/bMD2ECbZ8tPXd43Fes0aYixRYBIuDfgLl9UpqLlLmXsoUq5sTrQRXvn4
	wzG6SPq9S+DlSqi82gpaZbPKzy3Fksd5Es+GpenfLZerbWYoVgcmHnyQvFhimfZz+JbzCtc8lon
	I2OpKns8IkeYRNKj+uhG1KJvs9/trxTH1v1CbqPoHvYOVkAyEBZx3Q7XVJ7/oIdcAgehfMv2Dfl
	2ZSnK5OVqSncUnWhEs4pvc7eSOJm1knhdE9xaLgsOFluUHKCcEQc/9Gu+099HZIJc1dPlYCANNm
	FP8W5zcMWujeIy3FIbTNoQe+aWEhtMr07tDiYyMggR3s3FaInA=
X-Received: by 2002:a05:620a:2a13:b0:936:86d9:e1c5 with SMTP id af79cd13be357-93704b0d83cmr671382385a.18.1787048260861;
        Tue, 18 Aug 2026 03:17:40 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010e7fc0sm299346985a.20.2026.08.18.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:17:40 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 1/2] net/sched: bound TCA_STAB overhead to prevent qdisc soft lockup
Date: Tue, 18 Aug 2026 06:17:34 -0400
Message-Id: <20260818101735.16655-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qdisc_get_stab() copies the TCA_STAB_BASE overhead from userspace
without bounding it. A huge overhead (e.g. 2147483000) combined with
a small DRR class quantum (1) makes qdisc_calculate_pkt_len() set a
~2 GiB accounting length, so drr_dequeue() spins ~2 billion times
adding quantum=1 to the deficit under the qdisc spinlock with BH
disabled, producing a soft lockup / RCU stall.

The same unbounded stab overhead also lets qdisc_pkt_len() overflow
the per-flow counters of other qdiscs (fq_codel, hhf, sfq), which
were recently clamped per-qdisc; bounding the overhead at the source
closes the root cause for all of them.

Reject overhead > 65535 (matching QFQ_MAX_LMAX and the max single
skb length) in qdisc_get_stab(); legitimate L1 overheads are a few
dozen bytes at most.

vega@nebusec.ai provided PoCs for both DRR and ETS demonstrating the
soft lockup.

Conditions to recreate the bug:
- require CONFIG_SOFTLOCKUP_DETECTOR=y
- Create a veth pair (or use lo) and attach a root qdisc with a
  TCA_STAB overhead near INT_MAX, e.g.:
    tc qdisc add dev veth0 root handle 1: \
        stab mtu 2048 tsize 0 overhead 2147483000 drr
  (or ... ets bands 1 strict 0 quanta 1 priomap 0 0 ... for ETS).
- Add a class with a tiny quantum of 1:
    tc class add dev veth0 parent 1: classid 1:1 drr quantum 1
- Send one small packet (e.g. `ping` or a single UDP datagram) on the
  device; the ~2 GiB accounting length makes the deficit loop spin
  billions of times under the qdisc lock, tripping the softlockup
  detector (panic with kernel.softlockup_panic=1).
- Reachable as root, or from an unprivileged user in a fresh user+net
  namespace (`unshare -Urn`) with namespace-local CAP_NET_ADMIN
  (Level 2).

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pkt_sched.h | 1 +
 net/sched/sch_api.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 18a419cd9d94..a4c1b7b0263d 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -12,6 +12,7 @@

 #define DEFAULT_TX_QUEUE_LEN	1000
 #define STAB_SIZE_LOG_MAX	30
+#define STAB_OVERHEAD_MAX	65535

 struct qdisc_walker {
 	int	stop;
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 65b35528d125..cdcf861c85f5 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -544,6 +544,11 @@ static struct qdisc_size_table *qdisc_get_stab(struct nlattr *opt,
 		return ERR_PTR(-EINVAL);
 	}

+	if (abs(s->overhead) > STAB_OVERHEAD_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid size table overhead");
+		return ERR_PTR(-EINVAL);
+	}
+
 	stab = kmalloc_flex(*stab, data, tsize);
 	if (!stab)
 		return ERR_PTR(-ENOMEM);
-- 
2.43.0

