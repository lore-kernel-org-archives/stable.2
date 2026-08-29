Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B91A2D9ECB
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991163; cv=none; b=OMXxlMUD9EhVLZEjMqX59Pb6iiWsEsJff3uGBSJjC+CKTOvaUzdpzKBA2ZUoJo+Wv0YC7cndx4jGnnllsPlTxDJafSHwthslsSWnfCF0cECV1jXTFrHhjYvzTRwzlozpXu9OWnu5cIliu4Tt2qq0vcALjCgsFbtU1a5R1+34oRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991163; c=relaxed/simple;
	bh=Tocm9xTVdjAG4h3ZeCQTFQp9GsUy3jTDUVO5FtFxKV8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HJp+sY1pdByCVmKxbn5pf4WXBUlDaVmx+IQ5VRwLEcJaSBMahbJEZG/o2G3xopiKftNbRwm3QS22mpKTkRuKqHZCibNskx2F2uL3jBOYujjaVJr6BERN+TzHeMKoe+fodkLmhT9GdJAOeFSCLphvi3JW9WRqdFKbIlMjsuMnWng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=djQxf4pY; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="djQxf4pY"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-52b3934af3fso20845701cf.1
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991161; x=1788595961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KtcKTjm9ijdrKH9B4mxB6pHRfv+Ie8S3UGs59ZmOZ1A=;
        b=djQxf4pYfn9PW2yW/Dik2N60InoixzZ67qzt3wAk/xRkr7PoY4NhANnskxSo6Cr7V9
         U2sXrjDmqwCC+cC6vrCNAHOSuqP0xyADKgw9y4WrRAFs3IdpifZBXkBWuZM49wWS7bIG
         z+qDm+IWamTZo6CTq6MvTfHv7gd+IFoxu/m/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991161; x=1788595961;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KtcKTjm9ijdrKH9B4mxB6pHRfv+Ie8S3UGs59ZmOZ1A=;
        b=lHoUyNkSqycHbTW4xj2gZvjMYWf0JRNQ3it6yJNhKd4EhAeYKrmVwPrvMnWCbjOtRU
         wjrxnOr6NMEcl/dKEfOqUN53+8C2Ch6ewSD3Vn6DpeDUzaed2OSMcixKXQrAmYLW4rt+
         D3bxU0QADXx9Q8FsVnijb9Fy4glGafPGOVuxPv4I9fFAyZW7N8FSrkY9l8TKyD6yGwJF
         8YcTjKQ3pZ1Ej5+Uw2nHg3kbgm12QA0mHuQVwHpc4p3mI56Fxj644kTDi0Ps+Q4c8IPK
         OqT3i0CtzFem71BTmwJKAwrwwZ3+s3UMoeIjRo0gS8LdeFZn/L3KR8EAleMuhVzHSA2u
         xZEg==
X-Forwarded-Encrypted: i=1; AHgh+RppFxhjReawbndPQFNSBRU8A0zW/aDH2tN0LUGcFPkASzqpfqxYRWIKfOBJCheUmJrPwUAzs00=@vger.kernel.org
X-Gm-Message-State: AFuF++ljgkXIF9RHf6hx6RWX65CbWUoZtiaOPsVN5ncH7K3tYur+ZGAu
	TRaX1uv+NNFQmfhQ3Ev5AdNvQ4sHfVCBlEWLlQnuWaEhWAlAlx9cQ98I3Tnlz7mt3Q==
X-Gm-Gg: AR+sD12dFGC/gYOALdrSsWjIN2E7wU+yUD05kVA6egk1bgWErQaq1ygba75o07sJbTM
	0SZoAQGjVDqy0R5IIUuGuW8aL4/QPN0xzhr6YAxVywErFdqHs5vv4KStjC1Z5dM6icc7gIHl9Yl
	V1vEexRs2+nwAKvUmmeSbiKlu4nMx6a9G8CjJr9wyy18mc8knGF9NAX04OAfgSvatKsAzKBCfX1
	+ju2nV07oJkoHH3m5+/hchECizpSItm+uIGnEr+sKtPxS2k4x3dk6KH9Prf/aurPApZVVTQbIDP
	atl8sCPqtSXf+J+YRQkYf0nPHIZQCG2eTYf+JSNmokp5vaasmm1l/l4c5utbheFS04fu4/iZQxT
	w74ZFcltBXu81bgOb1qV9amR9c5XGcwiVHuDeo96olL74+BNNN8ac5SaEpWmQsySEpmevfw+pXI
	OShXDUoiRCOSaNX3ZGPwIhzDx4gaDMQixv+7Ie0i7fwQB4pQQCzCCspW74lILFYdYoSvxn3GPLZ
	869nHCuq3VugBZkYb9t+8KX7nwH9NSO0LrZ+RDyUWNpXtz3LIvGpaGKd5eoC8LP/gbj9UK1sYpE
	YL91ogDyKG4Tvr9PeEwnuwL2W2I=
X-Received: by 2002:a05:620a:19a7:b0:914:afc1:c66d with SMTP id af79cd13be357-939137f96demr1385270485a.11.1787991160640;
        Sat, 29 Aug 2026 01:12:40 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:39 -0700 (PDT)
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
Subject: [PATCH net v2 0/8] net/sched: clamp quantum/psched_mtu in change paths
Date: Sat, 29 Aug 2026 04:12:21 -0400
Message-Id: <20260829081229.81708-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <all>
References: <all>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is a followup to commit 709f34f7c28d ("net/sched: fq: add overflow
bounds to quantum and initial quantum").

The quantum_backlog_overflow series and the five siblings that followed
clamped the init-path quantum in fq, fq_codel, fq_pie, hhf, sfq. The
change() paths were not clamped but it is the same pattern, same writer
of q->quantum, same privilege level (CAP_NET_ADMIN in a user namespace).
A user can override the init clamp via tc qdisc change, restoring the
small-quantum deficit spin that the init clamp was meant to prevent.

This series also covers two siblings that were missed entirely by the
original series: sch_dualpi2 and sch_pie call psched_mtu() without any
clamp at all. With a crafted size table qdisc_pkt_len reaches ~2 GiB,
so quantum=1 (or a zero psched_mtu on a headerless device) makes the
deficit-refill loop spin ~2^31 times under the qdisc lock (a soft
lockup / denial of service).

Each patch fixes one qdisc with its own Fixes: tag so they can be
backported independently — the commits they fix shift differently in
the git tree.

Patch 1: fq — clamp TCA_FQ_QUANTUM and TCA_FQ_INITIAL_QUANTUM in change
Patch 2: fq_pie — clamp quantum in change path
Patch 3: sfq — clamp quantum and reject > 1<<20 in change path
Patch 4: hhf — clamp quantum in change and init paths
Patch 5: dualpi2 — clamp psched_mtu at all 3 call sites
Patch 6: pie — clamp psched_mtu in pie_drop_early
Patch 7: drr — clamp quantum in change class
Patch 8: ets — clamp quantum in parse and fallback paths

Conditions to recreate (applies to all): create the qdisc, then
tc qdisc change ... quantum 1 with a STAB size table inflating
qdisc_pkt_len. Requires CAP_NET_ADMIN in a user namespace (unshare -Urn).

Sashiko links:
- gemini: https://sashiko.dev/#/patchset/20260826074056.7873-1-jhs@mojatatu.com
- nipa: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260826074056.7873-1-jhs@mojatatu.com

v1 -> v2:
- Split the single monolithic patch into 8 per-qdisc patches, each with
  its own Fixes: tag, so stable backports can cherry-pick individually.
- Add cover letter.
- ETS: move 256 floor into ets_quantum_parse() so explicit quanta are
  clamped, not just the fallback path (Sashiko gemini + nipa gpt-5-6-sol-1-7).
- DRR: add upper bound clamp_t(u32, quantum, 256, 1<<20) matching sfq
  (Sashiko nipa gpt-5-6-sol-3-19).
- ETS: add upper bound clamp in ets_quantum_parse() and fallback path.
- sch_fq: add 256 floor in fq_change() for TCA_FQ_QUANTUM and clamp
  fq_init() quantum to [256, 1<<20] for tiny-MTU devices
  (Sashiko gemini + nipa main-1-1).
- hhf: clamp hhf_init() to [256, 1<<20] matching siblings
  (Sashiko gemini + nipa gpt-5-6-sol-6-24).
- Add Fixes: dcc68b4d8084 for ETS (Sashiko nipa gpt-5-6-sol-1-8).
- Re-add Toke's Reviewed-by from v1 (kept since v2 only splits the patch,
  the code Toke reviewed is unchanged in approach).

Jamal Hadi Salim (8):
  net/sched: fq: clamp quantum and initial_quantum in change path
  net/sched: fq_pie: clamp quantum in change path
  net/sched: sfq: clamp quantum in change path
  net/sched: hhf: clamp quantum in change and init paths
  net/sched: dualpi2: clamp psched_mtu at all call sites
  net/sched: pie: clamp psched_mtu in pie_drop_early
  net/sched: drr: clamp quantum in change class
  net/sched: ets: clamp quantum in parse and fallback paths

 net/sched/sch_drr.c     |  3 ++-
 net/sched/sch_dualpi2.c | 10 +++++++---
 net/sched/sch_ets.c     | 12 +++++-------
 net/sched/sch_fq.c      | 14 +++++---------
 net/sched/sch_fq_pie.c  |  3 ++-
 net/sched/sch_hhf.c     |  8 ++------
 net/sched/sch_pie.c     |  2 +-
 net/sched/sch_sfq.c     |  7 ++++++-
 8 files changed, 30 insertions(+), 29 deletions(-)

-- 
2.43.0
