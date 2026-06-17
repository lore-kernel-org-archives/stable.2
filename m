Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C837BE93;
	Wed, 17 Jun 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781722976; cv=none; b=p6FAdqgn4pUImPyNMjX4TMcHv80l2wEbjwIGDzJTCGG1/g3qDGC5eHhOQatYnrHoZzjzjtWfkLXKBzkkcyi0OCVDHB5f3Dt+zYdB//9loNF5/y7YM8VX2m2oZuAyg4JvDqiI5RvaLwwH7v4x5H5MPT2NIusu4NWWxun5IzUiWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781722976; c=relaxed/simple;
	bh=/wU5DQXpqHxvOenD2SD6jlh0NX13Wn2zUOQ+LjzMwGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtPMKSOw0v7tI9nzF7jTzAQdbuhBYMrLjimJT8jbe2VBs7N1UkbEBKKei5PK2CfaTtkd47M33eDdXJhbV8P2RAf2eylsNfJuFWEU4m2k0gwyWTaoP5rroTMVw1mJnNsRLwPEaX0n1e4sW6bz7HxpR5GaYX7nVb/6xQ1A7dirkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wIHXv1rS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wIHXv1rS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB821F000E9;
	Wed, 17 Jun 2026 19:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781722975;
	bh=Afx/cykbmlbE5XWCc3SxBMqXdQ9McMu+8eFUZSxPIgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wIHXv1rSOoI6ytGxTSr5Wy/M1JPdod1Mhcn92UzLL5wAp3HDLZDFPg1GGBRzyFY00
	 xm+ovQ75e0E+tSWYEjngJVm6Ivx9+9g3VECamEXbTnIttW/L4+AqgQ7F1wlR3VQbvH
	 adSM/Pyhk9Cl/Z6Prgu/kaGDSgdc4yfAftY+Py1I=
Date: Thu, 18 Jun 2026 00:31:39 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.18.y] io_uring/net: Avoid msghdr on
 op_connect/op_bind async data
Message-ID: <2026061804-slab-agent-a134@gregkh>
References: <20260617175102.2976716-1-krisman@suse.de>
 <2026061727-thirsty-sculptor-1e6f@gregkh>
 <87zf0tdn7r.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zf0tdn7r.fsf@mailhost.krisman.be>

On Wed, Jun 17, 2026 at 02:40:56PM -0400, Gabriel Krisman Bertazi wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > On Wed, Jun 17, 2026 at 01:51:02PM -0400, Gabriel Krisman Bertazi wrote:
> >> [ Upstream commit 3979840cd858f30f43ea9f4e7f7f1f56de82d698 ]
> >> This fixes a memory leak due to the lack of the cleanup hook for the
> >> iovec.  The stable backport differs from upstream by dropping the
> >> io_connect_bpf_populate hunk, which didn't exist at the time and by
> >> fixing the merge conflict due to the introduction of
> >> io_bind_file_create.
> >> 
> >> Both IORING_OP_CONNECT and IORING_OP_BIND reuse the msghdr object just
> >> to store the sockaddr. Beyond allocating a much larger object than
> >> needed, msghdr can also wrap an iovec, which will be recycled
> >> unnecessarily. This uses the sockaddr directly.
> >> 
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> >> Link: https://patch.msgid.link/20260602215327.1885109-2-krisman@suse.de
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
> >> ---
> >>  io_uring/net.c   | 36 ++++++++++++++++++------------------
> >>  io_uring/opdef.c |  4 ++--
> >>  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > This isn't in any release yet?
> 
> It is queued in Linus tree during the current merge window for 7.2

Ah, so it's not even in a released -rc yet.

> >  why just 6.18?
> 
> The backports are slightly different, so they were sent separately. The bug
> exists since 6.12.

I missed seeing a backport for 7.0, shouldn't it also go there?

thanks,

greg k-h
