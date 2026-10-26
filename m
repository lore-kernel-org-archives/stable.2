Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028855;
	b=nrmFQhck1rU3cyfRYC2zLpYH1V8l2UivCu+7Q6nmYT5brv0gcLDLlYk+vNuURCiAV/GY
	 Ftnp12TjfOWySq0OK1YzmFW6BVcm5MveXsc5SP/u15jjfaqxHdlUK4/xEJ0f1TANobBTg
	 5rckRIje6Uet9DwghlTqOYIYYUpTpWJrw9yrrNXWPkAn6/XNjYYU7Uza4nZrv0aYkeNOP
	 zPjsG4UHM52fZ54TD1i/Ze3L8T+/i+XH5u4ilZLw694FdHrX6DqEv+b3ROMG/6OVNyXnE
	 mrRxlNapRFOr7S5U9Ja2L2oT0k3kw1HuMmyIIX2lMnvam1WIGzSVOQ7lxcidCOI8qwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028855;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=enXAkrWKOg+OnmNqIxb5MDjoHdnjUwcVFg3yFO3gsOw=;
	b=xLqyyGq9rFEnNgAx9zHDYv6RkI7bFo9vx401LnLjed/hQvlVa+T0PFMZBsuqceYlcrAJ
	 EMFpDjjTQgcc2yo/WVeXBqr1JRD9tBZXqJOX5eQcD0C4rB8snBCRcNY2xnT9/8nrZvusf
	 UYFXeyR4vbrpaHWg2wa1zaq9/osTb/HixwbB/2AnUSnlKL8Kfi7DZrrY5OI+q9nb9hH4A
	 SKJPSYhI12P+EASyjo80gUOw2aTMcOJl3BjdIYiiLB1azC1R8sMx9JeUHCzBYY8IOtUks
	 iDFHe6J+UXhhOu3CnDUNRRVMEsGJv9VllbIaOUyO60PLYI9liM9xMGlLedPDYP6liGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYGedghM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E75606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hYGedghM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723FE1F01829;
	Mon, 26 Oct 2026 15:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793028855;
	bh=enXAkrWKOg+OnmNqIxb5MDjoHdnjUwcVFg3yFO3gsOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hYGedghMubVMClDJg8UjWJMPTv1naRWZLHo697LqQ1NjJFFIW3A8z6OiuPm5amsZK
	 817PrEtBwLXo2grKB3+JJOXabGO+zkyV8rqrnzu+GUiWa5EXeMU+HSJeOpqbRGbTuj
	 mxwEQfmskRo7b0x/jML5dWtyFpr6ot32rvD80UbE+Efxr1B2/cwsjfYgY8I0LP0C+N
	 C3DXm1HeJOokgfAgsMo6II1fKAfvoTievNq+9Z7q1Gj9Ols22ZaCpg5oSrBrMXEAjY
	 w5fvPfLODiXzNcoK9k6c1tpxQj3QfQElWrco5vXv2FXo8OwCGzdk5wikjtYD9EW8S5
	 arbgWnx6hwdrA==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 34BFA198003A;
	Mon, 26 Oct 2026 11:34:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 26 Oct 2026 11:34:12 -0400
X-ME-Sender: <xms:8nLfasmfM_A-8C6FdWnJR4MHx7n7Fo7vyQTnWJp3zKtP3nYBEhxX1w>
    <xme:8nLfavzl_xCYhIJLLpgJh-8VYiGaAi7HY0RQXA9j6TC9hHjdekDNQyRy-8eY8JFFd
    Ff4pCUEW-dzMzcC3YPZ7H1T5eDJsdlcfhGStKqYRdyNE16t6fNCTWYu>
X-ME-Received: <xmr:8nLfajKUovqMB16oEA__sc1etkZHnuNI6tVhz8wdpB7mtQixETQS5gGollY>
X-ME-Proxy-Cause: dmFkZTFChFXNPhfha3/sK9OQCU8ZlQFCIc2lL//QxSk/v80tP++TpcUbd8oBI/UC2hCcQi
    dysjiuRL+Umb1+5MgKTxHJCkcRB06cFautIOspS/IbW++kG8/nt8ByYqmCqa61kOqjjIkZ
    5B1b7xPTLC8gMOzABjCI1erXXuf49nuLg074PCjSRrrp9+Oq7WC3QUM0ucvNkrWxZrrCG5
    MVs6FZFG0Aaw+DL35JWwRyN0VG4Fp22qKOZ53y3IQDxZIkjTk8a1YbfdrS4W5R/sbrBkRC
    UBedcz1USRKX28DOANmsb5RQXnQUKOL0yrp2AoqRpq0xZ+5hUhJdrd4k3LnrmS7tNTH2jF
    +hrceKOpzCT+YgvEo6Tidp/DIQQXN+eysGfT3Nunq9RrOxcrzaKuoL24LSxJcWMRTCQ7JB
    GbyChTM3CE2oDN4OuBozGAgz0BtZ/66gj/UKJZn5e/XsKdnswLwtpoCwCrum5WoWiMT0vK
    I1CHxlqCouIb6mBk7vYnOSlrtbnJaDjNzT8MT0NGEhwnzpFTSWbHMyMNDxXDshV6DKo36T
    m3GWcwxg4sHSxn6V1+ADIZM9hb++0XNTk1dIRJNH7sonrxwjvO1m5o5RnDM06kMMYbQQg5
    P3GMfvvNuuOZPzbclJKODWSzYrt4rBUgQCMlvQYsuLNJ6//cwaoVT9IQP4/w
X-ME-Proxy: <xmx:8nLfaiIWUjTM3Uzj9zDV0cUQxWekHdcdUFfzUe5i-gXZ4cohLZetaQ>
    <xmx:8nLfaiVL9ri3TDtKf021iCV3YxqSv_NYyxWJ5WffayAlEiPBGXaBbQ>
    <xmx:8nLfaqBOxmM8eyw4vmNZCC_6I-16pxlgLBJXgS9Ni0JZDC-FCKbeNg>
    <xmx:8nLfalFghDFHw7Ivc7lOozgqdNDSlBAYOgJnKh_WFhEr_IPCMToVWg>
    <xmx:8nLfamf3M2UKMwUNzKOTyHsHgSG9tI6zGNoyZOnoRhh_O5poW5mpXUsU>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:34:10 -0400 (EDT)
Date: Mon, 26 Oct 2026 15:34:08 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>, willy@infradead.org, jack@suse.cz
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
Message-ID: <at9xXRhD2xZhszEj@thinkstation>
References: <20261025164619.89992-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261025164619.89992-1-dennylin0707@gmail.com>

On Sun, Oct 25, 2026 at 04:46:19PM +0000, Hungyu Lin wrote:
> shmem_write_end() advances i_size to pos + copied even when copied is
> zero. A buffered write past EOF can therefore extend a tmpfs file
> without writing any data.

+ willy, jack, fsdevel.

This doesn't seem to be tmpfs-specific, right? I see the same with ext4.

simple_write_end() and generic_write_end() check pos + copied the same
way, so filesystems that use them through generic_perform_write() are
affected too.

It makes me think maybe generic_perform_write() is the right place to
fix it. Hm?

> Moving prefaulting to the slow write path makes this easy to reproduce:
> a one-byte pwrite() at offset 4096 into an empty memfd, with an unreadable
> source buffer, fails with EFAULT but leaves the file size at 4096.
> generic_perform_write() calls ->write_end() with copied == 0 before
> trying to fault in the source buffer.
>
> Only extend i_size when data was copied. Leave the existing folio
> handling unchanged so successful writes, retries and preallocated
> pages retain their current behavior.
>
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  mm/shmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index d97fc32e7c94..55287c370c73 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3487,7 +3487,7 @@ shmem_write_end(const struct kiocb *iocb, struct address_space *mapping,
>  {
>  	struct inode *inode = mapping->host;
>
> -	if (pos + copied > inode->i_size)
> +	if (copied && pos + copied > inode->i_size)
>  		i_size_write(inode, pos + copied);
>
>  	if (!folio_test_uptodate(folio)) {
> -- 
> 2.43.0
>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
