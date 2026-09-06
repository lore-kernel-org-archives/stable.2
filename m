Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440234252C;
	Sun,  6 Sep 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659154; cv=none; b=ZZcDH4HsDrl4EfkugZ2L9SmvAjb3bobbO0fH4uqkCIcUMczVlIKfdOTSH6mPELh51m4o5h6AsV3n1iaeqtQcIPHHW+AVx7Un+qNFXGixLUooJIP1wi28iMPH4a5SCkJi+/+p+zak+umMQq3fnuBq+Cihb+jobOo6d2LL95OtOao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659154; c=relaxed/simple;
	bh=dNl5RYgoJyRe3BbQR5kcSu6ZiDR5iawJdpnVQzg2V7A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=eFTGRlEBD+1zl1VVD5Yg/zbjsrTVE1P1ovgI/SSE5yKIh4AKoA61dRRSTCvB4QornyJxw+AgfI9W8YtfZfy0GhRoDCbBXDhmcGF78ETU1dQevnwu6w9arNxTYg9r3L0zlLMjXxXaOfApAT0oxlWXSPhIu3EINq76cXgPaMOP8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8kBJ818; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8kBJ818"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB571F00ADE;
	Sun,  6 Sep 2026 01:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659147;
	bh=cxFNKUL2XbhJTz3/Dyo98jS0edW4j43/SQuz71JNgFI=;
	h=Date:From:To:Cc:Subject:References;
	b=Y8kBJ818Zxgz9HFpBwIhJn3WNHWv01j9vZgrvn9pr1o0Yco/ArSXMyvAZBWaGk0vO
	 fyOlhD1hjyNrmNmbqkuDpFSubv8RGJl5MK2c0oj+pMrqWFqeQxBdF0VsaG5q7pTsXQ
	 I1C2sQJD5iZZdO4DCKPAjiYKiszGeLG9NHXU/vNpiBv23hqBDU20gHkyThwqG838t2
	 Gksdvhm8Afr5p2k3DP8KIOaVLCdo6lUkZCbj21ovVka858h0mBd5YueNo7ye7jFiF2
	 ZiKXzAMqBxtFmRVaAqMhrduVZjtoRh8KlW7Bbc0/5+NZCR6uur8xr4exBjVH8246m7
	 z4rBXQrSBeKDA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x31yC-00000006PPd-08OD;
	Sat, 05 Sep 2026 21:46:56 -0400
Message-ID: <20260906014655.890933279@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 21:45:36 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 05/12] ring-buffer: Allow splice reads on static buffers
References: <20260906014531.720267751@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

ring_buffer_read_page() rejects splice (full=1) reads on static buffers
(that is user-mapped, persistent or remote) because !read check assumes
unread pages must be swapped. However for those buffers we have no other
choice than memcpy the data.

For the memcpy case, only return an error when the writer is still on
the reader page for the splice interface to wait.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260901155445.1475405-2-vdonnefort@google.com
Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index b0963ac6fd16..84fd4cdd486f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7193,15 +7193,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 		unsigned int event_size;
 		unsigned int flags = 0;
 
-		/*
-		 * If a full page is expected, this can still be returned
-		 * if there's been a previous partial read and the
-		 * rest of the page can be read and the commit page is off
-		 * the reader page.
-		 */
-		if (full &&
-		    (!read || (len < (size - read)) ||
-		     cpu_buffer->reader_page == cpu_buffer->commit_page))
+		/* If a full page is requested, it cannot be the commit page */
+		if (full && cpu_buffer->reader_page == cpu_buffer->commit_page)
 			return -1;
 
 		if (len > (size - read))
-- 
2.53.0


