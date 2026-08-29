Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B5D38F930
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991181; cv=none; b=cZR+vV/H7hnqspH2wqQI0lemZYMkfd58qkKGg7KzwF7D2PpvRe2DVvH7atItkmTBHvd8It75gvTZP5U2ctgnF9dAZeSMioF3keMmt3eEXEEZ0DaAfSH4suMns60p5WGYla50f9Ig9eP9L2L4G/WBegYN/8DX3VoY1mRqqzUsrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991181; c=relaxed/simple;
	bh=NNiqIoW95J4VoaZIqNbNYxj62ObUv6XngGlQw+ysAyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qp3CWvtwvZ6MkOuhWxFhcaodFW1eGASl6g2JWO1MShYVy1h2gHBK2+oKUS7PYYet4ZGlxkxqMbGe4LKF9xzcGlL3rMFRrjghKD26/lYi0zA04Kco0vtRm42hHAIC/Al4bq3R8+io5ypO9IOQFrQ8lcV9zUBDB16Qe49pYZcr33M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=aCcjt27F; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="aCcjt27F"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9391252b5caso115103385a.3
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991179; x=1788595979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vH+5YsNTB/xDLOggySY7l0UJb0258tXEDEvScD3qwdE=;
        b=aCcjt27FEOI2ohi5ItIhjmcfe8OdpzwaseGIw/35uxKV3V7AXTXZDy+336Cp4f1YVh
         8P/Zftzet+22HpFzd6hHoVX6Rgl8s43SfSJ2PA9w1B26Ti5ecAfCguTU6yN2McCU+g58
         A6KZeGW+BMef2UBBtQriYkUeQTb6dMzsHfq+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991179; x=1788595979;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vH+5YsNTB/xDLOggySY7l0UJb0258tXEDEvScD3qwdE=;
        b=iCxzlZjCELC6f65mCP49z7wSg9daohCg7oUgN0X9r9UJKsx0fOpXkmN3IS7GMTOFyC
         ZXcfoBe6XNxxwYVPMXq1+d6x9mM65yIrkxEPKf7HRcuxk2fZovmxVcaZztaSGPb4Q9/3
         WZyu2jfBnIDGuyESLrVnwVVBtJ4rA7ZXIxzzXJU3y9fCdt1+bED1UL6aob/0x/+dmXds
         Wi4asSXvaOgGZcsXCWNfRk8P0oZn580m+4JKx8/lCUQhpszr1i52VD9RJJFYQkSUjKVv
         OrO+n/FhwUlWvWvh1+bKVD/PXHs5N/4EgRQxIozozKiXAnmjPTEuE3gxbCMZGCR9M3jZ
         wosw==
X-Forwarded-Encrypted: i=1; AHgh+RogKBvXUP6QTYnEV+PqCq6V/KNh5shWMP60o/nuY4zuhVoOhfcWN9cNNO94zSqeqvBoDUsX1vs=@vger.kernel.org
X-Gm-Message-State: AFuF++mIXS5DWvXJiCq8DLWrVV+DyHau4ws7fMBRl4w8jZoyUtKYYNgB
	C/FKduMgM73eXkjAk8By2Op31nuZQ//TVK3Onn9clx2z1Fnjs5QAlY9cmMWxXMfFLQ==
X-Gm-Gg: AR+sD12I6qiS4sq34rj3ooG28dpLAQ+CRtwAiHc/5IEEd36hchI46eb3JSD490Qm3LW
	vLw8WgpJAqHC2UEM+rk6XHp7SZRMNg+/qTLfprD/Pz5xhIAf5em8e0Pxh4oXbgI+6SgHF85JTCm
	CdP6txEP+Gcee9Fl69sEjqpOsYl+g6KRs/EA3HjWgEmeYLzlk+ixHRo+efwxkQgHkYL83PwhGP9
	tudAU0WA/edtJgIzRM+p8kl1htKCDQBSmyB76EMYvQR8rBX23pjMmC+TaVM3ikxHEUZIUo84JWr
	Dm5q8tgnnCZjceudLJdNYfknL2aH+6EKtRUA+Dthtu2gpUTJrUQF/d44rcxGLflKgCm0U6zdznl
	YV/UmOMGRLbfV91Q3VBthNWBtwf/2i9EUp8A5pga9I/sjGdc5CAHDuEL45D8mHmE0Vvct1pTlX3
	Bc5TECdDVOmn/qdF9ANWBYPYboUUjZba93IUhCpktL9UnyWaqFmJ9OzKPVriDhMTk1Tbe577Uk6
	DIB0st7yYFk8byJki/SQA1/S4VB0p6ARa1UZWmw7SX01rQ5x02Z4PyRyUMdQMOTP6/taKE0lJCH
	hwTnOJ0xUv8nSQ+ROt9OrqwFODI=
X-Received: by 2002:a05:620a:7001:b0:92b:5408:b6be with SMTP id af79cd13be357-93913862520mr1228692585a.23.1787991173931;
        Sat, 29 Aug 2026 01:12:53 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:53 -0700 (PDT)
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
Subject: [PATCH net v2 6/8] net/sched: pie: clamp psched_mtu in pie_drop_early
Date: Sat, 29 Aug 2026 04:12:27 -0400
Message-Id: <20260829081229.81708-7-jhs@mojatatu.com>
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

pie_drop_early() calls psched_mtu() with no clamp. With mtu=0x80000000
the bytemode divide silently zeroes the drop probability, disabling AQM.
Clamp to [1, 1<<20].

Conditions to recreate the bug:
  CONFIG_NET_SCH_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root pie
  tc qdisc change dev dummy0 root pie stab data 32768 size_log 15 cell_log 0

Fixes: d4b36210c2e6 ("net: pkt_sched: PIE AQM scheme")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_pie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b41f2def2e2c..3b7863ffd284 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -35,7 +35,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 {
 	u64 rnd;
 	u64 local_prob = vars->prob;
-	u32 mtu = psched_mtu(qdisc_dev(sch));
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
 	/* If there is still burst allowance left skip random early drop */
 	if (vars->burst_time > 0)
-- 
2.43.0

