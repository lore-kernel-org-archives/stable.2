Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CC54A7CC
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995240; cv=none; b=RwGtlWn1TSlBJ8S4qHKhN32KyA0MVX5q//qdvaHJKqUiS7WPetrjbsevm0MQfNUv4z9BKMA1pqQy2nIkbAG57b6jpjoT81p6qDewQnebibsFtUG29hfQ60+LJkUosq1jHVasOjjEEwL7z1KdH9lS6WIQ3ZLBXTe89XAnonsD1no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995240; c=relaxed/simple;
	bh=sKUZlLhOrMgRwmNi6jUDh1V2/nyPhhj3mYIjf0e2zew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6sweyTox7Y04rgVx5p6dtyvQoUyOOtheuUOyoeOzuQO5b7E1yb6+EYCg6mvtjP7JYoN6cV5atBPyMCoOSxtkg2oKU1761NoFwIDoM8mK4ux/Iy8E0tJvcV8S5f6XiEY7DfbUz5bJOMr0pPVCgLg5LN0Q2xMmhYlvwGxYQy1QoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE7wnSnG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE7wnSnG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48c14a06c95so3434250f8f.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995237; x=1792600037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnSdw0uaL1vtACAdgkw6vpJyes4Ayf/5pwfNbIBD7hw=;
        b=OE7wnSnG5kXUrHEIMDOXj0Umf2juMILqsurHwdjrqLWxh2vR665iyZjbLScZ5XAsPB
         S2rI9eWLV/ehW33pllWR6PdnYzKAgItJYkmeZ+EI4TMXfFY2XWYrFo/r0dU+tSwoqZAn
         Bv+kBDbSjdi0bgBpEOMyPI+BgrvaYtglavWb9xc5diizMI+3k/X20/OuqpHzGqiZKAqd
         NmtTH8djbSbHyBGOWuGrWNGjY91m2SkCun6S/37BU3QasMsR7QzYYoso4zbPYebCenak
         SWmnXLjclARDwxS3KauS0Gj9z4iSOAHGfJVgnCIpdyRZ2LtjKSFuh7D1oieaFlnyXy3K
         2IIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995237; x=1792600037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nnSdw0uaL1vtACAdgkw6vpJyes4Ayf/5pwfNbIBD7hw=;
        b=RnMU7L3eSZA9ThCvgvzYDy209772d+pdKNopnZjekwCZvlyVeEf9X9oi7MtTQyTA98
         6u6EJ2cLWb59lU1aURu9kea2ykYYum8JOi7fj3vzNpAGOUlcaJZV8YgFSbc0q1Imtcol
         Jp24GzndArUWsg2rxhiCiQDmMJH62v7VfhtNDvotkQhl2pg/sIpXyKzdJDLlNQSy62CM
         4LJnL+5WGxvNmhBzYidvXaHMZlFOTq+u2I2I1Fat128SDqQAZHJtGzGhmHDxQ4oKhaXy
         2Gzc2fvx0De5d1z+sLGeXAVZzPkyGTOGpDvJ27KWAlKG7Ro/kkruGZ4iGqHu0au7EUps
         oC8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzpS+EfEdsKaPqSgqwyYDOockM3O1iBHZn/ykj75/Xn/XuxDQ+soClZXySzFujhhM7+Kh9jtxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKadFZk068T2qvq/xhyjNjHFKVKvBvNOQyI4Sc+ewdo7TeBixcy
	Gzk6WFyKgjk/l2b5VtjVZWnB7yu9OFAyl0SOQnOvq/pmqAT/nkH2w54udcfczjndli0=
X-Gm-Gg: AYBFou3t5kEYB1WTRlwyFEwaAFBQSU35o17+YmyVw7i+3PczwUiXbfOk6eG/N4r671/
	txm+z2JdvBLi6XMgbUbBpOaqbD/nUHaEFCdsOooCECL5/HuYM2jlmJEQtc5gLvannQtkvZDC9Cu
	2nl/aLquDKgKjfmBgh2Ot051NukcrqApxYoVui+O8PFS/MpTeS8Vu4jJ0Du/V167Q5VYkyXss2Z
	vb+E4OWmh1KLiLcynmuBWB5/Rw+KfUQj2oRyww3SKHYqgO18kgmaLLpTr4TaFeMNZsnz6VyxxgN
	iUxqP+IE+pc+pEDZXh6Z2nW/BEkWfn98LTMgsQCqUQ3AP3yAa4Mg1Y/U+ijtI99RiCqQRO7k96j
	QnwvWAtlT2RbT3M3XCXPCmZBNXhIKiAj7IhtN9Rjn2dKvnu4Pe4nhnaxPxW/SqAkhuQGHJtKs7D
	RwHN5VwMhZHvgCrCmSQKLCR7/U0c0hc7cjygTdTfnwmtNXAcK/FVuHmqynJTqTLezVe0wqrna8X
	iEb+KJ2vnM74AoLFILqw+JfXA==
X-Received: by 2002:a05:6000:4285:b0:48c:4485:3357 with SMTP id ffacd0b85a97d-48dbacf2482mr29285172f8f.57.1791995236714;
        Wed, 14 Oct 2026 09:27:16 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabc3sm13076890f8f.16.2026.10.14.09.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:27:16 -0700 (PDT)
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Zhang Jiaxi <Z1529105815@outlook.com>,
	Johan Hovold <johan@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/3] ASoC: qcom: q6apm: reset the hw pointer with the fragment queue
Date: Wed, 14 Oct 2026 19:27:01 +0300
Message-ID: <20261014162703.10172-3-tvlad744@gmail.com>
X-Mailer: git-send-email 2.45.1.windows.1
In-Reply-To: <20261014162703.10172-1-tvlad744@gmail.com>
References: <20261014162703.10172-1-tvlad744@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On every prepare in queue mode, q6apm_dai_prepare() frees and allocates
the fragments again, and q6apm_alloc_fragments() resets dsp_buf, so the
first buffer queued after it is the first one of the ring. The hw
pointer that q6apm_dai_pointer() reports is left as it was.

q6apm-dai used to keep its own position and cleared it in prepare.
Since commit a93dad6f4e6a ("ASoC: q6apm-dai: make use of
q6apm_get_hw_pointer") the position comes from the hw pointer, so a
stream that is prepared again, e.g. to recover from an xrun, reports
the position of the previous run until the DSP returns its first
buffer, while ALSA has reset its own pointer to 0.

Reset the hw pointer together with dsp_buf.

Fixes: a93dad6f4e6a ("ASoC: q6apm-dai: make use of q6apm_get_hw_pointer")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
Found by reading the code; tested on a OnePlus Pad 3 only together with
patch 1, with no separate test for this part.

 sound/soc/qcom/qdsp6/q6apm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index ea6680925f21..b6b1ef6833b3 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -285,6 +285,7 @@ int q6apm_alloc_fragments(struct q6apm_graph *graph, unsigned int dir, phys_addr
 	mutex_lock(&graph->lock);
 
 	data->dsp_buf = 0;
+	atomic_set(&data->hw_ptr, 0);
 
 	if (data->buf) {
 		mutex_unlock(&graph->lock);
-- 
2.43.0

