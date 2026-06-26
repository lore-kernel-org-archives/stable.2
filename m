Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECCD2BE026;
	Fri, 26 Jun 2026 00:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782435502; cv=none; b=PN59J2D3qZFA+/a0uCf0bc7jCYXu3o/C+U3mJlmTxjHhAcZ0hW1xqej8qB6gYVYjCzYz/8n7oPgmJ0N6EWQhY4KFtBc06MboTmwsqWhSi7f8mIEtbA9dMMrHCngTXUX04cggofYeC06c1ct+eqYpQjxXhBugESAnoWE+Oh0Yh9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782435502; c=relaxed/simple;
	bh=jWLTZ/AXVNOgS6js3xuxXtAxE4a0xngRkEbgyFI0d2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hV/TUQgyOAoQvxJ0/WtHwYSilSB5md33LLFXQiBc/I7HDdXKilknlUqurLAgds8Rn4z2FxWs2X0UT67R+mFS3oA1/9KRlHkln1iSMB7KP4Uevx7FO6SExSRh79I1PmI/+jewSE0vn9hZtukd4F1+ieI93rTiuR9H1WrS577IQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G6Hk0z2y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G6Hk0z2y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA5C1F000E9;
	Fri, 26 Jun 2026 00:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782435501;
	bh=TAkkL3sPm5ZfzdmjNmlGFuALBQCcFtDjbOh35GYhvNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G6Hk0z2ylq/Oy/aFJH+415QHc50i7/EYqo3wFynduArUqCpblGlirmquZkLrq10MR
	 I8AL3Vdu7/MaQPVyeo6ceuWiGIEwARnndQz4E/EbdM90ufIi2Nz/MhJD5da/cwD+Ve
	 3bsn8HctYrKuNFCbsfe7/CGUvVz5Klqt4L58aXiY=
Date: Thu, 25 Jun 2026 17:58:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Balbir Singh <balbirs@nvidia.com>, david@kernel.org, ljs@kernel.org,
 riel@surriel.com, liam@infradead.org, vbabka@kernel.org, harry@kernel.org,
 jannh@google.com, ziy@nvidia.com, sj@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Lance Yang
 <lance.yang@linux.dev>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Message-Id: <20260625175820.cdc6716095c3355257726afe@linux-foundation.org>
In-Reply-To: <20260626004416.vm4funxhn42hbi3c@master>
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
	<38410976-ddac-4848-a4ff-e6a9f7d9c828@nvidia.com>
	<20260626004416.vm4funxhn42hbi3c@master>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 00:44:16 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:

> >Should be PVMW_MIGRATION and "us we do" -> "as we do"
> >
> 
> Hi, Balbir
> 
> Sorry for missing your comment.
> 
> Hmm... looks you are right.
> 
> Andrew,
> 
> Would you mind handling it or prefer a v2?

I have made those edits.
