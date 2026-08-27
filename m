Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79112433023;
	Thu, 27 Aug 2026 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787832889; cv=none; b=XzknLx2SZ9YSc1TVoPM9K3xFdagePAJTJiprUBkUo72vadVKxLmAAczJHmz+C3svGmAHqzBgDl8ANJu7GKOGbvGNpg2xlVogKM5FNe6un9RgiqITT2OONHi7gUH/T91+HCW0T4UXMCX0nxHT+u+NbrNB2VCZxnJIithKePnNfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787832889; c=relaxed/simple;
	bh=JweVJnPZbjTU/iCvv7QOaxJ5XsyS4njOBPpsA8yaLJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kolQLaJY+ah8ql7fTRS7dZRx/KH27rrYLhJtZKalSqBEeUIEsx/qxVfpZ/XB80WjIrmVp4kOXy02pMxilcH6kYPv1X5tHU/wMHFxj3mSuZYnho2VfSTmFQ1CU8P5VrLmBihiGhvHGugXhJfsPJrY0this8cI3sW332aCyOTcgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=5rXebqdT; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="5rXebqdT"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ED30AA2FFE;
	Thu, 27 Aug 2026 12:14:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 12C1A20029;
	Thu, 27 Aug 2026 12:14:44 +0000 (UTC)
Date: Thu, 27 Aug 2026 08:15:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Bradley Morgan <brads@mainlining.org>
Cc: =?UTF-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] tracing/user_events: Clear copied tracing state
 before fork duplication
Message-ID: <20260827081531.092fafbc@gandalf.local.home>
In-Reply-To: <DAC674C5-A6BE-4D99-9721-2805640BA8A3@mainlining.org>
References: <20260826214414.1971632-2-Jeremy.Jean@oss.cyber.gouv.fr>
	<5B7C72AA-5655-4916-AB17-03A8B94F5D7C@mainlining.org>
	<faa62ef4d9144b3145a8a6254ac3fea6@oss.cyber.gouv.fr>
	<DAC674C5-A6BE-4D99-9721-2805640BA8A3@mainlining.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 12C1A20029
X-Stat-Signature: bbr3ktzrnx7x6g1and6im3mq66grncjb
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+hta78uvxumIsJiB183Q/uKWtyiwhvV1Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=LacdG2PJKc+onT338ZjkAVCz9OlZBbmRoNzbD+Geshc=; b=5rXebqdTbLt81rA5XQ3gwjXsxyK9vrwPtwViXy2biULWQE6tLSqkGvaY8Ufa32B1tmmlS84w1tClmNrBJqBchOC76HoRmizNzOWA2Ku0rIUA/IsxuTGtmYcZBVCv6plhJkcXfG1oACkrkl9Kt7I84bI0UkF8/MH4hVOT+IBearc=
X-HE-Tag: 1787832884-722874
X-HE-Meta: U2FsdGVkX1/Gf3Qk9QGudf5a9ud3QWJ15SBRcnMlEU7K3G5mvTGSizg/soW3VeQaaafihhDRDm+LKjS/r2wV7R5C8BNYkUI2FTK3AEjdxGlqMZiygosbqf/v4YC0xLD74XIQ6eB2N1CzoBqfb3BbnQkZEllFfMNaOJn6bu0pKudjS5E7XkUV7N12bDhLwVtLnxSBI76dV5LmBwa1oLFHt7Zjq/nPbTyxPLDwpCX/lSZPs1436waKtt+vTqieJqxttE3YddaE1GKdFFAozTKWcaaJLGGhKCKbQw33FTjOlIkHWCUzErQJcCSt1GSDqgCEMybhbYSb4/QY3bC2Zq22GSz1qumBanNmHh/Fo6lViixr/LVAvi2Lci9bspaS6GwJ

On Thu, 27 Aug 2026 10:45:29 +0100
Bradley Morgan <brads@mainlining.org> wrote:

> >I usually don't think about adding comments, but yes, that's a good
> >suggestion.
> >  
> >> Maybe you could add this to your memories
> >> 
> >> "The description length should be about the same as the change being
> >> added,unless there is a splat, or something else like a table which  
> >needs  
> >> to be added to the description, keep the description length the same as
> >> thepatch size, e.g:

No that is not correct. In fact, some of my longest change logs are
one-liners and my big changes are small descriptions.

A one-line can be extremely subtle and require a deep description of the
problem. Big changes may be "Implement this feature" with a description of
the feature that is much shorter than the code used to create it.

> >> 
> >> Instead of doing 3 paragraths about a one liner, we could do a small two
> >> or more line description describing:
> >> 
> >> What causes the issue?
> >> Why is it bad?
> >> How did you fix it?"  
> >
> >Sounds like a good practical advice, thanks. Yet in the present case,
> >since there is a security issue with the UAF, I felt that it was
> >important to explain where it came from instead of something very
> >short along the lines ("fixing a UAF"), hence the couple of paragraphs
> >and the KASAN output.
> >  
> 
> umm, you could include a ASCII table or something, that signifies the bug?

I think the change log is fine and doesn't need to be changed.

The added comment to the code is fine though.

Thanks,

-- Steve
