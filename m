Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B812449B47C
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 22:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789683168; cv=none; b=s9fmQ3Ps0OpVSGFSTRRvEkZI97RFV/vv4zSOCHvAHyiRpr/eIlpNTMCemb94CDdukrOASBj0WTZQkyLXlJHO0v0bOuoHt6/zp3JlZ7GudvO4vadiOcLXZBrBeT39UbEuAsm9nvtNp6DLZn/bej8z3Ad4GUL4CzhZqVtwMulKzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789683168; c=relaxed/simple;
	bh=V6nnwvB9sh6koSriz+lfylny5m+Sh6r2d5ywRRJaQwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPls0cWwT1BbyTN9mnXsQp1VTrdjydKzRxnbz/f+2TZFIkElimK7/ZkyeiX33xnColPDn3fc7XBO84NqQvq2IAsIeM5lpYgQ1VgtSNflvsmQqvDXg2A3VMhT9i1pW9lOiAG9yrrXxlYfRgYCp/znbGx3dMnwFx1x4/VQCrXjt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Y4KAOJCv; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y4KAOJCv"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4843e397f74so34659f8f.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789683165; x=1790287965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=04M0oD7PJnXKwygY7xXBRwcz1/IqxGd86V4FW9s/qsg=;
        b=Y4KAOJCvrFAK6diDTMNu/FdQbndQmNc24pz60+0BPb7rS2qPzkNoifQA9Fz6M1lLef
         NVFgcGcE22W4KRvR2HiK6IF8EUMbh3rEYbSM26BZVPgbyeo3tLyBbJgpRtOT69rgoVId
         T8NOF8EdWmnmywvFzVfV7V97VSFY7IkO4VNWn/GOVu8sv1WCoZhZw5zeLBj0Bm1SumSa
         UfM+qbYNIwP4af12HtPFWjdB8GC3I7hIw1S+yy8bGvLgAGVvfApzVU3RvQ3RE6OaI5bT
         n8Ht9O8O8mVPWFIahZJkxF9xiptdArkj0wJpw+YxavKUJCZ46CWC1qGC6SxGBB5rYIAI
         PRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683165; x=1790287965;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=04M0oD7PJnXKwygY7xXBRwcz1/IqxGd86V4FW9s/qsg=;
        b=neYzXdZQBwFm30bRpslVn3dWxMSa252EAMAJqBO5Q7QiVAmMgsaG4vRh1radz5HTFa
         zoJOET+8sMAWciTKLNvPC50C2po/ELXlYez13dFB5V9gNqZa+NrYHm+m9DO2L542FE8S
         MXkjHq1LkFBHQ/rL6l3/OW+NU/dV3u8kLx653f1OhEl9pAjTogcjm+eLqucIizfad/7y
         0qzjZLmMeS+Llao3+sUZTyANdSdi1In2JLd+tKLpqw/qxjFus7TrIroy2I093qqYCSmr
         ktXLsNa76BTO8jYv211vFA7f9t+sInZyTUVd0jdumsuqlnDt+G0o/MaRKXRKaGGnf93T
         Ourg==
X-Forwarded-Encrypted: i=1; AKwUvBxgT74PETi493wqlgNf2Slonmvl6gi8jSZU8Zbzlhw/MLRWhI0FKtoP7l5qijWUGKEtr74Pm4g=@vger.kernel.org
X-Gm-Message-State: AFuF++lwztHuDQ6n7qXERxnaJfMvJqg/rEK9aucAuLYFXp9IzS0EEhti
	5nbCYUNCX7AA0GfQDISUJdxON/kafzFwob2yxXSLmmXezbQu/WR6Xro=
X-Gm-Gg: AYBFou2nEgksjUeBzQ2NiT+woeTxlimJLxOTwh8d75jOmZbbdQ4s8FqIVzxcmDwklNW
	9stIx59oE0u0HIVW2Xud775vrNiS5l8J/EJvedHLBg+U19GUo2KUcxn5h/0uKep6YwSfnpIp4X7
	KqML6L84SANxOkZfqqHS2udqWLGZU7xgyrDIwzkq6URn9S2hpyqjegHu3d6Gm/MaWmL2dkTz0Vg
	SrZJiQt90kO1xjGC39bBFbH4ss2ImbhnFuIYZTl1f56FnMavSSGAA6X76vt0YH3QCwh0yki2QTG
	XUUfqoq5ze3tcT5MNesIWGQwexxjAGiLu2SFfPIMYv9XBH0U90h5EzbrGapiwF9UUF0SoxLoLff
	ptcW8v3nNS9QXuj/XlQXjLzM0tG3q7UPFXIFI9dfj0ebqMCFB4i8WMjBuG1RsJTtvEhBVX/315L
	4Lv0p2j0fTnFqEUuc8bDGVyr98+VvQd4qcxf/bc5JnpgkIPthydqlxrfqmVhb29zkdbhgn4Yg2s
	UMNtx/ItqdG71h08XtIok04Hn/0Uteq+hQv9+uhXS0HP4gsxffJlGjwAg==
X-Received: by 2002:a05:6000:643:b0:487:955:e6c3 with SMTP id ffacd0b85a97d-48713a887ccmr7483885f8f.0.1789683164645;
        Thu, 17 Sep 2026 15:12:44 -0700 (PDT)
Received: from [192.168.1.3] (p5b057001.dip0.t-ipconnect.de. [91.5.112.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fad3sm17073721f8f.12.2026.09.17.15.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 15:12:44 -0700 (PDT)
Message-ID: <35368918-5b16-4b29-937b-e652a86b0393@googlemail.com>
Date: Fri, 18 Sep 2026 00:12:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.18 0000/1250] 6.18.53-rc1 review
Content-Language: de-DE
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151551.901433442@linuxfoundation.org>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <20260917151551.901433442@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2026 um 16:56 schrieb Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.18.53 release.
> There are 1250 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697v2 server. No dmesg oddities or regressions found.

Tested-by: Peter Schneider <pschneider1968@googlemail.com>


Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
