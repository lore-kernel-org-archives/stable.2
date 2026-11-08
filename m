Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147496;
	b=GwKWqnd948Q1i3CycXenzgp+WBNOyyYDDBStaRTJ19Jcir+daxmnFJFU+/mFf7jQpNjj
	 iF1HXdH8Yf2lNiOyyb5ZQcIlBfpnFUYbm8xlly6aDtbWkAH1xno6PD0ZDb9lg2EMmBkKh
	 2Vz6KkPQae7luobmVurpvSvQsNzDyC08X4HMoriAAFm4PJABbHXdQdx1tOA707AtZjdLg
	 DpmP8JOsyOSqTQxBMNlPpnvF25D+RjdrkMHaOchTMWTbYmGXGzNlLqgwd02KmBuaOXJg3
	 /A7wM382ig3fXvVdSO3BtpibpkCua2ZTPU6SfI+41uhk9CmZ2idvX710iUCw6w82ozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147496;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=abKaeZg/hOITMson77Otqz/eijU8iluUpb9OKmQ2iuQ=;
	b=0qPdAOWoW12OOsMmL4KjF+RefYPyAypb/hmhD8xePcFljUuouanooJbY7ixtJuUoJGJS
	 O8qeKf6IdRa/GFNt+nrnSKu6GPUgUckGdoSUbzQYmY9jj8PqmLuFWhOv7n5A3hrkg59gM
	 Qi7DPpvcRC0ehHgVTAOEY7KG85I85C7GS1CRf/654MsLSPMZZKi2OI6n3pZYwhF6XZnaX
	 3UkDg41JTECOtU1sJ4vxBhZwvLvMqOy50Xg+C21sd7+Le9BDe4T4cCJ/K9SXtGZQZIkVJ
	 eJgbNnJ7S1+g10Dv5jWREsmxJP3RLS7ZhBAiUVBBvjJ57WGH/oYdpMvhCfvioqRkUZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MgyR/A7n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D472606A31C;
	Sun,  8 Nov 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MgyR/A7n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4821F0089F;
	Sun,  8 Nov 2026 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794147496;
	bh=abKaeZg/hOITMson77Otqz/eijU8iluUpb9OKmQ2iuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MgyR/A7n1zd+rhRyP2TYfrRwkCUkPX6G0iQjGGv/tGw96ipTBbV/IvlbNUT+oL2aW
	 mECjBq8twEf6uIt12TQpJAqvUQc4WV0lgn9XrodWKePfYpli0IywDmyzSmmsLV4Gny
	 EfN/YN9AR2ZLEvWcUTwPbYJNe7f+8u2jAwuSNAoDsbJskVWuPMmPVTZlxC1ELmdVm0
	 zKBOQ0qvyJz7fRuMMJKByeW6j1QrrQ60v3s03A+97XaMhW+A7IUeOP8ApM2zxwgD0H
	 FnupU5t8eT9By2tLt6WtoOwDcy4eG8yh77Cn4T8dwckMV113eB2CzL1cE835MRcsWB
	 BP39hIRglbBrg==
Date: Sun, 8 Nov 2026 14:18:12 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on
 byte-limit update
Message-ID: <20261108141812.GA18859@horms.kernel.org>
References: <20261031221052.1642262-1-Jeremy.Jean@oss.cyber.gouv.fr>
 <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179348482309.3286.17799482231932078029@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179348482309.3286.17799482231932078029@kernel.org>

On Sat, Oct 31, 2026 at 10:13:43PM +0000, netdev-bot+sinfo@kernel.org wrote:
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

Hi Jérémy,

I would appreciate it if you could take a moment to respond to
the questions posed by the bot above.
