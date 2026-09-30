Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59993C8728
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770193; cv=none; b=Ltq73XgZ5Wt585SMOusqlNIe8fwDr6s3+e3vHUVgjKddSnCo555z8yb/mecWjIkPf6TtiyK8KAx2XXF/UjTx5FTZgnBQzKPWCD3XKicxIAPh4HeOhkRdev3J6KdpX0ykil02EtTFqEZFZTlJrC8mjrsALPrqfVwArQpqu8h9L+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770193; c=relaxed/simple;
	bh=vOAxurFJOhyy5hPm2tTqeL/Tg7dmEjb61QCq40EF6sQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjdQJo9OV0E3oFMVhCJPz/9Elj8ReYnpdEjR5YcSgC6tjHSA6nXZpN8OF/Fu42czbKl5HRg3BKnNRfxytOoOaSfJ6rDd8H1YWfiwJ2PrjZfpTDXpJVf8nCVlpIwKbdCoa9vujlf04pe4Q9kZ4qutWhGW1jUWL88mIKUd6Ij9Hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w05IdtV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w05IdtV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7C71F000FF;
	Wed, 30 Sep 2026 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790770192;
	bh=3uquKuBqXCRLhMJFzZV4E9LRHvABkoHEmBpKGeVhL7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=w05IdtV8JY2TEUDPp232Xys+lfDuKXJWqQCnSlyTJ3TU5LSf0fm3kbc+n/DW/Zuo8
	 61r2GI+7oVNE4hSzFoFDjQwZIK1nIYWC+UR/qTK2trVFweCwr5pr/aSQZCcoGT+Kag
	 5zac5dkx4CRg79XZ3s/HU7igBnQUnPXBfas81kuM=
Date: Wed, 30 Sep 2026 14:09:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: kayracizmeci@gmail.com, mingo@kernel.org, peterz@infradead.org,
	stable@kernel.org, yu.c.chen@intel.com, zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched/cache: Keep nr_pref_llc_running in
 the runnable domain," failed to apply to 7.2-stable tree
Message-ID: <2026093010-repave-debit-afee@gregkh>
References: <2026092932-unmanaged-nectar-23d8@gregkh>
 <f74faef913c4d49cdede9c43581e979317c00829.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f74faef913c4d49cdede9c43581e979317c00829.camel@linux.intel.com>

On Tue, Sep 29, 2026 at 03:12:01PM -0700, Tim Chen wrote:
> On Tue, 2026-09-29 at 13:43 +0200, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.2-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 0d6526f82c3cdefcca47f73f5fc08dc6f335eac6
> 
> This patch seems to apply cleanly on latest 7.2.8:
> commit 9a66fdc0d7fd55f54235524a73435af99051e46f (tag: v7.2.8, stable/linux-7.2.y)
> 
> [tim@b04f130c83f2 linux]$ git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
> >From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
>  * branch                        linux-7.2.y -> FETCH_HEAD
> [tim@b04f130c83f2 linux]$ git checkout FETCH_HEAD
> HEAD is now at 9a66fdc0d7fd5 Linux 7.2.8
> [tim@b04f130c83f2 linux]$ git cherry-pick -x 0d6526f82c3cdefcca47f73f5fc08dc6f335eac6
> Auto-merging kernel/sched/fair.c
> [detached HEAD 9d0e82dcbce41] sched/cache: Keep nr_pref_llc_running in the runnable domain, to fix LLC mis-scheduling bug
>  Date: Mon Sep 21 17:37:22 2026 -0700
>  1 file changed, 58 insertions(+), 5 deletions(-)
> 

Does not apply now, perhaps due to other patches in the queue?

Again, can you send a series?

thanks,

greg k-h
