Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0F93955C7
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309562; cv=none; b=Vr6xI3hTjD++KX+Wn1n99yXyKE74PnMb/WDX0ZPx3fsvhrj2MgBRCXL4KKD0025hY5SML5TD4a9zRfQSNgTYDAwzlJi65pmCvlwsX6LGnQBidqZz3zcKWzYsjGOOCXXD8swAEX59Ov+psQWM6a5fLGV1eJIy7B7EJQAObsdLEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309562; c=relaxed/simple;
	bh=MT8y3W9BpKyCzzFF6DhqsNlI8SINBQKwQSPAq/IyNNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ey4gOw9Fh32nbUKBWsWPFjNiHdOZFlCdl7UkybZgcAmC5S7PyOwbhREb6mwG/fJwuy0HOeM0hqaFg3lm4Wvf4XeHyiC/C82kLq8VHYE2AnA+a0G8ey7pDV2P2T10dhvMFHwhYvpwLGEWdsguWm6id4CC1o4MgbvCSad+rjsV0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDNT6uMz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yXaLXw43; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDNT6uMz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yXaLXw43"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pfpmvv3vkWQc7+S/D25INR4q2xsdkLWMGh28bbEu+hA=;
	b=UDNT6uMzJKUqHx/xyNUtqv3frBsFKct0dMec6VCpFYO9k6oBHHB3znQkL+oUS9Ly+BKEoq
	YnGuuR0qEpqxlWatPw/too45aPkE03OoS4gzVbuIBVLJkeu8EwLG9ChlsaddRUq2oGajlU
	d7ZDJ6YS8ML6s5nwvki7jpGgK4uNDa2UY4BxGHvOKKcZhvmJBPGxmiwbbjwmNDWToyokEo
	mVP/bPVTsA0gMpP1RKW0E/0DMhvxM5KKYp1n6ibZmv2U8Nvcn6w0TgGpC6iDqS4GhRIh7i
	PNxERUNt8/JfBz2aYjkG89TGsAALefjQjmX2DVasGo9NAsmB0zaIro+So/9MWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780309559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pfpmvv3vkWQc7+S/D25INR4q2xsdkLWMGh28bbEu+hA=;
	b=yXaLXw43cVNMl+oV2GE6K2EbeT/hgCIrtJ2/D4Y7Oblrg0sJUo1rGRPPNdvoLZfsrXYQPf
	pBcBzUz1TlhuFhBw==
To: stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v6.12-stable v2 00/15] Backport: arm64: debug: remove hook registration, split exception entry
Date: Mon,  1 Jun 2026 12:25:39 +0200
Message-ID: <20260601102554.233076-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

this is a backport of the "arm64: debug: remove hook registration, split
exception entry" series
        https://lore.kernel.org/all/20250707114109.35672-1-ada.coupriediaz@=
arm.com/

which has been merged as of v6.17-rc1. It fixes the HW breakpoint issue
on PREEMPT_RT.

I only picked one dependency and manually fixed the other conflicts to
avoid a larger backport.

This has been prepared against v6.12.91. v6.12-stable is the only
relevant tree for a backport (earlier stable version have no PREEMPT_RT
support).

v1=E2=80=A6v2: https://lore.kernel.org/all/20260528144825.850351-1-bigeasy@=
linutronix.de/
- Added "arm64: debug: always unmask interrupts in el0_softstp()" because it
  has a fixes: tag on one of the added patches. (Suggested by Ada)

- Added Ada's Reviewed-by tag.

Ada Couprie Diaz (14):
  arm64: debug: clean up single_step_handler logic
  arm64: refactor aarch32_break_handler()
  arm64: debug: call software breakpoint handlers statically
  arm64: debug: call step handlers statically
  arm64: debug: remove break/step handler registration infrastructure
  arm64: entry: Add entry and exit functions for debug exceptions
  arm64: debug: split hardware breakpoint exception entry
  arm64: debug: refactor reinstall_suspended_bps()
  arm64: debug: split single stepping exception entry
  arm64: debug: split hardware watchpoint exception entry
  arm64: debug: split brk64 exception entry
  arm64: debug: split bkpt32 exception entry
  arm64: debug: remove debug exception registration infrastructure
  arm64: debug: always unmask interrupts in el0_softstp()

Mostafa Saleh (1):
  arm64: Introduce esr_is_ubsan_brk()

 arch/arm64/include/asm/debug-monitors.h       |  34 +--
 arch/arm64/include/asm/esr.h                  |   5 +
 arch/arm64/include/asm/exception.h            |  14 +-
 arch/arm64/include/asm/kgdb.h                 |  12 +
 arch/arm64/include/asm/kprobes.h              |   8 +
 arch/arm64/include/asm/system_misc.h          |   4 -
 arch/arm64/include/asm/traps.h                |   6 +
 arch/arm64/include/asm/uprobes.h              |  11 +
 arch/arm64/kernel/debug-monitors.c            | 258 +++++++-----------
 arch/arm64/kernel/entry-common.c              | 148 +++++++++-
 arch/arm64/kernel/hw_breakpoint.c             |  60 ++--
 arch/arm64/kernel/kgdb.c                      |  39 +--
 arch/arm64/kernel/probes/kprobes.c            |  31 +--
 arch/arm64/kernel/probes/kprobes_trampoline.S |   2 +-
 arch/arm64/kernel/probes/uprobes.c            |  24 +-
 arch/arm64/kernel/traps.c                     |  80 +-----
 arch/arm64/mm/fault.c                         |  75 -----
 17 files changed, 340 insertions(+), 471 deletions(-)

--=20
2.53.0

