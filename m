Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990047CA80;
	Wed,  2 Sep 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350402; cv=none; b=j++o4+ybGc2tuxH9V6lbgRPopgVB41btOG2ca5aFiXIIZ4d6vk+B1riAM7+0WRIHxfD2IZWKRnWMwRh+n2777rjnjTND9Snsc2UdUrINUoRf9/jKEdYYw0yEgWsVXLyfynEsR9c7irhHuwjGmNWBfv9yTt0yJinx0hsTCcuRd2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350402; c=relaxed/simple;
	bh=kd+Yyc7NYCeNgqH4h5WwvcyPFp8KPW7JVTHUROcl4h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IAkk11q9c9FWtXdjMi7c0buNReBWJ8FDT6j7cji01AkrlSYUj1WgTt8Myeuf2kHr7p2IqEEMo04tMdEyWQWg4zIRpWlKhfckrSVRabSMyphFQ563kFQb5n11x4Wa017b660lS9AloUoIP4VInqVyOQi0IroGUG4pS2M+T9yEjNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai0rW35e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai0rW35e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6EC1F000E9;
	Wed,  2 Sep 2026 11:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788350389;
	bh=+GMRGtPJF0kOjxkPGpdOGJ/QQcsY+spD3Byr8n5Cdoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ai0rW35e84q7etisLcAs5i6HERQJohghziR7l5ol5kcffn5Qoh7e/xvcAQFHAGgVA
	 Ds837SY2DJ8Kd6gXpX3FcjK9T+gRmse6EwTAvKVx/9HoF54ONBIhpeqG4PiTzZt6Yr
	 aKve9vr+z4VMKeVXRZA4x3EcUxekF9sL+9Ax2vdSKSZWJgcJsyKde9IqfYId5PnYJi
	 L/T33YLulOGN82Bh45wOzUkBzc8iD3z9XrlPK9xo370FUzRpokrVBFN9YRN1tng9sg
	 u8fyKUbbzFCEDUQ2ECTDHKu0CIQZ7c9jKD4jC3M+JY1QzzdwCo5kBYhSGlx2kq/6RU
	 UPhlqJc9/0g+g==
Date: Wed, 2 Sep 2026 12:59:44 +0100
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902115944.GS2943942@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
 <2026090230-entryway-acquaint-d12e@gregkh>
 <20260902095744.GN2943942@google.com>
 <2026090221-riverbank-overlay-704c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026090221-riverbank-overlay-704c@gregkh>

On Wed, 02 Sep 2026, Greg KH wrote:

> On Wed, Sep 02, 2026 at 10:57:44AM +0100, Lee Jones wrote:
> > On Wed, 02 Sep 2026, Greg KH wrote:
> > 
> > > On Wed, Sep 02, 2026 at 09:27:17AM +0100, Lee Jones wrote:
> > > > On Tue, 01 Sep 2026, Steven Rostedt wrote:
> > > > 
> > > > > On Tue, 1 Sep 2026 13:34:44 +0100
> > > > > Lee Jones <lee@kernel.org> wrote:
> > > > > 
> > > > > > Could we have this applied to Stable please:
> > > > > > 
> > > > > > 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> > > > > 
> > > > > It's marked for stable so it should automatically be backported (if it
> > > > 
> > > > Where was it marked for Stable?
> > > 
> > > It has:
> > > 	Cc: stable@vger.kernel.org
> > > in the patch itself.  It is in my queue to get to, along with over 1000+
> > > other patches that people decided to tag for stable and yet wait for the
> > > -rc1 merge window to get to Linus.
> > 
> > Am I losing the plot?  The patch that I replied to [0] did not Cc:
> > Stable.  If it had, I wouldn't have made the request.
> > 
> >   From: Vincent Donnefort <vdonnefort@google.com>
> >   To: rostedt@goodmis.org, mhiramat@kernel.org,
> >   	 linux-trace-kernel@vger.kernel.org
> >   Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
> >   	 linux-kernel@vger.kernel.org,
> >   	Vincent Donnefort <vdonnefort@google.com>
> >   Subject: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace_pipe_raw readers
> > 
> >   [...]
> > 
> >   Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
> >   Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> 
> I'm lost, I was referring to the above git id that was asked about,
> sorry.

Ah, so Steven must have added it to the commit on application.

That makes sense now.  As you were!

> > > It will get there eventually...
> > 
> > This wasn't an urgent request or a request to expedite.  Take your time.
> 
> Back to the never-ending-queue...

Enjoy!

-- 
Lee Jones
