Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1A7313E1B;
	Tue,  2 Jun 2026 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780363286; cv=none; b=mS8/uHdJZt8ZNd1d8V9REK/HXeDrnW9s7/TNBAQGQASWVcJgtJBIBJ7x8ivIhwhevkgx+ZYQ7N9nklurgMBLYiYL6iy7J/OiSCYc1vtCz4rxDiOfMScgLE8x2qQkLEKW72RtyI6TyP/SgZ3J7EXHem1prRn4fWSEe0+eP6Q9kd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780363286; c=relaxed/simple;
	bh=ylX5weLmyDJ13Z3LUmWFCW6OSYKIcOo9C108v4n7fcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kli43OIZrdPLoE26XLDvl+iuVad5pDCyfASzIaYfOkso9VqpA1wsawqE3jijkWlyqJLJ2zU4mgHFq7jy59K62AP9Kd2s72VdtdSP0DciF/Hs8fmDrbWIoHmLDOKPF29kS1CMdJXSwubP4ilYNy1vnqee3Pbn/6NatI0W8G5HXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=tIBO4Ca9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="tIBO4Ca9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VNX9dbRUraIAwLZ8K015p84hZOjX17udUILx/Eu6IMU=; b=tIBO4Ca9uM1CRsze1IKkZJNuWy
	kGARR3/zEXFyweN/4ud7qFbYCcXmb9Tof/u8o5R8bJGyy5mMwgdMRtlzOOh6NdzPjSsNKnIFaqkEs
	QFvF5/BtYogdL5ojCjY+tA1yljZ75nM5kbTVNNPX4GoAOsDFLG6NGTcF0xvT4Ig6tj2dGOzaj9dOa
	PbT9xGsVRHzLipWuNzPZf10wH2A/L6IdqbBNu5NGAMXkg9JbPF0yBafqPPU0mupND3DZ8D0sXDGyN
	11i91rgkj0hSRTDOlLRZHxEQsxWaTa2ie4dwoFrMn5+yEdk46pQvvcswa0B3x7E/te3uD8Qmx+w5H
	txmdIoug==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUDop-00000005F4u-0dVo;
	Tue, 02 Jun 2026 01:21:23 +0000
Date: Tue, 2 Jun 2026 02:21:23 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Denis Arefev <arefev@swemel.ru>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-ID: <20260602012123.GN2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <ahPnFlvUqq0JC2vy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahPnFlvUqq0JC2vy@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 24, 2026 at 11:07:18PM -0700, Christoph Hellwig wrote:
> On Thu, May 21, 2026 at 10:28:56AM +0300, Denis Arefev wrote:
> > The bdev pseudo-filesystem is an internal kernel filesystem with which
> > userspace should not interfere. Unregister it so that userspace cannot
> > even attempt to mount it.
> > 
> > This fixes a bug [1] that occurs when attempting to access files,
> > because the system call move_mount() uses pointers declared in the
> > inode_operations structure, which for the bdev pseudo-filesystem
> > are always equal to 0. `inode->i_op = &empty_iops;`
> 
> Looks good:

It really, really does not.  I would like to see the reproducer - analysis
looks like random noise out of LLM.

I've no real problem with removing that register_filesystem(), but if
it *does* fix some reproducer, I really want to see details.
