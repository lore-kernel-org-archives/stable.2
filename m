Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196480;
	b=AP+gLsESAyAVQgpQZetRM3vm9o00HhNob69bT7pEQc1VHgRe5kaLGItTKHa/XzH+2y2q
	 fIlpbymR6crw9KqT44Mydx+JO/CIW2eVx7bgCHHyt/o+120HAta5Z3yLL7oOmdKmalyyo
	 jLMpENigXFpie9kDPsmd2T6niSDVpE16teZXUi9QHXfjhVtwEMRJzoHVG1a0FbgzFP63/
	 pPP98quf8NSQaQ3SPafSeN4hJ4FTbvuU3KG7iOjZ6mEFMoksul8o5w7bdqc5JUlfg+DvL
	 hnsn/PVMiHHT9KhkHHtrECvCb/eN9uOZgqwqEqEFVoWzM5DTrurCBMM1gn0JUQE5CjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196480;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=xkLbuQRzc0Xwrp6TBHzoL52MYkhRq5+cr4+OlWc1+T0=;
	b=J37Q4K2P9UGo5QFJTF20aZ6Y2Mr3oyWZxnsBsOz/HwiTJd7E7WEGa5tFzy76msuaL0qm
	 Y+yCvxKx4m6mJ3FNy+5uJ+O/4xVepaJ7qkGomdy4qZpGD5pz4yaiC0hn919CNNu9zkXd3
	 OXxroIapBFYdMbVj8YsFJWArMRl07FQx6NGmqw5JUFgvGMfDc2RiWODz7OHZytPuJk+VG
	 cDL/5yKP6Rp3oiIQdFJfOpCj/TGl1RDDHu5RPPFOz5p9y/cz6X4GVpE/nFFpdjRQ4N7B7
	 L+Pll+TG0waJGG49J/QlTshnt2y3FzhqxSgsFsXLBOd2KnH0hnDN4Ux/BSTvh1dME6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meoFBIUV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CC960A6F72;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meoFBIUV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206971F0156B;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196480;
	bh=xkLbuQRzc0Xwrp6TBHzoL52MYkhRq5+cr4+OlWc1+T0=;
	h=Date:From:To:Cc:Subject:References;
	b=meoFBIUVelqnQRgA2ldjziSaOnzpwg2zeWyzpxcxnvkWjCDLoungM8p6hUNMVyiAD
	 WxR7A3lcUmLFugpP9iWRXzXC9lQmEUUBzF5i5vcVEB7CSVB4r/zUGdwooQInFJyEhl
	 hapmRa/L4KIRVoKZf5umkl1SxYha0bpEO9IngTzWFaQmNMeMCufNz813KVzTfv8j+E
	 jY16rxoy8iJW/uy6lCnf6Vea0u8Dh5ZtfhxaS+oiGlZwDUzK4WjhatwGM0iBUTYz5k
	 B0oYj5ysEqC4/kudxOk3vKZwqP2z5gajGU0F53yvpTkxqsd9pWFqKhUC5iBHzHLuaX
	 1PFxJqb64aBng==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbv-00000004aTy-1rPQ;
	Fri, 20 Nov 2026 12:41:19 -0500
Message-ID: <20261120174119.272851478@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:20 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Kyuwon Cho <kyuwoncho18@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 28/32] tracing: Take trace_access_lock() in tracing_buffers_ioctl()
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

tracing_buffers_ioctl() calls ring_buffer_map_get_reader() without
trace_access_lock, breaking concurrent readers. Take trace_access_lock()
around ring_buffer_map_get_reader(), matching the other consuming
readers.

Cc: stable@vger.kernel.org
Fixes: cf9f0f7c4c5b ("tracing: Allow user-space mapping of the ring-buffer")
Reported-by: Kyuwon Cho <kyuwoncho18@gmail.com>
Closes: https://lore.kernel.org/all/179485165154.2547186.6129837870360499372@gmail.com/
Link: https://patch.msgid.link/20261117082932.3441173-1-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 70b3c11ac166..65b9d67647e5 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7415,8 +7415,12 @@ static long tracing_buffers_ioctl(struct file *file, unsigned int cmd, unsigned
 				return err;
 		}
 
-		return ring_buffer_map_get_reader(iter->array_buffer->buffer,
-						  iter->cpu_file);
+		trace_access_lock(iter->cpu_file);
+		err = ring_buffer_map_get_reader(iter->array_buffer->buffer,
+						 iter->cpu_file);
+		trace_access_unlock(iter->cpu_file);
+
+		return err;
 	} else if (cmd) {
 		return -ENOTTY;
 	}
-- 
2.53.0
