Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C143C4166
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 03:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781581159; cv=none; b=kQgsYhMnzqmt+1FSrIjFmqNqFM2ZMBgUyPhSjCWPtFnnNXMmVN8FTfNRxjN9KvBz0646FFuDr4DbJN/8x/jGoxV0xT5tG0C3/1hZNm/XT6AbNq/U1ikhlYUhQlzUcqMtrHmCuz6i/6YpGVVEaR4gK6mV10ZcGDTgGNmQyqc7M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781581159; c=relaxed/simple;
	bh=NdmJaaT95k/edNIX14vsuGNZZS9mIdS3WzO4V27ubkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HGocrX7Ix4gRWAIkojBQtFDay5eBAn5UTqp698UaI6g6t8XurPrOEZNmpJIT6dOiWBNToolzr3UhAJglXi9/uS+8aJIDlXjUcOAKppXNnN6+9C5yMMaUdMGg4JBghUIH7R6zs6uC8o3+fheEuPRm+RBD4svW1O4B79SbDq4BMuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I7dh4giw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I7dh4giw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 861941F000E9;
	Tue, 16 Jun 2026 03:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781581158;
	bh=IcsyuHjhRls5YZFdO/v9OywQHVefNRaJXQbt4Wrvs9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I7dh4giwaOOCLS2GMDro/3DwiOruX2TV/9NGWkHzsefOX1tZ8wKAkle4CRBYAffj8
	 9g6PLLxAMI+zfbKlygnt0kJngX9pcGAoP2EKP4N9HTnQOUH0OlyyYKrSW5cIbmCM7y
	 4mTUO7iC7DgJj2uQ4mO8Fx8GkM9FmWIwEjQRwaKY=
Date: Tue, 16 Jun 2026 09:08:13 +0530
From: Greg KH <gregkh@linuxfoundation.org>
To: Ahmed Elaidy <elaidya225@gmail.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org,
	ljs@kernel.org, avagin@gmail.com
Subject: Re: [PATCH 6.18.y v4 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
Message-ID: <2026061632-papaya-handwoven-d010@gregkh>
References: <20260515124218.151966-2-elaidya225@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515124218.151966-2-elaidya225@gmail.com>

On Fri, May 15, 2026 at 03:42:10PM +0300, Ahmed Elaidy wrote:
> This series backports the sticky VMA flags infrastructure and the
> VM_SOFTDIRTY-on-merge fix to linux-6.18.y.
> 
> Motivation: CRIU incremental dump/restore can hit a missing-parent-pagemap
> failure when VM_SOFTDIRTY is lost during VMA merge operations.

Ok, but what does that actually mean?  A crash?  Normal user
triggerable or something else?

> Patch 8 is the target fix:
>   mm: propagate VM_SOFTDIRTY on merge
> 
> The preceding patches provide required dependencies on 6.18.y and are included
> to preserve upstream behavior, as requested by maintainers for stable backports.
> 
> Changes since v3:
>   - Reverted to sending the full 9-patch series as requested by Greg KH and Lorenzo.
>   - Updated Lorenzo's email to ljs@kernel.org across all patches.
>   - Added Cc: stable@vger.kernel.org # 6.18.x to all patches.
>   - Added Fixes tag for soft-dirty merging in Patch 8.

We need acks from the maintainers here before we can take these...

thanks,

greg k-h
