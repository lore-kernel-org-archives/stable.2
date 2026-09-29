Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C63D953E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 03:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651537; cv=none; b=nBKsHlf6jXKdHC4zvOCerEUtQJb93C7VB08jApPO09Uj5G/nqMLISwg0xU03dwz9HT6TLtC/udNMvDW7v9H7NwbrRFsF4tgP6gpNxgMlJRzQGNQ4FMte9VUJw73J+G5DaH4m74RQesf1/0+rMVQGfkUDfIIJe4yf/ObYZb/OOyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651537; c=relaxed/simple;
	bh=dsosmekOsd0xz9VUpEbFdZ+i5QTRLPAikwiupwB+EWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkUYUZwASaSdQ6HfjKggO5UNWz7LKQR4xmf1X8fy84sUQmf7A0IQ/onCN8KVkVTzozYk45wHz2BbdDAik1lQmB0ZuNNG8ifRoKb3sfZ0oqFtD5WG55JLi/270e6dYAjFg7nyNuWEcR0/A7vArpu6CQoqGZPtpCF1kImSZQulDFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=CEdfKHj0; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="CEdfKHj0"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-34b6f8b80beso55106eec.2
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 20:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651533; x=1791256333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tYBLb2quugyRTAsa7b71SM3DW5Wwgo3gafQib73WBzk=;
        b=CEdfKHj0qOD369okvqMdksd9Zc7AbGmDq7a5NSjghq8BdY4zxIy2SmSEUEcfOSg/QG
         WsrWCZxinWZ0ukQkihvam/w+iNLXKvzZk/qJLZlzYUUJxwyJ3ZD+a6ZEQEBAcBTOG21Q
         AtszD3Y8Ww+bK/M+y8noLCDzCIsbmkDy+T6c2y3Sd5U1/0TFbKiHHZR7Nwqxx7AP1CzK
         0vvFH4EFkLdDwCkzVoF25Nc03cXydzG/RxoYYZrH0DNVZh5QDgwE7jSGqeHtZWeCHF+M
         AEE5AdnwcjHcpAr/82tFZLwiwjmIkrxQj71XHUw2wjC3Z2AEMnUpc7wW4RklqRUIIUoS
         zoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651533; x=1791256333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tYBLb2quugyRTAsa7b71SM3DW5Wwgo3gafQib73WBzk=;
        b=zlcpUWPTYxzvNcCt5Nvw7mtZrwdgLZTwG5huj49Ii53csR9I4DEttxk2jKYDXkdaRR
         t4mctscsL7QV9R5QkZybVHAwBWUBzqvKf3AELYEeYmxKDJVyS6XmUsdorkcYT/ULhTaK
         6/lqL/R75pQGKqmtdv0UW6/GRS7ilbn5P9eG9cUhfiIUwFCcK5YlySf/lcOGz0YNKUPl
         m4f2rkCzM90B60K5vm1w2BBxi0l3KGNCIbiPMziR6JwgzxUdC1vVVG3Hrlr4jkqgmqQ/
         KSzrqLlu2u0mFlvpxHNe3nyxXlKig1p43H64ZFYiNTJyg5dsO1Ae/8liPXqQ/Peil9SM
         DLaA==
X-Gm-Message-State: AFq9FYLxZqSsIGviZdC5NU69IdECT16oZuQ+b4HOqbApNsZqj/7M9dZP
	wm906zseDQsZ/oJs2vrEay6PtJj4OWvaRZu0dJ2pNZVchudP++gmMtKNWsYO2HFLwO478+9PdiJ
	kiuDeCjQ=
X-Gm-Gg: AYBFou3FUtHHt3XSFX67rzNSLgDpre/xQ52PkyY6y0DjUKeRCgGuV5DBW2dXFq9oFiR
	iyCfhdm3JYDRr746xQaST7fd0sHuuJXAwivbA/A+Xdz+QdCqmOAoB1Jdvg/h/ULDg4N+/QpXhJw
	2UOrn0T5CBHRq5q16WywovwC2uVDBIakrmMbcx/N5AOueV0Wrhon0hGV9S+8rUuKljEGfIaVV5t
	Xx49BK5MqhOzJd9vlq+eD03PQsFAdjA2z+/bOENunNrp3j1rde49netcIbIxel1miZVcVBl0u3E
	tqjB/2wymMGw3p8F2O4GyhQbtApSTzk2mp4sGSnX/dEHw5xH8Kh0fMhBDtcsXbA25gFhYTjctnI
	H7srgS4BUyPEWqavTZvd9BDhRmTjZSnjeeMSH6xNq88yQAm3S6r5bTzy6uBY+nLuZEHnLQ6c7sh
	gn7udfYjLhd4Eftd4e9W3q0LNKUzs8BxN3JGXBVHilLiNnqsMfhHh6qH+MrLuAf12SGCWkVPzW0
	SbWSE/3RouftCu6ht/qIbFTHrnHlHdbF6efU3FFL9ZFZuHW/xq1u7RMl3N4sj5DBN84P4V9xnPf
	OJSXVg==
X-Received: by 2002:a05:693c:65d1:b0:34a:e4f6:4a5e with SMTP id 5a478bee46e88-34ae505937fmr2051657eec.24.1790651533232;
        Mon, 28 Sep 2026 20:12:13 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343580930e2sm22425259eec.16.2026.09.28.20.12.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:12:12 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	=?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
	"Pan, Xinhui" <xinhui.pan@amd.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>,
	Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 6.6.y] drm/amd/display: Ensure array index tg_inst won't be -1
Date: Mon, 28 Sep 2026 23:12:06 -0400
Message-ID: <20260929031209.87164-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 687fe329f18ab0ab0496b20ed2cb003d4879d931 ]

[WHY & HOW]
tg_inst will be a negative if timing_generator_count equals 0, which
should be checked before used.

This fixes 2 OVERRUN issues reported by Coverity.

[ Backport to 6.6.y: mapped the newer pipe index and helper to i in the
  older acquire_first_free_pipe(). ]

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and drm amd maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-46730. It adds upstream's zero-count guard
before the fallback timing-generator index is computed.

The condition now avoids forming timing_generators[-1] if a zero-count pool
reaches this helper. I did not find a successfully constructed in-tree
resource pool with zero timing generators on this revision, so this is a
defensive match to the upstream check rather than a reproduced fault.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-46730
Upstream: 687fe329f18ab0ab0496b20ed2cb003d4879d931

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 84474d5122284a..1f576b2a1960fd 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2354,7 +2354,8 @@ static int acquire_first_free_pipe(
 				pipe_ctx->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			pipe_ctx->pipe_idx = i;
 
-			if (i >= pool->timing_generator_count) {
+			if (i >= pool->timing_generator_count &&
+			    pool->timing_generator_count != 0) {
 				int tg_inst = pool->timing_generator_count - 1;
 
 				pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-- 
2.39.5
