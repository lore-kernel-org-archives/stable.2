Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792676563;
	b=t9h6aAhDYv98Mm175ZDhFK9ywLIi+rskhs7Aete1QTHh2Uzy3a0bhyFPDO6fegmpYpms
	 /IXDjtodnVcU0jkJp0X3D/pUkGC9f2KwUC4OYMhU0j/smnOVenXwOFEDFmRNr9hGIQO7i
	 6NuOQRb7X3tOGSIn4ggGw8z8M+E4uxHVc/xbGhPPHRSRKGV+v5OZQjjXaj9trrk3zUt+E
	 ZbssNPYprP+PpCeGBRhQvCkVFL/KCeHM0oUlV+1Ln88ZdYoWXE6ZThn+iDRPWMGBE4C0G
	 BUaCL1dVmXXJgcyiY+Ry7x30swgHMqbFfGmYY0n+iUNf4oJ32fnojgk93iFF/dccWng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792676563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pntMIJIM0O2d8Urg3h6MO7qE/ZPaHdnQqc8CJsiYr8g=;
	b=zwyAqL+uYEzXylZLiRXlaWYQasSad8DzoUGMNDl6PZxCgIZLo+BOImbA0M5Xjit4B0Ij
	 tawDpc2kyulHzZaNMiV8usdtbLaK4sXRTBG2dtD+ujznvnnh0Y8MXIkAnQWotqzwej19Z
	 rhVVHmfYGjlQEKJtT6E87pBk/MxtuXG3YsZk2NeLo2Rq+yifmNpzK/iW7Q6LFuHXaY+Fk
	 b442+2MHr7i+TGLwQEtF/nlrJ3Bo6yE+1TmnBzhyB/u/t2olJQrUnE/O5Anx+lTNjhe1i
	 E5ekBaXBBTRQ24vJpb4DBTbN2h2sa2pr6i54EcOIcVXqJC91Uy29QAKYC0Ov7XB3J1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDEhIT11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4927160A2628
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XDEhIT11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E0E1F000C2;
	Thu, 22 Oct 2026 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792676562;
	bh=pntMIJIM0O2d8Urg3h6MO7qE/ZPaHdnQqc8CJsiYr8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XDEhIT11rC0OC64rRhGmjzuaZ4Zfmg2QGdfSi4ocwLfLan8bJ/Bazve7biSoPJvUm
	 pxv+Y/hfxmoQbYchRWfxlt3x616FzDhxJo+yp1xVEmtOUvwFhvQNdTdkksODZMd9VW
	 IzJPZ6gSjAnpPkVvj73EQu8UBeFTkW9eMq9e0AHSjO9PXQbwPqJy+pWJGLNNXPDd93
	 22b3tRhbIgpHuNfy7U5VNE+sjcGoRu5VvkUA/9TfBHafSVRN6hhLPHc4sD/BE0B63q
	 QJVq5ISkg3yMx/FDbE65/HfO7zdkkXjGAxjIK622Ci73uTDEXYKj8RMGTYDOUAXAX/
	 B+zOC5pr5iW4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Taeyang Lee <0wn@theori.io>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing: Keep the predicate limit separate from program capacity
Date: Thu, 22 Oct 2026 09:42:41 -0400
Message-ID: <20261022134228.1443227-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102143-pranker-squire-2247@gregkh>
References: <2026102143-pranker-squire-2247@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Taeyang Lee <0wn@theori.io>

[ Upstream commit 803aa6fc2dbea25ab9d3ed19eca1c96d0ab17445 ]

predicate_parse() adds two to nr_preds to reserve the terminal TRUE
and FALSE entries. It also uses that increased value as the limit for
parsed predicates. If the initial count is smaller than the number
actually parsed, the program can fill the allocation and subsequent
accesses can go past its end.

Keep nr_preds as the predicate limit and use a separate value for the
allocation size. This leaves space for both terminal entries and a
zeroed entry when parsing stops at the limit.

Cc: stable@vger.kernel.org
Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Link: https://patch.msgid.link/atELCd1XjKVhrkFL@Taeyangs-MacBook-Pro.local
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ sashal: adapted the allocation change to use kcalloc() instead of kzalloc_objs(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_filter.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index ada02ae893c20..cd89fbf2fb208 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds_alloc, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
-- 
2.53.0

