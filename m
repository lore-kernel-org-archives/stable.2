Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705A38F930
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991174; cv=none; b=IfiTRdxpv0wcDdpv8ZsO6nRr3qVgKjShITuqU+0nh4XqdQOyNIkyjm27SVG7Z0Zh+/M4TLfHiAYBoy/NbQUtHMRspjXNYUIx5uNFLKcZBuR4g17y5QFj6Gw26Qtxo9Gyigcs6RsOB0XQQqvUfRbRozobQvsUI12I+DAyunDFIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991174; c=relaxed/simple;
	bh=VSHjPxoENWOJZWUuZrWj6+G7emdgMSeBRUNJdinfg+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e91vrun0sO6meowaZfRTVunobvqB9jqvnEUCfdAQRY1ybMAVx6mo7p8pDMQPic+XjZY/euQXOc4UfdL3mJNQDlvWy9WLgBaPJZcia+7uduAdDfWEWA7gLIl7aGBNqDC9MLbURHx6A7Mmm/JB83bQFOqmEftI+ybK8itFZPD0hjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=mz/k2HeM; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="mz/k2HeM"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-9391e3b21fbso62331385a.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991172; x=1788595972; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xKR4iq+vEzsRiCk1YHyUdk6oLwqB/fP3JglRMOEMGK4=;
        b=mz/k2HeMMTKR174WU6CzkLuUw1bpll3zYgDObgSMK6LANY6/WJNyej8GqWwNBmBXbj
         QjRMXghqpN4YcHLXLuN8Swz8Ga/WKVwFJqGA01VnmbKqreu3TLRssyDap9x0L+lQSMke
         wJOxKb5XvYtn5U5CKKOnyh6XhBlCLyA8SZF7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991172; x=1788595972;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xKR4iq+vEzsRiCk1YHyUdk6oLwqB/fP3JglRMOEMGK4=;
        b=ceVFc21C3VaWTBH99i7OtiLpfFmtkxIFsBN+QtrONJ/UU05z58X+/oye+S54ll5OE+
         7XZd9prN/FLh/2cyk+fwzv+uJ3XrVJd20850V+Rf9m8wndU0Ke7F+OKGigdoSFsihdk/
         1F8mQOvu/SkZipv+xbKkCxbheWQCa2lFR8IjvSJoWWKtXMexKLmUqDn/XhvkAZfjayGj
         N/KINXsUCJ+zpSzuHOwGB/KU2DMhSk/hqF4N0de0EacGfonKLu0A/rItkg1dZnVwd1Fn
         u1m89XUO2zFmSZ67F8Z/dCiEeMyncNl1nKo3hlaHUMb0Pb/O9m6HqsNrW86MSzAiRfzR
         z0HQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro60zQ7mDUvFOrZml0vidm7BpDQV76jskaI2k4hCwBQOhi/KDHK/s6t9JebpGEt335kgvK12vo=@vger.kernel.org
X-Gm-Message-State: AFuF++k4N53s1VZR26dcKCcVzkS8tXAgBoeKLv6vkHTw1FNfT43GaEdX
	+Ue/pM+UvksGri8n7aSLlKfIRkDzy4jEPDam2flQgTzQMK4qykG3v2rjz3nWIFB09w==
X-Gm-Gg: AR+sD11/vpDPDqu+NmC7GzkC4ZdtjNlxHQJ2mU+w9dkGJ77ZT+O5OQLkMT+rquLeqm+
	Mzf5z43l8Ijk1KrdSM2nQ8nFCY/uRTV5yBAJZxh22U1IzwrCDITpH84BwmoRjYAwLByFpMVHQuf
	oG3Ow1sK4pBy4aJYEcuFnoOh0XNmq07Iq0muw4Q3RT3VUyzlOofmY4k+JNOfWAOU371qPMdExTc
	0dLMEb1dJ6qriJiSARJ6Xuanxf37zqTO1zo72Q8qpMvZsIK7RpV+LPHrEqG9dvoHqC0K/BH30IB
	75WByklrCaj6DFkeRJG0LxeDapSdj42z7sMZyNf4ytLCqcfXUlIBdca5xw1iJhFGj6JvdRceGmb
	m2BPZM6AxgoBK6hOBIn8mCfFUyIImpXBZ7e1nOe4eQ9qTqq7tTHY6WszCf6nXxHSmweaUbfLkVs
	AmtE48ieeezi5JBioo479acBddvgzPJ+0JotDkq2OOg53zbnVa07UTPmcmTd6fxxC/7V5nnGr06
	Fw8Vb14XSCKuDko46A6PPsx4AOsH7lQKoQfD9QKWRbqLUXHgxw2ymxfCAWu0yK9Lnq7CpznmkCv
	F91zn+ojm/ynlTPafm/PkDBlpmo=
X-Received: by 2002:a05:620a:448c:b0:936:6c8a:f7aa with SMTP id af79cd13be357-93913749723mr1297309385a.4.1787991172020;
        Sat, 29 Aug 2026 01:12:52 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:51 -0700 (PDT)
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
Subject: [PATCH net v2 5/8] net/sched: dualpi2: clamp psched_mtu at all call sites
Date: Sat, 29 Aug 2026 04:12:26 -0400
Message-Id: <20260829081229.81708-6-jhs@mojatatu.com>
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

dualpi2_calculate_c_protection(), must_drop(), and get_memory_limit()
call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
overflow in the signed multiply for c_protection_init, and 2 *
psched_mtu() wraps in get_memory_limit(). With a crafted size table
qdisc_pkt_len reaches ~2 GiB, causing a soft lockup / denial of service.

Clamp psched_mtu() to [1, 1<<20] at all three call sites.

Conditions to recreate the bug:
  CONFIG_NET_SCH_DUALPI2=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root dualpi2
  tc qdisc change dev dummy0 root dualpi2 stab data 32768 size_log 15 cell_log 0

Fixes: 320d031ad6e4 ("sched: Struct definition and parsing of dualpi2 qdisc")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_dualpi2.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 4f678d4ff10e..4947def7c49e 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -208,9 +208,11 @@ static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)
 static void dualpi2_calculate_c_protection(struct Qdisc *sch,
 					   struct dualpi2_sched_data *q, u32 wc)
 {
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
+
 	q->c_protection_wc = wc;
 	q->c_protection_wl = MAX_WC - wc;
-	q->c_protection_init = (s32)psched_mtu(qdisc_dev(sch)) *
+	q->c_protection_init = (s32)mtu *
 		((int)q->c_protection_wc - (int)q->c_protection_wl);
 	dualpi2_reset_c_protection(q);
 }
@@ -285,8 +287,9 @@ static bool must_drop(struct Qdisc *sch, struct dualpi2_sched_data *q,
 	u64 local_l_prob;
 	bool overload;
 	u32 prob;
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
-	if (sch->qstats.backlog < 2 * psched_mtu(qdisc_dev(sch)))
+	if (sch->qstats.backlog < 2 * mtu)
 		return false;
 
 	prob = READ_ONCE(q->pi2_prob);
@@ -712,7 +715,8 @@ static u32 get_memory_limit(struct Qdisc *sch, u32 limit)
 	/* Apply rule of thumb, i.e., doubling the packet length,
 	 * to further include per packet overhead in memory_limit.
 	 */
-	u64 memlim = mul_u32_u32(limit, 2 * psched_mtu(qdisc_dev(sch)));
+	u64 memlim = mul_u32_u32(limit, 2 * clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+						     1, 1 << 20));
 
 	if (upper_32_bits(memlim))
 		return U32_MAX;
-- 
2.43.0

