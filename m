Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73378F2F;
	Thu,  6 Aug 2026 06:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785997783; cv=none; b=AEXEsH2C1YPQqtnubS0LQlnG0UXRMpuvBIIju8FLTjHwqS9rcO85dFqc8kPLuskviE3V7cmUybtb6Bo05WgeMLRbIbqMCATQELjaboMHv3dTXUfdoi2X9UWXzV30r/DylGmI7ccQoYoNlXcYqv4a+mi8ur6CNvIPNMu0SFirlfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785997783; c=relaxed/simple;
	bh=W8Ka2GyGSF7gzyXYu3bxcMqDbJP64R5aVj0T65I/HLc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=J10UK8IU6uG4fyb9cCX6Eicpz4AI2CvXpKx3uJKpy2usPBop392kOllZVWLqNRm9I4iqjS3DWvQ/EZqr7iModnU05TxxQmv77nkbW7xTHxtJdl4dVTqP8NNakxMQ+BN48ShRfdiqhQ+4f49uW6rjEu2oBIgTiQ+qJe/NVoFbnjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GRWypgQm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GRWypgQm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3EB1F000E9;
	Thu,  6 Aug 2026 06:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785997782;
	bh=1oY8lbXTomFFABlq28RvaAPiO8AnqoSfHSvFMVUFi9o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GRWypgQmsQpH+Mr5K0BFXBFwozD5Xie44p36cirnIl/qe72fnBCZqqUi3XnTAuvsW
	 k9fEWGIjXwyguJ+5OSp+EhtwwZ0qrXbsVwKJwtq9YWjWnf5Zc4hDaP+wj96ig25pDi
	 bUdceVvm/e4XvKCrCl79UjiyHFU0mf6m+9Im2Mow=
Date: Wed, 5 Aug 2026 23:29:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: liam@infradead.org, ljs@kernel.org, david@kernel.org, vbabka@kernel.org,
 jannh@google.com, 00moses.alexander00@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/madvise: avoid skipping pages after splitting
 large folios
Message-Id: <20260805232941.e89e96269472ce5106967bda@linux-foundation.org>
In-Reply-To: <20260806055501.56761-1-cuiyunhui@bytedance.com>
References: <20260806055501.56761-1-cuiyunhui@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Aug 2026 13:55:01 +0800 Yunhui Cui <cuiyunhui@bytedance.com> wrote:

> madvise_inject_error() advances through the requested range using the
> size of the page returned by get_user_pages_fast(). Saving the size
> before error injection is required for hugetlb pages because successful
> soft offlining can dissolve the source huge page.
> 
> That stride is incorrect for non-hugetlb large folios in system memory.
> The memory failure handlers split such a folio and handle only the base
> page for the supplied PFN. Advancing by the pre-split folio size then
> skips the remaining pages in the requested range while madvise() still
> reports success.
> 
> Advance by PAGE_SIZE for non-hugetlb folios in system memory. Retain
> folio_size() for hugetlb and ZONE_DEVICE folios, as compound Device DAX
> folios are handled as a whole.

Thanks.

> Fixes: 19bfbe22f59a ("mm, hugetlb, soft_offline: save compound page order before page migration")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>

Should there be an Assisted-by: here?

When fixing a bug, please always describe the userspace-visible runtime
effects of that bug.  Especially when proposing a -stable backport.


I asked Gemini this question and then pasted in your email.  It told me
stuff, but I don't know if it's correct.  In this case it would be good
to hear that description in your own words, please.

And perhaps a means of reproducing the bug - clearly our selftests/
coverage here is poor.
