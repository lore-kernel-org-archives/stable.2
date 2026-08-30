Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5113D25B0B9;
	Sun, 30 Aug 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051936; cv=none; b=gwzOocG4c+xsi5A23BF1+orwMC7vCvkII9J8dLbaoJ993/y+zDHnECN4XZmCy4E3d5dVsGn9WOZUq/pPMzYJjfGKYqV/lujC75yOGv8jabFsiqUQnl3+UHdjE9CBDvcwDlLgTdVT2pbIXy2myYQaaLUMT2mKGt5cipDGQua14u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051936; c=relaxed/simple;
	bh=oB+KPR59cFI7eZAa9KgeABPL3A12TJ8BB5uUmES0v8c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=E0nibuOrUQJ/RXnUYY3Oo9MzwIMQLj/qltIwIII49Vv+Ip6qZfbk3xhcTMZElR7OMDtQo+CiVDvlGzbSCPRZ7Nhp929eYatkAJRhDBhque7C2L1j1moqunvEu3gUAxb5XAiqSvKphQNQ2wjruM32ZDgfTm5b1raDe/MGhWoJxh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQFEUehx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQFEUehx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD71F00AC4;
	Sun, 30 Aug 2026 01:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051935;
	bh=iTpNiIj47HKLQsR3btqhyiB6ko64R0R8S6RSN4BlvuE=;
	h=Date:From:To:Cc:Subject:References;
	b=OQFEUehxQLIAwJ8GlGW3M9aMmtbUf+7zh+Q0cW7Kae+fbGmr0rQDq5d0wmMSGfMnV
	 XhfJxjFyn20IAdir+FrZMJJAdfBE9df7K9eHeJTrTxsv6Iuc2HClg1G/LEEW7CP+94
	 421qogtk7KV5pb1EpsXBhJkX2ISWk+O92EpzrkpaZ9gx4J8XvHd7FcP4aN0uFBL/TJ
	 ywPoLErhufIJ67udXRKZOOoqfeYaWIT36jSSPY4NLky1BZKWgPPSqrHOOuMiaohAU0
	 5p/9aERvoIOXhz0nZIgbexYRM7shmY8v6mUxbfmxIHx6RA0lTr5rtrdbwat/dCyYV4
	 ot7BiVl5GXI7Q==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x0U0C-0000000A4A0-1SRo;
	Sat, 29 Aug 2026 21:06:28 -0400
Message-ID: <20260830010628.208350485@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 29 Aug 2026 21:05:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Subject: [for-linus][PATCH 3/3] ring-buffer: Stop remote reader update when page swap fails
References: <20260830010531.847108845@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

The remote swap_reader_page callback can return -EBUSY when the writer
moves the head before the remote catches it, particularly during an event
storm on a small buffer. __rb_get_reader_page_from_remote() currently
warns about that failure but continues with the unchanged reader ID and
rearranges the local page list as though the swap succeeded.

Handle the callback failure as a recoverable error. Report it with
pr_warn_ratelimited() and return NULL. Callers already handle a NULL reader
page as a failed attempt. This avoids splicing the same page as both the
previous and new reader without flooding the log under contention.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Link: https://patch.msgid.link/20260825-kernel-patch-1-v2-2-bb3461807a32@gmail.com
Assisted-by: LLM sparse
Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 5fc009edc1ec..b7d076b6edcf 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5805,8 +5805,11 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
-							  cpu_buffer->remote->priv));
+	if (cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
+						 cpu_buffer->remote->priv)) {
+		pr_warn_ratelimited("Remote reader page swap failed\n");
+		return NULL;
+	}
 	/* nr_pages doesn't include the reader page */
 	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
 		return NULL;
-- 
2.53.0


