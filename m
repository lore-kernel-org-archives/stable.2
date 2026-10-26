Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793004295;
	b=mvSuPKQKnv8WUtgGG7jlL0W63YdB93VAdBnMIZIVnHI/5EXqAnTCwR8buMPseJm14M1a
	 UBmZE/RJjWSvhQxgLiO+ZNvbuUReIinOBTUG/GNj9sjDF/w/yCclDyIWUMfj7Kz04sZjK
	 ZrigrMLYbuKZiAeRkIyRF7/9ufvIY6+q0HpS33KDI3guo9gsHX6UWhAk9ox/p1s9J3eEH
	 IHJCY0shRecbZH7/kRVqS/WbeTclrhQKQ4Ft4m+20OVnoCbAp25PwBdeq7NOqi5pYa5sq
	 CEer2DBi6iZBfxG/3KIyFeH8Atyjib5AfkKQw1MMOesG8+cCHzLgM8Cz0ne/wjZ9LAA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793004295;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jz30Kqva1oj2ZOG9QQrY/EiApxn9BM5nq3IuAzI3TSs=;
	b=WgF39tCMKgLMCnduiDDYRdjGEha0Wy9fw5IruCaPQgOsVoQXmpoYi1rRp81X9e4JyCSw
	 NnecXd0Axh8r+G/wZLgIxVBsQliL4Xx5aOfPskqrsdYeB/E2i8ipTtx0u6ZhLWz7MaTq5
	 QEyPSrLvSE51WYwpgtBNVco+p+ncEOjk+aSGfCV8rNVNvkiJRgxT8PCQ7R6FtuEl+RIv2
	 LfcJeIXz7/x8iBY1mLa8pDxNt9jFZ+GzQS15185bpKJFmzmnObk5SuVyROOTwSqdBGNbm
	 wAepkU+cXA6/gH9Jm9+JOq3zhQtDQZpAjkaRo5rtlfufsYci2aeM19Z8vqa36RGSs9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMJKtiEh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E30606A31A;
	Mon, 26 Oct 2026 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gMJKtiEh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793004295;
	b=dWAN0EA67mkCKq8VUjhqFwoFk5EgPe7rQxVRZtXhCamRDaG0JOQBtpRNRIpXws6k40pC
	 tJP+5kOd6C4Hgyi6XuuQ+U01PEOO2ZtDebFLBpkLn8Y7iwkhrdzlgShRRNedcsnLEW9pl
	 MEuTuGsmbb/alOXiHDwUKAKt0La+bBfX8M9IeoOzv4BqVqkwUhQ4Sihi8wpjd/QwOKldV
	 ZTs4O9yJFEqJ3sr/NfWaipq/KZKX31pI7Q7Amj2HFcYTLGnJvwQNx4gTIvXDp5OHNwxQH
	 oD70KtbJXOLfK+HN1x4RbMqP+oalQ6zgQjLXMPz8zi5xxcu1Jqv4FN8JB9RESgKeowQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793004295;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jz30Kqva1oj2ZOG9QQrY/EiApxn9BM5nq3IuAzI3TSs=;
	b=V2glH+uPavtLp8oC12tl6S82+lnS2XoUinfKVH1jwr1dQrH703vtaCUGENd4zVgbUn9Y
	 mgmYSVnSGySHYw8kzTZc7h5zQVGBwjydRPt2D9ciAYUicEuXna+tmfyzX5hS2fQGLLd76
	 Gd00nlH8x//PWJrp4cxLMtQ80N+gzwoQpIMEuw2VnlhCNV6XKghFVdAf6S9nbRLrdFPPH
	 V0na7/SZvzGCFZYd8p+PloY8RmcgqtbqBQpf/7zF/GgK5Syo+pqZORR2MlWOdQAETG4d/
	 ifgdWx5Zdg6D6nHH+CzJ/jrj1QK1+0gCiHCxDreHj4rGweboxjftByzcmWkc9Ll1s3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6D5901F01825;
	Mon, 26 Oct 2026 08:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793004295;
	bh=jz30Kqva1oj2ZOG9QQrY/EiApxn9BM5nq3IuAzI3TSs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gMJKtiEhaIn1a8UWqUtN0VcNNYZr2qYm/gsIoW1ftDtXtGpU7qPh7SpqdZgRHbAov
	 3IIIl2ogDpTY+vBlxc8gH9x83SEg3WaRj8FvSiFvq4usmr5fDEd2cpw7E+pxyo0/Ow
	 hg8hMrpbFiBx+yifOqbJ0V3tzYJY7X5FcmKJ364HsmfbkFPNMbALe5QR9p7bd8pyz0
	 Xx3JrZ6JbeTA+wzR9ZnpMBlB+eZFklCcxK6iuu3X0WFS7razZ5/qo8j1c+FHQpqKFs
	 YYkXyWC6mqaQPOmzYwJB3pxKAZNroon3Vc7Z7pOXKOfwxCioUZUylIo54wRYk8I5Ir
	 lLoF+rr0JB/VA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E064A44C77;
	Mon, 26 Oct 2026 08:44:53 +0000 (UTC)
From: Enric Balletbo i Serra via B4 Relay <devnull+eballetb.redhat.com@kernel.org>
Date: Mon, 26 Oct 2026 09:44:34 +0100
Subject: [PATCH 3/3] clocksource/drivers/nxp-stm: Increase min_delta to
 20us for PREEMPT_RT
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-nxp-stm-fixes-v1-3-20a64a4ea454@redhat.com>
References: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
In-Reply-To: <20261026-nxp-stm-fixes-v1-0-20a64a4ea454@redhat.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
 Enric Balletbo i Serra <eballetb@redhat.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793004293; l=1611;
 i=eballetb@redhat.com; s=20261026; h=from:subject:message-id;
 bh=2oVeDkpoG/kZGujP8YpSokhvVMo8D6Pr1tME75FCvYQ=;
 b=oJOj++Ax9eLtn9MXj4cg6VRzFKwnoiO5tNLT0d23izNOmKsdtC/1h8bWWET1Y35f76g/bOVb0
 XhycJ+0Wl1tApeDDk7ptKBEbENZ1EAQRpXw1C/GUzgfGlAMb2CHSQBl
X-Developer-Key: i=eballetb@redhat.com; a=ed25519;
 pk=5zh6xuAxTiQwglL2NXQFqWuyRPmCE8T5KPXLbNXhnKI=
X-Endpoint-Received: by B4 Relay for eballetb@redhat.com/20261026 with
 auth_id=1324
X-Original-From: Enric Balletbo i Serra <eballetb@redhat.com>
Reply-To: eballetb@redhat.com
Content-Transfer-Encoding: 7bit

From: Enric Balletbo i Serra <eballetb@redhat.com>

Under bus contention on PREEMPT_RT kernels, the 2us min_delta is too
small and the counter can advance past the programmed comparator value
before the overshoot check runs. While the -ETIME fallback handles this
case, repeated retries add latency. Increase min_delta to 20us to reduce
collision probability.

Cc: stable@vger.kernel.org
Signed-off-by: Enric Balletbo i Serra <eballetb@redhat.com>
---
 drivers/clocksource/timer-nxp-stm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-nxp-stm.c
index ed7662a4e2bc..a0761d7f8b01 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -335,14 +335,14 @@ static int nxp_stm_clockevent_starting_cpu(unsigned int cpu)
 	/*
 	 * The timings measurement show reading the counter register
 	 * and writing to the comparator register takes as a maximum
-	 * value 1100 ns at 133MHz rate frequency. The timer must be
-	 * set above this value and to be secure we set the minimum
-	 * value equal to 2000ns, so 2us.
+	 * value 1100 ns at 133MHz rate frequency. However, under bus
+	 * contention on PREEMPT_RT, 2us is too small and causes missed
+	 * matches resulting in 32s wraparounds. Increase to 20us.
 	 *
-	 * minimum ticks = (rate / MICRO) * 2
+	 * minimum ticks = (rate / MICRO) * 20
 	 */
 	clockevents_config_and_register(&stm_timer->ced, stm_timer->rate,
-					(stm_timer->rate / MICRO) * 2, 0x7FFFFFFFU);
+					(stm_timer->rate / MICRO) * 20, 0x7FFFFFFFU);
 
 	return 0;
 }

-- 
2.52.0


