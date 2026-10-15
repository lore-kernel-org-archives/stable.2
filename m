Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122151C041;
	Thu, 15 Oct 2026 13:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071246; cv=none; b=PwuQAoiPgvVZ7ZmTmXs+4vPOJQvae3bWbJqLbFpz+iG0bZ8SU0KluH1RTb6n+Gs6TvREAdLFdZTeElzI+vUq9nnuRGJ5O7zwJNmkeo2lybEjN4OrBgKq2Fbj1if4rgmxhYM5m2aFfHp0YL0vpqc4IGObvqMEiegrtI0Jp1d2aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071246; c=relaxed/simple;
	bh=drS7zsdGw2WWlaWiu5L3fnnDpFWSiGUs1fkBK6l6rEo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sWw8QBn6bYIlAb25bZudQqnNOaFGe87j6wCzx2O1wW86p+uzf2bDWYZStalCUdpkV9BM3SexCFV2T0mu1C7hD4S7Y8LYynSRSFUIqJ3QdTFX1LgtQXtEHF55tkJ4ptLrA7CqTBsLfuVcmDKmcQflexAcXwPJa7x2pfateJL3XQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z694581x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z694581x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCD81F000C9;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071243;
	bh=32QJgRy7rPJA7+pGtfEQaWGLVab8kd6GII/J6YwBJJU=;
	h=Date:From:To:Cc:Subject:References;
	b=Z694581x2wOuprYb279YQ2uhU24/WmqWherD4/tEMPxM9+uH27tz3ieolUxTl852v
	 qOOoom7Af7yOg877hN3JC68LycTCP+t791Omb4urV4SkkeoLxY+7beQFXexByLT9+S
	 xbuI1qwpsrfTP2q1TM2J6h1KQivw+dXiY+9Wjlx4of4x29TDFx1l9Nel/SIrVhLEKN
	 i4zwy6AhVza5n4wmXuZHVD1RY83WaQ8YMOpExQEsUuM32bS5Z6TNQmiuNpXVwZE//V
	 APhZevK3Ad3cYuEyrkOCClM4MHGVrbbvcZNFQCK4pY6+JG83reIvRrI2TWnwjuDLWj
	 ScZV63E3ov4GQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLat-00000000McA-0ZYw;
	Thu, 15 Oct 2026 09:34:03 -0400
Message-ID: <20261015133402.944192115@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 05/16] ring-buffer: Fix the sub-buffer array base in rb_meta_subbuf_idx()
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

On a persistent ring buffer, rb_meta_subbuf_idx() can return an index one
sub-buffer too high.  rb_setup_ids_meta_page() then fills subbuf_ids[]
shifted by one and leaves subbuf_ids[0] NULL, which __rb_map_vma()
dereferences when userspace maps trace_pipe_raw.  rb_update_meta_reader()
writes two such indices into meta->buffers[], which rb_cpu_meta_valid()
would reject on the next boot, discarding the previous boot's trace.

A CPU's sub-buffer array starts after its meta header and the nr_subbufs
integers that follow, aligned up to a sub-buffer.  rb_meta_subbuf_idx()
inverts that calculation but skips only the integers, not the header, so
its base is one sub-buffer low whenever the omitted header size crosses
the alignment boundary.

Invert the calculation with rb_subbufs_from_meta() rather than repeating
it.  rb_range_buffer() maps an index back to an address through the same
helper, so the two directions can no longer disagree.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260918071507.1019251-1-donggeunyoo.kernel@gmail.com
Fixes: b14d032973d4 ("ring-buffer: Add ring_buffer_meta data")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ce179619e655..ad3bc48e2670 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -3630,10 +3630,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 /* Return the index into the sub-buffers for a given sub-buffer */
 static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
 {
-	void *subbuf_array;
+	void *subbuf_array = rb_subbufs_from_meta(meta);
 
-	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
-	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
 	return (subbuf - subbuf_array) / meta->subbuf_size;
 }
 
-- 
2.53.0
