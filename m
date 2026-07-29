Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA63CAE74;
	Wed, 29 Jul 2026 19:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354316; cv=none; b=YU5HrGP/gjL9+YtrcMFzgbyC8zrEz95SLKkaF62nZeikq2sNsN8PbKYWq2BKeRc1TKxrT5hKOK1UVUIXpfO8M3rLSimYvu4sm74+xUYFEZeo4CGhlBxDE6KkAupOxaV/oTPTMVJUvTmmJvRFbtmO5yF9fqOshKep/tCQLPO5MIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354316; c=relaxed/simple;
	bh=q0QMEYIX3DpTk/BPL88YP+TA3BY/pFAOafUzxWH8x+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Px5HV3N9B76wsIvfWRAfl1l0v2iF0AJ20Iy51b1gSA8cuMV+7tWheO8hKAJy7OXTdXOeYeWKqrRrpzgxIaZVXUAVceZ4Z5blSwcxoCh16IqFFQB8zPRzKCxagXwQkdvRh5bBw9zue3ly77dgxNsrQmvaN28NvWoq7fHCEA2Th6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C8D7C807BA;
	Wed, 29 Jul 2026 19:45:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 9148F20028;
	Wed, 29 Jul 2026 19:45:05 +0000 (UTC)
Date: Wed, 29 Jul 2026 15:45:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 jolsa@kernel.org, naveen@kernel.org, davem@davemloft.net,
 mhiramat@kernel.org, stable@vger.kernel.org,
 linux-open-source@crowdstrike.com, mbenes@suse.cz
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
Message-ID: <20260729154541.0099cb14@gandalf.local.home>
In-Reply-To: <CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729104114.04298a48@gandalf.local.home>
	<CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
	<20260729113136.32af2a4d@gandalf.local.home>
	<CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
	<20260729133232.1e6c79eb@gandalf.local.home>
	<CAOu3gNg6kNYp-Sc9Eme6yW7Nu7wV6hZ9=CG0eptROfhQ-H8nFA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1ukio9e7iwc1o8rdccxb49rot37qmibf
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 9148F20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pnNwsSkb7pM0sSjczNoXweyWMyth5UjA=
X-HE-Tag: 1785354305-203512
X-HE-Meta: U2FsdGVkX1/AAYdz1BiErrNi+gXHTIdomJvJqKo9jbOfLm7GJBaUANwYhp1/riIuDRdBiiTxjUeMnojXSzKA5m40eW8DXtYtcMbLBCZ/69EUB6+b9ql4IJRCec5+Vb/ZBpgmGJFkgxX5GhISs1nSLdRvWWANhCLYNDjSaeC/HZQvFQOWa6gKYefqZC6N0STZ9TO1vX/goJHo4a3+rPXjvDXVESmgcYM9CF0whBnv0lKBQy/xjtPjqhgs4gt1+7fQ8BfhfTcC63uKdKFizBhn71jj2D44XCZX/0gh4qZggYN3q4Y9nB4oQxgvSJggF3zSjf5GyvBkvw0JZpc1Do8BA9CQphEbPzEO

On Wed, 29 Jul 2026 14:20:17 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Should I also clean up the entire PERMANENT flag logic we now have and
> drop the flag itself?

No, because we may need it in the unlikely case that we need to revert the
disabling of ftrace_enabled code.

After so many years, we can drop that flag if nobody complains.

-- Steve
