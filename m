Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A6142DA3D;
	Thu,  3 Sep 2026 08:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424720; cv=none; b=JL7UAdHlikfwdD0BA9R7Rf+y0Lap7aRHGQ2eSY1s82ZhgzI+Jn7GSX4kPceGdXMIo4CtPYG99yaG/p+1h4ZM60ZRNCGXFQ+9wjFbqlzTFfyQYX446ierSSYQ95D0lqFqDySruXGn7xo0Ukf1VSrZ0hEMN4j6txzdASaZp+8BTHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424720; c=relaxed/simple;
	bh=MpkGd3Wq9g0clpSZ0PtgNlSw09+OWGS17sCRuiBABsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/Nl3saAT6VDVyXeplOaUpD9vuyZl6chO4t8Cw0LBHgFRvU8GppFTnGpGTQ8eh9glAb2zhTkcjx6aYvkNPQk/+7tpGWI5WLDD2xqJYTCWlsPU0WD04wX7VnSrN8hjdqRJZDfS8BKfy0834lxFMgsRd4vJZnNWRi+xtFtjM4kaps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jslV3LkW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jslV3LkW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7981F00A3A;
	Thu,  3 Sep 2026 08:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788424719;
	bh=62T38dYAlVZeyw20TJ22LXgeeZg8s/iaCz4GUJ6sgBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jslV3LkWqAecm6log/JYiuGF/LSipT74D2SqNFLafBB8aNxhMSC6os3vDEhaU4TxC
	 0zHl3WK6lBWgj8GVXKDM3NosfcArzMu35vIJSogFbg+Ezrp25y1WeENxsuFHDwEeGZ
	 FhVlzIHXHVAc5VarqPPoa5KWuw9vVWrkijL/bf90JPjGgvxNUcGkiCAEWSgN2bUluQ
	 44/nsY3LVM8TBAEJEjy5IPxaIoM4qMLtLPv81Dy6liclte+56WP8Be6wnbcKX5WZXu
	 EwMHE9TdteyhT1AldKn4ZAXUSr7238tscuBfJBEv03nElWaGH3rVmILME/PlPeKalE
	 6uMUIt7z60bfA==
Date: Thu, 3 Sep 2026 09:38:34 +0100
From: Lee Jones <lee@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260903083834.GE2133376@google.com>
References: <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
 <2026090230-entryway-acquaint-d12e@gregkh>
 <20260902095744.GN2943942@google.com>
 <2026090221-riverbank-overlay-704c@gregkh>
 <20260902115944.GS2943942@google.com>
 <20260902082141.00583dfc@gandalf.local.home>
 <20260902082550.4644fe91@gandalf.local.home>
 <20260902162246.GC2133376@google.com>
 <20260902123325.615e3934@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902123325.615e3934@gandalf.local.home>

On Wed, 02 Sep 2026, Steven Rostedt wrote:

> On Wed, 2 Sep 2026 17:22:46 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > So what happens when you receive the FAILED message?
> > 
> > And why are you interested to know how far back a fix can be backported?
> > 
> > Personally, I'm _very_ interested in a _small_ number of patches, but
> > none of which usually emanate from subsystems I maintain.
> 
> I'm interested because they only get backported to kernels that are
> maintained for some reason. And since these are in my subsystem, I do like
> to know that my code works for all supported kernel releases. ;-)

Well that's unusually conscientious of you.  I like it.  =:-)

NB: Not that _you_ are unconscientious - I was referring to the rest of us!

-- 
Lee Jones
