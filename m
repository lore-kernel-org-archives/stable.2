Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427062;
	b=3y73xgvPbkpdLp5OPhZFteHmD3sESFOHzbV+Fjg57yqOXDFB3wBio7LWKJ9PEjet8+b/
	 T1vTwqSPJFzF743ulqekZdpnKXdCmn78o+KNM8+wKq4+vI6N7yJhCgzeyeT6wEdNoBcRB
	 Qr08j/r7SacvXruGuvBgc+smdQU6z4nwwmPriBqIVm2+uifqPQXVUVAKoYS2Ad31ZtDLK
	 USSiODsubov3VLpNw1pUMo66cNzOQ0ArwRPhvEznT7reUp5pIC3pQrm0yrOQZm70eDb9O
	 RUxT2RLdXzYK2QMdrYoW5YlgQlgUhze0EE0r0aA4la9IdNPZis5TWxbDJ7iC2/dt/JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427062;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=U4IXXMcC7cdP3dcXyehvU/a2apzs/cu4mCfmZw2dIUM=;
	b=PFhDtfxMIh5AtXe1qemniO4mk5Q4NIAUS2BNIicePB/nYrqTV2bW9nF/FZCWd1tfsn/L
	 gmQHscfVZc/NAaAp56i5kkT06ZA0yfOL7ARjcuvDKJ327zkxofkGTUxmd2nlvi/rFv8u1
	 bCQG9t/ZHr9zkyIzFcDyjMo9k5Fm3I7ZB4FmfIqYbYcn5UeQG7S5DAmMUVNol49GOE40U
	 LnUru8PFGkSZIDSWTQU05eA0aaCGBYyWos8nhaidghw2SlNH8ywvpIHt79Cmcs9wvKyhH
	 1Vcq9ldVM3pf9ybuamBLacZSRYFJxIg60uFBEvKuTBiz7DBAodJoawuO28Bm5LTXoLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FvA6T71E;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IZ7IWt9a;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A13606A31E;
	Mon, 23 Nov 2026 09:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63A13606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=FvA6T71E;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=IZ7IWt9a
Date: Mon, 23 Nov 2026 09:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=U4IXXMcC7cdP3dcXyehvU/a2apzs/cu4mCfmZw2dIUM=;
	b=FvA6T71E6M5W7kI18MyoIEDj6tNSPURYCPr02vtuI4bWOZfFotMptHvUI0iV/MD+ossP56
	ePL2DMc+akZUkOHt+fnjOsBpJ2gb4EuIg3t+zwmJpoCzcJym2Niwv+uvxbuhiC0ShBwvkB
	zTtMXSgPij0hX3iPyYUsUbTyQd7aTwRFRdt915zfFANik+Gh1p/ATGF+z6LRqj1EJW7dv6
	4ikR2EuFaWP5rClBfSqn6LdOsFyJmrffgq3TT2Oeq4GC7/bVXHUZwYu2Leeea/ZjABmFML
	qp/oULbGzU1P8fIvGuStamyvFmHsDXdeVkT9232+U8X8kKpcyadk3GsNK18GHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=U4IXXMcC7cdP3dcXyehvU/a2apzs/cu4mCfmZw2dIUM=;
	b=IZ7IWt9aQeJctaS89oJeCQwXiLqwgPq3/YTqHI53wkZ2c5aV0wjkgRk8xOyCregk+sahDd
	D1bKoG7GGNeGwFBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_pmu_register() sysfs race
Cc: Hanxiang Xu <xuhx@hust.edu.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179542705589.92412.1823103275393818072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     dd1e556d9a5aef3e731fbe31ae43d9b4eaf05c1b
Gitweb:        https://git.kernel.org/tip/dd1e556d9a5aef3e731fbe31ae43d9b4eaf=
05c1b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Nov 2026 14:15:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:37:47 +01:00

perf/core: Fix perf_pmu_register() sysfs race

Only expose the sysfs files after fully initializing the data they expose.

Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
---
 kernel/events/core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f424b72..a2e4b07 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13012,12 +13012,6 @@ int perf_pmu_register(struct pmu *_pmu, const char *=
name, int type)
 	pmu->type =3D pmu_type.id;
 	atomic_set(&pmu->exclusive_cnt, 0);
=20
-	if (pmu_bus_running && !pmu->dev) {
-		int ret =3D pmu_dev_alloc(pmu);
-		if (ret)
-			return ret;
-	}
-
 	pmu->cpu_pmu_context =3D alloc_percpu(struct perf_cpu_pmu_context *);
 	if (!pmu->cpu_pmu_context)
 		return -ENOMEM;
@@ -13036,6 +13030,12 @@ int perf_pmu_register(struct pmu *_pmu, const char *=
name, int type)
 		__perf_mux_hrtimer_init(cpc, cpu);
 	}
=20
+	if (pmu_bus_running && !pmu->dev) {
+		int ret =3D pmu_dev_alloc(pmu);
+		if (ret)
+			return ret;
+	}
+
 	if (!pmu->start_txn) {
 		if (pmu->pmu_enable) {
 			/*
