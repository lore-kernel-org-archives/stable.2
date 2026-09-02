Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B639FCAE;
	Wed,  2 Sep 2026 08:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788337643; cv=none; b=JjzMMusVDOOo2L2/02GYF76eMROknbTmUlqcAnOgx7doHPpsjKipEO8AXQpORSLhe+rEWj+TzbiKI7H+2QpJ80hv7l7ynU6nE5rWGYpxhepQoRy9ZFAH5vfhuac4j+emk+ZQc3BogCtcaTiAY+0hJfMZSfEWd/bhch9sjPLrBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788337643; c=relaxed/simple;
	bh=hyb/kQxsDHZichJuq48GBlPaPhYSJkRuurkVl4V1ZSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCWH506QvxZ/HcANxnqHQ1Hd7fccpd8ii8bBroJqTGY417hF6vDniychOQmAhUUzfAvyeePPs9gfUvhBjrHipKB5SmzmJJOEw9gs2hzcYZ/ANiSNEQl+QIbycmAPw43zVNs9+wbSP2jEYG8qZBLi4c+EICVLEbhaZq6EZNlzqzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwICb95/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwICb95/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291031F000E9;
	Wed,  2 Sep 2026 08:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788337641;
	bh=DElkAFKuwDMf0MEmdH+MURNISttp5CgJr0ZOt/9hQpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nwICb95/zL6nd6KOs9fyaWwa3+cd4j3R3PkLZkszjOu9Ay17tFRF2KaOVbaLi1jlu
	 Gu0ucW4+booECKcenb3fX7nmKjCRKjTC1HZKvQll4Zh493epu4YIx03yrR9usrO1jV
	 JKao7eOkJg3qMyxupy4DoNI7hGuxc3Z00z8vSR5g2I7VzRT7t8okoMAxPtcjGYoeeH
	 r3nbCWjJeZljULnOmPCFanph0X+8nhPG4RGZ7Y+qZSlX+Gzqn/n8TXVW9zdAyn4p4M
	 azwSTdgUg11O94zrc57H3Z3MUGCNFxrr5R3UG+o273PX+AcKIdO3AIyfaUhJ1d+z13
	 bjF4ajDtn+l8Q==
Date: Wed, 2 Sep 2026 09:27:17 +0100
From: Lee Jones <lee@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
	mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902082717.GM2943942@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
 <20260813131152.3589632-7-vdonnefort@google.com>
 <20260901123444.GA1350131@google.com>
 <20260901094656.487b278f@gandalf.local.home>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901094656.487b278f@gandalf.local.home>

On Tue, 01 Sep 2026, Steven Rostedt wrote:

> On Tue, 1 Sep 2026 13:34:44 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > Could we have this applied to Stable please:
> > 
> > 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")
> 
> It's marked for stable so it should automatically be backported (if it

Where was it marked for Stable?

> applies cleanly). Relax, it was just added last week.

-- 
Lee Jones
