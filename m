Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795826271;
	b=EfqBadBxOfUpNZgAg5RHBuofR55P79W85NrUv9eOPJmuLw02jQCxMeYV4F1x0nqCybTF
	 Ad8mE9ifnue01KcTKUmfUFarw+3GFzZL91zrCJn/n/YWokjkouCiRCLLWaFLJCzJKs1D6
	 sWU7dE8C1ygzfVn/1EdZncdycmW3gU15NnZ0WGf8j7DEpIRDu3E1WLffark2M2HStPFgi
	 OTDojBtpC6o4ZO0P1LTSsmr+D8/PZxQNlfzwMW4MJOGDBhLqiNLDMsw7g7URGr/jsYkbP
	 ngBk6SAM0Eck29QBp6Ug+n7HeQqn2DyPlo5xc5yiXpTRF1FOnF9OmsxyKhlSH8wpV1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795826271;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=XHNSyP9vXiUABekrjWdiq3Cv7yHc1OpTTdfPh3CIO9c=;
	b=hFpun7QtcLY26026x2A4CqWLJtTyqYhsNCFfkybz2Blvnyhz0S4mlAuXgZpgE+9jJyuL
	 XXiU1hhODDBKCF0B1ruqvZWJsRe4Of3GWlBb6o0fGxdrTTy/nbcxuLdcpF7x4S3CQ3945
	 /XxGc17d23qSfbYunt+VJ1FKC0+MDds5RlIwNZdytXvBY5eaOz4aFmwaz19Fi4LDk3B2s
	 rEA1J7Hb8573Va9SLYZWnhuAuzBe9RbzGWd6qmkh4sDSl1k9Zkpa+y5VBXAWLfRk6vpBA
	 0twDIBgpbsOvwk0g+C4tyoZDGh3osZlbUNBzwXLvn3EwAu0F3VkUiyDDY+O2z7gvYrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=vO02KLo7;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86698606A31C;
	Sat, 28 Nov 2026 00:37:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86698606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=vO02KLo7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=XHNSyP9vXiUABekrjWdiq3Cv7yHc1OpTTd
	fPh3CIO9c=; b=vO02KLo7+e+v+hjpY1cqyiw6dzDCUArVlscqsVWwmXNTKBk1EQ
	PmlvB4qyWlW6kAYLe+XSAvPOxpttprGInX5B8ks89WBmk2qT4OMatf7HyX8KwuNv
	Xm34wLahJklqQDKYIvWu1JkEDmco+W7K44PBxeasX315wxYtjzA9ohmwk=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.184.233])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgAXkTVRIgprEugEAQ--.1728S2;
	Sat, 28 Nov 2026 08:37:39 +0800 (CST)
From: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
To: linux-media@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bryan O'Donoghue <bod@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Stefan Schmidt <stefan.schmidt@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: iris: fill in a default colorspace for decoded formats
Date: Sat, 28 Nov 2026 08:37:37 +0800
Message-ID: <20261128003737.1300698-1-xiaqinghuan@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127152024.2149804-1-xiaqinghuan@mail.ustc.edu.cn>
References: <20261127152024.2149804-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgAXkTVRIgprEugEAQ--.1728S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW5XF1UCryxCw47GFWUtwb_yoW7GrWfpr
	1Fk395ZF4UXr17AwsxJw4Fq3Z3ZayrWry3CrZrG3yUCFs8uw1rWryvkF13uayUJrnxA345
	AF12yrZ8Can8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
	Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
	W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka
	0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x07betCcUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREDB2sHyZtdggA7sO

v4l2-compliance fails the format ioctls on the decoder because the capture
and output colour fields are left at V4L2_COLORSPACE_DEFAULT:

  fail: v4l2-test-formats.cpp(414): !colorspace
  fail: v4l2-test-formats.cpp(537): testColorspace(...)

A decoder cannot know the stream's colours before it parses a frame, but the
format still has to round-trip a valid, self-consistent set. Default to
BT.709 limited range and keep the value when the client passes
V4L2_COLORSPACE_DEFAULT back on S_FMT/TRY_FMT, so G_FMT -> S_FMT stays
idempotent. The description parsed from the bitstream is still reported
through the source-change path once it is known.

Tested on a Snapdragon 8 Elite (SM8750) tablet with vpu35 firmware:
v4l2-compliance -d /dev/video17 loses the eight format/colour failures and
decoding is unchanged (H.264 and HEVC both decode with framemd5 identical to
the software decoder).

This is v2 of 2/3 of the series. Two patches are withdrawn:

- 1/3 "media: iris: report a platform bus_info prefix" is a duplicate of
  commit 1facae9bc3c1 ("media: iris: Fix bus_info prefix in
  VIDIOC_QUERYCAP", Vishnu Reddy, 2026-09-29, Fixes: 94ef75095d5e,
  Cc: stable@vger.kernel.org), which is already in mainline. My tree predates
  it, which is why I still saw the failure; sorry for the noise, please drop
  1/3.

- 3/3 "media: iris: seed the crop rectangle when only CAPTURE is formatted"
  does not apply to mainline anymore: in v7.4-rc3 iris_vdec_s_fmt() seeds
  inst->crop from the user format in both switch branches
  (iris_vdec.c:271-274 and :309-312), so a CAPTURE-only S_FMT no longer
  leaves a 0x0 crop. Dropped.

AI assistance was used to prepare this change; I reviewed every line, and all
measurements above are mine.

The *_DEFAULT initialisers themselves predate this: they came with
38fc8beaba55 ("media: iris: implement reqbuf ioctl with vb2_queue_setup"), which
brought iris_vdec.c in.  The ioctl path that stores and returns them untouched
is b530b95de22c, so that is the tag below.

Fixes: b530b95de22c ("media: iris: implement s_fmt, g_fmt and try_fmt ioctls")
Cc: stable@vger.kernel.org
Signed-off-by: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>
---

 drivers/media/platform/qcom/iris/iris_vdec.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vdec.c b/drivers/media/platform/qcom/iris/iris_vdec.c
index 0dd33ff447bb..2238ef1a2794 100644
--- a/drivers/media/platform/qcom/iris/iris_vdec.c
+++ b/drivers/media/platform/qcom/iris/iris_vdec.c
@@ -37,6 +37,10 @@ int iris_vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.plane_fmt[0].bytesperline = 0;
 	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_INPUT);
 	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_709;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_709;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_LIM_RANGE;
 	inst->buffers[BUF_INPUT].min_count = iris_vpu_buf_count(inst, BUF_INPUT);
 	inst->buffers[BUF_INPUT].size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
 
@@ -49,10 +53,10 @@ int iris_vdec_inst_init(struct iris_inst *inst)
 	f->fmt.pix_mp.plane_fmt[0].bytesperline = ALIGN(DEFAULT_WIDTH, 128);
 	f->fmt.pix_mp.plane_fmt[0].sizeimage = iris_get_buffer_size(inst, BUF_OUTPUT);
 	f->fmt.pix_mp.field = V4L2_FIELD_NONE;
-	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_DEFAULT;
-	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_DEFAULT;
-	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_DEFAULT;
+	f->fmt.pix_mp.colorspace = V4L2_COLORSPACE_REC709;
+	f->fmt.pix_mp.xfer_func = V4L2_XFER_FUNC_709;
+	f->fmt.pix_mp.ycbcr_enc = V4L2_YCBCR_ENC_709;
+	f->fmt.pix_mp.quantization = V4L2_QUANTIZATION_LIM_RANGE;
 	inst->buffers[BUF_OUTPUT].min_count = iris_vpu_buf_count(inst, BUF_OUTPUT);
 	inst->buffers[BUF_OUTPUT].size = f->fmt.pix_mp.plane_fmt[0].sizeimage;
 	inst->frame_rate = MAXIMUM_FPS;
@@ -207,6 +211,19 @@ int iris_vdec_try_fmt(struct iris_inst *inst, struct v4l2_format *f)
 	if (pixmp->field == V4L2_FIELD_ANY)
 		pixmp->field = V4L2_FIELD_NONE;
 
+	/*
+	 * A decoder cannot know the colour description of the stream before it
+	 * has parsed a frame, but the format has to be self-consistent and
+	 * must round-trip: keep the defaults when the client passes
+	 * V4L2_COLORSPACE_DEFAULT back instead of clearing them.
+	 */
+	if (pixmp->colorspace == V4L2_COLORSPACE_DEFAULT) {
+		pixmp->colorspace = V4L2_COLORSPACE_REC709;
+		pixmp->xfer_func = V4L2_XFER_FUNC_709;
+		pixmp->ycbcr_enc = V4L2_YCBCR_ENC_709;
+		pixmp->quantization = V4L2_QUANTIZATION_LIM_RANGE;
+	}
+
 	pixmp->num_planes = 1;
 
 	return 0;

-- 
2.53.0

