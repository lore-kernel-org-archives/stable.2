Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5A373BFE
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374138; cv=pass; b=ke3oZMa+LcSbRFCSvtJ4P6I+/fTg5GUg5JFsC2lWizMTJyi0n93T6baHuOvGP8uizxJBoedGPWHIFHM4qFCKVJGIt60Ufrn3IMlDeeb3jauSZGFoZxopvvV/SyQQXuvNgRrKckV6n/Jo/MbIMmVwLQVLRJSDhFVs7CwNH2vCCqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374138; c=relaxed/simple;
	bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLtNYPq5QlG6Ik0ut2otEaLPLIezterVpoF0wbbH5Y+RUP4nPmHdzkH+h9z+tL4fRpVgyZzoaFqgNmyS0zWLLeEMwai+l+xqiKMGKyxNG6J/B2nuF85cLdrAkbrZxPFQteovyQ9FbMJLd8zpAvDygqe3By8QJnIMagu7RuhguxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com; spf=pass smtp.mailfrom=melexis.com; dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b=1CWqQZZr; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=melexis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=melexis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=melexis.com header.i=@melexis.com header.b="1CWqQZZr"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92213351918so209517185a.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 00:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782374136; cv=none;
        d=google.com; s=arc-20260327;
        b=rAoTqjXq5QiG4zYXyMJX5CxfYPgNrk7eAc2mrs9WsfgoIfZrT/+vtd/p7TPJ0FZSEL
         jKOFj2UtnNMv6LAtTeAQAYvUEckaVIocdAqmTRqgKbBg/kGpmoZ4EBUg3R8ayFR31lTh
         MfbfTGuVq8Zyvi8CT4JpkoG3bx8+5/0cQAoF5FwRxIWjhPWsnIbm3rOQCHJI4o1ygVx+
         vEtcn6Yb7Dc/8zZNcFoJo4oEbZXwFGPAXujQOcushoTXU0nxIIaLGp7OuWJW+g/2fBiA
         YAnN8aGlXlt1y/2c9rXE3oJVAmunham3l/oaOzotNJG39i6Cz3BVneyNUv18ED1rPSKm
         Zcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        fh=eEghoWRiBlftapybIwf6ZD3eZqu+fsX685Y3gLBqDCk=;
        b=IuvboZxXu03oQVGw2qxijAsZivN+mDN4+rB2hhH8ovSthmzJZR1pxJBWIv5O2F47F8
         lvBuntqppH3KZFA5UR34Bx8FyspGw9H6uzoCjnw57lO6aAaA6AWcxCvpUtoCiPxDSZMG
         oePujTRL2/Mu9qaAYl0XFvnCWlu9Jqw6WyMZJM2yyfhzqarlQaugQqlIi8x+G0M2Ux+/
         mgcVPPUIjLw0zyM/UDKA8n6DW2v4nX9K/Ex4wDFU+G4nV+WsX2bwVH3KZQKRETqWB7Rd
         7kCQRtITCNvIrwpv0Tj14xctf7j8nCaSdXasqLdAqLTy/unTirCsJ6y5iPujHrgRP6/b
         ym0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1782374136; x=1782978936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        b=1CWqQZZrZRfJWTcyZ9Z+tZVza4eR5QbVhJcDmuIvP+87DTN73i0WeXLF7qR8ajFHrO
         W9F0oJJ23MX42n1DUvnBCsARqXQe2deL26DjfyWRY51kTiqFiW7vprT+KyV2+Q2l516z
         CdxkQuTYn42Paef64UUSVQ8zlevcKLwpZW31pzu4bPnnp2aJcYM38vy5/4BUeTVmamgI
         cBZ8alAKH9kCewfzqO+OYhIHMbHWwsPCfrPlF2Pecp/VXaFheMz9ihs6MYBfams+w3Vx
         eDX4tbR/Oy2ZrAwLRVzTf8SNAYCVuMAzwSfVZK4cDl5WA/zSUYb/Z+/ICI9DNPUONqo1
         mPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782374136; x=1782978936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeixKLDd1bxLQVD2tdQf18Y4CR1YFUz/5IolhY6Scdw=;
        b=Uw1Newrj+ivdoPlG+OT2SJw0qVCHlhhCVwOfgj6QJJZy0shRDBR4q7SiR/9TDXMu5I
         YAUKI7L3wFc2QEK+PPLqiDA4BHGCiUjXwGk6uRk1nuzpkLgdEQsJQTLdAi8g+G6LyXo6
         6I4eAX14T1xnKpttdQ2i6o2sLP7qxEAvtVgGXWLKYrKHy0jodutrh/GQpPqBCzrKTfAt
         1aIP7hsJ7Bj8VcIZO+5u1Hn5UM13bRnGlmci7fFz9NwmnPuldyuQbnCArkE0IEBjivE+
         w3GdE6ZAM5pE2Rqem7EqZOOam6nkgp4fvCHmvl4iYEy7S8xePW6Cd60MxAASOVElTyYM
         86LA==
X-Forwarded-Encrypted: i=1; AFNElJ/125ov/P5gdwn/op41P+JoIvGCMZlISTze8jfXdv2A+jpce1ij/8rTAll9flvuzz8R0zQ3vfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+TWdrL4FrGojz/gvgcaTTW7YOUHdzNehSWdMcWP+x4aOSioqX
	8OSab1SqT7d2KCOcQdL75yXh3hLAc4QOxyu1I9By+Lz27Fieodo+RoqcMa0r24DDrIUhv/Df39t
	hRFzA/7AeGvvNB8+1kLVDcjyN2kF/ZHfO+BWEzMvk
X-Gm-Gg: AfdE7clx56vlyeVrLMAe+1r8AWT8s1WBaBloj/h5rRDNzmZVfz9ZUfILx+dpoDfaopY
	eHZ/HoIu2bJONAdfbpeh4M6/AIyo0Cst4qSjKqAsMpTwY69d+P2NkWhvXv+ix9npy4qi2jX3MAf
	ogBkCAfi4vpk2HQkyO0IEQObddOUSvqZWJYA2V2bnYGfBuvVFIzREQZVmnmJsHvS2gzPtDto/YG
	3ZKDhxumqxBGx9FB3USZiFdAdkgyMzdULsZ7rhdoQijagfgV3e5cCrnIb2UbWTbfs0oJg==
X-Received: by 2002:a05:620a:3912:b0:915:745a:70fe with SMTP id
 af79cd13be357-9293c11e3cfmr179731185a.28.1782374135581; Thu, 25 Jun 2026
 00:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624081309.77805-1-pengpeng@iscas.ac.cn> <20260625054259.76774-1-pengpeng@iscas.ac.cn>
 <ajzOA3MGaCqrgCDp@ashevche-desk.local>
In-Reply-To: <ajzOA3MGaCqrgCDp@ashevche-desk.local>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 25 Jun 2026 09:54:58 +0200
X-Gm-Features: AVVi8Cf0Kq8KvxED7bUTegw9DwvGkx-iAJ0WMlc-jUAjlQ3zb6kIh99CFD1m9KI
Message-ID: <CAKv63uupUcUGXwXJQL957YtUmP+OZ5makvGROvFuvS8BWF-sPQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: temperature: Build mlx90635 with CONFIG_MLX90635
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for spotting this Pengpeng Hou; it's strange that nobody
noticed until now. I would like to apologize to everyone for this
mistake.

Acked-by: Crt Mori <cmo@melexis.com>

On Thu, 25 Jun 2026 at 08:43, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Thu, Jun 25, 2026 at 01:42:59PM +0800, Pengpeng Hou wrote:
> > drivers/iio/temperature/Kconfig has a dedicated MLX90635 option, but
> > the Makefile currently builds mlx90635.o under CONFIG_MLX90632.
> >
> > This means enabling CONFIG_MLX90635 alone does not carry its provider
> > object into the build, while enabling CONFIG_MLX90632 unexpectedly also
> > builds mlx90635.o.
> >
> > Gate mlx90635.o on the matching generated Kconfig symbol.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
