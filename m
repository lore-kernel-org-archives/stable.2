Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5653976A4;
	Tue,  8 Sep 2026 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859767; cv=none; b=MygOtsZIeSUWQF6Fa7JMbqeWbrCfF2Skz5FE6q3/XCzy7VbQ03M5ExDHLJ/D+uolz3GqpGxmnYSJSaqixm+I6+uG8h06y8TDvXcIlvbvnfXPcda2tO3eh1pbtPRrYNr8KEZMOIhLW10FVSu5yxEKjpncmQfDdjb6CXBZ/XG5HQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859767; c=relaxed/simple;
	bh=8HNlZD5OOlfCDCBlZAW2xYxQOHSMdp4k66DWsewGV94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0mTNDwSJYpwMPIPx0zLXBAxwqm6VN4fqGRzJdENvjWifOXqb5aNuLpMQFiTT/JmWjU/p8MJYnZK5C3c1k5oVBjeU2ZcOFuYtggki3sIIIgkQxlkB5J6Hf8nqimWk5+ZPJtQWeBVDXKGccOQTAmwM6yzcjrBaIiaMfdzzf7ZHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOPRUGZn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOPRUGZn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6634B1F00A3A;
	Tue,  8 Sep 2026 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859765;
	bh=RLTmU7D9Vs9PNyIcNWfktfyTvD6dwfvTPEO7+SNJnX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOPRUGZn9Bly6FkfQSiA/GvEVLzJ9C2QF3nx9tlTtt399Af1tpdSdgxQnyOJDb0IB
	 ejbirfKdG1lswNYDvvqB8fl3vMmvQ88HrOCqEKU07Xwgl+lJw7FBNk5VIBJ6dy0ihE
	 /oGz8BoROlw8J9fG3duISQRiQXdMIWPvhzpYQTcGNPJJXoOr5qYnRbCGaGt/JE488R
	 ShNc0UOLgZ5oKv5tELsk8fEqaI8/qLhyx3dKCVO8WpTuE9JUbupGZkuIFX1w9RiItr
	 6qHNWcDA+QlU02J6IYBCWIdDvA4Lz6itFTVyQA5Nce7KMg49AFpKqs8H9mtopqav8h
	 M+/U07s2J2LQg==
Date: Tue, 8 Sep 2026 12:29:17 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-tip-commits@vger.kernel.org, Juergen Gross <jgross@suse.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	syzbot@syzkaller.appspotmail.com, Atish Patra <atishp@meta.com>,
	Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [tip: x86/urgent] x86/mm/pat: Fix effective RW computation in
 lookup_address_in_pgd_attr()
Message-ID: <ap_VbQE97wgy9iZO@kernel.org>
References: <20260813-cpa-fixes-v2-5-39b4ff90f91d@kernel.org>
 <178837401172.3717435.314324339347590321.tip-bot2@tip-bot2>
 <20260905044253.GA3816371@ax162>
 <b3fe6376-bd3f-4c58-8698-abcca3ad7186@intel.com>
 <20260906181247.GA1148584@ax162>
 <1987b7d6-7aa3-4bcd-9082-f2cdfde7c1e4@intel.com>
 <20260907222813.GB1619741@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907222813.GB1619741@ax162>

Hi Nathan,

On Mon, Sep 07, 2026 at 03:28:13PM -0700, Nathan Chancellor wrote:
> On Sun, Sep 06, 2026 at 12:12:54PM -0700, Dave Hansen wrote:
> > On 9/6/26 11:12, Nathan Chancellor wrote:
> > > Hmmm, I don't see a warning prior to this patch though. Do you mean that
> > > this patch is just revealing the bad behavior that you mention below?
> > 
> > Yeah, "fixes" was a bad word to use.
> > 
> > The W^X detection has been broken for a while. The patch you bisected to
> > fixes the W^X detection. It doesn't actually cause the issue.
> 
> Ah okay, that parses way better. I assume this will be sorted out
> without further information needed from me but I am happy to test a
> patch when available.

Here:

https://lore.kernel.org/all/20260908092730.4002628-1-rppt@kernel.org/T/#u
 
> -- 
> Cheers,
> Nathan

-- 
Sincerely yours,
Mike.
