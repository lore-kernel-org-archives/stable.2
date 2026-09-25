Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF534D3B9;
	Fri, 25 Sep 2026 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349786; cv=none; b=NtZG/tA+dvCRboA/8UrmGTOXjza2Nln4PQ5Cd5zacHxcqLGIK6M5J3g7zAnKE6kXPNNInfGCJZJUj+1zIMZMHcfINQp4I2pOYarm90OpJNImzwNrj1romxps9D6XxPqnrRECKIQ8IEH6552cdocqHOiZgOKg5ySCjQ7oM9Tql3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349786; c=relaxed/simple;
	bh=SWc83UqTAkDV7WEL+4a1H4Tpio+CTGZYBFHq2jOI1SQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIkMU0QFa5ooxAO3grJZCK737ZKVUPQ4yXoIEoeQ/DuQwoLN8S3p3k7Tbaepm59X6BW6XkZqInydvnz3Q4fNz51SUqeWAO76b/rfI31gWiQ95RY00bGYEwH+YBgvt/08Q3pUiGitwwLOOLaXgQ7HdtN2EfRbnVHNcf1qmEo6F3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNzAXmUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNzAXmUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98291F000FF;
	Fri, 25 Sep 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790349784;
	bh=wvcVEneofb0DGWWcLLjfTra2Qi+3HpZ+zonfvQOjIjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QNzAXmUCLeWgP3VMxOK5PkqMR46UqwsVvb+4w3754gUDaz60UgyneR3icJxjxPdjH
	 m7QFXX7CkYkCydVKsNAgJTWioFO11LNQMvcwX3DHsP7gJ6c8EeTw1M/cVNH8cW2sW2
	 Wem0uDyB9x+H8TRpzsagNnEo3YzQpDkTgbQkqJTUnlg2uB03okkNS02PrL3XuiKlin
	 Tx6dmJxTSJSqWhBXtZuS8pYeoz71CGUd2igd5lyF1q1iBUmSiPc9Nq+OjoUSaAmmvE
	 H/Kynqw3iH5yUWJYxFTHroXkfKImsefr4V9jFvQNi8j00mkTHMSDGuGBZ0tmpFK9R/
	 Y6HFI2wN7xc/g==
Date: Fri, 25 Sep 2026 17:22:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrea Parri <parri.andrea@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fs/xattr: don't assume the inode is locked in
 path_unlink/path_rmdir
Message-ID: <20260925-hernieder-leinwand-gaffen-99a8e603725f@brauner>
References: <20260922145530.369775-1-parri.andrea@gmail.com>
 <DLN6RPOBSYOQ.13B97Z6OSFXY5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DLN6RPOBSYOQ.13B97Z6OSFXY5@gmail.com>

On Thu, Sep 24, 2026 at 02:20:54AM +0000, Alexei Starovoitov wrote:
> On Tue Sep 22, 2026 at 2:55 PM UTC, Andrea Parri wrote:
> > bpf_lsm_has_d_inode_locked() makes the verifier rewrite
> > bpf_[set|remove]_dentry_xattr() to the _locked variants, which assume
> > that the caller already holds the inode's i_rwsem.  The path_unlink and
> > path_rmdir hooks are listed, but security_path_unlink() and
> > security_path_rmdir() run before vfs_unlink()/vfs_rmdir() take the
> > victim inode's i_rwsem, so a sleepable BPF LSM program attached to
> > either hook mutates the victim's xattrs without the lock held.
> >
> > Drop the two path hooks from d_inode_locked_hooks so that the verifier
> > keeps the locking bpf_[set|remove]_dentry_xattr() variants, which take
> > the lock themselves.
> >
> > Fixes: 56467292794b8 ("bpf: fs/xattr: Add BPF kfuncs to set and remove xattrs")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> > ---
> >  fs/bpf_fs_kfuncs.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> > index 6cb8772679782..357a379ef92a5 100644
> > --- a/fs/bpf_fs_kfuncs.c
> > +++ b/fs/bpf_fs_kfuncs.c
> > @@ -472,10 +472,6 @@ BTF_ID(func, bpf_lsm_inode_rmdir)
> >  BTF_ID(func, bpf_lsm_inode_setattr)
> >  BTF_ID(func, bpf_lsm_inode_setxattr)
> >  BTF_ID(func, bpf_lsm_inode_unlink)
> > -#ifdef CONFIG_SECURITY_PATH
> > -BTF_ID(func, bpf_lsm_path_unlink)
> > -BTF_ID(func, bpf_lsm_path_rmdir)
> > -#endif /* CONFIG_SECURITY_PATH */
> >  BTF_SET_END(d_inode_locked_hooks)
> 
> Christian,
> this looks correct. Want to take it via vfs?

Yes, picked up now. Sorry, foot injury was afk.
