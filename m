Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802638;
	b=znkKqUHEN1poBNBC9epOB/DA1k6UwGWTk8rtdxYzcwNJWyjIvM+YsKpSst9wekL7N0L6
	 ctqQ9HzlrAsUe1NylGnM0XY2yiandoAXbSsV9qoctIQvpqeMncUwXAZCQtnlpaw/dWdR8
	 fMBahM1jU+ZJMwlaGF6HPhMl3iD2Ha/f3rmTSwkSzPd7lLqI7e0r2zrT4xznr45yctyHa
	 J92MwfgWonZLmBVLT4ah70fUEFdXqNgabSsdvYfLKYVddaSCdcl15SXokeYHfIGtQgu3C
	 7VENKAaKuQSThMz4gz0v8bWBzgD6tj7ZQ3CHSrcgWDyU75iL4mMU0rg7hwf3XprptpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802638;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=9pWZ3EWTAvBpk0cahRb0lTVvvb814awtr8WKr44+mVA=;
	b=tfAG8lrbTFH9B/at2R9otu376p1MRV71Q7yr2gelf0LEA8a2fDyuukOiYP+YvwMn7K4t
	 o78DUDXcCp5siaMGWDRRwhvEFxrksYZQqrGZ5MlOpDqLc9f+kGAe9oBHhDej6KO07bo/v
	 XA53oqIhGHbvErU2/nOIMPMIqj7ujdbnV5rgzoUP8OjlqQMc0OcU44e9A9ia5a5yAENS/
	 R1W/Gv3vR0fWc91QyNeKyKWgsZN8HOpv4Z4tnpV4nGmjDDTY+B504XDogT3FfsY43uelU
	 LzkXveS5nlhWfBd3yNHn4aucLyBpKMAlXIYYnCgn3SKvxIyXD2ZKhQgtlMNxX9W/U7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kaldtiCF;
	arc=none smtp.remote-ip=216.40.44.17
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE6606A31C;
	Fri, 27 Nov 2026 18:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02FE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=kaldtiCF
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 8EDB4A77F5;
	Fri, 27 Nov 2026 18:03:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id A7BB82000E;
	Fri, 27 Nov 2026 18:03:47 +0000 (UTC)
Date: Fri, 27 Nov 2026 13:03:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jaeyeong Lee <lee@jaeyeong.cc>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing: Reject filter commands in perf function event
 filters
Message-ID: <20261127130346.2caf63af@gandalf.local.home>
In-Reply-To: <20261125060411.445-1-lee@jaeyeong.cc>
References: <20261125060411.445-1-lee@jaeyeong.cc>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: A7BB82000E
X-Stat-Signature: aa3ku49etq5heib8116fmey8957jchin
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19ESAvDAcOS6rFJ3VY0F2ntNB+MKBfNvUw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9pWZ3EWTAvBpk0cahRb0lTVvvb814awtr8WKr44+mVA=; b=kaldtiCFQc6lwivJefi+IYI2OOVftvy9gAcFSinswzJ0jdqAHM099Oyz+uWDPheshnkKK5Uih4yttVPJv4SxBmGRFvRIT3s35DW8CoOYkqcNQACuEHmDHrJGjJTZJIlOHlDjqhDkPJHNaAH6ZwWsXSqovVx/vp1SEOcITxVnME8=
X-HE-Tag: 1795802627-954037
X-HE-Meta: U2FsdGVkX19IbsaVSUwUxngVcYthpSe6DD2fir3oDKhubmjRVl5vCa33k0aM9IerwPuvs5J8rP7CdVH5zwCFxlplNVhZxXZ/xdbho9zlH/nwgyDc5Dvn9dPBZbm/yZe2c5kZ6FIDZFfiuhlEXQBU8kJDkWw1AWOD7bSv5JrWHSVc2kad9nIAEkcrRtnOmkTOcCGIDpTMv5oME+Iqp6Klh/ywoOO33PBnoLOcwGbNJKb9+AWA6KVIHmExfORylHnfTWRvCDxFz4n7vOTnUTdAa+R44BGHmvJyRaZpzVzn1KThqz2rJFdfXCrLnKRZG5QiRn/WIy8C2nPjXKw/q/IfIw3a27Ly8zIZ

On Wed, 25 Nov 2026 06:04:44 +0000
Jaeyeong Lee <lee@jaeyeong.cc> wrote:

> The perf function event (ftrace:function) keeps a CPU number in
> event->ftrace_ops.private: perf_ftrace_function_register() stores
> nr_cpu_ids there, and the TRACE_REG_PERF_ADD/DEL callbacks store
> smp_processor_id() and nr_cpu_ids.
> 
> Since commit 31f505dc7033 ("ftrace: Implement :mod: cache filtering on
> kernel command line"), ftrace_set_regex() treats ops->private as a
> struct trace_array when the pattern contains a ":mod:" command. The
> "ip" filter of a perf function event is passed unchanged to
> ftrace_set_filter() and ftrace_set_notrace(), so a filter such as
> 
>   ip == foo:mod:bar

Hmm, I think this should be allowed to filter only on modules.
Just not cache the module if it doesn't exist.

> 
> makes ftrace_set_regex() use the CPU number as a trace_array pointer.
> When the module is not loaded, ftrace_set_hash() sets
> FTRACE_HASH_FL_MOD on the filter hash of the new perf event, which is
> still NULL. If an earlier pattern in the same filter created the hash
> (for example "ip == vfs_read foo:mod:bar"), cache_mod() then
> dereferences &tr->mod_trace at a small address instead:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000018
>   RIP: 0010:ftrace_set_hash+0x210/0x260
>   Call Trace:
>    ftrace_set_regex+0xc0/0x160
>    ftrace_profile_set_filter+0x24f/0x340
>    _perf_ioctl+0x531/0xb20
>    perf_ioctl+0x42/0x70
>    __x64_sys_ioctl+0x96/0xe0
>    do_syscall_64+0xf9/0x540
> 
>   BUG: kernel NULL pointer dereference, address: 00000000000001f2
>   RIP: 0010:cache_mod+0xb7/0x1f0
>   Call Trace:
>    ftrace_set_regex+0x121/0x160
>    ftrace_profile_set_filter+0x24f/0x340
>    _perf_ioctl+0x531/0xb20
> 
> Perf function filters only take function name patterns, and the perf
> ops has no trace_array to cache module filters in. Reject patterns
> that contain the ':' command separator before they reach
> ftrace_set_regex(). This is the result ftrace_set_regex() already
> returns for such patterns when ops->private is NULL.
> 
> Both crashes were reproduced on v7.4-rc4 (8d7fe9885c62) in QEMU/KVM
> with x86_64_defconfig plus CONFIG_FUNCTION_TRACER, using a test that
> opens ftrace:function with perf_event_open() and sets the filters above
> with PERF_EVENT_IOC_SET_FILTER as root. With this change both filters
> return -EINVAL without a crash, and plain filters such as
> "ip == vfs_read", "ip != vfs_write" and
> "ip == vfs_read || ip == vfs_write" are still accepted.
> 
> This bug was found by static analysis.
> 
> Fixes: 31f505dc7033 ("ftrace: Implement :mod: cache filtering on kernel command line")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jaeyeong Lee <lee@jaeyeong.cc>
> ---
>  kernel/trace/trace_events_filter.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index a9d77df3e..da48210a6 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -2669,6 +2669,9 @@ static int ftrace_function_set_regexp(struct ftrace_ops *ops, int filter,
>  {
>  	int ret;
>  
> +	if (strnchr(re, len, ':'))
> +		return -EINVAL;
> +
>  	if (filter)
>  		ret = ftrace_set_filter(ops, re, len, reset);
>  	else


Does this work to fix the problem?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5b161959e701..6e82941ee2e9 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6808,9 +6808,6 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 
 	/* This can also handle :mod: parsing */
 	if (next) {
-		if (!tr)
-			return -EINVAL;
-
 		command = strsep(&next, ":");
 		if (strcmp(command, "mod") != 0)
 			return -EINVAL;
@@ -6850,8 +6847,15 @@ ftrace_set_regex(struct ftrace_ops *ops, unsigned char *buf, int len,
 int ftrace_set_filter(struct ftrace_ops *ops, unsigned char *buf,
 		       int len, int reset)
 {
+	void *private = ops->private;
+	int ret;
+
 	ftrace_ops_init(ops);
-	return ftrace_set_regex(ops, buf, len, reset, 1);
+	/* ftrace_set_regex expects private to be a trace_array or NULL */
+	ops->private = NULL;
+	ret = ftrace_set_regex(ops, buf, len, reset, 1);
+	ops->private = private;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(ftrace_set_filter);
 

-- Steve
