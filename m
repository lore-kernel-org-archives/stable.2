Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1042D44A412
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151403; cv=none; b=aEMog1Zqr7/mLdCqJt1+sdr5LemBNT+IO0Inr3gghsI9vE+ULkP5qlPykMH5ZwqqyCfP8ZjN/Ahq+i9wbY0indFu0sNKoR8FxSp/E6uKFr+eBinShgGu/G9NwJxhnL+w5x5jl0jetNlI6iskOBdl6ztDGurYBR/JI3+AzFiZuVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151403; c=relaxed/simple;
	bh=fK3Ukg5zQTWvbEFQvn/H4I6v5HIpSKVPjdb3zwxJuiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpnlZwdH4jYlu8TVEkzRkvfNMEoHJDrgrvUPQ8/Ww3AYjA1IDgJWOtGc9bOVnlvcEJdEshCbrsL1KZUnWyx5fJiClmgMvfUUUDheWv2qUct5F0cISB1Xrq2BRXEuCqvOfQsdxYSIFzKT9BVzUgwa8M7FCyw/+n6U8/QHcpopSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3neWhYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3neWhYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D705A1F00A3E;
	Wed, 19 Aug 2026 14:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151393;
	bh=i/a9IuFcsLx+Pn0YHMROBaajAz8t5zJD7FnyswqDDyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a3neWhYAlwbHXgmtmnSgLj0p/2FEHeumuggnUnqhAPuFcf5MxvC7LMaVCO7eTT2lm
	 jLKL2s4oNZ/YbdtN9gUeTjREAVPaFeODf4X6Gg6syP14OaDlp63G4QXNdQLFqbo48d
	 VpwsPXP3NoNo+O7+Fk2gvHncyBcHSeZ7+tsnM6KafmgNDftAfgxFwXVCQNDtx9ZET1
	 k9EyfEle9Y5QEj3tPPYe6LKnevqkpko1s3+2w58WTb64KK4c7cSb+h+GRCx56frxoX
	 QInGHjJ7QBZrLpOEVDi57KH/wMxDd77O54m7t9MLkLPkuCrmgebJ5XOoWgx+PxHNwT
	 YB+oiLNG67lTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ring-buffer: Prevent resizing of persistent ring buffer
Date: Wed, 19 Aug 2026 10:56:28 -0400
Message-ID: <20260819145628.3900889-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145628.3900889-1-sashal@kernel.org>
References: <2026081709-tank-childcare-2caa@gregkh>
 <20260819145628.3900889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit 7c727dfce6be04dd009b29091a4a17d952dbfe03 ]

Dynamically resizing a persistent ring buffer is not possible. Disable
the feature.

Cc: stable@vger.kernel.org
Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Link: https://patch.msgid.link/20260806211306.3704194-2-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ Dropped the incoming `} else if (buffer->remote) {` branch context, which does not exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d11bdcfad94e..f56000a69eb7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2238,6 +2238,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (cpu_buffer->ring_meta->head_buffer)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
+
+		atomic_inc(&cpu_buffer->resize_disabled);
 	} else {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
-- 
2.53.0

