Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6262D46C85A;
	Wed,  2 Sep 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349143; cv=none; b=fhi4FM63DR6XvglZwxuhywtZbP+wKrKXHONxnQJDM0+Y9cHWLi3dljpgLqw/zKmvKRVwsdCiX+FA2vU4OfDhuUmkEcUKswzbdsrUhfBDzDTlTRb1MK74MuKDkvfLtXjN/nMOQUkIFICDDGvk3CVMxwgS2D3YBb7+5+Sn+eWQW0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349143; c=relaxed/simple;
	bh=sscbjgBnKtUxRsO/x1GczA8xhnfKCQamArGMbzJc1IU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnmZHyoxr3RXW8v0SfPwiArXVOEK1JyiVhV7muE+J1mlEYlFKyt8TrrThsEdJKhKOpoTXz4Q0uvbqY1brRQN2ueJKNp5pao75MwYpaKLwIgQSI/L0hLkovh7HxLon9g8+r3zRBCEGPjTU7LxCeTwyioUzLqG0qV+hQWSdUQJjMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0dv+xi8v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0dv+xi8v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574EF1F00A3A;
	Wed,  2 Sep 2026 11:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788349136;
	bh=MBtJ4SmEKsot9ny2wTAVp4NB/sOooiIro7JQTxtxrBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0dv+xi8vU4nc/DL+Tvqg1/fslvHMIKOmkYAylr6KgmlO5GIJykIn759bhsUAcUfXk
	 fOVNvSzb4OK4t8m3ogAiZ1qURdwdXjVita83Rr0rhiYKxJTiAFOOFURIE9gAtt62GA
	 rNGYMD3sHaxD9X/33pZ6dA7XYfzWkoWpKgzIFGRg=
Date: Wed, 2 Sep 2026 13:38:52 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <2026090221-riverbank-overlay-704c@gregkh>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
 <2026090230-entryway-acquaint-d12e@gregkh>
 <20260902095744.GN2943942@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902095744.GN2943942@google.com>

On Wed, Sep 02, 2026 at 10:57:44AM +0100, Lee Jones wrote:
> On Wed, 02 Sep 2026, Greg KH wrote:
> 
> > On Wed, Sep 02, 2026 at 09:27:17AM +0100, Lee Jones wrote:
> > > On Tue, 01 Sep 2026, Steven Rostedt wrote:
> > > 
> > > > On Tue, 1 Sep 2026 13:34:44 +0100
> > > > Lee Jones <lee@kernel.org> wrote:
> > > > 
> > > > > Could we have this applied to Stable please:
> > > > > 
> > > > > 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> > > > 
> > > > It's marked for stable so it should automatically be backported (if it
> > > 
> > > Where was it marked for Stable?
> > 
> > It has:
> > 	Cc: stable@vger.kernel.org
> > in the patch itself.  It is in my queue to get to, along with over 1000+
> > other patches that people decided to tag for stable and yet wait for the
> > -rc1 merge window to get to Linus.
> 
> Am I losing the plot?  The patch that I replied to [0] did not Cc:
> Stable.  If it had, I wouldn't have made the request.
> 
>   From: Vincent Donnefort <vdonnefort@google.com>
>   To: rostedt@goodmis.org, mhiramat@kernel.org,
>   	 linux-trace-kernel@vger.kernel.org
>   Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
>   	 linux-kernel@vger.kernel.org,
>   	Vincent Donnefort <vdonnefort@google.com>
>   Subject: [PATCH v5 06/10] tracing: Fix subbuf resize races with trace_pipe_raw readers
> 
>   [...]
> 
>   Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
>   Signed-off-by: Vincent Donnefort <vdonnefort@google.com>


I'm lost, I was referring to the above git id that was asked about,
sorry.

> > It will get there eventually...
> 
> This wasn't an urgent request or a request to expedite.  Take your time.

Back to the never-ending-queue...

greg k-h
