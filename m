Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387754;
	b=Sb/PJJLsey+EWjVdD1ZIONmB0qhl3T8IUE73sX5JOHlJm7PZGKHteXHy3xUtg8XkgfCz
	 OqyiQhDFi1dWq8sv6QmG+VSW/ZXnI9L3AqtixK1vft0F/cvjZG63VP6P6nLsjd0sCDfAn
	 zksUPORpEmiJAnlP1qbPw73SaUsQvXEAxwiWdHu0tU5/7NRepLDLADEagoF7Q9XO6C0AK
	 3BadWRJu0bt3xhMrQ4PDPe719sQ8pyD6PnKPfigCkeS0j+qbFdTGS0k0HsFtqDDerMd3c
	 o3ZxpquAF54VlAljwMqEfx72T6M5u97iD/zZHh7hapIwIp2hifoicgnfG6LIh3CKjmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387754;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=5JDR8Hqene+rdEcUO5Up4IkiyJUzR3DqWgd6zemjbwA=;
	b=TLjuBhxuUpFX5vwAKuonSiEN+pSt05F5IwSWqirfE3nKa/2NJqjPiOpfw2y5+ke7mo0a
	 nS8N3KlHgBwZeDouhvW+vwxfnQLWuQ1mUnR+hTfl1zdlQzf0SqWe8XkxlUXngzgt3l7iF
	 DDxCxShXCP72mpB8daTQAGXS/6o0a++/pmd5VMJWmt9JXHsmKZ11EetEDSMNkFWFmflsZ
	 8/2T5NofYZhRPORSLSuDn672MQqcTgW+b+R7VrYZQbouoYRX9dJ/i97M9WChOw5Tmgh6m
	 DJpcqjwsJXH1CZDt+CH8SAcoZHG2WMwLmP7Uvp5ws8v+7mZMxuXG5BzcKh/ykkkcUMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DM+fUKM0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vfa+c3Va;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA0606A31D;
	Sun, 22 Nov 2026 22:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BFA0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=DM+fUKM0;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vfa+c3Va
Date: Sun, 22 Nov 2026 22:49:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795387752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JDR8Hqene+rdEcUO5Up4IkiyJUzR3DqWgd6zemjbwA=;
	b=DM+fUKM0gTD3hTnEnqXpVZdK/AtxjsC1sgLYtg4sTRlETCuX6U7RMTDYMudXFQTqfe8Kfv
	gNkbMe+a2Jr+iFU8P/B0YkMRY4usje6kQxAgsp65aUSJi1oxy9PTWZKTouVEuoJ32DBN95
	gGgxTDlJek5iJSbwlYO05Sxyoi6zaVZronTiOgy6F99USFMxzj7Q4JGup0U86010Feu38V
	fYgXN5qmVCFccftk7cDFGE/5cinF4Qp/oytsl55P0tmEV1tDfINh06ApJmEwV2gfUGLEUh
	dwyjA6AlK0rIHpbVGCk1GGqspD1dqRtBay1Y13D50bfKqSFSRbvqRU8aamSbbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795387752;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JDR8Hqene+rdEcUO5Up4IkiyJUzR3DqWgd6zemjbwA=;
	b=vfa+c3VaYnzTO0J8noXK4rA7V1tFWhSHWnsDZK6s0UWUTRG+mmW64qmsF/4R4JUznWCy70
	vKSQgPlZ0RcmSsBA==
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
Message-ID: <179538775038.92412.1181985385445483116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     a3c976da55a8da3b5759bcca94832f757763059d
Gitweb:        https://git.kernel.org/tip/a3c976da55a8da3b5759bcca94832f75776=
3059d
Author:        Usama Arif <usama.arif@linux.dev>
AuthorDate:    Thu, 19 Nov 2026 13:10:44 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 22 Nov 2026 16:07:42 +01:00

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
