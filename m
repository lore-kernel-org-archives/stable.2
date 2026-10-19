Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792438427;
	b=c9ghnXQxgZfdvAaHGqwPKGyycSWSY4J7KfwvZQYjqiTRDNlcfPL0k4xg4ogVGFU8gXk3
	 Ep/CuvLCNurxNvQMqyHbUF1lxlYqtUBWN5zaN8yoPctKSPW7YyLUynQkfk9hu27cA3ZdJ
	 wKMQslDiYzozgQsHLjhzc+pAf2U4eF9yjqv69UoP1d2LAWepeeaaifiWWVyAw6/JxYgrv
	 zolFC+SIzCO7eZrdlFSwEzRHrigv4XMF3uaMzJJ53XbAUeSeJz8mZi77K35iIiWpJGwIF
	 M1rGqDaP+sVl06o915M+niCMFUWCBrKJF4N9xSJ+JHlrVf0wsqtXbbrhDO5rYjTj74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792438427;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=cLf80aF1oE//m9U0h9Krq6cHWUyxHuFgVvrddQhntx8=;
	b=1DOlGQBeW09uSh0m8qbrrTQgWr/iUVIltEKJQjDD2HZ7ODL8169G9rI+bGQMRxTBpH5d
	 MjdSy9IaVxPHaZOM3B4s+XGk0CYMi/3516hy5A1sKuJ4skyEe6JSz2d9KzUdKwRfloI4Q
	 1vQTKu834ke8yLrjONmW/08fBwnDTEktULEWRCLVszRy4aFW1hAfFexFGZDB6xsdwE1u4
	 LBZ+R1UhWUb/grdaF4RMsfiYXz1ZHmB1W7IyMp6gF4sDGUN69+E+2dd8BlpVic7M+dLSw
	 vWZ0Z94iJdNyxPHIwVnQZDnEfO06Yalo85hq5IZxlldiJQA3eHysEEfKDiOojZxOgAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBwxDyjl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE8606A326;
	Mon, 19 Oct 2026 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBwxDyjl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50AF1F000C7;
	Mon, 19 Oct 2026 19:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792438426;
	bh=cLf80aF1oE//m9U0h9Krq6cHWUyxHuFgVvrddQhntx8=;
	h=Date:From:To:Cc:Subject:References;
	b=LBwxDyjlduxjvasCtyqtnh/9TS4YTVPNYcuVJYWTABD+91IRUWooiP6X1K+5ucuS8
	 uqmF9QJIdlklzpJv7ixmmW7QXueCrt83c7pfFRgx7lj7plzsldsiPWXAn0hCh+1rpv
	 exI8GM/Twlx16vt0mMkPv0OWzT9RqEcqbf/5ni2eeDnKwFDX4ACG5MNo1OUotSwqQo
	 ArDZ+mEyxuGA6lpc2Yay4oaKZrxT5Hf+/ABNg4+8B+bL1RYziyh5rH6jSpZgFOFTiV
	 V13i82oxoYTl2mWo13s3g8z7omol3qNphuOZBHa5fHUUWEEbvO1P+rqD7olrQRWiIM
	 NIa+H/CsnrRiA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xIt7C-00000001ego-0WpN;
	Mon, 19 Oct 2026 15:33:46 -0400
Message-ID: <20261019193345.931372911@kernel.org>
User-Agent: quilt/0.69
Date: Mon, 19 Oct 2026 15:33:35 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-next][PATCH 5/5] ring-buffer: Take cpus_read_lock() when changing the subbuf order
References: <20261019193330.365764549@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

A CPU coming online for the first time gets its per CPU buffer allocated
by trace_rb_cpu_prepare(), which then adds it to buffer->cpumask. If that
happens while ring_buffer_subbuf_order_set() is running, the CPU shows up
after the allocation loop and the install loop walks it with an empty
new_pages list, corrupting the buffer.

Take cpus_read_lock() as ring_buffer_resize() does.

Cc: stable@vger.kernel.org
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Link: https://patch.msgid.link/20260916192628.274136-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0068bd185945..443271779e94 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7464,6 +7464,8 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 	if (psize > RB_WRITE_MASK + 1)
 		return -EINVAL;
 
+	guard(cpus_read_lock)();
+
 	/* prevent another thread from changing buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
-- 
2.53.0
