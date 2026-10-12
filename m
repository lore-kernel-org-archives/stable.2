Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB39318ED7;
	Mon, 12 Oct 2026 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791784671; cv=none; b=ioVCBJsqPUPvN3vLmMdDeWTujGSlQWuiHpjw/lXlExLuTdtVWfYhVjcEilaMrc+KxsgH57pWt9wGPgz3jMVYACZt7jn7TEcqVTjSHiTbTRbXPXwFrFv1yvwLED+mhcPWe/7RDvhwZbk8xmnXGh56zrVqQ6uj0hmBhgpRDWMKHTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791784671; c=relaxed/simple;
	bh=WN7nf+p7kxzQ+C+blyl1D7z4iLtnAw+tmqdPCP2akJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m3YGwBWIGfO123Haif0LaAHw8el2kffLQQLGeE1poCb/NMgA+WF7oXsy2ae6kktX1Z6pX/KdPPavxp7eG5i/qKXjYRPw9oh7cUC7h1OnckgAcyKVE4JRbW9KYr3/fs150brr27CQ+3MY+ZXYR/ExFNwHdZMVDhgOAlCtgCBeUcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=p2t+mMbt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="p2t+mMbt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1941F0089B;
	Mon, 12 Oct 2026 05:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791784669;
	bh=fqNaSHKbaBtd70ZOA6N6C+BNYVqH/ibRWUuvmgYjVao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=p2t+mMbtBUSLXhudX7Z+BmXCRa5YmWhGAZxjfdQ6+I/CH8EolgF5rsHcL9n3nJymm
	 CZZVGfeYbGQf+vdf42v1KiwBEv7NQd7vdH/mXLvyF7NVw1zkfg0mEkyg6M+wFYZNkx
	 PDf9YE7muMTkgOsM8+LQxsTsS869IrMnsUosEh0s=
Date: Mon, 12 Oct 2026 07:57:47 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
Cc: stable <stable@vger.kernel.org>, sashal <sashal@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"tuan.zhang" <tuan.zhang@amlogic.com>,
	"jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: Requesting CVES to be merged into version 5.15.y
Message-ID: <2026101250-taekwondo-eatery-9d4f@gregkh>
References: <2026101013574578732920@amlogic.com>
 <2026101020-sheep-monetize-afa3@gregkh>
 <2026101210492396062337@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101210492396062337@amlogic.com>

On Mon, Oct 12, 2026 at 10:49:26AM +0800, yao.zhang1@amlogic.com wrote:
> Hi stable team,
> > Here's an example of why this is not in the 5.15.y tree, it does not
> > apply at all.  How did you come up with this very small list of CVEs
> > when there are thousands of "missing" fixes in these older trees?
> 
> > Have you tested this commit to verify it does work properly in the
> > 5.15.y tree?
> 
> > Again, if you wish to see these all applied, please submit the patches
> > that you have backported.
> 
> These CVEs were identified by our customers using third-party scanning tools, 
> and I have verified using `strak` that the patches for these CVEs are indeed
>  missing from the latest 5.15.y release.
> I actually checked the code, and those CVEs aren't there either.

I agree, these commits are not in the tree, and they are not in the tree
as no one has taken the time and effort to do the work to apply them
there.  If you have customers that need these commits/CVEs fixed, great,
please submit working patches that you have tested to resolve these
issues and we will gladly apply them.

> For example: [DEBUG strak] Checking CVE-2025-39797
>                       5.15.222 is vulnerable to CVE-2025-39797
> 
> I have not tested this specific commit on the 5.15.y tree. 
> I would like to know the reason why these CVEs were not merged into 5.15.y.
> Does version 5.15.y not need these CVEs?
> 
> I have a few questions I would appreciate your help answering:
> 1. Can you merge the patches for these critical/high-severity CVEs into the 
>    5.15.y tree?

If someone sends them to us, yes we will.

> 2. If they can be merged, what is the plan? How long would the process take?

Depends on our release cycle / workload, see how long other submitted
patches take to get merged.  All of our work is in public, it shouldn't
be hard to track this.

> 3. If you decide not to merge them, what is the reason?

We will tell you if you submit them for review if there are any problems
with them.

thanks,

greg k-h
