Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23EE46D566;
	Fri, 11 Sep 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126246; cv=none; b=KKNLz7CiRhiuR0lzCkfrm/T6cvxAsqlLtJ8ahk9aS2e3i+V8Dfx4qWLWPxfnlu0cD01n84llVIvhhWUsZixf5FvocLpPJlvntkKzOUKROjQ1d+0ulqoAiz+ka1+rM68bpW3+PH7Urcj2blfmV/WmCw9s3ZdHxhoFfcF1kA9zwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126246; c=relaxed/simple;
	bh=YUhm9NBkByaTeIVID1/vCcUZgllqz4k9CZd6Kx9fzVY=;
	h=From:To:Cc:In-Reply-To:References:Date:Message-ID:MIME-Version:
	 Content-Type:Subject; b=q+7D4aEkdAvfdS9FHkRjhYzCHe1O/EulGeQZ1xkQz5Dnh39suwgcn0vv41KS3Avbm62byJvdh1+A5JX+r2/pqF+wHrrKdpDwdqzFIuliubNiIz/wMqURXzhKWIb52PtFYKKilcu/EhoQOgCF5ukej0JCvKqa/Ya853rCMndm5OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b=H5klL0Wl; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xmission.com header.i=@xmission.com header.b="H5klL0Wl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=simple/simple; d=xmission.com;
	 s=xmission; h=Subject:Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=YUhm9NBkByaTeIVID1/vCcUZgllqz4k9CZd6Kx9fzVY=; b=H5klL0WlcE+EQE+WeSlU5pAfZo
	DWCmx0Ac1Oj9SWzH49q26qhj4flHXz6LN4nSL74SYwbhQPi+OrNT2XmP2anofm2pQrtF6KzUdAHKj
	D02tHClbZ/5geVU/x2kfH8iyT0Fz0oK6uQy8csVzTLEzK4ECYIKTf+mQRo6tpJT5gabA=;
Received: from in01.mta.xmission.com ([166.70.13.51]:40652)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1x4zSN-00FxAM-QD; Fri, 11 Sep 2026 05:30:11 -0600
Received: from ip72-198-198-90.om.om.cox.net ([72.198.198.90]:36826 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1x4zSJ-0006F2-Ux; Fri, 11 Sep 2026 05:30:11 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,  Christian Brauner
 <brauner@kernel.org>,  Benjamin Peterson <benjamin@locrian.net>,  Jan Kara
 <jack@suse.cz>,  Arjan van de Ven <arjan@linux.intel.com>,  Jake Edge
 <jake@lwn.net>,  linux-kernel@vger.kernel.org,
  linux-fsdevel@vger.kernel.org,  stable@vger.kernel.org
In-Reply-To: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
	(Jann Horn's message of "Mon, 07 Sep 2026 23:26:32 +0200")
References: <20260907-cloexec-before-exec-update-lock-v1-1-8018c201a7df@google.com>
Date: Fri, 11 Sep 2026 06:30:01 -0500
Message-ID: <87qzj09gau.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1x4zSJ-0006F2-Ux;;;mid=<87qzj09gau.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=72.198.198.90;;;frm=ebiederm@xmission.com;;;sPfnum=0;;;sPf=pass
X-XM-AID: U2FsdGVkX1+/j6EdwnaZPcABZpZozdRvZbPKKJvlU/U=
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.1 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4219]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3373 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 12 (0.4%), b_tie_ro: 10 (0.3%), parse: 1.11
	(0.0%), extract_message_metadata: 17 (0.5%), get_uri_detail_list: 2.5
	(0.1%), tests_pri_-2000: 20 (0.6%), tests_pri_-1000: 3.8 (0.1%),
	tests_pri_-950: 1.84 (0.1%), tests_pri_-900: 1.34 (0.0%),
	tests_pri_-90: 124 (3.7%), check_bayes: 116 (3.4%), b_tokenize: 14
	(0.4%), b_tok_get_all: 12 (0.3%), b_comp_prob: 5 (0.2%),
	b_tok_touch_all: 78 (2.3%), b_finish: 1.45 (0.0%), tests_pri_0: 405
	(12.0%), check_dkim_signature: 0.59 (0.0%), check_dkim_adsp: 2.5
	(0.1%), poll_dns_idle: 2759 (81.8%), tests_pri_10: 2.6 (0.1%),
	tests_pri_500: 2780 (82.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exec: do_close_on_exec() before taking exec_update_lock
X-SA-Exim-Connect-IP: 166.70.13.51
X-SA-Exim-Rcpt-To: stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, jake@lwn.net, arjan@linux.intel.com, jack@suse.cz, benjamin@locrian.net, brauner@kernel.org, viro@zeniv.linux.org.uk, jannh@google.com
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-SA-Exim-Scanned: No (on out03.mta.xmission.com); SAEximRunCond expanded to false

Jann Horn <jannh@google.com> writes:

> do_close_on_exec() currently happens while holding the exec_update_lock,
> which is used in a lot of places that access process state to
> synchronize access checks.
> I recently added another such use of exec_update_lock, causing a
> regression.

A small nit.

It has always been a requirement that in exec_update_lock not be held
for writing over any userspace accesses.  Which is why it is taken in
right after exec_mmap is done updating userspace.

In the original version I missed that do_close_on_exec calls flush
which can block waiting on userspace (Is that just a fuse thing?).

So unless I am mistaken I don't think your change technically
created a new bug, so much as aggravated an existing bug.  It was
definitely a regression in user experience.

I am mentioning this just to make it clear what is going on.

> do_close_on_exec() can block waiting for a reply from a filesystem.
> That means a hung filesystem can block codepaths that use
> exec_update_lock; and it also means that a FUSE filesystem which
> attempts to inspect the calling process can deadlock.
>
> To avoid such problems, move do_close_on_exec() before the
> exec_update_lock is taken, but after the FD table has been copied if
> necessary.
>
> I have looked through all the calls between the old and new position of
> the do_close_on_exec() call; there seems to be no file descriptor table
> access in between.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Reported-by: Benjamin Peterson <benjamin@locrian.net>
> Closes: https://lore.kernel.org/r/f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com
> Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  fs/exec.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 745f6eb5279e..b51e5d7e4536 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1164,6 +1164,20 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	if (retval)
>  		goto out;
>  
> +	/*
> +	 * We have to apply CLOEXEC before we change whether the process is
> +	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
> +	 * trying to access the should-be-closed file descriptors of a process
> +	 * undergoing exec(2).
> +	 *
> +	 * This can block on filesystem ->flush() handlers, including waiting
> +	 * for FUSE daemons, so do it before exec_mmap takes the
> +	 * exec_update_lock.
> +	 * This must happen after the point of no return, and after unsharing
> +	 * the FD table.
> +	 */
> +	do_close_on_exec(me->files);
> +
>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
>  	 * not visible until then. Doing it here also ensures
> @@ -1214,14 +1228,6 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	clear_syscall_work_syscall_user_dispatch(me);
>  
> -	/*
> -	 * We have to apply CLOEXEC before we change whether the process is
> -	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
> -	 * trying to access the should-be-closed file descriptors of a process
> -	 * undergoing exec(2).
> -	 */
> -	do_close_on_exec(me->files);
> -
>  	if (bprm->secureexec) {
>  		/* Make sure parent cannot signal privileged process. */
>  		me->pdeath_signal = 0;
>
> ---
> base-commit: 73ae59e975966d24e32926247ddb45a537ebe184
> change-id: 20260907-cloexec-before-exec-update-lock-972ad108510c
>
> Best regards,
> --  
>
> Jann Horn <jannh@google.com>
