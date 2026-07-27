Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F53BE62B
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154562; cv=pass; b=AwtjzXVb5Acr9x4eSAuMn+Lgavp55FpkGbfMO+Wzo8d0FETdgovAh5a5a3+OA+ECo/jeuuSQHZ1cc0oAaEcS5owAGPyLBmi0Dnsj1DW+etU6vkLi4/JcKd6O2HHz76vk9YDCF42W3cfCJqyAiBeEkCS+/QhD3cD/gmI5mipf4IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154562; c=relaxed/simple;
	bh=2dnykRpHze8TEvIX/f6BP3ebkvsUAMvb1oehjQu7tTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFQBZUSsTtnD8jgfa9+EGcV+MggB1xQzN8UgYiftpD+/EHwSZMszDtgXiN/RdIixKGXf1N08SIdOQ2kQ2MekAYAeYEXzcktD/v1+xXFTu8KgD4aFcHIIQJMJLeBD803pIMBNBn0VUOmLERpQDXLDQAEQoaY/ilHzslXi/+uCL5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/1u+YeR; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/1u+YeR"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c923b8c2aso26607831fa.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:15:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785154551; cv=none;
        d=google.com; s=arc-20260327;
        b=eysTw4ntkwf5p17m/6z42H05Xjm88TrjbxyGf04CK+YS4hGljlyMHtAuf21lFpS90K
         iDFV+OKpUegvgQDZhl/szK6F9KzpmPJ5gEeKKmFx0WpBSbSSI/QNXgazEhEaWFvs+OGh
         24PTmeCCcpvTACPIrEla38QIqAY2ITf9LA9AM1tr9xpq5eGpEGNJy2a8SSzFVH/7gSKN
         CfVeeUc6Hg9ATTe9wfSAq50jMq1niJAvH0b9OB4/2yS03wCMlvboClCsQOp0bcnfrLon
         ibqjg/HpH/Rx1+FGQw35xCuIGbweNeoUleS2zjMwz2zDtcMaiLpvqBWOM7jw0B70JVY2
         fJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2dnykRpHze8TEvIX/f6BP3ebkvsUAMvb1oehjQu7tTE=;
        fh=8Bdr4KKslZrPQ5ZSSoJg8ftxYorpmstm3+Qo0f1P1Oo=;
        b=ZVQXUmUmWrs0Cal5y2S6OCSO6X8JW13Zdsa/Fp+Hwyqz1/IwxlrWEMzPDWNL2Scsx6
         XnlIWJzckZGNeD5x530M5iVdZO2EK5iFYAOzelutz/A68E8kAWL8CN/4LyXtv1u4W54y
         ZcRXHAsEffouA8a1+UIBHA/7MD3z+67DxHeoPzciVHDTG1ANjLsKC8VdoBqwb2yDoP7C
         VVvbxPPjE8tbzE4vuDUaoMWeAB8ozBLCcoBo+wrefYmZ64pGcL0gTHZavgiAvFQE1OGO
         RG/Xk+lXMldD48ta/GOo+JCrnp0deMhrd+sSf6gqGAyhd/AtXgbciPDbWedHYcb8paQc
         Yfxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785154551; x=1785759351; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2dnykRpHze8TEvIX/f6BP3ebkvsUAMvb1oehjQu7tTE=;
        b=B/1u+YeRoOVwGnakjDyZDTJXXvSVltFVaP7oYuq6phuM7+FHGkIFtE26s3W23vJ9dn
         ZqTbZ3oqXC/o/3mcEnNqcQY16xAJ/1vXwO8pEZHSeaH74rkLyj7xSCboHqVzzxq817Ng
         w38ioiY430ayLR1u6ArxcJVULNvhNWXhDPpOwQhy5rqIjBf0VzaljCP45q8/esQeohJT
         qieJKj4SwBRXGzPiP+RL0G+50AfYQLAMUPJe6dOWvbBoX5TvYpPFv9ybTic83LGHcnio
         JO2Og2SCY7zvqFUGPUXBALU/N0uhppnxg/gmSTtoUDnOxJ79RJxhOA2UTVOxtTByzl2k
         SyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785154551; x=1785759351;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2dnykRpHze8TEvIX/f6BP3ebkvsUAMvb1oehjQu7tTE=;
        b=ZtSqA3aqmRvlNSKucu3rpjq0oD25vbLJs80IAOBN/rsLlvLix+SPuhSHqL6JbCDJnk
         Qzs1/xnpsoUDXeHWw9qAwTVBFaUhrxlTRzubMFKpnKhU5XCOcywirKT+sbZhIUJ8Sr1w
         8n3F8pdleBZg42GI2XZghIDFEwICkGWrgUDIi/2kQRPIMw+Wn/NnTi5WGDOflRgP3KEP
         ILPvCwJjuTwv4HcyogmPKBSS4pKpXODnCp2w50DgPwci0koyzybtAHaW3g85xWrriMre
         nbjVKz0LbN+0PO+I/tRJEiihkGiUbm1PL/3bV6BW1hHXW0kHoYTPmKs40uFW9sv7QDmt
         V9yw==
X-Forwarded-Encrypted: i=1; AHgh+RpDExFUNvBYJ3C5fROoujv7kpGCYzYs8+77aC+9AeNVuNnHfuNmxkQF0bxETPYFcu/HXtWHucQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySeJIJSwO3GXTMq84llz44MzSkXDW+/Vjc3K6nrXj41xM1lMtj
	aLqKg2dp/KimP8tS0R9UOtCEr9pjfhXzYC4JDPKkJaSPEX6YRTZvEz5OwS7Bmh1vT8UC0HVel6P
	L+uK9UZ7XlwkEAHDKLUYRuW6bvUPNQck=
X-Gm-Gg: AR+sD11FICg6+/RYaOD/+TgRgOjPVHVxzBeBMvqlD1x0Xbvj/waFEcrz7HZVHhbC6SJ
	JY04oUzel8q99v1FE+i2Md+QC14OPRGKJAQRqbIuAeBpE5CylSYpAZyzuCpatcDs4+ERMKH0jUA
	UcM+AyCxlHCupajfeY1/zOyhLpGtIOVRvMytFyJrv9NOmQI4zCjXMwzO+zgxZWe2yNSGldZ0jCa
	rUOwOiKAV9SMvqTcT3aFPIoeA7EWY5/7i6cEkRA6JL8m7Cei8w8X2ql4O8vSW8rURs6pZgINRFx
	hzXXxfFRbv9R6agmfp0Rh0CA535FEUvsmcpmDoJTQQ==
X-Received: by 2002:a05:6512:318c:b0:5b0:141d:ec5a with SMTP id
 2adb3069b0e04-5b2c1afb57amr1663610e87.13.1785154550644; Mon, 27 Jul 2026
 05:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712221709.7099-1-gvalkov@gmail.com> <20260715145228.GG56330@francesco-nb>
 <CADOrJmYwYs08REP3eSwiTQegcKHFLwW0gpUexhomLDtO91ASMA@mail.gmail.com>
 <20260716085942.GA99146@francesco-nb> <CADOrJmbJAfNoyAuRq5OxP17r6rCAYFFJPy-Nvj4D+1zv=heK2g@mail.gmail.com>
In-Reply-To: <CADOrJmbJAfNoyAuRq5OxP17r6rCAYFFJPy-Nvj4D+1zv=heK2g@mail.gmail.com>
From: George Valkov <gvalkov@gmail.com>
Date: Mon, 27 Jul 2026 15:15:37 +0300
X-Gm-Features: AUfX_myGzWRT0vMuD4XimDF2RYBSlHK6CH_z43UcRHdj4YC8E-D6w2CjthHNS5w
Message-ID: <CADOrJmYyAXzx9wVdLMwtvaFBcKcEPWxCv8OAGkkDYZjZGzoOCw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: fix freeze for 60 seconds caused by request_firmware
To: Francesco Dolcini <francesco@dolcini.it>
Cc: johannes.berg@intel.com, Dan Carpenter <error27@gmail.com>, briannorris@chromium.org, 
	s.kerkmann@pengutronix.de, kees@kernel.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Any update on the progress? Do I need to do or change anything?

On Thu, 16 Jul 2026 at 21:01, George Valkov <gvalkov@gmail.com> wrote:
>
> Thank you! Note taken and I will try to do better when
> I submit my last planned patch for this driver, soon.
> I wanted to collect opinions from OpenWrt members first.
>
> Georgi
>
> On Thu, 16 Jul 2026 at 12:00, Francesco Dolcini <francesco@dolcini.it> wrote:
> >
> > On Thu, Jul 16, 2026 at 11:26:54AM +0300, George Valkov wrote:
> > > Please backport to 6.18 and 6.12, which are used by OpenWrt.
> > > Initially I did not know that I could insert
> > > free text between the commit message and the patch.
> > > I apologise for that. I am still learning how to use git send-mail.
> >
> > Please see Documentation/process/stable-kernel-rules.rst
> > It should explain everything you need on this regard.
> >
> > Francesco
> >
