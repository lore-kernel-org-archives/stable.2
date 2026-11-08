Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794159285;
	b=XZbKrRxpU3d1tRcNF0vXKssdvNdcOnV5uHsAIeXDmpdADKSkHVQojIpqiRTX/EuG+Z7g
	 cogyYyayZ0TQWbg8R8bWhBWOsiC90dv10LQIYwrDIZjEpWecekcR/FPv2YZNKj6UNypRs
	 pPZYJsnVJYz69+oifjSkM90mZmYdU+wTozQE7Qaj/3AL4gG3/T4DfeFnuAkMVXIUI5KXz
	 5y0ZlqrG5FCX1SPOzRIGI3hyv3G8iIgQzfLRSGH4qr4xjUss3oEQqB10RWuJ+iNI0VY7P
	 pHKVxaNch77k4PJjjDoUU4plcFC4FPCQM/XFcXyOBQKF0vDVQqN8sXUNyJAHAf/zdng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159285;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=h9fN+blWcYiz+Rj05u5EqHcYFX7OMSudCRxrgXVuF4E=;
	b=4MiAb1KKLFRf7mW5wEuBN0k68Q4g/lqK8yiCiSFD5+uGz0XVUYdTCfQeZAHkr1XtQqcM
	 1F3TcFzu6GS0eyGoWZU3TgUCKa0H2uMGobdPBvBEjeoZ249Jw3yJEQr8/PTL9TA8gTHN3
	 F5Sc4icGl79kiZ0tQEu6Qay2WioljitP6rO+JG7NJ3T+izE7ExoNpvSyqKWFRZXphLZcJ
	 Re7cWeCJSXpQFNxDY1sl809nnv22zJppdXulHwyCS57AbmQeZgXnyV1sC9Le5MPdVvQ0X
	 gfBdOpGCKB+g3j7jTTJz8n5SBmh6MxNUB4K+pAhM8MENFfZDek7FCy+aPdXR9lZwEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut7Gg1Hz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0FB606A31C;
	Sun,  8 Nov 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ut7Gg1Hz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9801F0089F;
	Sun,  8 Nov 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794159284;
	bh=h9fN+blWcYiz+Rj05u5EqHcYFX7OMSudCRxrgXVuF4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ut7Gg1Hz2MLSjXtk9vj9PkR85jCxIYPQNx6CUAlxUUQOKbGqQsQN/RuDMseiBzf4d
	 Xqb7ME7/otbljWfqj9/oWrYCTqMGRxNT8oao96QMPHJl/EqqR4OeAsNEUdeaD7a+rA
	 DrLA63k4CSP8qBoFiQtlXA2hLj+y7RIFVUWnmx6RDfOj+RFSB5ttV8A/ZvhsfSy1Ot
	 mpeVtGVlJ5MYktIa10IZLMvUxgK5/imQnqHbPl3OtLsgBaWGQHqskrOng6eNUL4ADX
	 i/B3vA3VIpfL1dib70sc5Ha6WQ5/HrLgFouDo4KZeAJ/wRafbDvIe6FDACVBxDc8WN
	 XpogubVTrYKvg==
Date: Sun, 8 Nov 2026 17:34:40 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is stopped
Message-ID: <20261108173440.GK18859@horms.kernel.org>
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
 <179370062811.488859.14852630470087836565@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179370062811.488859.14852630470087836565@kernel.org>

On Tue, Nov 03, 2026 at 10:10:28AM +0000, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi Wentao,

In my inbox, I count 39 emails of the form above from netdev-bot+sinfo to
you in the past week or so. And zero responses from you. If I miscounted
then I apologise. But in case it is not clear, a response to these messages
is required.

I would appreciate it if you could provided responses to all such messages
for patches which are still active on patchwork.
