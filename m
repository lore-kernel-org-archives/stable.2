Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED81346EC8F;
	Fri, 14 Aug 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711290; cv=none; b=G0cOGdz5/NTh0voHuLu4IjiyckL5RFt0WhVLlVFtarVSod6F6elup5LX3Gj/Ihlq/8BVeG2OlKwyjlZwEcZJ9d64WKZ0KZ1QSgyPbIScWln8aSIyeF/wwtVE6fzQ8KPWG4Nyn0fmX5QUtiTNnJsFElzJUXbPC/n8gvcGPLz1Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711290; c=relaxed/simple;
	bh=csj+y7b87J57izW7dshInivp64LxKu4YFyOL3Nz+XhE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GWA74kAuZLjv9hAr6jY/jk13ylLWPl/iMR4ctWgFlA4IG6zDhOXMoYhIkXktCd6SdifnI8L+04MmDjLdddFxdlrc1t4uFzk5dCuXQgJvPiT7MvQzspmVpl+zRLRHgxRwT5mf+bEc0FkB6ncOt8cC70kPnhAk23705hCBiJk2KmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PCLb+bbb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCLb+bbb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E977F1F00ACF;
	Fri, 14 Aug 2026 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711284;
	bh=CDKIlCxcHcHVQcLzlXr/2oBd2JZPxlPkIoB88zc/hVY=;
	h=Date:From:To:Cc:Subject:References;
	b=PCLb+bbbeyz8Xe0mXoEgTeyXO5LEvKutrU5AL/9/qMWnNZrMKya3RTboD9kFZgrey
	 bAZG2KITSUtNRs4IoPqZfDeP2ciyDG5Y/7r1m2XISbVtTd7aFcKhR+TxjvQUfu8SlV
	 flpLxUD+CQCmbOwoji5QFUwqjTqu83/Zk5jzcPq1AebVCeUXnnNGtRBG9FYWFCsNJR
	 SL8TvLTfcElhX9sgrY00KGy4W9Qo5770jj1/uIJG3yqer1Px/baNgm5wNOnOdeZLJw
	 691/Xm1f1mLCz4Ya8J5fTRmBeoLpHA0VTwQy3wO6f/9uSo2SBfWw95e1+j6SK2R/pg
	 b7hpHiVckMMTg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wurEE-00000003zmm-1q5W;
	Fri, 14 Aug 2026 08:41:42 -0400
Message-ID: <20260814124142.300131278@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 14 Aug 2026 08:41:29 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 6/9] ring-buffer: Fix subbuf resize race with
 ring_buffer_alloc_read_page()
References: <20260814124123.133362396@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-6-vdonnefort@google.com
Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index e436793ed5c1..796c10319d6a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7018,7 +7018,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);
-- 
2.53.0


