Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A14B3373
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948649; cv=none; b=lFN/MagFl2giGrt2J+mzOPR+fFt2VpByF4EiD0A68vcM2brFnToYyBocV1oggY9qAHCIJxoeAd4crMxjI6aowLUNo4oL3ITW9DoAMtfJO7EDlPz5Y7nKtcmE7LHAyzbKHXeKELpWmhStxN3SpFxvA+3UlYv+FeYMadyIsJIk3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948649; c=relaxed/simple;
	bh=0+tNHXh/J6/QGWPxu0bk36FJIiLSTbXWTIdse/8kBjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7ca1rC/iX7ABBpviuzL9xIVQ9cMz/Su/XgRCkgzKAqo9lHf3M+wrtTLNyqOPgkUAKRGGYiES+dXn8JhbMv0VbtkxWhAU9wBTYlXrt1pwUDg77pKp1edagEshHAitFsiYF6VEcD7rBx57pXMRQPCef+/nyopAP+7b/S4Cz0VPbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuASLvSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuASLvSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0B41F00AC4;
	Wed,  9 Sep 2026 10:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948647;
	bh=jpy9TDi9erw2fpLm7VBTfZNP/UPe2fByZiZoTtBk7po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuASLvSQAYESsyzBxFRhkIadO+CaeZZGBZrhcACgq3/AuQusvwCofLbbC0WCDcEaY
	 i4oSIRIvHPyTpZRGs7gPKABvoAbI6bQK5J28mgEkoCWjBQmnTMr0mzZ2wYZdvRxqXG
	 JVelCkXpHdxaGj3mJNeZ5sDvSucadgdPeMqEwQ5fA9Z3ulkieUaN/YDJrJVlFiXRXq
	 YPQ1bU76tOeBXNuJM5SxRe81pxCJKkoL2cWBNzXq+7Ses3c6ZElqOqRhxItGgUCv15
	 cJo9A3nvEFb6WIFUum7Vuj6rP46Q5W8mJOFbDkNwG9MaWE5E/k7+eKVSuaIFxrU2KB
	 foTEmoq8tX9iQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vincent Donnefort <vdonnefort@google.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ring-buffer: Fix subbuf resize race with ring_buffer_alloc_read_page()
Date: Wed,  9 Sep 2026 06:10:44 -0400
Message-ID: <20260909101044.1457737-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909101044.1457737-1-sashal@kernel.org>
References: <2026090352-announcer-magnify-98b4@gregkh>
 <20260909101044.1457737-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vincent Donnefort <vdonnefort@google.com>

[ Upstream commit e743527c5bfdceda1095bc0a9e596e2aebb6a9c3 ]

ring_buffer_alloc_read_page() is racy with ring_buffer_subbuf_order_set,
it can allocate a reader page with an outdated order. This isn't a big
issue, the user can still re-allocate a new reader page and try again.

However, what is more problematic is if the value of subbuf_order
changes in the middle of ring_buffer_alloc_read_page(). In that case,
bpage->order might not match the actual allocated memory.

Use bpage->order for the allocation to prevent this race.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260813131152.3589632-6-vdonnefort@google.com
Fixes: bce761d75745 ("ring-buffer: Read and write to ring buffers with custom sub buffer size")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index dafcf77b3d78e..bb2626413be3a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6431,7 +6431,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (bpage->data) {
 		rb_init_data_page(bpage->data);
 	} else {
-		bpage->data = alloc_cpu_data(cpu, cpu_buffer->buffer->subbuf_order);
+		bpage->data = alloc_cpu_data(cpu, bpage->order);
 		if (!bpage->data) {
 			kfree(bpage);
 			return ERR_PTR(-ENOMEM);
-- 
2.53.0

