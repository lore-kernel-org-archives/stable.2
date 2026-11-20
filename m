Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196479;
	b=TGQ7aJdy1uXqFOJRM6pczWmqTXhX5EIZ6g/iCd7E4E2FYbh8wXmKLRiR7MlYKn8Yn5zD
	 gyCATeb7ClcS7miEel3yz5/BrEOvcUimVGl1TrlIZbxKoY5v9HcmWlP20PZwtSpYWAr6p
	 mHfrZEnJbvKLTvvzJO0MN3n7uM3Qfrw2efR1DxX7XvU48JyaPHbDQXD3/u0ejC8Brfcyv
	 0G3pXQUA+D3pcAEkkuR4TOvO+RZdovLsrpJEVuwxJhT7K8Ss/YWZHnMPNUc/dxN6FKusj
	 M3EkSzJ01kh3QFHuhuFxkfbCG17a1gwg0jATPvzJxS5UKTCZzr1GxJ/2vOrwqFY2sSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196479;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=7D9cJe1yNWbqh0DJmxweChnohkqptYnNcUKzDoL19jA=;
	b=UNcJcYk81IwtMAhDmzIVPBN3MoMEQvFoBjtPeO8YuZo2DftwYBLEr1j3rUtT4fNCEqaI
	 V1YV6QX7iXgpwIGrTMkJxv1144LMYQ9kT+XqoCp3ICyie7FUikn4rvdNHvhBuC7PiZIlQ
	 JrzY/tUFZCsyTE6JHxBUl0mXD5A2lUN57eSAle7rdmZzJvWmqsJG6iCVbHXZy7J0ihl58
	 erUT36HXpJWzKb4ZzUz1mqBW5EPMXTxmRTGX5AsQyA+aB3wSmk9GglI8A+02pThZ8u6ut
	 47MhEFbchabxbh1jY+Cmx+MLp/BiwIqnjWLKJ7s70XZ+LUL6i7hOQcIiIYMGBQ7CHjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4QpB2tl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990160A5BE8;
	Fri, 20 Nov 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4QpB2tl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB95B1F01579;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196478;
	bh=7D9cJe1yNWbqh0DJmxweChnohkqptYnNcUKzDoL19jA=;
	h=Date:From:To:Cc:Subject:References;
	b=m4QpB2tlQYd0EcJshsPTJNHuaxeNs9M7pjDB0Mqw+NXyrwr9U7pEWOy/Uw2e/R06B
	 7Iv2c9CUhWQdcPWlhO5Y8jan/5w/l2TuU/gBsvYEwDRQ/tLmv75eIGiN6mJ6Jw9waD
	 RRATx6RIGiXE1y16arNrOUI4kDN98l4LaXQ5njzBAdwODBc+kRmgpppSKWHVAzpXNM
	 CXjP5ukQZWLf2Vn707oJqDQZacYkkWKPA8mhR7bTtA1CnZX5AdMy3UNYXwgujvFyww
	 xOJpjuLaRzFmdLr5Uy2nDSd2sCj6ZJcfwmUyw85Bdm9mO0qly9i0FnK1GJA9YSQ3Gz
	 /n5NLeQK9ukpg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbu-00000004aQ2-0cES;
	Fri, 20 Nov 2026 12:41:18 -0500
Message-ID: <20261120174117.981511691@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:13 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 21/32] ring-buffer: Skip remote reader page swap when on tail
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

When the reader page is also the tail, swap should not be permitted or
it would insert the tail behind the head, breaking the integrity of the
ring buffer. While __rb_get_reader_page() does correctly prevent this
situation, the simple_ring_buffer implementation misses it.

Once the reader catches up with the tail, make
simple_ring_buffer_swap_reader_page() return 0. The remote reader now
can expect an unchanged reader. When it is the case, there's nothing
more to read.

Also, when the simple_ring_buffer writer moves the tail to a new page,
it resets the new tail counters and more specifically page::commit. As
moving the tail unblocks page swap, order the page reset before the
tail_page update. This ensures the reader can't swap the reader page
with the new tail and observe a stale commit value.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261113152729.837429-2-vdonnefort@google.com
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c        |  3 ++-
 kernel/trace/simple_ring_buffer.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index ed267d628826..15ccb65de35b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5848,7 +5848,8 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	new_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(prev_reader == new_reader);
+	if (prev_reader == new_reader)
+		return NULL;
 
 	prev_head = new_reader;  /* New reader was also the previous head */
 	new_head = prev_head;
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index abfaf9bee12e..d5c84af01925 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -139,6 +139,13 @@ int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer)
 
 	reader = cpu_buffer->reader_page;
 
+	/*
+	 * The reader is already the tail page. See simple_rb_move_tail() for
+	 * memory ordering.
+	 */
+	if (reader == smp_load_acquire(&cpu_buffer->tail_page))
+		return 0;
+
 	do {
 		/* Run after the writer to find the head */
 		ret = simple_rb_find_head(cpu_buffer);
@@ -196,7 +203,13 @@ static struct simple_buffer_page *simple_rb_move_tail(struct simple_rb_per_cpu *
 	}
 
 	simple_bpage_reset(new_tail);
-	cpu_buffer->tail_page = new_tail;
+
+	/*
+	 * Setting a new tail may unblock the swap in
+	 * simple_ring_buffer_swap_reader_page(). Ensure the reader observes the
+	 * page::commit reset.
+	 */
+	smp_store_release(&cpu_buffer->tail_page, new_tail);
 
 	simple_rb_meta_inc(cpu_buffer->meta->pages_touched, 1);
 
-- 
2.53.0
