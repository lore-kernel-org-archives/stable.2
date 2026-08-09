Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4313A4F31
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 07:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786261443; cv=none; b=Mr5xxROnp3i+EaxDDtZim4jeTT65EoYstc6/XXynqwo96T0NDFC1RT/csB5PqHMi3PibEQV8+5xma+noNa6TyDHb9Vz9C+uyZRrdM2Ervb1qwo3oJLYe7DUCZ2MdzMDp3lCaXrTC5jVKZputmFGQq29xtk4MaeThZoiJxiIIIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786261443; c=relaxed/simple;
	bh=AraZ1rq8LxasfB6TogqLmzZITaAl0hmJqf7mOyPNC50=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCDkpq//N3lMv/N9cswsEJlwkWSZyQXeM+4nccU/Edbb7XbWFWdYsjQ0kss+y0/VLAk9Es7Z+P9dVw8Y85KezqrPTnXIBy5TGhKuj+fRjtSdx4gM5nXuZSvO4cwf/pm+ogGoyI49Wnvr9cNe1eh5lQnYSdkH/gTBqGLabPDhRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Ue5ddp; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Ue5ddp"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso834150b3a.2
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786261441; x=1786866241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9ieAFPZ3KCNYtYRe7iipfxjLEguJtXDiYV3GvLkaig=;
        b=T+Ue5ddp2P13cGPRpcC9wmwp0EATFVw5AB9wCoMXaCA6WMP/EYzdxV2Fg7Yd+p62y6
         7ges9/R9WzwYvYlb6k0FIUxJMPIdGKaezPN3MwbYdXI2fZdUXhV/c0aWtEa4msIG0Tnj
         4JEbD3VogwtBRgkSENfRZAFn0Al7OehWQlk1UfYqfwdtBxXABVE/fjfN/zbQhAjk1KtS
         JPKoo47VkEj5spqN3OgeD0dQ0cnrt3MiHRJp5Mo57ZS+ykNln5RTkSOlkT31pzds2KUu
         LnUKIbOfW5oyH6S5aEY8d/Q6LAvII5I9T9CI8xh/34efBEiNbUHt6eYFsUhWE9ZGTz6i
         fWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786261441; x=1786866241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9ieAFPZ3KCNYtYRe7iipfxjLEguJtXDiYV3GvLkaig=;
        b=EOp3EwZNu2DQa7ZTQ6PMxi1PZzzEdaUKPU+bLJ6n89a+tmJO+5xIoQaaELo8/Q8lyD
         OdCeTznjuMZe6/cgGJfpXWIreZw5wGH2oN6OK4aE2WnJUkqvIENU3/qsYefLSaFM5x7w
         l2n+k3B9++wpGwf0j+xZtCLN/gJxocwx2iGsjdEbC2ByxnsVqAqcKBA4Uo0u1mhJeQyP
         jJGcKkKiJvu0fiL1CxArKh/VeJLXfCtFc4V0Kk5g7kKcSEsde9anO8mLCQ8wKoTsJaOu
         gq+v0A31wzfM+nna3gExsYyXBg3F1rbV7/kjcQVhN28y9tHYXuBNU4y1eSBRWr1ZfmFi
         FOzw==
X-Gm-Message-State: AOJu0YzKWr2jm9ROD+5MclU5PDW5aW4tuQvMn3KXfUojjoWjgGvY9vHW
	ElSfyZakdNkdlmk/m0n23RLKgd7ziPyYXqSVx12G56rGPiQcY1RewTkbEGF83WonFo1sGuxx
X-Gm-Gg: AR+sD13e747B5ULZLvHd2hZl7q5eF8pHCL3jwVlB+be46YSP5c6QQc278baBcdqnh4k
	rxVZQQEuhfzSLT+KDiQpl7x0XcahHS467sS/XLnw4ri7IrLsNrYbkSX2zkw42nPOPtKLJ0K+f1b
	nPnBpO72epuCTcdqzmPBCJxj9AF7IrDmf+JOy5QZPzQ3VXE4MkpRmDHAKoyl3DVU9q7kdaunP1W
	Hkpu6FnNDGCeniaxYlHnfUTxFulB+PNrdKyjUeP1zDsV+T/C0c0fF53In8Kroh/tjiueC71berg
	9+adDCA99DOzHYKjIgdoAqJetlKJwK6Bv6TUUq7UYB2MGh/7jwIBBx6Qjwwadzl52kblUd+5+8T
	aQO5MtNYnU1bpoKAZP0MMLKeoJvs/8VkTz3n/wB47guoDP0FEQcH+19pUztWIzcHYSaZQNazB7V
	eAV0xQybdCbAyAl86BE3KjcMdKyVZ6Fw301kYbJY+QJSuGSCCte1Mez7zWoyQlTniPy/YPyP9HY
	5PblYNBrw==
X-Received: by 2002:a05:6a00:4218:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-84f2e210308mr40466210b3a.1.1786261441265;
        Sun, 09 Aug 2026 00:44:01 -0700 (PDT)
Received: from LAPTOP-7K7V6NC8.localdomain ([120.212.170.8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe8f371f4fsm2443827a12.24.2026.08.09.00.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 00:44:00 -0700 (PDT)
From: pzqqt88198@gmail.com
To: stable@vger.kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	pzqqt88198@gmail.com,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10.y v1] ALSA: usb-audio: Evaluate packsize caps at the right place
Date: Sun,  9 Aug 2026 15:43:20 +0800
Message-ID: <20260809074320.1407-1-pzqqt88198@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[Pzqqt: Backport to 5.10]
Signed-off-by: Pzqqt <pzqqt88198@gmail.com>
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

