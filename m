Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FCC37E5CD;
	Thu,  3 Sep 2026 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438901; cv=none; b=jc5+jplzhd5EkbWIODbCfo9APA7SC6GmEY2KIIP5vdcgB6AnjYc4LrchRImkOHYsRYCiflveMcuWJ71Jc68E+5wRHVJGpal9H2pUeXTHP998ky6qcNoTrpmnnUk2PkIB95TIYtBwBWHCU1iKGHaVHSEUS/4TJ/U4r3DVpyjYhG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438901; c=relaxed/simple;
	bh=fuBAGqqUDOqetB2V/lzjUNoB/11ynai98RY5zv5kmM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzNNw+U9AGK4HJFF26YLFQ5u+P3v/x8CS7deWC4gyXIt0gIen13P9I2CL8kct7S5dbmXNOh9Mzl7Xyqxl/tcRYXfzmDM5yGH+TjFk+9aMzkPA9S59HhA73/YsAUDxv2rV1xx+lJMFOGtoZaodCn/KkEWvCVPVVLr0vZkjXnizdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvHP23vb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvHP23vb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C671F000E9;
	Thu,  3 Sep 2026 12:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438900;
	bh=LkHyojIiqDTwswEf0pCBO7d+LqykZSReJx6ZH4c8vlY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hvHP23vbG9IiqSRn4lxC6hbe1z2w6jX7yKRajvDm8CYyw7qtAzs2GKMuoeulyrCZD
	 50CrgXsfTLYRZ0/Xh5DGU6Ts9RyXEOuzdwzxISxdXgP4ibYzaJJCQm74BP2bG3zBis
	 FMPWBib8khhEm4efo00Bly60KuFlugbnp99YtmqRqJh1nHtFCw80pVk3TGGWCsnkod
	 ncvG3tQjzaZfF0RgHXrg2urDhQoV9IIHJFnuKJz8eh7g2NSEyvFa8yNHpDrvqiP4Yg
	 52fMOU8q/ZYpTb5ssWQYYxvW3zsexK51HIpEXal4IhBKTin2nOQFMX5ax4wZrS8F8V
	 xDXeF39Z42zgw==
Date: Thu, 3 Sep 2026 13:34:55 +0100
From: Lee Jones <lee@kernel.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260903123455.GS2133376@google.com>
References: <20260901123444.GA1350131@google.com>
 <20260902-daily-reply-0006-tracing-subbuf-resize-7-2@kernel.org>
 <apk_dQ4Q6msdw_Ub@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apk_dQ4Q6msdw_Ub@google.com>

On Thu, 03 Sep 2026, Vincent Donnefort wrote:

> On Wed, Sep 02, 2026 at 06:14:05PM -0400, Sasha Levin wrote:
> > > Concurrent subbuffer resizes may crash trace_pipe_raw readers or leak
> > > uninitialized memory to userspace due to stale size values.
> > >
> > > Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > >
> > > Not sure if this is the latest version or not?
> > >
> > > I see review comments, but no v6.  Anyway, no matter, it'll do.
> > 
> > Queued for 7.2, thanks.
> > 
> > -- 
> > Thanks,
> > Sasha
> 
> This isn't the last version of this patch, I have just posted a v9 [1] and
> Steven hasn't reviewed it yet.
> 
> [1] https://lore.kernel.org/all/20260901155445.1475405-3-vdonnefort@google.com/

The confusion  is mine to own.  I responded to the wrong patch mail, sorry!

  `ring-buffer: Fix subbuf resize race with ring buffer readers`

Which is in Mainline with the immutable SHA 8a5f63637890.  My assumption
is that Sasha queued the correct commit or the tools would have
complained loudly.

-- 
Lee Jones
