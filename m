Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610346EC7E;
	Fri, 14 Aug 2026 12:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711288; cv=none; b=S+iAKX6sY+RzJaF+qbxVnu3BBK+DhlDnKeMsrsaUhOiTvH4zFT1TSfpNP6NYpHSzkGtTJ9Xd/luEv1iapzeBNN5+2FMXIJk2L6sIYWluayPgnnf4KuEP+B7yGB3nz66CgAnWriAbB+bDnX0iJAarl8BDxCX/8HAn9gkND+TWXNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711288; c=relaxed/simple;
	bh=JqnHCT32qVO54UOzLmOYNavvaxQn9B1g5DougJpccrw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=tXi/rn1mB3e70GqI8+EPK2S0qsJG3Oh+1KRpvET3aK61B97Kt3pEflsRQsurm+O/yDg6hQH1mVADK7C3J6rUCrXNX3+x/mdS7nhS493bL7OZyTO3wc8hDmqip5BWqJ4rk8cNbyIm8Kd8WBqvnrh5j0bE/IeGUzj/eFR8WuwmwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDtMtLa5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDtMtLa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731B11F00A3F;
	Fri, 14 Aug 2026 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711283;
	bh=1IS8mEyq71qXVERuAbIYDjD6JjBWkULc6LCRV5cXw4Y=;
	h=Date:From:To:Cc:Subject:References;
	b=gDtMtLa5pRig4GZcsDgWPkic3VNmskhhC/8x/dZrjsY0Rk4zflB3ytMNajNSIBHec
	 RG97dlkK1Cos3GvkWBBlyxtOmSk7AIEHHL04km+TLJQfW7uXz35eMteGVDzHCbs78V
	 AGez5d03bX+bgL0tGNpZi/i2FYLGwmrW2SRc7CkoUekYLkKGTJGy3PNXBh6PPWc4Cu
	 0KBNBhfN4pgiXXK6fKq3djt3wRhcfev4gaQW50a4gucSyEeCctWyjf2YSTm4BhRjUO
	 7stLBx+TLFENJToMfT434ZXd70Eq18py9vYS4wZbF8s3xU4UoYdVhLmSvxftnsxnAO
	 GkweoUsfyAd6w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wurED-00000003zlK-41gf;
	Fri, 14 Aug 2026 08:41:41 -0400
Message-ID: <20260814124141.810285258@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 14 Aug 2026 08:41:26 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 3/9] ring-buffer: Hold cpu_buffer::lock when resizing a subbuf
References: <20260814124123.133362396@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Because, ring_buffer_subbuf_order_set() can clear cpu_buffer->free_page,
hold cpu_buffer->lock to prevent races with
ring_buffer_alloc_read_page() and ring_buffer_free_read_page().

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-3-vdonnefort@google.com
Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 73a3fb76ba4d..0479c404db03 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7431,8 +7431,10 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 		cpu_buffer->nr_pages = cpu_buffer->nr_pages_to_update;
 		cpu_buffer->nr_pages_to_update = 0;
 
+		arch_spin_lock(&cpu_buffer->lock);
 		old_free_data_page = cpu_buffer->free_page;
 		cpu_buffer->free_page = NULL;
+		arch_spin_unlock(&cpu_buffer->lock);
 
 		rb_head_page_activate(cpu_buffer);
 
-- 
2.53.0


