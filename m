Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA064D8D92
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 11:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660222; cv=none; b=XYhbLB9JPog8DwA4HQT4VXF43ORVMMw3MahbAQ2B8nhfPZi9OCuFulGH9LE0nnB+JHWqkeZaQx4NC7aH7JP8a2N7o/RHxBQO3o9BiLo/W9CVqA9WR8FXCpKLlGMI9sUBflaBPBJN587OHOOXN0Fa3hqFGPuVxI6o5PWBqZYQ/sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660222; c=relaxed/simple;
	bh=mCXKkkhnaPjdHayDuK/2yUynf4W6NwP8p7Q3PEvX+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeBnwLmosqqRyudMNuZ6xxwS7UQRlkPuq7FHrHzodXuNd0YzbrcotCx6hajqMFxLsj36H0/2pxAq7v1M20zShfUj6uLQb0v9UGOa2lSEDnrj14b3moCHW+/bb+Xoojgu+CuJh6OKF95AdfDJTudrdMcqJYXrNqlnH08ljiFVhJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5+0CGjw; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5+0CGjw"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4602e2a0372so1075113f8f.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780660219; x=1781265019; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EgtDIubqbZvCNM5YYIDrDCWKvXHiZQSJQvsolhx0YGw=;
        b=G5+0CGjwPxzGC/cSabtBwi/zykISJ2c76/dNWLB9z7OCqjVuolQSVOzuuVdy3It9cH
         J5xNUlsE/BDAeJgleHUx1AgjaIei7fn2bTbI7yj8vxCk3bpzgGydJq109NgzCNKP6yAs
         QSo6Z+bXfjj0er+PNcdsW2yQRLQfyHOJlrPT3Y/0KwhfpXvbzLzItiTyWF5zkPaSPNx/
         MfM8C+vfctBIOKe0mTmiiKHwXPvRewWYE+h7ROG0QYlJXzCfVuTHY3L9kpiQssrmlEPf
         rggcBVMEnaEI7T0yq8Hfp12kjVeWJHLzvsNKC+MMJcSlrHPv3MG92/zm91hBRGO6/LEU
         3YLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780660219; x=1781265019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EgtDIubqbZvCNM5YYIDrDCWKvXHiZQSJQvsolhx0YGw=;
        b=Xc2ilVd/Lcu2z/Upt20/rlkwncDexQH8kT6pofAAEqMbPjrTa4PxtWO7zk2StVMLNy
         46VGWIauNTkISOkquzqVkYYQn/wKAMNohwjkaO0zccBz3RWk8wo893Z4DAI7UHijIbcl
         FUw84LDNf4bbddwoz4JaFZwANio4ByuTik4TGFLCcnOZA16CJb5Vi+cBuT6hqExLKgoS
         j76m/fXU0/1bh5ksw2a8mbEXsA7xkmGUpjs7FKtd8MU/wNRuMGe/7rj+BsnHnNZgVfgE
         FRoNJrLbQ4bDYf6BzPLt3gnRHVzaCG5o39zGLUL7kgVtKhpt9VTzp5RtKJYNbX4jPdvV
         djzg==
X-Forwarded-Encrypted: i=1; AFNElJ9LgnOusm8gnv4mpSV0YVzk0mQpg4TH/nz020tlzXWHrouk8FrHBKHgdQ9xOn8HCcC6JQAD1Hc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIfqexmXLE9uJ/jIcgs7l38pcD4PnImA/KMmkdf3bVYx2iNs99
	bl08KBJ3NZ+8xN5uwiOPfNR7p4znv49v64zuQG1l8y7DmbvHeFUaSBhQ
X-Gm-Gg: Acq92OHlIooDrxnOzfF5JkfV6kdhZZJ4R5lUtzbYt/vo5xFx4xyD7NVzHO1Du1MIZwO
	RniFNSWEjL3Gw2pNNerQnQ3wnmUqhN2w25XCBoNOI+OSWzzHGDyAXkEPRrH8UlEsnABEA5zv44M
	QX1S/biN8W5qxFrRnVobKVTRT0M8P4bkuyZzK8plC+ndvAFRdmz8L0NL7a/MYkRV6Um6gAiCK0+
	JLirP9cio7CEwAouAYLyzbMG9mLmNHxGnSSCCJXCzrhn3EddLmpxiCa3EQMio0nQunAr86OVJ1t
	q8drHRanSIjlpfTvKKdWh60UzadkJF2PZ+pxtFoBt0Ye0ojHIQebl6QRhmTBw2eTUfFNndw1mEg
	Td2t8a/rI8eJHfSfUF2usStdR8jvLd+vqTrGPQgOqDbXYlqLYwXwgTa6vvtEETCD2POhC9QP7x3
	1tEmACBqrj4L19km/AtGMQqSBCirU5h4IVainD/SokJ2G5eu3D8H4MpNmm5NQ=
X-Received: by 2002:a05:600d:8486:10b0:490:c2a2:e91c with SMTP id 5b1f17b1804b1-490c2a2ea20mr33466435e9.34.1780660219017;
        Fri, 05 Jun 2026 04:50:19 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm41857850f8f.27.2026.06.05.04.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:50:18 -0700 (PDT)
Date: Fri, 5 Jun 2026 13:50:01 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] selftests/landlock: test SCOPE_SIGNAL on the
 SIGIO/fowner pgid path
Message-ID: <20260605.b1f90e8b16bd@gnoack.org>
References: <cover.1780614610.git.hexlabsecurity@proton.me>
 <43370e89f7a896a583bf33d1cd171d02630e61bf.1780614610.git.hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43370e89f7a896a583bf33d1cd171d02630e61bf.1780614610.git.hexlabsecurity@proton.me>

On Thu, Jun 04, 2026 at 11:17:05PM +0000, Bryam Vargas wrote:
> Add regression tests for the LANDLOCK_SCOPE_SIGNAL handling of the
> asynchronous SIGIO delivery path (fcntl(F_SETOWN)) with a process-group
> owner.
> 
> sigio_to_pgid_members covers the bypass: a sandboxed process at the head
> of its process group's PID hlist (the default after fork()) arms
> F_SETOWN(-pgrp) + O_ASYNC and triggers the fan-out; the in-domain owner
> must be signaled (proving the trigger fired) while the non-sandboxed
> member of the group, outside the domain, must not.
> 
> sigio_to_pgid_self covers the same-process guarantee: the owner is
> registered from a sandboxed non-leader thread, whose domain differs from
> the thread-group leader the kernel signals for a process-group owner.
> That leader belongs to the owner's own process and must still be signaled.
> 
> Without the fix the first test sees the out-of-domain member signaled and
> the second sees the owner's own leader denied.
> 
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
>  .../selftests/landlock/scoped_signal_test.c   | 183 ++++++++++++++++++
>  1 file changed, 183 insertions(+)
> 
> diff --git a/tools/testing/selftests/landlock/scoped_signal_test.c b/tools/testing/selftests/landlock/scoped_signal_test.c
> index d8bf33417619..4359e0262dcf 100644
> --- a/tools/testing/selftests/landlock/scoped_signal_test.c
> +++ b/tools/testing/selftests/landlock/scoped_signal_test.c
> @@ -559,4 +559,187 @@ TEST_F(fown, sigurg_socket)
>  		_metadata->exit_code = KSFT_FAIL;
>  }
>  
> +/*
> + * Checks that LANDLOCK_SCOPE_SIGNAL is enforced on the asynchronous SIGIO
> + * delivery path (fcntl(F_SETOWN)) when the file owner is a process group.
> + *
> + * A sandboxed process sitting at the head of its process group's PID hlist
> + * (the default position right after fork()) used to escape the
> + * fcntl(F_SETOWN, -pgrp) domain recording: pid_task(pgrp, PIDTYPE_PGID)
> + * resolved to the process itself, so the same-thread-group exemption skipped
> + * recording its Landlock domain.  At SIGIO time that domain was then unset and
> + * the signal fanned out to every group member, including non-sandboxed
> + * processes outside the domain.
> + */
> +TEST(sigio_to_pgid_members)
> +{
> +	int trigger[2], sync_child[2];
> +	char buf;
> +	pid_t child;
> +	int status, i;
> +
> +	drop_caps(_metadata);
> +
> +	/*
> +	 * Isolates the test in its own process group so the SIGIO fan-out stays
> +	 * bounded to this parent and the child forked below.
> +	 */
> +	ASSERT_EQ(0, setpgid(0, 0));
> +
> +	/* The non-sandboxed parent is the protected (out-of-domain) target. */
> +	ASSERT_EQ(0, setup_signal_handler(SIGURG));
> +	signal_received = 0;
> +
> +	ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
> +	ASSERT_EQ(0, pipe2(sync_child, O_CLOEXEC));
> +
> +	child = fork();
> +	ASSERT_LE(0, child);
> +	if (child == 0) {
> +		/*
> +		 * The child inherits the parent's new process group and, just
> +		 * attached with hlist_add_head_rcu(), is now the head of the
> +		 * pgid hlist: this is the case that used to skip the recording.
> +		 */
> +		EXPECT_EQ(0, close(sync_child[0]));
> +
> +		/* In-domain positive control: the child must be signaled. */
> +		ASSERT_EQ(0, setup_signal_handler(SIGURG));
> +		signal_received = 0;
> +
> +		create_scoped_domain(_metadata, LANDLOCK_SCOPE_SIGNAL);
> +
> +		/* Owns the SIGIO source for the whole process group. */
> +		ASSERT_EQ(0, fcntl(trigger[0], F_SETSIG, SIGURG));
> +		ASSERT_EQ(0, fcntl(trigger[0], F_SETOWN, -getpgrp()));
> +		ASSERT_EQ(0, fcntl(trigger[0], F_SETFL, O_ASYNC));
> +
> +		/* Fans SIGURG out to every member of the process group. */
> +		ASSERT_EQ(1, write(trigger[1], ".", 1));
> +
> +		/*
> +		 * The sandboxed child is in its own domain and must always be
> +		 * signaled: this proves the SIGIO actually fired.
> +		 */
> +		for (i = 0; i < 1000 && !signal_received; i++)
> +			usleep(1000);
> +		EXPECT_EQ(1, signal_received);
> +
> +		ASSERT_EQ(1, write(sync_child[1], ".", 1));
> +		EXPECT_EQ(0, close(sync_child[1]));
> +
> +		_exit(_metadata->exit_code);
> +		return;
> +	}
> +	EXPECT_EQ(0, close(sync_child[1]));
> +	EXPECT_EQ(0, close(trigger[0]));
> +	EXPECT_EQ(0, close(trigger[1]));
> +
> +	/* Waits for the child to generate the SIGIO. */
> +	ASSERT_EQ(1, read(sync_child[0], &buf, 1));
> +	EXPECT_EQ(0, close(sync_child[0]));
> +
> +	/* Lets a delivered-but-pending signal run our handler, if any. */
> +	for (i = 0; i < 100 && !signal_received; i++)
> +		usleep(1000);
> +
> +	/*
> +	 * SCOPE_SIGNAL must block the fan-out to this non-sandboxed parent,
> +	 * which is outside the child's Landlock domain.  Before the fix the
> +	 * parent was signaled here.
> +	 */
> +	EXPECT_EQ(0, signal_received);
> +
> +	ASSERT_EQ(child, waitpid(child, &status, 0));
> +	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
> +	    WEXITSTATUS(status) != EXIT_SUCCESS)
> +		_metadata->exit_code = KSFT_FAIL;
> +}
> +
> +static void *thread_setown_scoped(void *arg)
> +{
> +	const int fd = *(int *)arg;
> +	int ruleset_fd;
> +	const struct landlock_ruleset_attr ruleset_attr = {
> +		.scoped = LANDLOCK_SCOPE_SIGNAL,
> +	};
> +
> +	/* Sandboxes only this non-leader thread (no thread syncing). */
> +	ruleset_fd =
> +		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
> +	if (ruleset_fd < 0)
> +		return (void *)THREAD_ERROR;
> +	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0) ||
> +	    landlock_restrict_self(ruleset_fd, 0)) {
> +		close(ruleset_fd);
> +		return (void *)THREAD_ERROR;
> +	}
> +	close(ruleset_fd);
> +
> +	/* Makes this process group own the SIGIO source. */
> +	if (fcntl(fd, F_SETSIG, SIGURG) || fcntl(fd, F_SETOWN, -getpgrp()) ||
> +	    fcntl(fd, F_SETFL, O_ASYNC))
> +		return (void *)THREAD_ERROR;
> +
> +	return (void *)THREAD_SUCCESS;
> +}
> +
> +/*
> + * Checks that the SIGIO fan-out is still delivered to the file owner's own
> + * process when fcntl(F_SETOWN, -pgrp) was issued from a sandboxed non-leader
> + * thread.
> + *
> + * The Landlock domain is recorded for a process-group owner (so out-of-domain
> + * members stay blocked, see sigio_to_pgid_members), but the kernel signals a
> + * process group through its members' thread-group leaders.  Here the leader is
> + * not sandboxed and thus has a different domain than the registering thread, so
> + * the registration-time check cannot tell that it belongs to the owner's own
> + * process.  hook_file_send_sigiotask() must recognize it through the recorded
> + * thread group and allow the delivery, matching the same-process guarantee of
> + * commit 18eb75f3af40.  Without that exemption the leader is wrongly denied and
> + * never signaled.
> + */
> +TEST(sigio_to_pgid_self)
> +{
> +	int trigger[2];
> +	pthread_t thread;
> +	enum thread_return ret = THREAD_INVALID;
> +	int i;
> +
> +	drop_caps(_metadata);
> +
> +	/* Bounds the SIGIO fan-out to this process. */
> +	ASSERT_EQ(0, setpgid(0, 0));
> +
> +	/* The non-sandboxed thread-group leader is the SIGIO target. */
> +	ASSERT_EQ(0, setup_signal_handler(SIGURG));
> +	signal_received = 0;
> +
> +	ASSERT_EQ(0, pipe2(trigger, O_CLOEXEC));
> +
> +	/*
> +	 * Registers the process-group fowner from a sibling thread that
> +	 * sandboxes only itself, so its domain differs from the leader's.
> +	 */
> +	ASSERT_EQ(0, pthread_create(&thread, NULL, thread_setown_scoped,
> +				    &trigger[0]));
> +	ASSERT_EQ(0, pthread_join(thread, (void **)&ret));
> +	ASSERT_EQ(THREAD_SUCCESS, ret);
> +
> +	/* Fans SIGURG out to the process group. */
> +	ASSERT_EQ(1, write(trigger[1], ".", 1));
> +
> +	for (i = 0; i < 1000 && !signal_received; i++)
> +		usleep(1000);
> +
> +	/*
> +	 * Same-process delivery must always be allowed, even though the owner
> +	 * was registered from a sandboxed sibling thread.
> +	 */
> +	EXPECT_EQ(1, signal_received);
> +
> +	EXPECT_EQ(0, close(trigger[0]));
> +	EXPECT_EQ(0, close(trigger[1]));
> +}
> +
>  TEST_HARNESS_MAIN
> -- 
> 2.43.0
> 
> 

Reviewed-by: Günther Noack <gnoack3000@gmail.com>
