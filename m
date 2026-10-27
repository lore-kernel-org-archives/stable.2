Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793080203;
	b=qIjvk5lDFznG/YlyUQApsSmcbZjTQ6u4gXRDtksqzuDrmw7G6j3VkTHq7JEIkoZjuGis
	 XNFq3XGTdBifa/e6SSz67kYDksLrv5c9DzTHYLjeB5Ah/4IgUxkuOk6gsfV61NBIPfYhZ
	 HFAyHe3yQyYOkVDv+abev66tEJzf8yhQNpoRGARY9aecoz0at1ErKK1ckE3VrAVA2CD1W
	 hFH8vSXZ6wLQQBkowjc7G7JEJPUMCAc8MkMow/prRT+QpFiMZB/0BCpZAlDLYMGZ3c9hX
	 EfERZNXRJcfM1rqTGSTLQejZ8kpaayyYgPkQmA1M2/51XQwFZJCli9AaJe2XFXreK+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793080203;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AF8+tY0XoFdKfS6hqQtj29XSUELY/nlktGY153p75yY=;
	b=zWF/5plSpjyJbVesLJwzyxphm8W6+X8A7Dhgq6QOaRWflWY4qt5oshnYBNRJ2hCI2RTI
	 Hm+bkTUh6nJXtdXqKA2xKqSS52iwfdpMdQDQ8n/QCuAchdvGY8C6PHT9NwwCp8GbE/+Zh
	 K3eNVtEx0C/X6yeNOdLRC3rsbURnrus7L1dHVjJXzTNBL7Y2HlFxs5fsBK0J9aVvP3PlV
	 estxTyJMV1PczQ3LFBhGIaoMaVT24MvqLQdyc+fprYZ+xmDhUei4jzrCTZ0EaAstE2dUV
	 4vt6JMOdeeETlQtSlRTv1egMi0sQqON9DyCaXE31OntBmWiCMo8jDjst4bJ1J0qJI5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=psSjvtjr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6552606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 05:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=psSjvtjr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBAC1F01825;
	Tue, 27 Oct 2026 05:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793080202;
	bh=AF8+tY0XoFdKfS6hqQtj29XSUELY/nlktGY153p75yY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=psSjvtjrdA3tpFpm8B+Gww+BgArb0Yb/0KG5XXC9nhz6pbSRTOmv7+fBIOsp+s0WI
	 uVEXY6wCharVJhj908OPiQ6E3axYsHKttd0Ud/sPcy6JJdmnojydpw0D4CBEP20dh3
	 l2aSAwbuni6ZNAJ803rYtKt844PFn692+h3x+bZE=
Date: Tue, 27 Oct 2026 06:50:01 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
Cc: stable <stable@vger.kernel.org>, "tuan.zhang" <tuan.zhang@amlogic.com>,
	"jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
Message-ID: <2026102700-astonish-whenever-37b4@gregkh>
References: <2026102711371963416812@amlogic.com>
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
In-Reply-To: <2026102711371963416812@amlogic.com>

On Tue, Oct 27, 2026 at 11:37:21AM +0800, yao.zhang1@amlogic.com wrote:
> Dear 5.15.y maintainers,
> 
> An mm patch should be backported from upstream mainline to the stable
> 5.15.y branch. The patch's information is shown as below:
> 
> [Subject]
> mm: call the security_mmap_file() LSM hook in remap_file_pages()
> 
> [Upstream commit ID]
> 0f910dbf2f2a4a7820ba4bac7b280f7108aa05b1
> 
> [Kernel version]
> 5.15.y
> 
> [Why]
> The remap_file_pages syscall handler calls do_mmap() directly, which
> doesn't contain the LSM security check. And if the process has called
> personality(READ_IMPLIES_EXEC) before and remap_file_pages() is called for
> RW pages, this will actually result in remapping the pages to RWX,
> bypassing a W^X policy enforced by SELinux.
> So we should check prot by security_mmap_file LSM hook in the
> remap_file_pages syscall handler before do_mmap() is called. Otherwise, it
> potentially permits an attacker to bypass a W^X policy enforced by
> SELinux.

Please provide a working backport that you have tested for this, as it
does not apply cleanly on its own.

Also note that 5.15.y will only be alive for one more month, so why
aren't you moving off of this kernel version already instead of wanting
to add a new bugfix to it when there are already 2000+ unfixed CVEs in
that tree?

thanks,

greg k-h
