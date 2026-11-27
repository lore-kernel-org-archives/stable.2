Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795813753;
	b=jELfJ6vCcz5Q202L/9EaIQRoUQ7guz02YVyq6dxzFAjKjHRpJVDZexvcAhlrZzsRXgd6
	 G2v/Khec3Zll3AW1C4lofsD6+bdQMG8DzCc1PKAAppLWzyRsoeqzNPh5l1stXUsRP5cjL
	 GZDjQVBR7o6UhABeBNl2cRqhs0y3tEmAYdzQc1ifHSbdunxBOTgQ04fuoNJOcFwfowUhA
	 sFsvnWQfND6IO9IZ8UFNvBHlMATAIHkL+bhx2qUvkJL3q6+hD/EwJ57zYsTlmHkqPMej/
	 BhlQIkP2yFDC8bPnZBgxd7HElPeyW2DABEVE/VGL2m9TrbuTB4Ekw/SlfDJGfE/EG8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795813753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XIvy0mpNH25dJka9yiHVSc+lFF3CQmZ8/QH30h3M4Z8=;
	b=P/emB8E9cCwnQirjo7xLMSaFGa2T4D8I7Ru7RfeTQGoLpBbObHE7FF4dHbR3LYDkcdRW
	 q6bU4Apw0K10TicLFsUk07gjiu/fNUt7jK8ayeMRqE3zvFynn9M+3egA6/OwcAgGYSoYQ
	 d8DaXj/9QR0xm67MEKmO1MPtg9F2N7/Hp15/sIlwmlmc3+HUk0oc7D6WM/EoCtbxjFVJt
	 IPZtFyoH9qcdSxcJRuLP1Y/nFV0s/Is414gEwhTmFYxpUfYe/5VRjwHR95LKuhx2dw6Zr
	 V4mIzJEDWwt1YTNrJS+1p1wH/IdYCUfHaeo2O49BD/OvKrhz9VJ1FmbRlTWT+Vu0zbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxCEb+7z;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD52D606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 21:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD52D606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sxCEb+7z
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5365d725440so74993261cf.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795813751; x=1796418551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIvy0mpNH25dJka9yiHVSc+lFF3CQmZ8/QH30h3M4Z8=;
        b=sxCEb+7zA+wFTPzdrar6GAaO3t7CBZTNjXIZfaB2FTtT5vTG997JcNdHGjN2KirZy/
         eqLILNLSuus1tGchZzG8TuV7IlqZeNA7LMxqICsaaiFAYlHISVzhBG0kVtAb7a7yszGI
         V+pcEFopGxbc1bIc83BxedgG2fe49+YS7PHmIyge52rb0W16DDtO7wB0LMeAXgVIt/ra
         ImHbZfvAbvMi3sZs4FVS8/nL/5o7zTBigtOnF59wGdKzD1MwSii9ZvcTU2caWHWxeY5O
         Pd5PAUCbf8JDUEg2tqfjdF84qf4ksqT1yyYSqpErHWwsYUHD8HT1KCGlMpwqZBhiZEul
         /RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795813751; x=1796418551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIvy0mpNH25dJka9yiHVSc+lFF3CQmZ8/QH30h3M4Z8=;
        b=TGwhXxk36o6cDRSFlOX7l3fpt6K9Cwlcc05AKXt2AkHHwFA0fo2rYrvng5jqhwz6r+
         dZYOVg6R3/6tN45cLUd0Ee6vnoEOltIJFlWpF0XJaRLx5INx/taHSSjfkLCzZKneuCS1
         xm/7CAypjK+kbPjw7BBIUFXBsFR0ZO/iQBwUV8HlGwHLMlCAu8dzjgtA7qKPxCY29kxQ
         AeJRgTZOIPOkqWeTET30JNgUMOkhCADsqcPP/Lu+JPq+cS11xSSpgwP9WkNVqEPhZSNw
         s1Q64h6f1BWoA4SFLfvnvkmYv+PohO6lH2TxDVywgkbQVOUUnTrlHjLgAHNo3y6kjqNr
         Wmaw==
X-Forwarded-Encrypted: i=1; AL+hErF4yTf1G8U4OLB0+zXlgaop316prWT95FJyTU4YzOUXiFb9AhKWrZ2vV3VwErSi9gQVmf4ApFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+cB2n4cuQkroeJ/IuIjDf6Kr89vupVWxqbh/h+GmctOKdgSUoG
	zLqBbppb4AoP86zE1HH00aV1jzkAQ3k1CjnnoBNXcgMAYiJXlFsTqbbcarnPCDIvBE4HnT7v
X-Gm-Gg: AZFdTZfIbcA+uGevZBFM+0niXDq8X5K87mZNmUI9s28dq0df0jmi66IrlkJ7Mj73xtf
	uyL3LrhaAJ7sTwV6xwUODrITNYwA9u4V+yNL1zDVgU1UCo89IhGeR6elLoR8sG/tbI0EVA2cOW3
	LMkU3k2fHJCf53mTiG1JY1EWXlc9RivN0x28nGmUAzPH7ObIrO3qNTaAQbiPNeolPn1VxqtdQrX
	zvAWhseBOvB9KOaygu1MZ4jSz+CHnrC8WWi9XaPFJR5uoDPG9zY0GBwWUAbWDCjC/xzf0L5yrct
	nDfw1SerXjuck9+TuQG4OGuRuqwARgzDaSIKvZKarR+9QCQ1eFbFgcLI1HKNTSQd9C7VyN5pF+b
	qWyf+bkZkXo0Tq0mf/R+Xa/2p7JlvX6CpWutr/MjpHU/RBpfHvPv94wVpKeeZaUTTX8ODfqcLtD
	YbdobIT958LiGUjgQBm19RbB5ypjYCzE1Gn85kI/HOucS5LGRLGGL7w39uS7Wy88RpQ68z3L2sw
	/0SzdKH+hmBysqsSmh7YiOf8YJ0ET/M6JDO4ZyYDn0X2FPkYbae+hQa0t6/4cRZmqqUhvn7jc2i
	9wQ2DwnjqAFoCzUEAuMMT43eHtLc2YOnUr2gq0FH/XkdQTtlBRPS3PLuPnmEu4fGjeDzPfDDG31
	XSP2xphUBXdVSPwO05C0YYKrCYmIpI4vJjGZuvGrQ39wZeJnyOP6Wczrd9gI8WGpvrb0GUPo/H6
	Mw6CVh25qS9t27xO8TiUZVQVitVrGCRokDdGdxjqhHZBWEjbf2GaJ1ExEUAmyRmfVvOtlBHz6Zu
	ff462gO7deoq3FLaeqvFhlPhjXHlxb9+OTiT88r6DF4kQ==
X-Received: by 2002:a05:622a:a10:b0:55d:17e:f87 with SMTP id d75a77b69052e-55d769374d6mr471770991cf.1.1795813739524;
        Fri, 27 Nov 2026 13:08:59 -0800 (PST)
Received: from LRMS.tailf8556c.ts.net ([2600:4041:5046:1a00:2403:c7fc:983f:c934])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7882e32dsm219584681cf.13.2026.11.27.13.08.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 13:08:58 -0800 (PST)
From: Jesse Casco <jesse.casco@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jesse Casco <jesse.casco@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/msm/dpu: link Glymur layer mixers 4-7 to DSPPs 4-7
Date: Fri, 27 Nov 2026 16:08:57 -0500
Message-ID: <20261127210857.65336-1-jesse.casco@gmail.com>
X-Mailer: git-send-email 2.56.0
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

The Glymur DPU catalog defines eight DSPP blocks (DSPP_0..DSPP_7), but
only LM_0..LM_3 set .dspp. When a CRTC requests a DSPP per mixer (e.g.
for a CTM or gamma LUT), any third display assigned to LM_4..LM_7 fails
resource reservation:

  LM_4, invalid DSPP_-1
  failed to reserve hw resources: -119

Set .dspp = DSPP_4..DSPP_7 on LM_4..LM_7 to match the declared DSPP
blocks. Tested on an ASUS Zenbook A16 (UX3607OA) with eDP, HDMI, and
USB-C DP active simultaneously.

Fixes: e2aeb8deddae ("drm/msm/dpu: Add support for Glymur")
Cc: stable@vger.kernel.org
Signed-off-by: Jesse Casco <jesse.casco@gmail.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
index 4eb4a0e..280df25 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_12_2_glymur.h
@@ -175,6 +175,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_5,
 		.pingpong = PINGPONG_4,
+		.dspp = DSPP_4,
 	}, {
 		.name = "lm_5", .id = LM_5,
 		.base = 0x49000, .len = 0x400,
@@ -182,6 +183,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_4,
 		.pingpong = PINGPONG_5,
+		.dspp = DSPP_5,
 	}, {
 		.name = "lm_6", .id = LM_6,
 		.base = 0x4a000, .len = 0x400,
@@ -189,6 +191,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_7,
 		.pingpong = PINGPONG_6,
+		.dspp = DSPP_6,
 	}, {
 		.name = "lm_7", .id = LM_7,
 		.base = 0x4b000, .len = 0x400,
@@ -196,6 +199,7 @@ static const struct dpu_lm_cfg glymur_lm[] = {
 		.sblk = &sm8750_lm_sblk,
 		.lm_pair = LM_6,
 		.pingpong = PINGPONG_7,
+		.dspp = DSPP_7,
 	},
 };
 
-- 
2.56.0

