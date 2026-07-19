Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476352AD00;
	Sun, 19 Jul 2026 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784465403; cv=none; b=gXUrXCWdnC94alMnQB16roxqDyE/Amoh1o16Q9+eCbFeb8lfs3NM2sqJj+HKL0yvGsbKDdAzcA1nAkgkP9Epq4uFhS0nLGeUgGKA2UWNv9Vh59xf3uAXRr0L20xNv/GMuQp95BHEPEXSo/iKeMZ/i7ZOXyU/JYruager5qw1VTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784465403; c=relaxed/simple;
	bh=z6v+Y35P0zRBBUn1Dzxd3IG7+R/bQ5iK+PzYHHyreuY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JrGgwvL2cs28IRWb6USKKq1enm/+Q4QCkWdIIO83mEDK/xAaMMB2nYcqO/aMb0VlwSmCp9GlO8pmrPZginWWjLajGCKj/be3ffAkuS+B5Db/zyTwIafwYfdrA9xiA7QUvHeUExioWPraLW0jZk+m0VtTqoTOBNLkREGYXCrq3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=FMjCRj0c; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="FMjCRj0c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784465392;
	bh=VlrfRKz9zjOG/6YIbcGSZhp5l34LCXdz/FMZifxUPRA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FMjCRj0cxdaEyYO3WeZ2LjYvVzxpbKSV6col+ilxW8Mu2crdtLReYE6oMX8j+/kE0
	 mq+xi22QT9jb0q4jDgZpAXB0GBkhGmwC59qvxhLDh2MLYvyTxDCB/OME8Q5E2VvA5A
	 ZF1yTM+QZdCxEgIF3yCIWiGdItaLS3pJrzUlTbzA=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h33Q775G9z6vMC;
	Sun, 19 Jul 2026 12:49:51 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h33Q74Dznz4vyJ;
	Sun, 19 Jul 2026 12:49:51 +0000 (UTC)
Date: Sun, 19 Jul 2026 13:49:53 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: brauner@kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@kernel.org,
 npiggin@gmail.com, ebiederm@xmission.com, pasha.tatashin@soleen.com,
 kees@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_reboot=3A_use_make=5Ftask=5Fdea?=
 =?US-ASCII?Q?d_for_the_halt_and_power_off_fallback?=
In-Reply-To: <0D454AB0-9690-4228-84DD-60AC3F02C9FC@grrlz.net>
References: <20260713062332.21131-1-include@grrlz.net> <20260713181001.a46e0bf04235dd076f10d5dd@linux-foundation.org> <0D454AB0-9690-4228-84DD-60AC3F02C9FC@grrlz.net>
Message-ID: <7D5A48E0-F891-4497-B574-D9DA99256173@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 14, 2026 4:48:09 PM GMT+01:00, Bradley Morgan <include@grrlz.net>
wrote:
>On July 14, 2026 2:10:01 AM GMT+01:00, Andrew Morton
><akpm@linux-foundation.org> wrote:
>>On Mon, 13 Jul 2026 06:23:32 +0000 Bradley Morgan <include@grrlz.net>
>>wrote:
>>
>>> The reboot syscall calls do_exit(0) after kernel_halt() or
>>> kernel_power_off().  Those are expected to stop the machine and not
>>> return.  When they do return, the shutdown path has already disabled
>>> interrupts and torn down state, and do_exit() then hits its
>>> WARN_ON(irqs_disabled()).
>>
>>Well...  why are they returning?  Is it both kernel_halt() and
>>kernel_power_off()?  The report seems to indicate that
>>kernel_power_off() is returning.
>
>native_machine_power_off() has no __noreturn backstop.
>
>(Only for kernel_power_off, kernel_halt() is theoretically safe, ends in
>stop_this_cpu)
>
>>So is there a flaw in x86 machine_power_off() which we should be
>>addressing?
>
>Well, yes, but it's really not that simple Andrew...
>
>I did a quick dig at the other arches code and guess what? 
>
>x86, arm, arm64, (loongarch, riscv)           power_off can all return,
>(BUG!)
>
>
>So just doing a fix arch specific isn't really right (unless we want a
>3-5 patch series, which just adds more complication)
>
>>> That is an error path, not a clean exit.  Use make_task_dead() instead
>>> of do_exit(0): it is built for this, fixes up the irqs disabled and
>>> preempt state, and bounds repeated failure via oops_limit.  This
>>> matches the make_task_dead pattern that exit.c already uses for the
>>> oops path.
>>
>>And make_tsk_dead() is __noreturn.
>
>Nice catch! let's just remove break;, it's dead code
>
>>
>>
>
>Thanks!


Andrew? What do you think of this? (Sorry for the ping)

Thanks!
