Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D3E43DEB8;
	Thu,  1 Oct 2026 08:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790842268; cv=none; b=G9KZpmneqCKFTVF7tkl9Tlp02NdrmbW1OcH+eFdCNeJjf2T4ICXEnz7NLqlrt2c+n5UoWt96B+jASzcrLk5cBPFUMZwU1/Eadr5i8F1CAA9ZQgtC7YDRXsaDJjteA1xHlSBrsjqtxdZadzxJ/gOEvAxMDr2WOnQ+xhX/E4scTE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790842268; c=relaxed/simple;
	bh=a3KAFfZLPL/iqhDGoZOXunbeijIVxJ+m5g4rQeKJ4iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcTrdt3LilXYZd/gmMzjWcM9q9UaqCLYTb4F9z81ae4DUFtfiCBg0D73/2mJtyDPNGtgNp5X3hNtszmsijQyyW7qWQISUMt/s/pj3Tj1WHnWgQEghMJa6mddcOzda5z8rpqzl58rVfNPT2/iWLYWTWOA7Cz+UUK+GqQ/p6/RpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqvZRIdr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqvZRIdr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810F11F00898;
	Thu,  1 Oct 2026 08:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790842248;
	bh=d5/phgaGBQwVy6V6BUkCiUN5WmeiYYNNtE9pDVKKLjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aqvZRIdro+8NdHQstHL7gE3OG7dqz2U+WyzsVI8h3r7c0vsi0QBDnSdZLjUzzqYgk
	 2c3/n5Z10vygU+/SCs7KYlMFoYvJ8tnzI/jomGmzM6R8qiDL301Ylbbqi6wffK7LbC
	 c6l2jaWaPxj0CmM2DwtLvk3wvVUNMb+72TMjPWjrH1nAVT3O/T6MjIz2L7HSW1D+qs
	 eA9E2v1TdygeOd1/qYwfp/TyTnEzmbZxFqMSSDx368vIbMXS10j1yYm2n3nHUeUcqM
	 xuaj5dQL3RUErk6WliqUS+3LFfo9vjjx6Ir9SlwR+KyDpXvTEECiUPbyFisBqBpyyP
	 NE3pI1FiXgGKg==
Date: Thu, 1 Oct 2026 09:10:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-ID: <ar4VdqHwMRuYdqck@gremlin>
References: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
 <CAEev2e8TXNwon=Ro27WYvyn-N5j=CenA8pEgLTPerMQtDh2OWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEev2e8TXNwon=Ro27WYvyn-N5j=CenA8pEgLTPerMQtDh2OWw@mail.gmail.com>

On Wed, Sep 30, 2026 at 02:15:16PM -0500, Anirudh Srinivasan wrote:
> On Wed, Sep 30, 2026 at 1:47 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:

> >  mm/mremap.c                   | 70 ++++++++++++++++++++++++++++++++-----------
> >  mm/vma.c                      | 21 +++++++++++--
> >  mm/vma.h                      |  7 ++++-
> >  tools/testing/vma/tests/vma.c | 10 +++----
> >  4 files changed, 81 insertions(+), 27 deletions(-)
>
> Thanks, the selftests are passing now.
>
> Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

Great, thanks for confirming :)

--
Cheers, Lorenzo
