Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4707132AABA
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 18:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784140423; cv=none; b=V9xe6anfO9w9NG8U9bGwhfIh3q1CBN60MWfyqMOLpl6Dovm0cgjvKA9zCkO6RpSvywNr0nIBA0gmA2aLb2jcDwZ3AjqfaSOeebROgvj0Njr4sPR9TPkYGthPnUnSyl4pngoc48xwoThjAKsjeEID2QsatN/NxTDeBi2fbUr+JDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784140423; c=relaxed/simple;
	bh=XPEkn4UlRz2dBihu6PB98HoFP+K8ePsRHX8aeHWJM/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lp4PRMJ/uqHJn+YSM2HllVx58jA0DBIlGzUGm/SRQIbAHAocW7hdFAlcTALdyrGWiUj12F5U4GFgcdwgNdixz800qxScksnsOIXc20riGgvL0Fc+hnX3g0FNOZ/ZQtVwbVCgAccGpi1XZV28ZaiQyYv+RFDXwoghIfF8Jk4WEmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=ytJDqFeH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="ytJDqFeH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4953ddae026so6725655e9.3
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784140408; x=1784745208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPEkn4UlRz2dBihu6PB98HoFP+K8ePsRHX8aeHWJM/E=;
        b=ytJDqFeH+q5IEcTy49Y3tR0LwCGhosOffAcQx9mVenclQURFU8FkH8gTJJE/HEoVC/
         wKW5hWcc6RFdWvshZJuTyitlKOmgClPEdrMEsIYZWoKJLflTOCdZg3xnenMS99eLKf+w
         AfkLbVMZz4mPACbjvoE7cE5iw7AWb0vOqJY+yq1HVdKeGKuHVzIdnqdCGjp4bGUDTVJe
         GQrS2wOwWRT9KCeWaQSU2HjBtjKuxekuMFSf1pt8x2p4gEv992Wn8MaQdgZ0df271DVh
         V2X/tn9EiPY9pqhlXnZ/Vuai+0kohKbGdWaHnc1ovGH1dR5hVSPA4N1sQyjpX2fAz2Em
         qMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784140408; x=1784745208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XPEkn4UlRz2dBihu6PB98HoFP+K8ePsRHX8aeHWJM/E=;
        b=bCarYmplqf8qytZfWc7gZI1uEpks/NPr8QAkaQ08B3N4J2Nm613S12v1i0U7v1AdjY
         k4W+MuzuAUpAD18vdOoDM6uOJOM9mkDkqINvzOVDhZEM0dq9tckrUlqnPo+Idm90jlZU
         H/1A6rPWEJXCxFbGlbaO0J4ENKqq9e8oAK7h7ftud5HbIMxChbTECpg5vH8gxSNfSl5u
         Fl++l5jCPFhPhdJ+WKYNS6nGXU4xTxhxPi6BlXtwhWDU5XLeSLysP0E9PmsBgfWJUpGs
         rZt9s7gxyz5aMcNLj7hMiDSjw8iNuDXF45xpIM6846weJI/JZa86UJkaejrq6N1Az5FY
         d7cg==
X-Forwarded-Encrypted: i=1; AHgh+RoqFJeeh1D3w08OF+9VxXfJ1+KVr2EEq0WXmrC+Iy6aYWMVUI3EkHu1QZEzUg1EZe9GpiFStzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLWRi/AYFFHr0VBSgLRD8g7xnJNwxnQQhKSnyJrfigJMm7tzcK
	w5l2MvG/p7ESdd2WWPAV78MWbGB7TV0uv4IrpBvvGeBpXxLxTrD+9ZxbE1PHYmibeedyVJaOonz
	OXS67mLSy
X-Gm-Gg: AfdE7clXJ5t+W9FvNPRTobTudzPwHjCexTiJek0DNCqGj0hCVuA8MQehRvYs3KvHYwC
	6inbbI35DjtLcLzo1CjHFsQQCQ7BZK/iOAAaDC6ll5zDTYU8/Zam+ikvc3JybFX821Glg7pnUho
	NZHa7YAfqycIp/ShGZpvWjTl90RwbyPwLbzpSSJT/FDFS0RS472+L6iea3VeU5I6ei44L5cQuJL
	3Vi4BAR73lfsYYncREKQbKFNfkDRbpBve8CkekN8N031oHII6Jz2JzNRb6aGUx/NBDAB5WDCZE0
	9ExbmcfcC3M0vQK4EYK3wSzRGcHKTubmPgi1b91vCsZT0cysQpzyIpSs6V7e66xVQVfFT8aGIbk
	pcOMuE2DEfPMupu743gpzThEO/XrgRw6Tbz6RdOTeEa40zusPifs0trE0Aobwm2rfuvwJwdw2Ez
	KNnmnUNZspQSZUhZQNVnjphHNgN5rvN51ljzIpBeHhxNrtv4odhSlRRIqNcNQ6USsOyw34+y6CR
	TtBjXZXnMx1Ndg5xxNqEvnJEqBIfAulvUHEifHMEdDcuA==
X-Received: by 2002:a05:600c:45c3:b0:495:3e08:ad19 with SMTP id 5b1f17b1804b1-4953e08adb6mr33169345e9.9.1784140407405;
        Wed, 15 Jul 2026 11:33:27 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49541e93295sm1302175e9.10.2026.07.15.11.33.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 11:33:26 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Brian Norris <briannorris@chromium.org>,
	Kees Cook <kees@kernel.org>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: validate HT/VHT capability and operation IE lengths
Date: Wed, 15 Jul 2026 20:33:25 +0200
Message-ID: <20260715183325.45521-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163458.GA149147@francesco-nb>
References: <20260715163458.GA149147@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> My advise would be to do the same we are already doing, and unless I am
> wrong, it means that we skip the whole frame if a corruption is detected.

Makes sense, I'll switch these to -EINVAL and send a v2. Thanks.

-Doruk
