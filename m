Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AA615A86D;
	Tue,  2 Jun 2026 01:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780364129; cv=none; b=dovj1CZxj6D+WxMXq0SJ2AmfGE+7RtS3Fo3lnNepk3diW+Z2Zhl/FBJ89/ZblJD0Aky0dWxyYAAFDLWdNqYJnxnZSwZjqqgljBeebHDpuUM59e0j9zdYUZPLLPej/JbHUgW0yR1qyFVH6U1EALFEgID0878W++NfthGHjt1E4dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780364129; c=relaxed/simple;
	bh=RdA6LE86r8jsoZYpCHow1eeJqRpXht1bmL55sUXORoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAMpnJ4ymmPT0KLu6y4yJ65Mbn8iTZRQWPFTA/627EQirHVqM7uvWncd8i1BNTVOf92p240/CvbFEZJp8W4OBFPgn9bBpxwMuB7ulhQ0iXeFvaK7lIrTvKjlk5JL6Uzz+gBPd5Woi6w4bevlTd1IzioSXGNrEqGGQvN5m4AoAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Izo3uQd/; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Izo3uQd/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=W2Gktytyiai/yXIIzLju2+22GzznnF7rncF3FpGPaw8=; b=Izo3uQd/vsXLT81MerBX6rLA1W
	G8+Lg65UmroVHjhjOdqgJn5aHlE+0p5IuG/YFL+kn2sY1naz20p9uOb4e3R9o+7GxrdhTu+w9eRZv
	eHwkfKOFinHNdOgMPrKzyj12GyeouLKaF6UfUszbJ3ykWXu1UUeY4ytWAjnEM52RfeXCAnEg0y1sY
	go/b+TOTzTNWrG5Pc5yNMKyxoUYZwKXkpgNMRVaIvXe+mZGfryHC2bO6XuX8Qs7uBO1abmHtyqtES
	AMXqS/dlC9JqPoidBWGeIRXhzQkn1fSDJNZRYRTtOWpcg7WXMBBJ6hKiW7hVfIinYXfXt6tzCfL15
	IjsWNOmg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wUE2Q-00000005IRS-2fHm;
	Tue, 02 Jun 2026 01:35:26 +0000
Date: Tue, 2 Jun 2026 02:35:26 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Denis Arefev <arefev@swemel.ru>
Cc: linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-ID: <20260602013526.GO2636677@ZenIV>
References: <20260521072857.5078-1-arefev@swemel.ru>
 <20260602011907.GM2636677@ZenIV>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602011907.GM2636677@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jun 02, 2026 at 02:19:07AM +0100, Al Viro wrote:
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
> What?  init_pseudo() sets SB_NOUSER; what are you talking about?

... which doesn't suffice, apparently, since now bdev has become
mountable, along with the rest of pseudo-fs.  *THAT* is a bug.

> And assuming you've somehow managed to mount the sucker, which
> ->i_op method had been accessed?

->lookup(), apparently.  Which means that 'directory' should've been
rejected by d_can_lookup(), no matter which filesystem it's been
from.  Which might or might not be a bug in its own right.

In any case, NAK on that patch - it's papering over the real bug that
has nothing to do with block layer.

mount -t bdev none /mnt

must fail, same as for pipefs, sockfs, etc.  It doesn't.

fsdevel Cc'd, as it should've been from the very beginning.
