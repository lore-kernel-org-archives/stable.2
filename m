Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075243E064
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282283; cv=pass; b=YaG8r3FLJQt7obUMNZr0VqHX8y41xP4cR9a4yC+2AM26AB6hklxmm0lm/p1EurXyPViKD5w9Vf2kLOKmuV90dEh7ZCMs4k9Q9weL102fmI1t35VU9K2c+xrtr6BZbB7YpA2LgpbN/vLnycTZancTTqblL0+kxl79Ob94EnRfOhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282283; c=relaxed/simple;
	bh=d0cdEJI9/RswzkjbxjykcepGXr1VSGWZgZWnK4lfHUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OKgoGPV4X/G6RCKXOFP8wlXh0Kfh16WeAEd5C9Fke9Ka66ogKNhYGQo+8VqZEdVzRxFDtGWMslv6ios5BXAjf5elXy0KkkFL4Aaep9ci3o7VfrOpMNZGI8P1WNHKNDZYe7tXB+1jvq1lmGHXGI7Dakmlh2qKwYZmQ4pcuUk2KuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwvv/oiq; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwvv/oiq"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4b383347fa6so855391b6e.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:04:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282280; cv=none;
        d=google.com; s=arc-20260327;
        b=BttkQ5wF72Rc0bMKGDsWw7A+11k5nclCr/qwUKUd8LZogz/iT59d502tmo7BIPy+C8
         cLUm9XXAVWqkMya/CEbKTX0qZBHfq2BA/hCM3ax65meMfyxxexrk89W0MpH3ycKcuy6D
         cFeYTdGYRd9OCoDr2U3E+aW+qdsEOmH2sSD0hdasDIZqIp8HlaZ810q07Dfzin8cbpos
         nr+qaKWTXAUx1VVuKK5yMODPPrG22dA54stap09RQE4wyUjklW2rryd5ZD3E71ExIVDT
         DRPZ0csCkrKJNE4MEYzgguQ2WVIfvoxV0SXqswM+9ZC3XC6djiQQOvLQOeyMTCak8KDI
         1RDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        fh=86Mrj1UnXpzL03A+R/OhzHO3r48vhjikmqhtzamTrzA=;
        b=NWgUu5llgX1W68v51VCZdmoVOM2JmJlk5M1BWowJJsrVe2OYYtvVhiP4Z3cTkH4SgV
         MqNC6LXhmWu2ajjMubhweWLy74SyIuhgareNEgVnpJb0Xax3aiNv/pT6X9Nuk2HfzcQq
         aypgBKP3/2n+X5xqjetXK01m7HxI7g8yR0xBPRQoBh/X4OBcsOQJLT9zr1+LtjWJSmU2
         vtmsIg7/N79Uep7yagYD3BLXtMVj3585yOo/wXsuzv0ZEVB7358w0uNCOAwyhAWzPQ4o
         1lYQMEHrfH/ngOHULgRpnxQhwkDq2PVOGIbAyL4EV9EmbN5mYuQPJB6QBt6gUjAGfk0N
         +hAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282280; x=1788887080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        b=rwvv/oiqIjRz/IrkMYP+qzY/NjYS3kl/D9JfYWAkCE1dkt5ZlrdU9bRCP/vdOQWF9D
         sYbzaUuccnh9PYLKRF1JPp5qWKrWkmN6AccAZ83Q1z6nZJVoXp4lBov6GSiiuf8XkZX1
         n6kl6WFxNQDFd8/vB10l8y3pMk3UMeTdKSbhT2zZK9yOSxGsbfi061r7fZGEBe3cSsbr
         z/r/GyXokbhlcKXS7UdSQ7gdJiJr11b2mxF5jxW36gm7kpUIfB9NTcSlOLT+UKr3qXmS
         ROcwaMnOPRn/TuYEzk7GakKLLUuoCSCOnEoP+XKwre+gSoKbHekXT1kqLPgvEqo/QjvV
         +ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282280; x=1788887080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        b=EiYmvvKiPJ7mTSm01Q+8xMp641BD4NmoFhZEioZfN1TlQ0B0eeyHXnBL0GRSEcpBkk
         OBqYibEqNieHX8oT1C9YiXS6cXbOmbWG/dnriigm1kUd3NZC+FIAv8H5McYusAZtt2A8
         VZudMJe4kCEh+9HIwP07Gc/ZdhgbvPbTB5rGSzNnhsY0nwoJs3Gtitwqlu1zjmsfabGr
         1FpZLCQ+l2t9QyBdC5sGUNZDLwOq06hDlJ3rURrl4CEhb1Xu+ROVg3rHnIlxzoOOw+qX
         7ep8uye+U7EzmHvGSWNXT5EPtDxvJwBOHy7jiDLxwPFQpNeB4eXj0I253znqZfc3Itp/
         Gj4Q==
X-Forwarded-Encrypted: i=1; AHgh+Rot2mgQlb7ZTzOUEqPJODqlRLZlXlIeXMJUmaw93kbFDbUsjRHazxVY3s6Wp37P2pJ0KGkSGA8=@vger.kernel.org
X-Gm-Message-State: AFuF++mSHVTzVQ4OnCnJkdC6KPYgsUlWAsIUZxHJWMOeR+7V91h+xMS+
	+NzaKtiuqjdAO8tcH0zxZ+0DQbSHobxjSZznkNDVQrIGKygtCaJ8c6uKYlDP8yh+iZQI3/NEEmq
	EFT/P8tfEEH33F84fxaD9tr1Qo7KXJsntAvJg9YLrQg==
X-Gm-Gg: AR+sD10dNREdih7mUU/7VgsQ2CzDPP9r/XP4ntAfOaCMcq/SAyT2D7QSTgEbScM2RxA
	9LA6GVHQ6OUat1nRBmQmDtlXMTqTS2xh94XsXJzE/Ez06HZLjFeiXLg1+fEKjIFg6ht7CHKcXsH
	SCYEpCaTO0NUYVDPTtaV0w7nw7Jsh+07EFk9ylSpaMNoVOFGiNI2UShCv6s+2SGPSGqG8ogtiF5
	k3aAw1PIjbuMQz2ayqlCWZr2enLO/o0YdBLsh8/RJGyXgGk3W0Ic0PLMsuLCB6KlP2VvVHU8gfn
	CVdtY6GbnYHR84nzlmWDbW5kJgH3AeyWab1aOsghuiQc2wmZW8NmqP2oEUnWnrFf/Hv5f2oryAB
	gkpCLsfABXHE0RLfzIH4jxtAyGD9xdeWV1w==
X-Received: by 2002:a05:6808:4f08:b0:4a3:cea7:4ab6 with SMTP id
 5614622812f47-4b5befda1b3mr4924582b6e.10.1788282279853; Tue, 01 Sep 2026
 10:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901145156.3177187-1-mauriziocasciano7@gmail.com> <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
In-Reply-To: <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
Date: Tue, 1 Sep 2026 19:04:28 +0200
X-Gm-Features: AcwNN1UE6ze19kP9LilT_aCzQNaCwiaSO9Pp-1Fdq20zkQWrRN7Eq-cc3-82AVo
Message-ID: <CAO7O_xi-BYfGb428q1TO4ERp059-BOq78PZR5Ad-bs1ikVkmZQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
To: Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

Thank you for the review.

I agree that firmware-node references should retain priority over the
legacy name-based mechanism. The "supplied-from" property should only be
used as a fallback when no "power-supplies" references are present,
including the case where the consumer has no firmware node.

For v2 I will preserve the existing order as follows:

1. honor an explicitly pre-populated supplied_from list;
2. resolve "power-supplies" firmware-node references when present;
3. fall back to the name-based "supplied-from" property only when no
   references were specified.

Errors while resolving specified references, including -EPROBE_DEFER,
will still be propagated rather than triggering the fallback.

I will wait for Sebastian's opinion before posting v2.

Regards,
Maurizio
