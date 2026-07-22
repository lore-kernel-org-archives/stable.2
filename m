Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C7C27F017;
	Wed, 22 Jul 2026 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737919; cv=none; b=abJjSdoorYQoQJDRcPnr59yfj0hCpvporCV1MAJh4uIeImjOU1VnItu62EHGnTRTok4SZcNlVtPhWbQnKKVN79uMrCe0Zq5UCLDJq05gW68lFvQTvnpGyrQG5fH2oy2tMWFSjvKWaAbb7gDne923sMUB+6PmNtRiusKPVO6kB+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737919; c=relaxed/simple;
	bh=+uxGt0oivnldx/IuMlGd2pexbB8hRglpr/tuwBiQGGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WeCJC2uA8Dh6ArUyE1tWIRFIupZpM317/DN8sDzwpvqXmAYA3YdLU2JuADg46WSvUtKpOzlG0DfaN+pY8gNklgOcNuf4CgCpYmFvUQ+bMdhYPGA5shPRb5Yjqai3XwCjTVtQ90FWzjt64gx0Jfgwznw4guKLzGIWy0upCux/8bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 087E4A0256;
	Wed, 22 Jul 2026 16:31:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 60C0520010;
	Wed, 22 Jul 2026 16:31:49 +0000 (UTC)
Date: Wed, 22 Jul 2026 12:32:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] tracing/hist: Prevent overflow in histogram
 expression strings
Message-ID: <20260722123205.75994ca7@gandalf.local.home>
In-Reply-To: <20260722061040.112747-2-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
	<20260722061040.112747-2-liqiang01@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xneuoywgycq7nsgqsmz9d3kgnimkg7bu
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 60C0520010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19D4KMmbQ0ypTucQB57jTCp5qZ2YtZRWrs=
X-HE-Tag: 1784737909-180328
X-HE-Meta: U2FsdGVkX19+xT8QoLO3zQaPvtRXmK700HsPC2BOncGvwUqN0o710CHdXYlL6ktPrqI12iweki46HpXMCrQEXb3ov2dyvG6HK4jsXJ8nvoY5NAkyNAhCTV0P7zvIdfiQyCDjo32u2Wroc+FUnKT7Dl1A/EiJpjCnW/ijiSJ5TSNruNLcL4CLzUMCuqm/do4+/wUDSOSHF7Z81eScmPQ9ovA12OmfAJ6MKWC1w22snOLjwq1XFEMrU6JqC8YWQsw81t3rlPIlLWk9EhnS9lnB+Td7xwIUdMBlWojUIGnAg8WchoWEnzUHW0uyTlADbR1VFzSzvu4M0AybVPdSg+mBaiZfUZhsSqalg/n/iVG2tp9/H4Waa0CpRYIZIA3SuXV9wvGEisRqOF/+0Sz3I/ZJMpo8hbdiTy7oNzzv4QoyoyQRW0+zm6Q0dA==

On Wed, 22 Jul 2026 14:10:37 +0800
Li Qiang <liqiang01@kylinos.cn> wrote:

> expr_str() builds a histogram expression in a fixed-size
> MAX_FILTER_STR_VAL allocation with unbounded strcat() calls.
> Synthetic events permit field names longer than that buffer. Constructing
> a trigger expression can therefore write past the allocation.
> 
> Build the expression with seq_buf. Propagate construction errors to the
> parser and reject strings that overflow the fixed-size buffer with -E2BIG.
> 
> Fixes: 100719dcef44 ("tracing: Add simple expression support to hist triggers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>

This has been fixed by this:

   https://patch.msgid.link/20260611055945.22348-4-pengpeng@iscas.ac.cn

Since it can only be updated by root, I didn't not add a fixes nor a stable
tag and will be sending it in the next merge window (I haven't updated my
linux-next branch, but will soon)

-- Steve
