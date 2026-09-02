Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5083FE37C;
	Wed,  2 Sep 2026 08:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338788; cv=none; b=PA8/MA2sjku3nZWWQFQ7qjG61trBRYw3xZZac7ZrhttqjP7S1GtL/lCYzGpWlW5lKM6QottHF40uCpRmUyCGGtDsAA91MsY2iO42wUpG84u7S+fcTCkcRz50lzjVI8av6C6hWm7hou8xR9kyyhAlNan3eQ6guZVb5YymUwHXCcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338788; c=relaxed/simple;
	bh=Kqj2t04zKz2PqfF8TBbEtXUtFrjGtXkzpDnL9Bl9TH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qm0GkFPp9Gpxrj761vjJabFkqeETS88wGraEDwfLPeIu6IiiyU3+aMJ04tYYKkFQjYaWp/oeK55kmqWdcDzOPbmAZjgPEiZguXKhoIi0fpkMtnNrkPoFfyc8Ch9V3kC25wDEdjb/5A/94Mz5hIil5QgTorGzCQESw+VbnhxvIQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UWCngEy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UWCngEy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D191F000E9;
	Wed,  2 Sep 2026 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788338786;
	bh=jm82Xc+PocKOGqmwJ7VXG90pOI43KqSjYBu3zdPPKEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=0UWCngEyR3mSjeNNYsZq7jqBIxUMkza4fuRVlKQ8hVkemz/cI06lODws8Fggh5m7m
	 R8lJZZkozApJnkkm/T7r7ba3XseWzOqEG6cp5BJSs1YJ9R7VXKTYTzQ5kz/xnFGtt1
	 ihmV7rHDxvaKzA1mpYtV29UxoQomwOJayKKriOhM=
Date: Wed, 2 Sep 2026 10:44:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Lee Jones <lee@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <2026090230-entryway-acquaint-d12e@gregkh>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
 <20260902082717.GM2943942@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902082717.GM2943942@google.com>

On Wed, Sep 02, 2026 at 09:27:17AM +0100, Lee Jones wrote:
> On Tue, 01 Sep 2026, Steven Rostedt wrote:
> 
> > On Tue, 1 Sep 2026 13:34:44 +0100
> > Lee Jones <lee@kernel.org> wrote:
> > 
> > > Could we have this applied to Stable please:
> > > 
> > > 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> > 
> > It's marked for stable so it should automatically be backported (if it
> 
> Where was it marked for Stable?

It has:
	Cc: stable@vger.kernel.org
in the patch itself.  It is in my queue to get to, along with over 1000+
other patches that people decided to tag for stable and yet wait for the
-rc1 merge window to get to Linus.

It will get there eventually...

thanks,

greg k-h
