Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547840;
	b=is0cwtYygoh0CdaAjWRRKB2kzlis2GQdSWYmbl47BUC9qieykBXXTClmLf6Eacimw3pB
	 X/iMm2fxRAu0dnd7lQ/TwpjD2FjCcI11pyKoLjFX6DwrBDOOkmCy+9x6eHZVqeVH5v+ew
	 5IwNaIY6b/mazNzMdSisgXi6Bj0BqFw7ezJUhoD6B9J2nMgYu2U2kBSyLPgjVcgGwVjel
	 KUmIhZ62/UrwZXyXXWBPHVKQb+dDHh86xkcDgmxyDpu4R9fGOYQAeydumsj9SM1YM6h83
	 im+d+Li5zty6zUBr44EN8m55XhbjFqF0g/WZnnrkc42ewecHgNy1kvSxTN8oTgh6KhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547840;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+zMi/65hYb4icVfgLOTZNJ+TTD2i0/XvV1mGmiRSo5c=;
	b=E5dM1T2l0kWz+hr7f18pWHYdbMNtuSzUuzsSjuT3VmcJoD7WwmIuTHA7oKAYiG4+5Wzz
	 GhZzo8NIc9FO4eh9VNIf3hsVA9ixTdTBfzscnWvpriVyMDWchlOtLO61f7pW7gZnIKyzr
	 rQy+OsxAZog00i23s6Ye7iOsQD2ijCtBXyU8FeQgtC1v5tl4jjFhcM3S03hee9cvgCZgV
	 /TLYmNq/Ot1gRPbnjjAgBNS9nwVbeBKA551oRflcOBuzXLwPRNmsuc8XyL1CywJS4cyAP
	 /ENIX0Rl7aJcbre+Cb5pfyZjib+kF1q8+xEDy0e/vcL1SrOZDgO2xtJkM+SjG/Q0CLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=SW39g62m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6714606A31E;
	Wed, 21 Oct 2026 01:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=SW39g62m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095571F000D1;
	Wed, 21 Oct 2026 01:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792547839;
	bh=+zMi/65hYb4icVfgLOTZNJ+TTD2i0/XvV1mGmiRSo5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SW39g62muPgqyFTckNU7VOgm5KdXvPYXlN7Q7nzq1dd+EbBcKNERDCXCQQTo4G1zP
	 WcAhzipv9+PXjXeqgC4zSDyLZW5xMItrHbsi/+p5Q5NOhAkFTj3NRt3I8Ais5ZTyGQ
	 qwMlSInX9oFUF43PdeuHmTZdM+fqdta9z+E1gcyo=
Date: Tue, 20 Oct 2026 18:57:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, shr@devkernel.io,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: avoid 32-bit overflow in dirty
 threshold shares
Message-Id: <20261020185718.1d17aa486a19c4ba88a005fe@linux-foundation.org>
In-Reply-To: <20261021013046.23997-1-dennylin0707@gmail.com>
References: <20261021013046.23997-1-dennylin0707@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 01:30:46 +0000 Hungyu Lin <dennylin0707@gmail.com> wrote:

> The ratios used by __wb_calc_thresh() are scaled to parts per million,
> but the threshold and ratio operands are unsigned long. On 32-bit
> kernels, their multiplication can wrap before the result is assigned
> to u64.
> 
> For example, with a threshold of 25600 pages and the default maximum
> ratio of 1000000, wb_max_thresh becomes 4125 pages instead of 25600.
> The shared threshold and minimum share calculations can overflow in
> the same way, producing incorrect per-writeback dirty limits.
> 
> Promote the threshold before each ratio multiplication and use
> div_u64() to retain the existing division order and rounding.

Checks out, thanks.

As usual, the need for typecasting is a signal that we're using the
wrong types.  It's better to reexamine those typing choices, rather
than casting away previous mistakes.

I think that if you add a new

	u64 threshold = thresh;

then use that, things will turn out more cleanly?

