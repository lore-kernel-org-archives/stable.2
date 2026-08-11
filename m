Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C6044A405
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786460360; cv=none; b=iKhOGAFXmYvvMsaalYGu+CkRpQ+2aVUv+O9skniHbhsM5CpN6IWqSCq6rVSczuznZIJwsfYxZHVixRhtXgMZE3vYa791yJKfLdO6Baaww9G1IvgSfHbBVRsO+Rs/XsVa0deWGPgOKoarRxxLOHt0lfkoPzQdOhbO90zB5t6pHz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786460360; c=relaxed/simple;
	bh=vW0VoaKpYR6UuvZ2TYveGRQwkldVdkjVpuSMwCTKTgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BqJzy3+2UIxHKqyt1D80d6X6f2Nvb0fYcdTT9trdjVILciyThfvw+gx/AOpjbaH0QI8m9+hWa1P+Tb0VkAwAZNXh0EMbavVrVyK8EqWsMK2cxj7r9D4J2oougDEljbjSF3rUfSEiIo7vgdMFU+0SkTutT6cFExWvGC89Vte7cWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCiNZqbV; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCiNZqbV"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e84a6c4bfso1223147b3a.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786460358; x=1787065158; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XFGUKXgNypg9pKlEsqRB8qQHzSOuDwN6U9MUHY9yTYI=;
        b=gCiNZqbVqWJAcjlC4XMjuZYBeBoilNg5zJEBshSrvFBM0/20ISCsECGzFhcRwzddAw
         +ujE6Q7Ml+vaBvfqgYaMLmo5Lap1FdIZvzOI2qC1cdidLFM4xsaQGzEVWNy3XmP660tq
         Q3XoPt3u+SIn74yXWgrOA12dGpAFrq6ep6skf+/INuYuj0Wg5daVtWdSiWuob1ogrqSQ
         19uQq0BeJR/DO0l1tVqsQAqWeIgTAPeLIytv+9HNuPxkOML8sBIoY+BFdF6EP8PqO9Fo
         IhYNY1GWv9CCotmg8SlFu16FVqPtBXoTjA1gn8aY6liO3lM0uglDgS2KxloOqbR8/BJT
         C9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786460358; x=1787065158;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XFGUKXgNypg9pKlEsqRB8qQHzSOuDwN6U9MUHY9yTYI=;
        b=lVAANENPf7+i2HhcZvstR9i0ZKRtz70UDu+aLEzRNuVBhvNOwvNfGZ0eAzfP0hCpiB
         vfr5F6FR7nt8neZj/baqsKFP8dBr8qMNaTrvsB4a/gDtYOFQisDas45zO5UO6P7wPheP
         zjE+09fXf2Pj62uT/HxwBriM59/Om1P8erg3lkiyrrb6GmaecwHhkdIgp1M/siZF7SS6
         MEZ5GiTMnR5mCRfKuXe2h5FykPTlzH+I9EAGmdw1Za7CDSnK6IY1638+Q9eRVhB2lrRU
         FWJ6/7DhCWcQPcpPOh/bVdWJUB7P/15TD5tAqkkAkq8e1YMUYMsOeRgXBOvRZ8a0ImW9
         mK/g==
X-Gm-Message-State: AOJu0YyF/Jj2n07Xqx3e1bdCZzWtlHopnJZ1Djt2egVoPBqNO4Unk3Ck
	VYmOddTHAYcmjeQWBobQn/aW0uPjnIkN8zLANa/etq35Iujoytk7UdcyJ+2xGwq93JmXRg==
X-Gm-Gg: AR+sD127+RAXu/uyeAPs1a3xKYMLDJOJO7IBoQMUig9cswoFKgjzcuqjQPzQ5LrFh1C
	R+DKtqSI/XPr5c1FgS7I74YAWtSlnHgnAcMvyOtnO11m9gKocs/ZqeZJ2ryypT7FdgIwyACZqme
	EUxgHLMuxqpvu3p3VJqu7fIVZY/vzzndPsfm+wAXwKHKCMDSEP/UbjJa0Y1n9aRe0Wcc44tdx3s
	4g8eFos5QbxqN/w+ABAsRRCZajViNBfjh91HEk5pGaXoF7o+wJCnZDaa+1ZeLrWHKXkuRJajLhS
	FdaE9/CWDBtx597IM8SKQZpR8GUbuWk2MKEUTYO+iQmm2xi3OlY3S8uUfH1PljxqHweWV1XhzoG
	dAfgQJckZmpWa8bMmcAHk4GjmqTxR1Vvp+GeDbqO6mI6tN6kU3C6/RvcZNfPzlURqzKeAISwEl3
	F0jAMz1gqSu9uFhkRUWb/eJuIyNsGigLoYu574eJI2Ym4hgxPfZ2xycsv+ldLOEbyeN0QmZmbgz
	HHMFxzvww==
X-Received: by 2002:a05:6a00:4095:b0:84e:46d:23a6 with SMTP id d2e1a72fcca58-84faff3da20mr616615b3a.18.1786460357810;
        Tue, 11 Aug 2026 07:59:17 -0700 (PDT)
Received: from LAPTOP-7K7V6NC8.localdomain ([120.212.170.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa91b63b7sm947484b3a.22.2026.08.11.07.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:59:17 -0700 (PDT)
From: pzqqt88198@gmail.com
To: stable@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10.y v2] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Tue, 11 Aug 2026 22:57:40 +0800
Message-ID: <20260811145740.306-1-pzqqt88198@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 52521e8398839105ef8eb22b3f0993f9b0d11a57 ]

We introduced the upper bound checks of the packet sizes by the
ep->maxframesize for avoiding the URB submission errors.  However, the
check was applied at an incorrect place in the function
snd_usb_endpoint_set_params() where ep->maxframesize isn't defined
yet; the value is defined at a bit later position.  So this ended up
with a failure at the first run while the second run works.

For fixing it, move the check at the correct place, right after the
calculation of ep->maxframesize in the same function.

Fixes: 7fe8dec3f628 ("ALSA: usb-audio: Cap the packet size pre-calculations")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221292
Cc: <stable@vger.kernel.org>
Link: https://patch.msgid.link/20260410143220.1676344-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[王YP: Move the check to `snd_usb_pcm_prepare()`. For linux-5.10.y,
       ep->maxframesize is calculated in `snd_usb_pcm_prepare()`.]
Signed-off-by: 王YP <pzqqt88198@gmail.com>
---
 sound/usb/endpoint.c | 3 ---
 sound/usb/pcm.c      | 7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8e2b90cb5b95..21bcdc811a81 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1099,9 +1099,6 @@ int snd_usb_endpoint_set_params(struct snd_usb_endpoint *ep,
 		return -EINVAL;
 	}
 
-	ep->packsize[0] = min(ep->packsize[0], ep->maxframesize);
-	ep->packsize[1] = min(ep->packsize[1], ep->maxframesize);
-
 	/* calculate the frequency in 16.16 format */
 	ep->freqm = ep->freqn;
 	ep->freqshift = INT_MIN;
diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index f4494d054917..802ed1dbd23b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -953,6 +953,13 @@ static int snd_usb_pcm_prepare(struct snd_pcm_substream *substream)
 	subs->data_endpoint->curframesize =
 		bytes_to_frames(runtime, subs->data_endpoint->curpacksize);
 
+	subs->data_endpoint->packsize[0] = min(
+		subs->data_endpoint->packsize[0],
+		subs->data_endpoint->maxframesize);
+	subs->data_endpoint->packsize[1] = min(
+		subs->data_endpoint->packsize[1],
+		subs->data_endpoint->maxframesize);
+
 	/* reset the pointer */
 	subs->hwptr_done = 0;
 	subs->transfer_done = 0;
-- 
2.43.0

