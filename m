Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAD039935D;
	Thu, 25 Jun 2026 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385533; cv=none; b=JFDoAA+toxaW0aH8sFk2wZ6mBwT8w2vPasGXbkXo9ZUIdufojMC4Xxg+SQILKoZDolmpC+V7JnKXjcOTXj0ygqv+QFLQaanZ9RVD+FXXxQClG5Es6Ca9DA34e+nFzZlxcATtDpWXw85B0Ubx1Qh94XORbSfZFzMrm4fAsU1nvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385533; c=relaxed/simple;
	bh=uxW6EkWjVTN1sa5ltf9VGrhY0/55bCbObofQQviLjvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KEZEld0X8efNAESkCCvzVtNpVEtOzztj7OLq0kTXnv8WscgxestXHj9NDEZr9rqmP23nzig4UkPiwsLryyhCUlNy3cHLYVJYREDgkGCPXoGWDvVoBO3DlCGtoNADCVIxgQxZkRCf6bYFWc9+xFpiTyYvpqcv1SdLM0PxjSiPqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKpMltyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKpMltyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B681F000E9;
	Thu, 25 Jun 2026 11:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782385531;
	bh=tUkARHxqgFiPuume8xpZyaeJ+B5pIVmsfh78GoOA1qE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eKpMltyxDNd3u63zTABfLLn42J1MUY4QDC+oCGPrbQh00CuSFRZE+B8xSzuCBYUi4
	 757hv8kjIlASJaGg0Nm/3U7/HlK51gA99GJAJi8SA+VzVZSyRztFanVZCuR8qzC+Bi
	 0Z7Ub5s+KhhMh6HvzMIlU4Nbkfw1qytMCxALM3W0=
Date: Thu, 25 Jun 2026 12:04:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bernard Pidoux <bernard.f6bvp@gmail.com>
Cc: kuba@kernel.org, stable@vger.kernel.org, linux-hams@vger.kernel.org
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier
 (merged out-of-tree in linux-netdev/mod-orphan)
Message-ID: <2026062543-think-rocker-6e19@gregkh>
References: <CAFAa3YBfk2UOjAktrLq3_9+563m6UZuKv9XdBjfp2aB1twV1HQ@mail.gmail.com>
 <2026061625-starless-mascot-691a@gregkh>
 <CAFAa3YBciYSJxDT-SH=4oppyBS3hWUSEwJP_86EgUriJfYkjLw@mail.gmail.com>
 <2026062048-posted-scarf-dcf2@gregkh>
 <CAFAa3YAEDsnqcN6UqUE-4X+y0t7RPmNtwdb0LxExryZmAKU9pw@mail.gmail.com>
 <2026062051-doorframe-crayon-d390@gregkh>
 <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFAa3YCJXV9uW==2776dbfNFH4PhBPUYnTxDJ2xs7kn0b=4UTA@mail.gmail.com>

On Sat, Jun 20, 2026 at 02:42:17PM +0200, Bernard Pidoux wrote:
> Hi Greg,
> 
> Thanks, much appreciated.
> 
> Short answer: yes, the same series applies to 6.18.y, and the same bugs
> exist in the older trees too -- but only 7.0.y and 6.18.y take the series
> as-is. ROSE was removed in 7.1, so every stable line up to and including
> 7.0.y still carries this code and is affected.
> 
> I just test-applied this exact mbox with "git am" against the current
> ROSE files of each tree:
> 
> v7.0.13 : clean, 15/15 (what I sent you)
> linux-6.18.y : clean, 15/15, no conflicts -- the teardown code is
> identical to 7.0.13

Great, I've applied these to both now.

> linux-6.12.y : applies up to patch 3, then conflicts in
> rose_loopback.c (the loopback/timer code predates one
> of the refactors the series builds on)
> linux-6.6.y / 6.1.y / 5.15.y : same, conflict at the same patch
> 
> So for 6.18.y I can send an identical batch right away. For 6.12.y and
> the older LTS lines the fixes are still needed, but they need a rebased
> backport rather than a straight cherry-pick; I'm happy to prepare those
> per-tree once the format is settled.
> 
> My suggestion, matching what you said: let's land this 7.0.y batch first
> to work out the workflow. As soon as it's in I'll send the (identical)
> 6.18.y batch, and then the rebased older-tree batches one line at a time.
> Whatever order is easiest on your side works for me.

What you sent was fine, no problems, if that works for you, it's fine
for me.

thanks,

greg k-h
