Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CE3B3894
	for <stable@vger.kernel.org>; Mon,  8 Jun 2026 22:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959073; cv=none; b=st0/8X8Vm7oPkOvY4l8mBALXRnD1uJfN8Q9EJhFfPQ4z7F+xkvI7EOUkYnVCn9xkCiYQ+ik8fjobnIdZWfAl1i/hKEJG7v+lKKVLUz3UUZp8cc/JJk0O3fEXS5/7mf40jU1bEaAQXTPoxHiDzcjZukX+YTVnwBedVH4f1Gbt10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959073; c=relaxed/simple;
	bh=tcojNWyZlA4hOL9PXkaYaUZBxwMZ3D8jqxSv4YkHmM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUzHizBfGDq68xrusyYQBnZ6KwlLZRvRELlYoWedo8EB0qjoRkvSTrjl0kN44ECNJcGT0iisIdUnnKv1Mvat0C8buqXmhvCRAPfxGXnMH8xbghn2uzsvjxJDuOh1QkBrZEQrOvHImXp2i0qOf8gw/XTJ8jRoV+6iK3vazg/7sVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=rBBtcnRo; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="rBBtcnRo"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gZ6hm00m7z954;
	Tue,  9 Jun 2026 00:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1780959063;
	bh=Ihp2DWwa5XBMw5A0wiUqR5CUCI5kU3bO6aS6PO85JbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBBtcnRoo0EGvKWh39HYPlkpgOTsZiU5rD5UO4iRGLDKJkIwUCeLsj8Japl7ptpZx
	 zZLX5iN5ShYj2kyFdGnzjuwFqELOw2OQ+hl1GJg6chCBvyo5X3iEH7YwnNrKUKNdSu
	 Omp7bAEvuNNY6O/ngF4OrCrL1lpn3E+Vfe+pyIiU=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4gZ6hl1WW0zBTN;
	Tue,  9 Jun 2026 00:51:03 +0200 (CEST)
Date: Tue, 9 Jun 2026 00:51:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: explicitly disable audit
Message-ID: <20260604.Gee4caexei8o@digikod.net>
References: <20260529-welsh-nagoya-b4d9ca60@mheyne-amazon>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260529-welsh-nagoya-b4d9ca60@mheyne-amazon>
X-Infomaniak-Routing: alpha

Thanks for this patch.  I merged a few fixes and I'd be interested to
know if this one fix the issue you spotted:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=d8dfb4c7faa87c3e41a8678f38f136c2c7c036fa


On Fri, May 29, 2026 at 08:03:41PM +0000, Maximilian Heyne wrote:
> I'm seeing sporadic selftest failures, such as
> 
>   #  RUN           scoped_audit.connect_to_child ...
>   # scoped_abstract_unix_test.c:314:connect_to_child:Expected 0 (0) == records.access (8)
>   # connect_to_child: Test failed
>   #          FAIL  scoped_audit.connect_to_child
>   not ok 19 scoped_audit.connect_to_child
> 
> This seems similar to what commit 3647a4977fb73d ("selftests/landlock:
> Drain stale audit records on init") tried to fix. However, the added
> drain loop is not effective. When setting the AUDIT_STATUS_PID, the
> kauditd_thread is woken up starting to send messages from the hold queue
> to the netlink. Depending on scheduling of this kthread not all messages
> might be send via the netlink in the 1 us interval.
> 
> Therefore, instead of trying to drain the queue, let's just disable
> audit when running non-audit tests or more precisely disable it after
> audit-tests. This way we won't generate any new audit message that could
> interfere with the other tests.
> 
> The comment saying that on process exit audit will be disabled is wrong.
> The closed file descriptor just causes an auditd_reset(), not a
> disablement. So future messages will be queued in the hold queue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> 
> I've seen the failures on the 6.18 kernels but haven't tested on latest
> upstream. However, I still think this is an issue.
> 
> ---
>  tools/testing/selftests/landlock/audit.h | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> index 834005b2b0f09..7842330875f53 100644
> --- a/tools/testing/selftests/landlock/audit.h
> +++ b/tools/testing/selftests/landlock/audit.h
> @@ -494,10 +494,9 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
>  static int audit_cleanup(int audit_fd, struct audit_filter *filter)

audit_cleanup() should be called for audit_exec tests too.

>  {
>  	struct audit_filter new_filter;
> +	int err;
>  
>  	if (audit_fd < 0 || !filter) {
> -		int err;
> -
>  		/*
>  		 * Simulates audit_init_with_exe_filter() when called from
>  		 * FIXTURE_TEARDOWN_PARENT().
> @@ -518,12 +517,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
>  	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
>  	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
>  
> -	/*
> -	 * Because audit_cleanup() might not be called by the test auditd
> -	 * process, it might not be possible to explicitly set it.  Anyway,
> -	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
> -	 * process will exit.
> -	 */

Please add a comment that explains that the audit state is not restored
but just disabled.

> +	err = audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
> +	if (err)
> +		return err;
> +
>  	return close(audit_fd);

FDs should always be closed.

>  }
>  
> -- 
> 2.50.1
> 
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
> 
> 
