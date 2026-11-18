Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039448;
	b=gtyCONIevq1J/3uh2W+Yt/wcU28DK4AqRWQbT09AYjLlm8HMMo+udUQqFTrH5fnZ5jx/
	 tsH4FIHqId95iXapK6lGzH2JO633PEhzD8lNv51K5L1GKCYe+c0B8U2r+9kJmYMGknWl3
	 IccToBVd1pc4Mo/gbtKFSVq6FQtGdZ0zwFsK/BTLJggMjlD8/NomrTAcWMSW/f46s+1kg
	 iN/uBmM4/2FfPHjpgbsI2BMMswwmZ0hdb5VRzsOpxH5kppvK95GPuYUWY0PnujuHjluSD
	 IlrpvbnT/+bTcGu1Tr/Cps26CBHULORV/cbBx7bdNkoZVmsapq8Rsn3cp3x8oZO6SYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039448;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=F99TcS6GS6LcOdl28JA1aAD6HB54WK+n8tF0clR+7AI=;
	b=AeGrWUQhW/QSj7btltwtyCWHhqg2dVy32rjckHFOMiPa4dv+0Pih8YiP0jSqsIEaRHke
	 qJ5Ix5XS5XMoIjVycVBDF+rhksIIS2eZWHPfEWA/cp0Q1vqqr01xS6vr2/ZW3uMgYDFJ3
	 lJ/4uQ1m8WBAFoz80Xl1VWWMZgrIkzDyOa7/yLPHRv1FWWX3xUivp5ovaIo+k1veueyWV
	 MfOfQfHV54h/5AIvFQCMW2P/KosmMWmvoj7K8MrJIb31Flmxjiq9dfshz2nczUsi/7SV8
	 yRWT7QAy6h6B5GETtQ75mVJXMhHSCH5EJrWoq45OARkzhrkn51AP/SjrEWUyHGYu0RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGgJeIAF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6B606A32F;
	Wed, 18 Nov 2026 22:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MGgJeIAF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58E61F000C6;
	Wed, 18 Nov 2026 22:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039448;
	bh=F99TcS6GS6LcOdl28JA1aAD6HB54WK+n8tF0clR+7AI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MGgJeIAFYJOLUucACRpOikWVSrTX5JBCW6ZfRp6krQF2Ae7+TKTq1JhwKRodhqJrj
	 Cnz06N7E/NljW4ayIMf0ATaGXdF6Wc7w9a2G2C3TCe7wLlxtzTkj5GPE/fjlsdD5s6
	 j9wLTPRxsP6VVTfhko7oAl+gr7DpjQ05wE6QyZ761TOqxLhcGwJhcVvCNpS/OpnC/C
	 FWGkfKNSmJ8R7m67ji0C+5B8hAZFsZoHe2iKONS9G0UZ63GUfbDjEszEydwgXnucQN
	 xnfjgqJw3CkDtl6YYhS49OpBBUkE7JG3WrCQMRU8uzfrsmb4tFTb4PWqK/NHtwm64u
	 RvyFG3AhepxCA==
Message-ID: <4c783bb9-d988-48c3-8849-8ec0c9ea1eb3@kernel.org>
Date: Wed, 18 Nov 2026 23:04:02 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net 7/7] mptcp: fix dummy mapping of overlapping segments
Content-Language: fr
To: netdev-bot+sashiko@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-7-bf7656de653e@kernel.org>
 <179495459243.3136.9349092580555178374@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <179495459243.3136.9349092580555178374@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello,

On 17/11/2026 23:29, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found more severe
> issue(s) in other patches of this series. This mail is only an FYI, in case
> you want to address the nit picks below when you respin.
> 
> Low priority / nit picks for your consideration:

(...)

> Link: https://lore.kernel.org/4c48d016490d43b6892c622cbae858b48f176cff.1794304840.git.tanggeliang@kylinos.cn [1]
> 
>> Author: Geliang Tang <geliang@kernel.org>
> 
> [ ... ]
> 
>> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> 
> [Severity: Low]
> This isn't a bug, but the author address and the address in the author's
> sign-off are different. The author is geliang@kernel.org, and the only
> sign-off from Geliang uses tanggeliang@kylinos.cn. No sign-off uses the
> author address.
> 
> scripts/checkpatch.pl reports this as a FROM_SIGN_OFF_MISMATCH warning
> ("From:/Signed-off-by: email address mismatch"). The names match exactly
> but the addresses do not, and checkpatch does not look at .mailmap.
> 
> .mailmap already maps the two addresses to the same person:
> 
>     Geliang Tang <geliang@kernel.org> <tanggeliang@kylinos.cn>
> 
> So this only affects the consistency of the tags. The DCO itself is not
> in question.
> 
> Since this carries Cc: stable, could the author be set to the kylinos.cn
> address, or the sign-off use geliang@kernel.org (changed or added), before
> the patch is applied?

False positive: the author is tanggeliang@kylinos.cn, see the "From:"
line at the top of the email body. geliang@kernel.org comes from
.mailmap.

This looks like a bug in Clashiko, Sashiko didn't report that.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

