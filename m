Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F6C3EC82C;
	Wed, 29 Jul 2026 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337142; cv=none; b=q7mB1Vz3eDLwjxeB8g5geVvnaJlb7D0vpmKwe8sM75lQr4T7/MjeisUFba/QAeBl85jjy6rvQizuM1xQT6EWejIvn8r6ur2mLeyTbbOA2JrE0HBvtNEXE8SGxYrb1OLm3GNTHFeOjFhDDWgdyzDRn39nXX2fIABgYiZhvZErzrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337142; c=relaxed/simple;
	bh=BC9DKDkbFpZIuwKBKE1cpLaKvpdwF7SPweVBu9sPbUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DkL9Jk5X0ney8zaudtKK/cBtaAIjh77HQ3C8CVL5WRc6V2pHqNa63vHeBG8rUYGFB5oaZxF7PwvFhycOGP9ug0TX+0izAXV5MtyzZ3tGGyx9ncsWhny7apTaTkWwUfdV/dAMpneSQRSqvAS7mka11MNafxxkxk3K3d/W+9WOipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1WAxq061; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1WAxq061"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D627B1F00A3A;
	Wed, 29 Jul 2026 14:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785337141;
	bh=7RaxPzkFNolkG0Jn/Y9SXWpPiCVTq0rHihDR8xzPi3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1WAxq061NVZ0oM2CTVmHxuhlh9E/iEZ58U8SNZbC/j1zf4/nKwxqgttZ2JlfNQKvl
	 ZBVqMqZUMIhuzJ9UUq30EhpmwKfFNCfCjLk9RK7yCne73r0gCnx20M+TLxVF1MfbRW
	 F2wUBZ1dVLiZkmMvRAoDkNSVTCSJeFbQ5xEtUW5A=
Date: Wed, 29 Jul 2026 16:58:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: Pasha Boroffski <hex.dec.bin.oct@gmail.com>,
	stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: regress caused by upstream commit
 6650527444dadc63d84aa939d14ecba4fadb2f69
Message-ID: <2026072933-widow-grouped-f9e4@gregkh>
References: <CAHmU7G=Dsf31mJ1VH4+Tp-McSvXCg=GcO-eC+O52-_t5gc7Pyw@mail.gmail.com>
 <CAG48ez1UqV8E8nHGq50orS+3oqXbP80R6g7kVa3Hq-domHCSsQ@mail.gmail.com>
 <CAG48ez1tUk+8b7-eWw-fHh2x_bJA1n3CTANVWKQuPW=J+inCrQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1tUk+8b7-eWw-fHh2x_bJA1n3CTANVWKQuPW=J+inCrQ@mail.gmail.com>

On Wed, Jul 29, 2026 at 03:59:18PM +0200, Jann Horn wrote:
> On Wed, Jul 29, 2026 at 3:45 PM Jann Horn <jannh@google.com> wrote:
> > On Wed, Jul 29, 2026 at 11:08 AM Pasha Boroffski
> > <hex.dec.bin.oct@gmail.com> wrote:
> > > Hello.
> > > I believe 6650527444dadc63d84aa939d14ecba4fadb2f69 has a bug in it as it causes "kernel bug" with PREEMPT_RT enabled.
> > > How to reproduce the bug:
> > > i used 'find /proc/ | grep 123'. When scanning, the kernel triggers an "Oops".
> > >
> > >
> > > [  344.465851][ T3715] BUG: kernel NULL pointer dereference, address: 00000000000000f8
> > [...]
> > [  344.465888][ T3715] CPU: 0 UID: 0 PID: 3715 Comm: find Tainted: G
> >    D    O       6.12.98 #9
> > [...]
> > > [  344.465905][ T3715] RIP: 0010:down_read_killable+0x9/0x40
> > [...]
> > > [  344.465974][ T3715]  proc_map_files_readdir+0xc7/0x500
> > [...]
> > > I think calls
> > > mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > > if (IS_ERR(mm)) {
> > >   result = ERR_CAST(mm);
> > >   goto out_put_task;
> > > }
> > >
> > > should be fixed like
> > > mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
> > > if (IS_ERR_OR_NULL(mm)) {
> > >   result = ERR_CAST(mm);
> > >   goto out_put_task;
> > > }
> >
> > Ugh, yes. This is not an issue on mainline, but the API contract of
> > mm_access() changed in commit cd3f8467afd4 ("mm: refactor mm_access()
> > to not return NULL"), which landed in 6.13. So we'll need a
> > stable-specific fixup for 6.12 and lower.
> >
> > I'll try to come up with a patch for stable later today.
> 
> I've reproduced this, triggering this NULL deref on 6.12.98 is as easy
> as "ls /proc/2/map_files"

Ugh, ok, let me go do some "quick" releases with just this fix in it
right now, sorry about that!

greg k-h
