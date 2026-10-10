Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6ED3655C4
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791596660; cv=pass; b=F+dh8jIcWshZ00Xiv97Q/HZdXdNC0bDjJ9RQuUE7JLg1sT7dxapNm2qYTh/Ib7yPCWBoQYRcQXUXliy6qV52coIODTdILTyew+jUep/Y0jQzOrz7k60zne8UqQ7iNFKlLaw3Twgmzrwq0l8atSfSVsHF7zMtF30lZHp4fA5O/j0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791596660; c=relaxed/simple;
	bh=PjXhq1bwf1IsoZVyd2lMtLh7MWQTYMfimRSXqhCMkbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oiupSMG8qBsw+0NZLlHBNGUuUzHGE3zXQGHxOdZPJxOynQFB7nIbz1YfYNCFo9tkOQjOxcvQdxCteV0HrOVKI5nIIEmbYqUUC21mnnN+6RUjLR5PHlKqoCICfNgxVU9rd/eE2CAbTpbUrrJQCJLAPKqIEYmri9pxWnXv9wsldWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZJj8Sip; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZJj8Sip"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ba37877490so194518e87.3
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 18:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791596657; cv=none;
        d=google.com; s=arc-20260327;
        b=JAkVo16ZtWRddh/DDzyLlQ6pzJcJeFosKo5wHjE7YLyB5rVe/lCfWXdP+Fka44r3ic
         zPYo55f7g8LXbA0Fsk0AvSYTvA++ArLQ/RXTTs8mcjc4GO39ebwyCBd5Kj7SGKePD4Se
         yA57aw3Y3zI3J/aGPnV776+ArJP11pHIuUPDOktELw+pzXJhk4MTPpzZFbWBRHdFeBLb
         9R0dfTrKGr3jFeOE8Eoqx/5ntRi2u0ALZPfflupFhbJ44FKCvsRC6M9pRtwPTpbENEVV
         p8V/vo6WcJ++1cfyokVaGMiaspqGqWdWH7TJVREHeQTQcZ24+xXqHiII/BaMEzGSP6hJ
         IJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PjXhq1bwf1IsoZVyd2lMtLh7MWQTYMfimRSXqhCMkbg=;
        fh=CqGJjY21M1nByBn1EEcFOOL6Q+iI7hlo9oTdGH9gUWU=;
        b=JqdDvsJqnISrJxFXJxWZ5mLLwsZFP2p+TmSsCdXPX+0lY+CaEXrxZwEYUZsBL7/Pda
         y0O2bniNQfSFo/lKwQr1m+vV3G7smAG/RwyX3Gr+RPNpKTXvRRk0Rol5JA3dbXqEaaHr
         I1ME4WSRPJY3I0j/XvxKmDS1tO7pevMRPEGP0StdF3rpz2lTcUhIcTOiFiShEP2YFXcb
         4WiyulChljx4F+k5UdJ6jN9yqBtYfJBjkVGOQSn48JeScav3Wd8w+gV7ympHRCOA6Ug1
         b7IpL5AUKUh60GZWoEwIBuzX6Jzw6LQRFjTVyTV3TIkiE9+KJcD3PSzmhrDrr0rjTsLM
         y/GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791596657; x=1792201457; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PjXhq1bwf1IsoZVyd2lMtLh7MWQTYMfimRSXqhCMkbg=;
        b=jZJj8SipIH32RFYVrE8+5zxNiO4nUL3TzN8to81Zk+518X19iX9NYpTuBX02C10SEu
         B7BmwYqhO9Bb/pp4/wr5636mIHQ7pGyGCFHEG0wVN3sQlBYHPc2ExjrUj5Uh5vW123Sa
         wsbU6VFG/LYX7VF7K0gf95/OUJvOZ0X85/3dk1/sOG79pxZ2kUjU9ail1xMUxC1Sfdzb
         9bK2GgyAQ/e61yb3tflwno7tKrJGzWF28g9wUsIBM48PO7P+Hq1JS8PebVen0frk4FS/
         X9dHET50o2wk1B6qG8V3QtJn9Yy5hC9YAIV3RrSf/pKRMmHoplGI0wOGEmd7brxNr6vw
         vMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791596657; x=1792201457;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PjXhq1bwf1IsoZVyd2lMtLh7MWQTYMfimRSXqhCMkbg=;
        b=XSVmNp+xdap4jNxzvn8j4de3rePvyd0OmrOY9UG164KLzfb0Vfl/iHlsxAqCI6lS8i
         FGVL45HweAVoZ87lxFerVYGOO6S8d5Gw4JDCrxt4TPzkLi8Bni/iggpKK24RuA/Y3zsD
         2uVUgwxPxHYkueZp5STUa1NbnMuzforUjBOF8gqYtph5g8uTKR5JBZ7l88VgEwkMR2ek
         /UjoqlibbYKSKosMbdy61nL1P17HkeuCr3XBVjZrZwQwKIVp8KAOX3Q4j0x5oH70Rs0N
         DP45r8/4lODN3DwtMJnIeOFBIJYf+ADW9+3yAiHfUGyR6M61aC4j1N1hCJ0k4Ggjr94E
         8xYA==
X-Forwarded-Encrypted: i=1; AKwUvBxQHIOjAJNtFN4Q3jedP2PyYNH9gW7gKfPO6TGGc3p53FWYyZsQEna38+dIi5/0BK6a3knS7nc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFOHrWazvDScARkY9UyQQ37n2GtVu7OjrsUA8KnMeD+VauU7xx
	QAhjJkXNDW/wN/bNeP4Lc1X4uzdhfkp0ybSDJ6h57s3gbpoyMmvCN5MyAUms59vYknaeEA+Dkvq
	apBZ147sf0nsUN/Ej6GryatpJCUrJUg0=
X-Gm-Gg: AYBFou3KjnBTJ/k4PozFcINOTDLsGPNIu1XL7Uq9Km5ri6vKj1urxtst5Em0ew/xOQg
	jcIhX/jKygDCVnMy0ndSGwbj0qvwTM8IKXCAqS+SimVDTjlo4TIR6+SCoMeQvfatULqnbXlpfGS
	zATNHZ8TEvJHHjvgyc+8Nbaxppq3we+4PlM2pHQmGLsZYoHLXZfkFKyVuclk/qmvgAHN4m1Mnlr
	kfz4vcF8YZwWi5MBzMQC/IitHW5J/UOes3OkCPfjEiX/J26TQ9ek9Ei2E8uDXfm1/jDXP0GAAgS
	c+wP/4koqOlPKYAJamrx5tnfD4Rl9BXUjlkfls+H/pc9cjezwcwv3k1NFkvI7uu7+7qH3nqdbpw
	PeMZZo4jB/15k3dvbL+i1C9JdhVLD7xKIYA2hhWiPXko1a1FK6XJGTeSTXyLgy5fIifAWBC8=
X-Received: by 2002:a05:6512:4012:b0:5b8:d8ec:bee5 with SMTP id
 2adb3069b0e04-5bcde6c6fbbmr1252328e87.24.1791596656639; Fri, 09 Oct 2026
 18:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009210449.971057-1-linmag7@gmail.com> <20261009210449.971057-5-linmag7@gmail.com>
In-Reply-To: <20261009210449.971057-5-linmag7@gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Fri, 9 Oct 2026 21:44:04 -0400
X-Gm-Features: AclHuK_zId0_yh9bj0LvR21b7Dyfnsf-U5B4cO_z-cljbb_gEYRCPqonHzDk6DU
Message-ID: <CAEdQ38EpOApGeo15BAppLF+rV4-qxXo2VUfeA8W0fx-o12x0BQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] alpha: invalidate the local context in flush_tlb_page()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: richard.henderson@linaro.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Oct 09, 2026 at 11:03:49PM +0200, Magnus Lindholm wrote:
> Add this before changing the
> current->active_mm test to current->mm: that change will also send lazy
> callers here, so their local invalidate must already be in place.

Thanks, this is the order I wanted. With only this patch applied a lazy
caller still does the old targeted tbi(), so no step is worse than the
one before it.
