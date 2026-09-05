Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65124312807
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788571108; cv=pass; b=EgUjSu5/DhmofWvK8wSv+OZ00pK4TnQDwu6U7wr+iZQvazJGBwj6Q+IHojImiNpBbPzqDEwD0laVq8qdH5Prv6+ib1uG5/JrMjdlrJiONlOdGQgA69wJy7ySdI57dFp8WDMQ6YfBa502chfN79N4JLFk/2ZHNzdMWX9nZiEkyis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788571108; c=relaxed/simple;
	bh=QRWFS+GgSuBuV0EOpOPKRYi+MPqomhFhRkXTuO72POc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOzBoAd4bWmvON6d6dOK+kxjn+Z336ne+f5KpsMdY7byy22pw7uF3Q/wddNGZa5Y10HFo1Qh6soR6mDQstoUeTQdhAy2bom3dJNbqAqbGt7JVD77GdVxzF7ajucqy7y11xGl4jvNDG33Pqh6GXH8hDxJd6b7a+4wuRJaXf1eF2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=eAWN2CTo; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="eAWN2CTo"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20e70a0962so208301466b.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 18:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788571103; cv=none;
        d=google.com; s=arc-20260327;
        b=pjMlNZPAK5e/qC4CwRNTFQqbdIUhEGrI8b2Wbl9r7T9P8wJObHMZCTr3uA0C+liUzR
         cjEiLVZ1pbBGY3Trmvu4+f+rTpGbCgozd+b5bdAjWQ+ey/e/Is47pSR2WsKX4KaHKr0a
         xBIaL0lqFKQK0Kg+WVzlr/8X1A5ZU9FXmumJ/cAO6L3U3aoFPFb7X9FBojED/Nzsqbwj
         BWXRYpX8tkFzgm+6pCUg7/3xQZ/h83JaRX8DWllAHiQtSsdbxJhUTdpn7UPNljYD0opx
         PIs4xraxO+5Le0kTCqOCjPwylfXoKZljv48Hbxd7Pdjhm9mxlGX1Q2F4H79WWctfMHjV
         FFPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        fh=ldOCXCJQWblY96WWlqqI5pB9uvtpsXCsZgiZ2SmTCSY=;
        b=AQwHsNfQwSjsPsmv3hFpa9padDglhle5mNggVe1w78pCWwBSVXA5YB+RJwhA39Jjxq
         42gM9mpCVpGSy6DDaEHth6MB7nrtgm6dwgcNQ+/cWJrxJnCMXbBYuMgUaSRR4ErFAcVC
         AYspBWI2N87NRqmFZiMQRc7E78Hgtit7ugHujEortNeN+pX21kHnGCbBuFvNT4NK/v0N
         M+wQbyBpmul2aMnn55Ik0Sctw9pzLArYRX4kasNxTJAo+2vD+SywI0BbTW8gO0g4UAZ/
         ekcvzwDZkPSNyyiWcI1MR38ctQjdAgIT53R+KzAh2MzYzzYMQNrybWvdtr1Em6Hf8OLx
         A/dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788571103; x=1789175903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        b=eAWN2CTow+E996I5x9d1j3DbWJx0UtN8ZH5WYW1MFMlMO/xKXywG29SOt/pOWkUxEn
         fEaNTEKjWtEG0mo3mv5vf1M27dAHBmsVcCuyX3neY7Xb1TIhZ+H7PmpEfHPwjmPt0doy
         sJHPRt+mSEmHUFs74+p5uoDv3ltOOKA9Ff3DJvgbgrxEAx8FvN/SJQgDj0sJYIvEMiBB
         0LnTFqnbElc0MeyBBYW6+v+angPRza+IUinDJIiHs7cFHF+RAdKspnxopXZeIkeInQJr
         v9o8pNJB+DtB0q/4g6aceivClTjOpGfOmZy6WWSt5StJH8+2cTH8b6O1EBM9PybUk/Dg
         NPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788571103; x=1789175903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MC2O83yQA370xxba7M3dBk2YHStIU44lILC32r6Jnrk=;
        b=PnVQspMqbJL2XpdJ8X3N9hHCxlGMJeE1UHn//LLY2+tPavEXF7aYI4y2rcOEhzEUKt
         /T/BPAE32DJ9gE2pgWvb5NVRI4fqjCxeA0vskv0DtBItDmcJye6zClXay/uEp6XMh/ME
         tRaPfMyko08j0ml8Jt3uJ0TVvDVbN/xyleBY0dLGRrJ1/rXAjjcOep63FhjKCvIoidXh
         6NKasPoOi7x8jtQKMEwDc6Q9nR8GNWuT4P+bWJ0lx7l+pbNJiMQa7a/4aJWDCemIQ1EF
         17ZPnPiBUTd6CE7xnib1Oyx1XLTdq9nlXd1Y3ZNxCWqun0yTeIXuUwHsElrdr5Mk+5An
         1AqQ==
X-Forwarded-Encrypted: i=1; AKwUvByb0EbyslsLzxEU3glJ5HtmwUedJ5579xUwK5HTP958p9YQu7/K2yqIqa0LifM9wcp8pXmh+yo=@vger.kernel.org
X-Gm-Message-State: AFuF++lI01MxtjMpXMIZIjTaDM2Pbf7nOntQPSqRl6uSWibk8maWWUjf
	hblZway6ibi33WwEKVU8YZe3r7/+WMdkuXGri8HRJ7ttpnT0xEsFk2zEcJ+S8EOcG7VCakivMXZ
	1pHrf4+1GelIxsm6zxhtw4vgsYEVM8XxfIrw4uUV+7w==
X-Gm-Gg: AYBFou2dOtkwNgVfk/A2FnUYepVjtFUTjC5Zquyygta2cnJLmaNNWs7HbQKqq4ClA45
	0nE9WKoY0OomKM6c00cCbJ9BFQzvSlqK7jVlBzglKFcr4NLO66ftM7h4akhiwWAgt4qkV6812iO
	JHsdq7hDS3Oeu+b8rgrzg0EgJd562CYwMgFNYj0a39Vh9nFWWdC+/2yjpot91OO6SkYsBYHLuQa
	DfQYG01sWGEVqt7+mYA0m63M2D3YNMF2+6CSBlScsYxslahlyAIWLLXEMRMeZX7mHh3lUxm5Vw5
	UK5uOlYcVCI441G4e6kPL7IWn/x6oqygP+X5UHi5UHuXzQ==
X-Received: by 2002:a17:907:9709:b0:c26:2a5:819 with SMTP id
 a640c23a62f3a-c260ca1f474mr642465966b.18.1788571103585; Fri, 04 Sep 2026
 18:18:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904103351.15357-1-max.kellermann@ionos.com>
In-Reply-To: <20260904103351.15357-1-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:18:12 -0700
X-Gm-Features: AcwNN1VahgJIxFl-EEQrkp0gkp8R3dSoW-hNCnMZLa2sVOL76dxy0sOlZpB3OjE
Message-ID: <CAOJNxRLfDHmW_+jtUQogRcHCGKAyQJKBkQKQRM1i0Bvj2vkLVw@mail.gmail.com>
Subject: Re: [PATCH] ceph: avoid pending truncate during nonblocking cap acquire
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 03:33, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> Readahead acquires caps while the folios are locked.  This can
> deadlock when processing a pending truncate; truncate_pagecache() can
> then attempt to a folio that is already locked.
>
> Return -EAGAIN instead when `NON_BLOCKING` is set, causing the
> readahead to be abandoned.
>
> Fixes: 49870056005c ("ceph: convert ceph_readpages to ceph_readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/caps.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bcb04c6cb92c..86e195c5fd32 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -2889,6 +2889,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
>         }
>
>         /* finish pending truncate */
> +       if (ci->i_truncate_pending && (flags & NON_BLOCKING)) {
> +               ret = -EAGAIN;
> +               goto out_unlock;
> +       }
>         while (ci->i_truncate_pending) {
>                 spin_unlock(&ci->i_ceph_lock);
>                 if (snap_rwsem_locked) {
> --
> 2.47.3
>
