Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80F3597B;
	Tue, 13 Oct 2026 00:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791852396; cv=none; b=BbzDvlu+j2bmM4er0DH/PPCDouSf99SFgdV2KDdjDdG84eXXKS3FFSvWFaJInGHEw6M5dyOFAuFTMZmDAmBMyP9GCI6/HxXzC7ctVku3iZdcF96E0aCKgP8zv/26nu7UpBUHFfdMT4dAxGDSuRQvMPe/PZjXMqKaj1iLUwbMttc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791852396; c=relaxed/simple;
	bh=J7nekE5mQiI2XT83mTSb4x/jiORslfk7laVQ7w0ieSU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xhced815zZfUx8F9Fj9a/ZIGXjW4kfOn9TOLIwv6no2ySgjDTuzNuetgnN6QMaXlAzDn6j+JDsZvS8xNcZ5uvCzvUJxLUxgyxjBUlwgoEf3ApP3DRvLM/9kiUzKg+q5UVTcwCHJS/3j1SvKg0/I0dkEeH/CINr3rdiebCpBCj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Syu1u2hR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Syu1u2hR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0101F0089B;
	Tue, 13 Oct 2026 00:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791852394;
	bh=cEwon4gjp+x1MBe2eyFSDvJ62gG0hpSEQDYWtssky3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Syu1u2hRHcxGtl/rA3LH2AEggJGGZr8G9c9WGPSaSRPfWJtdcNmjPYueQROENPzGF
	 VvgqYqBttA/VA16gR3JcZ54njyWalkuoD4A5bn+9Cp0P3YRGfpV12sNX1Wgza37Jys
	 U4SPZ6QueYu7Fyl0LiGNrn5LS+5Jij0G13D6xQE4=
Date: Mon, 12 Oct 2026 17:46:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 0/3] ida: fix the allocation failure paths of
 ida_alloc_range()
Message-Id: <20261012174633.6a86cf6ab068f3c1eff94fb3@linux-foundation.org>
In-Reply-To: <20261013002703.773923-1-nickolai@csail.mit.edu>
References: <20261013002703.773923-1-nickolai@csail.mit.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Oct 2026 20:27:00 -0400 Nickolai Zeldovich <nickolai@csail.mit.edu> wrote:

> These three patches fix what ida_alloc_range() does when its xas_store()
> fails for want of a node, found while formally verifying the function
> against the kernel binary, where its resource accounting could not be
> established against the code as it is.

Please teach your LLM about the first 32 lines of
Documentation/process/stable-kernel-rules.rst.  Seriously.

Please also tell it that when fixing a bug, it should fully describe
the userspace-visible runtime effects of that bug, especially when
proposing a -stable backport.

Thanks. 
