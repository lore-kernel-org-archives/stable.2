Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DFF41D13F;
	Sat, 15 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805801; cv=none; b=O+0Y5jRdOxSOLCz7dJvgAYnjIhlU/kKcqD80uYaPLWMYxzLN2r2IiRKpMzjgCQ8P9LNmiU50ml39NwqhgZGI655L3bSPkWXvg8hmuHHls3Zj3TL0c/vjZsECTL3MPEju5vfBQ6wd/BgWf7uDz9mpemyqrDyQt79Dg4hSlXwfpNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805801; c=relaxed/simple;
	bh=3quwtnblckAjT2ds5UWdPCagF676MycNoyOJ/zGFrFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzJ68y+X+Bl4LWGnVxRcFXArPzQ88waaek2pmyOqqeXHGh25Dk2R5JJPDGT/bIPf/XP7bIJlzOGHBpNsK6laXgxW6CNwSAXa8qDIOIAu/uFbOAUnLgEt8Q2aEzUkHZ8a5ci1OSHcR/47jejv+uEteiBjM8S9FAcLQZ6ZErTZ0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgCTsBV9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgCTsBV9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DFEF0C2BCFA;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786805800;
	bh=3quwtnblckAjT2ds5UWdPCagF676MycNoyOJ/zGFrFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EgCTsBV96q2ihFKObcUTovF68ovbyQcrFODA9A9n5bLDAzqGDcNank/KFjRnrAoSY
	 9mYZKH/IgZ2hlj2+b6/ySXLXKHvPS4CCiC1gF6O7mpYreUwaMggbSm36nHE0FBkS2S
	 K8ig3ejDUY0d+Kvbl2ccVv3cqU+tNDnSKx98II0GmwG31DycAArlZNmdKidPwpJ3Rx
	 mffLXxxzEUlwiP08TpbJd8aKn7uBxclmTVbgMQyou4NnjI87IoRGSLRwS8CSFyT7cR
	 pun6iRgZx6AGkYeBYRzr3Tw9CSF1AMlBGCCF/i+UZN/Cz/DtyFJq9Tccr9ZM3QBCA6
	 cP/wy/W0GSXlw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C216CC5DF6E;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 22:56:37 +0800
Subject: [PATCH 3/4] media: vicodec: clamp visible dimensions on S_FMT to
 coded bounds
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-vicodec-fixes-v1-3-12101572eba7@outlook.com>
References: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
In-Reply-To: <20260815-vicodec-fixes-v1-0-12101572eba7@outlook.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Dafna Hirschfeld <dafna3@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2305;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=xw+SM0NXC9kyoKDEQVYsDRhjEC52Kz8+luL+uJhz9SQ=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrIY6tc5t0XfZ2C7auOxbVPr91OOvv2fP+X1y5uyfL
 jy3pHLM17R1lLIwiHExyIopshwvuPTNwneL7hafLckwc1iZQIYwcHEKwETa1jL8T1zPKLn76u4U
 l2tvfv5apnHY/splvr+OzNr+t5p2u3WEpzAy7EjtnTrvrK6c7Fxe6fiyBq9e/fsG3Hp/z1vZLV5
 x+OIZZgAcyk2d
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

Setting a smaller CAPTURE format on the stateful decoder lets the visible
dimensions exceed the coded ones, and decode_plane() then writes past the
end of the capture buffer -- a kernel heap out-of-bounds write
controllable from unprivileged userspace.

vidioc_s_fmt() writes coded_width, coded_height and sizeimage but never
touches visible_width or visible_height, which vicodec_open() initialised
to 1280x720, so shrinking the coded pair leaves the visible pair larger.
job_ready() compares the bitstream header against the stale visible
dimensions, so no source-change event fires and decode_plane() iterates
over the visible height at a stride derived from coded_width.

On a KASAN-enabled kernel, a 1280x720 I-frame decoded into a 640x368
CAPTURE buffer triggers:

  BUG: KASAN: vmalloc-out-of-bounds in decode_plane+0x1bb8/0x34b0
  Write of size 1 at addr ffffc900004b8080 by task trigger_bin/69

  Call Trace:
   decode_plane+0x1bb8/0x34b0
   fwht_decode_frame+0x173/0x620
   v4l2_fwht_decode+0x595/0xea0

Clamp visible_width and visible_height to the new coded bounds after
every S_FMT, maintaining the invariant visible <= coded that
update_capture_data_from_header() relies on.

Fixes: 3b15f68e19c2 ("media: vicodec: Add support for resolution change event.")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 318e8330f16a..36b92f68ac42 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -1029,6 +1029,11 @@ static int vidioc_s_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		return -EINVAL;
 	}
 
+	q_data->visible_width = min(q_data->visible_width,
+				    q_data->coded_width);
+	q_data->visible_height = min(q_data->visible_height,
+				     q_data->coded_height);
+
 	dprintk(ctx->dev,
 		"Setting format for type %d, coded wxh: %dx%d, fourcc: 0x%08x\n",
 		f->type, q_data->coded_width, q_data->coded_height,

-- 
2.51.2


