Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794513596F8;
	Mon, 15 Jun 2026 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515651; cv=none; b=aJ7VzBjx9LQicUIXbx7ZR0+iRuVwKGPmUY7Oh6su6zcs9p5P1F1OWwqZSsXFbz1+5P8lrakEOyAZG1bki5v6gLm5tD3VaSk59axMrzwLk+iJTm/0l1/RB1HdQ/2y3HwLITkbGn7VTnrqyggZO9yeiSU55Pwko9bUcqRbJBab1Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515651; c=relaxed/simple;
	bh=iiI/3oYFv5y6wTk4HPzM9H4YOmIMLgjc8doasA80F5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ6Y0u5VMlcEHtD5T0J62UdO8CKGFzgXYAnCgM1RqRybohamEZ1yIBQX+cmPrbM5G7zHA6bJAV41JwisZqc0TTfGbst8yni4GNkdvjERdCWTozg2zXN3vRFTmLZc8wK1BRp1eSZYY6UG+UmI1GNxWF8SaOnsevnTRkBVpW+ykaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=XT8kYBOp; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="XT8kYBOp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CYeIUWAZAMbunjNvtgNf11r755PDjXW4U8h+2x+GW+8=; b=XT8kYBOpELSi+dB+QCLRVVBq0r
	xE3Kp4ltNT4zeToDTjh2HiL/sjP+EJd+acf48B2fcFn7ruEMLFhZMEiBSl2GNnRj7S8vo2zJAjoS7
	BQWXCI1zR8ZSz+wbrHnnRRA/eothFn96GFBDDLo+/+lbre7o8qbUYyJnN90nPhWzc6OcD0aklKf8c
	J4RjY0le5LvE6jMT8hQwJizU2RQkUeeOWFE8D1J0d24+rpRFywmbC4oRXqA9Om0fEiULH82a71/MK
	mJAakOVbb1f0AlrY9X/BBhe72SJHo5G3LPAN/Q82FJAgSy7sFKbJFTovAmv5JR3GjXYSzbaCa/XF8
	HZGvfTvQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZ3bC-00CyHz-0U;
	Mon, 15 Jun 2026 09:27:18 +0000
Date: Mon, 15 Jun 2026 02:27:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, lance.yang@linux.dev, 
	Davidlohr Bueso <dave@stgolabs.net>, Oleg Nesterov <oleg@redhat.com>, Qian Cai <cai@lca.pw>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/kmemleak: avoid soft lockup when scanning task
 stacks
Message-ID: <ai_EVJVfe42glgKI@gmail.com>
References: <20260612-kmemleak-stack-resched-v2-1-53240de79e88@debian.org>
 <aiw9u4BllwZXDH2S@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiw9u4BllwZXDH2S@arm.com>
X-Debian-User: leitao

Hello Catalin,

On Fri, Jun 12, 2026 at 06:11:40PM +0100, Catalin Marinas wrote:
> Thanks for addressing this long-standing soft lockup problem.

Happy to help. We run kmemleak on several hosts in Meta's fleet, and
I'm working to improve stability for those systems.

> Yet anther variant below, untested. Basically, it follows the
> next_tgid() or task_seq_get_next() approach (we might as well move this
> to a separate function to avoid excessive indentation):

This is excellent. I explored similar approaches before proposing the
horrendous array-based solution in v1, but didn't arrive at anything
that would work. Thanks!

> 	if (kmemleak_stack_scan) {
> 		struct pid *pid;
> 		int nr = 1;
> 
> 		do {
> 			struct task_struct *p = NULL;
> 
> 			rcu_read_lock();
> 			pid = find_ge_pid(nr, &init_pid_ns);
> 			if (pid) {
> 				nr = pid_nr(pid) + 1;
> 				p = pid_task(pid, PIDTYPE_PID);
> 				if (p)
> 					get_task_struct(p);
> 			}
> 			rcu_read_unlock();
> 
> 			if (p) {
> 				void *stack = try_get_task_stack(p);
> 
> 				if (stack) {
> 					scan_block(stack, stack + THREAD_SIZE,
> 							NULL);
> 					put_task_stack(p);
> 				}
> 				put_task_struct(p);
> 			}

Should we add a scan_should_stop() check here to allow early
termination?

Thanks,
--breno
