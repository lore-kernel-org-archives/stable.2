Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651FB38AC83;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242739; cv=none; b=hR8GCKH1BXHTbAArc2QQsXU7mBqpAvlyjyZksW/VeU+ql12EdEDaaV54EZOkYkAy90XxyYrHu4Y5iZQoSRL1HgGVuRpsB7EalFQaqxW2JI2E8KW4Qy8bNmwF2McFBjmCuAiCD8Op9XxkeIiGQUFvfCe0W7or2X2E2S0ja2LJOsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242739; c=relaxed/simple;
	bh=G2JcI7zZny1pDHlT26ifDULaTmvkqZrOzjFrh01/dJY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=OMNmJqec67Im4jIAP/6Ql4Ue2qLuLzqm+Xm3AeKcCeoQn7kaUBsJ83FyAX/Uj8X9gOKWiDmSxgkVZ749cJ0soPeBOErCVrAcqYYKGSURpQRypyr7mZtOOGRGanE7rkpZEVvmHf5IBjgthu8DOiZBhWtuXCsPdDpyMW6E5T9w5FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVRvQqlH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVRvQqlH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8631F01559;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=UyyWp3NwzGcFwkjSQWDprdH9t2NSEehPe+aAU1OMBpU=;
	h=Date:From:To:Cc:Subject:References;
	b=LVRvQqlHg0UjneGi9ZeJIErL3tT3J+heCabWPBa/me0CyFGWQdD6nu9ha8sOwLwBW
	 tNIIh/Lnz6zJh56p2/yNIEbaQ/wZ/CBHsNqxms05OjZ6FdajJ/7i7Lzd1agX8fHpfI
	 AKNb8Wqb7TOF//E7XblqjGpsTlSmm6J7tohH6Tg12Pc49ASNE/+9+PfWlnfgEP8aVM
	 QOxCRMeFF65VikOm4p3/XPgOgushjcejGEtJJGeRlYw2Z8eKAbdHYTAq1B7+LjSNud
	 9fPWBe3/gDxxmf8dN5+sYFGW8lIXf0F3G/9G9qWaIGWmcwT0JCRpDwFTshSif2qTMA
	 4wRAxIi0h/WGA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKp-00000001N7g-0L6P;
	Sat, 08 Aug 2026 22:32:23 -0400
Message-ID: <20260809023222.955041844@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 11/12] ring-buffer: Initialise reader page order in rb_allocate_cpu_buffer()
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

In rb_allocate_cpu_buffer(), bpage->order was omitted, leaving it as 0.
This is an issue for a ring-buffer with subbufs bigger than PAGE_SIZE if
when freed: free_buffer_page() relies on this value. Align the value
with the actual allocation size (buffer::subbuf_order).

Cc: stable@vger.kernel.org
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Link: https://patch.msgid.link/20260806211306.3704194-4-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6cbd80ccef37..760a00e8505c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2510,6 +2510,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 	bpage = alloc_cpu_page(cpu);
 	if (!bpage)
 		return NULL;
+	bpage->order = cpu_buffer->buffer->subbuf_order;
 
 	rb_check_bpage(cpu_buffer, bpage);
 
-- 
2.53.0


