Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC40472F63
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872726; cv=none; b=elyOW2UJRfsfIw7Mpwh9/p8w46LkiO9Ngxm3Mdq4mV0w3/ijNKFQfceNa0Yp/dT8XrgMFi1Q7Duto8zJG8yRGsFlzNikW4SzkTTSG4cDKUh9U5g4CZIN561ZhdqhJqFywk3/8VZIvMN5bIjdRzlrdT5iJPnQAw+PYF71ZsjynSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872726; c=relaxed/simple;
	bh=tdpx2ZIjUIQ052VmpzkRQH3IGdLgU/eWNPlZmRH9DXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3RGR1Vuxx/Z52rYhO3BnWZ1EGEuJvfwlucA3Km818NMp6LdtBCzmnw74840+6TKS/jv06mLmHK+j/uQ09lcxXh04xdxqnCvq1ghn9erpMLkj4Io5WVSibKcghQI426aIh8oTfqdPLbLTOZttcsy4l3GF2/g+KRmtS//nSmqP/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHeyCyjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHeyCyjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8CB1F000FF;
	Tue, 13 Oct 2026 06:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791872722;
	bh=/4s6DjAXr+EzO659uZ3MWnaixmJ68f1Y4pGdwciGruI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uHeyCyjWI09MBx0LdfDn0Es4b/bTf/X4ZRmm3YLBei5ZcmuLCeKXIbKafal24tNuY
	 +a+I8nvXjh7q/BI0vW19/nzZFH112JqakpDPiQbo12XredoQjuyu9KUOqVWYAiGf8/
	 H4/cjtYxZd+8LyS8oIubv8XOFdkcVCiSA+HqfrJo=
Date: Tue, 13 Oct 2026 08:25:27 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] io_uring/waitid: fix KCSAN warning on
 io_waitid->head" failed to apply to 6.12-stable tree
Message-ID: <2026101320-given-crispness-72c3@gregkh>
References: <2026093018-boneless-remorse-ee12@gregkh>
 <6ed8abf0-15d3-4de9-88e2-a44a7a11b32b@kernel.dk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed8abf0-15d3-4de9-88e2-a44a7a11b32b@kernel.dk>

On Mon, Oct 12, 2026 at 03:26:46PM -0600, Jens Axboe wrote:
> On 9/30/26 8:59 AM, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.12-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x b994ace83a2bc7699420f6a4c6b860c8da133159
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093018-boneless-remorse-ee12@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'
> > 
> > Possible dependencies:
> 
> Missing dependency, here's the dep with the commit too.

Thanks now queued up.

greg k-h
