Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF612D9ECB
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 08:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787991172; cv=none; b=hhKpHe1Cd+v9ve/8DXXnD0tYn2Ubxyrb+R5t2aJJBt8GMuVlAYFy2m3fr7XvPKWmpBzNXW4L5eIDSnw8todVUvziZnI2ym6ghyaBx7RKtQKFs7Qbt3nlVoFACTUuusqqR4Moa2VHnjZfFATlCxy6r0wpAnqVCXqFwB5JijJHtE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787991172; c=relaxed/simple;
	bh=quY2v/bxKM12diO99BUeH4YNwCXkhOs+d0lDHqZyEAM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVgyPXbAdA5qtDi3L/yjvLY6w7wS/ZHQJQLyCN8wgY5sZqVy3RYqSeVN/HQ/VAoZ9cPuLQ8+jOxRdENa5zfG4nPJx5jhzP45T7EzL8BlfTupPweaRF+yd86mqJ3Ytvt1yTib0+wUnn5C7D3lrI0shoug2mjBe4BGAnDHaU82lXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ObHqJsU+; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ObHqJsU+"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-90c522298d2so22177536d6.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787991170; x=1788595970; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8mUybPresjzuEz0a7d65wBNDKIGpxh5TFrub1P9rfiQ=;
        b=ObHqJsU+wpNl9WM1iVhF5VLf4YoonbZZDche3jw6vgC9A2SLZ/bPo7CEY5qbQr0TKd
         Mfp0kxZlxGoUQP1IE89HQauL4FLpa/YkBgNpcDfKUxrzSEIOeNrLJ08YtBupyO6DqQ1q
         9T4Cct93afLUYUmeDh7kb+gmXa1UEN+Y7UmMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787991170; x=1788595970;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8mUybPresjzuEz0a7d65wBNDKIGpxh5TFrub1P9rfiQ=;
        b=UH299QabNk4585id6cyGd9/QCmcYUk8CCnoCmIbj2UOpfqsu//yD5naM0bNV0crzVc
         uy918wG1biM9f95NnHrxIhIjT2fx6kRnHhF8+mi7gQkFbvnpCh3jM94Sw2ISLqDXE+Yx
         g6Kk5NWV5Nblj1boLqxjijkebkjSIxCDiYWern8h8Vh+9f5RgFX1uVujjXXORtqrF7eF
         pg+gMy9eDpP5mg2aRFAv88KdWGBSA42i8imrFNKejb7YYU+YEHqkNqfxaTNB3X2F0EAD
         8rMlJY4raIM6XLUtZN9h83df8lzlJnKfAVDZbkm8UHjB3bTn2h48wBR5ijIQvX6eqf70
         XFRA==
X-Forwarded-Encrypted: i=1; AHgh+Rre5+T0NfCFYtJgWJro88+2VrGlnNp3E4cqBX53Qv1zN8GHIOkRjuyk2//lE67mCb+9kHxXT3g=@vger.kernel.org
X-Gm-Message-State: AFuF++nptw99sBDVLWx/t4VL5kmWAG0AtFOldrEM9DCvV52x6hsbJYxW
	OsjjSdsL5gCBzzEh388PutyzNew0+XG6WkI3Q4y/pynKxeghl+vhv8ah8W1yaNTFIQ==
X-Gm-Gg: AR+sD13U+b55y+cgnlk2bPTnzBC3EGqOYdenD0YWFhhIZ324i38vLx0y+gBVj6wLfsI
	cmw+Oc3H9lTna8unQIIJJl4poB+MlniDGuGph3tMneUv4rCCwioImCyI9kRDfYi4D4iDwU+xWGG
	ucj8wkvFIDTDUlZmuM/NlC9qGeaoroxBMOX9kxBY4cviDU4xheS1oFuCmxOUEDwN893klPfReiL
	96GtUmbeHQShhQQ/36x+5wzwnFaGeWY79qIMv5XZ/MBlGkD3ayE8SsA+RKPU1eLkaQwUEUAON+E
	mPIH4HYzWth+q9xLYrm/Za0S0OkpBffhC819m3ZsWUkpyoQw7/IPMKWBabNHg+xxrNXM7LHfHLh
	66T8CTQ7qxUbl8+QT35gpwbxVUSpJPkZQJTepPh6spRMmFLaRImyMrlsGHAZ2R/PaCTKIhL87Bk
	3mMr9e0GE8OdNGWlu1rKUSlju6Vv8q/qBkkfNz/QQGDk+QAj2SNKhMETXh5RbJQGM5bfhRSUenc
	lk7H5dYnUccjGat4vXBEOOlxybU7tDuYZpmRAD1L5aNwVGUIADIMyl+cR5Xlo7YD9peoxhFQ3L7
	rVdUDVu/zoQ19Q0WWhZNusjlm6Q=
X-Received: by 2002:a05:620a:379e:b0:939:9b9:c121 with SMTP id af79cd13be357-9391385e9camr1004133485a.28.1787991164986;
        Sat, 29 Aug 2026 01:12:44 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93917014c56sm325358385a.10.2026.08.29.01.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 01:12:44 -0700 (PDT)
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
Subject: [PATCH net v2 2/8] net/sched: fq_pie: clamp quantum in change path
Date: Sat, 29 Aug 2026 04:12:23 -0400
Message-Id: <20260829081229.81708-3-jhs@mojatatu.com>
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

fq_pie_change() accepts any quantum value from userspace, including 1.
With a crafted size table qdisc_pkt_len reaches ~2 GiB, so quantum=1
makes the deficit-refill loop spin ~2^31 times under the qdisc lock
(a soft lockup / denial of service).

Add max(256U, ...) matching fq_codel_change().

Conditions to recreate the bug:
  CONFIG_NET_SCH_FQ_PIE=y. Requires CAP_NET_ADMIN (namespace-local via
  unshare -Urn suffices).

  tc qdisc add dev dummy0 root fq_pie
  tc qdisc change dev dummy0 root fq_pie quantum 1 stab data 32768 size_log 15 cell_log 0

Fixes: ec97ecf1ebe4 ("net: sched: add Flow Queue PIE packet scheduler")
Reported-by: vega@nebusec.ai
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: stable@vger.kernel.org
---
 net/sched/sch_fq_pie.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index b27d95418707..5982847df8f8 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -341,7 +341,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
+		WRITE_ONCE(q->quantum,
+			   max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM])));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
 		WRITE_ONCE(q->memory_limit,
-- 
2.43.0

