Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795427056;
	b=HsB///PlWbLcNyezTl+1jfMkYO642Z4/4wzuhIook2vfYn7w48yVgJZHbD+X64azT2gN
	 AveHhr5HzunC/g2LIjOFi5Dw6YsvKmqFo504kov3XbT7T/vLHYkHE7Off6pLX3rbUs92L
	 hBCgOTRhU5Xc31z9WIj+HM/FWjfHDO4P1o/5rPh3wkVQkLjcfTIetnfVnisV3Dl515ci3
	 747P03p3OMhM3Pup4qnYeWRs1NFz/+XOlMoFSiCVbkkj1hLbqmQ9KNGCVtg+z/cYOXpIw
	 COOckdl9/lCxUhpRJ/pT8Y5QLzzK7fM5TZ4L60YGJsb+VYNUxQAbYtcmjCgqsAdHCig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795427056;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=OlprAqhNGKUEqmLLSXrHu9sA0SfO4MKL8K0YpfgjC1A=;
	b=FlqFtKn3aDod+B9KCJepdIX6/Pc4vVu78Vs8rc+l8/CpFApWZ4zH2Bl1OLWPSwUSIuAL
	 QDVyeNVbb9uLzN48QgM8J6wipjKhDjwLS9M+EuSV1je3CmThJSklcE8JohUvY4lhzg1WZ
	 2KB2YwUV/5vyRhQ+MmDNxmo0d7xwUUdinLhCZ5MJUR4IXBxZYml2gH6w3qTbC34U5memw
	 THsffJGEeBo5ed8J40ofksyl/7Lmc9LOFThtW5KQrTgqm96CXfAyiwC5kIPcfwvOq20xT
	 4UX/oGIKxcq1Zv3eo5vCq5StQVo0MLVCOR2W3uVk3iPHIWY1N3xy/R5cyHGgKdEVp4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pyFBJtFZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1BRuyebv;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8424B606A692;
	Mon, 23 Nov 2026 09:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8424B606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=pyFBJtFZ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=1BRuyebv
Date: Mon, 23 Nov 2026 09:44:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795427054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlprAqhNGKUEqmLLSXrHu9sA0SfO4MKL8K0YpfgjC1A=;
	b=pyFBJtFZZA0UhunMH3G7ZpysiH7bYN7aOsQYLqC4DrpsRPx32Ep/vsnTECfQEWZaJViDsW
	CWvEpjw6ZtmsWEiT9fvCk4NXOb2Gz5zrrsNyS9teWenBKGLFuj+qjII4AjqZoZgxKpHI68
	xDgH6lAGNl9XQG1/WmqCq/Fxl6XRg8JAkdTuaraey6E8KfDOADsH62sTcnS8lq4+YZnz1p
	qVi7hCHgvYCeysvh3A85wGNdsS/+w7w2/ZhF+GleaaVOV7pq4y05KucP631wKnFveB93IH
	6xj3H4i6sDkThc0Zyz+ekdzVb93mQQc0X/dKuLDrd5+WMwx3y43FxuT9s930kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795427054;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OlprAqhNGKUEqmLLSXrHu9sA0SfO4MKL8K0YpfgjC1A=;
	b=1BRuyebvNDeFr01ibFlbzS5dXC8IS4DKXgOIAXhIJ55FFYcBxnB/2/XmU7gQtusxB+UZNu
	ExxC5sJgcX0ibSDA==
From: "tip-bot2 for Usama Arif" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/core: Fix perf_sample_data reuse across
 software events
Cc: Usama Arif <usama.arif@linux.dev>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261119211235.99805-2-usama.arif@linux.dev>
References: <20261119211235.99805-2-usama.arif@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179542705228.92412.17399899909354714081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b57e800b6e70a0957642ab2bf1db3e176ac229b5
Gitweb:        https://git.kernel.org/tip/b57e800b6e70a0957642ab2bf1db3e176ac=
229b5
Author:        Usama Arif <usama.arif@linux.dev>
AuthorDate:    Thu, 19 Nov 2026 13:10:44 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 23 Nov 2026 10:37:47 +01:00

perf/core: Fix perf_sample_data reuse across software events

do_perf_sw_event() passes one on-stack struct perf_sample_data to every
matching event. perf_prepare_sample() fills in the fields an event
samples, marks them in data->sample_flags and skips fields that are
already marked, and those marks survive from one event to the next.

So a sampling event later in the list emits the sample ID, timestamp,
pid/tid and callchain prepared for an earlier one. Its record size is
computed from the earlier event's dynamic fields as well and can come
out smaller than what is written, in which case the kernel writes past
its ring-buffer reservation over the records that follow.

Two "perf record -e page-faults,context-switches -c 1 -a" sessions
running at the same time hit this: the one started first gets the
other's sample IDs and fails with "Bad address".

Commit:

   1d1bfe30dad5 ("perf/core: Fix perf_sample_data not properly initialized fo=
r different swevents in perf_tp_event()")

fixed the same problem for tracepoints. Do the same here: initialize
the struct for each matching event. While at it, drop the unused 'data'
argument of perf_swevent_match().

Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_sampl=
e()")
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261119211235.99805-2-usama.arif@linux.dev
---
 kernel/events/core.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 51c251c..42bd8ad 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11142,7 +11142,6 @@ int perf_exclude_event(struct perf_event *event, stru=
ct pt_regs *regs)
 static int perf_swevent_match(struct perf_event *event,
 				enum perf_type_id type,
 				u32 event_id,
-				struct perf_sample_data *data,
 				struct pt_regs *regs)
 {
 	if (event->attr.type !=3D type)
@@ -11207,11 +11206,10 @@ find_swevent_head(struct swevent_htable *swhash, st=
ruct perf_event *event)
 }
=20
 static void do_perf_sw_event(enum perf_type_id type, u32 event_id,
-				    u64 nr,
-				    struct perf_sample_data *data,
-				    struct pt_regs *regs)
+				    u64 nr, struct pt_regs *regs, u64 addr)
 {
 	struct swevent_htable *swhash =3D this_cpu_ptr(&swevent_htable);
+	struct perf_sample_data data;
 	struct perf_event *event;
 	struct hlist_head *head;
=20
@@ -11221,8 +11219,10 @@ static void do_perf_sw_event(enum perf_type_id type,=
 u32 event_id,
 		goto end;
=20
 	hlist_for_each_entry_rcu(event, head, hlist_entry) {
-		if (perf_swevent_match(event, type, event_id, data, regs))
-			perf_swevent_event(event, nr, data, regs);
+		if (perf_swevent_match(event, type, event_id, regs)) {
+			perf_sample_data_init(&data, addr, 0);
+			perf_swevent_event(event, nr, &data, regs);
+		}
 	}
 end:
 	rcu_read_unlock();
@@ -11243,13 +11243,10 @@ void perf_swevent_put_recursion_context(int rctx)
=20
 void ___perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
 {
-	struct perf_sample_data data;
-
 	if (WARN_ON_ONCE(!regs))
 		return;
=20
-	perf_sample_data_init(&data, addr, 0);
-	do_perf_sw_event(PERF_TYPE_SOFTWARE, event_id, nr, &data, regs);
+	do_perf_sw_event(PERF_TYPE_SOFTWARE, event_id, nr, regs, addr);
 }
=20
 void __perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
