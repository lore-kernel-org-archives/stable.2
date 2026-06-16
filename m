Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258ED243376
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570037; cv=none; b=WKuue3nRCRgsM8IUkkL/ImFveKNmgth+yFYrOjp7V4MRsymaJ+nK/GZr5MpRYSAgXhf0a2TwgllWss/Nq+ox33fQfn9sJM+jdFxqKthlc/uONbsMwyMBN6tjS8RJUxZIJ9wTm/qq8xc+G54+udK1WzUtmynWkadqi21dGXzP+j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570037; c=relaxed/simple;
	bh=dhG0qTmxRJCFeDxS2zULR97K9iw81i0kKqjbWCkeJTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TfUg1qxeK4zjBrePzH0MUE/dyFcA5rEeq4R8vQmyeY7ExXanDunlD4INlF37bXeisCWetn/WWI0qBYI04oUS2iu4f0W+1uin1kKUTW7UUXo91TBdiVt37NBj/UBjZitzZjxAISoBoOVS/ula7K6gO8jVQYDprVYuHNViSsIa3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8PKPYbT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8PKPYbT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3771F000E9;
	Tue, 16 Jun 2026 00:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781570036;
	bh=RC5cz7R8sad6+KQpxwVwOduOOhcwydpgcJc3JovOP84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g8PKPYbTgYCPastN3gvC4Unv51An6mB+b0rCw9FTkDKC6+RhdfBKYzMktvccs1YQU
	 zRtMFsLa40pP40cXYw4s/ifLFMFDqMZg8TcjW1Ku3bRYlZyKTHnqEEtp/GuSlCTe6J
	 JPA9RvqbYpfUqr4Hl7K5V+SBUgxz3ikWN2ycetOEj2jhYYW8+U50C49LFInQbSeYrP
	 toGfSgaRxIU8BAh+libXjRNlK0beRjS/ERULanhg84kRws5H5Id5ZAXOkuZ7RFf8he
	 JBvN8tw4dtO/Na0ERQeD3gvga/3Y0wig5Ovrofjz2WSJT0Hj4RSA7hOIqIc+hPzePs
	 y0k9ABtwPmVSg==
From: SeongJae Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Fernand Sieber <sieberf@amazon.com>,
	Leonard Foerster <foersleo@amazon.de>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1.y] mm/damon/ops-common: call folio_test_lru() after folio_get()
Date: Mon, 15 Jun 2026 17:33:45 -0700
Message-ID: <20260616003346.141166-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260615190329.2368312-1-sashal@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jun 2026 15:03:29 -0400 Sasha Levin <sashal@kernel.org> wrote:

> From: SeongJae Park <sj@kernel.org>
> 
> [ Upstream commit d6b8b02a27b3dd09ec12144322b3dac46d9bc9ef ]
> 
> damon_get_folio() speculatively calls folio_test_lru() before
> folio_try_get().  The folio can get freed and reallocated to a tail page.
> In the case, VM_BUG_ON_PGFLAGS() in const_folio_flags() can be triggered.
> Remove the speculative call.
> 
> Also mark folio_test_lru() check right after folio_try_get() success as no
> more unlikely.
> 
> The race should be rare.  Also the problem can happen only if the kernel
> has enabled CONFIG_DEBUG_VM_PGFLAGS.  No real world report of this issue
> has been made so far.  This fix is based on only theoretical analysis.
> That said, a bug is a bug.  A similar issue was also fixed via commit
> 3203b3ab0fcf ("mm/filemap: don't call folio_test_locked() without a
> reference in next_uptodate_folio()").  I don't expect this change will
> make a meaningful impact to DAMON performance in the real world, though I
> will be happy to be corrected from the real world reports.
> 
> The issue was discovered [1] by Sashiko.
> 
> Link: https://lore.kernel.org/20260525162256.8317-1-sj@kernel.org
> Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
> Fixes: 3f49584b262c ("mm/damon: implement primitives for the virtual memory address spaces")
> Signed-off-by: SeongJae Park <sj@kernel.org>
> Cc: Fernand Sieber <sieberf@amazon.com>
> Cc: Leonard Foerster <foersleo@amazon.de>
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Cc: <stable@vger.kernel.org> # 5.15.x
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you for fixing the conflict, Sasha!

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]
