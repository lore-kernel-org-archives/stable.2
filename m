Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37563324B22;
	Mon,  3 Aug 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742212; cv=none; b=n9Q9OV7J202ZQop3p3uvKis85Bmwaihnb5P+rH1xUCi9cfg2E6/SXDNZgblRS2ZQuB1pDsZgQIn6YZXcOiujPBom2P5XzsbXjezfdbITBMzN6DtQyOqT12Gb3zwLVHjcEA9DMmpr04lqebZB5SkQKwDUoqb2U/5ZLlHUeHnjwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742212; c=relaxed/simple;
	bh=nW4Oria3JDl4RQUhHTC6Ik0Nt7jezSYNDBlP9xfAKwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kzLjWMkxqDLoAso1GWIr3S8a1UNkcWj3r+E+XP7SnHA0wGPV1xBhgP0ORfKv9wM8A9C3E8P/dQe6o9a8wM2aKnymiVh2ikHN0bdnBBXHEYQxXYsyYbjNLRhpF0na/yzfwIqXeC3YLCTIaV+cV38MIL5q2iKybhBYyCwKpWcqSnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6asfHzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6asfHzA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4093C2BCB9;
	Mon,  3 Aug 2026 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785742211;
	bh=nW4Oria3JDl4RQUhHTC6Ik0Nt7jezSYNDBlP9xfAKwc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=O6asfHzAHoJUgY4Q6Vm4e4JwyiJJ1DTOkTlU2ZKTe65e2GMoPusFY/ZDfsaym+ajC
	 vEgW2LVyTgvBmbqaLwIHSgvMCdmUTJz6fovtduyRWEXElDAhIlTZGebp8oSDtzUcSn
	 oAdiDNDi4eL89dX+jFalkngCKKN5YP0skLI0lLQLNjskpOX9WcDgBoRIkhyYJfbWlx
	 m6z8H4nv0TXWNtnRuamIu9lWM9j5qCTR8iTsgH/D31UHdYimI1hlbVnJS29Mp8FtrO
	 aXL/01UkIFnweesJwepBW6ETEDgkeUaqpbQuIVvEQy+luI77Tmm24dsgEARRxrIVKK
	 gnYsSDv/XAsLw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA564C55175;
	Mon,  3 Aug 2026 07:30:10 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 03 Aug 2026 15:29:36 +0800
Subject: [PATCH] media: vicodec: fix NULL deref on oversized frame
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-vicodec-fixes-v1-1-f3cc40cacd05@outlook.com>
X-B4-Tracking: v=1; b=H4sIAF9DcGoC/x3LTQqAIBBA4avErBP8qbCuEi1Cx5qNhoIE4t0bW
 n48XoOCmbDANjTIWKlQigw1DuDuM14oyLNBS71IK42o5JJHJwK9WESwRplVG5zUDPw8Gf/Ay37
 0/gGlSAuEXwAAAA==
X-Change-ID: 20260803-vicodec-fixes-f8313923e415
To: Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dafna Hirschfeld <dafna3@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
 Nicolas Dufresne <nicolas@ndufresne.ca>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2344;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=iV3617BfwTniNi3UKnCkcCHXT5MEjJv0HupDO6zG/sQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrALnRosKNnO1BXc+WMzrUhcLu3bjFMdO4ZyWL3rLt
 QIzWzz/WHSUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARHZnMDLcaH5U8mXvl6/+
 1pNS+gOWKTrsY/sUo/V66Rm207xfPr0IZ2RorFzk9n7NaZb1re+0NRWOB9+wvZFuvH+22fbH8g/
 5Ap/xAAAntku5
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

job_ready() only honours the is_header_valid() verdict when
ctx->comp_has_frame is set, and comp_has_frame is only set once
comp_size reaches the full frame size. Since the copy is clamped to
ctx->comp_max_size, a header advertising a larger size leaves comp_size
stuck at comp_max_size, so comp_has_frame stays false and the failed
validation is discarded.

Control then falls into the resolution change branch, which calls
update_capture_data_from_header(). That function re-derives info via
info_from_header(), assigns it to q_dst->info and dereferences it as
q_dst->info->sizeimage_mult, with no NULL check of its own.
is_header_valid() does check that same info_from_header() result --
if (!info) return false which is precisely the false verdict
job_ready() discarded above. info_from_header() returns NULL whenever the
header flags resolve to no supported pixel format.

Drop the comp_has_frame conjunct so an invalid header always bails out.
The resolution change path is unaffected, as it is entered with a valid
header. Oversized frames are then rejected by device_process(), which
already returns -EINVAL when comp_frame_size exceeds comp_max_size.

Fixes: 3b15f68e19c2 ("media: vicodec: Add support for resolution change event.")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 318e8330f16a..dfc8dde4bad6 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -654,7 +654,7 @@ static int job_ready(void *priv)
 	 * if the header is invalid the device_run will just drop the frame
 	 * with an error
 	 */
-	if (!is_header_valid(&ctx->state.header) && ctx->comp_has_frame)
+	if (!is_header_valid(&ctx->state.header))
 		return 1;
 	flags = ntohl(ctx->state.header.flags);
 	hdr_width_div = (flags & V4L2_FWHT_FL_CHROMA_FULL_WIDTH) ? 1 : 2;

---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260803-vicodec-fixes-f8313923e415

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


