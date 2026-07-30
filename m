Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA970314D05;
	Thu, 30 Jul 2026 07:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395371; cv=none; b=ret4P8ucCrOFpS8ZZTJ2swGJyzTOSqkv6k1Ol9O7Aq6W4aiMzmKsecFJsFQwZqTCkeb7TDAGl/+P4zQ8I7XAsO0GZyeF8qTrZ23v8QhUmnnAcc99XTeQru3ikf7EA//jvqiCvLv3goPLCrC+W1aPdBPcygzaRrwWfuuAwKufHKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395371; c=relaxed/simple;
	bh=HZklfwxrgZk8+7rCpfBUN0ZhsdYAKDE05bNNO/mGoFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsZdNp3dcpxjExXtSf0MdVcm5rhfnedTwZFyBTWZX+Y5Uk4qUCAGWoSnPB9+LZ3pHTS6BXArb4FaH/t8x91CEgrKM8osNRUmhFvWvcJqAYBsPqAV+gfTDCQ+VUnKpjfgcdZX6JlVfi6ISdQ6OhDJJ7z5A5jf6v38zPtIP/JH+34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uIijY1aF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uIijY1aF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4EF1F000E9;
	Thu, 30 Jul 2026 07:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785395369;
	bh=WDoiElx8LglTt524YUit6tAlFtyEb5QtniW6Y8tnt8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uIijY1aF63dBCOx7vAvLNDb5J9XQvQxWNSZjWCErIZEOBhLJHMxLT3b86gWGje9Ls
	 eBOgPWqz2Vvbhte0erAziNzve2GOr0fXL+LFVGNMpfKa86d09lwvByxyrwQxe82gCR
	 LJFIB4KW9tzSFP0krg6BvoY8mDdtkpIiVzhBL1NI=
Date: Thu, 30 Jul 2026 09:08:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: xu.yang_2@nxp.com, Frank.Li@nxp.com, panjunzhong@linux.spacemit.com,
	kees@kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Fix Null Pointer Dereference in
 uvcg_video_init()
Message-ID: <2026073054-shaky-radar-da75@gregkh>
References: <20260730070207.16065-1-jeffinphilip14@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730070207.16065-1-jeffinphilip14@gmail.com>

On Thu, Jul 30, 2026 at 12:32:07PM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: 7ea95b110811fa8e41f5960c278bcfc80b8b21c1 (usb: gadget: uvc: rename functions to avoid conflicts with host uvc)

Can you please shorten the sha1, like the documentation should have
mentioned?  And did checkpatch.pl catch this?

thanks,

greg k-h
