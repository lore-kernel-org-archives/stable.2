Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC68436A363;
	Sat, 10 Oct 2026 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791619495; cv=none; b=GXe4F/i0eQnDK1jQ43DvSpyySOsdczpE8ABkQ+C769CbDkXGFwNm5RrH/S3gzf4jNhiP98AnTMgXHCplybA7AD51E7Q8ti7qPp3dn/u/wVHhzEBzlIqgO/l7m9STcB5QrpK0rv8ClPpPHM6Ykihe+p6nJXjq6VIPWJBTBuHPOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791619495; c=relaxed/simple;
	bh=xq7jx1ZmTWwvUDKu5ybvsIFbIRvBm+hI1QiSweckPYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c7Q6h6SzEH+/C6Qv7SAReLhN6YMEM6lMEuzPGwKbvV1Cjqk3ERN/WvoS1L7CTMhwM4PH3ests+8zRuf+7wkUdiQlQcTmgFD+LxbvhkMmZxUIH7XmPKru895W2kdCSTN+7e8MD9crIyrY4EYGcjtU7FnUWhaaekJJyBS2ojnnDwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cVE4jjeA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cVE4jjeA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE2B1F000FF;
	Sat, 10 Oct 2026 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791619493;
	bh=X6c7IWbKCx+1r9A8VEojattwPTEZ080KS2yZaXfwu6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cVE4jjeAC0zq7xB33TrSAkwvAthc75rN+thyklJYCT9hi3GIzWK+w8GfUdf++apgQ
	 yhMFT1dGVlSkxg5tnp2GlzJduR0wjdhZrxsjPLYgZfM0Gf0knVZ56X7dTDTlqeeCeO
	 DbQ/kJpx684DuM6LJIbsi7hAIKs4SWlGHUkcHnUM=
Date: Sat, 10 Oct 2026 10:04:50 +0200
From: gregkh <gregkh@linuxfoundation.org>
To: "yao.zhang1@amlogic.com" <yao.zhang1@amlogic.com>
Cc: stable <stable@vger.kernel.org>, sashal <sashal@kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	"tuan.zhang" <tuan.zhang@amlogic.com>,
	"jianxin.pan" <jianxin.pan@amlogic.com>
Subject: Re: Requesting CVES to be merged into version 5.15.y
Message-ID: <2026101020-sheep-monetize-afa3@gregkh>
References: <2026101013574578732920@amlogic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026101013574578732920@amlogic.com>

On Sat, Oct 10, 2026 at 03:21:20PM +0800, yao.zhang1@amlogic.com wrote:
> Hi stable team,
> 
> While reviewing the CVE database against the 5.15.y series we run in
> production (currently 5.15.222), we found 27 security fixes that are
> already merged upstream / in newer stable series but are still missing
> from 5.15.y. Per Documentation/process/stable-kernel-rules.rst
> (Option 2), We would like to request that these commits be
> cherry-picked into 5.15.y.
> 
> What is the plan for merging these CVEs into 5.15.y?
> When are they expected to be merged into 5.15.y?

Please feel free to submit these as tested patches that you know work to
these trees.

> Summary: 1 CRITICAL (CVSS 9.3), 21 HIGH, 5 unscored (kernel CVE team
> does not assign CVSS to all records). All commits below exist in
> mainline; none of them (nor an equivalent) is present in v5.15.y.
> 
> Details, one entry per CVE (severity, CVE link, fix commit):
> 
> * CVE-2022-49218 (CVSS 7.1 HIGH, CVE-2022-49218)
>   commit a2151490cc6c57b368d7974ffd447a8b36ade639 upstream
>   "drm/dp: Fix OOB read when handling Post Cursor2 register"
>   already fixed in: 5.17.2, 5.18

Here's an example of why this is not in the 5.15.y tree, it does not
apply at all.  How did you come up with this very small list of CVEs
when there are thousands of "missing" fixes in these older trees?

Have you tested this commit to verify it does work properly in the
5.15.y tree?

Again, if you wish to see these all applied, please submit the patches
that you have backported.

thanks,

greg k-h
