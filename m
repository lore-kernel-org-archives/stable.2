Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC5F58B6CD;
	Thu, 17 Sep 2026 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789656798; cv=none; b=Ys8GXOEG5/nddRDncKHOQC5BTn7Ytvf/jpGG6rDgLJC+sEaL32vUUHRUmkXM/u27b9IFqA1KtG3jdf/vyIfxwLPRIuMPQaO6fa5gs/gb8fESfeqU4OiQm3eEA+BKWnyMOFWNV/DoP0Z3O/HeOJgVJkwCTTT2h2F+o8nd/5YcBoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789656798; c=relaxed/simple;
	bh=d8RdIhOHoZdIBdAQFG8udmKfkOZ+UIY9nPFEEMKFz0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBuj9OqCBdcU1/m2QR8Hsfk9NLcL1JaHPezEQZeH+dT/gYdqUOcGs6gqEfQPbLLK6iSX5Jbff3kpUCGUHzKi73cbrKPI1DN+vbSNYcVjtKg6xwHUc4ps4oxnesezA1H+62vcCv+8eCJweFuRMokNmy2XhMrqBtQwt8oifZycdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SxNbbx+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SxNbbx+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01BA1F000FF;
	Thu, 17 Sep 2026 14:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789656788;
	bh=7Vy5EvpWPgBEeIJ3xF/KQS+oApkjxSsfLwoKOwx0i3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SxNbbx+NRNTcafU63eSB8LK9pkNbX45AzITypEU5CPuoGxdYDWOen0V4I0FDsbzT0
	 Wjngn9zdSD9GB+iVkdWqfLITem9gzEJzAnBOPrgVGGg4fAsoCmuAwl6pCKoMLcYygJ
	 Pz0GCq8RnzEtcxO6En/TJdNdOfvPMCEeLW1SlVLA=
Date: Thu, 17 Sep 2026 15:51:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Adarsh Das <adarshdas950@gmail.com>
Cc: rafael@kernel.org, dakr@kernel.org, driver-core@lists.linux.dev,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
Subject: Re: [PATCH] kobject: fix uevent socket use-after-free on net
 namespace delete
Message-ID: <2026091756-widen-doozy-399c@gregkh>
References: <20260917144206.85836-1-adarshdas950@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917144206.85836-1-adarshdas950@gmail.com>

On Thu, Sep 17, 2026 at 08:12:06PM +0530, Adarsh Das wrote:
> When a network namespace is deleted, we free its uevent socket. But
> sometimes a device in that namespace is still being removed and tries to
> send a uevent through that socket. The socket is already freed, so KASAN
> reports a use-after-free.
> 
> This patch attempts the fix of taking a lock around both the send path
> and the free path, and clear the pointer before freeing so nobody uses
> it after free.
> 
> Reported-by: syzbot <syzbot+4393dfdddf166f2de2b0@syzkaller.appspotmail.com>
> Link: https://syzkaller.appspot.com/bug?extid=4393dfdddf166f2de2b0
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>  lib/kobject_uevent.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Did you forget an Assisted-by: tag?

How was this tested?

thanks,

greg k-h
