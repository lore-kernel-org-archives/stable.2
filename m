Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970538655A;
	Wed, 14 Oct 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792004396; cv=none; b=S2udxzqxP2BHlGPwEK+rtM9cci7B3gQpJayZJLNiCd8LyD6WLgqC/t54H3RbPU9+r0Y1SINX1hDAsL4Nd6KhZvA6CWN/cSpGfwagQuhfDy+QyBl+uqUSUWwAy2ZkopMeBEtNktw0YNOjoI7/sNobAq6gxrxEM6POhho2Qie+JwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792004396; c=relaxed/simple;
	bh=v01eufSSkMK2Ssm0QFEjHeUPWJsjYJs7y5wZ21fVnUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lC/EVeUfaMtV7cr+mKgIQ2/myPnsjaY4XJo1QT295NNO314ANWq7YzSJSDgKk0lxJh67p223VgbtGEmZD1EVUhbdVD8zGyEgdRCyjq133A4fSkornVW+v9pZi6Bl1tqtaF5/FksPqgzqf5gzE5EJ8z0456xGIQuXli1zBWwrzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7okzoa8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7okzoa8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9329E1F000C4;
	Wed, 14 Oct 2026 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792004395;
	bh=QmCjJWonjPZlo+NNn27Bd84fmKXnLf7XN+7sY7W46yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a7okzoa8t1w4RYqc2S7n8nu4EBWX+nvXHNLLwC8eUA3EMdfmFx6PcI/UbATV2Ttd9
	 X3W/q98ilCJmA+hEcuVB2OAR+eFqhWkbvT3xspMfI50hb08+V3aBztOXImaY+25RW6
	 ZDqdS7ngece7sQyyBtmG1TEbs2oNRT3+KGmEtsSboW66rdIq7d9soB5kjEKVcCQOgI
	 +2nfwUArePsj7wvtkZUQdISkIx9y6euHXHlATmiTDJBtWcdgT6f+b0P955uriOBDIe
	 m46Ytqp+0OAkUMtlbnxaI4ijjRqTnHwp5z5vAahPa6iPAjCA7IfQRaBxqG7eeJ2Q1l
	 eQ/3D4I4fegNw==
Date: Wed, 14 Oct 2026 21:59:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] keys: Protect quota-owner reads in namespace
 filters
Message-ID: <as_RJx-M2IKX-PDZ@kernel.org>
References: <20261013084056.1070923-1-nicoyip.dev@gmail.com>
 <20261013090358.1178367-1-nicoyip.dev@gmail.com>
 <as9otxVeOLbhkIMy@kernel.org>
 <CAAo+4rXGputXtxgkLLAtFSS=utgr=S=ajbqDFZV=jySZ1yz+sw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rXGputXtxgkLLAtFSS=utgr=S=ajbqDFZV=jySZ1yz+sw@mail.gmail.com>

On Thu, Oct 15, 2026 at 01:52:04AM +0800, Chengfeng Ye wrote:
> Dear Jarkko,
> 
> On Wed, Oct 14, 2026 at 7:34 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Tue, Oct 13, 2026 at 05:03:57PM +0800, Chengfeng Ye wrote:
> > > keyctl_chown_key() replaces key->user under key->sem and drops the
> > > reference to the previous owner after releasing the semaphore. Readers
> > > which do not hold that semaphore can still be using the previous owner
> > > when key_user_put() frees it.
> > >
> > > For example, namespace filtering in /proc/keys can race with chown:
> > >
> > >   /proc/keys reader                 keyctl_chown_key()
> > >   user = key->user
> > >                                     key->user = newowner
> > >                                     key_user_put(old)
> > >                                       kfree(old)
> > >   read user->uid
> > >
> > > An earlier instrumented run reported:
> > >
> > >   BUG: KASAN: slab-use-after-free in proc_keys_start+0x353/0x440
> > >   Read of size 4 at addr ffff8881128abbc0 by task poc/88
> > >   Call Trace:
> > >    proc_keys_start+0x353/0x440
> > >    seq_read_iter+0x25d/0x1190
> > >    proc_reg_read_iter+0x19e/0x260
> > >   Allocated by task 86:
> > >    key_user_lookup+0x1b4/0x540
> > >    keyctl_chown_key+0x3cc/0xbf0
> > >   Freed by task 87:
> > >    kfree+0x149/0x330
> > >    keyctl_chown_key+0x7b0/0xbf0
> >
> > Last night I missed the text below.
> >
> > It is somewhat messy to the point that frankly I could not read it, or
> > at least I did not understand it. Have you read it yourself?
> >
> > There is a whole eassay and I can only see that key->user can change
> > unless key_user_lock is taken, and READ_ONCE() is required to pair with
> > the writers.
> 
> That READ_ONCE() should be unnecessary, since key_user_lock now
> serializes both readers and writers. I will double-check whether to
> drop it.
> 
> > I don't understand what is going on down there, and what's your goal
> > with it?
> 
> Yes, the messy commit message should be cleaned up before sending...
> Sorry for that. Basically, it describes why the three `key->user` use
> sites should be protected by the lock (because there's no
> synchronization) and why the remaining access at other sites doesn't
> need it (because other caller sites are synchronized). I will rephrase
> the commit message to make it human-readable.

Maybe in the case of these bugs do this:

1. From both: drop the tail.
2. Just think yourself is there a remark that is good to keep
   in my. Put those. Not more.
3. Put exactly what makes sense to you, not for me. Don't
   put if you don't want to.

E.g., maybe in the case of this patch it could be that you just
take the head and add remark about READ_ONCE(). Perhaps did not
think whole a lot.

Now it feels maybe that the tail is some kind of "just in case
list of things". 

Hope these instructions help you out. In this case I don't
believe in zero effort, or actually I believe that you do
check up stuff properly it shows from the first half of
the commit messages and from your responses.

Just wanted to state that explicitly so that it is clear.  Commit
messages are in this case exactly the glitch. Otherwise, I don't have
any issues, fears or doubts.

Br, Jarkko
