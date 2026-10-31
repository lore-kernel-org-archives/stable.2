Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793444144;
	b=Pvn8gbW5+veP3Qku5Mb+G0LTSsbQPkP7BmbzmeN8GVdqnTW4ehYNDX17mSj918O2zbEU
	 y7zPS4BJtQj9NZEGQuBNZHWjMaImfYIxccglnCcoJe9SMiR1F4vgaaaK23Ch+yiXUJFdi
	 s1EyohVvh0kSTFnIlCkfLU5zcSj2corSPpzz8tup9N6hNd+JvhBiwOu+VsJiY09UUgKBM
	 1mXXwY8RIfWdtc0iSPNpm1mCRsUcTDCIxwFu5bwSQPYiiS/dd0pEicr9jZKtnw8BRlSQ5
	 5Imk4i2H+JajW7ZY+8rDstINTh+c/Fj1ne5MsTUlNtmkzLtrcCHWSuownscJO+8JSZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793444144;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=/zHOCVGlKd+Gbw9WkcwRAX9nfU8lVQAZb5r1Oq1ewkk=;
	b=NFq09kTbSLI+oTwKkl2u4B5BBR5GQ83MmfeqOX59GW2OMCLpdtzE06sXFAjztrsTyaSs
	 HQVOrTyV7Nt83+j3VeCVO66uJhf72+ZLWkDCPzhUbVxc6qnuh4xEW4H5ngq4M3+ocWSuJ
	 9H5teq4MlULVKx5FB7pbXh96xTkzTEMwbtUBtFSq47gaD3n0GebYdDP3Ax/OB/O6Ms3Zy
	 CKLv4MU/1WJ19w+4hy241Zy1QyVdAt6zUkRNxQoHvW84sOWErtnOjU71E9SIFe0XHaZjX
	 nGgVuxmBeJtx+/A9TotLMQDa6SXvUkYAMgki9oNnwpwbnnRO3PNI5SYt1ppeISoK1SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdAdo72s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A7B606A31D;
	Sat, 31 Oct 2026 10:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FdAdo72s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF88D1F00A17;
	Sat, 31 Oct 2026 10:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793444143;
	bh=/zHOCVGlKd+Gbw9WkcwRAX9nfU8lVQAZb5r1Oq1ewkk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FdAdo72siP0pWKtPYHKtDnT3myBbO44Iwr2y7PQ+tvrQr16MRxsWBeogf0w1mEycX
	 F7KTXuXQz91GvFIZwzuFXxSVKD02xpOyrHOGApOiHCw0zx8OXrMxu3khaoylsQzd1m
	 xKaG+SRpDZHcgyg+l3ScfTlpQdzujaWDiHne2N8c4k9djSAqlQUdQDr7cy3uJ/lzeP
	 VMrODT4NtA6cATADzB73dBOSZfqgXIV6n2GgvQTDXcVIqnmhMNXHHgSV/nFteiftAi
	 fv9qjBDhYrKGwvHE3Y0MQhc0eXTV7uKkWuk+6b1W4Y91/zGSNhOl8gODnISQZyt8JJ
	 jjetI8m0mleMg==
From: David Hildenbrand <david@kernel.org>
To: akpm@linux-foundation.org, Lance Yang <lance.yang@linux.dev>
Cc: david@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
 liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
 dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
 jack@suse.cz, djwong@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, hch@lst.de, pfalcato@suse.de, 
 ngocthang2710.1999@gmail.com, 
 syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20261026152013.10511-1-lance.yang@linux.dev>
References: <20261026152013.10511-1-lance.yang@linux.dev>
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
Message-Id: <179344413746.15514.3017134720155207012.b4-ty@b4>
Date: Sat, 31 Oct 2026 11:55:37 +0100
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

On Mon, 26 Oct 2026 23:20:13 +0800, Lance Yang wrote:
> collapse_file() can call page_cache_sync_readahead() while still holding
> source folios locked. If truncate holds mapping->invalidate_lock
> exclusively and waits for one of those folios, readahead waits for
> invalidate_lock and neither side can make progress.
> 
> We need to release those folio locks before starting readahead. On a page
> cache miss, roll back first, populate the collapse range, and retry once.
> Doing readahead after rollback avoids an extra pass when all folios are
> already present. If another miss occurs on retry, give up rather than keep
> retrying while truncate or reclaim removes folios.
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

[1/1] khugepaged: fix readahead lock inversion in collapse_file()
      https://git.kernel.org/mm/core/c/96995467

-- 
Cheers,

David

