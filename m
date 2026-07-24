Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4D947604A;
	Fri, 24 Jul 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935113; cv=none; b=WdOoN8yyyVkqsswS7lFl+q4n3qGk41iqAwOon860QbmldJqyHhqPDsg1y0qh3bRCruPE5s+uOXQFgqMyDNUFNaTsbA0WyRL1AP8AnCoXnbPxPGlqv3E471chUUX4Dl+I7JxxP9Ay9s3hdbD/nV/GQQSvjaWwCePU1Jk+aCaJUjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935113; c=relaxed/simple;
	bh=Qll+//jgXXadWYprn+QPuI4SCLrd+jSg8/sUJmq5GuQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jmmoR/HwF+Eq7k6dNKwC6RsiTu0CFz4WlbTE1aoP85dILmJJylkZ4UrqmjE3FN1P2Qd4m0UWypXzgDYBYDt7KrRVp9z4uInJo7Z+YKPRUu5nDWLrOuC/hnEDEyTEVVoTHEhE0bSJLCVxsXTGpdULNGYLGAgFAg0ZiDCkYNsp/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AX8SfgNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AX8SfgNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2865D1F00ADF;
	Fri, 24 Jul 2026 23:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935111;
	bh=OJWcsF5hPHMB0NRQDfte1CFKDsA//x9f6tzD+Q9jzVI=;
	h=Date:From:To:Cc:Subject:References;
	b=AX8SfgNG1rrAaMIETZANRwsr079nYaAPaJrbO5Ak6h3NETRENU/oD01qL2uCnvcvm
	 Bi+u35zZMSbbe+2Am3z8ajqiq60N6FZaJWU2iQFtGYRwb5nCi656mmdEVhRuQ8QnnW
	 OOo3qI81NNO5vpQLRLRoyjbjzxE46cEOmOXPp24Mgn0y7bOYL7U51EgNw4LBEbDf8r
	 RD2aDuonIa+y0Q9cC+hYU+CrbCzDDMyVUsCfDnc6JkuAQsz/hi7rX98nEUPllycgJp
	 RGn6zNQVUTLx0lWvDeKspc50LEZ3e4SXA0Zbig5wijPaBBQx4aSEJovqjKVoOjnf4l
	 /WexXL9zMhXEg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAP-000000046vS-06K9;
	Fri, 24 Jul 2026 19:18:57 -0400
Message-ID: <20260724231856.879374418@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [for-linus][PATCH 9/9] tracing: Delay module ref count for "enable_event" trigger
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Triggers are now delayed from freeing, but can still be triggered until
after the RCU grace period has ended. The freeing of the enable_event data
is put into the private_data_free() callback, but the put of the module
refcount is done immediately.

It is possible that if a module is removed that has an event that would
enable (or disable) it is still active, it can read the data of the module
after it is removed causing a use-after-free bug.

Move the trace_event_put_ref() that releases the module into the delayed
callback so that the module can not be removed until any reference to its
events are finished.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260724132415.1b5005db@gandalf.local.home
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260724030523.19081-1-devnexen%40gmail.com
Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_trigger.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 46e60b70a4bb..ad83419cb420 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1726,7 +1726,10 @@ int event_enable_trigger_print(struct seq_file *m,
 
 static void enable_trigger_private_data_free(struct event_trigger_data *data)
 {
-	kfree(data->private_data);
+	struct enable_trigger_data *enable_data = data->private_data;
+
+	trace_event_put_ref(enable_data->file->event_call);
+	kfree(enable_data);
 }
 
 void event_enable_trigger_free(struct event_trigger_data *data)
@@ -1741,7 +1744,6 @@ void event_enable_trigger_free(struct event_trigger_data *data)
 		/* Remove the SOFT_MODE flag */
 		trace_event_enable_disable(enable_data->file, 0, 1);
 		data->private_data_free = enable_trigger_private_data_free;
-		trace_event_put_ref(enable_data->file->event_call);
 		trigger_data_free(data);
 	}
 }
-- 
2.53.0


