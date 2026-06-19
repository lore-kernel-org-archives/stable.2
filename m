Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EA02C029D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882171; cv=none; b=htUy8Yv2UQepaeeC3GdyljalkUtsryWhIxOMSwpZR9rLXmBDXnhUbsXf3PvDvzEOymEx4NrwEu01Kq2q/SbP0IRLfF29NeWlTCnw7awPRpidMt8eWwlKFH+IyBbG5FOJUPzpNmHX6Uu+x+87OyHadd0S6akgEwixY6H0dJK0VMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882171; c=relaxed/simple;
	bh=yrM5OO9S72ojRQbz4TpJns2tN37h8f8DLKFgCZmRv4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdA9gbp3ulrTcVDPr48id4MldotNRmSAPyLRlWRnww+Zx7bBGNpngjsLUO3JNFvfubvcQZ8Pg7T+Iy/ISXWXIYb1Xlw3rzVkdVx/Dl0FeXLGJYoZcaJs2Xmoean0U0pvWLGp1GpuIZ46YSok8BKKC7c62+yVxhY43hVUB4xkgJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=VtK7LiPn; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="VtK7LiPn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781882167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wb88phcKJT+f+2SK9GFhsWNRHlWhBZE168HrCznh2ZA=;
	b=VtK7LiPnKx0md0rLt001UVQY8qOvyS6MaFMjTbrfw6/bOGSES3sRnoCxSsC65uZdynPVkw
	HjwPxKKGtqhr4BA6iJICnfcMtC2jbvgBeyj5wvj6lFuTlak110Xsxz4GtYcn564TFsdQyZ
	kcBphUROXeC8fdvqZhsmP0MuySQePsnBLIj2QJoID69GILhwax026HnJDPOdmwNl0Cnl2n
	3mEHblT4mu5JfZjeSxOqtZtK0dlVkwYK7sFEWrup5PmTd7uC5u8TXnkjqbtQjVAEa0Pkd9
	wIIWuPxF0Xl+iImh+XFDpQ5ZPASu0W9Rd3r0lwTKna3F+XRHvPM+NKiskqvw8Q==
From: Xingquan Liu <b1n@b1n.io>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] selftests/tc-testing: Add DualPI2 GSO backlog accounting test
Date: Fri, 19 Jun 2026 11:13:48 -0400
Message-ID: <20260619151447.223640-2-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
References: <20260619151447.223640-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a regression test for DualPI2 GSO backlog accounting when it is
used as a child qdisc of QFQ.

The test sends one UDP GSO datagram through a QFQ class with DualPI2 as
the leaf qdisc. DualPI2 splits the skb into two segments. After the
traffic drains, both QFQ and DualPI2 must report zero backlog and zero
qlen.

On kernels with the broken accounting, QFQ can keep a stale non-zero
qlen after all real packets have been dequeued.

Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
 .../tc-testing/tc-tests/qdiscs/dualpi2.json   | 44 +++++++++++++++++++
 tools/testing/selftests/tc-testing/tdc_gso.py | 43 ++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100755 tools/testing/selftests/tc-testing/tdc_gso.py

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
index cd1f2ee8f354..ed6a900bb568 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/dualpi2.json
@@ -250,5 +250,49 @@
         "teardown": [
             "$TC qdisc del dev $DUMMY handle 1: root"
         ]
+    },
+    {
+        "id": "891f",
+        "name": "Verify DualPI2 GSO backlog accounting with QFQ parent",
+        "category": [
+            "qdisc",
+            "dualpi2",
+            "qfq",
+            "gso"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP link set dev $DUMMY up || true",
+            "$IP addr add 10.10.10.10/24 dev $DUMMY || true",
+            "$TC qdisc add dev $DUMMY root handle 1: qfq",
+            "$TC class add dev $DUMMY parent 1: classid 1:1 qfq weight 1 maxpkt 4096",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 2: dualpi2",
+            "$TC filter add dev $DUMMY parent 1: matchall classid 1:1"
+        ],
+        "cmdUnderTest": "./tdc_gso.py 10.10.10.10 10.10.10.1 9000 1200 2400",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -j -s qdisc ls dev $DUMMY",
+        "matchJSON": [
+            {
+                "kind": "qfq",
+                "handle": "1:",
+                "packets": 2,
+                "backlog": 0,
+                "qlen": 0
+            },
+            {
+                "kind": "dualpi2",
+                "handle": "2:",
+                "packets": 2,
+                "backlog": 0,
+                "qlen": 0
+            }
+        ],
+        "teardown": [
+            "$TC qdisc del dev $DUMMY root",
+            "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
+        ]
     }
 ]
diff --git a/tools/testing/selftests/tc-testing/tdc_gso.py b/tools/testing/selftests/tc-testing/tdc_gso.py
new file mode 100755
index 000000000000..b66528ea4b68
--- /dev/null
+++ b/tools/testing/selftests/tc-testing/tdc_gso.py
@@ -0,0 +1,43 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+tdc_gso.py - send a UDP GSO datagram
+
+Copyright (C) 2026 Xingquan Liu <b1n@b1n.io>
+"""
+
+import argparse
+import socket
+import struct
+import sys
+
+UDP_MAX_SEGMENTS = 1 << 7
+
+
+parser = argparse.ArgumentParser(description="UDP GSO datagram sender")
+parser.add_argument("src", help="source IPv4 address")
+parser.add_argument("dst", help="destination IPv4 address")
+parser.add_argument("port", type=int, help="destination UDP port")
+parser.add_argument("gso_size", type=int, help="UDP GSO segment payload size")
+parser.add_argument("payload_len", type=int, help="total UDP payload length")
+args = parser.parse_args()
+
+if args.gso_size <= 0 or args.gso_size > 0xFFFF:
+    parser.error("gso_size must fit in an unsigned 16-bit integer")
+if args.payload_len <= args.gso_size:
+    parser.error("payload_len must be larger than gso_size")
+if args.payload_len > args.gso_size * UDP_MAX_SEGMENTS:
+    parser.error("payload_len exceeds UDP_MAX_SEGMENTS")
+
+SOL_UDP = getattr(socket, "SOL_UDP", socket.IPPROTO_UDP)
+UDP_SEGMENT = getattr(socket, "UDP_SEGMENT", 103)
+
+sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
+sock.bind((args.src, 0))
+
+payload = b"b" * args.payload_len
+cmsg = [(SOL_UDP, UDP_SEGMENT, struct.pack("=H", args.gso_size))]
+
+sent = sock.sendmsg([payload], cmsg, 0, (args.dst, args.port))
+sys.exit(sent != len(payload))
-- 
Xingquan Liu

