Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B5285060
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784698712; cv=none; b=jemuSf9rAyoRMB7wex8V0Nz77uFhq4E+fGWOlzblwayWQ2fEUGnMmoqrBoEtL//wOWDeK5zYJxJ1s7LgpO+PUNjAj673y1ZqRtVGoeeFjQAT/fBVWT937hLRF7Gy2uCE7pnra/dkj6wy3FNoflsfB/hwGAEXUT9Z0TB8y8MpDJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784698712; c=relaxed/simple;
	bh=1ZGWoyyvqOJ5KCogeHJ5WHBQVSfDjznr+J1XUiKfBX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXjm4RJZGR6IQ2E3bfmCi2Fx7N8s7bSAKkARd5d6Dby0nHCH47/cmLCMRuBd25IC+HwnVBoEg3Yo6MIAfBr/Oa37/ZFyPtiNO+YFEz2IlW0VCX/z7FVpJKugkbl90UfzJL1h9YDmJkU0OQ60sI9reEuErFaG3iOKjurrs2b2OiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gNilz+mv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gNilz+mv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887E41F000E9;
	Wed, 22 Jul 2026 05:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784698711;
	bh=MZ+yKqGXEyIQFJPzBcI1cwFDDsgWWAguBDA8Yl30fQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gNilz+mvKHRP5T5Uo4jQzjSh2AuGNMZWJABqzEtSqLyOzq7VD7rCRy0CLwywEB/xa
	 j5Jqt2YGllt1EK9ZOmItySD1dwWgws+C3Bj18LMsMFBU+q3kFkQA5uN09S6vYx6C9W
	 NEtnjfiSGJtEdOJWMfJhwecaJZM/rT4XxiHmdO30=
Date: Wed, 22 Jul 2026 07:37:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sean Christopherson <seanjc@google.com>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] KVM: selftests: Remove duplicate
 LAUNCH_UPDATE_VMSA call in" failed to apply to 6.12-stable tree
Message-ID: <2026072256-audio-operator-7f84@gregkh>
References: <2026042008-thesis-flatworm-d8ed@gregkh>
 <al-vQXTtfnq-e7Mf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <al-vQXTtfnq-e7Mf@google.com>

On Tue, Jul 21, 2026 at 10:41:21AM -0700, Sean Christopherson wrote:
> On Mon, Apr 20, 2026, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 25a642b6abc98bbbabbf2baef9fc498bbea6aee6
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042008-thesis-flatworm-d8ed@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > >From 25a642b6abc98bbbabbf2baef9fc498bbea6aee6 Mon Sep 17 00:00:00 2001
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Tue, 10 Mar 2026 16:48:09 -0700
> > Subject: [PATCH] KVM: selftests: Remove duplicate LAUNCH_UPDATE_VMSA call in
> >  SEV-ES migrate test
> > 
> > Drop the explicit KVM_SEV_LAUNCH_UPDATE_VMSA call when creating an SEV-ES
> > VM in the SEV migration test, as sev_vm_create() automatically updates the
> > VMSA pages for SEV-ES guests.  The only reason the duplicate call doesn't
> > cause visible problems is because the test doesn't actually try to run the
> > vCPUs.  That will change when KVM adds a check to prevent userspace from
> > re-launching a VMSA (which corrupts the VMSA page due to KVM writing
> > encrypted private memory).
> > 
> > Fixes: 69f8e15ab61f ("KVM: selftests: Use the SEV library APIs in the intra-host migration test")
> > Cc: stable@vger.kernel.org
> > Link: https://patch.msgid.link/20260310234829.2608037-2-seanjc@google.com
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > 
> > diff --git a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> > index 0a6dfba3905b..6b0928e69051 100644
> > --- a/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> > +++ b/tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> > @@ -36,8 +36,6 @@ static struct kvm_vm *sev_vm_create(bool es)
> >  
> >  	sev_vm_launch(vm, es ? SEV_POLICY_ES : 0);
> >  
> > -	if (es)
> > -		vm_sev_ioctl(vm, KVM_SEV_LAUNCH_UPDATE_VMSA, NULL);
> >  	return vm;
> >  }
> 
> Can you retry applying this to 6.12.y?  This now cherry-picks cleanly to 6.12.y
> (and FWIW, the very original patch applies cleanly too).
> 
> Oooh, I suspect the issue is that the path in 6.12 is x86_64 instead of x86, i.e.
> 
>   tools/testing/selftests/kvm/x86_64/sev_migrate_tests.c
> 
> instead of
> 
>   tools/testing/selftests/kvm/x86/sev_migrate_tests.c
> 
> and git on my end is configured to automagically handle renames?  Holler if an
> explicit patch with the x86_64 is preferred and/or easier to consume.

An explicit patch is preferred, thanks.

greg k-h
