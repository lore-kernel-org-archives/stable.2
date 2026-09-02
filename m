Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347AA42122E;
	Wed,  2 Sep 2026 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351895; cv=none; b=KqyFhR82tTfqrWC320rCsAXuaDDS+zYPueQEdxOCgeyEpJfeyjMW2j1EX+g2Tbg9lG/nN72hFq691bVOKdbPBI137+j2/r4pMkJteHWKGnT/sc5k+58YeanWhR9RTbNjB45BjWOyuyIMo5tCnZM3trahJaBuJGLZ/YaawGR5exY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351895; c=relaxed/simple;
	bh=ej4p0qa74jnkFOGU5Qewu1Sjfz4nOHxMv+LHJ8EzW14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0JUJlcNIyBEPIg4j+aSrfnRQfKwsuw+Vf9x+TP4Ttpee1g0NRhzlwbVk8dla8s/8gjm+Nvmh6MCTlr9iUDBTPW4gaelcFBxIFge5QbGFQGAG0z0Oqkx3/OIsV4kSxYJlaBwvtT9SGEOMOUMpUvwnHGLC7ZnAOpE23DwWbsIUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=ppkuMep4; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="ppkuMep4"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 38BD3A2D70;
	Wed,  2 Sep 2026 12:24:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 2E8092002C;
	Wed,  2 Sep 2026 12:24:50 +0000 (UTC)
Date: Wed, 2 Sep 2026 08:25:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Jones <lee@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, stable@vger.kernel.org, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260902082550.4644fe91@gandalf.local.home>
In-Reply-To: <20260902082141.00583dfc@gandalf.local.home>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-7-vdonnefort@google.com>
	<20260901123444.GA1350131@google.com>
	<20260901094656.487b278f@gandalf.local.home>
	<20260902082717.GM2943942@google.com>
	<2026090230-entryway-acquaint-d12e@gregkh>
	<20260902095744.GN2943942@google.com>
	<2026090221-riverbank-overlay-704c@gregkh>
	<20260902115944.GS2943942@google.com>
	<20260902082141.00583dfc@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2E8092002C
X-Stat-Signature: 1px7os6pxgffm8pa9bxe3ascm1amsno7
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VmYHVcSK8qCijeiH9Xv0m2nzQycbwqjw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=ej4p0qa74jnkFOGU5Qewu1Sjfz4nOHxMv+LHJ8EzW14=; b=ppkuMep46KNbWgKUxRUeLSRe++AJdx/skL1WVV5WPZZP3EDCjUTyTLrNV5yWEQOGSzHXgxep65E+HiZ7Ss2CioAzIgBsxmXe+x/LyT0+qyRaWMlVlpG2f9nRN0k0Nhp6ZjM7qrAIG6pvmrI/JxNo1dASC8FGVg5f1qxxxaw3t7E=
X-HE-Tag: 1788351890-601368
X-HE-Meta: U2FsdGVkX19pZWjB+gdQpmznQcfOz7UQ49dQknVK5f+wC6C4T3Z6LhYbWrN5JKQSe9fUXtSImFvjMyQlfyq8cjhI2arASpgeSTLWHGogJQfjneOoVTTR2CePGbzN5ihZHrek11h1KHffJseO75ZuudkwEAG4rlOWUsmCgEHKX4eO1V7UZzDg11JN+ESz7N2qQw0GPWWwhPNI/MzLa73ve97IQnzzcGKliUkg6H7ir11538+tq3fJdM+Q4gbWZBFUC6LIFbaa0V5xvKggnoEs2HlzPcaPUkse57T8RC165J6jgS4PcO6nKHusYlGpa4rC/4o5PsVCQmdfJLJoc6KaI+oa3nxsnDE7e1ws+Shg/IPLaia6uzaXS+NF+NdP/XrS

On Wed, 2 Sep 2026 08:21:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> There's even been times that I *removed* a Cc to stable because I did not
> think it was worth the backport. Of course, I still keep the Fixes tag,
> which means it will likely be backported anyway. But that's up to the
> stable maintainers to decide ;-)

The big difference between a commit with the Fixes tag and a Cc to stable
verses one with the Fixes tag without the Cc stable, is that the one with
Cc stable will give me a "FAILED" message if it fails to apply. One with
just the Fixes tag and no Cc stable, will not generate that message to me
if it doesn't apply back to the version with the Fixes commit sha.

I do like to know what I marked as stable and fails to apply. Unfortunately
I don't have the time to go fix them. But I keep them in a mail folder in
case I need to do it one day.

-- Steve
