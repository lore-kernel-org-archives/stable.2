Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3300730FF30;
	Mon,  6 Jul 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368414; cv=none; b=uVv3HazR2Dfjc/fGIrXSU+5WlsMrEFaQPJCyzEnsQkefLxwQ02Kr+qs8Neq+r/CeXXLOIGu4y4AVIwcK5wNYyuXVJl4CXNnwa89NMxM61gwAdLb5cpzj9jp/Ly/4oMO8Yx3JCUH25RIzDZpMc96tVZG+yfQGJGEYZP0UZ5BjV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368414; c=relaxed/simple;
	bh=7AVWbUDFzRUJVhTXkohpw3uJPblrvDhs4HG1ioyZ6h4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef+qTxpHB6G/U1lDQi8ElDW0Yncuw7k6I4DKIQ0hd6cGxhuayY+GLkHk3NcplXPLnuFoMldmEl8rMzcGXShsaKWabgh0TIUByqe1/dH5i3KoPccoE8hiyjOnYIXOvkXYRe71g/GfI7QJBOLwvmRM/wSf2WejMNC3brMv9PEMQAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id A4E5D401B7;
	Mon,  6 Jul 2026 20:06:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id A3C6320027;
	Mon,  6 Jul 2026 20:06:49 +0000 (UTC)
Date: Mon, 6 Jul 2026 16:06:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: XIAO WU <xiaowu.417@qq.com>, Michael Bommarito
 <michael.bommarito@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in
 user_event_mm_dup()
Message-ID: <20260706160650.2791767d@gandalf.local.home>
In-Reply-To: <20260624200535.GA132-beaub@linux.microsoft.com>
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
	<tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com>
	<20260624200535.GA132-beaub@linux.microsoft.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jagmx5g67n79qqwe4hg8p4mot1adnccp
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: A3C6320027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3E1FLbKrJG6/wP8CcQsT65mdL2TWMCa4=
X-HE-Tag: 1783368409-764143
X-HE-Meta: U2FsdGVkX1+1Zg1Ka6P7PCfxJOi/VD5Z2RuSQFfoV83RT0piOVEjEINuTrGHvk3t3IHWOnpC4Am7NjkjvXgF0vp0k9whefkO+I1o4saxNX/S2/I/0rqjv7Ssm9h+KZmfQ+OXiGsNeJOqQ3wvVKH2isLvCZoaoUiaacYbqZTD2GmLzUO0kWaVNEiHdmVZDnla5UxldEZlq7CvtR6pBcCXvaiIbmaAus+ZHbZM3g/5B+Pq6sjSrea/LI8SdF42vFaCAIjhGAgXaZQppUyiCwVp0jnrO54O9E+Tl9x70i3Gm7d+3qUtFb9Kg6ptKTdNmRrA4mwkFqk5eRT2LqbCpk0Rpb3Xm0iKc3at

On Wed, 24 Jun 2026 20:05:35 +0000
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> While I cannot repro this locally on my 16 core machine, I do agree this
> case needs to be handled correctly. The enabler should keep the ref to
> the user_event until after an RCU grace period. I have this fix that
> addresses it more completely than the original proposal.
> 
> I'm hoping you can try out this fix with your machine that does repro
> the timing window. The below change needs self test fixes, since now the
> free happens after an RCU grace period + work queue schedule. This is
> because the self tests (abi_test and perf_test) assume after unreg the
> last ref is immediate (which was never guaranteed).

I'm taking in the OP patch, but this looks like a separate issue.

Any update on this?

-- Steve
