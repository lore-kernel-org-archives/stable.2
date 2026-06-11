Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5453C9EEF
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172692; cv=none; b=OjvaRZ+e2AQOeyhmUEgLi2913AostNNwriZrQANs/xtBmujhNLzmNZd0gNoXuXfwkzyRetzlMEcIN9NRGn9Eiezqm7xljE8XwIr/bMegOQbNOuDf50iEpsNHSJ/L5DEyE6XrFy4T9ApteQ/wlj45fpBGfaTIEKjfb0i908c/jPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172692; c=relaxed/simple;
	bh=jYECQqhOuGSVvKdTwPWyVL5AujdqMA5a0nxgPXJ1KXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=igRU15aIErmdtPa5xVr3ddkSnQ6dcw1Gd4sTEO0gCZZGv0xCfjBeBlx+XS8uDPvZwPH7JbdZnXt3au3/K6k5cDRJwkFf+lf56nNfHi3A9NtNTDN926AiNfgY7gCPQuSPrIwLK+hNCEWKPpRqadU/c+srp7el0XUgE4cGh8RkLy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V4wDati0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aUSRzXU9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V4wDati0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aUSRzXU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781172689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
	b=V4wDati0cTd3kX5sMPsw3op3tmBPD0gd4A6IfmxwLfYgxXcXdJx89HZu5LWLlBs0Ps1Tr0
	5uExXAQbYeULw1ta3bFLyJDqOlAareV/IpqtUu1IhNRgb/I4NVnINKIhDKLEiF4o7fYn1+
	vlySgvoppTd5TWK78f9zWAqwIYx3iiA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-GFurUXl5NtqSrAucOZ2p2w-1; Thu, 11 Jun 2026 06:11:28 -0400
X-MC-Unique: GFurUXl5NtqSrAucOZ2p2w-1
X-Mimecast-MFC-AGG-ID: GFurUXl5NtqSrAucOZ2p2w_1781172687
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef55779d1so4930060f8f.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781172687; x=1781777487; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
        b=aUSRzXU9QGaPji1/m7+ubGAHyjvOG+cgcCuYdukcDW3oA/SA0WNQNZOwPoZbL+qVUh
         6pYQi7GBoOXMx1VbafPxYNybbDG1qfs+8envw+5udPKDaNq/DhwV/fXqa8lMRgkCKh2k
         f7oL9yGzd9Aafzg+wP5TGSDL+AbTmgaQP+MMEakWYHBkPyzhqwKvsUPOkWSTgHU66XhA
         rurCOFr6ZtC7i+/POAS795ZYG2t8Rz9ASJXkk5b/r9//qynvC4lIYUNM2wy3YixFQq8q
         ZVvV6ny4Wp19+8Htbmd0+LN2xrOfUN01SZpjfX8u/dqLOnY0gXaFG9MmqdKXOVyqHtIk
         FELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781172687; x=1781777487;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J03CxoywVvGkdqDT93IzLl+xZxTV2J8FpCDOD6Xyq8=;
        b=pr9g7imftAzvyvhT+w1po127OUEcvPa+BEapqpFR9Q/Pgivs9M8DYXcw4WHJoEulM/
         WYJQz9iZL3v1HZz79lFG9zDi84C1Hy6v1/pizwEEgCvhrBtr6LRdqv+Bruyg+uYMaE6W
         EAgjMCUBkiq7mnR8lRPcnB9R9GlLoKAiF3iHwZG5V0IwxmsiYvQCAZbDNieNY4mKf/Ux
         F4X0yLwAW6Hk04Cr1Q7wLlD1qW1Iluf1CA1IVAh1uoPhzDBlhJbkhjuhxQybeJ1RV6VX
         Rhw+n+Xq166cGUPKeFf4B68xKcOMi68g1pg8L84TIaUDm84NHl5l0loZ5dy+0BenN+lj
         wwBA==
X-Forwarded-Encrypted: i=1; AFNElJ9CieqneK8u7Esf6Ocb/lhytkrek0lKS291pUKeP20HLTZtkwfsFW2ClsFeJR92ndApQZ8Xamc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJjLiLwKirBKR/b/ZKoQptncAACLVIJ/kF+zDuUnIm9dHi+ecP
	MjhuP8+lVRFP8A9cyJxKT3bPjIYvEjasZBsMERTHTKGM8bKsiOq4PRU8njY/MUMqFq9ZyZgFRMq
	mZlBQGMwuQY2NoWWLwRVT4iYQBl2SRkJ3g8p31taySMEj4x9mt87N6TrBUg==
X-Gm-Gg: Acq92OFBsEZHYA2CK3n3OccgaUGw5WAXeLi9d6nby42nhnYHnjnaQAZj85t4+TTUT5Q
	Pjn7Wl7sfJ1nXP7EHgsBzLy3qdq8G1G5U5Gr1h79CDXU3F34EHJusC0wGe5zR+aGqscFD911ttL
	M8vngekeDVO1dy0du87k2isRJ4G6NNdbS7UmmOfJ6r/oI1+xWC0sfbhWRuB4CLEyCVLtMpI9yba
	tKPyBGWqFhBjFFNYkE5AiTRqykbsSujqvo30PC2vDB6IV8UIh0tDI2VSJGBwTT19KnLH9+CD9Sb
	6eUOmamQhoB5qKtLcYo2e1k/wtFUlkz+I+/A/8NX87+eoRcT6NfrZCwN1lAqejxjhT2X4GbfLnh
	JtOumhkCT4x/k4UPyCLu1cBPZ4ORd1Kfwurvas70BX5j6Kq3qSgUgXd7uK1MSZOThNE/ntIKWuF
	jJrtYpuWrArVUQXgY=
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150177f8f.40.1781172687232;
        Thu, 11 Jun 2026 03:11:27 -0700 (PDT)
X-Received: by 2002:a5d:524f:0:b0:460:3233:bee8 with SMTP id ffacd0b85a97d-460677b28camr2150129f8f.40.1781172686816;
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm63288157f8f.10.2026.06.11.03.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 03:11:26 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, airlied@redhat.com, airlied@gmail.com,
 simona@ffwll.ch, admin@kodeit.net, gargaditya08@proton.me,
 paul@crapouillou.net, jani.nikula@linux.intel.com, mhklkml@zohomail.com,
 zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 dmitry.osipenko@collabora.com, gurchetansingh@chromium.org,
 olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org, Zack Rusin <zackr@vmware.com>
Subject: Re: [PATCH v5 02/15] drm/i915/display: Handle struct
 drm_plane_state.ignore_damage_clips
In-Reply-To: <20260610152505.260172-3-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
 <20260610152505.260172-3-tzimmermann@suse.de>
Date: Thu, 11 Jun 2026 12:11:25 +0200
Message-ID: <87v7bp5quq.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The mode-setting pipeline can disabled damage clippings for a commit
> by setting ignore_damage_clips in struct drm_plane_state. The commit
> will then do a full display update. Commit 35ed38d58257 ("drm: Allow
> drivers to indicate the damage helpers to ignore damage clips") introduced
> ignore_damage_clips to selectively ignore damage clipping in certain
> framebuffer changes.
>
> The i915 driver does not modify the flag, but DRM's damage iterator
> will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
> right before drm_atomic_helper_damage_merged() guarantees that it
> has the correct state. The i915 driver does not do this elsewhere
> so far.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")

Same comment here than for patch #1. I don't think this is a fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

