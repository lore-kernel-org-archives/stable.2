Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794213487;
	b=2FNZf5j58x37phRwfYn8SqWHvjIa3DdvXNgGTwd5USYZAg1F7ZsswE6wO5ZhLqCCKAPM
	 t6c/qHrmMIT+YsEbM6RFHWCne9XSDGAdw13NuqXROyyfQnwVYFSwC1YQ6ZUDAKlD9v02s
	 X1pFgePkCWq41OcSYFNYSb7xVYOjsLteU8gapLyninfDmRtfGE4s4PrNqO8aadu55GK/C
	 5AVK9xXC/GqTvx2lYc21h5lqx0eZmQaOk7u5M+sNVGxIBeHxi1CaX+kg62WIDRMROZBDG
	 C9//vewT46KVhbXHO7WTohcXwh2A8LEvtqCN2iFwKMqoG1juhiF0+1uQmf74SkWHGwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794213487;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=6VrZDM3fYOdSkSPKiqKMyCone02DlY/LbqIvTdlm5jE=;
	b=5qGbhfh0M0DYoRNEccvFlnfOoiTFqcaNYw0zsaWcZQU964xDxhVbwaSvnGl/XBO+gd/U
	 v5mbrdJBTusNWoFO4BT3uEfeh0a93XFFJNdXNMlWyExoooQ1uEjk24itGkiQ8yUI+Zo7K
	 sKS7vcIClxlhTGZRStnhrbR8odCbpLfADDL97YgiqlRBg9GxlF0sP5EZsAKM+VyvWLYpV
	 oA++cmRHfCyq9fa6j4CcL8rxnq8/FJKuaQHy5BY6UynLuw+BZ+h9ioWkcd6Zpt93kBbvX
	 fQ4jxVFgl0s3dPcBw7Ket4hucF3vgR0B4KFJWgKfs7RvL64xmXFWMqSAtvTZLV8mrnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sqS9N9tG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PF1b86qP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA5F606D83F;
	Mon,  9 Nov 2026 08:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CA5F606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sqS9N9tG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=PF1b86qP
Date: Mon, 09 Nov 2026 08:38:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794213484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VrZDM3fYOdSkSPKiqKMyCone02DlY/LbqIvTdlm5jE=;
	b=sqS9N9tGC7Fw9gMiaGHt/KqEYmkRMcVNBSrbQ0f2vd5DTl60mOUR77WCqXsJ6JHmdaNJK9
	oKG+yg3L9DN0IR5yQoTUGIVB0xMuHHZumvR5bWq/4XTyl9dSmOCngY3QglUg/FeC2V7TdR
	tYwzYVJ0450kZgFkDkzqsHy0vQlHl4F5xZWOVunz3J/n7jdJA0/eu4l6K4v5TbWV9xWtBG
	8Nq/b1+Nr1DeBn7833Qw6NALyBEBA9bo1sVMkyoaitfJ3cK1T0dCebNFtpTPAGzmc1g5KL
	BY+07NlTcRfoxK3Ozj/hCxvYwK357+1JYMMJW1DfWmQtU8PjBSekNXoFNHC9vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794213484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6VrZDM3fYOdSkSPKiqKMyCone02DlY/LbqIvTdlm5jE=;
	b=PF1b86qPh8jMxMqBG/xdeLEliqk1nac9P2hpvpW2YLhfHxxQr6yj7kxtobYqVhiOzqqpTB
	g0xqwSCN52iqjcAw==
From: "tip-bot2 for Paolo Bertinetti" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/hw_breakpoint: Clear stop state in
 hw_breakpoint_add()
Cc: Paolo Bertinetti <paolobertinetti200f4@proton.me>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261103130732.764081-3-paolobertinetti200f4@proton.me>
References: <20261103130732.764081-3-paolobertinetti200f4@proton.me>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421348251.2093942.4751132931367188495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     6bea5e29daf123a78ae58cb5926023f4705f396f
Gitweb:        https://git.kernel.org/tip/6bea5e29daf123a78ae58cb5926023f4705=
f396f
Author:        Paolo Bertinetti <paolobertinetti200f4@proton.me>
AuthorDate:    Tue, 03 Nov 2026 13:07:53=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 06 Nov 2026 11:45:14 +01:00

perf/hw_breakpoint: Clear stop state in hw_breakpoint_add()

Since commit 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage"),
__perf_event_overflow() stops the event with pmu->stop() and disables
it when the PERF_EVENT_IOC_REFRESH limit is reached. When userspace
re-arms the event with PERF_EVENT_IOC_REFRESH, the event is enabled
again and pmu->add() is called with PERF_EF_START.

hw_breakpoint_add() sets PERF_HES_STOPPED when PERF_EF_START is
missing, but never clears it. The flag set by pmu->stop() stays, and
perf_bp_event() drops every later hit, so a breakpoint re-armed this
way delivers only its first overflow.

Set the state from PERF_EF_START on every add, as perf_swevent_add()
does.

Fixes: 18dbcbfabfff ("perf: Fix the POLL_HUP delivery breakage")
Assisted-by: LLM
Signed-off-by: Paolo Bertinetti <paolobertinetti200f4@proton.me>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103130732.764081-3-paolobertinetti200f4@p=
roton.me
---
 kernel/events/hw_breakpoint.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index 789add0..7a60621 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -968,8 +968,7 @@ static int hw_breakpoint_event_init(struct perf_event *bp)
=20
 static int hw_breakpoint_add(struct perf_event *bp, int flags)
 {
-	if (!(flags & PERF_EF_START))
-		bp->hw.state =3D PERF_HES_STOPPED;
+	bp->hw.state =3D (flags & PERF_EF_START) ? 0 : PERF_HES_STOPPED;
=20
 	if (is_sampling_event(bp)) {
 		bp->hw.last_period =3D bp->hw.sample_period;
