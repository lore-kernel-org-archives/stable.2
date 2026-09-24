Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7D242925
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286565; cv=pass; b=h+IDdNmSiN/N4CYG1yI/Z4r1ZI8mGNxoQUJ2WbB81uW8iHxlmlFP/O8eMyyOUN9ayyb/G+H4OGOSGBf6BTN/F4ic6fZee5ANiRJg4swqONE1fFihbK7C0jrLcjr1d6qq+jYHSD9BzhB9AeLwwZXzqzmy7qlWyKrfj7QwAZ71Za4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286565; c=relaxed/simple;
	bh=IOZdo6RY6JZCS/RhKzdbZOS/gJ453N8ilVos30rrtrk=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNw8BzcYcptPUbVHhGPs38ZUxCX0+2QJjmr4Qr3HSgNOKqZf+K2WsAeR1Tg/9HmimlSyfzOzfx4MGuybzMuRYDrtgf9Wvbco5p5K2drEyz682YO1UJa8F6sw8oG4crplOE07BXgSlqeVLUSGzZGLm/sY3KjDFb4emnvFdIDKZOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/5S7HnL; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/5S7HnL"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2946aa0d5aso211511366b.0
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286562; cv=none;
        d=google.com; s=arc-20260327;
        b=N7eeszuvkjg87wq4iS8Hhl8e+T4iWQPyBi0c2Hf0MgTOKx955r+yNKkn33tqwsSpnR
         FEBlQtvcgGOT8FGtgML4vA4WKo2Bu1s2fAz4l8k2e+KV6CaHv9CKskcTs56Ui93kitv7
         DtGUvZpGNhPBwUoUoYAI6VXmhdeOjBYQIxg6mM6lLw3+hLbOqIjxRN6FnYYMMAU3xpuJ
         p8+/RPBN7MQftUAycpxyFzppMbn3jSmJYXbLk6OHTQzn2tn/LPRDiT2Hz3q1SsveOaxT
         iRRz9xtSUhder+0H0KLpCLHA71E51+U7ZnBjHOA7TRx/NDp2ZWLXm4yrEWvdBRznk9Q9
         rE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=UiSS5MDz/yhz0gJroXWIYjWE1XbsEfZtw32iYL5QFY8=;
        fh=IU16SlhmtPCpFbou4dN5VF/Nf5lDAwcudKu9+uAN6iE=;
        b=PhK7EQ2yzPSoBbmxDtdeZTqsVdX6e9bPFhtdWRGOMXtr9Ux1eElQo/pNO2x/NVqzg4
         NH1RJDplDHd8AfWSJUNS34+WcqCbDD8PWZa1qDu8jhRlWMJqH51agWEyUEdf0TKzfbzE
         pBWZMyJt9nOabYgdczSupgaBEfRvKzv4OD5CR2CqH8IB9QU5Lhxy8ZGLnE+wpvoT0+bj
         Dt3I4E6pG5iw2KeCMKKcNnlEHoM9I92GVvsRJWJlZZuFNNymAeDxAc6kJQlbaHDGVaXQ
         OAD38VtyP/yNbFtG4MBPVwSnlu+OldG+NRz+qcTJX3GBtW3P43Q69AgSdyOWrtkhpISj
         pRLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286562; x=1790891362; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UiSS5MDz/yhz0gJroXWIYjWE1XbsEfZtw32iYL5QFY8=;
        b=J/5S7HnL4FWyRco7pkbziAehu6lP7fVmX6achpExkVa03QQ+skKvsjMBrp0V7pHeP6
         utJBdqGy2ckmgNdBOJAhXpK0TXYaPCdW1dUOvy70sQ3DLI6IP5JGaoTqvB0XsrvZG8MM
         L0Oaq1jWIHc9W3ClhKXPxoBGlW5HiL4aeUDBCOSwty8N1ZfdRvbgIIWY/znYNCUefNsq
         On4OFLC2Gurt9jvF7uikY7d3G7K5sAHxNlTNiz+fNE7nE05UfEzCBdRvUzXp4zrNw3U0
         uz//hFNZ7oqdV7ffJ/WOdt1U+Det2Rek60p03pI47jS2kKNX2A8pxndzABGO+PKcGtKO
         9K4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286562; x=1790891362;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UiSS5MDz/yhz0gJroXWIYjWE1XbsEfZtw32iYL5QFY8=;
        b=TK/JEOqoZ2Ejy8zLBK4rACHt/hJOqv5xGxPpVsAEp1UTN+Yy7JC9F/ceFpKt86EZqy
         gbg8glIidV8Dl9DqESrcmSIm90RowGnvxW5QV5x03sXDSGvHA5ErYgCDjYQDQhrgig5b
         ANe3eu2aERe/HDs3TfxaBf9PASnx6r2CBtDGtjRWx0mJVvz13preJqaI5HN1uYUyabzR
         CI/9G8uDHau/2R43zoKIh5DJ5WM9Fmv1NKKimbI5HdgYZ4CBz3m8hN7c2ESiQ4iXhFU3
         IzYumRHti5cwnpF336Y+rCOg7s+TtNBWTuRvmItEXxdIdUMxfk51kUtGPhNT3Q8O9Y4l
         EjDA==
X-Forwarded-Encrypted: i=1; AKwUvBzTULxkCeC6fnCiswBZ7blqacHQglN7Ydmi20qe1Gi4/MqAECCXix4fveqVU92y5Q12zD3UdBM=@vger.kernel.org
X-Gm-Message-State: AFuF++nJYjSKcW1jFw/XevEKZ6JUmkNeuJDsx6K8en6XWQbY4QZSXjEz
	LKjAzHCN/++9UByh2rsPiwZjBCm0m3omP8gfV3Mkv/bEwd8u50HZYUzGeYVG/GIZqHNDeC9XbuJ
	Qg/mvPaQv3Se55SfV9a2NZ/MutDDl8Q==
X-Gm-Gg: AYBFou2953HQZRiNXv6pwsyJp7Phmn+f/ndMxqmogEMvy+ihnHYR8ZJXSRUV0kVR/i7
	ea+sY4E5ogPf7Mt9Bl6OsQ92p5GRP+xRhApQ2tseonycOhArIFGw9YgN7NvxqD3X1iifUlu/gG5
	s4vEEr71gSQj2oJW3QhstcmDXlFQdvh8ie34jgVDhlx6hEB3A8RKC/2TF7/4xXKs0WsBQSVSwOB
	GWVdrxYHBS+yPSsBrf5IWaSwPZp8YXQFIeyvA9kY9e12pIUATLSE2tmQaj+1HUMPLAQx74bM/cU
	V5Cn2tYHssdKzPrDZMLFqC76ZytkYL4/XiSmDF5ThK4lRC5fJeBr6FiFn8bk/peBKv3eX0nCHvl
	9U+oiefDbDVKs2iOGUfCwBb/PsVJDWL1xAsuDGkirgNryBoPyhuDIjf+dLJUViJd7
X-Received: by 2002:a17:907:86a3:b0:c25:5a26:3787 with SMTP id
 a640c23a62f3a-c2ac2240137mr324783166b.8.1790286562321; Thu, 24 Sep 2026
 14:49:22 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:49:21 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 16:49:21 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAGEsz8HmUoQq7XLr5ZN7diWt-sWYoUwYd400vpq5jYEDEB7_vQ@mail.gmail.com>
References: <CAGEsz8HmUoQq7XLr5ZN7diWt-sWYoUwYd400vpq5jYEDEB7_vQ@mail.gmail.com>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Thu, 24 Sep 2026 16:49:21 -0500
X-Gm-Features: AclHuK-DvetQh1gHZkZvAtF-Wo01E6S6SV8NInGxHeSu-8odoao-bwAIz_ybmN8
Message-ID: <CAGEsz8HrSazyf=aoRkAD49S15fKwYdswFBXbHq=+MCVN4PTg1Q@mail.gmail.com>
Subject: [PATCH v2 1/2] media: amphion: drain message work before releasing
 core state
To: Ming Qian <ming.qian@nxp.com>, Ming Qian <ming.qian@oss.nxp.com>, 
	Zhou Peng <eagle.zhou@nxp.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Myeonghun Pak <mhun512@gmail.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"

vpu_core_unregister() frees core->msg_buffer before cancelling the message
workers, although core->msg_fifo still uses the buffer as its backing
storage. A queued worker can read it after it has been freed.

Drain the core and instance message work first, then release core->vpu
and the FIFO buffer. This follows the ordering in vpu_core_suspend().

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/media/platform/amphion/vpu_core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/amphion/vpu_core.c
b/drivers/media/platform/amphion/vpu_core.c
index 85cc4a14f8ed..a0c58ec97a42 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -299,22 +299,23 @@ static void vpu_core_put_vpu(struct vpu_core *core)
 	core->vpu->put_vpu(core->vpu);
 }

+static void vpu_core_cancel_work(struct vpu_core *core);
+
 static int vpu_core_unregister(struct device *dev, struct vpu_core *core)
 {
 	list_del_init(&core->list);

-	vpu_core_put_vpu(core);
-	core->vpu = NULL;
-	kfree(core->msg_buffer);
-	core->msg_buffer = NULL;
-
 	if (core->workqueue) {
-		cancel_work_sync(&core->msg_work);
-		cancel_delayed_work_sync(&core->msg_delayed_work);
+		vpu_core_cancel_work(core);
 		destroy_workqueue(core->workqueue);
 		core->workqueue = NULL;
 	}

+	vpu_core_put_vpu(core);
+	core->vpu = NULL;
+	kfree(core->msg_buffer);
+	core->msg_buffer = NULL;
+
 	return 0;
 }

-- 
2.53.0



On Thu, 24 Sep 2026 14:49:08 -0700, Myeonghun Pak <mhun512@gmail.com> wrote:
> vpu_core_unregister() releases the message FIFO buffer and VPU reference
> before draining queued message work. An open video instance can also keep
> a pointer to devm-allocated core state while sysfs unbind removes the core
> or its parent.
>
> The first patch drains message work before releasing core state. The
> second prevents manual unbind on both platform drivers and warns if core
> removal encounters a live instance.
>
> Changes in v2:
> - Move vpu_core_put_vpu() after the work drain.
> - Keep runtime PM and mailbox teardown unchanged.
> - Address sysfs unbind in a separate patch.
>
> Myeonghun Pak (2):
>   media: amphion: drain message work before releasing core state
>   media: amphion: prevent unbind while video instances are open
>
>  drivers/media/platform/amphion/vpu_core.c | 18 +++++++++++-------
>  drivers/media/platform/amphion/vpu_drv.c  |  1 +
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> --
> 2.53.0
