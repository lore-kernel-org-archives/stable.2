Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794543673;
	b=b+Df/nJ99GQ+A8jICtBvKp6mmwQRYxsmHaKNFX4oBZRsBAgQ3icZ/7G2u4pKrSi871kN
	 IwxWk8dg65NpM47NknFS/ohq4SLSnpeDQmGCBOFg8UXG7xGrC5qLOY+THEjB0rVMOsr4v
	 HGPaFrehnEA7Nb93zcQ+x5kzyowETiI8/AJlyJ6pJlSJMb+ay3A8LJvJaJd6NrlprTgnB
	 1Te4aw3FRUCxu+ZGM9TcEMJ7PQ2hBTK2TsqiMO0Ojw261lTR817KBS15kJtp0CN4sDTmQ
	 nUVTSo8NGcYBxqQUrbJ1s/9VTjrgmsCHHEXLBw0scYiCHs03TVD02WTUuAp9yd9fAZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:In-Reply-To:References:MIME-Version:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=BdNFe7I+aOZIYc5jfAvJU39qKEvdsp2/ywq7TpQP4oM=;
	b=SQdYrMj+kHlwF/VA/7SsNsStP2LRKxMKZ6AGkBOTX+TgmFnT7uQrXjkq4sTKvw/vZKJ2
	 UJsM7ZaNusXZZPv/CR4uh4FawgqQxEu1Eb1tqk6IOCiWQAE+6kDn/k5rgi/kOyDOyWwaM
	 eSVfImv+VWV1B5D9OS4zXyLpgPxWtLUopf02YU5yv1KJfCVfk5j4P+ATxygP9o6eQsICE
	 GYiseijylgNJubGsb0M5kjCFaqjR91oKwc7Lon7Zw9WWkXKQi4YjEQEtWXwU9aLCFZoDy
	 w6KQg08x747ObFKAFvntJuf+9H2mhvNLtGqZCoXuPdOhHTmCthh9cYNsk/mzZ1B5jgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcOP6SPw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB18606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:21:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CB18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OcOP6SPw
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53664b4860bso9346821cf.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:21:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794543672; cv=none;
        d=google.com; s=arc-20260327;
        b=hj88TW+oYWHVJ/GKzLaMCOWV/DVlTNjinh0QJB8/KfYPtN261tTUA0Q4uwn4KJfpl7
         vCkvL4y7d4RaZOlAo/lmm3mVNLCPdvHTyBrIMvvjwVRmnjEatKKYeuwM65iLtG1PjrOt
         cZ4qvkh5VqkCVfxdzSV43mM+1o/S+UnXmVpltoUoZqIzLqOkt4DHvY6JSzaKDCgWW79e
         QsjD50DMx1DMABwbkqeOpFo0ixyq+ZTZqxmSMOSa9G+atjydiskv2nTDLAyn2Miixbnp
         sx7uJGnABlq3jdl78deIXnW+JkgdntMdwIhb0YjZcEcbg2lLOlHFAX6zPTSBZKM/Sf68
         EWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=BdNFe7I+aOZIYc5jfAvJU39qKEvdsp2/ywq7TpQP4oM=;
        fh=9lRVJQCnPHe78LwqSe2DlXptGQWOavZlYyf0XHhSfKI=;
        b=RAdrtdPQsx4gvRO7LpScBDmy9+GCKce+Dh7qgNsuuH0bzroBtyUajs9qeotJD6kQC8
         QoCqJfQXiETqfvgROGGUIBy0gaPl0+Eine3ETUI952n5S4byXSApZ0KTqLI1Q38MlALf
         1xsY2KslX6H54iyGY7j9SwTqhPr7P+E6GgXUEJ0IPi6HbZ1f/4/u5BsJZiqu8zhsaqZl
         CE4Ecd+WVaNJQPRlUs86yR5zSqSOhAtOG9VnSoTQxHVlTi8BV5fC8T714uv7Uk/Gipkx
         GDHpoGe5rrpU0uP0FWf3EUXK5Y3irtzG0NbpNjYrJMbqrt2g2w+XPEjMY1ZUTmnYU389
         6emg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794543672; x=1795148472; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BdNFe7I+aOZIYc5jfAvJU39qKEvdsp2/ywq7TpQP4oM=;
        b=OcOP6SPwfGVjfk2vk7Kf3JWIasna8TKF5+LlJEBONoNmpJXqQrJvILfKRrsFawcrdm
         IvE9pAsj3dXuzzQ8AE5TbZS/R9QMlZRAPMD1CtMapbUPY0IftEKFV1+Y28xZFSgLaRWX
         DoLvd+aqdCs/sNUNZcbl1Nvy1ciTiuidyK41HlSjCLeAwMlnRbmXNNKXaTF4yq3v+TeN
         X2V+M+PTuv5Jw6FN99QfkFGxCM+o4A4fTueWz1k4063wiX0wlMi1KxJmbJBBpt4Juumt
         3bfKWTDBuCLriIUR3uG0JBbQ/rvmRNAp7QeFQKNKf2huongfnqyhbgrNA5gmr8rnLxfS
         65dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794543672; x=1795148472;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BdNFe7I+aOZIYc5jfAvJU39qKEvdsp2/ywq7TpQP4oM=;
        b=iVDoP4yFjBeHBaRD+F0sLy0dH8cAnvxyJjGUo9a+zCJi+HstKZ5XEdmK26lyn/cxEY
         86Z7J49nxn7BPCLHOQXeySc7+lPwJpeokGhpWUng3wdYHMhJ8rB0KsstX9ls5sZ0OOkX
         mnvOlrwiL3dzUdB3A6SQlyoAekEyohEsemIQQlnj1GZDZXh+CMdeDn1O7i5ygoEYW3W0
         hNFJ1j0DUzFXs6LvodzdQ0gh121mOL09g4JTnd7JnVFzzr05Lid+AzgtDEHSARkhCwHH
         ZXt2F79dh/ZfMwzgqloZ0XuRUT2e6dpuFsi+WNbascSo+2EfLRoVPzFTNoEDjOL110BG
         LG5Q==
X-Forwarded-Encrypted: i=1; AL+hErFPz3W60SYEim5LnEPkN76ORUaOdq39PGj9YxZ9Ij76RXYV790Fye629gNUt/h0b6au15ba69k=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FO3z4AnR8kb61eB9lbp5eBIZdMd2JVJxw0hMXVQyjLD0ZWrHc
	jbXfLYFDOKHfGzwkW4lRj43qo60R+zwCX3ndRpqh+KjyyWhc991LEuHtpNAhhak4rfLxBfi17Y0
	U0OJa8z6i+h9gWUXJHZPxiIj+Z6+m3Yg=
X-Gm-Gg: AYBFou0AXz1dgBBv2vhg5HS8yfp+GHq8p/COoeyFAhCYU4kBDXpDJoldjFyH7GxTzdY
	6fAVqLJep0C0BYIUTbgFONxGAsM9WJQGC/w/a/bwxzA7iR5X3IRNs38pVpksKN9QKFAISvMUN7g
	+YmtN/akGKcBd3A3bg2WMCR0tp+7kB4BYC9fm/a6mbUL+/wVE2mi+FvsRppOe8UIRCWt09AgBuc
	16CukAjHRotM4AJ4UHbX/a8FsrCxKPRUbn3wk8S7ku4xHA5xmASlKWpjixnCn6adG5XylsHkDEa
	Uw7Fjf/qFRMiOpZTQLogtws9fgEELfmgifJsfJUD/y5ZgDypySZOV+tJUFE9TzEbrJWQ/h837GU
	b49QP4WB79XzbgCzOyEDM7M3mySSRs5EJhSi9pe3TN2T5NyLDcaowAL3FnejgTXpF4KaHUJSx1V
	epAfL/jchGp4QxSfAeY8LngjcUmbYIGJLDMkQZ
X-Received: by 2002:a05:622a:a58a:b0:536:35e1:b5 with SMTP id
 d75a77b69052e-55ac3363fccmr24163281cf.1.1794543671941; Thu, 12 Nov 2026
 20:21:11 -0800 (PST)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 12 Nov 2026 23:21:10 -0500
From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
In-Reply-To: 20261113011234.45270-1-diegomancera.dev@gmail.com
References: 20261113011234.45270-1-diegomancera.dev@gmail.com
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 23:21:10 -0500
X-Gm-Features: AclHuK8Vg0T6W_EJcB7LJOxNFCo5T5bVUA5gjr-c9q7orQ4IGb3OUxb4r-MnfVs
Message-ID: <CALruWrWRWRU84AkDocSnNMSRp+WQD5ic9G_3peE50BvQR5iGBg@mail.gmail.com>
Subject: [PATCH v2] media: em28xx: clear dev->v4l2 when v4l2 init fails
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com, 
	diegomancera.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"

In em28xx_v4l2_init(), if an error occurs after video_register_device()
succeeds, the unregister_dev error path unregisters the video devices and
drops the initial v4l2_dev reference, but leaves dev->v4l2 set.

An em28xx_v4l2_open() call already in progress (such as from v4l_id)
that blocked on dev->lock while em28xx_v4l2_init() held it will then
find dev->v4l2 still non-NULL and succeed on an unregistered node
instead of returning -ENODEV. When the device is later disconnected,
em28xx_v4l2_fini() also sees dev->v4l2 is still set and calls
v4l2_device_put() a second time, dropping the refcount to zero and
freeing v4l2 while v4l_id still holds it, causing a slab-use-after-free
in v4l2_open().

Fix this by clearing dev->v4l2 under dev->lock in the unregister_dev
error path of em28xx_v4l2_init().

Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Cc: stable@vger.kernel.org
Reported-by: syzbot+1a7507a194fff09e5c44@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a7507a194fff09e5c44
Signed-off-by: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
---
Changes in v2:
- Drop the non-standard 'Assisted-by: Gemini' trailer that failed checkpatch.

Note: compile-tested drivers/media/usb/em28xx/em28xx_video.o with
allmodconfig (no warnings); not runtime-tested locally against the
syzbot reproducer.

 drivers/media/usb/em28xx/em28xx-video.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/em28xx/em28xx-video.c
b/drivers/media/usb/em28xx/em28xx-video.c
index 84424284d486..f78325a41124 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -3129,6 +3129,12 @@ static int em28xx_v4l2_init(struct em28xx *dev)
 		vb2_video_unregister_device(&v4l2->vdev);
 	}

+	/*
+	 * Clear dev->v4l2 to prevent an in-progress em28xx_v4l2_open() from
+	 * succeeding on an unregistered node (returning -ENODEV instead) and
+	 * to prevent em28xx_v4l2_fini() from tearing down the instance again.
+	 */
+	dev->v4l2 = NULL;
 	mutex_unlock(&dev->lock);

 	/*
-- 
2.56.1
