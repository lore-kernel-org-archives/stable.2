Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793540005;
	b=JVAQBW3Q3V/IciTo4unCzrwMxlsfHQpUqW0rVzGz0vG6AF0HJ3kFzNAMuOnT9bzQFLKI
	 YHJrxIJIgkoYe6rAmNHoF8MUkV32GwzTBM5OjHJyEPHSbcR046cM+Wo2pUUgcOUe+NM4A
	 uoC7pohTpnRgv4ztfEFXdVthVYhwZftomfEcKWxOj2PDGRuyqZPXd9wIWr4RFeT5O9Pbj
	 2Khz2HQ+kFhu9uzssc6jTL7OO9fPcVRIq9b6wBfa6eveXbNfzms1FzWMAsKOUd/6MUAKE
	 YApaYat3Rjqv0PhCIHNmyo6W8cx8gLiBOdyy3vmBIjv5txGNAxqRjZSy4QJc3l4i9tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793540005;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=neLWtSceMYlxYsjXzdJ9arOYUSJDsCqTRHZbfoxyj3Q=;
	b=uhSDdkGvYluDOgepYIVUe1VIKXrFj1teiIeAxXtWAvIPErXeoEWkiZfIqKVdN7ZCksxT
	 SiTuZkaiynOL2XPmyLrA2og2SDPns63A0dym41HdZzbv0TdDoxCn4ekCzzo/P53WzhXDu
	 6S0w1bQLwWpWG9tJO+MvVsQuWu7rp8NcybGGAommda6Xg0dwJ4daLeCW/Ics7soLCv+CD
	 HvRScACueW2IJkvRDgkTUTp6WOKyc2vFwRi7pgf1vsEVEAfDB2nN8NOXS6FGlZh7NKjG9
	 CtlXVn0otgROrfCQ7NhZVsA64cZRDei3YJG1dYxS+MHgE1cZqEVqYjnJ3aOXSPAxoKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYYDVKoD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39F606A324;
	Sun,  1 Nov 2026 13:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYYDVKoD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B836B1F000C1;
	Sun,  1 Nov 2026 13:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793540004;
	bh=neLWtSceMYlxYsjXzdJ9arOYUSJDsCqTRHZbfoxyj3Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AYYDVKoDRJv3WOKI2s3gA9ET9FOf86cYW2f9/a+SmZbaPnZTSGJpPraTfOsKS5dI9
	 udjzMc0Mv3xwBW4MdlPa/yVahM3ZuMq4XW6y0MEhzstCx1w0ZJuJpW6IiLPz6XJbxa
	 hQmDNEeSGMH4ggIaUT2z0JgxTlQ24Wc2tSPEwvhUsl7EyZWhieeTKOHaaA/AigUGSp
	 K+LUmZDOiOjMEe7z+jEsAmpqSxK+JqTaebB5Z39bexKieFL8FfGUzs1kS67vXax3Lj
	 nmPzQNXxmQFJbrg2b9r1WwH6VF31NR/QVVc/2zTfm7qZI3+Z2maylHRbXIeGhoYv7k
	 /bP5aFkJKUdkg==
From: David Hildenbrand <david@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Andy Lutomirski <luto@amacapital.net>, 
 Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261031203540.2282507-1-skhawaja@google.com>
References: <20261031203540.2282507-1-skhawaja@google.com>
Subject: Re: [PATCH] mm/gup: check folio->mapping under folio lock in
 memfd_pin_folios()
Message-Id: <179354000144.6438.8171913734635387726.b4-ty@b4>
Date: Sun, 01 Nov 2026 14:33:21 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Sat, 31 Oct 2026 20:35:40 +0000, Samiullah Khawaja wrote:
> memfd_pin_folios() pins folios from the page cache without taking the
> folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
> its refcount check while memfd_pin_folios() still pins the old folio,
> and the caller ends up with a folio that is no longer part of the memfd.
> 
> Lock the folio and recheck folio->mapping before pinning it, like other
> page cache users do. If the folio was removed, retry the folio lookup
> from the index that was removed.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: for-next-fixes

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()
      https://git.kernel.org/mm/core/c/10b2920f

-- 
Cheers,

David

