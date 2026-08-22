Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778AC36B91A
	for <stable@vger.kernel.org>; Sat, 22 Aug 2026 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428542; cv=none; b=Ae9kywSjjMcdfq2OsTCUTqsYGMRAFwiLwzl0q4NsDPAIpzarf6sqbQXz/yEmClVzUaYyikDtl0lwTHaFDtjW/M1FPh6eZiSOupzq7cHyqdVPb9CUhlzKecSeO7ymdaV0urFM1tWBDZ2hfFOTOI+/xBQFwrTBhOs4DPRXfI3rJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428542; c=relaxed/simple;
	bh=QvTV3FLFGZZDXf1OzMUjrD/IhAgZ7jQaoRKhzIgGaSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W0E5Xd4cvcsieJyjQEvaM2GAwnqUrrraQyy0YEy2Vxqdodl867YyGthclr9EYgMT8iobD3NzmHyH6hm2JymOezlCsgsoqKi5N0mJcGpjCbHfxviqsnAz8/Yguc9F7HML1gS9va1mw098rA91ZGqm/VYXwtqg+jsKfpoiIM3elMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=sCxl27Hc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="sCxl27Hc"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e99ef0902so108294385a.2
        for <stable@vger.kernel.org>; Sat, 22 Aug 2026 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787428539; x=1788033339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s8XoO9BhrR628r7wMpIcOW/v5foMyF/fKBuXqg48WMM=;
        b=sCxl27HchmOjw32V2HSHtTukbzn4NVOQfzfk4jY33eYrcYNNTGGwovkhtzSjc8YdCN
         gZGEyQ7d7Iqzde4/bPlIK1j0LLiSj0drJdU6kKOzh7ptWhvOxNqhUy1DoVSJctdT8Jcf
         dWFLnpSX/EeN9mR2eItPGv9W4pRHcElI0niN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787428539; x=1788033339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s8XoO9BhrR628r7wMpIcOW/v5foMyF/fKBuXqg48WMM=;
        b=H8WaO8eNdTZpLTAZx1dZuoukhjtqqgjZEvha81CeyqDJ14NDFRFP+VeFhOWQgQlqr2
         4RAO8f6M18f+hvQPj3z2vmAqBohJ0OPSkgnrD6ac4vrXbH2IA25o18inIP/CClPe+hiu
         n9RWhOCS8qlN0cpad8RB6KOwD2wYij0dbK3zt9Iyz5rWWvmx9liuR+1aX1MChCwGH0eR
         VLIQKlBdRyHjL9rbeNOJOMioq+EZ1oKE7mWeIbjf9hnDzAzoy1k6w8hd0s9N73poJoS0
         aFDIFgqbUtGZ3KwWa8wQYfUadl7AwprGhImaZnL0p95TWsIdV9x1Kae9Pi052kQjmVOd
         1+Cg==
X-Forwarded-Encrypted: i=1; AHgh+Ro5rxNvxL+ynzoo1yrZuOJV9xHXrM1Vx42PIwO5lcb0aCkXfsmhFc4TCo7n19nzw+wpVylBBrs=@vger.kernel.org
X-Gm-Message-State: AFuF++n8tb7N+jFNCytUYnOGrBeCkqksbAY4BM8xy2TzbrnLYsuepTjp
	w+HsBUJWfsUbZ04OnHLZu6+1DST+eaBaT9gvrnblwSQzu/Qmja2RpTvgDrRo7Vauhg==
X-Gm-Gg: AR+sD125suSrGJlsUXK9OEjflNGk9eerzeofxBK0G/dguW+CcOgLsbOXf8EA7Oz8sDI
	F7tPLsxaP5QEyXY0xRoc+9f6adKXKriTuhX8b+GgAw5jZ7btXGeO+rcYv1DmGB46im1lkYGWZLD
	w31VkAM6G6tMnsRdnnUd1RRxGpEG84NDpUFzXl3ZZW49hxkBa3AAXU2LGeqPHRUV2MQQUDBxs1I
	UfZBIFq8DmaspBhkh8xbNS5UrGcGd8wM/pzOV/4KXnV5oQA10mjnWBzs9+LSDDAAf4BNFJl6iE+
	MFNliT9BvPz5hgEM+aLjZYNPzV006rcHr6qCH2C3NnaTnSFMqRHjKbpxKTEMR3iO8PzLqHX/VMz
	eCOMif4iNMDCw/jBUC2Uj21lGJ4tgDYb8w24TMPYWFdVmEWzh4ISQ3PYTRac+M2xLmqeGCENA1/
	f9LxpDxtZ5e9/yiPvm2YN584seim82zyl4TrO85ydRMvFZYbtaNRWB
X-Received: by 2002:a05:620a:4052:b0:937:5351:3a72 with SMTP id af79cd13be357-93753513b9cmr173875585a.22.1787428539336;
        Sat, 22 Aug 2026 12:55:39 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93749adef4csm172997385a.11.2026.08.22.12.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:55:38 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v3 6/6] net/sched: sfq: clamp quantum to avoid signed overflow soft lockup
Date: Sat, 22 Aug 2026 15:55:09 -0400
Message-Id: <20260822195509.112717-7-jhs@mojatatu.com>
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

sfq_init() sets q->quantum = psched_mtu(qdisc_dev(sch)) (unsigned). A
device with a huge MTU (e.g. dummy with max_mtu == 0 accepting MTU
2147483634) makes psched_mtu() return 0x80000000, so slot->allot = INT_MIN
and INT_MIN + INT_MIN toggles between INT_MIN and 0 forever, spinning
sfq_dequeue() under the qdisc lock.

Clamp the quantum to [256, 1 << 20] so the refill loop terminates. The
lower bound also covers q->quantum == 0 (psched_mtu() returning 0),
which spins sfq_dequeue() identically. sfq_change() already rejects a
negative quantum, so only the init path was exposed.

Conditions to recreate the bug: a device whose MTU (plus
hard_header_len) wraps psched_mtu() into the sign bit (e.g. a dummy
device with max_mtu == 0 accepting MTU 2147483634). Requires
CAP_NET_ADMIN in a user namespace.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_sfq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77675f9a4c46..187d3ed578f2 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -799,7 +799,8 @@ static int sfq_init(struct Qdisc *sch, struct nlattr *opt,
 	q->tail = NULL;
 	q->divisor = SFQ_DEFAULT_HASH_DIVISOR;
 	q->maxflows = SFQ_DEFAULT_FLOWS;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)),
+			     256, 1 << 20);
 	q->perturb_period = 0;
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 
-- 
2.43.0

