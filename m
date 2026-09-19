Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12980547041;
	Sat, 19 Sep 2026 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789852838; cv=none; b=YYlXUWDCa+RM3vpTcl9EiZrsr5QC0xN/DkD3/DaLxTcpOnk92BfSSj+vY3WTyEOocWhIId0LgZCXDyEMyo7XLYBUl2ReVQEuuBugmPA3CFIMKqDksr4f1xl3fHQPAvba1ouyXB0oc+SZiZxL3EhAyQvfLCpkJOxnCzTEV74Zp6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789852838; c=relaxed/simple;
	bh=QSYCpy6aGg/XfwkSF+LhfAxFm+Ju/6PLbQnktNFBfbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Duk9L/tTCjFcqUUsWMnYuBM/Tsi+X3CaSwCl8G9D+sh6b1f21HHRDXKNe7oBhazMctPsvLqDxnPmpskri3/u2ZuLxD214wK/IVO241TLVdLp8Oxv4Y0PdcYH1onDqi4UlrAXIYmrk8cWiAYrN1fVkPa6UIIRQnMhBmND7dyS+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2NwDFqP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2NwDFqP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB841F000FF;
	Sat, 19 Sep 2026 21:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789852836;
	bh=WWRhvzt1bxKb4a4PKfjNZNSEMlhwEztRWLoE+Q+ZkgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E2NwDFqP9gHk6Fh20z8ijN4A580Sn4bSZTVQN+tDavInvxBVVWfXSv2XewqdfuLNp
	 PuQ/mJaGkCaFRRDChNlSgKnTbzeytJrzQUmw2n28W3YkEV3ZT47/jcf6+H8wVVIxwI
	 KmaaWOGe5xgQSKr/lqoOG8bzoXI9JHS7XUGqVteGEGIk37Ds0jltOGTMJe/kE0DPxw
	 W4e/43u6r161OREP0iB4M3f0t3VRwp6hy44bY5USTxO85YSPIrPzuT5w8YiKRzo7Qp
	 vLthtABFUKMym4tljuUY0khHNNixgy3jTzCG/NvEYhy4bikknE+B7ZUHTdT4zbl0FU
	 NdC+U2e4DErNA==
Date: Sat, 19 Sep 2026 14:20:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, Willem de Bruijn
 <willemb@google.com>, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuni1840@gmail.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <20260919142035.4d0e11a8@kernel.org>
In-Reply-To: <aq28mdNpi3ssjgXz@v4bel>
References: <20260904033543.2635540-1-kuniyu@google.com>
	<aq28mdNpi3ssjgXz@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 07:35:05 +0900 Hyunwoo Kim wrote:
> >   Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")  
> 
> Hi netdev maintainers,
> 
> What is the plan for stable backports here? Does the uapi change rule
> this series out for stable?

Not super well defined to be completely honest.
My gut feeling is that we should wait for it to reach Linus, and ~rc3
then pull it to LTS. Which would mean 2 months from now (mid Nov).

That said, I am personally pretty unbothered about local exploits.
There's too many of them. And because of the serious exploits
(remote, VM escape etc) I think people are not deploying stable
much more rapidly and with less testing. I don't want to inject 
a de-feature under such condition.

Adding Greg and stable in case they have a stronger stomach.

Also FWIW I believe that Eric D is AFK at the moment, and he's the only
netdev maintainer subscribed to security@, AFAIU, so y'all may be aware
of more things than I am...
