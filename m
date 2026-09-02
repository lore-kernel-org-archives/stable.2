Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F904AC144;
	Wed,  2 Sep 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366751; cv=none; b=InYQDvp0eRn36xuee3tBduWK85yytvgTi8BEPz8WZU9cYWmw8bBzoG/e2R4QvRVgu3xUq4QLFkbWnCiq9oXf/Iij5zXksSle4VylqUXrzSg/mucefpXt/Vvind369ZhWJdzBslWaNbOCO1FVJa0M+OCuHMFQUKZNsfz47DBAbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366751; c=relaxed/simple;
	bh=8Y+hdw5J+4jeHCQ3ZjAa9jZKgYtJZB39NX76XH6Tjpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vFJgi6tB84t6FdptrDFrkTpMIwku3KbYdzKSTIxlQdT56VYpa/ZiY6/gINyUn8GijjpeS+JyweKNwBpcvZIOV+B9mrdz45JMKvHQ9RhEs0sfgtU5bIrJg4vsMCkntiATFODBPIvPttwGz0EJ+4LrkVpo6GqSraqj0ekEGOfAKvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=3FQ79PsV; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="3FQ79PsV"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C35DD80270;
	Wed,  2 Sep 2026 16:32:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 70FD82000F;
	Wed,  2 Sep 2026 16:32:24 +0000 (UTC)
Date: Wed, 2 Sep 2026 12:33:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, stable@vger.kernel.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902123325.615e3934@gandalf.local.home>
In-Reply-To: <20260902162246.GC2133376@google.com>
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
	<20260902162246.GC2133376@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 70FD82000F
X-Stat-Signature: xhzek8shc583kxmcjy49afkbfujfjdmy
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qlQ8r9dHTnG33sEUhMNFcPScyL1vxPhU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=NVLGBeoo3q3+NKK7CjyMqmZGCKYxRL9YGTQcOgb5dbg=; b=3FQ79PsVpvxtZs4NmpStBrQvzyIQQsIRR9z+ALqX62CsNboybg8OSXTLUmMh/i+PfR/lh74d12zxtgfzqHUERzzWgqzXvMywmxozNZuCqnGtS117XO5uIh1u1dvrU3qlYa7J0Q1UB3sQg5H4h/hVziO9dRgfS5AhfOYzsppYNkQ=
X-HE-Tag: 1788366744-878283
X-HE-Meta: U2FsdGVkX1+RRY+tcnEQXT2PKxgptvNOw1hb4PlsGEudPa9vnpzAqfhjlWF30rUxYB+T18dYI+h+G7vfhThsUGLLCAW+oYrEKFzr9LK3kQ2Aev1nWf40y0tquH/pqQz9PCyHVDsqX10kQ3khX2C5TveUKnIbqQ5B9S7hN+gP6DKzOGqLml72y1zNOQuUF5MWnFRk7CHBiiaZbf+JagEyav715jPKk8sAG3s7h1c1LqYxs4hgUgBVq2uq0d3y29szU/PmtcV9v3cUsswpAZaRHjel6sPKPy1gK3Kl2beCk73U/p57HUjVN1VhjWW9ZFqD9I5Uq5aU8x0GR6z/gvoBGYySBjxgqWbZ

On Wed, 2 Sep 2026 17:22:46 +0100
Lee Jones <lee@kernel.org> wrote:

> So what happens when you receive the FAILED message?
> 
> And why are you interested to know how far back a fix can be backported?
> 
> Personally, I'm _very_ interested in a _small_ number of patches, but
> none of which usually emanate from subsystems I maintain.

I'm interested because they only get backported to kernels that are
maintained for some reason. And since these are in my subsystem, I do like
to know that my code works for all supported kernel releases. ;-)

-- Steve
