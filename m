Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395052BE39
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 11:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867729; cv=none; b=kvsmka/PuHDQ1WyuSLx++5hJhnHXbP8YrydXq/35eGnY4eVSbRe+AtMQ+U8QEnywYlZos4n94mk6k7OhxqVB2/Mj7A28odng//sCdn8WTx49uM8bp+avs7JGAUcp/DhjuzgnN/5e51cHByjAjRZ/atTsXf9Z2IfiFeawMIX7cHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867729; c=relaxed/simple;
	bh=zcxlvAI1Ae/q1EaKnTsv186NHrqAGAv0T8fIeszsq5A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WivQoULVJip34XL6/zDVAIMhMlwEU4IOcFtRqX5vrkY1mHcUcwNdFGy73iZWmVJd/3G75/pyXRLg60/B3Fz5EWhWLx0HZaSy66zrCLtuW8AEOKR9RZuy+QzGjmVBpf8TITf/DrmAp0vXVmx7EFjC5tG6rYJX0PCVi8GKtcJ3wvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/S5KLcF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NkPT29NY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/S5KLcF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NkPT29NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788867723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RrNJtw6g290ODPNBtFlQPVdYDxDOj1rXvh8h+/vQvhk=;
	b=M/S5KLcFgMhfhZhOsB3t9TILoJn+aaiTXr4VfHD2g8ekOf+lR+vjcJLkWh0RLfc8Ei/XeW
	zshYvJociPAL6utr0iNoXQ8JkDYoTnpZiUZnfTZPyiAw/BbhvN7D3wAYSOiXf+wjS7rLjn
	9VdemQpmZBX093Jk8EIgk1lSQkA/0/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-F0AFgAhIM66MTX2dzAsLzQ-1; Tue, 08 Sep 2026 07:42:02 -0400
X-MC-Unique: F0AFgAhIM66MTX2dzAsLzQ-1
X-Mimecast-MFC-AGG-ID: F0AFgAhIM66MTX2dzAsLzQ_1788867721
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49ccb223bceso26533125e9.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 04:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788867721; x=1789472521; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RrNJtw6g290ODPNBtFlQPVdYDxDOj1rXvh8h+/vQvhk=;
        b=NkPT29NYx3lUXdkGCPgrrR3RQC/Sw+FUwL5H0Fsfz/LwVRDCSbnHhlV9SgJjkDgiOv
         VHQ2OInaDTPgRDhk16K2hrsb5FFyr01zK3UtAqpZ5Xyk9w6BrgjsFXUNvX1naS5wbAp0
         cZ1a4qnd5xhigaY4sQRu+EOxAYOH0n+inQQCrXHRyOb32324f06OeSm+IJawluME9OGn
         xNTu+Ik518xA9XzZQHiEwEGqNpTYK2LqHfflbLwXQhiNKYCjg3ovCd72cbqqKIpNowvu
         eWGOZJZThXuIewEJXwhikXHxTmwugpXoUQoFHhs92YbQuKNxWm4SNzaw+WIVcPNpZH3y
         NMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788867721; x=1789472521;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RrNJtw6g290ODPNBtFlQPVdYDxDOj1rXvh8h+/vQvhk=;
        b=ZuJ/Jg8R4TUW8v3QNMXQBeIiHMMUbTupiVstT5OmoNcQB/Yj8t0geic5nK7vAPkqnx
         u8LAiULBiI6vTsxxLmhhrh/kVS2CmN+HIVpOgBT+Vxvlx4LScaxr7efz7UDNWJYLaIT4
         HjJfA4kDSTChXmOz4ZZCfXcqXiNiNdlVAYlINEHG38/nfuGJRXO5QyWDw3tKDCfl40Qy
         FHGrJdFewmcNcWNdvWwPOEjXcnN8KbyG9d96nB7ADPe+fcPVsmYInZDYr5Nb9owRz4B/
         dfIrXgVUFtGB8VJ7k8qFjH4vAgw2OnD4OED9scTDwdalRsBOxxPUhjUgJf6zJwNo5M2P
         tPtA==
X-Forwarded-Encrypted: i=1; AKwUvBzr4XQ2uzJVfjlBFXZOjZ9T8g49bZLG8/B1I30obPyajcXG4c691fwvR0jmqabirloV50VJuNU=@vger.kernel.org
X-Gm-Message-State: AFuF++lfwVtKE+SPhf3Yqk6s1XPBV4jT/RsTmw7hTBl73QwVvdrzL9dT
	56emR15mqgYSUF+oCVPY5RAP+JAvdWaHc22EBNDupVtNTz9rH8lEqsYBlQM14+jb1K+W9LCq20w
	nhzX0C8wF6rjfqqYgMNAoiCnc2/6BTZ3CyKKu6v+T2E4rrmufYuwgdh9Www==
X-Gm-Gg: AYBFou2MfO0GaWvVYlt5oegmvlCJhv8MqrtjgN8duDwhWbmyeVvzqCJjEPrkGXDglyv
	J+Q/lwpmOgIyqycqmmXmsAj2aZzmJ4FRw7yT/tSqgyr1crY2yXGyTGdXel9gt2yYclSAF686wA2
	bI7Qm6hMBUY+yhK6pdldp7gR5LwbPpIJg3r2Xu1/yai7A9vbWYy91+9EYm1gavAtylV94kMKZUR
	LXTTQNDFBNoAQkUQe6IzO738vLxv0nX1eKqhyIGSjjVINmp5R3C22FGBsNA/X+XX+aEoQUnjkF+
	9nvfoSVcR9k1pI/PQD+sUemuelBvkA4bRKO3Sux69ym5ESURGgtsL5WQHt3Jge7R2rBWI6BboAX
	Z5SAkZc4ia3XT8dEu8/YbdMjfLwk+a5XSXhLq6htXmd8LzDgsSHtBvQmtew==
X-Received: by 2002:a05:600c:4752:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49d175439dbmr67723895e9.1.1788867720847;
        Tue, 08 Sep 2026 04:42:00 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:499:59fd:dbfc with SMTP id 5b1f17b1804b1-49d175439dbmr67723525e9.1.1788867720384;
        Tue, 08 Sep 2026 04:42:00 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d03543064sm296441395e9.13.2026.09.08.04.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 04:41:59 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Fabio Piparo <holofermes@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Amit Barzilai
 <amit.barzilai22@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Fabio Piparo <holofermes@gmail.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] drm/ssd130x: Set the address window in
 ssd132x_clear_screen()
In-Reply-To: <20260817152500.703770-1-holofermes@gmail.com>
References: <20260817152500.703770-1-holofermes@gmail.com>
Date: Tue, 08 Sep 2026 13:41:58 +0200
Message-ID: <87h5k0dl6h.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fabio Piparo <holofermes@gmail.com> writes:

Hello Fabio,

Sorry for the delay. I was on vacation for a few weeks and I'm just
catching up on email.

> ssd132x_clear_screen() sends its zeroes without setting the column and
> row ranges first, so they land in whatever window the last
> ssd132x_update_rect() left programmed. A partial final update then
> leaves the rest of the screen uncleared, with fbcon the last damage is
> typically the cursor cell, so blanking keeps the console content on
> the panel.
>
> Set the full-screen window first, as ssd130x_clear_screen() already
> does.
>

All this makes a lot of sense to me.

> Fixes: fdd591e00a9c ("drm/ssd130x: Add support for the SSD132x OLED controller family")
> Assisted-by: LLM

I was going to mention that this isn't the convention documented in
https://docs.kernel.org/process/coding-assistants.html#attribution,
but I just noticed that there is a recent commit 816d9992d9ed
("coding-assistants: simplify attribution").

So your tag is correct and I learned today that "AGENT_NAME:MODEL_VERSION"
got deprecated.

> Cc: stable@vger.kernel.org
> Signed-off-by: Fabio Piparo <holofermes@gmail.com>
> ---
> Exercised on an SPI SSD1322 under local enablement patches for that
> chip; compile-tested only on the SSD1325/1327. ssd133x_clear_screen()
> has the same problem, left alone here for lack of hardware.
>
>  drivers/gpu/drm/solomon/ssd130x.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I'll push to drm-misc (drm-misc-fixes). Thanks for fixing this issue!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

