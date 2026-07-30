Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89808386C39;
	Thu, 30 Jul 2026 16:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428367; cv=none; b=UFKYqTHxg5NU3HEGml3dCs0cxM2FVya8Z3WIMYr55dbUyWjSvh4gDx0BvFNGZajQpxokD5wcJeghlt86apsFTQBconwLToQJegLsrVyrZKpPM7MHY85CXfQnUZ3dtFG/8g9qGlGO7WfTIOiJkacJa5vPGNpqNVo4nekZTJvLQiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428367; c=relaxed/simple;
	bh=4VKK6/RhVnvThPaArztBEHWFDsC7QHAVqf2SRWG/svU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfxPG95VnkyNMYbl3qJgTZ96ayxuD6knbCOn8fjeqcZENF/26Y4FcB4aFGwqi33sjrChlMwpbhToURIKMtilnkIc8wi9mD+WyxF6OZGQtlP/wHMD5Raol9mk1bUEou+rG8eo3yjfeQUrvtH+omCnmpIrQuqpeBP/JTlDP76JmP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y0RgJASv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0RgJASv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB85B1F000E9;
	Thu, 30 Jul 2026 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785428366;
	bh=s3unlIab8+/GEnCRr7DOwvj69vbsf+pfb1bJVZC1sUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0RgJASvD/HOHk1YNcMzjah4vYAT5+rlFcyMrqYZmD5JkgcPWhH+EnqaT1aBHCMOx
	 7u88+Wpe11JHlMgOmUWlxuICCsngWStMA52ZFIIwPrzSDFXoV1vw5lYQsl0mP6WQDM
	 TeeIq4K35QvXtHj9AeFkueTBtM1Ee1sH2f02FLFk=
Date: Thu, 30 Jul 2026 16:25:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tty: vt: fix memory leak in vc_allocate()
Message-ID: <2026073028-icing-dallying-9229@gregkh>
References: <20260723070530.117552-1-25181214217@stu.xidian.edu.cn>
 <2026072345-copartner-shrink-9596@gregkh>
 <88f9ac58-8079-415d-902c-3b9455a9d17c@stu.xidian.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88f9ac58-8079-415d-902c-3b9455a9d17c@stu.xidian.edu.cn>

On Thu, Jul 23, 2026 at 06:45:23PM +0800, Mingyu Wang wrote:
> 
> > How was this tested?  And how can this ever fail given this happens at
> > early boot time, right?
> > 
> 
> Hi Greg,
> 
> Thank you for the review.
> 
> Regarding how it can fail:
> While vc_allocate() is indeed heavily used during early boot, it is also
> reachable at runtime when dynamically allocating new virtual consoles (e.g.,
> via the VT_ACTIVATE ioctl). The failure we observed happened at runtime
> because our fuzzing environment enables kernel fault injection (failslab).
> The fuzzer intentionally forced the kzalloc() for the screen buffer to fail,
> which exposed this specific error-handling path.
> 
> Regarding testing:
> This issue was discovered using DevGen (our automated virtual device
> modeling fuzzer on QEMU). While we do not have a standalone C reproducer to
> run a dynamic runtime test, the fix was derived directly from dynamic
> execution evidence: we cross-analyzed the precise kmemleak backtraces and
> the fuzzer's execution logs.

You need to document the tools you use as per our documentation.  Please
do so when you resend this.

thanks,

gre gk-h
