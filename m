Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E09341D635;
	Sat, 15 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786805801; cv=none; b=H2YsDArs53Jd6iw/c6PP6XVeOSxT/yNGEau5ouf/MuSiKmlSkWG3GXI9aPHvjoSQOrI9Ihv7BlqUafweLxDRS1XeltnidGMp7Ap4Pqhe44V64hwF8y0JamPMzewAUFtMHSAGOOn8UksQcA0ImIW8BJGj2ifXsqfn244+zAWvKvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786805801; c=relaxed/simple;
	bh=E7cbrRaKnfEnuB6TrYEj9kr/oZV+HBllIAUlhUhevAs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SOoPI2VFXDhe5dWBjpaCNt6mDgpe3s7ZnQRwI8IgvjI7EeOV0MaJVoN580hM2AVI/QZUgXtNoiI3cY8mMnsLOyembBz75XrNXJNtp3uqP3/oxF4LqQPFJMK37oz7KGPb3XTTYnsg3AYPeJjaSDmO0rctb+53zwTNRlDxPcojkgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=flroNpZZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="flroNpZZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6746C2BCFD;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786805801;
	bh=E7cbrRaKnfEnuB6TrYEj9kr/oZV+HBllIAUlhUhevAs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=flroNpZZeds8B09mO7QvwTXMy28jOQ0Ju9xzui3R0QYzLw8M1XZFeNFpYdp4Bzii6
	 XUACkU3o47B2AxQn623rEF4KKH+4VDPz/bpqQj3kZE705dfDbdIJlZNqZlIdFMQCWW
	 wW33o28uR9FmOi7h/+JC3Rroz1XRXzL0kuw27W8TS3iAzIC7+jIePqPEWKGfkVz2W2
	 HbItKN/rV4v+Z4miSSFh3Fv+PIbK9tg2uMfthtA6OJev4tHGxEw/uC1luo55wDoASA
	 vuNw6mPVbEBSNpRNhOkRmDOU+a51/jcX0Hu224y6n0z5zIWoZKiRokBzMaGSkQ182p
	 mfMi1U43Nl9gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D200FC5DF6A;
	Sat, 15 Aug 2026 14:56:40 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Sat, 15 Aug 2026 22:56:38 +0800
Subject: [PATCH 4/4] media: vicodec: make encoder CAPTURE dimensions
 read-only
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260815-vicodec-fixes-v1-4-12101572eba7@outlook.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=39hTfONQcomxQ23TBhyVDkf40Z5LuSFAHoiUH91wz3M=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrIY69f9S97dv0M2N3STy3Zft8LqiJd3Lz3grX9ijw
 hmzknf1sn8dpSwMYlwMsmKKLMcLLn2z8N2iu8VnSzLMHFYmkCEMXJwCMBHDlwz/rO7x5Nace7V/
 7X/By3KZN7hWZv8MaTzD90bn18z5U1heVTAy7Os44KpTX2Pb+tek3lbsZje7wiLGI8fc9X7/zDw
 udt2ZEwAzA0ya
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

Setting the encoder's compressed CAPTURE format to a smaller resolution
than the raw OUTPUT format makes the encoder write past the end of the
CAPTURE buffer.

For a stateful encoder the CAPTURE width and height are not
client-settable; Documentation/userspace-api/media/v4l/dev-encoder.rst
specifies them as "ignored (read-only)" on VIDIOC_S_FMT. vicodec only
implements half of that: vidioc_s_fmt_vid_out() derives the CAPTURE coded
size and sizeimage from the OUTPUT format, but S_FMT on the CAPTURE queue
overwrites them. The encoder then takes its geometry from the OUTPUT
queue alone, and v4l2_fwht_encode() gets no destination length.

Overwrite the requested width and height with the OUTPUT queue's coded
dimensions in vidioc_try_fmt_vid_cap(), making them read-only as the
interface requires.

Fixes: efec9c815e5d ("media: vicodec: pass on enc output format to capture side")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 36b92f68ac42..6d20a749635c 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -890,6 +890,8 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 				  struct v4l2_format *f)
 {
 	struct vicodec_ctx *ctx = file2ctx(file);
+	struct vicodec_q_data *q_data_out =
+		get_q_data(ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT);
 	struct v4l2_pix_format_mplane *pix_mp;
 	struct v4l2_pix_format *pix;
 
@@ -900,6 +902,10 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		pix = &f->fmt.pix;
 		pix->pixelformat = ctx->is_enc ? V4L2_PIX_FMT_FWHT :
 				   find_fmt(f->fmt.pix.pixelformat)->id;
+		if (ctx->is_enc) {
+			pix->width = q_data_out->coded_width;
+			pix->height = q_data_out->coded_height;
+		}
 		pix->colorspace = ctx->state.colorspace;
 		pix->xfer_func = ctx->state.xfer_func;
 		pix->ycbcr_enc = ctx->state.ycbcr_enc;
@@ -911,6 +917,10 @@ static int vidioc_try_fmt_vid_cap(struct file *file, void *priv,
 		pix_mp = &f->fmt.pix_mp;
 		pix_mp->pixelformat = ctx->is_enc ? V4L2_PIX_FMT_FWHT :
 				      find_fmt(pix_mp->pixelformat)->id;
+		if (ctx->is_enc) {
+			pix_mp->width = q_data_out->coded_width;
+			pix_mp->height = q_data_out->coded_height;
+		}
 		pix_mp->colorspace = ctx->state.colorspace;
 		pix_mp->xfer_func = ctx->state.xfer_func;
 		pix_mp->ycbcr_enc = ctx->state.ycbcr_enc;

-- 
2.51.2


