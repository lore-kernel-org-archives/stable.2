Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED853D9E8;
	Thu, 15 Oct 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085661; cv=none; b=JWeUGSkNxC6RNAQus1QliKnaj3TJlcgaRts1gRzOLk8JosM5hNiGqNGNxRFQwtXExut8FurLCVRd8PdFyFdJmvViLPqSnT4Mc5pL2kO0+o4ok2W8fpCk9tijrvrksnZnuD3Ktvc5wEktBs6qNvWPJ7ivjdht5kwjxqrNvcMsft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085661; c=relaxed/simple;
	bh=epjlmeoGpijaMuj9xc2qnFeAOdlhiSgRr47ilrUJuMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kjcks3hO9HtXt+E+xrXItbDGMqx0K+e6A/m1gc9e3LgrNOssEn/hBklQwjZW/ATsz9IIq+LP6Pp1kfu2lLy4Ti7VnA+blcuoLReARtzIwmYZlPqZkMsJphFgif/6XLGgVyfzw2aaiN1LYEI0Vy8VekwhpvU9tPaLlltIpGTqJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UiJkGwXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UiJkGwXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1161F000C5;
	Thu, 15 Oct 2026 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792085652;
	bh=6SLE0Fy67GOA2mayZg94htIlK7vPp6C0A4dq0yw0XmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UiJkGwXluuOqrdSZjy62Zr7hB3n+g5I81o2ehLfnOp7+cbkSb4VDKizrwE6s6iJFH
	 pfbY1cjVa2Y8YYd4hGBRhdXFTJKcq045m5kHAMAPij3t1pwt8SvhCSsEB4GzbMpF/P
	 C/me63nagkLM6OF3XHLSxlkFr+AKuMeWGSC4b6uo+PcacNGELU1R1IGSpz8OI0VpW9
	 u9ucmPBFluN0C++mhblbfmSRjT+1uuSYebqEvy6eqhtJDqJRKrFkIA/AkqwF7XYMet
	 558gPskr0K/InX2Jkgy0DMR0bMQJLm8LycPaYk/kWGLR7e7GRxcbiCmxn5i6b7n6TH
	 82h6dRUCnSnbQ==
Date: Thu, 15 Oct 2026 10:34:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>, Jiri
 Pirko <jiri@resnulli.us>, Brad Spengler <spender@grsecurity.net>, PaX Team
 <pageexec@gmail.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org, Yeswanth
 Krishna Tellakula <yeswanth@linux.ibm.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <20261015103410.15ae1b8e@kernel.org>
In-Reply-To: <202610151006.E2F587A60@keescook>
References: <20261015165959.i.798-kees@kernel.org>
	<202610151006.E2F587A60@keescook>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 10:07:06 -0700 Kees Cook wrote:
> geh, for the subject "net" and "net-next" glitch: I've poked my 
> subject-building tooling again, this should be for "net", not
> "net-next"... 

:) Ack. Just missed today's PR but looks like this is 2 releases 
old so not _extremely_ urgent. If you think it is we can also ask
Linus to take it direct
