Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C017344021
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309562; cv=none; b=Birm2i/utV0p5SJ99u2Tbhukh1dwB9Mwm3iBV6HmYyQFViXBUhf6b83CJdD4CB4Tj2uof3BI7FN3VT9gaLOldwArTdfPZmUmqOYcSKlqa1vpJmmlB5jsgjyHrfLXu8FHZMJPEzx2OR2uhjhh5oRK0Rr6nvUee7yfyY9URH9jFWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309562; c=relaxed/simple;
	bh=CJ/Gb/Amo/RRsAiespTlZkp0PVmRdzWgtuZoWaNPEf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScHV54qgWspNVu1G2YYWx1sj8j7Dbwes8bSBkRzVG62TDZWTf0AFqOwock8fs63v9nJf7euzpvmhcBQ65S+8Gjr1m7b8tQ5QOu3ReDShi7EXFKDdHMNi724At392BDPmGnz+9sbIgHIuHVbIxh51pWcVGf1SLRgSB02lOjNoQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hbt/zyuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RXxc7/rW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hbt/zyuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RXxc7/rW"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQs5igYm7UO7CQ9x3kNZcIZksFJrgfqWsPRxn51Sobc=;
	b=Hbt/zyuqkCg3tnHrbiXGGBcSapA0ivf/iOox1QkPFj92owz467bLO7fJ6DgNQlzOhyUGzJ
	DZMQkRtjMhCSuloBQ5pLRTxhJmmTX7q22I8YKDJB58I6V3CLP6MztsubNZloU8S7ZRw8hY
	AOpEj3SV9cwqRDX7fHOrUsmRKeN1eeWAFafKbbGaMLM/gPlU+RzHuJxs1ZY4WDaevWbp/9
	/3oGnigqq8LStgXwUMysMK/dKFHSwGwaaJc9oR4fz85sIZSlkL/GzG/byGjBcaI76H707b
	k2trTlJROs+diPgQMLczBrqoUP7BAzzV4YSMBvgGQZt4u8mJP6Pn/ZNts4lPKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MQs5igYm7UO7CQ9x3kNZcIZksFJrgfqWsPRxn51Sobc=;
	b=RXxc7/rWm/Zu9xaMEiEpNg5CKBLDL3GTwgZwtpeSR1tRw1b6SXoRJcFt6XVVcB5OytHOKl
	iEyE0pA7Rm3yjBBg==
To: stable@vger.kernel.org
Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 02/15] arm64: debug: clean up single_step_handler logic
Date: Mon,  1 Jun 2026 12:25:41 +0200
Message-ID: <20260601102554.233076-3-bigeasy@linutronix.de>
In-Reply-To: <20260601102554.233076-1-bigeasy@linutronix.de>
References: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Ada Couprie Diaz <ada.coupriediaz@arm.com>

Upstream commit ad8b22648b7d0bc6f84230508436b1aafc2e2516

Remove the unnecessary boolean which always checks if the handler was found
and return early instead.

Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
Tested-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20250707114109.35672-2-ada.coupriediaz@arm.=
com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
---
 arch/arm64/kernel/debug-monitors.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-m=
onitors.c
index 024a7b245056a..b7a2155bca42b 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -241,8 +241,6 @@ static void send_user_sigtrap(int si_code)
 static int single_step_handler(unsigned long unused, unsigned long esr,
 			       struct pt_regs *regs)
 {
-	bool handler_found =3D false;
-
 	/*
 	 * If we are stepping a pending breakpoint, call the hw_breakpoint
 	 * handler first.
@@ -250,10 +248,10 @@ static int single_step_handler(unsigned long unused, =
unsigned long esr,
 	if (!reinstall_suspended_bps(regs))
 		return 0;
=20
-	if (!handler_found && call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
-		handler_found =3D true;
+	if (call_step_hook(regs, esr) =3D=3D DBG_HOOK_HANDLED)
+		return 0;
=20
-	if (!handler_found && user_mode(regs)) {
+	if (user_mode(regs)) {
 		send_user_sigtrap(TRAP_TRACE);
=20
 		/*
@@ -263,7 +261,7 @@ static int single_step_handler(unsigned long unused, un=
signed long esr,
 		 * to the active-not-pending state).
 		 */
 		user_rewind_single_step(current);
-	} else if (!handler_found) {
+	} else {
 		pr_warn("Unexpected kernel single-step exception at EL1\n");
 		/*
 		 * Re-enable stepping since we know that we will be
--=20
2.53.0

