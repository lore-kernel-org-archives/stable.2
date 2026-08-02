Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99230649C
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 09:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785664298; cv=pass; b=l8YQ1OzqqlVIlPt5bDxUzdR2gX5LAg4j1XzURJyqa6p7MFubQAjR1qSZng3/gxdyWa0JYWFQSs1ErDqp4BDrBZo8SvBUuzULT5B66KsC7OpwzEKFFxuimHwtsJWpkqyOXtqOO+8Jjgmxyo1LSMmAPF480hTPVBb7Io4cZd+8kOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785664298; c=relaxed/simple;
	bh=OnBlFg9ufxfV2JABgX9cENM8/Nk7zlR3/f+76HcDBLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XstGklxvo+dgR+tPstKBhLtwkIvOCrYhmxMRlIOT9s+xEHCDlOTLUSOMn4gUgkmMHxdoxdcHJ/XGQ2xBAgq3dEYBvqxZ4hapVaZAQkkTO5OvAesLpcpUmiT9s1jjFOZls6UAMwaxo58bK0G2iBQEFuDEk/9WyAKUNIi5a8EVni8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=GKHb/MjX; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="GKHb/MjX"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c1600d040e4so368779666b.1
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 02:51:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785664295; cv=none;
        d=google.com; s=arc-20260327;
        b=oFuw2zo1I5ytvouNrY1FoSEy0ZnOJWIAGaSaW3AYEN1bfuIDUcNRP3/yoRRzKSIXqZ
         BKchfybWaLNtlTnf6rEYBSP1EqGMP0/PlSRsaecs28fuVYNQGYqkPduzJjur4VgCqTaX
         0XITurfq9uW7YeFGG24jKwGv9PeSRxRZJrBy/BsrLKENTQvntsk3s8WKDloWgKP6M/qU
         qD54HVd4+qtddoXE4BSVM3tFMS3K/zNUgFJGIzmhE6piS3kXfx+7Yr6D2Uxlc2o20crd
         EpfaOYKveTVEz4mtXgT8H8DmrcFNp9XUawub6B1TroVjTi8fU3u8BDBcRDhb7Rn8hcvs
         wtOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RcY18fUTe+GvrWML3QSCdOQefdsNdfa3eTybs7JUMoM=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=KxRThEbCGJGcMlwKg5R9t97oPMRRfwpjb+CwhN3hnlNsn/OJjVV4GQFUMCnvzkYKxB
         v5GwWGHjD7GEu3STbFR+D9doEJHboU7SPAoywpQuXdODFloF0tpdyARCeZu2aKFwqTVi
         Pe94LouuHAbhF9UBbMsyAGmf2DTv75lbTJNrPtrB2hRycHqLCg1PpPkUq/FtlPV1lU36
         esWo6raiGs3K5Mm20BCkFbyZYLJOA+IyWJRpwNb7Jz245HUtr1lxsnhwSpcq2ayQEhAK
         k6S/Xj0o6zGLhmTecW52KZ+FZnGjN5oiMuUXSSHrkIr10pAdtX0TWmLrOU9nCBcCSrl8
         rkRQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1785664295; x=1786269095; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RcY18fUTe+GvrWML3QSCdOQefdsNdfa3eTybs7JUMoM=;
        b=GKHb/MjX2BBnqJ7XuCj9KyTJymSOohab/wSyfmK0gh8eVudZ8ZCS4SPJN2V8ULqaAf
         ev1Gks6gKOA4ytTXU5mZSZp1Ug449xP+5ZBA5LAaajuLj8K7wTgt9l76dJzNxzgS2PQi
         KdYevjCoWtKzfeQek+JRd5EVDpdbCM+5WyyLbDAYiFuJDo1M9Oe9feYK6APlS3XXIH18
         1iYQ9FunhN8knqxZDhBbMmD0I6o+zpJq5V7ayoMp8XVVHJN/L0qRIJRqWB4ndmXA52KQ
         zGGjGTSs7rT0H7Dbae/f9yoMBSjKK5wbrcGYhpq6cL/M13kbNrJAA4GnoG27el0WQjdg
         GR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785664295; x=1786269095;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RcY18fUTe+GvrWML3QSCdOQefdsNdfa3eTybs7JUMoM=;
        b=QakzL/JToSinXrnKN20Bqh1b1KbNHFMxmc+ZzkMVT738HRorP1RyOhrUl3sJ6qEkoO
         h3BZ2Gr34wULxYkHTYV+anU5uA9XPjG9d/xlpYXnbbbjmNiQ+EoBG96TexB0ub+FxQvk
         JhFquRQT9lp4VOqUZy4QG8vdpawQBWYObkjD3kxbd3ygUFgtSP5yZczSj5N1rgAV7zEY
         ljeHzPfN4gq3Dnpw97Sk4r8BNR70rYm/ngIrIbKn8Iyq11BuBUuO4h/lI3l4klzwnj4D
         30qUSA/2aLAxyqsM16gRe62iJrZMg31QB720WaKoHf8lhC3I/CLPFMyI/cIt2FLHztyR
         IzJA==
X-Gm-Message-State: AOJu0YwplUEQhYwvwUm4CFjd+pjrrtft6+WDWJY+qc8rUtu89jKi4CWC
	M1h/VwI0DNc+TGooIFG+rP/JwL7VsmChmeSAM1VNS045kbH8PZaEjgjMxQVsVCgmkEB66Q3zHtD
	8j0WmZvRJrNoOJjqqVluZ2yQJcYFdztdoutoPcIsl5g==
X-Gm-Gg: AR+sD107hCqaetW560HSBm2fsm0qMbKidNNH+o81tdxbPr2i4ful6/qcfRcAxuWcxdM
	cQ9AY0PogVgAxzJxV/U5oyjDKyoxk5WvJ9a3Y3aRMY/GJayLTgGsk76fPxC+swsRjp1M3djPhBJ
	+Meh+LaYV9eUITDRo/fJCSuIEqLTGy5ah2gp6+czztpz9UkCFgKP1G6VYNP9xmeM57P4s4viEOt
	nNwfOWEX4hM32L7tKTVCnimmt0GCO4gQMfG+HJDj5QSzShY1tTH7DhPM/ep/0y040Uzq8CxDSLH
	R34Zj8eGhnaGZQt7FXS8rQBJJoPvszupDr6hX/DWqSLh0mTJO296up65hKSg5nB/U63vqDk3U8A
	FQKfp6QGmkdRg+lX7RnYWQycOVxSL9PGe5gf6tJOlg1+PCYHhR2bisLeXYV82vCVtBXAfZUAa4S
	HJqgiXAyzUeGbVKg==
X-Received: by 2002:a17:907:a0d1:b0:c12:8a:7d7b with SMTP id
 a640c23a62f3a-c1fd316d285mr518464466b.1.1785664295560; Sun, 02 Aug 2026
 02:51:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730141444.267951807@linuxfoundation.org>
In-Reply-To: <20260730141444.267951807@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 2 Aug 2026 15:20:56 +0530
X-Gm-Features: AUfX_myz9-eUDDINqT5CeYLvoi6DlvCjBCaBzgzbdugbcSsyHgfc2JTSiDnOjXQ
Message-ID: <CAG=yYwmMa0RAFUPkTDC1zOMNCMS0oiJ7n6B1Q0Xx1X-0VYWhQg@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/744] 7.1.6-rc1 review
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

 Compiled and booted  7.1.6-rc1 (using qemu-system-amd64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
