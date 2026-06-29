Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD793DD523
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 10:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782728540; cv=none; b=h0l6UQOc4nLe7Okcyh/8i7IbIdlo9r4AnKjsniPTEJArsXC96H7KNkD3TQFRs4gtqWow2TYCYJoasQnHDoOmuqXZY+ueTLblyNzwGmDsePMsyGfV5G9mJ1HPIB2A/TF1xHNhmkLN/sZ2j85tRkqae6mqpuAHSiSj/4j9LBknojI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782728540; c=relaxed/simple;
	bh=ASAsNjpJiL0iDVuRoTSS0v6raFdvNBmTaG2/7A8pzxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqYYDYgx0VIefNOKkcXTbPe0jtMPVGTuJKOArbeB9Oyxhj9osKrX+eX+CQ9LZSgl40oMXwGaeFfD5YMMvETI1B4bif31yHlNInVHknwT6q/u7tmV7pXoxMPOIMY353ojiBAvYS96O8t17/UvBiQigrIhtw1Gttc70iMvElX+Qkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=ylhoM19q; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="ylhoM19q"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e512a9a6bso58787085a.2
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 03:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782728537; x=1783333337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6bI9WxCTH9AmhFxJspc0SFcU/tfRkGjHjpW70ODuqE=;
        b=ylhoM19qGyOxC1WhFhpR5C535vL2CizSA3Go8seV8tMjid/3nZM+2KY1JgdlZUTY4r
         LhcWBVqQLw1xKnrBXcldnEZLyPJTma0kyheOVnaB3ULe+Qn+4b/0rCyTKvrbXnlXjyDm
         BvMh+rGg/2O+aJs0WYCrxd7UhfOHWMbZVUJgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782728537; x=1783333337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=q6bI9WxCTH9AmhFxJspc0SFcU/tfRkGjHjpW70ODuqE=;
        b=rae4bCw/u39OiUOs/h3sRnhX6jFy/2WglcqOHy2kq8zGCQ/si7LMLFl9bKMBq54HUn
         iQk5sln4VpXqIoOqs/LbIlsxi+oWmtXaABnBXa9YSiumVbDBSfDFGseDmu84x3dFKlua
         D/fzqd0ojeuzDb8sHz2Yvj+9ugOQ1Y9bpgPBa9ZLml85VmfFwJsLukcXgjMsyhs+SGbF
         T1TbzGazzFsOo5MWL8/hhcm77ZJwk82lsoJ+iWvRo6+KiM2S6TYHmRWMxsjT+r/lpITl
         Ajhey65ywFgkK5IsW89ElRt8LgyLj5Ypr58ZtcWpLf++nNn6feX79ozS/2Ndvg6AzCC/
         E/GQ==
X-Forwarded-Encrypted: i=1; AHgh+RqQJyKKKMIsFfaQ6OReG06+Xh8Zj8CE27PyXPPg/tQVhTbcJfCpJ/zzashRUkdcV9wMhyBvlNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9p3fDjo/XstdQCh8+mRN4wQoysTyZUq73TUVZGnx+MuzF+qy
	tZAcpN7l9TgTccAey5KAvbSRPYhGKDUIISWVmk1p2miOk9bMO+d9+/3Nz7wchqTf+g==
X-Gm-Gg: AfdE7ck3wdjyt2P50Q8xdANxpCdnQ2yvhuz7kpuMh22TQ+wJDR3GeKiK4n4TVIFiakO
	jAdYuBvIv9wzLI/Frm1Mo1dTfapIcGtlfdhJmhr5slrzyPIGz8ciE4Iq5tw/ZPHdMLf0F60tgSE
	x0p6OGBw6KXMTxx3FJUlJoWnH41nRaiKzROXs12Q3VT1HtTHAzz6y44LzvFYzpoWNrqT7MyrtEa
	5OpgLgDN2vW2D0sl9pZZs+qHsM8aRGCDXTS6MALihPUXio37dwDjjaRRlFKgd0YXjdiyiQyJPsi
	1a4d3nksZTuFmt3+46wxQKoNbJvKYYzoPiskWvh9rP28HeoOb5W0HV58ZdCFKHXMlVCS1k8pWlW
	8jFtT5/4w5ME13klZ7SLr1hPwxChowh3CkAeHcTqhqZ9SDuH8pOKoKpe5w3Bf19AiFyFQ3W3sGA
	L2I2loIA==
X-Received: by 2002:a05:6214:5292:b0:8ba:3fc9:88ca with SMTP id 6a1803df08f44-8f159d1344fmr1534206d6.39.1782728536829;
        Mon, 29 Jun 2026 03:22:16 -0700 (PDT)
Received: from majuu.waya ([184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ef0f2b9df0sm53589236d6.13.2026.06.29.03.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:22:16 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	toke@toke.dk,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	security@kernel.org,
	stable@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 3/3 v2] selftests/tc-testing: Verify bpf redirect on RED block with preceding clsact (egress) classifier
Date: Mon, 29 Jun 2026 06:21:57 -0400
Message-Id: <20260629102157.737306-4-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629102157.737306-1-jhs@mojatatu.com>
References: <20260629102157.737306-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Nogueira <victor@mojatatu.com>

The bpf_net_context used by sch_handle_egress() is stack-allocated and torn
down in that function. By the time tcf_qevent_handle() runs
current->bpf_net_context is NULL.

When a filter attached to a qevent block (e.g. RED's early_drop or mark
qevents, which always uses shared blocks) returns TC_ACT_REDIRECT,
tcf_qevent_handle() calls skb_do_redirect(), which in turn calls bpf helper
bpf_net_ctx_get_ri(). That helper unconditionally dereferences
current->bpf_net_context resulting in a NULL pointer dereference.

Add a test case that reproduces this scenario by attaching a filter to
clsact (egress) and a bpf filter to a block attached to RED. Use TBF as
red's parent, so that  a traffic burst builds backlog and RED early-drops
triggers the block filter.

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 .../testing/selftests/tc-testing/action-ebpf  | Bin 856 -> 9072 bytes
 tools/testing/selftests/tc-testing/action.c   |   5 +++
 .../tc-testing/tc-tests/infra/qdiscs.json     |  32 ++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/action-ebpf b/tools/testing/selftests/tc-testing/action-ebpf
index 4879479b2ee5c046279be0fe8f9ca313dfb7e618..52c47e42bf0af024a073cacc823c8270f906a8df 100644
GIT binary patch
literal 9072
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

delta 317
zcmez1c7tt#hG+yM0~|PjSq=;w6K#!|-2;3kf8>;vbYoy(U}5<9A1sGNNKf7<Ebhb3
zz`!8HzycRnfU;~E7#IW@SfM<S2@oa|GYf-WNoqw2Lt=7CW`16Lc0QD)n?2b|MpptN
zte4E7S6ot5l9<GxS6rD}l9)7kqm2C|E)G_I1_lP^$saj|Cx1|60h=E`IZ#f0vW2V#
zqw3^BS$jso$s1+u8SN$;%84@;O!kyhXVjnkQAu3%1H=Uk%upKSbcV@=a>A_P3=9lR
YATu>8pmH!86gW%_3=AAlaS1350I>8ljQ{`u

diff --git a/tools/testing/selftests/tc-testing/action.c b/tools/testing/selftests/tc-testing/action.c
index c32b99b80e19..350f2d36a773 100644
--- a/tools/testing/selftests/tc-testing/action.c
+++ b/tools/testing/selftests/tc-testing/action.c
@@ -20,4 +20,9 @@ __attribute__((section("action-ko"),used)) int action_ko(struct __sk_buff *s)
 	return TC_ACT_OK;
 }
 
+__attribute__((section("action-redirect"), used)) int action_redirect(struct __sk_buff *s)
+{
+	return TC_ACT_REDIRECT;
+}
+
 char _license[] __attribute__((section("license"),used)) = "GPL";
diff --git a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
index a1f97a4b606e..762f86ceab1c 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/infra/qdiscs.json
@@ -1540,5 +1540,37 @@
             "$TC qdisc del dev $DUMMY root",
             "$IP addr del 10.10.10.10/24 dev $DUMMY || true"
         ]
+    },
+    {
+        "id": "fb8d",
+        "name": "Verify bpf redirect on RED block with preceding clsact (egress) classifier",
+        "category": [
+            "qdisc",
+            "red",
+            "qevent",
+            "clsact"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "$IP addr add 10.10.10.1/24 dev $DUMMY",
+            "$IP neigh add 10.10.10.2 lladdr 02:00:00:00:00:01 dev $DUMMY nud permanent",
+            "$TC qdisc add dev $DUMMY handle 1: root tbf rate 1Mbit burst 10K limit 1M",
+            "$TC qdisc add dev $DUMMY parent 1:1 handle 11: red limit 1M avpkt 1400 probability 1 burst 38 harddrop min 30000 max 30001 qevent early_drop block 10",
+            "$TC qdisc add dev $DUMMY clsact",
+            "$TC filter add dev $DUMMY egress protocol ip prio 1 matchall action gact pass",
+            "$TC filter add block 10 protocol ip prio 1 matchall action bpf obj $EBPFDIR/action-ebpf sec action-redirect"
+        ],
+        "cmdUnderTest": "bash -c 'data=$(head -c 1400 /dev/zero | tr \"\\0\" \"x\"); exec 3>/dev/udp/10.10.10.2/12345; for i in $(seq 1 8000); do printf \"%s\" \"$data\" >&3; done; exit 0'",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -s filter show block 10",
+        "matchPattern": "Sent [1-9][0-9]* bytes [1-9][0-9]* pkt",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $DUMMY clsact",
+            "$TC qdisc del dev $DUMMY handle 1: root",
+            "$IP addr del 10.10.10.1/24 dev $DUMMY"
+        ]
     }
 ]
-- 
2.54.0

