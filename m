Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778413546C6;
	Fri, 19 Jun 2026 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860177; cv=none; b=f/6X0cjFjBjCxYCybTo3Zd3N/5ISH+/sZvQ6KvYOqWgSdks4FLs/1u2Xg4eVEdD3tO+Hr3kJL6RkIgg6+AQM8PsDjqtf2dNfQ8gemtdCDtN0FJBPcysgJpKTvAyLikaACJ6ODbyRsTXITgTM8y5Mk/eEq7sNoU6nXdDitNj0BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860177; c=relaxed/simple;
	bh=IvXspg0ZiStH7ZuuaX97arro3mrsjTvqtOgo2aJS8EI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7Nrp4JzYQl5zVX11OCbVw4+HkSrbGc+LNAzehhKNISGTOOfzhOcje4UYiC0SZyNh//NO3B1Hd5XOwqyTvbP8FdpHlztfwmnIVqxJQSDLFHGaeiomYTo5tFBSpnoDyTK8f5k3qluonuYXmNsrOOI6BEzCdJSstfOWsJXVncpokk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=MdVJuS9x; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="MdVJuS9x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1781860176; x=1813396176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8zt4sD1CkPtrU0rqWyuiTvD/tBylchvCBoRm98EulcM=;
  b=MdVJuS9xurUFLUi31Hpx7CEZ/GeMr24e7O8C6XaQDNaViXiRb1YSbpGl
   6HwvgxaThnj7wjOydIO315fgiMLX1gyhn5DfwUFedJSMjftX76lnXkw5C
   Q/byKcgZT/IcMgX18wf7vDohNcvuyt0BPhZHal3N+FEO/Ng2aVNJW9lc4
   FOFTpkCKHr2cOKOZYwgYEZXM+4BxCOmGAtb0tH18tqugar10Uw8gsvuCD
   l5EF8kXMDNjrKL5vqP6EHC2th+jm5w2eIdkMmsGVgUYz0TNjsMuTu7+kD
   aRRn7HwfVk8OuuNzdY3VJV4oohXm3Te1OyTSqZAPNChoaK155lql8DXwz
   w==;
X-CSE-ConnectionGUID: be8TuX0pQUm3CXJHwKI91g==
X-CSE-MsgGUID: V9l3NlhmS9GT6DYZ8GeGZg==
X-IronPort-AV: E=Sophos;i="6.24,213,1774310400"; 
   d="scan'208";a="21954542"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 09:09:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:25680]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.27:2525] with esmtp (Farcaster)
 id 5d80061e-508b-4894-a701-7c4910170ea3; Fri, 19 Jun 2026 09:09:32 +0000 (UTC)
X-Farcaster-Flow-ID: 5d80061e-508b-4894-a701-7c4910170ea3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 09:09:32 +0000
Received: from dev-dsk-mheyne-1b-8cc83676.eu-west-1.amazon.com (10.13.235.223)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 19 Jun 2026 09:09:31 +0000
Date: Fri, 19 Jun 2026 09:09:28 +0000
From: Maximilian Heyne <mheyne@amazon.de>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
CC: <stable@vger.kernel.org>, =?iso-8859-1?Q?G=FCnther?= Noack
	<gnoack@google.com>, Shuah Khan <shuah@kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/landlock: explicitly disable audit
Message-ID: <20260619-hold-nissan-07be06c0@mheyne-amazon>
References: <20260529-welsh-nagoya-b4d9ca60@mheyne-amazon>
 <20260604.Gee4caexei8o@digikod.net>
 <20260619.Ang7AiGeishu@digikod.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20260619.Ang7AiGeishu@digikod.net>
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Transfer-Encoding: quoted-printable

Hi Micka=EBl,

On Fri, Jun 19, 2026 at 10:32:45AM +0200, Micka=EBl Sala=FCn wrote:
> I extended your patch and merged it:
> https://git.kernel.org/mic/c/next&id=3D0302cd72fe196aee933e3fb76f6d175d1a=
b0e843
> =

> Thanks!

Thank you! Sorry for the late response. Only yesterday I tried the
patches you pointed me at and they also helped in my setup. I was also
about to sent a patch regarding filtering out the domain deallocation
records but that was also covered by you already.

> =

> On Tue, Jun 09, 2026 at 12:51:03AM +0200, Micka=EBl Sala=FCn wrote:
> > Thanks for this patch.  I merged a few fixes and I'd be interested to
> > know if this one fix the issue you spotted:
> > https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=
=3Dnext&id=3Dd8dfb4c7faa87c3e41a8678f38f136c2c7c036fa
> > =

> > =

> > On Fri, May 29, 2026 at 08:03:41PM +0000, Maximilian Heyne wrote:
> > > I'm seeing sporadic selftest failures, such as
> > > =

> > >   #  RUN           scoped_audit.connect_to_child ...
> > >   # scoped_abstract_unix_test.c:314:connect_to_child:Expected 0 (0) =
=3D=3D records.access (8)
> > >   # connect_to_child: Test failed
> > >   #          FAIL  scoped_audit.connect_to_child
> > >   not ok 19 scoped_audit.connect_to_child
> > > =

> > > This seems similar to what commit 3647a4977fb73d ("selftests/landlock:
> > > Drain stale audit records on init") tried to fix. However, the added
> > > drain loop is not effective. When setting the AUDIT_STATUS_PID, the
> > > kauditd_thread is woken up starting to send messages from the hold qu=
eue
> > > to the netlink. Depending on scheduling of this kthread not all messa=
ges
> > > might be send via the netlink in the 1 us interval.
> > > =

> > > Therefore, instead of trying to drain the queue, let's just disable
> > > audit when running non-audit tests or more precisely disable it after
> > > audit-tests. This way we won't generate any new audit message that co=
uld
> > > interfere with the other tests.
> > > =

> > > The comment saying that on process exit audit will be disabled is wro=
ng.
> > > The closed file descriptor just causes an auditd_reset(), not a
> > > disablement. So future messages will be queued in the hold queue.
> > > =

> > > Cc: stable@vger.kernel.org
> > > Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags a=
nd domain IDs")
> > > Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> > > ---
> > > =

> > > I've seen the failures on the 6.18 kernels but haven't tested on late=
st
> > > upstream. However, I still think this is an issue.
> > > =

> > > ---
> > >  tools/testing/selftests/landlock/audit.h | 13 +++++--------
> > >  1 file changed, 5 insertions(+), 8 deletions(-)
> > > =

> > > diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing=
/selftests/landlock/audit.h
> > > index 834005b2b0f09..7842330875f53 100644
> > > --- a/tools/testing/selftests/landlock/audit.h
> > > +++ b/tools/testing/selftests/landlock/audit.h
> > > @@ -494,10 +494,9 @@ static int audit_init_filter_exe(struct audit_fi=
lter *filter, const char *path)
> > >  static int audit_cleanup(int audit_fd, struct audit_filter *filter)
> > =

> > audit_cleanup() should be called for audit_exec tests too.
> > =

> > >  {
> > >  	struct audit_filter new_filter;
> > > +	int err;
> > >  =

> > >  	if (audit_fd < 0 || !filter) {
> > > -		int err;
> > > -
> > >  		/*
> > >  		 * Simulates audit_init_with_exe_filter() when called from
> > >  		 * FIXTURE_TEARDOWN_PARENT().
> > > @@ -518,12 +517,10 @@ static int audit_cleanup(int audit_fd, struct a=
udit_filter *filter)
> > >  	audit_filter_exe(audit_fd, filter, AUDIT_DEL_RULE);
> > >  	audit_filter_drop(audit_fd, AUDIT_DEL_RULE);
> > >  =

> > > -	/*
> > > -	 * Because audit_cleanup() might not be called by the test auditd
> > > -	 * process, it might not be possible to explicitly set it.  Anyway,
> > > -	 * AUDIT_STATUS_ENABLED will implicitly be set to 0 when the auditd
> > > -	 * process will exit.
> > > -	 */
> > =

> > Please add a comment that explains that the audit state is not restored
> > but just disabled.
> > =

> > > +	err =3D audit_set_status(audit_fd, AUDIT_STATUS_ENABLED, 0);
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	return close(audit_fd);
> > =

> > FDs should always be closed.
> > =

> > >  }
> > >  =

> > > -- =

> > > 2.50.1
> > > =

> > > =

> > > =

> > > =

> > > Amazon Web Services Development Center Germany GmbH
> > > Tamara-Danz-Str. 13
> > > 10243 Berlin
> > > Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> > > Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> > > Sitz: Berlin
> > > Ust-ID: DE 365 538 597
> > > =

> > > =




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597

