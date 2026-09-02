Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C114A5EB1;
	Wed,  2 Sep 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366172; cv=none; b=E+eeX7pwx6clAdVc3MqbsBgcMlSGcKIktRmvhExhr7hkzQs728K9cXH11tASZrfNWw5eMs2pB/erwYjQUxcEs/ZnYz5N+b44qPDc9uMT8tbbxekEIBWdzX+1RkcqUqAhoz3MRugMwvcPmsseMXeDAzcw0b89euDBIjg5d0hnf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366172; c=relaxed/simple;
	bh=/NSNlk8CYM1sowJ9sGx64hIZA1Z8hypkSJpOPaK89jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlxMzDkLCovV7Q+TB/ZNz/q9gQbBakaHxe237MYohkKEVzPuD5ewrqKtO7jK9gB09vVdq+K50OixST4JlI8nkMB8GMngFYKvIZC63FFwI32fTGurEfJNbjUvlTlkK3rMPfx0TCj79rPBNz+YcFwy3PKeKXH+2LT/kIufbWdNoxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpY6R44M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpY6R44M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589F91F00A3A;
	Wed,  2 Sep 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366171;
	bh=96LuoZFEU9IQ/+SufORbkPGVMLYFD8TLgV1+4zgBKzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GpY6R44MYFIXOoc3IW8hfnqcZ+mFVomt41Q2nPT/kqSu1eQ35GgRx/eo0vtUKetkX
	 0VJdYC9K1OG21cXZ4S4bmMStxzaQKtSmsjOemFtL7VEI5VQA/LOJmdsvUPxlyq8A7s
	 3nBZFqyho1iW9r7Rq7kV8RFYXVMii+HLMIuaQTbyMbVUIhZjhSrIr1gg4PDgg92w+8
	 9tW1t4YlwOqWlL5TsmfABQoQsgQWn0VewNpdGjlXF68PjiCOBW9vFdX4Q+h7arShDg
	 gjPq7OstF0VJSthp5AHi3ppM0Pphg4HX8Q1POaFB4SIEv1ahwf0SQQCjhiRlidwfxr
	 1xPeMH+kVeIEw==
Date: Wed, 2 Sep 2026 17:22:46 +0100
From: Lee Jones <lee@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902162246.GC2133376@google.com>
References: <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
 <2026090230-entryway-acquaint-d12e@gregkh>
 <20260902095744.GN2943942@google.com>
 <2026090221-riverbank-overlay-704c@gregkh>
 <20260902115944.GS2943942@google.com>
 <20260902082141.00583dfc@gandalf.local.home>
 <20260902082550.4644fe91@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082550.4644fe91@gandalf.local.home>

On Wed, 02 Sep 2026, Steven Rostedt wrote:

> On Wed, 2 Sep 2026 08:21:41 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > There's even been times that I *removed* a Cc to stable because I did not
> > think it was worth the backport. Of course, I still keep the Fixes tag,
> > which means it will likely be backported anyway. But that's up to the
> > stable maintainers to decide ;-)

Pretty sure this isn't the case anymore.  RIP AUTOSEL.

> The big difference between a commit with the Fixes tag and a Cc to stable
> verses one with the Fixes tag without the Cc stable, is that the one with
> Cc stable will give me a "FAILED" message if it fails to apply. One with
> just the Fixes tag and no Cc stable, will not generate that message to me
> if it doesn't apply back to the version with the Fixes commit sha.

So what happens when you receive the FAILED message?

And why are you interested to know how far back a fix can be backported?

Personally, I'm _very_ interested in a _small_ number of patches, but
none of which usually emanate from subsystems I maintain.

> I do like to know what I marked as stable and fails to apply. Unfortunately
> I don't have the time to go fix them. But I keep them in a mail folder in
> case I need to do it one day.

We have have such wonderful aspirations.  Maybe we can get around to
those jobs when AI starts doing our jobs for us!  =;-)

-- 
Lee Jones
