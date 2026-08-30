Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA2C12CDA5;
	Sun, 30 Aug 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788051936; cv=none; b=PSnOO6N6ZQRbcFWtzVNxaI9+wxpxgKEc7hQkS5SlHwrPF5D8B0L/qu9clFeXnVIf/96BFpF8kbuR+jQA1JCbMljsHMylcJjHOw/31bh5jq863H0k6efL8OEBQLT3qXoUw+n19PNnDGlqkli7PSKDM/r+XiemIA9Jza0n6wO1WvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788051936; c=relaxed/simple;
	bh=DqR8gnCgPjdDDpd1yS/qjAjDRYbt/fDTTOPtqsdfb9I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fGThfSQI+LBJ8N4fqSvSI2Vz4m/7zir/5zORLqzfsM6GWqMgGONugGyWqBy5IktkavZEKSe0wrCuLJjl71NAlwKX9B0rrBSialQnLk0DS2qZGQ3ilcpEKmzkGrlQY6InI8L7r7n/KUwVar/SGAnV/fCZ9LGSpWyXRXGJAaN1DZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SUTzhCFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUTzhCFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5961F00A3E;
	Sun, 30 Aug 2026 01:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788051934;
	bh=qB5MP1zgfIYCeSEZAt1zSTxgVF9hwMWNiuptqshEvtk=;
	h=Date:From:To:Cc:Subject:References;
	b=SUTzhCFUu0PXQzjJK14Qr6iKgbUlGKuNwFmatTuuoeKX5+IzRBsc9SgsoLn490+ra
	 F0ksGNnjbpJ+UvQnM/NC9UyIKiPWnz1SVWC6LJTHdAI8Mxc5YRfi53Eaf7FZYBCyzf
	 52Q3jxSgNMG9OpjnVqFxx+zPeMlnDKXGA7jOopgkVea0nydfscQ/ljv5Q73MJY+h/V
	 5sB6bs6QKV4op2qMbKJ8xfLBCQW5xQE97evkdvIA1ZSTTAbKItN3OZLbS5CBtZb42R
	 dI4kfctfMRD/cQu+ZpCd1ji2EAmQLOsO1Jix8KXEPQsepis5WGGkbM1xKi3BL60t61
	 MXvBDhj68Y5bw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x0U0C-0000000A49W-0nEx;
	Sat, 29 Aug 2026 21:06:28 -0400
Message-ID: <20260830010628.049582948@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 29 Aug 2026 21:05:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Subject: [for-linus][PATCH 2/3] tracing: Fix retry exhaustion in simple ring buffer reader swap
References: <20260830010531.847108845@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

simple_ring_buffer_swap_reader_page() starts with retry set to 8 and
post-decrements it only after a failed link replacement. On the final
attempt, a successful replacement leaves retry at zero, while a failed
replacement leaves it at -1.

The current !retry test reverses both outcomes. It returns an error after
a successful final replacement, leaving the link update complete but the
reader bookkeeping unfinished. After a failed final replacement, it
falls through and updates the head and reader pointers as though the
replacement succeeded, which can corrupt the ring.

Treat only a negative counter as exhaustion and return the documented
-EBUSY error.

Cc: stable@vger.kernel.org
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Link: https://patch.msgid.link/20260825-kernel-patch-1-v2-1-bb3461807a32@gmail.com
Assisted-by: LLM sparse
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/simple_ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index f4642f5adda3..49913bb0057a 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -160,8 +160,8 @@ int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer)
 		overrun = cpu_buffer->meta->overrun;
 	} while (!simple_bpage_unset_head_link(last, reader, SIMPLE_RB_LINK_NORMAL) && retry--);
 
-	if (!retry)
-		return -EINVAL;
+	if (retry < 0)
+		return -EBUSY;
 
 	cpu_buffer->head_page = simple_bpage_from_link(reader->link.next);
 	cpu_buffer->head_page->link.prev = &reader->link;
-- 
2.53.0


