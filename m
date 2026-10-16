Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87E49BB5E;
	Fri, 16 Oct 2026 18:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792175930; cv=none; b=c7kb96Grv7QxZ5pxoc+iRWNOhRe9pDtF6irJL1M88xtz+C52vwfLtJcP53/hTD50wJ+on0hmSG4YPoGGUmA9+upu3ilfjuBZuxOpevGd5PE05R90vmYmJJC5z2VC/rm44BXLEXWrMUziW/hQ7cMpwS303Je2geZeR2tx3Ogj9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792175930; c=relaxed/simple;
	bh=A+BnR8v5h10WNIwUAv8tGGoMO5HL2DXsbw1Yqz4c3YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omgaKReIzv5kbFn28j1OFBGTvU8NjOC87iu/XVX7su4SnsteQkdnvjQ09Xz+NTQnQmtVhTVPELAroVeAP+0EvDgaqBQaaNbDbR8wFs31WhxC1KfEEYfsyO9q4GbxfK7d55UtAfe+ByIZ7rjEwcIPb0hK9iwT+rNUja/t+GbUjJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=iJKpS8QZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="iJKpS8QZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FenrRuMjoD1fzpHhEp4G/SV36LAq2Yswr1QRpeMEN3Y=; b=iJKpS8QZdrVSuhhAWsxyoOSv2H
	dpd9j6wuWh1EJ1fvDmVTmJxh+qCNjfq/H8IQWjEGJRpAOteMTGlElS0C5O4RuVGxaQ1GhYVaipY7C
	CYPdwbMstQkarnhAXfNmb/Oeo6ci1z8zASTrCICjyRxH4gxQ21f374ZpWclDmVNyOfUIZuVfi2ygd
	+Sn9bNyT4EBUJloTN+pWyG4FDwD4KPfyaJBgdgVPIz4dnnt/pVrvoU/wVFQTSsaQA6dKXb6FE3gM3
	6R58GtFPZIpiND7yWgGLoNUFBgQGtuc3BFp9xrVxSZgvz19uc2PhGKk5TSxH6ioY71xsdxniYOQhi
	SuQ7lcrA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xHmpJ-00000006ERu-0pbg;
	Fri, 16 Oct 2026 18:38:46 +0000
Date: Fri, 16 Oct 2026 19:38:45 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: brauner@kernel.org, jack@suse.cz, jlayton@kernel.org, cel@kernel.org,
	neil@brown.name, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vfs: keep the mount pinned while waiting for a parent
 delegation break
Message-ID: <20261016183845.GH989762@ZenIV>
References: <20261016093421.90725-1-zhaogongyi@bytedance.com>
 <20261016182927.GG989762@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016182927.GG989762@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 16, 2026 at 07:29:27PM +0100, Al Viro wrote:
> On Fri, Oct 16, 2026 at 05:34:21PM +0800, Zhao Gongyi wrote:
> > filename_mknodat(), filename_mkdirat(), filename_symlinkat() and
> > filename_rmdir() can call break_deleg_wait() on a delegated parent
> > directory after dropping the struct path that pins the mount.
> > try_break_deleg() only takes an inode reference, and an inode reference
> > does not keep the superblock active.
> 
> So why not have it acquire an active superblock reference at the
> same time?  We don't need struct mount reference there - all it
> takes in increment of inode->i_sb->s_active on try_break_deleg()
> side and deactivate_super() on ->i_sb fetched *before* iput()
> of ->di_inode on the break_deleg_wait() side...
> 
> No need to mess with every user of that thing...

I mean, something like

static inline int try_break_deleg(struct inode *inode, unsigned int flags,
                                  struct delegated_inode *di)
{
	int ret;

	ret = break_deleg(inode, flags | LEASE_BREAK_NONBLOCK);
	if (ret == -EWOULDBLOCK && di) {
		di->di_inode = inode;
		ihold(inode);
		// make sure that extra reference we've just
		// grabbed wont outlive the superblock
		atomic_inc(inode->i_sb->s_active);
	}
	return ret;
}

static inline int break_deleg_wait(struct delegated_inode *di)
{
	struct inode *inode = di->di_inode;
	struct super_block *sb = inode->i_sb;
	int ret = break_deleg(inode, 0);
	iput(inode);
	deactivate_super(sb);
	di->di_inode = NULL;
	return ret;
}
