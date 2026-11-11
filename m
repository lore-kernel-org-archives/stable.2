Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407428;
	b=fw4rD61oCfZ2TDsBP85PH4uBNpBqtqMAeN9FvTIvjJki8o/x+jSEF+byZu0yaF0oEDSD
	 ggDu347fk36iktwMcpGFLgxbmmGVB1WXAdIeeWPcfWFcldjbYwUA60DpAklTbM9rPWpsD
	 e5mhDBHuuOMnOCZbTgYbOYyyeM7XSWVeTyB6QSi+WssHcl76SXLpXxDKEJecLO1s4b9wf
	 TlW7eJALc9Gg9z2T4XLS4/f2n9XZtyo67JBsbEvYp9VdWa9ANQjAVQwYZ0SgUw+eiRePI
	 Ht88KDqyjIftcb6U20axDUXQost3lE+CSEN/WXcRUy5KOez6NDcZSTRyCrFlwTQw57Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407428;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hl6P/qIPzgssqPnaK+FHoZEtoJEOWAXytEPxMQqQpG8=;
	b=eJ2IRyyjWnb3QPX/T+FT3SSdHV5tP2HeBPTClm2nKNUbN2LmIx4U+W2qH1K95rKOZc/o
	 5CdYKJ94x57Y5qdHOtio1o8jaIlvKnYcFX7HzNo9xrkrB/QujCIePj2WOaGoXkO6ECFGI
	 MImTR/0kkA/OpHi7aNTYwF2OzLd4R/G9l7bqeJN8ozNUFktCLbB9S25ohNlQLOgR5YVXB
	 aW5ERc51fzbIqfPwqeFWknT6RD3JJnaEN+r0Eae5aYocWb6WdwMUTDzYVVhxOaKT0GYY5
	 z8fS0kBbONqlvyalSgzOjM/T29kbX0eqJE3WMdkfZOEOF2Zx2SBZbr8e7Kd7/Hgm2uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVGAohVR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C9E606A326;
	Wed, 11 Nov 2026 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVGAohVR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B831F00A05;
	Wed, 11 Nov 2026 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407428;
	bh=hl6P/qIPzgssqPnaK+FHoZEtoJEOWAXytEPxMQqQpG8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iVGAohVR/WW8AesjJ4/F4CEf1WLU8bl4pYUgUt991gPtj4Odkyd4qY30lpF07ajnw
	 s29SHfSJ8wuBjKM4wkU2gGMDIREwWNxgUGYHul9w5fiF1XqRVIT9ed7+egXyxX7UqU
	 /Kp02xz0crC0LcA5hYdNnYff9I+ltB0OJJEGYU0xS6iRGPfS8fC68DkGb+pG38jjaV
	 krCl78zEGGsOKc9RxoW8eclQuPj6wLmpbzr9gHxmrXl5EMjqxHawS7TWd2M5CHJr6M
	 cXpUILzNdIn6h6BxCjJG76muhqQYkE/UmqZQlfvRucBgGZy9in8PR0SpuTsHK/aGUb
	 kqciCVs60z8CQ==
Date: Wed, 11 Nov 2026 15:30:24 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix the SEEK_CUR f_lock condition
Message-ID: <20261111-aufhalten-erwerben-abmontieren-41386b5caab9@brauner>
References: <20261106-work-file-seek_f_lock-v1-1-5b9a6c2928d4@kernel.org>
 <7vzn53nez54u2ps3z7eb2v7vqca3sitzhhu7epk2lrrkt6l32o@hxboo6t23vow>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7vzn53nez54u2ps3z7eb2v7vqca3sitzhhu7epk2lrrkt6l32o@hxboo6t23vow>

On Fri, Nov 06, 2026 at 03:51:26PM +0100, Jan Kara wrote:
> Isn't the iterate_shared check moot now? Because all directories will have
> FMODE_ATOMIC_POS set AFAICS do_dentry_open(). But regardless feel free to
> add:

True.
