Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C1337DEAA;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242738; cv=none; b=QdMgqbYrSjhT2Iv8qV2C1HpRDiAtsaaAAe69AIhopPuw9+2VQoxn8H5xBGmWkFu7gLZm2XL/7c9c3ZOSEmrZIuuOd2Iy9ZKybWEyFJcbjXADhyfpoHRbPZbjtqS9qa/KO+TI2uESHHzr7iLvuy8c0unSpuoRs0fEPI5ajSR+GNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242738; c=relaxed/simple;
	bh=afozUb8E/5FXp1IRFFB2cQW7YrWaCKo+79vBmXSiE/Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hgLeaGC2nqJt3wDDdGgPBb4Ws2RyHux8mBK8qaogJiXQa/Sy/Qus7PrJRvm0nQUulbdvUf23ki6lEdaWUsvmhbJaiJHhZwgosmfJt72my03efqe1T28C4MYIqdO+VWE4KpiKZbxHF5mH94pO16bAw898E56CeDqEkd4sKWaLjLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg/Yjanv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg/Yjanv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3BE1F00ADE;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=JrxP5G/FB4r8xdT3E+9AH8xbkYjIv2lSi5v0y68eIGE=;
	h=Date:From:To:Cc:Subject:References;
	b=Qg/YjanvPmshHuWNqXtAj6WhQm3/mTZC4lT/wJXUEM5WqCP5DdaRTXlOmdHdX7BEE
	 sf/w1ByR9NeY1RIjCg2y9tfsyfuCKhtA/X6L7IQqSsagFo9tdPjApdYnb2Wt+mbsuz
	 96QT69JpAK/P8kjV6YZytcC9REBzu2b9Iz43nu+YR7TieWYg4Y4LSdxzeTqRuPn41J
	 iw8NeYujBeSaqLI9l59TyYWlYpoQ0epJcmgBvcVmSLjWj2hGFb83xaxTt946QGa0JO
	 a1jkYEEgfUXTzE9Ed0Kgse/BhmkTr6XHM9NPd1vmO4eOeqhfxZ55fQOeZL/sgMuvzk
	 8anUHbqqxUnNA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKo-00000001N7C-3ucB;
	Sat, 08 Aug 2026 22:32:22 -0400
Message-ID: <20260809023222.799156348@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 10/12] ring-buffer: Prevent subbuf order change when resizing is disabled
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Because ring_buffer_subbuf_order_set() frees buffer pages, we can't
allow it when resizing is disabled. A non-consuming reader is at risk of
use-after-free (rb_advance_iter()).

Return -EBUSY on resize_disabled, matching ring_buffer_resize()
behaviour.

Cc: stable@vger.kernel.org
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Link: https://patch.msgid.link/20260806211306.3704194-3-vdonnefort@google.com
Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 09d502ef4c55..6cbd80ccef37 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7360,7 +7360,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 		cpu_buffer = buffer->buffers[cpu];
 
-		if (cpu_buffer->mapped) {
+		if (atomic_read(&cpu_buffer->resize_disabled)) {
 			err = -EBUSY;
 			goto error;
 		}
-- 
2.53.0


