Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07FE38F927;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787676804; cv=none; b=ZFru+ywJM9ri3t9KSxo8Hs8X0ctFGuylqUYJ0FM7eh72l3V3BygYP+EDhnqG50KZk3egVpVoJBvBjTSKOwGJvjEH5P9mrr65DEgebcImZopM/JDSxFcfJKCofrQMz0FJP0ZDsbSfN3WqOixhmJ7SBBkAUifpaavX2OaNvgukWZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787676804; c=relaxed/simple;
	bh=Hk2FkW8rrOnBJBWeKeJ/xKFWNuL2YXyPRMVyxIwDSzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFhP1qEN/wSt1EGwmjR7ulFOhsUqUsD6ae2k2TH0XAx2FAi/yDN0DwiqAvI25xoVLXciKEHcX4BS52iBkneEdBCbHay20Lq6+3qHQ+ZfbkSSkCDzARrfs62Iup2jEl++KhrNngPc/JkzMYk/2DOBwpBOQIwNzjdaa+d87xHQthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCrZMQMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCrZMQMb"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68808C2BCFA;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787676804;
	bh=Hk2FkW8rrOnBJBWeKeJ/xKFWNuL2YXyPRMVyxIwDSzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vCrZMQMbPK163h1sYcPgL8fiOJaj2MqWShCJVcWuJV7CyNLjRkSSVh69I7Mi1aArP
	 adzrKJsiu9ofCKLrvuoMvTEQhLyBZzlP5ujl7YotVBArU6nNwn7oJOUwnwM9onYl28
	 FCGNHmiTVd4DTEmgI5mpA+9jXRfhiVqxXvs3zQ3reiC4PvDE5HJ8HgktKFSrkzJtyr
	 s1E09Z64mvaNU5UyjG/wngXpdrkeDR22xNRxcxMISbc5hSHo+vta/Dx2mQ4ByQJFaz
	 wG8dglvafxbcXD8vb2pzIjkqgV2+urmUgEKjMJv9WwEEngSLIaFmjT98YqofEzb/3i
	 m+Un8UmyivEXw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4590FC61DBD;
	Tue, 25 Aug 2026 16:53:24 +0000 (UTC)
From: Ivan Immanuel Shaji via B4 Relay <devnull+ivanimmanuel1234.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 12:52:49 -0400
Subject: [PATCH v2 1/2] tracing: Fix retry exhaustion in simple ring buffer
 reader swap
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-kernel-patch-1-v2-1-bb3461807a32@gmail.com>
References: <20260825-kernel-patch-1-v2-0-bb3461807a32@gmail.com>
In-Reply-To: <20260825-kernel-patch-1-v2-0-bb3461807a32@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787676803; l=1669;
 i=ivanimmanuel1234@gmail.com; s=20260825; h=from:subject:message-id;
 bh=0wlmuiqSThih8CNT0Jea/HbIHZ739kvpr2URRAfi46Y=;
 b=R2DpCEXju5XYQhQ2OyLBs0xLycXPVX5jRLVbIskDnXkcQD5sSsTRK67g0iwBxw7xpkTviX/o3
 9ly37jhgzggAXm1tVCvEcC0k1OgHoBNUAtqzvrMvu7BgQznSAN4nOoP
X-Developer-Key: i=ivanimmanuel1234@gmail.com; a=ed25519;
 pk=Wx8O3UUs3XneDkbqbOJJnlNdWSpEf2tWbTAoE7/vnqE=
X-Endpoint-Received: by B4 Relay for ivanimmanuel1234@gmail.com/20260825
 with auth_id=975
X-Original-From: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
Reply-To: ivanimmanuel1234@gmail.com

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

Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Cc: stable@vger.kernel.org
Assisted-by: LLM sparse
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
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


