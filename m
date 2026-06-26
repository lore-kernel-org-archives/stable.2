Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBA03F7A9C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782481690; cv=none; b=C5XrHdR72iZDgQOnm5kxFq7TJKhtIYrTX/3SKWxjf8tXg8kXdJk2ATtdKVPK2wZJNt2Kuio5nLpsmUtnCtNHdrEV1LpPHiEoYVjB/WAGPUG9iG3FIq6NvLF2ysONSkVmCXlhFhsZui4zx+HT2O/hFkaU604QvUlj0HXYTqR/Gp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782481690; c=relaxed/simple;
	bh=n5Rtehg5Wikz/OKCAwRELwtd1STgfqx29gu7EcctqdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ur3EtVhqSzIbHz/9yWiLcCsR3ee9d+9rSEYMvOImAmt8kZhRHmgIrCisjo8Jcu5yRSwuvztBh9i/1caiFbXCbyI1kRwFg6q9NHB/rGRvHU3bPUH7OPcvGqd4BHsoCPqptj1R1OiHdA1wOuISWnA+r6ho0fyxNK3m/R0mqITZQFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji7N63cX; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji7N63cX"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-46f3ca3c598so792823f8f.3
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782481687; x=1783086487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mYwJhG59Ofi/WzjVAi9x0eXfAYxxgdst32Q14etLU8k=;
        b=Ji7N63cXUKF8jYMAjQWrsW3SXutIDJgK+n3dU8Td91fWZP+J7OkrxUxh1dnWgsHNZ8
         hhas82Hk1syUU1LBJiDpdzt7EpW7cI6OWnyVG8rVD5LOMrMv+vnKgkn2SGMOic2Yh2Lo
         Wx2/jUFVhyu/hUWtQz2L6umWlZBdCDKU9QqFf6zpbkEPw+whm12qpYPl1y3C8OLVOfqq
         5lKztdTVstGWl56UIXpW8AHf8w3MhcB2eSJNu7Q0DbgXLustxCD2rtXEAUdJiqAdJmiE
         Xq5IdEbVsWvNWKCbGVW0i09eU8GWDxl9Z3rJ/qvP11/+Jl1HqE8bPKduE+YJYnUjhiBM
         zncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782481687; x=1783086487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mYwJhG59Ofi/WzjVAi9x0eXfAYxxgdst32Q14etLU8k=;
        b=YvNUu1jeuRqzGAkbGi9lL+Ts/vohfGjbXIdo9bm/5VsPOk+6mQIQ0gzS1uvP3P2dzN
         TAfF+p15osqU8PY2YyH0d6hqYCWdxYiyRF4MUw8j2OjaUHaO+Ww8cjRerKm0UDVrijcZ
         XGptKwaxpF3GOvNkh2GlOql1pWHtT71+ibLXxCB8tA89qY7AnGnkk4kEqskyD4/b8RzF
         kfds6xazdn6Walx9mje+bL4RkjVi6Unv8lLAUjYwM7ne1Po+6rKJ0rkGOYWR1nMNxcVw
         48V/HHlgu7YLXVTDzq/Xussu8bR5Kl25TS4h3zHaw/uey91D2ZGUW6CSkyuLaGxwJvuY
         smqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSFjIMnCtNJK/G4bQW/WVfH508x6fZtTw+7GEugfUKLVl/DPbgUPBww5eo0dEX+Xdm9zUhM+c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Z/CXsuu89+Syn+Z80HbDBBZbHjZwfRVitzXXi68noTk8GrdW
	m1MdYTk55PeR+2U50cI798avznN5bS7/DXTOc0GJCepTSJfnEH8lk01G
X-Gm-Gg: AfdE7cnIE/7i451xGSTgVfP3xI1wiVPrprFPwFtojyGzdQ0maTYrLlc9owDGHQ65L5/
	o1+AS3N9AkFmSUaQDlb26DwuXTMQZB4dUKDP6Xo63Nw+ErD5qUJeYHyHUnbKgWgPARUfjMeoByS
	UL6wCU5s5y4pkI0x8LvIgpPYivhjENIXaId7kG36qnTvLicoX36xnatVhPUEt1UYtLJ82Cs+VCD
	Sa4Hz606bcBIUAzG0vJLafffcCYLQxDfK+mr+iQ7FMyfwt3UH5eN1VDxnBLTaMMrwBCVPnQgspv
	PRDRlWK+eW+yOsiH7hBqsbjU/lsv6+pSohBLDdNuIANa+F/eYE80zKxd9TfOA4eeiRfCLS6BnIt
	aBprzk71zZrkZswe2VjMfGX1BynMA6yrR8fNYfQsNQaLH/43yZ8gMKECYqZJdeQLJVjVnHOe58z
	ZFfPVRM7QVhlnobqUpLPyCt4ZYp5Z/NOrnw0GXJpAt34p7jF40s0NvHQ==
X-Received: by 2002:a05:6000:5c9:b0:46f:dda9:35b9 with SMTP id ffacd0b85a97d-46fdda93626mr445196f8f.34.1782481687248;
        Fri, 26 Jun 2026 06:48:07 -0700 (PDT)
Received: from localhost.localdomain (IGLD-80-230-60-93.inter.net.il. [80.230.60.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm7987878f8f.14.2026.06.26.06.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 06:48:06 -0700 (PDT)
From: Omer Cohen <nevergfx1@gmail.com>
To: tiwai@suse.de,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	security@kernel.org,
	Omer Cohen <nevergfx1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 5/6] ALSA: pcm: use locked state read in snd_pcm_drop()
Date: Fri, 26 Jun 2026 16:47:08 +0300
Message-Id: <20260626134709.27883-6-nevergfx1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626134709.27883-1-nevergfx1@gmail.com>
References: <20260626134709.27883-1-nevergfx1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_pcm_drop() reads runtime->state without the stream lock at lines
2274-2275 to check for OPEN and DISCONNECTED states.  The stream lock
is acquired shortly after at line 2278.

Commit 7bc02ab446d3 ("ALSA: pcm: Fix unlocked state reads in
read/write file ops") fixed this exact pattern in the read and write
paths but missed snd_pcm_drop().

Use snd_pcm_get_state() which acquires the stream lock for the read.

Fixes: f0061c18c169 ("ALSA: pcm: Avoid reference to status->state")
Cc: stable@vger.kernel.org
Reported-by: Omer Cohen <nevergfx1@gmail.com>
Signed-off-by: Omer Cohen <nevergfx1@gmail.com>
---
 sound/core/pcm_native.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index XXXXXXXXXXXX..XXXXXXXXXXXX 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2265,13 +2265,14 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream)
 static int snd_pcm_drop(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime;
+	snd_pcm_state_t state;
 	int result = 0;

 	if (PCM_RUNTIME_CHECK(substream))
 		return -ENXIO;
 	runtime = substream->runtime;

-	if (runtime->state == SNDRV_PCM_STATE_OPEN ||
-	    runtime->state == SNDRV_PCM_STATE_DISCONNECTED)
+	state = snd_pcm_get_state(substream);
+	if (state == SNDRV_PCM_STATE_OPEN ||
+	    state == SNDRV_PCM_STATE_DISCONNECTED)
 		return -EBADFD;

 	guard(pcm_stream_lock_irq)(substream);
--
2.43.0
