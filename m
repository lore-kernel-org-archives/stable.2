Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792736033;
	b=DRD71Q+//1DBProbObwFNw8xnAQpOtDLZDwtvS4/1KalnzUa3KJFD4m0zJGwPpBxZVP+
	 TLYKG9GItTio+YsWAICbVdAKtKNm5bB73j02NeFCgyGF4TN9aHz19azPKYKYCM+KhPtl5
	 7X/bSVw8uyBKfj0wPMdBsUyhan9M4BS7C7Dt4zTlGlNQLJSt0OIuZY+qyy34fH4VDQy47
	 c/J8h1CVz+bktajH5MVkHaa74lcqcBReG0VtBGIlfI4UfapRMIaS8qNA0O0nrrYG0tKYO
	 79Q/sGcaZ2+akhJOTKsP0ma0afoGFnW+cO1o61TOoAiBPB7gkt1/nbbnHpurwoCOoPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792736033;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gLL1xptn6RDyJe8PrNG7lNafU7BM+s/CBAoAbuHqSBs=;
	b=CQSZ8Amh/hFKXn26582OX6GvMugTbYQoF/YdRQf8Du/uqL+3pCniLRcmIwFew5h/AxL7
	 2yphJn9Q4/V7LyYtlsDLtBR9gvWBRNXOUPx0f0aR3uTbdTv0qrPziV2LYDSGRHXIQwfGQ
	 YFkKziTJ01OZA5YGbUSGtzhjBL08Gs0wpoK0W/61nXFMI3xtmjoMZG5PibJaOs+QZJEsb
	 3Npqcjj8Jla5l41OiJ6Svsco14BN0pC/8TgfP/bRzIaofs1tpCpv91KnvJX04FO7ScAP1
	 +w734+7NXE2Iznbjt8F3l/bGWw63GUOK5fz68vsERUWa6RWYKIxW5DSU3p3sym41Cgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Goo0za5g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D1606A31A;
	Fri, 23 Oct 2026 06:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Goo0za5g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2691F031E1;
	Fri, 23 Oct 2026 06:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792736033;
	bh=gLL1xptn6RDyJe8PrNG7lNafU7BM+s/CBAoAbuHqSBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Goo0za5gyazjD883Pod89RCemjnoiEarlBhJ9bYbe3/ur7Bdpw4qpRauA+gmppnZg
	 aYOV1NUY5D0kb69X4uJhf2vpJdiYsmFXWIG+L3XWgYNzj/VN2lvZjVPWtBiUki8r9Z
	 LvEfWBaxngy0/6BDmRmePjqsWhLBRHDbz1lb3PAc=
Date: Fri, 23 Oct 2026 08:10:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Haris Okanovic <harisokn@amazon.com>
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: Please apply e74798f2f8e1 ("genirq/proc: Fix missing CPU header
 in /proc/interrupts") to 7.3.y and 7.2.y
Message-ID: <2026102348-spirited-extending-a801@gregkh>
References: <20261022215609.2203554-1-harisokn@amazon.com>
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
In-Reply-To: <20261022215609.2203554-1-harisokn@amazon.com>

On Thu, Oct 22, 2026 at 04:56:09PM -0500, Haris Okanovic wrote:
> Please pick up upstream commit e74798f2f8e1 ("genirq/proc: Fix missing
> CPU header in /proc/interrupts") for 7.3.y and 7.2.y. It applies
> cleanly to both branches.
> 
> It fixes 171cc0d9eed1 ("genirq/proc: Speed up /proc/interrupts
> iteration"), which landed in v7.2-rc1, so both series are affected. The
> fix was merged into mainline after v7.3, so it is not in a release yet.
> 
> The bug causes the CPU header to be missing from /proc/interrupts on
> large systems, such as the 192-CPU 8g.48xl and 384-CPU 8i.96xl AWS
> instance types, which breaks userspace tools that expect the header.

Now queued up, thanks.

greg k-h
