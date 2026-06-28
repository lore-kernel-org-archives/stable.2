Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B0331EBA
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 06:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782627806; cv=pass; b=QLjqL/sPSVa86P1A+v86UOyCrQ0OMJWH3MmgyrKXv7hWKwcZWK4c7FpGBC098LdlLrQFzRT0zb6J/xAvDa3awLvXGvpA1W9cXb0WA6nzJP1J2wQnODjM6F+ZGaHrAmw9tbnhqkmPlDd6vnskBZ5xipavbRM6aj+LK43O8Ehsdj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782627806; c=relaxed/simple;
	bh=vTzRYgBgZOamBxw1WiYenNhfQ94/nUWzB9wfTPJ1rsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXsWyQasjp60W5g0bm8ZslqHqddQ5U15v7bUrmVpXOfnVmWrfpFalqQIBAuj5cnC++GBY+p7Woe4vYBZNfi6hws7kI4gMo0rWjXFSpzSrIuL23TrUGa/+TYwWh4oPPMXyw+TtYSy6snWVNSp4IKdot8zQrMEqk57k3dbMwREMBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EPNoA4iQ; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EPNoA4iQ"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1237aa9315so118242766b.3
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 23:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782627803; cv=none;
        d=google.com; s=arc-20260327;
        b=OS+NcppR6EDIc8yOcsLU3YhjRG3efSm3zk6AxWIjOBNniF2+SbchXau9Kqk/pfjQQL
         SFR6h7SkIda4ZZNYRGGa0MEKn48tJxgPgIgx9hJMqCBRTxKeFYpqXwH6kRq5r4VGMAng
         ao/Qz4bOH4ezx85/rjzCrPceuWGnnCBmMN88UpIfmVHFL6Z/7uI/xmE5Yv7sMP/fapQt
         TeUXHv818foLZb5Zs2VzVQ2KhIUDv9pcafK7lTpY00OwjSQIvIQo4JfpYtZyk0qWCpxj
         7WzXSZNn9mT7C2sPpBI7cV1WCXdoa8u97b+I4kYQ8SmyA+7P/eNTRejTSLkOV/ZJSGTk
         peIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vTzRYgBgZOamBxw1WiYenNhfQ94/nUWzB9wfTPJ1rsQ=;
        fh=q63LYJyuuQI7Qn/6uLzV3i6ovmb30ifL/Oes9y4ptx4=;
        b=Y9McU7AfhjJl5ssWFPxSnJoQ8Lw8zHcnKrI2FqTtjXWYg/KyzZDpt8Tlh+0KA/mpLj
         lbnQ/wXLX22fEB6HAM7fCQFd7I89oXxOoFIfs2ImonPsSGvGPfwFbswLsqodWfjuYQNO
         ztT+9rc9QjD41biFiIKeFuqk/1LeHBd3HuO2ChFv9z2DllMj35Pgj9KKsDS13sbDdIGE
         21sUgJ+Dd6ZE1SSVKS+9T0StLgJ9BTTATVT+3ADWcOc+TZI0GpYlJcmukoCt3jiHQnQt
         gGbp3tdP5rFh6Ga/Zcv+9Pqn4e6qhEdSmzdk/Bh9KWN4cS+6oc+hps0V3s4DGhCWAF0U
         fq/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782627803; x=1783232603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vTzRYgBgZOamBxw1WiYenNhfQ94/nUWzB9wfTPJ1rsQ=;
        b=EPNoA4iQlIzz9NigehdKIO7AMaJMUw0QzNlWS1vlbWdOdFHpW7M2PSJzvBNlZMYCZ8
         BWukGH8w5kvrwt+DZwyMdnHLJkkmFQaPIfpVntipk8PHVsN51Gqb/KhBHzuznggYyS1w
         zAcBmcfyLPtQN99HcTfOTse/4Xe434Y+QyaLDGqMBRLb0nuiq7Ps/UnErKc4+auyBj6x
         hb+WZsIVuc2ujVZc4fASPRLdig/MCxW6S+AURcfiYien3/iIQ2wICPb7fo3HekdNCoVd
         eFBZ7rn0pl5ZOUhcYRVNzKOGy4McSm5KpmmWSDCVWTRZ7/xv+jqekHj8Jy/0KlaTm89u
         Mvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782627803; x=1783232603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vTzRYgBgZOamBxw1WiYenNhfQ94/nUWzB9wfTPJ1rsQ=;
        b=tELqdwrGbVfgq8wypusiOtqsluP7JNnKsXpDmapmBPF1cL/2qTPC8Fz+gk294N+g9P
         qZjzrO0fJme9EkqVyrL+JCC+JJF0ZRlBeFjBFxiFYvKzmb77CYQfnGLK7sSGcDztpb9L
         s+hqEuylYgeEQ410AeMoUwmc+KCSOrKSLYj+qdFv2e7tZgrbVrAweGivoV+SxnJQsTy2
         o4i8gj60ttbnjHzzN7t5xUj33zE43PkX2UlM9kPrAAH57TGpOC5XbXiXHfCF8l8mvWd3
         oSAKJRFwN3J0uOLLd2YkiliR2Z2Zb2fLYYHubSEtkR+nHyhw13XeWJOMnIXicyuYb50d
         2tzQ==
X-Forwarded-Encrypted: i=1; AHgh+RrlYrN5ClVNwZ867VtecrsP0GBHq73qjXDJ17SDEUAed3r8wSVOwHOYAnNt3KPwxeprA6uVa2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlFcru3MBGhJooCsxz1We+5iXPzjsgrdKq2N1m2mAiTM1UgY4U
	XKCwo59J+ux79Sb4v6XWxQWasyQZwTJjLML5bA0l7D3ndQstOdMg8O8Vn7F+A/7svqJwxBbZotv
	CsLwoxbRwlytT313AlAen+vig7DuJeHQ=
X-Gm-Gg: AfdE7cmycQLqIvu2NPWKHv6QQ/QCEJooG4vBCbtyzB1/RjSKmDeGdmTG77EQtrMwsgu
	3d50cVYpyR6C6PemXWnvtkn2Zfnu6WiRwneizy9k9U2vDnT6UWY1tsUeKJ27Ct72xnOvG5f/jZD
	ya5J3gpPMH3LVvvqwQC1YEAaHDY66VlJS0AHZ2sqOMSKqnEB7Lyp4p2LVKg9+ETEj7fZrFCMmch
	7EG2nP+1GkrPVLyg+C3j8L3Ea/sAij2Qp0O1pnm4jR0i6XTMx+oYz/toEQo3CS1oKxw/G+LHJUh
	0LtfJSg=
X-Received: by 2002:a17:907:7b99:b0:c12:1d42:6cd1 with SMTP id
 a640c23a62f3a-c121d426fc1mr437953166b.9.1782627802896; Sat, 27 Jun 2026
 23:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com> <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
In-Reply-To: <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Sun, 28 Jun 2026 11:53:09 +0530
X-Gm-Features: AVVi8CdvfZ8_HcAxzQ6YMXiRMTaitnhhJ0mCfb8fG-r-MuhUVjsbTL_143EGKF0
Message-ID: <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com, stable@vger.kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
out how to make it properly work with my patch because of the
following reasons:

1. I don't want to move it to the top because, from my pov, there must
have been some reason for placing that quirk where it is now. so i
don't want to mess with it.

2. Regarding my idea of adding a condition =E2=80=94 so that it doesn't cha=
nge
the behavior when the quirk isn't set =E2=80=94 if the full configuration s=
et
exceeds 255 bytes, we would have to issue a 2nd request. In this case
the existing behavior would be more justified.

So, I'm a bit confused about how to implement this properly. Adding
yet another condition to fix the second case doesn't feel right to me.
It would look unnecessarily complicated. I would appreciate a bit of
help and advice.

Thanks,
Nikhil Solanke
