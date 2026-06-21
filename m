Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD209191F91;
	Sun, 21 Jun 2026 19:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782069341; cv=none; b=GwM17tscFSnOLNPpUDRIzbOZPiIkYpUE58TOABtXh4E+jkvEu+4Yc3uZhCBzPat6JU9mwFsyZro8J0FXljHe5fIeuEETfjjTAiuO7HYf4DMm1s1dpkbSbQDA3xO01B6ijyezVYD38VL6AFFQZaTdyQHiS2l9GTu1JrRPnNtYni4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782069341; c=relaxed/simple;
	bh=d+e/Mw72mkmJjHaUSErDdh6JErbOMKT429bLJutuAqg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Js+Mcnik0BPMvxLkiB2E3waB1wLuxSeR47d+JEB3qhJJqTgXI2rPCuHKQ0NH3tK0B3QQH0dNdgaxCIz3lNeu2NSMXph6U0VEYJaQW/8izmXdY1wtFqhWHVpgWIVrSEm73GQx4UzFWcfWb0sTsRQQZB1BIqqOwtmSQau1D/jWBgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ibLVmSO2; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ibLVmSO2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1782069331; x=1782328531;
	bh=JwF2wNbvzuUhHfeS+Fs+AD0Exgo3KosHHnKx9GxZlOY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ibLVmSO2L/HKODhtFUXO4Bx6GSCX9h7ZLoSdPOfSAkKHqBE1Hk/AZBJLEn2bdFCmz
	 VoNhe7V2S1ZAjr/Xaxq7Iyc79vS/3J4NVfJucMv+pkmgPbqWQZd0SGNx6ZLvsoMdEZ
	 9g7PnCna7SoY4cz4FwIcjzV8lf9DBqbTuSmsHRU2jLh1rDa8FyjD54+59ekkmPTZq9
	 LHB1T18Llxa/k8OLTHOVTqfZ6AdRh+SHel1vr/v/rfCzH6WnfvXfqnGylaComrvZ/p
	 5AmBmTBsAoZZ76uM5SiKW64Dq8EH8oli9gZXb5DS9tv4Q89mlzlTFDY8w3CZG+WrjH
	 37ue7Hi6SXbqA==
Date: Sun, 21 Jun 2026 19:15:27 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: slipher <slipher@protonmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "rmk+kernel@armlinux.org.uk" <rmk+kernel@armlinux.org.uk>
Subject: [REGRESSION] 32-bit ARM's BKPT instruction no longer works
Message-ID: <kJqktbpLphg_Pk5I5SPptgTLjl3E3eq5mN5UzCslyFj7Q1Irp-wDid4mj5eQVd2iZtRGXgeZd8goq195EkXdjyt864YMc8mVb2B9NGH91NQ=@protonmail.com>
Feedback-ID: 10906495:user:proton
X-Pm-Message-ID: 95bcd13d440584e517a89ec387c20b67e70a3a44
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Consider the C program for 32-bit ARM architectures:


int main() {
=09__asm__ __volatile__ ("BKPT");
=09return 0;
}


Expected behavior is that this raises SIGTRAP. Since Linux 6.10 this no
longer happens; instead execution perpetually resumes at the same
instruction, using 100% of CPU. It does not matter whether GDB is
attached. I have tested with an armv7l CPU, but I imagine any other
variants with the BKPT instruction would be equally affected.

I believe the culprit to be commit
c3f89986fde7bb9ccc86a901bf28e1f7d69fc3b3 "ARM: 9391/2: hw_breakpoint:
Handle CFI breakpoints".  The commit defines the method-of-entry code 3
as "ARM_ENTRY_CFI_BREAKPOINT", but this is the code used for any BKPT
instruction - see
https://developer.arm.com/documentation/ddi0379/a/Debug-Register-Reference/=
Control-and-status-registers/Debug-Status-and-Control-Register--DSCR-?lang=
=3Den
"Method of Debug Entry (MOE), bits [5:2]". If the CFI option is disabled
in the kernel config,  hw_breakpoint_pending() returns 0 indicating the
breakpoint was handled, but takes no action. So breakpoints cannot be
used by user-space code, regardless of how CONFIG_CFI is set. The blog
post
https://www.jwhitham.org/2015/04/the-mystery-of-fifteen-millisecond.html
gives a nice overview of the control flow in older, working kernels.

The following Systemtap script can be used to demonstrate that the
ARM_ENTRY_CFI_BREAKPOINT path is used, when running the above C program.


probe kernel.function("hw_breakpoint_pending").call {
=09printf("hw_breakpoint_pending entered\n");
}

probe kernel.function("hw_breakpoint_pending").return {
=09printf("hw_breakpoint_pending returned %d\n", $return);
}

// these are not called
probe kernel.function("watchpoint_handler") {
=09printf("watchpoint_handler\n");
}
probe kernel.function("breakpoint_handler") {
=09printf("breakpoint_handler\n");
}


Tested on a 7.0.12 kernel, the output is:

hw_breakpoint_pending entered
hw_breakpoint_pending returned 0
hw_breakpoint_pending entered
hw_breakpoint_pending returned 0
hw_breakpoint_pending entered
hw_breakpoint_pending returned 0
...



