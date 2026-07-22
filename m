Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572A3E8351;
	Wed, 22 Jul 2026 19:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784749891; cv=none; b=clVkC5FD+sWtvPFc0JrpFq3l7uSMkW4NtaQaObDGNJDfonknVv9uvEHfI3QivAFIvmDmPMEIzE7Q842PS/YugOJ87ZDuzYr/t0QyW2IcBMQBiUxn9OBUzlOwBEJ9iPJmiaclQ7vCQ1O90bmJeSt1RlQbEWE3XUjRxAnb/7Y1kgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784749891; c=relaxed/simple;
	bh=Adgb0Rm/h5UzV14Sn8e1t9krNZy52QWnE3NJBniU3cU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=acWWINpQLm0UMo55dmPYXhAoqcbtalAbRNDU1Iq1CLCP2aMLlq3Hd4gkJ7JDgLhsWiwZYIEoHHz4AhpDHg5UiVi98wd2oEmQ3Re+dgz2juaoh5LN1uxX2UQ00Q6imPp27zPPYc2QPanBQdRzfwdDY1yjcS5Xij6dcyYFjgtZJ5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 7A21A40280;
	Wed, 22 Jul 2026 19:51:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id BA33220026;
	Wed, 22 Jul 2026 19:51:18 +0000 (UTC)
Date: Wed, 22 Jul 2026 15:51:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing/inject: Prevent overflow growing string
 fields
Message-ID: <20260722155139.1449664a@gandalf.local.home>
In-Reply-To: <20260722061040.112747-5-liqiang01@kylinos.cn>
References: <20260722061040.112747-1-liqiang01@kylinos.cn>
	<20260722061040.112747-5-liqiang01@kylinos.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: BA33220026
X-Stat-Signature: fjgw9yzrat9krit7bfu84qjbgs3o78p3
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/pb7i+yGAfUb1DHKiw1e/kAiNkk/inguM=
X-HE-Tag: 1784749878-249051
X-HE-Meta: U2FsdGVkX1+bT60etHhnF8qOZ9la854ui/4pHyyg991voFj8qE4/VNJ1SjJUplOkerrmW/NnqnXkXKfJJHtwbMO2nc9LqfkNoI0rqwGArSnKgF/Je6phMwA3Y8wvwvfx2qLko2F//YZxD5nHJ7zK4lrna1hsnZxyNtvyncq1k2QfAjAn+2f4hLHgiHZCDtn9GgFrW0iTmga4cazdl+G5CfNV2ZmBY2utz/raJPQ44IQunlUxdXylmD+DJbUYBVUsI/354kBslSNSrkrPM+iynpwvrIKhW2jkBoCBGGVbIjhmJuc6adD8zl7UaFVMpdX6hDxI4YKjd0LCArmHy/driCFOX2kZql5H

On Wed, 22 Jul 2026 14:10:40 +0800
Li Qiang <liqiang01@kylinos.cn> wrote:

> parse_entry() appends dynamic string data by adding its length to the
> current entry size. An oversized input can overflow this signed addition,
> cause krealloc() to receive too small a length, and then write beyond it.
> 
> Reject a string length that cannot be added to entry_size before growing
> the allocation.
> 
> Fixes: 6c3edaf9fd6a ("tracing: Introduce trace event injection")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> ---
>  kernel/trace/trace_events_inject.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
> index b8b141c00d5c..5c551def44f6 100644
> --- a/kernel/trace/trace_events_inject.c
> +++ b/kernel/trace/trace_events_inject.c
> @@ -243,6 +243,9 @@ static int parse_entry(char *str, struct trace_event_call *call, void **pentry)
>  				int str_loc = entry_size & 0xffff;
>  				u32 *str_item;
>  
> +				if (str_len > INT_MAX - entry_size)
> +					return -E2BIG;

This is just wrong in so many ways that it shows that you don't understand
the code.

-- Steve

> +
>  				entry_size += str_len;
>  				*pentry = krealloc(entry, entry_size, GFP_KERNEL);
>  				if (!*pentry) {

