Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652613;
	b=rTg9N3QCirhRY3lwxkvb0LE6vZynE6e289lhLRtaUJ8RBxy4QkS3hXyNsWhgLa1S3P3K
	 KuSvQmshBV7p7qIMb20cocXc6MEKvsjs7OmIO/a7mN5M51F1gpf33wkhazVaMx/lifzGX
	 He7tamtnsr1Yg+ghH0Auw5ZYYxkSUIe+NUsPhl0k4uO3f0uIcVsPM4sRcNoZJZ8jj846w
	 LItBemZtD0hQHxoS9soQvIs0QXZ/TrzOHt6XdvFKE9/xMCfBmhSpqXU1yV17yCCeHnoA4
	 8/4hGtxGO9A7AFQZyJuHW+wHhdk6W5MtPRYFskIuj4t3K0KeE/EVd5LEGWg8h+fxP+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652613;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ESU6Z+NgB8HdmTbvYFVneDG775N32Gq8eC3TzxGZn94=;
	b=MWj9vXwIaxo+5JMMKjK0ZX9qI6ifdvUnt3pz/8JF0uyzP8DAuRSBJyZOuhRxwbBK2fTE
	 jzdm2+8zP/G2bRHdQ8qVS75KyMpQ5JLqvB2oZ4iVzw1XepVO7DlgV8qQhH5bUOqJTk4rA
	 vNfgNOnIjWiQKYHGUqgtW6LCLJeb44rh4ViwXFnzZYrC27HRHFxsvRV1Fki0nz5jW7Z1j
	 N7cQ+QQCDW1TMXY7qrSVDYJYJAN3/zqp/5TJXlW8yVuiqA7W9BTr8TMbSk8+lwLchQqc6
	 irTeYJtNUmxFDc7Re8ZfgbByWmmwEBRSUctTppvQH/4/u+mTSFidKcKmJlNhQbkTpWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ID6DjFiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1AD606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ID6DjFiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902FF1F000C1;
	Thu, 22 Oct 2026 07:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792652612;
	bh=ESU6Z+NgB8HdmTbvYFVneDG775N32Gq8eC3TzxGZn94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ID6DjFiErNVvo/jq4poZa1Qi+Uv29P8uAHx7zm1vfAvT/IiHfbUhlndwalqqZx4h4
	 NIyihHCsqKW4S74fxVuyRxfFWezZl6SeD2m+/GcFwZT/jUXD7leYO+vj9gEe+owwYn
	 DYvBtPxOhTjKeCq7MT1udJUxwlM4octvHiJrZJR4=
Date: Thu, 22 Oct 2026 09:02:15 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: Please apply commit ebe559609d78 ("fs: get rid of
 __FMODE_NONOTIFY kludge") to v6.12.y
Message-ID: <2026102206-trinity-feminism-b082@gregkh>
References: <7701ab76-4761-4596-b6a5-92c74e03ce5f@roeck-us.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7701ab76-4761-4596-b6a5-92c74e03ce5f@roeck-us.net>

On Wed, Oct 21, 2026 at 02:50:08PM -0700, Guenter Roeck wrote:
> Hi,
> 
> all sparc32 and sparc64 builds in v6.12.y fail as follows.
> 
> Building sparc32:defconfig ... failed
> --------------
> Error log:
> <stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
> kernel/fork.c: In function '__do_sys_clone3':
> kernel/fork.c:3114:2: warning: #warning clone3() entry point is missing, please fix [-Wcpp]
>  3114 | #warning clone3() entry point is missing, please fix
>       |  ^~~~~~~
> In file included from <command-line>:
> fs/fcntl.c: In function 'fcntl_init':
> include/linux/compiler_types.h:543:45: error: call to '__compiletime_assert_325' declared with attribute error: BUILD_BUG_ON failed: 21 - 1 != HWEIGHT32( (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) | __FMODE_EXEC | __FMODE_NONOTIFY)
>   543 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> 
> Bisect points to commit 07ee6057f92a ("fsnotify: opt-in for permission events
> at file open time"). See bisect log below for reference.
> 
> Please apply commit ebe559609d78 ("fs: get rid of __FMODE_NONOTIFY kludge")
> to v6.12.y to fix the problem (assuming there is interest in sparc builds
> on v6.12.y kernels - this has been broken since v6.12.105).

Now queued up, thanks.

greg k-h
