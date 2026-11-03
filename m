Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738203;
	b=bYszMKYntcdsZT5L7L98ENgjvyfyENv3/JwCuYyBeG4hPOjjSRAjMrXZx/aZjXXX2Heo
	 8C1gkbcRT2Zq6dzEiZtQyWEhoFecO8g63cti1mENkh5gVa5J80mGxIq0SszQExtamZ0le
	 VzK7Y+izUxs9loJRRmga3tKrro6PMW6qEcedrr5/5KCNTP0VZxXO0taIoXlxNNiDQzL8T
	 N/K84TC/VI/qVOFJipYwKD6CYwX6QelldCeMYnDP5o7zEcq7GMAe8czt+1IDbV5rxMrKk
	 47ySTODwxCTCfh5DkOgEUiqBD6kGpdVW6dRy747rCxW2aYiy9jBOXE5h+CvZSN2r5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738203;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=H6euy1JPMcTX2hy9GI94GZuSFSw81ZMn0tXNEvb00oQ=;
	b=HExciybylwjYyu94G3mem7f8XJZr0nFS+eN69+77Hw5Oynts02F+Hdd2qEN60GiOYNp9
	 GLowioUGLik/yP+4vJZuu0jLlljrTAG/qQZ+BE7m/vCJmWDaaUEpIvR1ofEifsaoCNoR+
	 sy+6roKVM94Vp3C5Nd8F+79DDr17xNdLNmwqrp2JF3GyKLNUtgpx636OgkJtmORNFwJLh
	 wB0GBARKC5mANvc97flGKvCeT9Mp9KT/o0F+LCcLtcA8VWYTejetY4KE0Z0qvbQURyFq2
	 vwekF4TI2Smc6+XH/TB5FCVsaivHbfKY7GHw9jQTtAtQSod3HvreIKwYkDN4HPdJFpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HxYLUwvD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H6K4GAAd;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B331606A31B;
	Tue,  3 Nov 2026 20:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B331606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=HxYLUwvD;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=H6K4GAAd
Date: Tue, 03 Nov 2026 20:36:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793738200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6euy1JPMcTX2hy9GI94GZuSFSw81ZMn0tXNEvb00oQ=;
	b=HxYLUwvDWn+v+ihJGXGyPwrpD9IHW8nsrQ1jy7H/kAO1iT//ghfa4tYN7W71NZwOGdo4k4
	ZnNJkvekl0MrwcJ/8grusbeOvETFZsspZWU6zhvyVfmTvkUq4kURmd0A41Bn2fNoc/643C
	AXK+CZXgfPJZG+ix1f0VPgEqrGS93hcixFkjl2JBXPTZP36ZCegKFlq6SApADehOF4ImqV
	5oYBXPAl9T/nbhNe4pZin4DbWTpyMQ4LTjEUGYhIP3kB0teY7XeJ247QUFUH17qK+6XDM0
	7/x6inbwtgGeWEypEwcpfulXpABlwv8eRnD82/ONpkMTnCoVpQdtwKN2BMgB2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793738200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H6euy1JPMcTX2hy9GI94GZuSFSw81ZMn0tXNEvb00oQ=;
	b=H6K4GAAdHRL9B/JCxSlad7RkpphfzejlbFUWspDgsuP3iPL/u2Pr5hyLsZXKCgsf3hXPmu
	GswTTs4PFjv14VCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Fix ptrace regression
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <87ecd4xwlr.ffs@fw13>
References: <87ecd4xwlr.ffs@fw13>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179373819852.1009794.4642891487121637825.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b697faab2c92653ee13bd950c8de13551a78971d
Gitweb:        https://git.kernel.org/tip/b697faab2c92653ee13bd950c8de13551a7=
8971d
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Sun, 01 Nov 2026 18:58:08 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 03 Nov 2026 21:29:35 +01:00

x86/entry: Fix ptrace regression

The recent rework of the syscall entry code missed the historical detail of
the abuse of syscall number -1L to abort a syscall and keep modifications
by tracers to the return value, while a rewrite of the syscall number to an
invalid value undoes eventual tracer modification to the return value and
overwrite it with -ENOSYS.

Restore the original behaviour.

Fixes: 1b1f3b3e1b39 ("x86/entry: Get rid of the sys_ni_syscall() indirection")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/87ecd4xwlr.ffs@fw13
Closes: https://lore.kernel.org/all/20261022142425.3Wx-RrU5@linutronix.de
---
 arch/x86/entry/syscall_32.c |  4 ++++
 arch/x86/entry/syscall_64.c | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index a59509b..ca97fa3 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -77,6 +77,10 @@ static __always_inline void do_syscall_32_irqs_on(struct p=
t_regs *regs, unsigned
 	if (likely(nr < IA32_NR_syscalls)) {
 		nr =3D array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax =3D ia32_sys_call(regs, (unsigned int)nr);
+	} else {
+		/* See comment in do_syscall_64() */
+		if (nr !=3D -1UL)
+			regs->ax =3D -ENOSYS;
 	}
 }
=20
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 966d3d1..bb95ad0 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -64,15 +64,20 @@ static __always_inline bool do_syscall_x64(struct pt_regs=
 *regs, unsigned long n
 	return false;
 }
=20
-static __always_inline void do_syscall_x32(struct pt_regs *regs, unsigned lo=
ng nr)
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, unsigned lo=
ng nr)
 {
+	if (!IS_ENABLED(CONFIG_X86_X32_ABI))
+		return false;
+
 	/* Adjust the starting offset of the table */
 	nr -=3D __X32_SYSCALL_BIT;
=20
-	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(nr < X32_NR_syscalls)) {
+	if (likely(nr < X32_NR_syscalls)) {
 		nr =3D array_index_nospec(nr, X32_NR_syscalls);
 		regs->ax =3D x32_sys_call(regs, (unsigned int)nr);
+		return true;
 	}
+	return false;
 }
=20
 /* Returns true to return using SYSRET, or false to use IRET */
@@ -81,8 +86,21 @@ __visible noinstr bool do_syscall_64(struct pt_regs *regs,=
 long nr)
 	if (likely(syscall_enter_from_user_mode_randomize_stack(regs, &nr))) {
 		instrumentation_begin();
=20
-		if (!do_syscall_x64(regs, nr))
-			do_syscall_x32(regs, nr);
+		if (unlikely(!do_syscall_x64(regs, nr))) {
+			/*
+			 * The special treatment of syscall number -1 is a
+			 * historical bogosity as the original code used -1 to
+			 * indicate syscall abort, which is not distinguishable
+			 * from a syscall which is invoked with syscall number
+			 * -1. The historic behavior is to keep the return value
+			 * in regs->ax unmodified in that case, which means it's
+			 * either the preset value -ENOSYS or a value which was
+			 * written by a tracer. If the syscall number is invalid
+			 * but not -1 then overwrite any tracer modification.
+			 */
+			if (!do_syscall_x32(regs, nr) && nr !=3D -1L)
+				regs->ax =3D -ENOSYS;
+		}
=20
 		instrumentation_end();
 	}
