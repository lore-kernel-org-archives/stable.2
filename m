Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF159471D10
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784738550; cv=pass; b=VyNBswde5IcmpDmuNqN+QhiuMhuhQebAr3oRWXG34keTNAKcKCQ+AbQHM68KLGybWKGUffCXMPBt26diVyGE9E9RyifvRgdUCR6baGPvAXsjBCa7hbFgRE5vYUNJd/2khoUkZU+u3KI7/oGBb576/CAf1Rr4stJ+EjbES1vI/Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784738550; c=relaxed/simple;
	bh=1Sy316CYHaDxJapnwSy0hGoppwS0YvpDnjfnWEhoBWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nv9YegjRm7DDayDJ11JrvXg4FD24woXfliDai7Cy9oAVtmG3Lg3hS+SzA2y2RGpQX53DCNwkVFHV7+Kin+kki0J9819S7w5c1gfc1wVp21CoM74bl5cOIrEoaD7+hN6W+ca319KF7OwJSBGsIYu4KekLtzmIB3RS2213JakHjdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=mw8YSfcX; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="mw8YSfcX"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c166f1bbeaeso1423511566b.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 09:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784738540; cv=none;
        d=google.com; s=arc-20260327;
        b=J9aeyCeLeR04LR8l3In6cm8Z/7bwSikvQnMAqen/VPgHIFui5Suu+iOKON0PL2SQue
         aiEk7INEk7pJfSuS2FQ1ItX5QLPI57vrEEZJwpcbibHm4QQ971+dyo3A9f/7cM8L676E
         g9thP4k/LJyafseB8v8rbrK31H8MPRf8zokr92qM+E6Z3o2ftn/SyhWKiLjJjW5jm2eq
         LfCcYDcWU0uE0be6c3+2SAuligfV5vem5rguygE2gNqmNl8uzr57n97wTq6pb3QBiQcc
         wqDy5fZzMkkJ5m5hnNWTYegB1Ap9CxIbVzevICBUtMFuQtywdLpJWL7VYFtfqO21EVwv
         jmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7TP0pyi3l+8y5BA5jYpU9YfSpNIUhzsn3PMr/1sHd6g=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=cZkJNi9RLUoTq2rWy5pJ1VOyKFBQ0DN5alc0Cj8/pgQTWd7RAyLits0u0VXEj8ZwvT
         9iAmP+1V6QcmQ5o4E9sUWLogypmw/Dara/VDWPxwolCf5RdFaX8kCt38FoiVe/dr/Lq+
         qOVisJZgdETi5cNr31itr0VUQ+kqO46NKJxoaq9LjiHBf797mTS36R21P7pUWEjZ8i1j
         4QK16g4P0PkEQHaomcLj9Axdi7qfHoz/SbCewnOPEn76otbWUVYhJ8P3Ox79gUWJmRXU
         cWczEhAsLVXH4beklPkDE7F7gsA74DgkMZanvRAElJAGqilv2WrfOC7Rza8YycgzqczB
         PNOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1784738540; x=1785343340; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7TP0pyi3l+8y5BA5jYpU9YfSpNIUhzsn3PMr/1sHd6g=;
        b=mw8YSfcXDRbgL4/YSCQbXbBa6iqm39ou0sgeSluGVRV8MzcrPQwAOuhvrJMM3YRdUv
         S9oTa2eo0DgDVioXG/Y2HjPJ+8WKCx1Q6GBiElx7gWltUszxQwqu23zEg364GoHzj7k1
         1EB7XLnp/SIVuBhONtt1ttkFcXBlalNFqMU3RSRUVrdNZiqigl7LfByJc7+EK32iMalI
         xUe7JhgjIaYY4Vu14hC8Z1FgIGq1VntaN6WnbjP5DxFEtK7n0HXsqSi2nc6RL71nWnpQ
         12AV1YG7uAu59jg7tG+s/RVF8Z0XwnffA/Q+MUJT+47tHYG60gcxIpLhiHUVKFLyaqkd
         COpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784738540; x=1785343340;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7TP0pyi3l+8y5BA5jYpU9YfSpNIUhzsn3PMr/1sHd6g=;
        b=Ug8m+cizte43yt1ApBTU/rB68z7wVuD/gzhCH9pV2tykC5OxyHTZM9Pz/nSZJ804G+
         VkhUb8BuW7TXdMLRo4axspdukVO5FaebDgN1+plDE1gm4h5jbgJJo/nQOdoeYTgath4U
         J7yh9o9v1jglQmS5P6gp00pcmXurOpwLqY3x2hZ33l4MOmkeH38FC7ABnRlgGGdJe/se
         OpvaFXfcbXL8LMGKZsoTCgAKV0MA7kO/9HNfDufFwgEqrz3PGm6MNTNBwcxUKM9H6VkN
         7lxob3jLJr0CllatCkQT9J03I1L1zHlYZhuUBCA3lzwq9oNsKk2+UAY3/legKGgWvST8
         iMSA==
X-Gm-Message-State: AOJu0YxlND/bkBACLZ8oB44ULWNrd8GQFXm4T7rwaLSznTXsyEOU4MCs
	KgVauoOc7ASNeGKxwgMo1abDnNbK1YqKoojY/bAdpT/A6MxJpZ9w8jOMqtL+5XqxFsxEZxdE51h
	cwXUmjVtvvuwcnUJBSX8FnExZohrQY2mCRprLcfaJOOJ9cQUp7VS0NZyjHg==
X-Gm-Gg: AR+sD10PEOYd6RPSOkoolhlAMbx/tMCTt64A+MyAKB5Ir7e4lrqZ0eVbNRoMt7mtr/n
	JSrWkhX8HobrSr95DRmEJ13BnF7KIz7YeP8yVy6XJTVdsQ7zfOqpN1DanKrkZlfiBuJs24Q4sLU
	sVbn/mOORF49QAuANs0zfS/uAHmb3K4eLoGA7K3LZ8Xg1NWbv61h2Bl7rx6/AGnBKyroUsDznz8
	U9RrWTOLT0bNTWpjshB4YhbiaqvqMARjm7QdqTJldPxmzvDJoE6Am9iyqPM1ADyaHbjW3RMaxL3
	t+n5PiT+GnKEWfMQNWXjPA/xHXg9Z5qZ/k/LMBFO23Lr6pbjxBsKBRALKHUCzuYtDldrXD88ncw
	PQN1KCXyvcN2cx3Z5+T4evZb54If0
X-Received: by 2002:a17:907:1b27:b0:c12:6201:c4c6 with SMTP id
 a640c23a62f3a-c16b45811d3mr1056277466b.11.1784738540044; Wed, 22 Jul 2026
 09:42:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722142947.085426486@linuxfoundation.org>
In-Reply-To: <20260722142947.085426486@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 22 Jul 2026 22:11:41 +0530
X-Gm-Features: AUfX_mxBtH5GVg3yrhg2sh75RiE344YAAmxUpZm1eBbaFsnz3VfaofWya5rMV8s
Message-ID: <CAG=yYwmHmtD8p+mNMTasDdhG+V=0ByoBgoY78BgYKf3981hw1g@mail.gmail.com>
Subject: Re: [PATCH 7.1 0000/2079] 7.1.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello,

 Compiled and booted  7.1.5-rc2 (using qemu-system-amd64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
