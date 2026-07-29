Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170503E763F;
	Wed, 29 Jul 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336046; cv=none; b=GxwBNrWjy4DRZ1Whl9AQwaEP8437PNbU71mjnlzGlPUCLT25ZJ+qMdfZ5HFb5qfcLWDUKK7bLjHOJiFLbFV5wKMmsJnlE0sS/KJuW0Ar9yc1M9dWBvpMmPUgI2qk+mrDTWiraMGLVTYHQVrVFQj3UywAhFIp2rW0/mlDXyYkeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336046; c=relaxed/simple;
	bh=iC7LSdLV7T1od8xnAA41YHNWP9QOdGmvAAxgkXtGQOA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=og1A/tJRLE5DZnqCAoP5LdP/Jiv+kDtvIRmypVX3cAhkdnqaJE/xljJFo0F0QPTi19g0R24xLrvynyKcXRytZ8D/duMMYb8I3jTYq6KO9jJaV2PCbbBewU572RiGh+XYXs7j2ClBiX4+0u58OxIenGeoiCyChbUD5+TKX9URSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 8F4121A0672;
	Wed, 29 Jul 2026 14:40:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id A1A2A1B;
	Wed, 29 Jul 2026 14:40:38 +0000 (UTC)
Date: Wed, 29 Jul 2026 10:41:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: <bpf@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <song@kernel.org>,
 <jolsa@kernel.org>, <naveen@kernel.org>, <davem@davemloft.net>,
 <mhiramat@kernel.org>, <stable@vger.kernel.org>,
 <linux-open-source@crowdstrike.com>
Subject: Re: [RFC PATCH bpf-next 0/3] ftrace, kprobes, bpf: mark
 trampoline/kprobe ftrace_ops permanent
Message-ID: <20260729104114.04298a48@gandalf.local.home>
In-Reply-To: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A1A2A1B
X-Stat-Signature: 499kyhgzpha8ede91uyypk9psck4c73c
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18XandzLXTa8+ciNlokeOIqor1xPSfBmv0=
X-HE-Tag: 1785336038-944796
X-HE-Meta: U2FsdGVkX1/Q1VMD5PBWVVztUmDRsGyKdjgXyyq8UOEsrvQ4x8MkzXVv1XagktdXZg1hMtLPMbF3NG+14pqvCAulEmETwfclWLYJIdRiZak9IoPT5g5AQigCoGedHitSSmWGanL4HrTJm0lErfH81v8KlhDAZmQZYsgdMsWkNMjy2IJQaC0A2sTvtDwwcdQYm02RzAZu7L41x4P9CEfsnp2T/VfPCN7BNLGDi5y7JeOOHekGj3ZQtSALsU2etuRHhnP5z+yJvx5GFf6Lnxb0tf9dDXZBBVEtiwbg1f1L/hod8IXDzvan3OO3eICs4HYii9aKRI/C0D+DmjpPM54ck9EkdhXVEMsBhzpc5DpAerz3LLWIyijKPpCZ7gXcxIDld4fwbILHnK9sVTCBl1mtdQ==

On Tue, 28 Jul 2026 20:59:56 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> This fixes a long-standing issue: kernel.ftrace_enabled=0 silently
> disables BPF trampolines (fentry/fexit) and ftrace-based
> kprobes/kretprobes. The write succeeds, the hook stops firing with no
> error, and re-enabling silently restores it. Livepatch already solved
> this for itself via FTRACE_OPS_FL_PERMANENT, which refuses to disable
> ftrace while a permanent ops is registered and refuses to register
> one while ftrace is disabled[1].

The /proc/sys/kernel/ftrace_enabled was added as a "safety kill switch"
back when ftrace was first added to the kernel. It's addition was namely
there because live runtime modification of kernel code was new and we were
worried about how stable it could be.

Honestly, I would love to get rid of it as today ftrace has proven to be
rather stable. But as it is a user space ABI, I'm not sure what will break
if we do. I wonder if we just make it a nop, and print a message to dmesg
saying:

  "ftrace_enabled no longer does anything. Please report if you need it to."

?

> 
> For trampolines this restores a historical property: from 2019-2022
> they shared one global direct_ops, marked permanent the same
> way[2].It was later lost as a side effect of the 2022
> per-trampoline-ops split (patch 1's Fixes tag) and never
> restored.[3][4] Kprobes never carried this protection at all, so
> for them that is long-standing issue rather than a regression.
> 
> Patch 1: trampolines. Patch 2: classic kprobes/kretprobes. Patch 3:
> a selftest covering both directions for all four hook types.
> 
> P.S
> I initially implemented a per-record opt-in flag[5], but dropped it
> as over-engineering once I saw the original blanket restriction.
> 
> P.P.S
> Open question: kprobe.multi/kretprobe.multi/kprobe.session
> (fprobe-backed) aren't covered -- return-capturing fprobes share the
> function-graph tracer's subops manager with unrelated tracers, so
> marking it permanent needs a different, per-record approach. Perhaps
> something along the lines of [5].

Honestly, I would like to start deprecating that kill switch.

For the series:

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
