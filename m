Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC2934D385
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857976; cv=none; b=nXEVt+25pdBcG421dLplcOTgBw+9Lu0ZgFcTfDwl9E4v41fj8RHoYOIy6YIsQaS+Lj3Gjg8BKgLyg4Zyet9L+lNDVjOzOQvTAI5Fzj9hQb3pma75Mv5R9sXDhJudCujU5IBH2lcmw6E289oS087toMlcw201Kgh3KZHjxikoGTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857976; c=relaxed/simple;
	bh=lcghnOgksc6K+V+60sUOKH8n4KczTxPimTMIG8NYUeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfXS6FBIN6pQi3lHeIGOVPvU2CWo+O/kJuhkXWBbyQ2QL1I1eHpySmLVv8MUQus0KSRw9P/5MXOZ5HjND7vSTWlBKc3kpgEbYnEcMsm8ItpeMW1V3Akmhn6JRYaR6k6XUgxbLzrT2gyupO5G07ehisQgVpJ5cvnr0PZtRcx28CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Cwv4/6bg; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Cwv4/6bg"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghW7Q2Ycrzjb0;
	Fri, 19 Jun 2026 10:32:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1781857970;
	bh=TINzsjs7sBCgOdj6Zwmh7AnMmqEBiyCV2/FS4lTZiEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cwv4/6bgV0w/feEyfVInIsWZHiMNedNcv2d3bfpcq/mMGA1b0LXXHaWc9N83g/SUO
	 pZe2EwU+7TmS7NPTdVj7pvnKTe6P0glLIQhmfGYZh1C4IGuLOIE56fhLMLzOxabgek
	 /ynttDEvfxJ5t3QAIXciGNd8xN15d+pFdON4IMBk=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghW7P47gjzp2Z;
	Fri, 19 Jun 2026 10:32:49 +0200 (CEST)
Date: Fri, 19 Jun 2026 10:32:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Maximilian Heyne <mheyne@amazon.de>
Cc: stable@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Shuah Khan <shuah@kernel.org>, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/landlock: explicitly disable audit
Message-ID: <20260619.Ang7AiGeishu@digikod.net>
References: <20260529-welsh-nagoya-b4d9ca60@mheyne-amazon>
 <20260604.Gee4caexei8o@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604.Gee4caexei8o@digikod.net>
X-Infomaniak-Routing: alpha

I extended your patch and merged it:
https://git.kernel.org/mic/c/next&id=0302cd72fe196aee933e3fb76f6d175d1ab0e843

Thanks!

On Tue, Jun 09, 2026 at 12:51:03AM +0200, Mickaël Salaün wrote:
> Thanks for this patch.  I merged a few fixes and I'd be interested to
> know if this one fix the issue you spotted:
> https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=d8dfb4c7faa87c3e41a8678f38f136c2c7c036fa
> 
> 
> On Fri, May 29, 2026 at 08:03:41PM +0000, Maximilian Heyne wrote:
> > I'm seeing sporadic selftest failures, such as
> > 
> >   #  RUN           scoped_audit.connect_to_child ...
> >   # scoped_abstract_unix_test.c:314:connect_to_child:Expected 0 (0) == records.access (8)
> >   # connect_to_child: Test failed
> >   #          FAIL  scoped_audit.connect_to_child
> >   not ok 19 scoped_audit.connect_to_child
> > 
> > This seems similar to what commit 3647a4977fb73d ("selftests/landlock:
> > Drain stale audit records on init") tried to fix. However, the added
> > drain loop is not effective. When setting the AUDIT_STATUS_PID, the
> > kauditd_thread is woken up starting to send messages from the hold queue
> > to the netlink. Depending on scheduling of this kthread not all messages
> > might be send via the netlink in the 1 us interval.
> > 
> > Therefore, instead of trying to drain the queue, let's just disable
> > audit when running non-audit tests or more precisely disable it after
> > audit-tests. This way we won't generate any new audit message that could
> > interfere with the other tests.
> > 
> > The comment saying that on process exit audit will be disabled is wrong.
> > The closed file descriptor just causes an auditd_reset(), not a
> > disablement. So future messages will be queued in the hold queue.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
> > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > ---
> > 
> > I've seen the failures on the 6.18 kernels but haven't tested on latest
> > upstream. However, I still think this is an issue.
> > 
> > ---
> >  tools/testing/selftests/landlock/audit.h | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
> > index 834005b2b0f09..7842330875f53 100644
> > --- a/tools/testing/selftests/landlock/audit.h
> > +++ b/tools/testing/selftests/landlock/audit.h
> > @@ -494,10 +494,9 @@ static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
> >  static int audit_cleanup(int audit_fd, struct audit_filter *filter)
> 
> audit_cleanup() should be called for audit_exec tests too.
> 
> >  {
> >  	struct audit_filter new_filter;
> > +	int err;
> >  
> >  	if (audit_fd < 0 || !filter) {
> > -		int err;
> > -
> >  		/*
> >  		 * Simulates audit_init_with_exe_filter() when called from
> >  		 * FIXTURE_TEARDOWN_PARENT().
> > @@ -518,12 +517,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
> >  	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
> >  	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
> >  
> > -	/*
> > -	 * Because audit_cleanup() might not be called by the test auditd
> > -	 * process, it might not be possible to explicitly set it.  Anyway,
> > -	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
> > -	 * process will exit.
> > -	 */
> 
> Please add a comment that explains that the audit state is not restored
> but just disabled.
> 
> > +	err = audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
> > +	if (err)
> > +		return err;
> > +
> >  	return close(audit_fd);
> 
> FDs should always be closed.
> 
> >  }
> >  
> > -- 
> > 2.50.1
> > 
> > 
> > 
> > 
> > Amazon Web Services Development Center Germany GmbH
> > Tamara-Danz-Str. 13
> > 10243 Berlin
> > Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > Sitz: Berlin
> > Ust-ID: DE 365 538 597
> > 
> > 
