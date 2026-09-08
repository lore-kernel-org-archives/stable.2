Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AE23D7DF;
	Tue,  8 Sep 2026 07:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788852443; cv=none; b=oAZkGWe2S1TPw+LEqZP+ucb2+TYfCCPYXw9ykSklZOvb1K4btVA4wB1aPhszBvD8aBjCBc2QUwE+jlNGK7UwcP4XupWiChasrCAsHtStmsdTj5eOJSnwR787kuvdRm0L14JaPVijM78Bc5Mfz+SLrD6W7qwKfawcOIDqPYk/Q6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788852443; c=relaxed/simple;
	bh=Vt+6gXucuoioWVk58j7Utdta0numUj2daXjLDlo3WJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UZpUOgTac/bcdQst8Oktst1kl4UbAgbsDR9nOvz/As5LQPqgQ4hY9DWT36dKfG9mL5gLVVNmncmnZ4oBzddxRDVxQgsHlDDdF7ybbuzXsv+YdPAG778wqU47mYHVv9n9Cjk87vTmVGWSq8z0GASP3P6bg4sItufuerDGgc/6gu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNpnUXwD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNpnUXwD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56EB5C2BCB8;
	Tue,  8 Sep 2026 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788852443;
	bh=Vt+6gXucuoioWVk58j7Utdta0numUj2daXjLDlo3WJY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=CNpnUXwDZhrcNfnmQn+pqsW47mOZBckKg6WDNS2WyVyUO4of+nDuf1aPGcy/8LGsB
	 f4SBDNKdqU0aewI17flrrq+YMjvvj8OcL++QTqbIpqd/TwrKkPI8jXCD4Tlu+UZ/ru
	 epaMJlUDfbvQYyeRQBf5Xbb2jz5ZEbOFrOQCXBTnxOctXozKgHugi82GcL7U+p4GiJ
	 00jBUrEQNCAksQTzFMoSPUP3fT9DivkGBu0sNINofuF5C6+2X/qRwSkWTJD/d7dcL7
	 ORRE0A4QFonsYH13OH0GZDe812Xal4heRTeSVYze5CUn/g0e+59DlJ2qKUU0mpXtdX
	 IDZszU4CXOY0Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32547C79F82;
	Tue,  8 Sep 2026 07:27:23 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Tue, 08 Sep 2026 15:27:21 +0800
Subject: [PATCH v2] media: vicodec: zero-initialize stateful decoder heap
 buffers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-fixes-v2-1-4775af868cda@outlook.com>
X-B4-Tracking: v=1; b=H4sIANi4n2oC/y2MwQ6CMBBEf4Xs2Zq2CKWe/A/DAcoiG5U1LTYa0
 n+3opnTm5m8FQJ6wgDHYgWPkQLxnEHvCnBTN19Q0JAZtNS1tLIRI70wiO5QldqaURqnIX8fHrc
 hX89t5onCwv69aaP6tj9Do0oRyfGA7m+KSuSU0pi+6mun7Ymfy435und8hzal9AHTugV7pAAAA
 A==
X-Change-ID: 20260908-fixes-a453297f07c2
To: Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Keiichi Watanabe <keiichiw@chromium.org>, 
 Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2104;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=H8Q/kdKbBfEfe7vkpaLiMv4vI0tAEFtnxHDHcSar3uw=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrPk7bl6ZsZOtY/HZomVM2zZUxDuza7fpufFsKrHUF
 OOr2Gr98kpHKQuDGBeDrJgiy/GCS98sfLfobvHZkgwzh5UJZAgDF6cATGRuBMNf8RvpN3fUaptp
 Prxf3VGisZDp97uQqxNYEsP906Iv7pNIZ/hfbnu1KPsHs7qvyKTT2ofP7mb7+8ncu1evzqrj4sw
 f7nO5AYPrS4g=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

The stateful decoder leaks uninitialized kernel heap memory to userspace.
A process that can open the decoder video node gets it back in the CAPTURE
buffers it dequeues.

The reference frame and the compressed frame buffer are allocated with
kvmalloc() in vicodec_start_streaming(), and the decoder can read them
before they have been written. The first frame is allowed to be a P-frame,
in which case it is decoded against a reference frame that was never
produced, and the padding rows below the visible area are never written
for any frame.

Use kvzalloc() for both allocations.

Fixes: 256bf813ba39 ("media: vicodec: add the virtual codec driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Changes in v2:
- Rewrite the commit message per Nicolas' review.
- Link to v1: https://lore.kernel.org/r/20260813-vicodec-fixes-v1-1-13077b5b6c29@outlook.com
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index ff9d50fb05fd..0b898ed5801f 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1595,9 +1595,9 @@ static int vicodec_start_streaming(struct vb2_queue *q,
 	}
 	state->ref_stride = q_data->coded_width * info->luma_alpha_step;
 
-	state->ref_frame.buf = kvmalloc(total_planes_size, GFP_KERNEL);
+	state->ref_frame.buf = kvzalloc(total_planes_size, GFP_KERNEL);
 	state->ref_frame.luma = state->ref_frame.buf;
-	new_comp_frame = kvmalloc(ctx->comp_max_size, GFP_KERNEL);
+	new_comp_frame = kvzalloc(ctx->comp_max_size, GFP_KERNEL);
 
 	if (!state->ref_frame.luma || !new_comp_frame) {
 		kvfree(state->ref_frame.luma);

---
base-commit: a500db7819c50db59e55f1b4fa1c3baa5a2616f3
change-id: 20260908-fixes-a453297f07c2

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


