Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20438385D84
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783980701; cv=pass; b=BgOhb7Z9IGyXN8PLj4L8rwcYLt/Qe14x54dGvKaMGBGawPjG3Fy9bfh3/4j2I2OeiDszrozkX9IZgkRzdR9hFfXM5dKgVtuBeQV+RWv+aytoGfnBhrF2qbBM43QcWTMXuIdUXt0++pXAukzZJ6EZLw9oljn6o9lBmi/3Gexo4nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783980701; c=relaxed/simple;
	bh=RYLqTn8lhEpoxphy0WxGRTYgZn3auH47Zx0QJMaEO54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFZ0LOR9xXbq+2R2AFXo0ZA9tVu2DZ/MfAymdesjIZ1mXy7t9wLOTLvR3I2MVS4n1cgyadoakt+YT7Soc2zxJZA9RuMoI5YW6gP0bZLqAZJChuh3CZk5k4aQS4Z1AultGLbcxMH/jY7EkW28kBXqzbecOF4GxUIjXiLrJxyYm4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tLoeDsn6; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLoeDsn6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47df440fcd5so1993537f8f.3
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 15:11:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783980694; cv=none;
        d=google.com; s=arc-20260327;
        b=flPvnbTZz4wQlOArYfCZNZEKARxSWNuKlLXn8cRXHKf7Tmun3Jm556BZ4EUitYDN6o
         fJJ1Q4XJruk0bWa+TBrOpcxhqSxGnKjfPGt4rZAyvMh5tsXgB9+fszmXEp8pz06AiDYx
         P7jFb/sI7wDZN5DJGHmcJRsd7BhhiWqUh/R3YD59YmKwFfM+rlf6o8yOIoRlbDbnbciY
         7GBW6Z80lo7XUQ8FBUYNlbAa4Mm9F+pudfHRkQ6Pf5GpjXiYE/h5/w74Zlx1rkZY6I3W
         AaO5KfDMtItiRMVK6x4EnYg7TlqYipAn9KbFSafMuS3eQgcHFbgOtxKTyqQvePa246Tu
         sJ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RYLqTn8lhEpoxphy0WxGRTYgZn3auH47Zx0QJMaEO54=;
        fh=IkiDOCk0Df6b/T/etrXYoqkMytkL97KTIfbyjjdvOR0=;
        b=ASWi+54BxLCLK3A6C6fnrxLWfdOV047EmEBqGpTRrjOZXZkaLJ1dTVJMc2shNOH+ex
         TkAVxjx1fiigui4tLKBrHT0PlPm/qdHfIvq0674KjbWBte+8Rag7uTg7nFtnoqRRuPwP
         BXd6TlQlc2tuTlbTbZLlfayVLqVQfKtB+DFDj2N5sbJg6bE5xGAksyKMh4GXPj4ZOKoH
         JPaCdcqoR4SqOslBVMVqCykxswTgwbrZnMXS+AHbxYNXXKk1wvvJkDBgM8XtqD0iEekL
         upu8F2Kidl1VLGkDv+MJThXmgStAEic+zESyo4t8GeCz64m5ILmYf23dA8j94mhc3+MA
         /uJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783980694; x=1784585494; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RYLqTn8lhEpoxphy0WxGRTYgZn3auH47Zx0QJMaEO54=;
        b=tLoeDsn6FWKKljjqhOgXW8k25SicHVp6PqSvbLoqjUgRwAysWaWMaGEDPacA5Wlg0Y
         bIJ5SyKCcQB3qOZelkD/X5lR/SZceTUO2smMLjboOA5i88haO2cWaiIjQYCyknjLZMza
         6HzdQJdg+8nppOjnbydIdNxfZrpcR6venHGtE4fU2kFmdbmWimvLaRLSzY4OMURaO9cS
         2VFVhYFTkPDOZW91k1UyBngIorgeKzfex3zvJTX9UQ1lv1dWM9TnVRjAJsmMJ7mV524v
         YhBGkvRhj0BNG5oLRToCBMmbe26PNzrdpl3Omw18ps8+YUw3+F7/36xha1fZfvhR4YQG
         BMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783980694; x=1784585494;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYLqTn8lhEpoxphy0WxGRTYgZn3auH47Zx0QJMaEO54=;
        b=e4kVyuO+AR3g8YG6f4QymkkHo2A5vc8O/fXh5HBXnPz59ez8NE/yig0K5i3f2CSRcN
         Hrx/hpKjomuZrJhIKNOc2u2dpWBREk45uGjz7t0CIHz5fF3xZJm6AteAfpf4klpyv4NC
         EFj2CvjlLJJvUJAU33KYG46RzwaNUAhQ7ly5GKtX2GnPMr4UAWhkrt5gdn/tbDJmUIf6
         xAdWxzRUtxKSw1SZnEDWSkojFiqDO+7+yGeyIwm1adKub4zZ3VyHU/KRYAaCA5q2eRO8
         LjPndZU91fKRZMGXpkoS3mu+6/qU5IjAMNo9X44KL2D485AkeFiTOHUttBX72GVlouwI
         ZAGQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpv3MldteGWBVkWalIJ0b9aRSLAmp3WWHA6aXOjXqjLrGEI7H5m0eFFRzRjj8Hkp/xKAq6aynI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwepNzv6Arz2mRTT/Sm6wtv5RvyMWtLOZorAE/QfaB71cCT0C
	lkOnRlAfHAk+BS/SxarQPUHdM8AtFe+dj8KZDS6hQ8oEEchh1QfpOJUq4FWlRHbjr7Pl9MU/OQt
	9QapwnL5toW8C+SUc88Vmib5rZhplICg=
X-Gm-Gg: AfdE7ckumu06sfY2Gt+BAobD8bJpysp0/cRLCy1QBnPLqlQoTA6bPNdVtIBc7C8V81s
	hfFATZAmnILgAjxqLCHnvoOsFtHtmukPFX58Nm1p9+PaAu3rEz69GQru4t03O8idytmTZ/+Z4hf
	d/oZbkwznbtKOmaw9ydIum6be8jTgh3i3DsmeIfSUl/dOBrwFZjQnb4ZAqFXWNgJcxAlSovdsYw
	YPFY0nng9ql6kYvxcjvVgIU8rdw+Axtu5n1OGCkjGQz/EBnNQODpjgoCPrDI74WJvRc+oqJsPSy
	yy/S2+FwT4PtgtiIvLa4TeriL1AKTM49u71z853/SB4air7epSyeOFEFK4nWpQIO0DUGUA==
X-Received: by 2002:a05:6000:2006:b0:47d:edab:a721 with SMTP id
 ffacd0b85a97d-47f2dce9698mr12173493f8f.31.1783980694461; Mon, 13 Jul 2026
 15:11:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713175345.2542331-1-joannelkoong@gmail.com>
In-Reply-To: <20260713175345.2542331-1-joannelkoong@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 13 Jul 2026 15:11:22 -0700
X-Gm-Features: AUfX_my9JOM1Anjv8osAQkporAxxoHoY0M2kvYC4ypcjnle895hVIZpywcmiiHM
Message-ID: <CAJnrk1b9jjvP6a9PaYAiA0HZcJ0_dR_O2aGWPF44T2NNBJC94w@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse: fix missing barriers in io-uring init
To: miklos@szeredi.hu, bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 10:54=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> These are two pre-existing issues Sashiko reported [1] on the fuse zeroco=
py
> series.
>
> [1] https://sashiko.dev/#/patchset/20260630211436.2062816-1-joannelkoong%=
40gmail.com

Sashiko noted some other places that are also missing barriers [1].
Will send v2 to add these places as well.

[1] https://sashiko.dev/#/patchset/20260713175345.2542331-1-joannelkoong%40=
gmail.com
