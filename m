Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49592382281;
	Wed, 29 Jul 2026 17:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785346679; cv=none; b=qn+A7fVCK2A59HFcaBtpZrQ15KHj+eCkD6XQzjWxqDYVeAGdM3/sz3oQFsbvZnwxIEH7rAzbYxgHnXvG5K02+r2aZzSe9V8DNI2du+t5nxRphHr0ptCYQ2V7qcTUL297PvC971sWkmbDtftfMU61MgaEWGnBGYjr6wcz5hAmiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785346679; c=relaxed/simple;
	bh=kMRSqskHIZrtbFWKTm+34eU3QqdSmBHIzkXZaJIAV30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABXrqtHk8eV+BpTHQXdfsXMm57rIHsKuRU4LWvkxqIgzVTSdcZ4nVnBc4+KsOQ/T1FPhY2uht/NQTa6xKofsf45bih3xyYogGgLziJC/+cw4sznuGuJaqO2Tlh7Rr9erlOOHCVvVO4WSfF1bPcG1RcnAXh8/V77gngZC4Gh8TWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1D7621C0FA1;
	Wed, 29 Jul 2026 17:37:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 232CC1B;
	Wed, 29 Jul 2026 17:37:51 +0000 (UTC)
Date: Wed, 29 Jul 2026 13:38:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, song@kernel.org,
 naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
 stable@vger.kernel.org, linux-open-source@crowdstrike.com
Subject: Re: [RFC PATCH bpf-next 3/3] selftests/bpf: add ftrace_permanent
 test
Message-ID: <20260729133826.46c7d049@gandalf.local.home>
In-Reply-To: <CAOu3gNiThogqw_RzEOujeEt3dMqz513ZJdjCDp3nFr3GxvVumA@mail.gmail.com>
References: <20260729005959.3853865-1-andrey.grodzovsky@crowdstrike.com>
	<20260729005959.3853865-4-andrey.grodzovsky@crowdstrike.com>
	<amn-vbX6AitcIcC0@krava>
	<CAOu3gNiThogqw_RzEOujeEt3dMqz513ZJdjCDp3nFr3GxvVumA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: stz9xiecarhnkqnnhw17k1uwtjqhtr1x
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 232CC1B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196tv3Qn/I4MovrL0nmfVF8XnN5xSIjHa4=
X-HE-Tag: 1785346671-787363
X-HE-Meta: U2FsdGVkX1/03ONXSJarh6357eAnWESbpWOcztRtxB+5YLFfs/aHWLoxBd+sWawa2w9M420uuTL1XOCFLcrsf8Dy1r+k0sQdZ9EVssHd58V6BxWHL8h1RTzeUX1ydtMA3RmhwZmPri+ospw+9ngOEP3rZF6KyyfSXuXDP70ud2MRTbDChd56xYxNKnwoQnfYg/h3YCNihGdWG9qLn5/mFd7EFiGN/Ch4224YGTvkDH0NzRZL+WhxSD/xBxu9CIYTU+Hguxcx2YG60PY2wgtPFVL8omk23EVunpVsKiQxase1f1gN5YaCsByXmBytx2OSyAh9Gdr0gMrVd8j8HEc0u1chIj3az2HI

On Wed, 29 Jul 2026 13:16:01 -0400
Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com> wrote:

> Thank you, Jiri. I will address this once the decision on whether to
> proceed with this
> route or, just make ftrace_enabled obsolete, is made.

Note, the ftrace_enabled becoming obsolete *can* be reverted if it breaks
somebody's tool. So still be ready with this patch set.

Also note, I have had success in getting changes that do break user space
by fixing that user space so it's not broken again. But then I have to wait
until all distros (including Debian Stable) have that version of the tool
before I can add the change that broke it.

-- Steve
