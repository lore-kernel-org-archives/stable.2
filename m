Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3384322E1;
	Wed,  2 Sep 2026 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788343071; cv=none; b=WUDjxzTUl7+b2wnn8OPTNulP8gGhpUm8GMhxuW4aCrZF2OKwBLWiPdTrDecMNNTdjXesPg0zLDrlhh6pt6DzouLB5Qgck6jekVoeOYZDRl67keHu7jnZhbDc/6kedDOGBNxmJJ0+tmsxnLA3qvvvsWjivFbl4zuMl1PI9NIo49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788343071; c=relaxed/simple;
	bh=FmPs1AaC4HTx+4ATgO0Atnqy8ii7miSREtPj7fQifn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLKFuC61S27mepvkLVYyor7lG6WbzMUe5Ry1kBzn5Uo1Ew5J+SH2da0i8dI5QOuffa82LlMF1cb+Dn0+oz7hIT5ujmJ8mosROPXNys5ODplAQSLhhklC93jmS1gHCla8z2sgDQElOzeq/80vkRDYpF6Po+h9CU6Fro/J72SHWaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViFJ1IU2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViFJ1IU2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B53A1F000E9;
	Wed,  2 Sep 2026 09:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788343069;
	bh=q+9hqza9dyhnBNhxd9WKxgckCAvxjsSs3YHiVEje4Jw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ViFJ1IU2hH+2KHfYSGYtdUuc6hr9bUXkkeevJoRiXmLoNI06xgV/lhgRnrzS/tdLE
	 IUOfrv20g1snbWGfh+mCHI2mnejYiVSRR/9nDB3YddowNbAlJPLBFhSryDS4HZUC0A
	 DWbsM+NrjVqyk5nbIxwEmcHuxrGpvQtj/D88MU3+L8RdsGkJBykbujIrqmqLu/2WOH
	 OqeqhfpnmsqbzPs8qvi9zrUd8yWMn8lgGtvttwPMps1l1BSyYxrp4q+nSDeM/UcKGL
	 IRP3bhY6oSgMKVLBdQ0IiMnMdTeKAbLmdb5OG48RWeVDUbQmNJP8FfM9YFOJT8d8ko
	 62UARpYSIbY7w==
Date: Wed, 2 Sep 2026 10:57:44 +0100
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902095744.GN2943942@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
 <2026090230-entryway-acquaint-d12e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026090230-entryway-acquaint-d12e@gregkh>

On Wed, 02 Sep 2026, Greg KH wrote:

> On Wed, Sep 02, 2026 at 09:27:17AM +0100, Lee Jones wrote:
> > On Tue, 01 Sep 2026, Steven Rostedt wrote:
> > 
> > > On Tue, 1 Sep 2026 13:34:44 +0100
> > > Lee Jones <lee@kernel.org> wrote:
> > > 
> > > > Could we have this applied to Stable please:
> > > > 
> > > > 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> > > 
> > > It's marked for stable so it should automatically be backported (if it
> > 
> > Where was it marked for Stable?
> 
> It has:
> 	Cc: stable@vger.kernel.org
> in the patch itself.  It is in my queue to get to, along with over 1000+
> other patches that people decided to tag for stable and yet wait for the
> -rc1 merge window to get to Linus.

Am I losing the plot?  The patch that I replied to [0] did not Cc:
Stable.  If it had, I wouldn't have made the request.

  From: Vincent Donnefort <vdonnefort@google.com>
  To: rostedt@goodmis.org, mhiramat@kernel.org,
  	 linux-trace-kernel@vger.kernel.org
  Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
  	 linux-kernel@vger.kernel.org,
  	Vincent Donnefort <vdonnefort@google.com>
  Subject: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace_pipe_raw readers

  [...]

  Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
  Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

> It will get there eventually...

This wasn't an urgent request or a request to expedite.  Take your time.

[0] https://lore.kernel.org/all/20260813131152.3589632-7-vdonnefort@google.com/

-- 
Lee Jones
