Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A5351C05E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791995239; cv=none; b=pB1JQcBq9FpUZCfU3aIHqqTNCRndplzPKWweYxh07CUoqcqNudneufvdvbPvIqIzCFip+fYrrRgVSesef0kL/ao+QZrAexAf1XgFUIagw4LmrVxJlWcHBD4YGPg7bktzK+UTeibOrz+lzdvX8BPUZVH3BjCPevEdg0ksWNWIF8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791995239; c=relaxed/simple;
	bh=w0UxMJpxTIbUUoxkjgdBbOWY9aaStFWuKEVF+5GN4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOOsiptCOWJ8SMRBP40TMGQQLpr22NHcbQ4u7VJPqb/XRXG50k5sRWp26m+QLGcWxgg8fZw9oYdFkKE+3x7TktYaBMbOxSWle6ki1xkN3eZw2IKX04n/cxSPqCz5RuPpdWdInTXkAKPW7f3jHc8Z9Z9JUHUdVDFRqCiEKJh1aZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r95+R2JZ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r95+R2JZ"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48c4d870d54so2758125f8f.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791995236; x=1792600036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fMXZF8oI/JAcZ89EGF/inoVVxrty6tqZd5ZRgOp/8l8=;
        b=r95+R2JZp/2G8PexSfdsPuEbRHz4i2Xb2MmGIWh1bh4uKdpf32m7izvJRW2nZnG/gy
         bFwhhzV4oOfO72KLGq/zk6WQPEyrmlkdFJIiJ+K+sqKefIsLmLVW/OeVFc6k6/mjzcR9
         wIsPB3hCGIt9dpiIubtsXYeIzhh9eo3MGUGBfH2B5900kTZouGdqvw/4MyKucB49LjuR
         dNAx5aZqOrjonIikXXDTz/rUgEhcPLHFZxekPtsYa2G3XGRIj9Ij8HpiJoaA6TteKG2i
         j0TtB6fgVntEl3w4glEpl167tO3TcbI1zktv9CKiXYDSeFl5oGLKZJl/rgUPaU1h5PFG
         qQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791995236; x=1792600036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fMXZF8oI/JAcZ89EGF/inoVVxrty6tqZd5ZRgOp/8l8=;
        b=EOODQEHfZu/Ze+9iU6TzFEoyEAa5yQqusmM3EUSNgErbw0tmhFINEJM9qLpSUZ2NV6
         dU05lH9EPXGP1QEkHccq5Zx9MRPMt+JufwwlimxjjCeyoCTyFh+my3i2MZXMebCS0UcH
         ZTy9AhwZ1Zb11qYpvOY7KST0a+vZorFu6rwEsBP8NH/efAHGzcV+xVE0Bjqjr1/PicQv
         Hoq5s8Xqey6kPd+OKsSodoobaKoHHH2tmMqiGD+EE9K6VuegFHc/6rn7uzOk04u6trzT
         JelCwhKB/cenXeBdk0QfZ+JMSuejiFvKRrNPP6Wf3wBgpxa31Yc7h6Y+aXznwlzhGKow
         rYFw==
X-Forwarded-Encrypted: i=1; AKwUvBxsdrIioXKjeJ+y5LqBGWoLX3r/Ww6oy+7PRSY8lUHANJYYx+lIMdP9V2fEsPOfL/COeNAWznk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIb4oJJeziIuwWYaRzFSvEblZGNBJwCVkIVxIm4pl8J7gZOLvTQ
	odtth9SRdF+ZLyEaP4yu28k1k2Bm7knDqlkhBrkdaAkEsZX0Z4zLB7PA
X-Gm-Gg: AYBFou2037of9rUUcs8kFWYbciN/PREh7R9PcaORCbuVdoyVP5NZLVdjTadMmBER/FY
	4u2kMyxHFCe4vaEZhnLUHXXT3ePTtnkSo+eGo81HK/VPD/kluuh9TCshVlTqKnk9ocaM8slGk5U
	w5u5xHRu3oZWhov3qV1C+t4854dYJ518j7xmeZNttzxiEEF6pUwt3fwpSnonAHu04I1sT+LHx8g
	YynglYQnI8QjY/JK3wy+Lh5NGH9krZbub15f63gz/F7A82TuvDcfVS/R2I8PTXd/1XD/TBI6LsX
	HTvaUzMizjc1UgHKkgmXrFf9LqV6kF/XWn3ujIaHShowFQkzHD20g6wEw1ZGKFCSh3Zbn/Ozqhy
	zaw/crihVjKFG8eslr45g9TUHumbUk4o+rarvo4l9/9+Bc1co3f21ywfFgd1ctTa4SlWayzy3xb
	KIZL2xRIxIB4joPgAM3gD7Unnv+VK1XyiImzKrfTRduyK7HVm571UjP/bfPj7X85Et12kHogXyh
	LWQca0HMwfm1rWnddgCm9nEsg==
X-Received: by 2002:a05:6000:471d:b0:48d:f068:6742 with SMTP id ffacd0b85a97d-48df0686929mr2512960f8f.3.1791995235501;
        Wed, 14 Oct 2026 09:27:15 -0700 (PDT)
Received: from localhost.localdomain ([188.190.249.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0aaabc3sm13076890f8f.16.2026.10.14.09.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 09:27:15 -0700 (PDT)
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
Subject: [PATCH 1/3] ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0
Date: Wed, 14 Oct 2026 19:27:00 +0300
Message-ID: <20261014162703.10172-2-tvlad744@gmail.com>
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

q6apm_dai_pointer() turns the number of period buffers the DSP has
returned in the current lap, 1..periods, into a position and reports
one frame less than that. Commit a93dad6f4e6a ("ASoC: q6apm-dai: make
use of q6apm_get_hw_pointer") added the "- 1" so that the end of the
ring is not reported as a position equal to the buffer size.

One frame short has a cost once the application stops feeding the
stream. The DSP returns the last queued buffer and the position stops
at appl_ptr - 1, so avail stays at buffer_size - 1, below the default
stop_threshold. The DSP sends nothing more as its queue is empty, so
no period interrupt comes either: ALSA never detects the underrun and
the stream stays RUNNING. A poll-driven application that missed its
last wakeup waits forever, and drain only ends on its timeout, with
-EIO. On capture, the last frame of each period is held back until
the next one.

Before that commit the position wrapped to 0 at the end of the ring.
Do that again. A full lap is the start of the ring, and
snd_pcm_update_hw_ptr0() accounts for the wrap: the position cannot
move by more than one lap between two updates, as each returned buffer
calls snd_pcm_period_elapsed() and the DSP holds at most periods
buffers.

Seen on a OnePlus Pad 3 (SM8750) with PipeWire in interrupt-driven
scheduling: after a stall the PCM sat at hw_ptr 78239, appl_ptr 78240
(avail 3839 of 3840) for two hours.

Fixes: a93dad6f4e6a ("ASoC: q6apm-dai: make use of q6apm_get_hw_pointer")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
---
Tested on a OnePlus Pad 3 (SM8750, AudioReach, queue mode) together
with patch 2, with a small ALSA test program and no sound server,
buffer 3840 frames, period 480:
 - write 4 periods and stop feeding: before, the PCM stays RUNNING at
   hw_ptr 1919, appl_ptr 1920; after, it goes to XRUN and the next
   write gets -EPIPE;
 - drain after 8 periods: before, -EIO after 182 ms; after, done in
   78 ms (twice), and 18 ms for 2 periods;
 - 60 s of tone through PipeWire without an xrun.

 sound/soc/qcom/qdsp6/q6apm-dai.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index b0b10ba51c99..58beaf906b9f 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -613,11 +613,15 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 		ptr = bytes_to_frames(runtime, index);
 		return ptr;
 	}
-	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) * runtime->period_size;
-	if (ptr)
-		return ptr - 1;
+	/*
+	 * The hw pointer counts the period buffers the DSP has returned in
+	 * this lap, 1..periods. A full lap is the start of the ring again:
+	 * report 0 rather than one frame less, so that the position of a
+	 * drained buffer reaches appl_ptr and ALSA sees the underrun.
+	 */
+	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) % runtime->periods;
 
-	return 0;
+	return ptr * runtime->period_size;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
-- 
2.43.0

