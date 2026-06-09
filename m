Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660AB3E9F95;
	Tue,  9 Jun 2026 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780993316; cv=none; b=R0rpsVp9YcjbdVGc0qdlXihfnWZG7TYi0Bnn8iXa2tiI2ALfB6cdcRwQUy/wrBma9BwNyc7WjGn//+Qq/gy0VtTHmXof8Gn2HZ4fffVOuLH8pVPG9z8hwZ4tigOBS6A7jDzlDaNwGq/Bsv6g/i2tLvHgfYK2Vpn0dhJLRzl8PvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780993316; c=relaxed/simple;
	bh=Im9ZzidDGXaBTR9fMJK4Pj6LNJ/LeOPaPBG66jJcnLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IyKnl2/IwmPYjUdCW/mpNzyLc2Y8cHlM9RCZQTmJgLzBXWua1lhBq801qI47LpgYi6kmIVUxp00c/WEyps03tZyh4xAwH2Yvp43f4C/NONCrYBS0IlON9Og28o3dTrMlCBoaWQV6MP/3QLUC8hfuA1GgIJNaVxs7qhda16cCn5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LpSuIAdG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yvMs7Yzd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LpSuIAdG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yvMs7Yzd"
Date: Tue, 09 Jun 2026 08:21:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780993314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2GS6WNRmhRgoYsvpHwoH3ewXTkxHagm0xT85CIf39s=;
	b=LpSuIAdGoR9qlXe5ovGx3vySdx9zW7sd6t7G2Vc9/9WJEvprWWT074Iyq2BFd6Q0NQH/9S
	xB3phRK+1g3zAXbCKaeGG2ukNpFIoViS1SRat5A5617ELzyJnX+q6r7bEinalbK/Bh0NlK
	QJ1vVkuPNOXpovhcTaRT7j/WEn0NUza20NVJt1P0U8JpqKDV2DZ2Y8PfsU11ID+DpCNrhP
	QEUqVI421T4htZ44Mj9V5tt3eCpGYZ/SrFKbeX+1DT/8E0mMuTesUK7+zsJwQ8h0piQh2o
	+91ws+obHWHBSKs+kUUOriRGMaWaWgoyWpN/HPuh6RhPg5RdRlTLLJWwjIZnQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780993314;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S2GS6WNRmhRgoYsvpHwoH3ewXTkxHagm0xT85CIf39s=;
	b=yvMs7YzdmTxlM3Yqg10L4MfB3FOczgqBOwPZjCSUc3R1d9GOLcpWIZBsidkhLPH9i6BnWM
	PhCI0b48SPaMQrCQ==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Defer ADL global PMON enable
 to enable_box()
Cc: Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260602144908.263680-5-zide.chen@intel.com>
References: <20260602144908.263680-5-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <178099331262.529383.14700209873166739410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9a0bb848a37150aeccc10088e141339917d995dc
Gitweb:        https://git.kernel.org/tip/9a0bb848a37150aeccc10088e141339917d=
995dc
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Tue, 02 Jun 2026 07:49:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jun 2026 11:38:37 +02:00

perf/x86/intel/uncore: Defer ADL global PMON enable to enable_box()

On some Raptor Cove CPUs, enabling uncore PMON globally at driver init
may increase power consumption even when no perf events are in use.

Drop adl_uncore_msr_init_box() and defer programming the global control
register to enable_box(), so it is only set when a box is actually used.

IMC and IMC freerunning counters use a separate control path and are
unaffected.

Fixes: 772ed05f3c5c ("perf/x86/intel/uncore: Add Alder Lake support")
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260602144908.263680-5-zide.chen@intel.com
---
 arch/x86/events/intel/uncore_snb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index 3dbc6ba..edddd4f 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -563,12 +563,6 @@ void tgl_uncore_cpu_init(void)
 	skl_uncore_msr_ops.init_box =3D rkl_uncore_msr_init_box;
 }
=20
-static void adl_uncore_msr_init_box(struct intel_uncore_box *box)
-{
-	if (box->pmu->pmu_idx =3D=3D 0)
-		wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
-}
-
 static void adl_uncore_msr_enable_box(struct intel_uncore_box *box)
 {
 	wrmsrq(ADL_UNC_PERF_GLOBAL_CTL, SNB_UNC_GLOBAL_CTL_EN);
@@ -587,7 +581,6 @@ static void adl_uncore_msr_exit_box(struct intel_uncore_b=
ox *box)
 }
=20
 static struct intel_uncore_ops adl_uncore_msr_ops =3D {
-	.init_box	=3D adl_uncore_msr_init_box,
 	.enable_box	=3D adl_uncore_msr_enable_box,
 	.disable_box	=3D adl_uncore_msr_disable_box,
 	.exit_box	=3D adl_uncore_msr_exit_box,
