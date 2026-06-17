Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3772113D53C
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781703966; cv=none; b=NMVUdoDI13h7DcjjIOJyddrePtbQtoDwVMjynKLYUWz4+tgva5Ev9v+J5cora01PvPqAh9xy0p8BaO7QpD0biTruxKwHGQYABzwiKVGU3fPbOm2OJJyrAQBCNd8JvuEyCkpur1JhJQu78qAbThK5pHa6f5XhAdMWoPz7aw8pXpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781703966; c=relaxed/simple;
	bh=soBzkDfVP5l9QPqwRIHU8BeiyDkl8OfYWbIGvLLuB9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRuH2LPItqWl0P3F7k9Qx331rTk+R3q6LfP7KntcjkLAucIZWOrxpKQpK2hTsI8+Q4HnTXQFQOTfqChCgWCFuGmFRplM7ZqUxXRTJU7wKKl88juXD8aiqPw4JRiyJX0ag9Xm5XfCQ2vaYLuzKvnj5g6YpY7RMAyx2E9j+VtLBDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=axybJh57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="axybJh57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34C41F000E9;
	Wed, 17 Jun 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781703964;
	bh=wt8sQsBFtKaL9+ddjigbIPW8SUOk8N9h3GcYASJ5ues=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=axybJh57woBWrWqg9wGrwS8w6meddjZbeJin1DFGHyxfiNMAcjph5Upk3/woJR9Z9
	 1rNOtSXe108JB9D4MNwlVxCIOC0Rmgqh9odEK2+Wi0FBkDeKnwQXpqCGOh5WEwqW2V
	 pYhb+kk/A1pM8bXQzv4PPp9MZkS1/HtE78pS7ldk=
Date: Wed, 17 Jun 2026 19:14:57 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: Vulns DB is missing information for CVE-2026-31456 in 6.12
Message-ID: <2026061712-grievance-enjoyer-3ce1@gregkh>
References: <25098130.ouqheUzb2q@diego>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25098130.ouqheUzb2q@diego>

On Wed, Jun 17, 2026 at 03:29:59PM +0200, Heiko Stübner wrote:
> Hi,
> 
> not sure what is the correct procedure for reporting such things and
> didn't find something in the vulns.git .

Normally just email us at cve@kernel.org but this works for now...

> Fixed in mainline in 7.1-rc1 with commit 9b25a6e3d243 ("mm/pagewalk:
> fix race between concurrent split and refault")
> 
> Seemingly backported to 7.0-rc6 as 3b89863c3fa4 ("mm/pagewalk: fix race
> between concurrent split and refault").
> 
> This fix got backported to 6.12.84 with commit
> 138ada1337b4 ("mm/pagewalk: fix race between concurrent split and
> refault").
> 
> The vulnerability DB is missing that entry for 6.12 though, probably
> due to different commit ids floating around.

Yeah, duplicate ids for the same commit.  I've fixed this up in the repo
and pushed out the new json update, so all should be good, thanks!

greg k-h
