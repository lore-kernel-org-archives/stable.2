Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863903;
	b=hUqU7O6SwSR+hnwCT8j96xaDNYKxj7B/POqVvSKE5wcvo/G1iNV37GffElU4Y5pPJfGp
	 ibpTkQvVI/a8BWDbbrlPKRLs8M7JlS7ilwelQnLZYfPb3CCq1XebA4Fb37yLopD89IuAr
	 rHCS7Leyl0S9mBB3zIXISBEV7Cd817CTjFe/xM6gTE1zFM9BmituWVbjzEBLTmMOipPch
	 xUbvuAq232BJ9bPigP113gMZRaVffoLQOXQ6Q3pjmWIYlgZScI1U5GqodHzCpTRDx50i7
	 NvGQOQD+mxcLx96fk/QxNa9dZ5Ez3z9cNDajzDDL006HAnpbwag9p5vSz9islkvWVzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nn33RrLK2jP6yegXcMbyk7CADovV75ox65AHlodMd48=;
	b=bX4WEvDBHs2gpu8mMEylIepr1rWrSld4wPctWZ1q6VJXL2eMipbcMk7rBeyW5h2uVvuw
	 DyuU1hz/HUybj3+1yoXXMmDoAdZfaPXV0OixzqoVeaKA4iewwbpIEonem74uOQ+1ulhfX
	 jB4E4GW9Kp53ocFCH8+65oAJg7jtSsfsYEJLYF1dQjz4l8IS/cE8o6W3qB6Mj9te3iA7i
	 2STsXXcjwmZOTMmO1LN1Uv4E0cL8jVvx16BTjFbK6q7VtotjnwYv/LQblgfUCnr/d27/L
	 73XrYaVV1LJuajWSK7pK4CDfH/oQ7DUxOu7Znjya1E7Bis5208ehdoQ/3SlcBmzXmjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U9KL1kyn;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1BC606A324
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 17:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC1BC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U9KL1kyn
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df8fe8513so1657316f8f.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792863901; x=1793468701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nn33RrLK2jP6yegXcMbyk7CADovV75ox65AHlodMd48=;
        b=U9KL1kynmW4e9Kq9IiiNvGdF+51Gbk5+qvhsS4w4NciYSk8hrON1hl1eSeMWhlxgjN
         pJHRkV1N4GJXQQur+n8FXZctAO7+Dj1Vye1rez9Y+Ycum0mArRSLaVD3n4rUgNhR9ptg
         dxY7bl83dz4U+bPOs2ILmjuOUdPlB+BaKLFvDanLiLUO7xWT9mD/H9J+CUUevoGo6UiL
         vnMiw7BshVQdKn0A4qJ+iW7KDfB70MLXj+uLB6GVTHd3dHzfVBsZZTLTv0Lli9Fgi2fv
         6hBF/sURvxQ/bJKeTJ+YvGJ/uw03P0vqo9HnqSfziYQiEYAeAy5u88zgQ2kC2X2H7aKS
         W6hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792863901; x=1793468701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nn33RrLK2jP6yegXcMbyk7CADovV75ox65AHlodMd48=;
        b=KVB6azLYcmKAoJE7meSlN/CicvhvT3kT3ngHjioPRnnDn3r6MtHZHDjdeOk6+MWZOy
         OPS9VJBlBY6l2l9S5aLick9QHfCbsnqeFT0/OuGbg7YpD41rleHXr+DW9iMO5AAsLc8V
         Hu4MwjMtgfoZVA/TghUDluFJNcp0cGieiDfNOXr5L0rQgv8vlPUgc5nCC5sxiEe3hPlA
         /Yfvqm9bb1crC5HG5oqs4pvdinyIyKgFjvQsRb7GUry4oVn2ov58ctq06mt/Qt3I/HEf
         yRvJsAEWUe4QUHj6r4kZnPfWQM+Z52/2sZ+qQBGWeHn65FQdLAOHs3I5sLQEqL7AC/+l
         zWzA==
X-Forwarded-Encrypted: i=1; AKwUvBxsNmyjow0Egphhn09tkZmtskzhTfjf0TJFCoVgNVAywhqI0L1mDRp9SFMqwwhfE442vxkMLJs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIDhV4Xsznv3rNHxdPbqRZXXw3LAoEZC92DUOk63HwL2V9HAfNl
	YYNs5mAfb0NattBsBL91LkLQc0oFb4UMAgKSEdVYfXmceyDjyhbkQY2+
X-Gm-Gg: AYBFou1mBPnHHtUkfN1hMLKtOxxdMhJ2GrJRiuxp6HN2l1hd8YlNZCh0skardxkGreM
	9mQRporRTbYU0xcnhdoKUtov1fKvayWlIgh/v/cglkhh8efrx9gw4bFf+IqHIBW8/zqx63pM9Cs
	DV+uu07ZG5oo9VCk+wPPreKvZCtM59/SQ71VQAsEQfAvbq5RDv+aeOaclM5V6xU+Kn9ej4yX6xQ
	zOBt5cYxCt+HsalmNkEdo+n+AfDa7NuObHkKbkf0xppE1suDvEYRaJDna+1Qs+YDqBUEzwWm+V9
	NBno5ea/ey0R5K+Ns/Ny6/MDREB+a57UQZSXyKTwQA+quz+nd+glur3zxnK+/9HjBqcFe5QcAI9
	AbtSmgX8LELns0dRWkpopsMLm60QOUbxOiy3f+HH5iduHh2tfrJ3R7cM8Qe2VzejlwlIVqjs5An
	ID6GfdXqJD9BLnB5aFJ2Yrw81TFJgR2HcQSFXNq0Jy4eUnqR5bOJ/MpQFRQK1XXzOO/HunfK2yw
	fEUXyQVMNYejUvbysXm2WInfTOi7vAAWejIaVsQGR3tgzMR3ZGBBCMGoRmGFd3s6PNX7mY5iNXu
	oh0zy9zp1tK0phQ+MQSikuVWRZA=
X-Received: by 2002:a05:6000:178d:b0:48e:75f:477d with SMTP id ffacd0b85a97d-48e3eb262f0mr3872646f8f.7.1792863900975;
        Sat, 24 Oct 2026 10:45:00 -0700 (PDT)
Received: from john-desktop.station ([93.107.83.127])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb8d5sm5748244f8f.28.2026.10.24.10.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 10:45:00 -0700 (PDT)
From: John O'Callaghan <johnocallaghan@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] media: meson: vdec: reset the VLD before H.264 decoding
Date: Sat, 24 Oct 2026 18:44:36 +0100
Message-ID: <20261024174436.1835068-1-johnocallaghan@gmail.com>
X-Mailer: git-send-email 2.50.1
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

The H.264 decoder outputs wrong luma until the second IDR picture of a
stream. Chroma is correct. The top-left macroblocks of the first IDR
picture hold garbage that is different on each run. Intra prediction
spreads the error over the picture, and inter prediction carries it to
the following pictures.

vdec_1_start() resets the VDEC1 blocks with DOS_SW_RESET0 before it
powers on the VDEC memories with DOS_MEM_PD_VDEC. The VLD then starts
in an undefined state. The vendor driver resets the VLD, IQIDCT and MC
again in vh264_prot_init(), after the memories are on. This driver
does not.

Reset the VLD (DOS_SW_RESET0 bit 4) in codec_h264_start(). The VLD
reset alone fixes the corruption. The other resets that the vendor
driver does (IQIDCT, MC, DBLK, PIC_DC) make no difference.

On G12A, every decode session is affected. On GXBB, only the first
session after power-on is affected.

Fixes: d7647e7c90f5 ("media: meson: vdec: add H.264 decoding support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: John O'Callaghan <johnocallaghan@gmail.com>
---
How this patch was made: the bug was found and the fix written with an
LLM coding assistant (Claude Code). I reviewed the fix and ran every
test below on my boards. checkpatch is clean; W=1 and sparse give no
new warnings.

Users see this bug in normal playback. On G12A, every H.264 video plays
with the wrong brightness until the second IDR picture: the first
8 seconds of my test clip, with a band 72 levels too bright on the left.

Tested with H.264 High profile clips (1080p and 720p, 600 frames, IDR
every 250 frames), GStreamer 1.26 (v4l2h264dec) and FFmpeg 7.1
(h264_v4l2m2m). Every decoded frame was compared by MD5 with the FFmpeg
software decoder.

Radxa Zero (S905Y2, G12A), Armbian kernels 6.18.45 and 7.3, staging
vdec with Armbian's patches:
- before: frames 0-249 wrong in every run (10 of 10)
- after:  all 600 frames bit-exact (32 of 32 runs)

Odroid C2 (S905, GXBB), Armbian kernel 6.18.44:
- before: frames 0-249 wrong in the first decode after power-on,
  later decodes bit-exact
- after:  bit-exact, including the first decode after power-on

Odroid C2, plain v7.3 (no out-of-tree vdec patches), GStreamer:
- before: frames 0-249 wrong in the first decode after power-on
- after:  bit-exact. Two GStreamer starts failed first with the known
  poll() start race, so the decoder had already run before this decode.
(v7.3 also drops the second-to-last frame at the end of the stream.
That is a separate bug and is not addressed here.)

The DOS_SW_RESET0 bits were tested one at a time: only bit 4 (VLD)
changes the result.

Not tested: GXL, GXLX, GXM, SM1, interlaced streams, 4K. On G12A the
tests ran on Armbian kernels; their vdec patches do not touch
codec_h264_start().

The same fix is in Armbian:
https://github.com/armbian/build/pull/11098

 drivers/staging/media/meson/vdec/codec_h264.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/codec_h264.c b/drivers/staging/media/meson/vdec/codec_h264.c
index a6074de15..497fbada6 100644
--- a/drivers/staging/media/meson/vdec/codec_h264.c
+++ b/drivers/staging/media/meson/vdec/codec_h264.c
@@ -182,6 +182,14 @@ static int codec_h264_start(struct amvdec_session *sess)
 	if (!h264->sei_vaddr)
 		return -ENOMEM;
 
+	/*
+	 * vdec_1_start() resets the VLD before the VDEC memories are powered
+	 * on. Reset it again, or the luma of the first pictures is corrupt.
+	 */
+	amvdec_write_dos(core, DOS_SW_RESET0, BIT(4));
+	amvdec_write_dos(core, DOS_SW_RESET0, 0);
+	amvdec_read_dos(core, DOS_SW_RESET0);
+
 	amvdec_write_dos_bits(core, POWER_CTL_VLD, BIT(9) | BIT(6));
 
 	workspace_offset = h264->workspace_paddr - WORKSPACE_BUF_OFFSET;
-- 
2.50.1

