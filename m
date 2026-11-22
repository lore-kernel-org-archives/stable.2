Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387759;
	b=fSQO3OrLKj30yL+sg+ZowRnXp2stc/gJ6b6lFgkSIFIfxCFBwP0T//WlWI+E6O7UBkYJ
	 uOAlTr/g8f756CTHozje0i3eKncn6fIz7Vh/vtEi0Mnkk1tzST8/6Q1b6rz5CluU9VeZq
	 KH7HQyu+Tc3NMHMZJHpmtKXDxkmq+nEW2CvBujMwlmnXPQbXPFP8SpiyWE5RGLb8XAaUt
	 Wmb3FU42rVihR2vcAxV6PkmEg3fonT1h2u3Wt2Md//dgsVxdcOMmBPbiaC+6VCvRsTkyp
	 nsYAfWA6rtV8hbVXZ4GvuWv8e25r2Ye+1LWlcrfGW9awOVK8dCFfRXQvAmMR7+iLeKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387759;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=1y4d9MsrkIPklaL6P1dlLtEX6JDwrBmPIxtFyFHwrn4=;
	b=0IyFri0JjUbmMsc2FOjI846Zuxsrqc8jG3Tyuz2ogxp9ycTBOh7iMqbz1uoMs3N70qvA
	 5D2n0KspiP99iXZ2H428gGVJ22YAs0eevi3vxv38Tw98EpY/IpVEWpoPu2d7SPzG2dyxj
	 bfsNHrQTHg4aFXzu8roowUgcVxYcUPwdTAFKmJ0pfLfahRZI0CElnx/5c6HguGKLhkdB+
	 RaXLov5vA4uBCkYcPx3on6vlKEce/mmmaWTMpK95gpUMcLccRiAS2MEIchwKRI5ivTJ8m
	 YLfhSKk8Lw9NRj7aG2BwlWBrJMZa7vmdRAHYu48wkRphubo5pCeESefuQjWAPO/a0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JBVPuVzO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9RvcHsio;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3D606A337;
	Sun, 22 Nov 2026 22:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93E3D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=JBVPuVzO;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=9RvcHsio
Date: Sun, 22 Nov 2026 22:49:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1y4d9MsrkIPklaL6P1dlLtEX6JDwrBmPIxtFyFHwrn4=;
	b=JBVPuVzO+PyI+HB5j/dy8sKxXsxdxnbuU5XjE3LIZueDMMRxTjiutpeRW5CUzaOwyatzIw
	2qNvNbXSBEi4dYmsXbdOLSmgOUFTvty81+gvoVdNSmMXT3DRvpISaQoGhoF37bGkUFuOYv
	+eMKAVPgLuaO48aoEe64GIPWB3oFo1dFt2IaXn8HnWuoPBEJnbsV/5f5w8NmLY6oJY87kr
	WfdtYZMsDUOm1/axdH7FrDQAASCd0GCL3U6gEs+qVOCrTYT1SUWyuKOVyFdSJn1nNuumV9
	WBahftqtgAVPy9XM5buVtjUeetIL5grSqb4a/mW8SAgS4YAzrxYQAUgwgL1rzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387757;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=1y4d9MsrkIPklaL6P1dlLtEX6JDwrBmPIxtFyFHwrn4=;
	b=9RvcHsioreMiKWXh5Cv0wOMm2gqrfSLJ2n2C76bAhD3AS3OXbULGSu73MqUm1ufx/Rhmh6
	QniP+MGyrIGWWYAQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Cancel hrtimer on perf_pmu_unregister()
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
Message-ID: <179538775537.92412.7038823756938301341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5dbc21b5caa5b40f4af45dbb342e5db1c6f25f5c
Gitweb:        https://git.kernel.org/tip/5dbc21b5caa5b40f4af45dbb342e5db1c6f=
25f5c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Nov 2026 14:14:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:06:37 +01:00

perf/core: Cancel hrtimer on perf_pmu_unregister()

Since perf_pmu_register() initializes the hrtimer, make sure
perf_pmu_unregister() cancels the timer before freeing the memory
it lives in.

Fixes: 9e6302056f80 ("perf: Use hrtimers for event multiplexing")
Reported-by: Hanxiang Xu <xuhx@hust.edu.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
---
 kernel/events/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12..f424b72 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12968,6 +12968,7 @@ static void perf_pmu_free(struct pmu *pmu)
 			struct perf_cpu_pmu_context *cpc;
=20
 			cpc =3D *per_cpu_ptr(pmu->cpu_pmu_context, cpu);
+			hrtimer_cancel(&cpc->hrtimer);
 			if (!cpc)
 				continue;
 			if (cpc->epc.embedded) {
