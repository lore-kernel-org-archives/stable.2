Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B933B3884;
	Sun, 27 Sep 2026 16:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790526889; cv=none; b=GGAekZriQKLCpH5K+Eqej0AEdVnQrmOzUqcerlaZkVH4XmCuQKJdc43cr3nwAD3FD2PDE37/Ar5eGfa0gM+yW0sQLfkIVUp8EtZotUP41h4esKkRgzBlWoPF0dHM4LjD3a0C/keQ7zC2HstHiHIlorgJVtOoWthHNFatmBR/jig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790526889; c=relaxed/simple;
	bh=EzanT5WuC5b1cQCPU+KgB8dZunKNYgr9kBynhOZ6FfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sphWLLAymifWLeupxr0NZBP+bNAfaMzpRAZSjlDPHiKPRkHy3p5eT/FPoiyjG3iFHtsHLe/SG4+4MbIGMuu9Ex7myZq8Q46jE0ppjOPwWQLop3Ml8QiG4Q5mlVY1ZlV0qsDPLqXq0jvr/QHmkHBOqRP1Axe8bLeNrfmv5Y0E1rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BXGWVGjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BXGWVGjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0811F000FF;
	Sun, 27 Sep 2026 16:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790526888;
	bh=SOlu8u4sOWw1bl8aquiV+FQdZDJl1sJTiY0bcwBI7vA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BXGWVGjjOADCch8vlIv9WKIC8sIUSwRgP5J6C7cH3PNB6Q3+2eewuksxcWqmNamwT
	 zKgGbnGh7F5brrULap3pwGdJW/5nVOCnlJPm4+3LZx3+9voKVTnX4WM13L5ezdy3SU
	 qbWJre9M+DJ2O+cq+hXI6D+Jys8nVZn6V3W8YbQ4=
Date: Sun, 27 Sep 2026 18:34:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] debugfs: fix UAF and double-free in debugfs_str
 read/write
Message-ID: <2026092726-posh-handyman-43a0@gregkh>
References: <2026092647-ebony-unlatch-d3d0@gregkh>
 <20260926134726.1063068-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926134726.1063068-1-qwe.aldo@gmail.com>

On Sat, Sep 26, 2026 at 10:47:26AM -0300, Aldo Ariel Panzardo wrote:
> On Sat, Sep 26, 2026 at 08:53:06AM +0200, Greg Kroah-Hartman wrote:
> > Did you forget an Assisted-by: tag here?
> 
> Yes, apologies.  Both patches now carry:
> 
>   Assisted-by: sashiko.dev <sashiko-bot@kernel.org>

No LLM was used to generate the patch?

> > And how was this found and tested?
> 
> sashiko.dev flagged that the write path uses rcu_assign_pointer() /
> synchronize_rcu() / kfree() but the read path dereferences the same
> pointer without rcu_read_lock().  I then manually reviewed the write
> path and found the second issue: no mutual exclusion between concurrent
> writers, leading to a double-free of `old`.
> 
> Tested on QEMU/KVM with CONFIG_KASAN=y.  The double-free in the write
> path reproduces immediately (~3900 KASAN reports in a single run with 8
> concurrent writers):
> 
>   BUG: KASAN: double-free in debugfs_write_file_str+0x194/0x200
> 
> Full splat is included in patch 2/2.
> 
> The read-path UAF has a narrower race window (just a couple of
> instructions between pointer load and strlen()) and did not trigger in
> KASAN testing, but it is structurally obvious: the write path calls
> synchronize_rcu() + kfree(old) and the read path does not hold
> rcu_read_lock().
> 
> > And what kernel was tested, debugfs strings were changed a bunch in 7.1,
> > what bug report are you working off of here?
> 
> Verified against torvalds/linux master at v7.3-rc4 (commit
> 6812ce4e4379, 2026-09-26).  Both bugs are present in the current code
> at debugfs_read_file_str() and debugfs_write_file_str() in
> fs/debugfs/file.c.
> 
> This is not from a bug report.  It was found by sashiko.dev reviewing
> an adjacent patch and I verified it independently.

Again, no LLM for all of this?

I'd like to see the userspace test scripts for this...

thanks,

greg k-h
