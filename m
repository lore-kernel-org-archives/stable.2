Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4AD3ED10F;
	Thu, 23 Jul 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784792605; cv=none; b=VSa4bwvvhHdCxq/Uwb7xjDwmxcaG0REejSI+oJbML3qoSLMeX1V2iyJuKFiOg9qK4yxM31fB6Ygq07FyjRkEKDL0awcETBRecIQMnqOamvZJJmZa2P28dHnLI3Mju1i5dIlKAVDj3S3isibnkCH67zdGR4ushtc1+Q064UO6BtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784792605; c=relaxed/simple;
	bh=M9I3HlpVFD2CgmKtasZLrxsrUEQOKFvEw2pxJS/2+zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEGA4t/7uVsix7X2507nGYt8IJDgNF+Zg+BICiH4IsZhTuoQB397HbKLbCjIZN0616WIEtOb2gPt0iSGbmXDpGcWZwF4qAxQ7+zbir/X/21bFyuGEepi2GMfEC2qEuUfDYsNQjiJIvwcz0gNxv1RKcTnQVoNJhHIY3y2/ldUyP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hHFIM5GN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHFIM5GN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEC01F00A3A;
	Thu, 23 Jul 2026 07:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784792602;
	bh=7SJjISG7YIR2h4oT4Z2t2GkA5hwczQ6X1qd04H9YniM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hHFIM5GN2jBeSzS4CaPPPPE1qi0hAMnAznIn7NR57kztWx3J2q0TwXG0acY80bxa+
	 1zPReOvfL6Ibpi6I5v618K0xeU4rqkI1Qnf1VTcoGz/iqIY4mRfDwgAv9I673ffo1p
	 HaNVsdBQC5Xm5/mdlU2gSZxKXRjT16EiY3cCkiTI=
Date: Thu, 23 Jul 2026 09:43:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <2026072336-stout-tartar-f586@gregkh>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
 <amG2jCgWugrVroyZ@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amG2jCgWugrVroyZ@google.com>

On Thu, Jul 23, 2026 at 03:39:15PM +0900, Sergey Senozhatsky wrote:
> On (26/07/23 15:36), Sergey Senozhatsky wrote:
> > > Sasha, Greg,
> > > 
> > > this is the backport to 5.15 for the above CVE.  The fix was relatively
> > > simple upstream but only due to years of refactoring and cleaning up
> > > of the code; fixing from scratch is not really feasible so start by
> > > applying the patches that are needed.
> > > 
> > > Please apply this instead of v1, due to a missing line in the last
> > > patch.  Sorry about that.
> > 
> > Sorry for the noise, has this series stuck?
> 
> Sorry, forgot to set proper In-Reply-To [1]
> 
> https://lore.kernel.org/stable/20260626174620.1819772-1-pbonzini@redhat.com/
> 

It needs backports for newer kernels first, right?  These seem to have
gotten stuck somewhere, they are gone from our review queues and so need
to be fixed up based on the review and resent if anyone wants them
applied.

thanks,

greg k-h
