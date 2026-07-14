Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919CF4963AB;
	Tue, 14 Jul 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044108; cv=none; b=GoGyE86ZU095Igt8GEn5unZPIlSGlyePjAPzZ7ic1Aq4TdG5+mMS7ho+ZLhJ01g8H8mOiBta2/gAuOHDF5lbTa9duVAsKdjgQ8PhOZg/opd2O6+7TmKaTqF7x830zit1R3/Rniq8ILuw2mA8X0kzNSOITIU9IG63skaQN+5SgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044108; c=relaxed/simple;
	bh=2xK11R5XTnZdZ9w7vMn+gA8t1UQPml6J/T5wbWKRHvM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hKc/pobHFnyi6qaP6FQOJPglUUqjW2npN/0adLd9FLmWLCV87FaaJycAq89cGyKBIHOzgrWGJGBDwX8g2Qz0oQBvBqOJLKlddoJFhFfKmM0G/iDDv/PJq68THSGIT1nvcnPBkhE44J0XCnm5vzdN6FVzJutNZHfi/5b61HJdMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=jVCbGNmD; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="jVCbGNmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784044091;
	bh=XEhMqYAv+6EFinpq8nxhUlPqncdWVIAulg93LkLHFps=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jVCbGNmDdhra1ZUb/BEvQFXd4jXl7qVZBpAEctqLvGNJ6hL7J6+uyvA1nKXi+MDGP
	 GShg4ymCUIv2HMywbzhoVi3gluTQns63hIWlk3M6yU4pIA09xswxntdpEv3bVwbNB1
	 EWDJx2IUCq7Eqmr558ClfYkWKFE47pb4RHrze2NY=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h03cC4Snkz112c;
	Tue, 14 Jul 2026 15:48:11 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h03cC17ZFz111k;
	Tue, 14 Jul 2026 15:48:11 +0000 (UTC)
Date: Tue, 14 Jul 2026 16:48:09 +0100
From: Bradley Morgan <include@grrlz.net>
To: Andrew Morton <akpm@linux-foundation.org>
CC: brauner@kernel.org, peterz@infradead.org, oleg@redhat.com, tglx@kernel.org,
 npiggin@gmail.com, ebiederm@xmission.com, pasha.tatashin@soleen.com,
 kees@kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+8fdf0d8e10bdde1c2e88@syzkaller.appspotmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_reboot=3A_use_make=5Ftask=5Fdea?=
 =?US-ASCII?Q?d_for_the_halt_and_power_off_fallback?=
In-Reply-To: <20260713181001.a46e0bf04235dd076f10d5dd@linux-foundation.org>
References: <20260713062332.21131-1-include@grrlz.net> <20260713181001.a46e0bf04235dd076f10d5dd@linux-foundation.org>
Message-ID: <0D454AB0-9690-4228-84DD-60AC3F02C9FC@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 14, 2026 2:10:01 AM GMT+01:00, Andrew Morton
<akpm@linux-foundation.org> wrote:
>On Mon, 13 Jul 2026 06:23:32 +0000 Bradley Morgan <include@grrlz.net>
>wrote:
>
>> The reboot syscall calls do_exit(0) after kernel_halt() or
>> kernel_power_off().  Those are expected to stop the machine and not
>> return.  When they do return, the shutdown path has already disabled
>> interrupts and torn down state, and do_exit() then hits its
>> WARN_ON(irqs_disabled()).
>
>Well...  why are they returning?  Is it both kernel_halt() and
>kernel_power_off()?  The report seems to indicate that
>kernel_power_off() is returning.

native_machine_power_off() has no __noreturn backstop.

(Only for kernel_power_off, kernel_halt() is theoretically safe, ends in
stop_this_cpu)

>So is there a flaw in x86 machine_power_off() which we should be
>addressing?

Well, yes, but it's really not that simple Andrew...

I did a quick dig at the other arches code and guess what? 

x86, arm, arm64, (loongarch, riscv)           power_off can all return,
(BUG!)


So just doing a fix arch specific isn't really right (unless we want a
3-5 patch series, which just adds more complication)

>> That is an error path, not a clean exit.  Use make_task_dead() instead
>> of do_exit(0): it is built for this, fixes up the irqs disabled and
>> preempt state, and bounds repeated failure via oops_limit.  This
>> matches the make_task_dead pattern that exit.c already uses for the
>> oops path.
>
>And make_tsk_dead() is __noreturn.

Nice catch! let's just remove break;, it's dead code

>
>

Thanks!
