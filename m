Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA5A369D51
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428540; cv=none; b=m41OFpC9jWrAzT+ZpqZXuMQLfs6DC2zwFSMarY+nrPKfoiku5UzQvPJNXQRomUV6NusZfs5ju4cYxpErvCdfttk8fNCqzqzfTD/lOXLFr7/+7IzpuAJmAHIJ3ZRKXMETsc4oRcJQWJ6CFQHmNHXXHdHmFF5SGXn+Z/uc+sllF/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428540; c=relaxed/simple;
	bh=M3PTJqDCQA1BXV4LzCNUeCnnbEkKeELK+aNvFvWOOWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTuEjPIR2B/Kr+XxhjzTOMn7om+kKrfzZr1ID35nTj6xuSIIfLyefQXuhX1ymoDcknH7UtQM9qIbfY0aoKj5Fo+5JufjOqaQkApgh3phDzozJabCrGRdyU2cp2eleBe9YaavJNZXEPhfNaWSxEduTyiE3TIYePTdYO0O5CMdvK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ezdgeyTb; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ezdgeyTb"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e65e18969so151908585a.1
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428538; x=1788033338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V6HrdUaz7lkWm6/+aWbGhNRgT19l/HZ5BPcrR7RGLnE=;
        b=ezdgeyTbjiLxnAsxzXBW7ONzXlgGJD/SA5jPCAtG9EGWVPHNHTFpzv0J49nJc3LfLJ
         cQlW7ot06sfwgdqnxh+nSwsIPJGmYUmhuWKcCk8p+4tT5wAMkOIO2f3HZ0fjP9pTYZgO
         KQcOZ0U1jxPoXToKp24UVM9dV0iPBRdIuHtbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428538; x=1788033338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V6HrdUaz7lkWm6/+aWbGhNRgT19l/HZ5BPcrR7RGLnE=;
        b=jtoAbM5kSwZFpKGEOLCiwd4A1U/ylCB7PQMxkgl8/hJ4CpST4pn5NrxxiKEGnoKfGL
         mOsFtYa5glQBW3Qh0sUyDzyaFIGaVH7dnzM3FKSyW4ouyfIby5mR41y9d72Z5Hkq5L3i
         QM5CXeOckPL3vhLWm2l3EbHrdJUq4mw8QmboCBYGOSt47tRQ8qdQRjrwCtqGnvS9OfvY
         FSsSMICgu2ddXQ3zWEb0FFpI/I7dXfTmNaJa3W9guwD/MafoWYyN+IPzBFOsKUdrrGcK
         kJGLv/o/DwRp5cVGZfwg8Uw6iS4a+H6XV9wqMN/roK44GZSTGpHxeKzju9Xp5mBKLtR5
         w7xw==
X-Forwarded-Encrypted: i=1; AHgh+RpmxJE5+q4lI+mZuiOuZJ8mlUGI3UvQfJDMMLkYOVgp9adjI+8rDOQtsa9Wj1I5A96qyZ/7ejg=@vger.kernel.org
X-Gm-Message-State: AFuF++nB4WqXjmAoW4/Ez7wHM5VJvZk32TYHcPM5wyK6Fd3WTR9tiY9g
	SF3uglrglC7ktEfV79k1eO+IcJnXZKFMQFhWEB90F/Eh8TQyorBBt+34ZzIzXXEBtg==
X-Gm-Gg: AR+sD11sWKskiDhKp5eASZCm0iXHU5mOxvSyuhi/+xRdVSJy1hdjP+rTf7LF96/UqLk
	y93agqiC+O8j+DANu/N3u8hldDjstiK8AGgHrPjSYQZwR0uaLwVT5Dbd7VhWEKJSd3Dx0MbrTmJ
	n39u05MR7c6sQuaWMPafD9WkQSOEj2E12uFJc2tyfICUmz2/yACnn/PwnGs91lzS7wV6xyK3gFm
	UcI6OGCxkQKpR98mDYRBcLGKWTR6ylXUOvGVuDMDB3Y7wMsqHRl5EYqcTlFUIAVpqgV1E3irHUq
	7+lTz5whEehoS4HcHZhJnGMAAzV2Z4BxQbA7TWuuGUlo3j1oFlE2dD5hZoMHOu1i3YMBI9NKQjf
	3P/c2LZ5lmQaLJL5Vr0uy51hxs0hnHr0xsj/33wnMPBx7blJP6U32OrpX6mBGbkboylIaR2OWX8
	EJ969HjL8E2gTZB08WdQu8A1aiNWCjOB/Ei/8rN0EjSkStQqARgHZior9TjI9wCfU=
X-Received: by 2002:a05:620a:294d:b0:936:a184:3cf3 with SMTP id af79cd13be357-9372840f584mr2180174085a.10.1787428537718;
        Sat, 22 Aug 2026 12:55:37 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:36 -0700 (PDT)
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
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 5/6] net/sched: hhf: clamp quantum before hhf_change() to avoid overflow
Date: Sat, 22 Aug 2026 15:55:08 -0400
Message-Id: <20260822195509.112717-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260822195509.112717-1-jhs@mojatatu.com>
References: <20260822195509.112717-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hhf_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) with no overflow
check. A device with a huge MTU (e.g. dummy with max_mtu == 0 accepting
MTU 2147483634) makes weight * quantum overflow the signed deficit in
hhf_dequeue(), spinning forever.

Clamp q->quantum before hhf_change() so both the opt and !opt paths see
a sane quantum. Without this, bare "tc qdisc add ... hhf" succeeds with
a clamped quantum but "tc qdisc add ... hhf limit 1000" (any option
present) fails with -EINVAL because hhf_change() re-validates the
unclamped default (sch_hhf.c:559). 256 matches fq_codel's floor and is
a sane minimum for a DRR quantum.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 10239edf86f1 ("net-qdisc-hhf: Heavy-Hitter Filter (HHF) qdisc")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_hhf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index d85cb0263b67..96acab6a8da0 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -624,6 +624,10 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
+	if ((int)q->quantum <= 0 ||
+	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
+		q->quantum = 256;
+
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
 
-- 
2.43.0

