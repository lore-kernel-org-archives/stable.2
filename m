Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387757;
	b=K7ly4qtx2K39DF/Q5fO2+fgJuna+oKN0q/qk4/vf1R33cnRVCMPFIUfqgQYe9KgnJrsT
	 W1YnfQVjSgZmfpVSp0mhTGeMTQniHO3+SZSabaR080jfHsQbsTc+qkCBi4qB02bsIq+6Q
	 pmGryCnYza5dOlFSYmMn1TJ/sowdTMjhfxVNxM+h6AKot03xkW9R9S9mRQSw8HMKeQ9OJ
	 IuAfzGWigFzF+5PINcfgCxJv+HklmSaM3xRfuyre7Rey4Ex1lULYqjinqb2LYypswUd5s
	 AI5DwuAiIelgJdgo7zjVN8k9WRrjGn/fzwHLunsasiobwbixFZO4Gbv0vcLH+pqA05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387757;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:MIME-Version:Message-ID:Robot-ID:Robot-Unsubscribe:
	 Precedence:Content-Type:Content-Transfer-Encoding;
	bh=lzQGzXiUSpsUdPBBmqguDTTC5hpVhHveft8GwC3yRLM=;
	b=LMeOADsn58mqm1xyHBTK+LDubPNwBUvQPpFZbo930DFB0lPABbbB7GXbtUKPqdO586qV
	 siEndI5kg9X+4mLprNKTRXfzH/N9YF3jG7QZde2qBKDMCxF11zsmK/cWResBkl+L4TG6l
	 9jbOYYXKizsqw/0kP+XlcDEfBqTGuVgMoUz7PfV8fmUnuN1cVqSkU+cS7qMyb3Fb2ZeWY
	 0Eg6H5q4C8ikCgXmesN+sw0e4PmtfgPZPbuOaXl8kAUUZJS5ehGJNqEusqWTB474WBEMW
	 6pnRqQA2ZAJImKrU5N3CWul49LWjPPvCoq4zaltVyPVwP3dnZx9jwgtwfyNqU1/pLIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=i+OIc8v4;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RD4sg0uQ;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5D606A693;
	Sun, 22 Nov 2026 22:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52B5D606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=i+OIc8v4;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RD4sg0uQ
Date: Sun, 22 Nov 2026 22:49:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lzQGzXiUSpsUdPBBmqguDTTC5hpVhHveft8GwC3yRLM=;
	b=i+OIc8v4gDWGjGI23iqVKtAY/zVAA6RupI9oiqUOKLifwKoJrvv+6Q+hlm4FAXCM5B1nhS
	UcRaXbfphp0EB7Nf0FZdmjS5k2V5N43QbAJeOl7uEac18FIOhLZFKIQHfqDPujnek1hLbo
	WM0F0V7TAQrEGHJtwWBth0HY7NWSwiVKdiJEM5qjMNOFgIobcl+Sctddn6uytgb7UqLZ8r
	/VNXvB4fUSBNjPMpZlorVvhrRncsFZPPBewFfm8URAX9YHvJlGEAWZXsg7vzi1C/ckWpDo
	a7kiAvkyjvm/gcHaZ0SBqwC4nCnPzYxBLUQNhRllQnt8y0ReNFhYxzgCBPXPew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lzQGzXiUSpsUdPBBmqguDTTC5hpVhHveft8GwC3yRLM=;
	b=RD4sg0uQHQwxIztdp24z4Wa3tT8qKCKZLdLxWcX49ioC+1CE7VBECgJidW5UYxkPYXRTug
	uBZJ8ciWNdVcAbBA==
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
Message-ID: <179538775380.92412.11276607202806236789.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b7963d9969ef37cdf18a700e7eddb1398135572b
Gitweb:        https://git.kernel.org/tip/b7963d9969ef37cdf18a700e7eddb139813=
5572b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 18 Nov 2026 14:15:11 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:06:49 +01:00

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
