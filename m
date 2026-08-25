Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947A13A6EE9;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635293; cv=none; b=TIv4QtZqUnwfZfNgkxIUxu8FBXnTIeKgOkpu0x20oKL5DIqx+SIot05m/rStS98XJ0wiNvFMvobRYZw91Tn1GakmX2hPo4EPkSmebkP/boFj7Pfd2fLPnpQKCUqd1AD/H1wrUcvn/NrpHhyPGXSzUP+bwllM1q4KOMIznvPfm8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635293; c=relaxed/simple;
	bh=O0UzbZAN0EpcTXAFz5ooHMP36tBWRVlQCm0SfHy87J4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfnSkisZgHMe2/M2o9xS4i97kmCNRvhEU5uNqjUQurUNU1dCspCLIS91agQav0gfL0axSUOac3bKvNLuBD4F4Gn72dhbaiYZMgQrGararHYwqyQfy5YlAUrcKuIXO8+/KGB5Sp/pfIdbaQlCzNwVFs5fxsMbN/2E5A7sej57IGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/HsFukf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/HsFukf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A587C2BCFA;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787635293;
	bh=O0UzbZAN0EpcTXAFz5ooHMP36tBWRVlQCm0SfHy87J4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=D/HsFukf1XoOa3vf9YTdmOJD+vyOEoj6hK+NOunVkfj4e67efdz+m543FQeSIYtJO
	 HeHlMrtI/2A91MG+uFq/yxDdV2aAx9NHKbRBZBsw/5aZynuEswp6ivB+WSApvlqCTm
	 1Igk9l1hMn6cDXHC6IufXY8UtlyUEcuAByH+UjvUUHMwA321SEU6fqTjyknAbaOkek
	 leslUHjblA7L/pcpHY90JJNN5ilIv/JtQnBphKn3ZGjAXxk0/T31Ilf+HSQspRoz+4
	 VbfvuHi20cTs7lxOE1kss4GwRX57Y9yeFLZim8iq0k0+xsKznvsCMMl9UMgrYap4xc
	 7OeAGQokuXHXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B340C5DF94;
	Tue, 25 Aug 2026 05:21:33 +0000 (UTC)
From: Ivan Immanuel Shaji via B4 Relay <devnull+ivanimmanuel1234.gmail.com@kernel.org>
Date: Tue, 25 Aug 2026 01:20:37 -0400
Subject: [PATCH 1/2] tracing: Fix retry exhaustion in simple ring buffer
 reader swap
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-kernel-patch-1-v1-1-e9349aa0b165@gmail.com>
References: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
In-Reply-To: <20260825-kernel-patch-1-v1-0-e9349aa0b165@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Vincent Donnefort <vdonnefort@google.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ivan Immanuel Shaji <ivanimmanuel1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787635292; l=1613;
 i=ivanimmanuel1234@gmail.com; s=20260825; h=from:subject:message-id;
 bh=GwccFW1nTWWYVnS3r35/SqG9HHBPVSmi0y6pEIwL9rA=;
 b=uphKKVL9amV7PgkCBG78fcuiBHKszcd+IQnJm6N6imNxYSqSFjW0vwTnoty5JsRCaN+r3ZGwA
 hLb8upGLaUzDg7I6ayMuYbEt9x+WwgrYYSbp8LSL6urpX6uVbt5TdMF
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


