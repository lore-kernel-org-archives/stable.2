Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060937C930;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676804; cv=none; b=NrRztzsm0IMgWcLEy/LOBKhWBtvigWhu5G2qwhTIi1mgOHQyTmG01pLCH7oysLIZF2DThZBsCfS6B5F8fC1FMQDShdfpsR1gR2C4TrgdfwElrqwTipqf56I5h/I30an1eWM5QLtAI+74IcTxEk5BX3oHFg1JwcyTfjKOvJqOC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676804; c=relaxed/simple;
	bh=UtsO0Gokd/pGWTPuvAgNuOYh/Tb/GGTu3I5Ny6vLdtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SHUBv7/c5jXPmgha1XASmJ+Re8vR3hnpZpKQhDK4BLy1NEUF0WjPehKWO4QgU3/UDV9LN3g2Vat/URlTuK8ZNclQxKxxbX2BfQ8exkyEpQpZCsbII53HIyNUEoDMbisFrDC3AT0Gi/Ig+w429BnArHdb6Ul7kq7dxKexMZ4wCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHY10SNL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHY10SNL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71B30C2BCFB;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787676804;
	bh=UtsO0Gokd/pGWTPuvAgNuOYh/Tb/GGTu3I5Ny6vLdtk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qHY10SNL5E0cZuuqOfLziGE9cQnjOcWWldGqdvSGYVSqCCcY1ltc23aeM1jKX2TZv
	 GGqncvAnJh/1YoNg06yt7KmUoIFu8ppaMttMBBVZaS+Oy68DnQlMtnXFJGV7WXZOW8
	 Ez6vycZBp2ZZBdHbQYbJUKVxsiJ25Sosm5ge6VDEXX9QWc1+DO8vqxvpdoI2XurrOI
	 isnQkL+NCbjHQPRWhPnYJS+XULSY+8zf1q9XOWpG9iS2Fn++TyPUwJPf5Tzw7qaEyz
	 BQnNJTc6aG7KiQP2Eu13aqL+g4ucwiDTq0f1oiX9jaHkO4WKcV3jPYnyfCmxD4hC4G
	 h7ztQf6q/yKpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AA9C61DBE;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
From: Ivan Immanuel Shaji via B4 Relay <devnull+ivanimmanuel1234.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 12:52:50 -0400
Subject: [PATCH v2 2/2] ring-buffer: Stop remote reader update when page
 swap fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-kernel-patch-1-v2-2-bb3461807a32@gmail.com>
References: <20260825-kernel-patch-1-v2-0-bb3461807a32@gmail.com>
In-Reply-To: <20260825-kernel-patch-1-v2-0-bb3461807a32@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787676803; l=1736;
 i=ivanimmanuel1234@gmail.com; s=20260825; h=from:subject:message-id;
 bh=LNL2ffJz8llLBy4R+x3iJYnTiH9lI0OfoRC4hz5apiw=;
 b=QJKEN/5hZjtWkMBMH/i//qnraPVZXGGRR6NaiSx4oqq97BchClSXatijJio6RkkoNRwlXovwC
 VCPjsCR5Th5DCwPrek+JH9QfoB5TYU6QQAzsDO/Dc1D+/dccnIybkcB
X-Developer-Key: i=ivanimmanuel1234@gmail.com; a=ed25519;
 pk=Wx8O3UUs3XneDkbqbOJJnlNdWSpEf2tWbTAoE7/vnqE=
X-Endpoint-Received: by B4 Relay for ivanimmanuel1234@gmail.com/20260825
 with auth_id=975
X-Original-From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Reply-To: ivanimmanuel1234@gmail.com

From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>

The remote swap_reader_page callback can return -EBUSY when the writer
moves the head before the remote catches it, particularly during an event
storm on a small buffer. __rb_get_reader_page_from_remote() currently
warns about that failure but continues with the unchanged reader ID and
rearranges the local page list as though the swap succeeded.

Handle the callback failure as a recoverable error. Report it with
pr_warn_ratelimited() and return NULL. Callers already handle a NULL reader
page as a failed attempt. This avoids splicing the same page as both the
previous and new reader without flooding the log under contention.

Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
---
 kernel/trace/ring_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 3c3ed639923d..b0963ac6fd16 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5805,8 +5805,11 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	prev_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
-							  cpu_buffer->remote->priv));
+	if (cpu_buffer->remote->swap_reader_page(cpu_buffer->cpu,
+						 cpu_buffer->remote->priv)) {
+		pr_warn_ratelimited("Remote reader page swap failed\n");
+		return NULL;
+	}
 	/* nr_pages doesn't include the reader page */
 	if (WARN_ON_ONCE(cpu_buffer->meta_page->reader.id > cpu_buffer->nr_pages))
 		return NULL;

-- 
2.53.0


