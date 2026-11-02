Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643376;
	b=fSQFUMatMJ10FGLs3H5TpD3JMgK0uy6z+Cl/16+ncGxqHoDVm1ytY4yzFZS8YZBTAYoB
	 WPrlrAlkC9FpzSqa4HgoJFjkgwjWD9QmUAZthbq/b6dQA5zVuW8rAVq22CDfGFEE8k65w
	 luVSlJ4uK/SkVJPdh9SYxJnpid4e8NCNE2AcjnhNQv95xVviS0i5Xl5+zoW2bBp+iD4Vs
	 8xIV2nn5bJk4K5VnBZt6Y6GGz7/OHYhZDDEqS8rrnPeQOhYr7wVijuj/sMZHJThdKgpsb
	 S2qncQ0M6N+mKPN0OIHKi/IPHn8wgFdnqJy0KXOANG0CvLyZLQG9TE9KoITeZZKsBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643376;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=b+TfbLHD2FzEidJAvDzmQCBeADHzUQDWO+Z2tMvQd9U=;
	b=0JCg0iEjYYzTZWmV8OGruULnxLSEu74SjEz1WfC7vIZwfMrniypWFCCZEbSeVL2hKH30
	 1hYulZAFwUPioqniLRn9msHHxIkh023dCpEstbjm3sRmiHJRcoI09/n9oUjIonbf7qQwG
	 K9OiDHC8cUEHWg6W88zPj01v4cQ6GJzaHK7L9yi7SWzm1yp4yMe2XvuJzHl8ap87QuQ4q
	 mO2xCLDUGEmNicsqJFc6UdrfWY6gUu1TI7UXmrWHDr3yO2hkCVHtDiFaqxwog9s0VIb4q
	 Sjrte/g9m/bqLRPDu52/Yeh+0KSMiL9OViOmzNRORl/1QdgjftKs4XYeuS7y7gvwKjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SfjrBu5l;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F76606A324;
	Mon,  2 Nov 2026 18:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88F76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=SfjrBu5l
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=b+TfbLHD2FzEidJAvDzmQCBeADHzUQDWO+Z2tMvQd9U=; b=SfjrBu5lgBaE3RkJQlfwFPRXMr
	kErMj54JoE1GzleQoVJM4OeMZaG1YwEzL+0hdVljIDLsAwe6ovAlyoEd5UM9A2lXuBA+73qahrEXr
	AJTp/r8DAWUP3lx3bOYgdopQ7EnAs0Mnxjifqo4lLIe/cnk1n+WvL6oVzgR/Y5ZQ81XKhMyw0e1rm
	hQdriZbp3Qht5GFQELTtLht91Mxe+kWwkCin8aJP8/5lQekxCcaDDWbOxSP0xWTe10HLDP/lCP6Rw
	1Yy+04ReVSjoFQai3Es2KIUtLl+NPHDNN1gekoafblxjp32G4oBw1Qkn50aNqhXbAF9+qqNyARHwJ
	XnqcQ4Ag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xNwZn-006L4r-1X;
	Mon, 02 Nov 2026 18:16:11 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/2] panic: flush unsafe consoles before reboot and kdump
Date: Mon, 02 Nov 2026 10:14:53 -0800
Message-Id: <20261102-panic_unsafe_flush-v1-0-12d1e22fd6d8@debian.org>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLT6GoC/x3MYQqDMAwG0KuE77eFGkFnryIipaYzIFUaHAPx7
 oO9A7wbJlXFEOhGlY+aHgWB2oaQtlje4nRFILDnvvWdd2csmparWMyy5P2yzfU8dmPixC8Z0BD
 OKlm//3San+cH7op+CWQAAAA=
X-Change-ID: 20261030-panic_unsafe_flush-62939c2c28e7
To: Petr Mladek <pmladek@suse.com>, John Ogness <john.ogness@linutronix.de>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, printk@lists.linux.dev, 
 gustavold@gmail.com, samuelcrossley@gmail.com, ryan.roberts@arm.com, 
 brads@mainlining.org, x86@kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2148; i=leitao@debian.org;
 h=from:subject:message-id; bh=WWR0J519IWUZiYslN8ZtMKOOzmprzyXwOlc4FKv8qM0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq6NNlZnasAivhSouNFr7lBcw+ninAdxy+KQglm
 tn2i/6xk4+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaujTZQAKCRA1o5Of/Hh3
 bQ5oEACI05PBCsiojZxwztkJKfwaKRsCKaEfSfG83Cum4zp5erGSTgjpXLkMp/4Se5FlRQUcicZ
 LD+1y6CGZLRBeFMZz56rNGVsWCgMnt2VfetdBinhQUOZsUmsC+uwmcNmJBlKgbbTUeIO/xexKgl
 G97rvJG38ionirt8onPkdZ8u2jUO6iZFyZdHnzeeEH2UsD0nBSI94+gvhE5qo3+3UMK34P+FD1h
 OKMSfHmIUXqSwGS0+3CE4+06xq5w/5mC3MlMTMlDHNZK4xA3hYtxkBKesFzBwVdIxqVHi4QwGGl
 wCvbQwqQWZA/KGG4lE5YzQxLpMzbvpOEq1WMeF1xYn9kRBgqbsWnwr1QOU17pv3cCrDnsUdIni8
 NgEORaNGHLLydZW8T+giFaNtRHUz1ztlrdrtvXoLlB4AcMvM8j1R14rpMzr99y35vXAZyyvKzyp
 eRBtRRDor0OZb246t/o8sVWheUh6VYYpdzzwvoGqb15ZHEIQMfE3hS1iAM1ygDHvX0LZLhve0u3
 atTomm1cOP8QCZaVF9YhEUGM/qfq82IP/1H00JPdLgpb5invPicy5oyMbIeybZ0rAQLi4nqwYKI
 9lLG+R60TuDOKpJb/am3DZL5hXRgVIunJE+89Rte6rDiO6YuWsZAHzfJCj1e5y1sX0Eoc48rfU8
 QWue3GSvRlhfZ+g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Since netconsole moved to NBCON, its messages are lost when the
machine reboots after a panic or boots a crash kernel. netconsole is
a CON_NBCON_ATOMIC_UNSAFE console, and those are only flushed at the
very end of panic(), after both.

Ryan reported this [1], and the fix is based on Petr's suggestions
[2][3]. Patch 1 flushes the unsafe consoles from printk() on the
panic CPU. Patch 2 also flushes them in __crash_kexec(), for an oops
that goes straight to kdump: on x86 that path prints nothing once the
CPU has become the panic CPU.

Tested on x86 with netconsole sending to a receiver: panic reboot,
kdump from sysrq and kdump from an oops all deliver the report, and
the crash kernel boots. Under virtme-ng that is 21 of 21 runs,
against 0 of 21 without the series. On a bare-metal host each case
was run once, and an unpatched kernel delivered nothing in all
three. arm64 is untested.

One case is left open. A printk() inside machine_crash_shutdown()
now also reaches netconsole. On x86 that only happens on errors, but
on a TDX guest tdx_kexec_finish() can pr_err() after it has unmapped
the shared memory a virtio-net netconsole uses. Stopping the printk()
flush once __crash_kexec() has flushed would close it, but would also
drop "Starting crashdump kernel..." and "Bye!" from netconsole on
arm64.

[1] https://lore.kernel.org/all/20260915100140.3631650-1-ryan.roberts@arm.com/
[2] https://lore.kernel.org/all/auNaD8LELWok3LOF@pathway/
[3] https://lore.kernel.org/all/auhl3cdwrHt4Vw7U@pathway/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (2):
      printk: nbcon: Flush unsafe consoles from printk() in panic
      crash: Flush unsafe consoles before machine_crash_shutdown()

 include/linux/console.h |  7 ++++---
 include/linux/printk.h  |  5 +++++
 kernel/crash_core.c     |  1 +
 kernel/printk/nbcon.c   | 38 ++++++++++++++++++++++++++++++++------
 4 files changed, 42 insertions(+), 9 deletions(-)
---
base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
change-id: 20261030-panic_unsafe_flush-62939c2c28e7

Best regards,
--  
Breno Leitao <leitao@debian.org>

