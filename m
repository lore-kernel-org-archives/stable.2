Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988002;
	b=IHd4emn40B03bHSDo+AbHr3DRffK5+zkhGV8kJvjIavruw4jFs+46zR7FWw27QnKA7q4
	 Cl5kt+n5cRX8zyIbrOunkntCQXa6LVmdSYBsn3lH609ll/jbQ8gfUaBZkAsKxdskUkTGc
	 8RJFXNtOAmG4SdnYwc24A5N9ABxpjhWPTPNnzIhj+xwIuXCqMmAPAcqXyo/7NGfYbPe2i
	 DUxmfhCdtmoHfelZl63/t8uOpfMd3Re3VEXahP8GIOMgdaoTpobxT6BLXiurGlvhe0F2O
	 KWJt7zWTsvGdx2ODpVLmP6EzJm5rvJGrqumqmRK6UEqCFLJxubZ1hCb2QP+iu2DAFog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988002;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l+HBRH6Z2Sf6XQfzze6i5pft1TRrO4lvAq6O629kQwQ=;
	b=v5DoVuNDQOJuNd77Ejruky3m4L7h6YNGle7MXykZ/SY9PAZ0lL830FQ9YIZiYYKWUKlQ
	 Qrr6IIoT3fMDV8JyWgMbYhuUmrnceMGIDmPMy9wbgvgJ9DWJOHwSM88HlVzq6DDyVNErp
	 /0bEhe6HSg8vxvb33HOBB2+T7+9epeS4tP/lFE3Kd8wL/JCbPMXyYRQ5vOuagzHfDuBGX
	 dYEaMhR1NfASUiBXMpSg3JQTPPuU0Oq2/tGCAZbuxmeBYwnZDS5NVbA4jExwlHvlJbEiK
	 iI3yAJS3HHUN5CG1mCYAfA14k/yxjOU4b8xIEZIqQvYw5c+pLyTTWJPBKak2k6RkZBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V7S9TpIs;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4850606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4850606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=V7S9TpIs
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b203527bceso1305630a12.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793988000; x=1794592800; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l+HBRH6Z2Sf6XQfzze6i5pft1TRrO4lvAq6O629kQwQ=;
        b=V7S9TpIsPqXzUq3A6UkoBW71N9DZiWaA8wWWRo/cn+Ii+OaUl8iK3Fo/acjd4NRnkw
         xN76KbFxJpVXKLKrZX0eNxswogzOAtyhaV9Daq50KUI1qQ6bPVdWvyns8biF6v3u/LuV
         Sm8CRXLFqPAO7lbcQBhioPIgQBHvWkYe6MoAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988000; x=1794592800;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l+HBRH6Z2Sf6XQfzze6i5pft1TRrO4lvAq6O629kQwQ=;
        b=T/+/v0cLHmncrB9JHh2PKhuzhFpt/fix3J1EDairVnYEbUOsvLqDufyj8U7Yz6hhPI
         NneGJlcjtdsVqTYdQRlbIr+W8FA/IvOFTtpE45+kpAC/JuFD+MsfsnXhIpysZZo+EPNr
         iXkWiwjPlBSidoZiBeHCTFhweiuwqU7dICgLAwjPImvFzqCSAD4+QxX2E3mSHtt1OKC2
         +2SN5x5sIcIsfIlLQVXruPKAfkuyBnJcwea9L4lkmmqL9IP3PksDuHACdUfaQkK8pcyw
         Iy37xnOUBOW1GZnnG72WSWdRdKCbGzFf2L5qiAgSV93F0ZvQELsd7bg/PQkzMUVYV9da
         1n7Q==
X-Forwarded-Encrypted: i=1; AL+hErHl8DILgFoF2p8XRYtoZnxfw6nRPQLbsXUJkD/lr9AVNi/wCJ8PPsQac1b7cfsqS6pvqv99JSQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IRJe+BQVP/r31RSD7cE+UrOOES/iEIO2Sq/F1zFd5OJWkVbed
	z/in9grHmcXIioIL/uGa7ZUK/WrW9GKaKFewg6ZAepp/m/xent0lxjcVdhN+r4+IpGqkcFUVk7h
	eIylKW/h+
X-Gm-Gg: AYBFou15B+qW3dd5JK+Pz28sXfQ9jaMHtX2MUrCzvsjnb8XMcO6r+ht2l/mG0rPRkMb
	4/eaekeFy9imyNseaE6Q5CnQhqwl2OSUby9mEYF119HFb/rem56x3i0piwHzKeOBGpQPBHE+mEg
	6MJyqdHNIKNSjVvNWL4u7dzxZAAWkVulpT/3QyIwksa2Im4aJrkthAVMdKfPsMJdcefMEyjyxoQ
	bykep3LfYDQ7a6KQqscJZxZ0chqsSAkRYPEzx6EW5/0eL8+lMZnEUq4Jw/EiGLusAsuc7TWzrXr
	R8lQW4PFRlkIqASOurtxHeSCfU83qZJMtLKEmbhv62BfKbFC3eH++NoDjjioWle0Kuu63XJ1Ptm
	sY0c+tXM2diRAR4c1ymkgDUwzLjPBoyPrHotWRYZm8vXTdI05K93ydHcmmU8NUOXxRuTo95lHWv
	OnbAvd16Mn0W+crxouxXlAQcX8PXnqCx/5RD1eEc08FiBfyLFV1iS6E79cyr6vWtidErrqfdQp6
	sEnhq0rzJx2RIP3V8WUgUR8drfRL+8PnAI2OY5oKTYPUPbkhgAKm5ltSZY4ZI4kdqnmpcg2FBkb
	0XluZ7BcsKA3bXAau8YiOa2nC6PAoG6S0Yt9q4dUwyKT5BVKvDTX4PDYkK2zlleW3fE6zmJSHfS
	5PqMN8/9MdEST
X-Received: by 2002:a05:6402:1f90:b0:6a7:e514:1d85 with SMTP id 4fb4d7f45d1cf-6b5977a47e7mr2249685a12.13.1793988000322;
        Fri, 06 Nov 2026 10:00:00 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664ae5680sm940800a12.20.2026.11.06.09.59.58
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:59:58 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so8571785e9.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:59:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxHTXOVTtmQblbWL64GsiDpiCUoM6Pq1JvJ+qde3sChkfl58xKk5V5tKl4fXN2RYS1aX0ciAZE=@vger.kernel.org
X-Received: by 2002:a05:600c:8b28:b0:4a1:9663:7633 with SMTP id
 5b1f17b1804b1-4b6dd54b16dmr53499975e9.11.1793987997939; Fri, 06 Nov 2026
 09:59:57 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com> <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
In-Reply-To: <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Nov 2026 09:59:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com>
X-Gm-Features: AclHuK8dSVweZwLxaeldnIMbndWhz_-q2OKzaAPnRAmMzhlMe2QAncAFrE9VlH0
Message-ID: <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Rong Xu <xur@google.com>
Cc: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Han Wang <nesthanwang@google.com>, 
	Snehasish Kumar <snehasishk@google.com>, Nilanjana Basu <nilanjana.basu87@gmail.com>, 
	Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 6, 2026 at 9:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Just one thing: I think we should also have this flag for Rust so Rust
> and c are consistent.

Please see the commit message, which says:

> RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes because
> SampleProfileUseProfi remains false by default in the LLVM backend and
> is only enabled by the Clang driver.

Is that incorrect?

-Doug
