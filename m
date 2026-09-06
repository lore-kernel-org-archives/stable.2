Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CE382F2F;
	Sun,  6 Sep 2026 18:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788718374; cv=none; b=tCtF1EJMSKdmSrAcwdxTdclyj5OhkSc5YrOAnjnYodLup0ALx1DnQTMtNh7fhndGxDVk+EXRqz1PNXSx9QqeBuXbP9kYkGR4MLx+U6II8pGxTrkeKtzYvySW1fM/2sYuzvriIHRjeTUIEgMUEXsP4gUUzjEFT8Zdke3Ej+LFX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788718374; c=relaxed/simple;
	bh=zRGTPvX5kJiSubiY55rrWNV2xl5Y77Rfc3wQHRNVRgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJn+F5AbELRm11uGb1eBd3ChwQwm/O/NSa3wT4wpuD4Ltm5wfXyvEbNwNNmnkAa5pX8K9r7rgDUi5ewOraVWd9VzyJ5w6+XZoiL5o5RsLEbHS16q7cU6pzW2A3rBUKR3DICavuziV/3DzHYaT3eYukL47Kav48ClOmzordgRIQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jsELhNFQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jsELhNFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68FA11F00A3A;
	Sun,  6 Sep 2026 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788718373;
	bh=0UKbj6KtD1AbJpXqfcrRDmxZiWxq+JT8NwXXeqVCxlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jsELhNFQUdpiI6ljiNDCByAj0a2uc2qEJz4YOwrpLYssH1qreJPwV3XOZCVHLxb1Y
	 omSwTBCNzuTETNBxaL3nvQngjyX8o5lkXZBozmwQwHPqY3JWWNjtDdtFCrodjiNA6K
	 E8wbFxkkZz+ZzPxHaKDODWaebmO3YJil3IDcSAqGnrNREe3JOsYct+u7Vhh1PGq3WO
	 0D2uQnxWMHkrDNyDV1K3t18VmmI6ScSY4nbypN8VnEZfifXPP+OQXifrJJsaFhnj/P
	 2RjeBqssjhnAgRSTOujABdUiqeIaLPyz+UR/zz/0qqHoPYUyjABPl76RcMZXmW+u44
	 FPECu5yTYvuCw==
Date: Sun, 6 Sep 2026 11:12:47 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	syzbot@syzkaller.appspotmail.com, Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
Message-ID: <20260906181247.GA1148584@ax162>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>

On Sun, Sep 06, 2026 at 07:50:26AM -0700, Dave Hansen wrote:
> On 9/4/26 21:42, Nathan Chancellor wrote:
> > I just bisected the following warning on a couple of my test machines to
> > commit 453e78594434 ("x86/mm/pat: Fix effective RW computation in
> > lookup_address_in_pgd_attr()") in next-20260904.
> ...
> > If there is any information I can provide to help debug this, I am happy
> > to provide it.
> 
> Well, the thing you bisected to is the patch that fixes the warning. The

Hmmm, I don't see a warning prior to this patch though. Do you mean that
this patch is just revealing the bad behavior that you mention below?

> actual issue comes from:
> 
>         if (pages == &its_pages)
>                 set_memory_x((unsigned long)page, 1);
> 
> which its_alloc() does on an execmem allocation. Any chance you could
> get the output of:
> 
> 	/sys/kernel/debug/page_tables/current_kernel
> 
> for the page that page that it's complaining about? I'm curious if this
> is temporary or permanent.

Sure. For

   CPA detected W^X violation: 8000000000000123 -> 0000000000000123 range: 0xffffffffc0200000 - 0xffffffffc0200fff PFN 100e00

I think it is this line if I understand correctly?

  0xffffffffc0200000-0xffffffffc0400000           2M     ro         PSE     GLB x  pmd

-- 
Cheers,
Nathan
