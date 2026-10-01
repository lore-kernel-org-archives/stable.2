Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E95331209;
	Thu,  1 Oct 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858235; cv=none; b=ivoRlKsel+woq4DQW30mL9VHXE+pu7VpFsJl0sRz44jczGPLthv8JiKr8pxsX/3mYTCtgHJwKuBjixlg7BKsYz2x4Ke+3DYnh05t1OL0580gNE0m5YY2V8XaleWnCCscO1p/IIzFHT8jwfMoviQi/sH8X396sglGBesECZxbxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858235; c=relaxed/simple;
	bh=SHgG9AlGVoT4RssTSlUv+0sWZvFZ1EeKzzALoXpQRsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgrLr62Kbt64ECfuXkhNqsnF4Qzf414ZvuHoTMTiti8LQoa5NlPvT6aYn/6hSJgHl1/04gDgruSPl3jaedrNNW8pFHS4pH5lhKrPOlx8LIX8lY4N+6KvNQn2yd/NBVqokVMfEVqlFheTTpX/5hgucdvxU6ArFF2oG3SRPm7VLs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ylACmFv5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ylACmFv5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411971F000FF;
	Thu,  1 Oct 2026 12:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790858233;
	bh=GDk1vfh9PWrTqCO35nMpon00YhfDGRAMgJ+e73k2iug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ylACmFv5UKLw8B2p298KtfFzKNTZ0+a10g2BYAZCyGyEwdT4cvVwMDSYxOBy8RTm4
	 UJsfcPKiLc8oGWS+6P5w0graYD120/f/FhlGbSStGEESjT+iqNjSMIYQLJ8HFNDI95
	 2UYV4g5Hrt7zz/lMMBtEUMVUNSMR+TMEVZHLkAg0=
Date: Thu, 1 Oct 2026 14:37:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hui Peng <benquike@gmail.com>
Cc: arve@android.com, tkjos@android.com, maco@android.com,
	brauner@kernel.org, cmllamas@google.com, maco@google.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] binder: fix premature fd_install() and buffer
 leak on read -EFAULT
Message-ID: <2026100150-briar-stumbling-b193@gregkh>
References: <20260919213650.3316812-1-benquike@gmail.com>
 <20260924100019.3389555-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924100019.3389555-1-benquike@gmail.com>

On Thu, Sep 24, 2026 at 10:00:17AM +0000, Hui Peng wrote:
> This series fixes two error-handling issues in binder_thread_read():
> 
> 1. Defer fd_install() until after put_user() and copy_to_user() succeed,
>    preventing file descriptors from being prematurely installed into the
>    recipient process's file descriptor table when userspace copy fails.
> 2. Call binder_free_buf() on -EFAULT error paths in binder_thread_read() so
>    the transaction buffer and associated node/ref references are freed.
> 
> Changes in v2:
> - Split into a 2-patch series with separate single-purpose commits as
>   requested by Greg Kroah-Hartman and Carlos Llamas.
> - Added Reviewed-by tag from Carlos Llamas.
> 
> Hui Peng (2):
>   binder: defer fd_install() until after copy_to_user() in binder_thread_read()
>   binder: free transaction buffer via binder_free_buf() on read -EFAULT
> 
>  drivers/android/binder.c | 30 +++++++++++++++++++++++-------
>  1 file changed, 23 insertions(+), 7 deletions(-)
> 

Why is this in the middle of the previous set of patches?

And is this still needed?

confused,

greg k-h
