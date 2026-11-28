Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795833406;
	b=EK9wSnQQpbPZamc4uXZtFOmuyzg+Hwg3muV5mMUb60MUfjM8T7K0dOgaIinQYMai84WS
	 0Fqd9dFhg2zd9b7yxU28uU1O4M7QWOcSYM7ADXxdW6BC8pJrfXB7i2d8Cs5ez7kd+yLjr
	 lXKQLRnVhEMUnHGEQ1arCKfPfChn3WKFey79EPVUoF8WJCu6NScW1w+XJIi3C/hc863UW
	 /TDQByEAlTqhrZI94padDluKQlbQaU4ilhCqiSH4SYK0NV0F0OJxzl/ODmt8C6umEWY+B
	 ZZlz8V/lyr0REUNNiRWDQMtlYObXxmKgU1C5Vv13Ap44c1tWfMnWtskuUKHl0jMzYJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795833406;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MTrl40wuvNgA7pyYqP5WH0Tjsk6yd2f8SAlFn28+DFY=;
	b=a65RcX9nO3uPGUvZboiKcfdw3FE5YbZ9mDYUiHC2kNpM2iFiNC7EBbNJwb+dMtBTdmDL
	 wtwYqlAUfwSHRl6AmMDrt5i+urRkYUJ00LBJh9TIhXpQ8nd7xEKNYbnC5zI8zDiSEozDj
	 vJIisIyOYY5MFqvA7VSKkUXTF7jukj1f/Gx3/WYaOWQFrh4O5jf2/KxqmmKZoB0oald/6
	 wXmBCHnze7Q8ZPMWJfOeIf6N0I71klJPzCmP9zAldYbqntOBd0XXUjk05iqkVthl1OIvv
	 Tl8cKA/NihdSvd9Y70xMi5EVsRfum3ps+PIptwMFZ95mpXQRQQjcbxga9IiiViy5PoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=FTzmWO+p;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE0E606A31C;
	Sat, 28 Nov 2026 02:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCE0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=FTzmWO+p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=MTrl40wuvNgA7pyYqP5WH0Tjsk6yd2f8SA
	lFn28+DFY=; b=FTzmWO+pB+EIJ75xxyhoB19Sn7CzWdd80Xpd55uT1L2YjJqDL8
	bwCYSvOfZRHnrOpx+vtJDASGokqqqdm6WAaPRRP6bpZ4n6s2C9Soo03MXIc6V5TV
	1L7rmMZXeuMs9eVtv70Iw2iu27dsScZWMlydvzhbzgjDXM6hmnB+cjEDQ=
Received: from xuqianhui.tail7a2807.ts.net (unknown [114.214.184.233])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBH1EgsPgprzkoFAQ--.3888S2;
	Sat, 28 Nov 2026 10:36:29 +0800 (CST)
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
Subject: [PATCH v3] media: iris: fill in a default colorspace for decoded formats
Date: Sat, 28 Nov 2026 10:36:28 +0800
Message-ID: <20261128023628.24408-1-xiaqinghuan@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBH1EgsPgprzkoFAQ--.3888S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrW5XF1UCrWDJrW3CFyfJFb_yoW7AFyrpr
	1Fkrs8AF4UJr17AwsrJw40q3ZavayFgrya9rZrGrWUCFs8u3WfWr4vkF13uayUJrnxZ34Y
	vF1jyrZ8Can8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x07betCcUUUUU=
X-CM-SenderInfo: 50ld1x5qjk3t3q6ptxnoox23vfohv3gofq/1tbiAREDB2sHyZtdggA9sI

v4l2-compliance fails the format ioctls on the decoder because the capture
and output colour fields are left at V4L2_COLORSPACE_DEFAULT:

  fail: v4l2-test-formats.cpp(414): !colorspace
  fail: v4l2-test-formats.cpp(537): testColorspace(...)

A decoder cannot know the stream's colours before it parses a frame, but
the format still has to round-trip a valid, self-consistent set.  Default
to BT.709 limited range and keep the value when the client passes
V4L2_COLORSPACE_DEFAULT back on S_FMT/TRY_FMT, so G_FMT -> S_FMT stays
idempotent.  The description parsed from the bitstream is still reported
through the source-change path once it is known.

Tested on a Snapdragon 8 Elite (SM8750) tablet with vpu35 firmware:
v4l2-compliance -d /dev/video17 loses the eight format/colour failures
and decoding is unchanged (H.264 and HEVC both decode with framemd5
identical to the software decoder).

v3 only rewrites this commit message: the diff below is byte-for-byte the
v2 diff, so the code was neither rebased nor retested for v3.

Two of the three patches are withdrawn.

1/3, "media: iris: report a platform bus_info prefix", duplicates a fix
that is already in mainline:

commit 1facae9bc3c1 ("media: iris: Fix bus_info prefix in VIDIOC_QUERYCAP")

That is Vishnu Reddy's, from 2026-09-29, and it already carries its own
Fixes tag and a stable Cc.  My tree predates it, which is why I still saw
the failure; sorry for the noise, please drop 1/3.  Bryan asked for a
Fixes tag and a stable Cc on that patch - there is nothing left to tag
there now that the fix is upstream, so the Fixes tag below is for 2/3.

3/3, "media: iris: seed the crop rectangle when only CAPTURE is
formatted", does not apply to mainline anymore: in v7.4-rc3
iris_vdec_s_fmt() seeds inst->crop from the user format in both switch
branches (iris_vdec.c:271-274 and :309-312), so a CAPTURE-only S_FMT no
longer leaves a 0x0 crop.  Dropped.

The *_DEFAULT initialisers themselves predate this series: they came in
with the reqbuf ioctl commit that created iris_vdec.c, which is the Link
tag below.  The ioctl path that stores and returns them untouched is the
s_fmt/g_fmt/try_fmt commit, which is the Fixes tag.

AI assistance was used to prepare this change; I reviewed every line, and
all measurements above are mine.

Fixes: b530b95de22c ("media: iris: implement s_fmt, g_fmt and try_fmt ioctls")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=38fc8beaba55
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

