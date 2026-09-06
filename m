Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33998271A94
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706031; cv=pass; b=WS8/jaU0/MyESX0EcZyf0zczrkw1NREwLKPX/N4d11GGgkGbFWvG6Bi+jpUKK+6kfM2QvjfBGA4QZsDz1Zr+gUQDwi5+SUX7p+jQpNN9zMIGByxfYUAXlbHWZXqy+0hlzmIf/5L67m3F2yHLwi9aXdD3xa0qAqjfpJti4DaSAKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706031; c=relaxed/simple;
	bh=DBqqHAGSczpthp7loMH7wLmtYZ/JVKvH0RGvHHoN8+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayOTSTyLbdFZdu9ba6xs65CTFmhNUEkC0sdbwGp6uCxpx9c9fvCHut0Mj4270Eyy1UQpsEvs69lcCm5TgJgujSrvUGNpBuI0qzE9Ux1aNPNmBM00FaQ+uYdmZWsNGfXxXc2pmvDzsnWZFQXBuN9zGKQE01/9ccI/tOJ5ihG9wQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=iIYTmwId; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="iIYTmwId"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c207cb16cf5so398006866b.1
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 07:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788706028; cv=none;
        d=google.com; s=arc-20260327;
        b=eh1J44VkLRiOi8AEmh0zH9PXZ6DK/rBuf7LWr3p/nBisldmGEQjl1o6YltaC9mDOrc
         6gADL4a3pKOEwIINLPO3XKyrAraLosIzuClaFip1xE2pCDP85GmRxXxDUzQX9Pk8l6zd
         qhMq+9jpHrvrEfkJvBVO6VP4nnC74O0JzJUtTV9m/KGstdL+VmhVfZJK71E3jI1tSa00
         h0VByTfOnwi9XCZtHdqaVW/isA9vA9z1Lk0O0pWpEUr3poVtT+EkHzDa9CdLDoH2vCCu
         F/ZKEpOg5eTNeIG9abBg21CrAiKkeN/QomhnmL0H2oVAO7PENYrv+boTOU8OpIUHAEWC
         La/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fMw2a7h4FJa1ynMxKC2OZdTyNmHlbWlyFXY/M2wRjrI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=i4/0e02ZiTMOX1D2l2sqpnvBSQ1jow42iGHX7G7I01nFc809DoM3mMwuXrD9kkiDzv
         FAEwIxZYztVjvMCwMzUuLhvynCoCG9stvZuBDHwtDOcO4H1gvRNWcciGyZPU+rd8hHRO
         aOYuXvpL2vgW9TavOBGOh/GRRMcBn79gCrvXpgnJA3ta/v6CpgWih3A/qKvGTPPs47Tz
         g2ObG6enKZb48E0+WxxPHvz770cWubXYIIGFgjIwnPYBWlv0s89Ad1xwXXYYSwxaQT49
         7WPJSBVBAJYZaTC5IcS/5FGpbimjHed0IbA0MMQ/1S+YQrOF4pNfhV0alRtNc0oqa1ih
         Rhiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1788706028; x=1789310828; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMw2a7h4FJa1ynMxKC2OZdTyNmHlbWlyFXY/M2wRjrI=;
        b=iIYTmwIde1cba2Q//LXtNwLXZxx8YaZm68U3uba1OZGxN2H049jvAvTsUgHqU0sTbt
         oip36PBpzYwaIUTCHZmszroi1Iz1mgmixG55qM7ohXt51prO69INMyTb2nQNXhYD1K52
         SF3n5sy/UElYPhs7w1etiluG2Av1geQWrkniqNSQvqAMPAQabm3M13RYnuLx1NkKbnG8
         QWi8GNmGQANCFVcVmYzTpWaHA6OTCP7UI0fTr3PN8mNfDu0caZ455Dn1jAHIbY9jx57m
         Bb36zpXCBq8kzXlhaYxFfyRZj1Tv0fnYz+BIq+/XsKMsZocAeQvtfU06cZ8ortLrXeHM
         LLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788706028; x=1789310828;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fMw2a7h4FJa1ynMxKC2OZdTyNmHlbWlyFXY/M2wRjrI=;
        b=PqeScGif5UX74VtZ2oS8ANyxAw4uTDwFXbRtP6v9oUSmyE2DDQuRjoqXuojrTbspBk
         J27uGcl/RiJJS+ynBEfQj1eTLbmEjKvPc74hMObiqcFW7JUYgsOgTFAeBc0NI1TBgHQ/
         X+r+wueReFqc5HDjssai8CuamALCYe/EOhnT9e3PLoBA0PZnTvwHhFPKQvOnBDsmkmPx
         orZON+GU3KEOsUIrd5Mz6sngXJ1nVwfkNEY1eYXSn16uTBOfxCVH4cQ7KEz0NIwrZDGa
         wdJhSI6hrjTn65ML8wQTX+fXmSaPVLWG7p9p0mZ+Lv0O4BvrO7Gm2zTes5NZ8S7KA3cR
         NPOQ==
X-Gm-Message-State: AFuF++n4XkJj0Nf2o1y/yRDas7Qi7twbewpocIiPYXMIIrTkGHQlcGNP
	rJheYt2YcK+ZXhxDqX33s1xHsEv25/Ew7ts3miZYXziTbbtom3/4tAad80LE/pINZYfvD2zlcS9
	7fQH2pyEalWwarzFOqgPBg5fbPmqQX0NJePjglbYIZA==
X-Gm-Gg: AYBFou06h2Ck39shIwIo7dYavfzXwL5ddt8vSZdHPVvO26ihzzJN/qVjZ0wOfMt/MZ7
	ZSZH40z4JDbCTLVxV6jkP2kciUKBCLGLtWllMrg7Md9WiCY5AtJWo2NNSkQP/pfIvATM9V0YXvt
	9HnHApWJRdgfUFglpbCqU2UOzgTpsSkScWx3S02S1fKuuwnKnH3SvrYPbggfk2pw0++iXxU1An6
	sdXVSPqgNrNd1aBbkKJpsCXdpVXVQkHYy8HXAZC2AL6wIBjvOdK+brnCiEj9Hd5pKzQ8vUVZmIs
	wSTVTHLUvrLdvWyVBE6XUBYrENfKqleYuAlZDV6lIw9bWFKT9qXsAiDDQVMXssFIkMvdAw51+n/
	AcZ4PC30IXhwZsNLwRycYma05vVT/i28IAWqz5lvWXgp6Pb9SMx1j2f9CGvPR0ccSLlLtpcLIXg
	YSaXxbYrqbBnKB
X-Received: by 2002:a17:907:94c7:b0:c21:4393:c41a with SMTP id
 a640c23a62f3a-c260c9b556dmr671749166b.11.1788706028458; Sun, 06 Sep 2026
 07:47:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904045803.810145556@linuxfoundation.org>
In-Reply-To: <20260904045803.810145556@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 6 Sep 2026 20:16:29 +0530
X-Gm-Features: AcwNN1V3DdZWjKZZI59W-lXeZk-QDF9YMp4RrSPhW5D9Euh9iW7L-2IdybpMmLo
Message-ID: <CAG=yYw=4c2nQXppcKfCv01om-zohPbZoafSfhFSCgOu4cxZuVA@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/713] 7.2.4-rc1 review
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

 Compiled and booted  7.2.4-rc1 (using qemu-system-x86_64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
