Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8DB448B95
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662782; cv=none; b=eFtAffPd1bBLVvNqClEII61FnHDeAJ+8N2Ct7MnBlerLqXkbcuIo5t0hZhsDij4FDpGWiRIvfIStKOja6ImNfBIfjHR1PeV8OQ3y3p2UMqaz45IMOUQPK7B0lnFDPgDUnW3yJC8IwPmuGZyX8L/i6lBQ9qbTUAWiiTSCCgchzi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662782; c=relaxed/simple;
	bh=3PXNk7/0yo0PbqlcV9OaQ/HaxIzDmTIlqO4xhE6tNwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2/AsHbEx8BrIHbuieDZAzXd2CF1jOmBc/qG7bIzDOfwL2WhPIkCUR34LiH+l8Xh5ZgNVYxMn6nJlNoZejTwEWAE/enH3O+JpgvePFFM2yImadFUC/SmuGwHSuDXKGIL+h/7V8ET+RTVJvBOm/60UE8oNvUcyoooW0dOM4CUwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r884KMM1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r884KMM1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7C01F00A3A;
	Tue, 25 Aug 2026 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787662780;
	bh=670j/YhYxqOwH1WhKJwGKjkMe9KAa1lmB157txcCJ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=r884KMM1VjPF5K4cQ0HUIJTjrnU6CEdxuDaHnz7SmovM6aiR1AUAW4q7IqS8Ao9nM
	 VahHkN7LZiOvxpRCvYqEbL8Eoa8uQOuhMbOZMtCD7njaDHQ7E9pPbSrHe0shJZG0Fx
	 zRdfVRB196MpBXq5RX8qnzFtM/RZswBiiiL1nk3Y=
Date: Tue, 25 Aug 2026 14:59:34 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org, peterz@infradead.org
Subject: Re: [patch 7.1.y 0/6] futex: Stable backports for recent issues
Message-ID: <2026082518-curable-blinker-3dc1@gregkh>
References: <2026082446-lumpish-subdivide-9766@gregkh>
 <20260825091624.748852250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825091624.748852250@kernel.org>

On Tue, Aug 25, 2026 at 02:48:22PM +0200, Thomas Gleixner wrote:
> Greg!
> 
> The following series is the aggregate of the futex fixes which hit Linus
> tree over the weekend:
> 
> d8aa5dd97944 ("futex: Fix might_sleep() warning in futex_pivot_pending()")
> bde023808364 ("futex: Fix race on the initial mm->futex.phash.ref allocation")
> c5f0bc9fd1ce ("futex/pi: Plug private futex exec() race")
> f9ece060cc43 ("futex: Sanitize and document task_struct::futex::state transitions")
> 59b3732f95dd ("futex/pi: Reject cross-mm private futex owners")
> 8e7ff730dd96 ("futex: Fix race in futex_pivot_pending() during private hash resize")
 

All now queued up, also the 6.18.y versions as well, thanks for these!

greg k-h
