Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A6847DD59;
	Tue,  1 Sep 2026 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270365; cv=none; b=XdTJjeCYKSE6JZFW1m7MfhpRrXZpaLIp+C6PmmES+wAhvhtIxyQkLol2PCfdcLsIpPaXzJQ3+DmclAxlEG/AvCLhuIk1EizinJzwk6icyBJa6ardwmlwGaNQrAa8BQIcfQMi7zSz4XvixyfTqvbeGj2ChMWbnVq/THQOG9KPZvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270365; c=relaxed/simple;
	bh=kAFvuuukGheivdEdmw/HN6xlOJBO5K16F0p/M3gmzWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWEWTHYBp46+In/VJeea8ZTvtrYsi/t9+hQjMJQKnbboJGeUm9m/aXaQiifbShPhdAoY1zlVhRcPW+fmlXyZVGVFVGa5JaUlGJGJMus1kDfwbZAIjE0/kel5MPG1jdPPIHXvqKOC0o/2NpdVwsMPiMh8QXxFh5kTr+I2an9QGFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=e8M6txiH; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="e8M6txiH"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 73E1C1203CA;
	Tue,  1 Sep 2026 13:46:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 6DFD53D;
	Tue,  1 Sep 2026 13:45:58 +0000 (UTC)
Date: Tue, 1 Sep 2026 09:46:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lee Jones <lee@kernel.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org,
 mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: STABLE REQ: [PATCH v5 06/10] tracing: Fix subbuf resize races
 with trace_pipe_raw readers
Message-ID: <20260901094656.487b278f@gandalf.local.home>
In-Reply-To: <20260901123444.GA1350131@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-7-vdonnefort@google.com>
	<20260901123444.GA1350131@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6cixxhz7mk1bz4du4jppis6dqcjsbk9p
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 6DFD53D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19KsrB+p/7NssIgNppcqCVd9w1v3Yhl4eY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=iKcjZ3sLRRIVaqqwjTkKp2j3OHHZCyYhMdGgyX/hbYU=; b=e8M6txiHxPiPqQRMo8JzLfyqcslbCBckEgAefC8N5+JnOVMzooXIK3bcquqAhPuziNug7x6f/DFujOqmmA+anEkSMTRY7NeXopCHNyvkX2lzlK9cJiUTTQA5C+yiUHDjpnjQlmHRcWJs3gdIwtnzw/8Rm2EnzSNmG1o4DahZ2is=
X-HE-Tag: 1788270358-174686
X-HE-Meta: U2FsdGVkX19DoOGTtXHWSpJJjqv11HmqR7VSgEYz/E+gnbPJCfotHCqyVC3rVg9dyzmjAecBqHH7u7/s6Vw6vMy29PJ3Wcoli/7O5COKcBuVbpRPuZ0vaytpUqT0Wqw+zv8TMgNjM3rQ/EQSC5SrLacP7tdAJkhZsl3tmOk0EtaaPKMIjq14jSCn85OKKUfeeu4uLIf4FEdgXftMZgI87FAHq58V0s65Nt8oDuYohUlQJ5WTGGlqCvczsb7PZrOsfy2YRBhxGXfBYLPxLPy+S2x7BjI1khj+nfVhiGGH/bT+cjUDoQcgmZa7n7/xVc1sjBX6UCTNBjHXA6jmJH4n9HUG7+XwhrLb

On Tue, 1 Sep 2026 13:34:44 +0100
Lee Jones <lee@kernel.org> wrote:

> Could we have this applied to Stable please:
> 
> 8a5f63637890 ("ring-buffer: Fix subbuf resize race with ring buffer readers")

It's marked for stable so it should automatically be backported (if it
applies cleanly). Relax, it was just added last week.

-- Steve
