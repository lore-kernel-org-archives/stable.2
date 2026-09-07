Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EF29B766;
	Mon,  7 Sep 2026 22:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788820100; cv=none; b=D6e/EFV8RcsmacmpF7qUrhsBtxl9fHOUlT/CVDDZjpxZKNnFRyPOoTcgXWqdN/miyurRdhkKnoKJ3K5zx3E0p4amrI/Vkby16vDx7nsxFcy8SaVlFr9+bqtk0TLesc+jaI2ejaRIl2Cm6ibeKbdb28L0Kv2GRfRIJmRmtNYNs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788820100; c=relaxed/simple;
	bh=Wf+uxAz4MM2OY6rJ1HTjJe/OkxX7/CjswcmFiSaeuw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwzh1d/llvfZ09dYQq/3e5P4ttOzqSjzbEQ+LmaymWVPsb6ZWZwjfIPUlJ7kOyOC/P3zfSdLXgnNKPm6+nKTYqUntM69l3aYdOkSF4uB/1TFoqCKg9dvcnNPku0uQ7OQ9Zy/nVlQzdKt9imaaaMxT9QPv2ttjqTx5lTF1v28ZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGK0y7af; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGK0y7af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01791F00A3A;
	Mon,  7 Sep 2026 22:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788820098;
	bh=owiM88nOXIURj9qsoqZkIThz+09xXyFf6EzyHiifw8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EGK0y7afjUov9Ix1YKfPXOXxtjZPFp17S1hhmqU5jV9XARk5IMOuvXtRwCjvdB0oP
	 mCgzYLTFtI0UuiSoIsX8ad0PT35AGINRmdFpWri+jH+vhuex7djSoachl9YxlempuK
	 U4iB1VVrrcWizs5D5iBDSgj/vzMQ3qZGHSgAJLLBSWi0FJIH9pv7Z+A8ImFHJlhBBH
	 IlG/ZvP4o5WzkGJXab1QHu+o8Mv5yoggZ8NZKHqsl/EMH6olHW88LO+QGMpwAdr0u4
	 tiAcW0e+Exr8gBeIjvywcMtLXpvFQ6yXIulxjLLtXV2G+p5WM6c8f/70LhWTFJ+DR2
	 XbhqPP6uVGgpA==
Date: Mon, 7 Sep 2026 15:28:13 -0700
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
Message-ID: <20260907222813.GB1619741@ax162>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
 <20260906181247.GA1148584@ax162>
 <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>

On Sun, Sep 06, 2026 at 12:12:54PM -0700, Dave Hansen wrote:
> On 9/6/26 11:12, Nathan Chancellor wrote:
> > Hmmm, I don't see a warning prior to this patch though. Do you mean that
> > this patch is just revealing the bad behavior that you mention below?
> 
> Yeah, "fixes" was a bad word to use.
> 
> The W^X detection has been broken for a while. The patch you bisected to
> fixes the W^X detection. It doesn't actually cause the issue.

Ah okay, that parses way better. I assume this will be sorted out
without further information needed from me but I am happy to test a
patch when available.

-- 
Cheers,
Nathan
