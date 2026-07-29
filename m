Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9513A1693;
	Wed, 29 Jul 2026 17:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347593; cv=none; b=pJ3U0lU2vrcM4QwNUr7gz82UBtZ9xO1n5FR2t/LQZHMOoRq2NNMGcX4tPd0EkA0dWbkgk0ALUkE0FZTJNwd2qJ6gdZUfqGs8bhYFeMAnyhTn2XL0Xg+O+id59zFzwSJtl5Gs0PMduMImSY6rAiLiB02GkwF8E56Dre3YhLfZsDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347593; c=relaxed/simple;
	bh=X2qFcRsHCwHj1YWVPTJBxLn0VgM/uHUBg2zmLMndN5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9qB5nS0mRlxCCyOdKvXmIlZubDDWza8pmZ9Aae2NkF9ktN+QIYlS5THsWwsI4bWk4S1tpKSU6qBsYeRRh2QAPipG6WFr5fJ9fj4bzq/4hAe0lrbEL7l6Ms44P+Sf/J2uzMmya8141DKWeka5JhAqGpo/fcJqOdARhHuU6gzehY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 1A51EC06C2;
	Wed, 29 Jul 2026 17:53:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id CA86F8000F;
	Wed, 29 Jul 2026 17:52:59 +0000 (UTC)
Date: Wed, 29 Jul 2026 13:53:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>,
 bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, song@kernel.org, jolsa@kernel.org, naveen@kernel.org,
 davem@davemloft.net, mhiramat@kernel.org, stable@vger.kernel.org,
 linux-open-source@crowdstrike.com, mbenes@suse.cz
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
Message-ID: <20260729135335.2583c8f5@gandalf.local.home>
In-Reply-To: <20260729133232.1e6c79eb@gandalf.local.home>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729104114.04298a48@gandalf.local.home>
	<CAOu3gNgc0XHScgEf+yWF5Kr8sAm8Fsa4RBuwL0YE2EscSiBPrA@mail.gmail.com>
	<20260729113136.32af2a4d@gandalf.local.home>
	<CAHk-=wjzHTuomhTegkD69veDVRxprX8NB=i7A+BEB2-v6v5n+g@mail.gmail.com>
	<20260729133232.1e6c79eb@gandalf.local.home>
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
X-Rspamd-Queue-Id: CA86F8000F
X-Stat-Signature: jme8cjmcjbqwka1jqn8yzo9dui3bnjyi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18YRGlSju6UgRQMOFXLkhBxRNtuOpp1Uu8=
X-HE-Tag: 1785347579-571022
X-HE-Meta: U2FsdGVkX1+Ry7N3Tw+/M+8AbEpuRvf5J2IQfeBkjs9Pp3DoI6xiRsBkunmZUaGoNONmSIG219k6fwVREQzL+7a0qti7jjI7VQQvXm42UstXkJ8/kYhqPjALnDzpiH5z3NzcAsXqy/O7SfYmASOsUxvCX300CGO9vqI6SXhDlFzfVfSsMoqYXsHJq0l2n55KDLtd1iYgvkKhaGFWfg9Y4c4Mm432C1rVspFI8H/OJBRyzxruGKeXCpQk6w+7JmaoKSiz3mmbGViLiq+bnTsBAHZsMUaqaN1ICTFvAfLBX2mWAHfI/OMuRf0Xk+mmMMgkhRHuFBMjbETvC07yWnGLse05Mff72d88uto501E4zlUbK4bCU7YJt5gZ33qN9c7i

On Wed, 29 Jul 2026 13:32:32 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Honestly, I don't know of any tooling that would use this kill-switch or
> any reason to do so. For live kernel patching and for BPF, it doesn't even
> work. Hasn't for some time. It's now a "kill some ftrace but not all".
> 
> Hence, again, the switch itself is rather useless.

Also, since the BPF direct trampolines originally had the PERMANENT flag
set, but due to some code updates lost the flag, and if someone were to
turn off ftrace, it would cause bugs with the BPF programs that were using
it, it makes me feel more confident that nothing is using that file to
disable ftrace.

The bug causing BPF programs being disabled by it has been around since 6.0
and there hasn't been any complaints about those BPF programs breaking. It
makes me think there hasn't been tooling that set ftrace_disabled to zero!

[ Distros now use BPF with ftrace
 cat /sys/kernel/tracing/enabled_functions to see if yours is too
]

-- Steve
