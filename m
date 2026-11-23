Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427063;
	b=SbVf6F+SFn+pAzxytHGERUdgglqws1h4VKZfJUFPkQVPBISvcB2Utlec+62JIYVDmBXy
	 RjdcYOVn3JSiMLqyn48wI0Ggn7ij1clEVbpUDRSBx2UkrH6QhshVu0GB0BhIfbQZXNdBX
	 EFH7+yjxJEO784FXUrL856ZcVHuA9ccnSq4KMMXcl/pnSjo0gZaLhuOsbAAKXBzgZBg2t
	 sj58umOEs03jEhh7XB7oY/Us6sErfJwIOjGNG3nr+Y0W/MUAG/nNwgpTeushnII0o9fBQ
	 tyAuqQXUyVMuNXs/HhYoUWkq13LeSQlua+vZwhIszOOSHm/9LGdnZpaKQ2ZihapHe6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427063;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=DCb2SPB/uURZL9MaCW+MeN8s8i48GUQqx/NISFD9YPc=;
	b=yM6NfYDSbDw8KRgBd7TlfwKsLW7bJ5GG6soa7KOXB+jBOLJvAxVVUteabJnim6h0/dbv
	 m+DB9HfTKjaVYghadbL7HzScEfr8slDah0Pu3j5UrRijSOGrVfiUsfUMJwWqGaE1qELFW
	 cG8rR2RuUeMRYs1Z2c26XoRuO30NiX4/0CFW2DnUFOVeOYYszff1MXPhsT25U196Islvl
	 hFVTMh6GnrOdcymfhJ3hl7nVI6FGjyJHqRe5b491Tf/eIkNd6jyDhfa/uzgTybiJXpumy
	 EMvXznaK2e2bAvJOyNqszCCK3H//anvOgOko0LY96C4ZCNAAWd0UJVUuS0WK9ez4vAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZFdO5j4n;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="El/BnAGe";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63822606A31A;
	Mon, 23 Nov 2026 09:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63822606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ZFdO5j4n;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=El/BnAGe
Date: Mon, 23 Nov 2026 09:44:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DCb2SPB/uURZL9MaCW+MeN8s8i48GUQqx/NISFD9YPc=;
	b=ZFdO5j4ntzh1vZdmYncm/hpTpLpVeIXYnx3Rmbik806Z020QH9EDB8omELydR1fQiJMTSl
	sKawgoTryeaWv/WRr55uyjHr6blTPC8NCyXazcILnYjf7k9LJi3t7iwD5PiIkJArRDQQdP
	T/T7NQ93ti4A7IPJH+0WtNTz5CBwculCUqU+d4WDXHBS56fvQDGP0pxqrOgG2z67cngodS
	GLWOdjDRZ/b/jSIcvHqraEfUJ1EMtEk18igl/9ZJsiuTHAdmZqPS2MdMTAXRyRoxDt3V/2
	yaF5x+RvVpnp9WF08s9HRFoZYW3jLZ0M8hN1q/pXMPYJLREcOIdWTLp3271xBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427059;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=DCb2SPB/uURZL9MaCW+MeN8s8i48GUQqx/NISFD9YPc=;
	b=El/BnAGe2l6Fy9etKI0KgHgy6R0R4MfvyaOAyfoTQMTbN/61NdCQoB1J2AlL3OumnMjvoY
	tNlwMRmomixhuIBg==
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
Message-ID: <179542705760.92412.18298973222354613597.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     35fbc5a85891b2550425c7365ee3e011b505760b
Gitweb:        https://git.kernel.org/tip/35fbc5a85891b2550425c7365ee3e011b50=
5760b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Nov 2026 14:14:46 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:37:47 +01:00

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
