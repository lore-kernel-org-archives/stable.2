Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709749A3AD
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399830; cv=none; b=WXwKm3G9ng4pL9cjHMqaTMta8zBL9kgQG9o81/x/7q7jWjvRgn2oLnHQaKKSYA+j5y7CB1Cs863RmKB40MNEz5l5sOhJpODijg2R6MfZB4Lo+KxfwfN3eKOfdI8a+3KPMMxoBm6l9jSKoxFsLY9j3RNd2B9Jn9hNtIX6y/VopQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399830; c=relaxed/simple;
	bh=AoJUXfQlpBx9YGpGsuGpag/ce0ATIGMtiM/s3pVkdnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Akc9QBHyvcjBlc0EzC8R+e6T7rzxKRbnoDx3oQRIrZDgEFnJMu/yrUtuK2iG5GHHx8lqk28+q9squYQWxik/0+PBsKPTpPuO3K68XoflL6mOY2emal7Yu987PcAOgW2zE2qABIUbxyCPnJRXigmplL+CuxWHVeBU1MzmxRqD+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=U9S3MVt4; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="U9S3MVt4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1792399818;
	bh=dBoNG0JGnMePtauERpAtLY+t3Q4G4cAZenW9FRJQf5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9S3MVt45f96mA7NfcMSo0Rdojd2gj6gDqzrS5YBCHEv52sDx1TY4y6CK6n0OYdBC
	 AmzzcOxAQk3GMzzC7vS4wLw/5EyHfdeRNoRTnR2TwKwXeEX0NhNWq0U/6A58wPIREP
	 aL4kyG6oyZ48rqBwPTtYjOFnNR6+ncgo+wnw+CcxZc0jLuklMVmh0FKL6sadO1TYWg
	 OjldqlyGz3lCpQGvgJnpvcztdpAf99GRsNV9hCwT7fZSZP46p9wZrHSRlwZFOy2fHv
	 +VA5bWZt3gWSrme7DYe4OQBGkGlfzek0Qdw0my1VRw8SdczFFutU36ifcFlXHo0G50
	 P+qf1THejnxTg==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5298660057;
	Mon, 19 Oct 2026 10:50:18 +0200 (CEST)
Date: Mon, 19 Oct 2026 10:50:14 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	security@kernel.org, Willy Tarreau <w@1wt.eu>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Message-ID: <atXZxmkU9Yrv4h_b@chamomile>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu>
 <179236182769.4914.3317139682579833845@gmail.com>
 <atWvQFXJzJ434qGd@strlen.de>
 <179239012164.14465.16534329674629579851@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179239012164.14465.16534329674629579851@gmail.com>

On Mon, Oct 19, 2026 at 09:08:41AM +0300, Abdifatah Suruur wrote:
> Hi Florian, stable,
> 
> Thanks for the explanation and the Ack.  The explicit memset patch is
> attached with your Acked-by; it applies cleanly to 6.12.113.
> 
> Stable maintainers: would you prefer this minimal init patch or a backport
> of bb061d3de4170741?  Either works from my side.  The memset preserves the
> existing multi-register ABI and is the smaller change; Florian is fine with
> either.
> 
> I will request a CVE via cve@kernel.org once this is queued, per the
> documented process.

Are you requesting a CVE for something that is fixed upstream?
