Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17213A2544
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219571; cv=none; b=SISMQ2dk4SfRbUehf5O3zaMQXkoXEwV8sFZ8bdEFdkUh9HSWdRrPYIpSWbU6dCz+5ZIIrknAc5MbP2Jouy+PvgTgE4pg5mF+N4gUYBmfxdW8N3yYAHQLPFN2MeTz3BqrzC4tjbtcsvzPsqfbCfxgq90TVEliwgh8bVkCogsG+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219571; c=relaxed/simple;
	bh=pO9xKGT1TX4gkcjXNXA04rB1EhLzc1LoY04P9xUuGmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umjklJ2nFDJfnNeggAHDixKO+g9TcveKxlhgzXZTnJOFOv+fgDC1Qu8TMdMVDIqD35IU5Do3teNHIfAhss/dSzD9LHOlVi5m8T7QCgmh4/m4gQjS3+7jH8OlyN3oxyiztOBW+z2sL63TwHjvHvbRmAj3y/4G2oe8e4gPEbxLsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bHfEc/JM; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bHfEc/JM"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-462df62f872so709087fac.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219566; x=1787824366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DGQ4lHm/pwFE2eJnKjB8iU5lTL8Lwpsi6psSrL49/Ks=;
        b=bHfEc/JMrDhpeMeTSoFCQbz3s64f8b+u112t5ufl5MxDFwMUpzLXu+tSgQLZQJGNfF
         UwlT3fMH48bw3xE299c578eaEAtGwyL6h31NcjLUCQoxuvSvLsv+vGpP4fumSCqNFOKR
         YVXzlb9ze/hu7EEWnfFTlcQOSmObiyePMY6vE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219566; x=1787824366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DGQ4lHm/pwFE2eJnKjB8iU5lTL8Lwpsi6psSrL49/Ks=;
        b=Ob/uQsiPsPP3zD8VHU3reb3xvmowX5s/jdiaQxlNQu1hwqZbebn84J3LfeZpdTvhL0
         nqgvch2k3PEUo8LYP7wat2WgtGrY5qOXkiKGRCfYedNACdDypZeiZhzXQsdGc8d3yuC6
         JxcT01VT8VotHrLlZQ1u6J+Z+8CStUT/b6SWqv1I+Ws5CSzFNYrJWuBh/XJ+r1LlTc3w
         SzTwOpU/dFrq3kKBaH2f27OU/LYoCsjb0HeqS9YkJZOOVPfmK9ZvuRmTQjHsBAXKKvUH
         x6BPaXHVQbBw0J9/rAz8RR3qv/B1bm8gflAaUuJFQwAXOq30IHOGiL8Kd2kZ0HZwBiGC
         1a9w==
X-Forwarded-Encrypted: i=1; AHgh+RoMOR8lW++0X+nPFNiFypaGSE2hjvuArXZoZEOFP3TzpwjvQDothr9M3AN/QVGA+DnnLkFngFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVeUmX4scoabSODTwHlDW3PwA9CskEyoXQxTqkqfzfHR2QjQl
	jdpFQq5odSmh1D9AVkNyAwETCzsKnJijtcj/EU3flMl0oXSW9DOAkJkF5F0jhu1LAg==
X-Gm-Gg: AR+sD12+7r5CvbiSKVwEkbCIMZuP2aQRuNp+A3NAfnDmuwFJLCNaPZfcVqKfROPwVVQ
	CBxzbWZWHrA1zgVnle0RbXYYUOEhi8Oe/zA1LgHrsCghGsFftffJ1C6UNNHng38nID5EY9Tc1AN
	rZkyiyJ7evAJBRZYR88b+90LHcd4BVVw+nZjWZ1XcgAak57w5pTFQV1TDt6gkNz+yqg+vY8FOXH
	85XcF2H7KnuYcygCi7PAA6auQSoDdlsDtjk/7b/+MH3bDQvFTFiIDX/Ckj/0HTLgKpMUUVPUDgB
	S/UsUKFPzmxSMq62HRuNR45yXlBXre/mbEsFJjzhQ8Mc8Gf2Hz7VTeWWHsXoNJCYdCgU2yddPJ9
	cKp89envF9ATMOyuFpa4+aQ5kYTYjGuTHJ3s7q7pJwfSD5qgJnCNxEy3byil7bXuV6XfrLPiatk
	3G+pP6ngh5enKq4XU/ZRkO5OV34hFr/XY0UOzXeJbmjuHqWYqGFo2xziVKudJG6Dr5EJKld9/T+
	38sMxiFcJDWLX/nvjktiaYACRrm2bhVFjdM6snup65h5w==
X-Received: by 2002:a05:6808:b3a:b0:4b2:8dbe:fff3 with SMTP id 5614622812f47-4b2cd80bee2mr4070622b6e.0.1787219566045;
        Thu, 20 Aug 2026 02:52:46 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6d34c8esm1286981b6e.13.2026.08.20.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:52:45 -0700 (PDT)
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
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 2/2] selftests: tc-testing: add u32 node ID pool exhaustion test
Date: Thu, 20 Aug 2026 05:52:36 -0400
Message-Id: <20260820095236.68390-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820095236.68390-1-jhs@mojatatu.com>
References: <20260820095236.68390-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdc test case (7ec8) that fills the u32 node ID space with 4095
auto-generated handles, then attempts to add a 4096th. On the fixed
kernel the 4096th filter is rejected with ENOSPC (exit 2). On the
unfixed kernel it silently succeeds with a duplicate handle.

Fixes: e7614370d6f04 ("net_sched: use idr to allocate u32 filter handles")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/filters/u32.json      | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
index b2ca9d4e991b..b9019b14d05c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/filters/u32.json
@@ -353,5 +353,28 @@
         "teardown": [
             "$TC qdisc del dev $DEV1 parent root drr"
         ]
+    },
+    {
+        "id": "7ec8",
+        "name": "Add u32 filter when node ID pool is exhausted (4096th filter rejected)",
+        "category": [
+            "filter",
+            "u32"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$TC qdisc add dev $DUMMY clsact",
+            "yes 'filter add dev $DUMMY ingress prio 1 protocol ip u32 match u8 0 0 at 0' | head -n 4095 | $TC -b -"
+        ],
+        "cmdUnderTest": "$TC filter add dev $DUMMY ingress prio 1 protocol ip u32 match u8 0 0 at 0",
+        "expExitCode": "2",
+        "verifyCmd": "$TC filter show dev $DUMMY ingress",
+        "matchPattern": "pref 1 u32",
+        "matchCount": "4095",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact"
+        ]
     }
 ]
-- 
2.43.0

