Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24451353A74;
	Sun,  6 Sep 2026 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659057; cv=none; b=CQ1d9zfLF7bXci54C6Awag7wRIf/G5aWqNOnlQoOyzE3kbI7rNH/PYG9TC8HEaasEk8S8YLuEeDjf8xspUGh+IY5n2CZQXAnK4I4n7xlo2xv5xsla6jI2xyUzKVSRreDttv25nP9wiQ5tYSee5zM+0CAvRin7racmQpqoXZbSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659057; c=relaxed/simple;
	bh=dNl5RYgoJyRe3BbQR5kcSu6ZiDR5iawJdpnVQzg2V7A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lACsxSac5Ui0NIdHZMCGQN+fiZv7FU3aVWBcj9L9lA3HzMDDd4YeE5uWRA14cWRdQWscIvJl+vz9HGqppAiSK2mHmTPLt9hpEq6JqInXFVbE0y0ElX+KQcpzsLknBA/nAXviQ1grB15DfKKodx5s08USXpfarQOE1shDFZevCk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMyF4/cp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMyF4/cp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4731F00A3A;
	Sun,  6 Sep 2026 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659056;
	bh=cxFNKUL2XbhJTz3/Dyo98jS0edW4j43/SQuz71JNgFI=;
	h=Date:From:To:Cc:Subject:References;
	b=nMyF4/cpfXU1oTnhf6rakgBrd09ju0vWYgvxpspdJcEY0kNnvgMoCBvFX7Jueehdo
	 PGB0NbZTtY3xOhERrfcHB5iavOtCpf7HhkJ16HPbk6dSJXVz7NUiKGnFrK21UFD0XY
	 P+ARHh9cjy+xYLjaaV2FuwUt+mQoEuz02IVghsY7/P7Vpjb1NhKaZUDGWdmWxlpwLd
	 TBbes/XH/F0jTRD0b1TkklwaVss7xwcTt7u8EA4IRWEgcYVcjUE53BO5fbgw1DeHmn
	 3Or+7ody3dB/10F6cP+GRgen58ZOnhxDhJ9ZpoJhA2r5HSsX3yc5UJIV0Di6pDz4kT
	 2w+4ZFNFZW3eA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x2whP-00000006JAg-2wWg;
	Sat, 05 Sep 2026 16:09:15 -0400
Message-ID: <20260905200915.553716863@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 16:08:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 05/12] ring-buffer: Allow splice reads on static buffers
References: <20260905200827.773347757@kernel.org>
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


