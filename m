Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E1243550C
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131081; cv=pass; b=jd7uNJUwacSKCZvnRbLsq70rNtMwuyz7CsHfm1ciiNFbdLSxmlo6boI+xCdtN/mYc8gLiDVS9tL2Cy3ygLakzWL7XJgKObNU9u0P69yRGRieCiU95zizi6byAzmejIip7vdhneSu79CXfGkKXKvG9wFWW0R68S16JQFO7udhMHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131081; c=relaxed/simple;
	bh=kVzk6H4/xbY+K1aXAI3iqSMLKy1QzYUGKLXPF6MwLSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrW0BI4aQHB1exYnqiSkAaElotXu0NMxWzMIOwCO3+ci97oJn7Pfqxdi90tTAWG2GxAggdpnBL62fgk6D57fK4CJZYN+aMfMBxNj0jPqbJ48KHvfU/p2nghlyTRvsv7HswnqmbN9woD0sMwqq33LdbCxX3xdKvDYaJRRs6d+Su4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=GNM3V+YF; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="GNM3V+YF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1670dad7a8so116280066b.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787131064; cv=none;
        d=google.com; s=arc-20260327;
        b=IJ+QE1Dh/7YnWxvhZpS7P0O40eqjSda5I17lCKO4d53MLUvZ6y7A9UjVpxRPqg8+bP
         R+Ikhc/rn+7rvzklHxzuQLC+n5M6CC9JqLwLjIR0QQn12heJoPK3bNPOhdW0XFXHiMaA
         h9U+Bx4YL2d4+WnnOiOT67UzIxN8WRWss5HO0ccQ3kaWJFeVu1p+8903tC7J4zJZc0YO
         7rvxUfnrS/+UKSL6LYb0DEf3rjm57Z29GR18T99WototkOf+CORCUboVXO9vvMFGc4B3
         E4dUmMRUTCXKLnOb9+kbzcavDAVETyFNUnD4dB/Rx/Oo7rKAdooaq9vxCPbADooqiowE
         OWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbOII4SMA5lAflDDNgVaa5UMQMG1XG5eogBSO/8/gOU=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=EXL6I5u0/cCJQD+2kg4Z0BIbk9yV75PiVTraEHp6UOj2wtIYABM9uF8YEWPbUJA39w
         LU1lpL1l/3N4XE5BXXIWOJrVra9l1naZMg8g1h90lkRfFD5nwCeXIUwxPWeIhY6d7OY0
         UHrpUDi7JpXoKSgdXS2lIWkl6nlQ4Allt49/ADCr3gQ20jmDAKBWkY4icpniV0ueN3Up
         8K+8Xmb/eWu1CFsZHiBA43kzQdQNcnTvC3N8kY74EhnFtqxiz0QtDWo4HJCzl3pVYoj/
         n0RoXzVQSHLZ+agW8t4+/QXU+2Mlg/U0DdjfAGc/Lby7Bchw6U46PMTC2f0DUrTvLcUp
         IkeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1787131064; x=1787735864; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbOII4SMA5lAflDDNgVaa5UMQMG1XG5eogBSO/8/gOU=;
        b=GNM3V+YFuFytnR3V85U9A9O7/cFIvEbRxo+rZ0mo8SPSdQv9h36/b3ALqylG8mxCWN
         F7ELguIXWKhu4bOPkFr5XxqC6Lw7I9cLdFnOcmaERFQHrp8RVlOhrIi8fcfKMkd3gmbN
         uHY4De04sGDvlkIYPu4X2P7aTO+CPgZAmQDbJmKpw828Aj1C12HFmKPPlyXAuwhKiOYX
         xA8QqMnaSMk77n9Y1r+qc1tXKEYrddC75fiapaOAbWGiY8u6LCS2bmhJ+MymuYWiCbtR
         77+QFtULAWeMawVaIrjPrKLqIPcYqtqD7N59s02AO4yoKnvbnnnkPT7UTFBm1bDkDKCQ
         ivvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131064; x=1787735864;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cbOII4SMA5lAflDDNgVaa5UMQMG1XG5eogBSO/8/gOU=;
        b=Sj8xr8zCbNRKdpmYAHqlBLMwjenU351QtMK/m1jTfVZ29O5+Q7v9F/TxWXRAY+k9px
         k1pAh19ICmsGoFHy6J4Fl4urcnxPu06TcnxtucnqqwSaOsmfbcb41Zjmjs7gsUjZ3V13
         5c3+FoFnxMuyV205zz49gZpQrULP2snsTQG+VCR2cwUhr/qX4DFaJhj7liTCSbseYjl0
         R8TQSgchRc0T78Pqg6VBJX6WpmQCqvHRgPNhAwQOG5WzDWQJnWoFM3EMA5BCBzf4/ZCA
         7t5VA+zQjHjQoc9yuFtUKZJNDOFhIZ3RDCHBmsQM2/1Vmjr3LT9x6Y+qfH+jlcxUi+aP
         h5yA==
X-Gm-Message-State: AOJu0YyszXuLqmoLiyuyRr/IKII0k6Eezy/QHLDwIGI+WFWOVm/ogRXQ
	4dVho6/97SKZERNc9fD8Fa17gVtM3GJ54OMXngp3+SdgoIe68KS7pVOa0X9NJ2FF2MAAurKUtTl
	VxL+G/j2Ej3jnWWlpnzIJ0lvrVcR6z/s4U3sTOjvoG7Mp9FHf+BlcUCgUow==
X-Gm-Gg: AR+sD13Ra/TleG3d06qIurm84x07QBg4uz3uCxoRWhLSNHcaHabXln0gkn0FGgETs3Q
	9iXyiRyZK7fDZN2FdwLrGGQmxfDUAFXN0qNu4u4/H5TDXB2lnbxSZa/7F1VbK82Czo7Oekvhr1M
	u0mdpYkvaX38k2eyJoZkxSaII9hRsZ86LmQZCLLJ6PnPXiQvSoaeYxbXbT8ZaJyAX3YXGc7Nu6n
	2Aclk80kyg3jwp+brchRKyd4/qPtx1yDE3Lj6Y73j+tawDvYRItSkGNT+O65Nlm00ZeDN7Lsn2k
	7U0w6k5hMUIg5tj2mAGRFVighDcFwBZOTSFjZcM5Yt+u6ascbv5GCNr2Y25U8uLyDyaHwDPCW1T
	DqzJjCPTxfHjyw7aOlioRDSzJA/kfQEI8lzh7PVpDBA7CMyFlnUyhXi2dFVX910sAwvkg4ChNO/
	TxtRsUT7kisD3+6A==
X-Received: by 2002:a17:906:6a0b:b0:c16:2dc0:e1ed with SMTP id
 a640c23a62f3a-c23f9317367mr180650566b.4.1787131064517; Wed, 19 Aug 2026
 02:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817132536.752504388@linuxfoundation.org>
In-Reply-To: <20260817132536.752504388@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Wed, 19 Aug 2026 14:47:06 +0530
X-Gm-Features: AcwNN1UiULEM3MbnwL4VuzhY4xiT3pEXAY6LKKTg1jmDWoLEzDqkTP8LLsJWmrE
Message-ID: <CAG=yYwmxBjeuho30BMmfscK_r0WRcMykfKcKqHXVdD1Oh8KNtw@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/271] 7.1.9-rc1 review
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

 Compiled and booted  7.1.9-rc1 (using qemu-system-x86_64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
