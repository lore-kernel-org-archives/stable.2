Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31C94B66D2;
	Thu,  3 Sep 2026 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788452009; cv=none; b=AoNVfXakk4KvYqxZnXuYA0x1GD58kZYRJDHhSlvx3LWWxvCgP6ls9O7WReKV9iY4ItLmHuwnuIqHUZVT+cUgJjeXwaToGS7pPsESTUUlcinuq6PUQkDHvpM7jERToGPpXSIz3fszwm6iQtX+X4npSl8fsPQdQyKQ4sSB8YH2jA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788452009; c=relaxed/simple;
	bh=2py9P2IzpDqnVxJhEiRLK5ke9TxPnb74ODFtFCklILo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2pNP+hmGKfrkNQlUsArEFvvu8+faLe0OCl4xpP6fz4yfCGuZZnZqU9F7b4AIHHqPhUS2trsbFTR1tcl1jHWjzZxav2QExN1YLnBnihnQebzzoFBa3z1ixalNJeMbBpxvciRyblFasTG58ZZq0Jn5NRIWZsSKaNcECaHSQhAd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMNDaEXl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMNDaEXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2791F00A3D;
	Thu,  3 Sep 2026 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788452007;
	bh=LCEYAcPt0f1Nu3uSYIZ84TVe2clkjPIhGLMPzYGyrwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WMNDaEXlUUVMOIy9NaeNd/lxVzlaqXP9tPIKrqrFZ43stGaKkUu1dQuLNWIWSdrAp
	 V99KeqjLQualWnLjBtuLxKyrxbneST3ce4+cUMLzbJRqCA81U6p2V0/2aQHnEb+HJM
	 zED0Y3e7BCsph8JK1Msu5ZRWPmdRvTKAIrvrPreuKU+90jZixUehLcR8ViCWH9PiPl
	 cGQdP7WQYIr4ZvPSdUAyTO6mCyU1Fqf6yTH7QCL9g15y54OYlRXq9KakQ4wPN9QTWn
	 byilUl9mRTdYmG1qfnsAeQc4UpQ7CBrqa3Vbqgc3MgVuaaIUO3m7wLbc5+ckrdXLKx
	 17+3VNrY7kI7w==
Date: Thu, 3 Sep 2026 17:13:23 +0100
From: Lee Jones <lee@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers\
Message-ID: <20260903161323.GW2133376@google.com>
References: <20260901123444.GA1350131@google.com>
 <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
 <apk_dQ4Q6msdw_Ub@google.com>
 <20260903123455.GS2133376@google.com>
 <aplrlQbTRxAxMsAF@laps>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aplrlQbTRxAxMsAF@laps>

On Thu, 03 Sep 2026, Sasha Levin wrote:

> On Thu, Sep 03, 2026 at 01:34:55PM +0100, Lee Jones wrote:
> > On Thu, 03 Sep 2026, Vincent Donnefort wrote:
> > 
> > > On Wed, Sep 02, 2026 at 06:14:05PM -0400, Sasha Levin wrote:
> > > > > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > > > > uninitialized memory to userspace due to stale size values.
> > > > >
> > > > > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > > > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > > >
> > > > > Not sure if this is the latest version or not?
> > > > >
> > > > > I see review comments, but no v6.  Anyway, no matter, it'll do.
> > > >
> > > > Queued for 7.2, thanks.
> > > >
> > > > --
> > > > Thanks,
> > > > Sasha
> > > 
> > > This isn't the last version of this patch, I have just posted a v9 [1] and
> > > Steven hasn't reviewed it yet.
> > > 
> > > [1] https://lore.kernel.org/all/20260901155445.1475405-3-vdonnefort@google.com/
> > 
> > The confusion  is mine to own.  I responded to the wrong patch mail, sorry!
> > 
> >  `ring-buffer: Fix subbuf resize race with ring buffer readers`
> > 
> > Which is in Mainline with the immutable SHA 8a5f63637890.  My assumption
> > is that Sasha queued the correct commit or the tools would have
> > complained loudly.
> 
> Indeed, sorry for the confusion! I've queued 8a5f63637890 ("ring-buffer: Fix
> subbuf resize race with ring buffer readers") for 7.2.

Super, thanks bud.

-- 
Lee Jones
