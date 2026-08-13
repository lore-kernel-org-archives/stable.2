Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD3440DB33;
	Thu, 13 Aug 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601130; cv=none; b=QQMF1ZhG5Fu4BH0jRJlwUtOibglHgXUpgu3qZcSRS6VPkqWriOOCzZ1T1hYDE2eZDfHROh0QDRwkwh2H3QoxbEyrOgY38KBvU0en23swNzy40APjiaPod9LHR476tJziYycyGYBXCpUnqaJimZV2j3ZtTX/Hwg2oYW2+ODvla6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601130; c=relaxed/simple;
	bh=+GZ6H5vplgEN7JubL77C+TQcUORKyeCM4q2zPXvYNJI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FfKvJM1aIiPf+sxFxiMisHttOUA7DD/RhHEiYShlN9iQwUtFn0kbBFZlOvfm0huCXtb7KPSjXZ9FWcQADce6cyN2MmY4ujbqc9EIGuPSwAMQ57MAYVxagjXf1R6hKWRNU8kUDoMnxDEb3wm12THEZL/lyb3jDTl7dbGtjQ7geAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/WdOhsy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/WdOhsy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E89CFC19425;
	Thu, 13 Aug 2026 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786601130;
	bh=+GZ6H5vplgEN7JubL77C+TQcUORKyeCM4q2zPXvYNJI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F/WdOhsyNhjn3Ylm9vvw72U2CDn1sUBR2iPCJY75+3FVjk0GFdskC/OnfpMJY6027
	 XGSLOve/Gn/gLoDSkZIGyBmbqQ0yrRhjcSsO4wjUCpAHj3mzzRsocUoLGqz4OBDcji
	 KHTfiNhV0GXxurLg3Wq3o1UH5fzgulBNAk4T5N6mTBHhFxAQdK9jmsLqJdHw6reAem
	 Hv0BWcFoTl4YgT31jCwi1ZHtmv2CcBV292uaDL4BKG56gotDiS5iqG7NQupxcIl9V6
	 iTDrV1AIsBf7bZvvQCtsrUel0RphSgW4mUN9fVtFFPl0wO+mId2E+d7hQ47wuEXm7e
	 Fvej5lNHF8qeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C026CC5CFEB;
	Thu, 13 Aug 2026 06:05:29 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Thu, 13 Aug 2026 13:51:58 +0800
Subject: [PATCH] media: vicodec: zero-initialize stateful decoder heap
 buffers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-vicodec-fixes-v1-1-13077b5b6c29@outlook.com>
X-B4-Tracking: v=1; b=H4sIAH1bfWoC/x3LSQqAMBAF0atIrw1kEKeriIvQ+WpvjCQgQvDuB
 pePogplJEGmuSmUcEuWeFaYtiE+/LlDSagmq22vR+PULRwDWG3yICs/GXBnzcBwVJ8r4Q91Wdb
 3/QBwAUhgXwAAAA==
X-Change-ID: 20260813-vicodec-fixes-a91ec4217ce3
To: Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Keiichi Watanabe <keiichiw@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org, 
 Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=Co0FqQGmxCGN7homuUKiJci3TA2XlUb++kqLUM8OU6I=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrNq4FcwX4xRVD+VW9a3mMk8/5theWmz79tQTHhnzE
 7+lLBZ0zu8oZWEQ42KQFVNkOV5w6ZuF7xbdLT5bkmHmsDKBDGHg4hSAiWz5zvBX/v/Ttem39G4H
 lC0Sy5pwZiLLyd+Gx+17D5ex5ha42N30ZmRo62NXf/JN+P0zLodwFZb7ugeD53uv33jOxXXyX97
 ZJn85AGjLStw=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

vicodec_start_streaming() allocates state->ref_frame.buf and the
compressed_frame buffer with kvmalloc() for the stateful decoder and
leaves both uninitialized.

decode_plane() derives is_intra from the reference pointer being NULL
(is_intra = !ref) rather than from frame-sequence state, and the
stateful decoder always passes a valid ref, so a P-coded first frame
reaches add_deltas() over stale heap content that is then folded into
the decoded frame and returned via VIDIOC_DQBUF. The padding rows
between visible_height and coded_height leak on every P-frame as well,
since copy_cap_to_ref() writes only visible_height rows while
decode_plane() reads up to round_up(visible_height, 8). For
compressed_frame, only comp_size bytes are copied into the new
comp_max_size allocation, leaving the tail uninitialized for derlc() to
walk into.

Use kvzalloc() for both allocations.

Fixes: 256bf813ba39 ("media: vicodec: add the virtual codec driver")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 318e8330f16a..7ebde8f3fc37 100644
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
base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
change-id: 20260813-vicodec-fixes-a91ec4217ce3

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


