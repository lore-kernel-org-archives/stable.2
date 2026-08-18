Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A71D3C1979
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 10:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787048266; cv=none; b=RH6DigqSH5lLc5FT+SCpJ1JCCMqT0Ykek5d4AEod/PVAFRxrDS8ndYNOBF0F9bLfxXsyVFwc+GXEXc6pX5fPTNpsTfqgdW4zPCvDS4dhrYQf6a+a4ybtuikqA7CRZqcTEabI5H+uyb9L0NLa3HnZODqEeFeb+QG6sW/dW1lHLkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787048266; c=relaxed/simple;
	bh=/I3fqurkIVvuHLg56QKuZbaJJhBk7ENuiTDNDBMN0Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o84f2dtgYMjA2mxq7bSChUFflXPhm4dag+/Bk7wu+F0txGIofavKEqzGhVTu95/Yis8iajSCKDrnVODemhiCZ6TRlsrfD1gLSsjw5hsjGeI6e0RSg/Soz6FP38Nrn6aQc7kVJvKvdnmmb9+J0UcFLXf0X2Gtej/vMssqDr9AAHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=IqIDnPTY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="IqIDnPTY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9349ad9c857so438990785a.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 03:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787048262; x=1787653062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gxq5ZSvaEO4ApbVTxKVnsTovrfCAc4uzDIUjvK/vOu4=;
        b=IqIDnPTYJbQiubqEUZk4klKwNvaDAl8UojdlM3oy2w6mcf5aJljMHnIM2cupcmmsx/
         e35at+V7d6BpIbm2QU51LX+u4WjootA8hDBCiYedTliE2ovvDCy7FVmcNoRJoOLVlI2W
         YZ9RqR9ROsZ+NQ+nQzGqwTVJt73M1G02/rhOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787048262; x=1787653062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gxq5ZSvaEO4ApbVTxKVnsTovrfCAc4uzDIUjvK/vOu4=;
        b=c/HgSBIGiHf9ZKnrmtC+aso53u2Zj/OYuXnINPIb2P1CML39Thoi3xqT7cQuZKCaYz
         rdVMAVdIWUJHdLVIQDpt2jcxRire66FnSQUNL/7nxbOxdQ2WTpH47cXTKtCy0ZAQrOju
         RHNxWb+QT7ucsjWFm7IzskYkt5jNyV5x0NZRXskQ2WCUCf8JiKElMpHuXng8ZLYdNY5y
         R+ZRoeMB97TKkZL17i+xd1Gh8jZKYcHUgXaGBOo8VPxRrb+PjbkFK9rHJFo+Rg4EiD3D
         bWOPuX5yL9zr7IAru1lOsp8E4xX4iO1qG1By0PuLUuGtpz8fxqrKYc/twHbUBO2JXowe
         sYBw==
X-Forwarded-Encrypted: i=1; AHgh+Rop5buP6m/JKwzjciJpbbAq2eTHRIo6bTdFCqhOoHjY7/iRoAOMUTWue5bwEvmrmk3uYGFwo9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/pa/moW0+n+RlYXmptTlt7UhuE31MbVWB4G8jr2owppTngRqG
	Z1sBW5D69oXNcd7aGym5cvlV1NiEa2IAKWZNBPLWmGOfmuf2gGZuvctFlpzMAP+RCQ==
X-Gm-Gg: AR+sD13glisLxTQd01kcfkL1dY8/briwsriM7eUWgqT+0WcYDoccLncNG+qNQ0hLjPr
	amUavaBccAdGTYzpwCJGyke+PwlA0aTviQmvJldT5yPS2IX8GOlckt3e9H9r5wGEySXqYKwbxNE
	tbsxcOz5alDtvDShT2c6FrN6bMAeHtvX5RZfQss69+h+xWL0VvbA1XCt9E/ljZCiRWcosaCP3NS
	aVgbIJAyALc5ICpYcViU3HCO+aigHoD5bnCmrrdUoGTXq5BlaiYeiueJbkQdkc8t3JJhLkbRJFW
	OyPpyZKfEWV/MhNrSXebB11uN7KvxsUYgPQaXSrCOPlOUXRNw7AI/i8N+iijkqiu1XrOtmROXfE
	X1WE86uJOQ4jH4mH4+7dqDN5nbH3weC7A/dug0YkeQAk9qj6qUc7telWX9HXWcJ1AbthWBUl/v4
	YBs654iSfSgSz0nDQga3iQMKt7Oe1cC1GFGoQDj6PYJgzUJdqvrFMg7RaajbK6hV2iRBnOFmhkO
	GrAs1o/bYNpX541Uaqon1KId6pL2Hw24lpeb5t2FdDFfg==
X-Received: by 2002:a05:620a:284f:b0:92e:8a8d:ec1f with SMTP id af79cd13be357-936d22ce70emr3509189485a.24.1787048262181;
        Tue, 18 Aug 2026 03:17:42 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937010e7fc0sm299346985a.20.2026.08.18.03.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 03:17:41 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net 2/2] selftests: tc-testing: add TCA_STAB overhead rejection tests for DRR and ETS
Date: Tue, 18 Aug 2026 06:17:35 -0400
Message-Id: <20260818101735.16655-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818101735.16655-1-jhs@mojatatu.com>
References: <20260818101735.16655-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tdc test cases that verify a qdisc with an oversized TCA_STAB
overhead (2147483000) is rejected. Without the fix, the qdisc is
accepted and a single packet drives the deficit loop into a soft
lockup; with the fix, the add fails with -EINVAL.

Reported-by: vega@nebusec.ai
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-testing/tc-tests/qdiscs/drr.json       | 20 +++++++++++++++++++
 .../tc-testing/tc-tests/qdiscs/ets.json       | 20 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
index 2b61d8d79bde..7713eb35aaeb 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/drr.json
@@ -86,5 +86,25 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY root"
         ]
+    },
+    {
+        "id": "d1e2",
+        "name": "Reject DRR qdisc with oversized TCA_STAB overhead",
+        "category": [
+            "qdisc",
+            "drr"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab overhead 2147483000 drr",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc drr",
+        "matchCount": "0",
+        "teardown": [
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
index ee09e6d6fdf3..da7ae626f7e1 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json
@@ -1007,5 +1007,25 @@
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "f3a4",
+        "name": "Reject ETS qdisc with oversized TCA_STAB overhead",
+        "category": [
+            "qdisc",
+            "ets"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root stab overhead 2147483000 ets bands 1 strict 0 quanta 1",
+        "expExitCode": "2",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc ets",
+        "matchCount": "0",
+        "teardown": [
+        ]
     }
 ]
-- 
2.43.0

