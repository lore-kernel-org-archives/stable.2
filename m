Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793083822;
	b=qD7STH7vOajTBx//hTsyrMs95lRwI+u9bh6vqQio5RHSs9peXi4kJMp2zGreryLKl17t
	 WNrJ4kzv4OT3fx6BFdsSmbybprjjW1yxMcEfrwr/uLw/n4DtGMr/5egV0oonohVcn5yIH
	 OrjdiAQ4N1O1C4ligM/hsG9EIRsL5Zrw0nKmGUyNzmfdUdg1KRxm7ZyQ4k0+T5cSGo2S9
	 7MpMNheoQVIJ+JuJavQcKxhbNDVbgCrYdy01wPCmb/YayfGsOXXwINg1DO7jFrcxnj8sN
	 d21hMu8bT4jjoS12ST0/HKPwYbDO2aZnBgc7TRK/CacSrK2gcmK+g5SnoERaRrlFqpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793083822;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=a8fTD/fC9ruAzXHIZfkDejpPZ2PfKsrvIUsBB5aqWT8=;
	b=opHKBdqeaKzJ4hjDEtjQxWEpJlWEzDRtmNBBAQHenl7ZOFmD9ryKlAHcx66K7C4fXvLR
	 hWj3jQd0gcxnokSCQsQuzdgo08lqtQUKYry+WK0wODL7x6JqINjbsTPU3WkshnJnb4R5G
	 NE7JR28pb/GWw+RBI6qxvsUb97/i73w7bqtZC1cYbsfB25dUwCX7kbmKB/tameZ/bx3UQ
	 ZZVpoDAuPPoZhaKI5hVVf+25Xu909OJS5Eykp8bxJqRNfJYrCKAVYMSgtzsuafwN8DtRa
	 j1yhZ6wRLh4+OUe6GzleJSSWW1SZUDwuC20WeNvOsH4bamUf5V5JrRfFKk5e+ipgx3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="W9fnU1/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608A606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=W9fnU1/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523AD1F01825;
	Tue, 27 Oct 2026 06:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793083821;
	bh=a8fTD/fC9ruAzXHIZfkDejpPZ2PfKsrvIUsBB5aqWT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W9fnU1/XSiiiPGgZbDJnLGWKZmnb+I0KthGgCyaxUFLNIw6tE40Nslt34b7ovyz5a
	 s1wgdtZowA5NTnuIKF/beK8XfkX2+iyHovbh3D8FBYqrNOVHwij8xPj5KJKo0s8KnO
	 mrkwtPshjlH+x2PbU7OS+ykDJYLReX81wWD14hBQ=
Date: Tue, 27 Oct 2026 07:50:20 +0100
From: gregkh <gregkh@linuxfoundation.org>
To: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
Cc: stable <stable@vger.kernel.org>, "tuan.zhang" <tuan.zhang@amlogic.com>,
	"jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: mm: call the security_mmap_file() LSM hook in remap_file_pages()
Message-ID: <2026102715-carry-strenuous-652d@gregkh>
References: <2026102711371963416812@amlogic.com>
 <2026102700-astonish-whenever-37b4@gregkh>
 <2026102714443948547539@amlogic.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2026102714443948547539@amlogic.com>

On Tue, Oct 27, 2026 at 02:44:41PM +0800, yao.zhang1@amlogic.com wrote:
> Hi gregkh
> 
> I have verified the following:
> 
> 1. The patch can be applied to the `linux-5.15.y` branch.
> The commit applies cleanly on top of v5.15.223
> (using `git cherry-pick -x`, with no conflicts):
> 
> git cherry-pick -x 0f910dbf2f2a4a7820ba4bac7b280f7108aa05b1
> with no conflicts

But that is not the original commit, please do this on the original.

And again, please provide a tested backport and we will be glad to
include it.

> 2. Our customer is using the `5.15.y` branch
> The customer has requested the inclusion of these CVEs.
> and is unwilling to upgrade to version 6.x or higher.

Then you have tested this already?  Also what will they do in December?

> Furthermore, as they are using GKI 2.0, they cannot apply "autopatch."
> the only way to incorporate fixes for CVEs is by updating the LTS.

I have no idea what this means at all, sorry.

greg k-h
