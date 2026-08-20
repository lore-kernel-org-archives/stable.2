Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476EC2F1FC3
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787219871; cv=none; b=fTlhog31uV2wlPzo4uz+9sGCtuswKTBngPebdXyZEQhh14cBhuXGbYznYAzytZ8X1a8CiRuM/nsbc9brn9CSt7bMLueKNAckkNdrsO4chhl+IYHLlTewidHXd6cNGyE23mo3todv5nN8SFPN2svmOmUKtezt+9xiEaMP/yRpvUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787219871; c=relaxed/simple;
	bh=15Cw9oblK/D1vb486tpmsk9GW0qXeom/MxvsqfjbR04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syKx+E0X8bMNhnADj9+R7/fFPlPDmxST1Y64sZFay2KwvDldtJaBLZn3gypS+j0X8uJ5KE9Q3ZmmteFZ6hxgDx8txJVaIsV9kVTAftpXa5DUaOrM9rsMPTBrs9U2M6oJJ6IVfShqEhHZRWpH2Dntg63IIRHWUe4dRDpxfUDAruU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=rseub10l; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="rseub10l"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90c50c2a257so21958206d6.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 02:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787219868; x=1787824668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yWiRk4eGbnJIOLSDci/J7Dj9lG9H1Q4ou0ubiJm1Mow=;
        b=rseub10lS0f0Y8gtYUfKPx9WxIHqL/psU1Z/DPU/GbBHh9lHt3Je8B+nYTTEgUyQZ7
         ab4ZXd67lFmBnbpHcHyvtCLCVXd6Ie29YMiHleOExr9KotFwjVqCms//tgUicyNTITcU
         Yt/wvmWzXTlPUvu99T767L8M4RSdfITIXkAfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787219868; x=1787824668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yWiRk4eGbnJIOLSDci/J7Dj9lG9H1Q4ou0ubiJm1Mow=;
        b=o3clCEG2/PH4ePds1m7PCvythp7CgsxMBaXXU5+WSS6oB1DtEcXKeJBoDs++LV3ZQt
         Ju1+KCDtwEPr59fEOET3BaZLVDo6CTlRw1dkGso8fBMHnCvNdnSHIgUXuhGFSgKWeULO
         FvpoPoQuPuxQu/Kco6jnu7lGNQpzX77t5vjx3X9U+d+98Rbi2rTI827mJ84uxIkoO0Cu
         1MPhE1NMcTOuWyv9dUgt2tII7qCxph+NP8zjY122xizDWUxRlMfh3VjdNdcnKbSp0YR7
         GYjMCjc3Zz9r2N3iu3XNTSU3torDAtvz1/DqpadXCSWmzWkCmFDs60zKIkpBFjrUlmGV
         UwMA==
X-Forwarded-Encrypted: i=1; AHgh+RpFVVBf/zt5dZHcTpUalI+HaR3pfcoemnhIsX6Ciz66DzODzwENBQiS528mY2EGFWTeLLo5mW0=@vger.kernel.org
X-Gm-Message-State: AFuF++m6LV/oYSSwYCmfJ7h4yP94pwfKS71oGlnbpkd3PPzXoak1tDDq
	0HMnQbjtHbNjCvCYMtPB40nLOv+ixl09hLVfZ7Pkwlj78KlIaFUHWvmI7FUpDRmHBA==
X-Gm-Gg: AR+sD112JF7J3XsmavzderZYs21HVy6gGFeCh2qyKUk2QxDT7DyKokq0YOIpU95LgV7
	1sdZmFn4QfMsfDHdewM+refDinxuQlJtqGOhcxR4ca5UYsBIAsqlZvLYmT3DYZGR0BCgPI8x/+F
	WAITvr7ho2yEXUHt68RotDVqF7V5rDYDYbHzR3Srx9TJpJoEY5jO/vF62BvPFZdGp7WtrfhlCbb
	7k6AvIx61AZhkM5w/AmgJDEtJEPpxLXj9bGJXmnIN67P8j+bcfBqVQ4D344x8cutgP0JOW8YIGt
	JR1GAMGL584iVZY82DSLJ6mgY+MUv895r9Fic/K0CpF8Vfcfcafafv+/dAFBZ9GOTMXkZ0DnJOL
	6OMKSlIxqzjzH1IIWRhwn2qGwu9FW+W3xMbe3LTDaF/pz3nvmSGXDkUnejGb0BTGKcWLePM7a3W
	xSM80doe61Rv6Oo17dApb5YnGdtfnN9ynBqlBQiPlDDD5Ttq0sOCcTElizeT+ZPy8skNxp51cyT
	GAVENSvWA6L1UqPA6ulPgQX8NzioimwT+ZJpcQTBput3Q==
X-Received: by 2002:a05:6214:4016:b0:8f0:2c80:caa5 with SMTP id 6a1803df08f44-90c5eb91f13mr95769106d6.23.1787219867923;
        Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c5f2b8164sm34565336d6.48.2026.08.20.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:57:47 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	"Victor Nogueira" <victor@mojatatu.com>
Subject: [PATCH net 2/2] selftests: tc-testing: add pfifo_fast ring cap regression test
Date: Thu, 20 Aug 2026 05:57:42 -0400
Message-Id: <20260820095742.68511-2-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820095742.68511-1-jhs@mojatatu.com>
References: <20260820095742.68511-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a tdc test case (0249) that sets a huge tx_queue_len (100000000)
on a dummy device and attaches pfifo_fast. On the fixed kernel the
ring is internally capped to 65535 entries, so the qdisc is created
successfully (exit 0). On the unfixed kernel the 100M-entry ring
allocation (~2.4GB) fails, causing the qdisc add to fail (exit 2).

Fixes: c5ad119fb6c0 ("net: sched: pfifo_fast use skb_array")
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 .../tc-tests/qdiscs/pfifo_fast.json           | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index 30da27fe8806..2cbe9738d699 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -105,5 +105,28 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "0249",
+        "name": "Create pfifo_fast with huge tx_queue_len (ring cap regression)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY txqueuelen 100000000"
+        ],
+        "cmdUnderTest": "$TC qdisc add dev $DUMMY handle 1: root pfifo_fast",
+        "expExitCode": "0",
+        "verifyCmd": "$TC qdisc show dev $DUMMY",
+        "matchPattern": "qdisc pfifo_fast 1: root",
+        "matchCount": "1",
+        "teardown": [
+            "$IP link set dev $DUMMY txqueuelen 1000",
+            "$TC qdisc del dev $DUMMY handle 1: root"
+        ]
     }
 ]
-- 
2.43.0

