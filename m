Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDE3EC2FD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 10:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781779539; cv=none; b=YcD2xMV6JOnWhbkfDs3w6HSxYm2Cu292gFwhi03hyGjLepZ5qVcFrY8CUA96IJzrFofaUyZlOPAB7ptEAzUJzhP0NhKq0gMTZ9c9neTeSAgLBPhJEACinFqOnLvEcIQ17jMjn1o+//BFHHkn1nyqZALloX3YTGMRw2huSwzGDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781779539; c=relaxed/simple;
	bh=Wj7lHFDw7QwsljMhK+ltKOvxMVwEF40WJ2l1whX5uww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H/Jt+1q5toBj08DfyX9X6KSqLx/7Abis1pLYHJqyh0ndSNJg5ZkTHfY9F7ClZG1/7p7LTNhEGY9u8MohjTlQbYrpgzAXFNAftG/9gz8f9ce3IJmOgyOKgA1M4jbo5VIv2jO1QK/CO1HChTXQYJqhlLPSuyl0sRrV01rzPCuPkeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7imRrVm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq6MsVys; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7imRrVm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq6MsVys"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781779537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ex4FXoS07wD1HdVUSdQ/7roGTbJyzugyEwIGze9M3sg=;
	b=N7imRrVmILczqikPwhCiNpn4Dg+whX8BGM6RWweHZMdqL9CX+Oyib9O+lDHEw3KlTTu3JG
	xIb9NorUrX8ILkcxHmPbOXNLrCD5pH5MKrmmLksOidRmML+7o8v4G2ZZoXEDeteqkw7Clt
	8uEZ2qOzjnC2jDhZ7hfFpKO5Wk6DXIo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-3rNXCM4iO1mb_sAUlDYD6A-1; Thu, 18 Jun 2026 06:45:34 -0400
X-MC-Unique: 3rNXCM4iO1mb_sAUlDYD6A-1
X-Mimecast-MFC-AGG-ID: 3rNXCM4iO1mb_sAUlDYD6A_1781779533
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46016bedbaaso526841f8f.1
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781779533; x=1782384333; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ex4FXoS07wD1HdVUSdQ/7roGTbJyzugyEwIGze9M3sg=;
        b=Uq6MsVyssctCphsGUroff0TB5iDhIrbjCSroxzBmy/MFvX55w2LUTTCIJK9sRNlyZT
         TNvu78qjKr9WWW9JmfkO2iQ3/e1OzcuVbSmM05Zs2s1nNfS3KYvo4Al14KZrVveGhv0r
         xDrr8lcEdGOfIJN6GeocCYGfAS50lpegopPRemdBZCSjyzmpaK5Eyuh/XVie1/Zc0Ki1
         meDpg3/8TH3GI95ju9V/eAK+O38GXP6ugQuidmgmWx+fuNyASMzT75mCwnEuT7qUYqYg
         vOr8g6mY/pF2HEYd8WMENAtOPZHQ2RoorG8XPojKixSAXktz57jJ/M8e3J7e79+w1HYI
         oamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781779533; x=1782384333;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex4FXoS07wD1HdVUSdQ/7roGTbJyzugyEwIGze9M3sg=;
        b=pSDWHyLVmNsiWq5LWlf8diKDxtpMBaXCQraJwa0zut9gzUjztFB/kYf5f3NGjFbCgy
         f9FOyuSf7h5M1wzWQzDWTzqA4L8DryWX6H4xDvf7YDNz3DLPtjQHbJk7oKSVh7aNr8JI
         ppaw3UuG+kr6GMhHVrme9/lTJy8i5rGjPnPRap+JbpfqxHhfHnqFqWGT73FyIjEOYM35
         MkmqWdiymJkxhhy0bw9KYnY0A2L7d+YI3ZL/fuatSS1Huq5sYLYXGnspPRwLyHkJemKR
         OcTrA27EZPZjr3PVfk8hYw4J993KflaYTbaoyZo+NzDI6Rq49yGPShIID+0XcQISqhNJ
         zWSQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Qw3XmGL2rpDYPXoZN7nM8R1gZ/FcU7K2YTJoMtO2/WztXARZgRWSA+SLnDYcapBGWBV8sDSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylfspoHzPa8/saOmxIbMr04oa2++92aLGTRty4tGHTwrtxa5/S
	UG094gLy7Z1T7u6eWcg7L7z33AjK783c1S1Sz5wTS+j/fZvRVzS6CnvB1D1w8MgTSyCed/n2m+y
	ipak+R2FwOFdORQ+sLltVWyxBTk5uZ7pSpXk7Xc9o8ZHvrF42GhO8K/+K0w==
X-Gm-Gg: AfdE7cl5xqY7dnh3LwuxFEyV6EvYlCGPBmxDy5zHO77U95Do7qAnC5OWb+yUr2gjZVq
	CZ8GSGwIHyHW5NgnfRG4pBYwyKI+COIoLd/mhuk0OmGACJAAoB+p2ljPdLlSc13Nn1Pxy2HM1gW
	baERiXgC2l5TscnP5BvZvaBUyMS8XsqZnn0mGp6Nsr4Y0srmlkoljCjDu3dJ9bGtXky5Y95tbQ6
	1+PpwicmAi5df5kFW/qJWQUkliIVM5UQHu6Kh2U6h9uhnbCOUsajo6tyN1bgKTS97vjr2slAETY
	EIgxt5Llk5Zt3fQg9tPNtWLm5pW9cAv5M7BgaFsa2F1YUO2Z2AjFDDAWUkp+WJGpu4RLPAKu8pX
	JlMqpoCmNUPJ6jd4vo8l/vkX6T7CpfT+e8V4lI+WapXvVZ9M9yO8yEoPnQbDWi2trHEWdrQ==
X-Received: by 2002:a5d:46ce:0:b0:461:c779:1e45 with SMTP id ffacd0b85a97d-46235e9bae2mr9463937f8f.2.1781779532846;
        Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
X-Received: by 2002:a5d:46ce:0:b0:461:c779:1e45 with SMTP id ffacd0b85a97d-46235e9bae2mr9463902f8f.2.1781779532333;
        Thu, 18 Jun 2026 03:45:32 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f1cdsm64765302f8f.11.2026.06.18.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:45:31 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev, Thomas
 Zimmermann <tzimmermann@suse.de>, Sashiko <sashiko-bot@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] drm/sysfb: Avoid possible truncation with
 calculating visible size
In-Reply-To: <20260618084327.46567-3-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
 <20260618084327.46567-3-tzimmermann@suse.de>
Date: Thu, 18 Jun 2026 12:45:29 +0200
Message-ID: <87cxxojfee.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Calculating the visible size of the system framebuffer can result in
> truncation of the result. The calculation uses 32-bit arithmetics,
> which can overflow if the values for height and stride are large. Fix
> the issue by multiplying with mul_u32_u32().
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
> Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/dri-devel/20260617114027.1F2A71F000E9@smtp.kernel.org/
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.16+
> ---
> I've added Reported-by and Closes tags because this is a pre-existing issue.
> ---
>  drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

