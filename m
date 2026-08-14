Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB346D56E;
	Fri, 14 Aug 2026 12:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711286; cv=none; b=uFX9WJTqhNtPWr/OdCzLj7kPGUlynvbJEaVm8QQk6ViBcVu/XOiCzuNC140PS2eZkPIznr3lghgj1lH3emSWRB47WdEns0jgiNoofFjCoBkjADT27d72otx9xzroKmJa9sXIqccrf+LzMwKNlvOwhLLpwrUsdG34J/iWuP2DXMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711286; c=relaxed/simple;
	bh=irBzJJwuizB5llBUNRGRfgTfreGG25e4zpVM41V/KoM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JBXmPn0F13jiRQ0SElqQxq6/2lJAClWDWt14oAlRaSm1pGtoiQBmOt0H9sSLZ/5z/CPZbrtkhna+LHWsGaqkGBuB5vWIKVg0GR3GyH7nt+tJocxR02pWy3DpJ+0wb0uSVCpaWFEUmnQsX1CW9mtePKYPmrkqhPBEDgjFAN4jAvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iO3uvMjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iO3uvMjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635421F00A3E;
	Fri, 14 Aug 2026 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786711283;
	bh=HVIyGtmoblTtKrNCRMfjG2EbdcAfwJE+kvr8q/m1VOM=;
	h=Date:From:To:Cc:Subject:References;
	b=iO3uvMjt8AP1EspC3BBiqNwh/lTRUJbFhgbM4CbdX0EgOXIubSdP+hwHdqKHr67dZ
	 2BnD7dWNMMG21i7byxyqiSAAmu+ckkESoEiPzWq1l+8ei0v3/xfEaxhjoVhh9tAqVf
	 Ws1+rLHt1xbOLKtzJHPTmliaBM6bs/mvc8D6bmbV4rHSvuE5DZ62vrdjWiklSa+Jwe
	 G+3t8vmeDTE197Ab4EkrF1P6vc1u7JY31WJzfqKkAPN5XQhBZ75FRrU/VINYjeRF6v
	 0UVwoFtkGSkRLsiPy13zGkhiITbGRlskdm6j0sPf4JIaPPmA3XUyfuSGVFS4PoyKX7
	 YucZcEdOD8mrA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wurED-00000003zkq-3JZs;
	Fri, 14 Aug 2026 08:41:41 -0400
Message-ID: <20260814124141.646190168@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 14 Aug 2026 08:41:25 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 2/9] ring-buffer: Free cpu_buffer::free_page with subbuf_order
References: <20260814124123.133362396@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

When sub-buffers use an order greater than 0, cpu_buffer->free_page is
allocated with subbuf_order. Use the correct order for
cpu_buffer->free_page.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-2-vdonnefort@google.com
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8f34ff6fd066..73a3fb76ba4d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2631,7 +2631,7 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 		free_buffer_page(bpage);
 	}
 
-	free_page((unsigned long)cpu_buffer->free_page);
+	free_pages((unsigned long)cpu_buffer->free_page, cpu_buffer->buffer->subbuf_order);
 
 	kfree(cpu_buffer);
 }
-- 
2.53.0


