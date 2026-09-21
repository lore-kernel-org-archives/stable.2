Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20929469837;
	Mon, 21 Sep 2026 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982380; cv=none; b=Vmp69MglP+gjRtMygtWyeWTYNkZHg8IiI0qVMBzCgfCLQHQrfkqddUFjyDXloJcEc7KxVd3FMSw0zM9Sq0A6qDGx7jOO4ckH3p27Fe72KIl1t4/eYHs30v1iCY2TkchGYlO5bPnJXPQwneAc8dXCWc2cjIrfV6Ex6/gyNoi69y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982380; c=relaxed/simple;
	bh=YxoAtJmtJoYp3R5q6jTWFwiDOAXdC+pGbzfKbAKrZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nv6YutSmDwiZ+iromeRD4vKXbLsrF+u6sa3jWaO02qzAKqVoo+l3GfDQPqk4zV31F24x/sdl/F4DJ0B6egPnBZLccIs6teXtICneDrLYBNB7B4Nt6fYk2ASmAsdrznPWtWf2YIp2Mf013dYpVXMCP4VabIK0OzjsCagiGF9U2u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDj5yjd6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDj5yjd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFD91F000FF;
	Mon, 21 Sep 2026 09:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789982379;
	bh=MlsIXahdFvTNjjm1sP2TXecvRs5IS3of5WXLVkf2uP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hDj5yjd6dvGXj1tKDvl1qz/ItJLGwMWPc3l1ZnkkZFYelM14woiMpeWSji2NjiunB
	 eNFZbZMZtDSNqazOLI9ryVZgZ4W4Hia+3civ28gavWN0UnPZiU/Zk1C3tBhguzuxp9
	 1/YFBAvK2jjrExP/cwcmdDdDgqCrnrElAN020aY+uysQ/X0wfF7DfDZTRS1C9FMRAl
	 /aS4h2Id8UIh4n2tkDjnZCjz4Vmh8v5j+lealwGiuUA37KZ6Reqk5Xqlti2uvcEyxT
	 g6eGQD7gHhQHwn0fDTVo9BvhuPb5kcTo7ItdQzg6OhYZ8i6UvqQaLyhQbJ/jQJ1q/y
	 nD/FBZRMkxISQ==
Date: Mon, 21 Sep 2026 02:19:38 -0700
From: Kees Cook <kees@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Bradley Morgan <brads@mainlining.org>,
	Lorenzo Stoakes <ljs@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] seccomp: restore knotif->state when
 SECCOMP_ADDFD_FLAG_SEND is interrupted
Message-ID: <202609210158.F3D96F157@keescook>
References: <A3F8F45D-3B9B-4E52-B076-7924FF3AF360@mainlining.org>
 <20260920185910.3307638-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920185910.3307638-1-benquike@gmail.com>

On Sun, Sep 20, 2026 at 06:59:10PM +0000, Hui Peng wrote:
> Fix this by restoring knotif->state back to SECCOMP_NOTIFY_SENT if
> SECCOMP_ADDFD_FLAG_SEND was set and kaddfd was not consumed before the
> interrupted wait. Also add a seccomp_bpf selftest
> (user_notification_addfd_send_interrupted) covering this race.

Yeah, this fix is the same restoration logic as seccomp_notify_recv()
uses (although that may actually need "if (state == SECCOMP_NOTIFY_SENT) ..."
added). It does make it clear there is a missing state in the state
machine. SECCOMP_NOTIFY_REPLIES means both "A reply is reserved" and
"A reply has been delivered". But the hidden state is maintained:
"REPLIED + queued ADDFD+SEND" == in flight, and "REPLIED + no queued
addfd" == delivered.

Thank you for the selftest addition, the sched trick is nice!

> Tested in QEMU against Linux 7.3.0-rc3 by exercising kernel/seccomp.c
> and verifying the fix with KASAN enabled.

I've verified this now too. It's kind of a ugly problem because unlucky
timing makes it look like the returned fd is fd 0. :(

> [...]
> +	/*
> +	 * Demote the tracee to SCHED_IDLE and promote the supervisor to
> +	 * SCHED_FIFO(99) on the same CPU.
> +	 */
> +	sched_setscheduler(pid, SCHED_IDLE, &sp_tracee_idle);

Unchecked return value?

> +	if (sched_setscheduler(0, SCHED_FIFO, &sp_supervisor_fifo) != 0) {
> +		close(listener);
> +		close(memfd);
> +		kill(pid, SIGKILL);
> +		waitpid(pid, NULL, 0);
> +		SKIP(return, "SCHED_FIFO requires CAP_SYS_NICE");
> +	}

Instead of this you may want to look at FIXTURE_TEARDOWN to clean up
(though it's not strictly needed since the harness is run in a
subprocess so all these go away on test exit). The one thing that might
be worth doing is making sure sched_setscheduler(0, SCHED_OTHER, ...)
happens ASAP or the test could block everything on a single CPU
machine/VM/CI.

> [...]
> +	sig_pid = fork();
> +	ASSERT_GE(sig_pid, 0);
> +	if (sig_pid == 0) {
> +		sched_setscheduler(0, SCHED_FIFO, &sp_sig_helper_fifo);

Missed return value check here too.

> +		kill(parent_pid, SIGUSR1);
> +		_exit(0);
> +	}
> +
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
> +	EXPECT_EQ(errno, EINTR);
> +	EXPECT_EQ(waitpid(sig_pid, &status, 0), sig_pid);
> +
> +	/*
> +	 * Restore normal scheduling and sleep briefly so the woken tracee
> +	 * runs in do_user_notif(). With knotif->state restored to
> +	 * SECCOMP_NOTIFY_SENT, the tracee must loop back to sleep waiting for
> +	 * the notification reply rather than returning 0 from __NR_getppid.
> +	 */
> +	sched_setscheduler(0, SCHED_OTHER, &sp_tracee_idle);
> +	sched_setscheduler(pid, SCHED_OTHER, &sp_tracee_idle);

Need to check these too...

> +	nanosleep(&delay, NULL);
> +
> +	/*
> +	 * Retry SECCOMP_IOCTL_NOTIF_ADDFD. Because knotif->state is
> +	 * SECCOMP_NOTIFY_SENT, the retry succeeds (returns 42) instead of
> +	 * failing with -EINPROGRESS, installs FD 42 into the tracee, and wakes
> +	 * the tracee to complete the syscall with return value 42.
> +	 */
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), 42);
> +
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +
> +	close(listener);
> +	close(memfd);
> +}
> +
>  #ifndef SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP
>  #define SECCOMP_USER_NOTIF_FD_SYNC_WAKE_UP (1UL << 0)
>  #define SECCOMP_IOCTL_NOTIF_SET_FLAGS  SECCOMP_IOW(4, __u64)
> -- 
> 2.49.0

Thank you for the test, it really helps see the shape of the issue.

-Kees

-- 
Kees Cook
