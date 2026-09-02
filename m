Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A72480DEC
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384576; cv=none; b=UaOpzbogt0Duw8PwwaHqrU8vU3rjQXP/vgxihGZAdanCOhnzsRzo479SstHAwn9K6F/4WISyZK15r1LKDVwzNj+Quf72S3WkdhSLTzme5hxhfk4eH3flE5Dc83Iif+bkOxT1IJ5Q3xx7m+n/0mBMR1oKnp5B/LtpLjLHJTkbdas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384576; c=relaxed/simple;
	bh=fnCzv/03dRMIFg8h/PiBArxECEmb72z9bWTPFi3bqlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aqs6whKPNKxSpe34fMp/lNCUk0v0bgR1RKUw2s3KaO8NGBqG+b8hXIkAkv6Ke1HjsWi9/4W8Z5KeiDZvpGXx1NjMk6SBSFbqqspUulcClGQlsA2OkxpDlXcoKpEzvXnicNdbmziHVAUQtX+3aem9J9kfv74byx6NlDpmuAs8NpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=QE6ArFXo; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="QE6ArFXo"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-936c02e58dfso154104885a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 14:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1788384561; x=1788989361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tFXRNdSb9HwrsFgIcOd49WRWmMxbjwRabQG24eFpDYk=;
        b=QE6ArFXoyKnQsFwbaYBIOauwjzVwMBgye2m8naqzPwwA+diau/GOnhfwnAnv4Xkl1A
         N77SbMj4+fBzf6aj12CD1xpq+CZFt/7XbC47Gn+YrOHrzkCKISJHbIRntTymiuuWI8+/
         vfq6YAfZc4UVKjuJqR7N7q+RgKr6lo2KwoPeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788384561; x=1788989361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tFXRNdSb9HwrsFgIcOd49WRWmMxbjwRabQG24eFpDYk=;
        b=NOUQdE/q+0UQl3WppC8EH7ZNV+947SKaMGPEeRYJBHKLm3DwyHyYFjdwftp+0WwYv3
         cinhA6XHNa03XG7cJ9g0Uajtx0/tehDRU5kD7Dqn3jrtwAyLY3DQpYWlLZRlIT0D3mZd
         POzYRoyy9x08OQkZY0fSY6SlKr7vcAAkkSbYzab0ex7G46nEJR0Abql5hzj6N7j5FgCi
         zVdMgZXOSt669RyRhVzxw9mhKZBAXqGeEeAkG3SAZGix45j5KLYnwdG52zv9zzhH2mll
         w6EYPjzQb1SLPXEqjqdr9BawAEXpjbU+5WA5WIfSO7zkLTUoHbIxY/+4z0udOhzTn/Xt
         n05Q==
X-Forwarded-Encrypted: i=1; AKwUvBz1jT5r9nVoUu6jiKtdUvRUMquUEWcbQbaBpNOAUpTV5rkAY42wXPjrh/zSaiSUvhyXsRNLKRI=@vger.kernel.org
X-Gm-Message-State: AFuF++lDtnRydgw+bOB3Xwafwxe1YlQ4B/bhpFDWfeZV422DxnzEvp0i
	c/tr6la/2x3FlsoS71TCyUDYLU/JZsfpBPOssgLyHDF7jEaRCf7czcxQubReQP7KKw==
X-Gm-Gg: AYBFou3dtf/uCLCYRvVDe2/imP+e53ldeoLB5m7vwysyR8u3T4tESa98xLMsi4UJllH
	KqyoWi6qW9CZDFzUTLtXWtTl/CStpHOlNyuztESn8Sm4qO2njWYPaEOb5UrTgc3Bq1vcmKFUat+
	Z0ctJ5xBV0lZKVI47RR8pNlum7WzVdz9HDfmluB/oj/TGIjHoqHaw2ozSmvfOhqnmgzCnKnwan8
	zSLtVHFCI6jFAh4M5p0sP91N4wmNlOdYz95wsqgO0lCiLXSe4VGyNjqc40t8fIrDwwwDNipXDLT
	hAuHBEJfy9L96qhQ7tYyOlZPGGcOaQZ/eTH9K7wudCRT7mQAm2//mUx3Bj5DFfFpwoJR6MvGBKT
	10yYTjuDuTAyaVnYMQtpp0ituMUz2eN3712gBw11PHCnfKvRBZ8Z0iU6LtNyBI4QwKKyVVBM7tv
	+ViZrQ1vfdyeUuojLf5XN2VQlDEleE86Ceacn7QvGJTwO4RmOwyd0jNPIWwudYMTadzl0jwgsP6
	nGl/6aImsLbqHN7u1nPghhyHG22C0jWIboZzQ==
X-Received: by 2002:a05:620a:2589:b0:937:6ed3:78d with SMTP id af79cd13be357-93960f3bc9fmr959524385a.20.1788384561076;
        Wed, 02 Sep 2026 14:29:21 -0700 (PDT)
Received: from majuu.waya ([142.159.91.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9ee08710sm27169086d6.2.2026.09.02.14.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 14:29:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	stable@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Vega <vega@nebusec.ai>,
	Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH net v2 3/3] selftests: tc-testing: add tx_queue_len cap regression tests
Date: Wed,  2 Sep 2026 17:29:10 -0400
Message-Id: <QDISC-2899.v2.20260901233641@mojatatu.com.3>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-2899.v2.20260901233641@mojatatu.com>
References: <QDISC-2899.v2.20260901233641@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nine test cases for the S16_MAX tx_queue_len cap to the
pfifo_fast suite. Netlink cases exercise the ifla_policy bound
(2/3); the two new sysfs cases exercise the netif_change_tx_queue_len()
choke point that 1/3 owns (SIOCSIFTXQLEN shares it; the ioctl is not
portably reachable from tdc):

- dbe3: set txqueuelen 32767 (S16_MAX) - accepted, pins the exact
  boundary value.
- b50e: set txqueuelen 32768 - rejected with -ERANGE.
- 40f8: write 32768 to /sys/class/net/*/tx_queue_len - rejected
  (covers patch 1/3 directly; netlink cannot reach this path).
- 4b6e: write 32767 via sysfs - accepted, boundary positive control
  for the patch-1 path.
- b90d: create a dummy with txqueuelen 32767 - accepted.
- 57ab: create a dummy with txqueuelen 32768 - rejected at netlink
  parse time.
- e777: create a dummy with txqueuelen 500000 - rejected (the v1
  bypass path flagged by review).
- 31ac: create a veth with an oversized txqueuelen on the peer nest -
  rejected (the peer nest is parsed against ifla_policy too).
- b567: create a veth with txqueuelen on both ends within the cap -
  accepted (positive control for the peer nest).

The three negative-creation verifies assert device absence
("ip -o link show" must not contain the device), not merely absence
of a qlen pattern - the device does not exist when creation fails, so
the exit code carries the signal and the verify adds content.

The v1 04b5 "resize rollback" case is dropped: with the cap checked
first, netif_change_tx_queue_len() returns -ERANGE before the write,
the notifier or any qdisc resize, so the case exercised no resize and
no rollback. It was also nondeterministic: pre-patch, the resize
issues three ~11 MB kvmallocs for qlen 500000 which normally succeed,
so the case passed on an unfixed kernel only under memory pressure -
its outcome depended on the test host's free memory.

Test commands run inside the netns, but nsPlugin creates the veth
peer in the root namespace, so the teardown deletes the in-ns end
only; deleting the peer via the pair is implicit.

Note: iproute2 treats "txqueuelen" appearing after "type X" as a
link-type attribute and silently drops it, so the creation cases
place it before "type" to actually reach the kernel.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
Changes since v1:
- new patch: rebuilt tdc coverage for the v2 series (drop
  nondeterministic 04b5; boundary pair + create-path + peer-nest)

Internal review (i1) changes, 2026-09-02:
- add sysfs coverage (40f8/4b6e): the seven v2 cases all drive
  netlink and exercise only 2/3; patch 1/3 owns sysfs+ioctl
- strengthen the three negative-creation verifies (57ab/e777/31ac):
  assert device absence instead of pattern absence on a nonexistent
  device (vacuous before)
- fix the Cc: header (recipients were folded into To:)
- drop the no-op "$IP link del dev $DEV0" teardown (peer lives in
  the root namespace; deleting $DEV1 removes the pair)
- subject prefix: selftests/tc-testing (conventional for the dir)
---
 .../selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json | 204 ++++++++++++
 1 file changed, 204 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
index 30da27fe8806..a6e25e76ecb1 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/pfifo_fast.json
@@ -105,5 +105,209 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "dbe3",
+        "name": "Set tx_queue_len to S16_MAX boundary (32767 accepted)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$IP link set dev $DUMMY txqueuelen 32767",
+        "expExitCode": "0",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 32767$",
+        "matchCount": "1",
+        "teardown": []
+    },
+    {
+        "id": "b50e",
+        "name": "Reject tx_queue_len above S16_MAX at set time (32768)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "$IP link set dev $DUMMY txqueuelen 32768",
+        "expExitCode": "2",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 1000$",
+        "matchCount": "1",
+        "teardown": []
+    },
+    {
+        "id": "40f8",
+        "name": "Reject tx_queue_len above S16_MAX via sysfs (32768)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "sh -c 'echo 32768 > /sys/class/net/$DUMMY/tx_queue_len'",
+        "expExitCode": "1",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 1000$",
+        "matchCount": "1",
+        "teardown": []
+    },
+    {
+        "id": "4b6e",
+        "name": "Set tx_queue_len to S16_MAX via sysfs (32767 accepted)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [],
+        "cmdUnderTest": "sh -c 'echo 32767 > /sys/class/net/$DUMMY/tx_queue_len'",
+        "expExitCode": "0",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 32767$",
+        "matchCount": "1",
+        "teardown": []
+    },
+    {
+        "id": "b90d",
+        "name": "Create device with tx_queue_len at S16_MAX boundary (32767 accepted)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$IP link del dev $DUMMY",
+                0,
+                1
+            ]
+        ],
+        "cmdUnderTest": "$IP link add dev $DUMMY txqueuelen 32767 type dummy",
+        "expExitCode": "0",
+        "verifyCmd": "$IP link show dev $DUMMY",
+        "matchPattern": "qlen 32767$",
+        "matchCount": "1",
+        "teardown": [
+            [
+                "$IP link del dev $DUMMY",
+                0,
+                1
+            ]
+        ]
+    },
+    {
+        "id": "57ab",
+        "name": "Reject creating device with tx_queue_len above S16_MAX (32768)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$IP link del dev $DUMMY",
+                0,
+                1
+            ]
+        ],
+        "cmdUnderTest": "$IP link add dev $DUMMY txqueuelen 32768 type dummy",
+        "expExitCode": "2",
+        "verifyCmd": "$IP -o link show",
+        "matchPattern": "^[0-9]+: $DUMMY",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "e777",
+        "name": "Reject creating device with oversized tx_queue_len (500000)",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$IP link del dev $DUMMY",
+                0,
+                1
+            ]
+        ],
+        "cmdUnderTest": "$IP link add dev $DUMMY txqueuelen 500000 type dummy",
+        "expExitCode": "2",
+        "verifyCmd": "$IP -o link show",
+        "matchPattern": "^[0-9]+: $DUMMY",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "31ac",
+        "name": "Reject veth peer nest tx_queue_len above S16_MAX at create",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$IP link del dev $DEV1",
+                0,
+                1
+            ]
+        ],
+        "cmdUnderTest": "$IP link add dev $DEV1 type veth peer name $DEV0 txqueuelen 500000",
+        "expExitCode": "2",
+        "verifyCmd": "$IP -o link show",
+        "matchPattern": "^[0-9]+: $DEV1",
+        "matchCount": "0",
+        "teardown": []
+    },
+    {
+        "id": "b567",
+        "name": "Accept veth peer nest tx_queue_len within S16_MAX",
+        "category": [
+            "qdisc",
+            "pfifo_fast"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            [
+                "$IP link del dev $DEV1",
+                0,
+                1
+            ]
+        ],
+        "cmdUnderTest": "$IP link add dev $DEV1 txqueuelen 100 type veth peer name $DEV0 txqueuelen 200",
+        "expExitCode": "0",
+        "verifyCmd": "$IP link show",
+        "matchPattern": "qlen (100|200)$",
+        "matchCount": "2",
+        "teardown": [
+            [
+                "$IP link del dev $DEV0",
+                0,
+                1
+            ]
+        ]
     }
 ]
