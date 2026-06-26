Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A53E2AB7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489572; cv=pass; b=PmUpJmIpaJGyvzxgvNCXi3xBZxbbR32YAKVN9MTJZstpQAS6GHb33mO17ymXb/VLvb/MhWktpMTtEs/kVO4W522F2Lwbvbfx5I3iBubTt4uQfH6psi6MeFYKosOfzRdcJYK1eINHGw1V0iI6TNhuQ2zIScaoK+q06GgICzUAUm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489572; c=relaxed/simple;
	bh=sa77kVbAwLb6akjpKfyR0FVo5MP9BFTqAcnkd0xKDjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PL9JhpI78A68qhOMG5HyMVRPh1NOjNdt+7J4Qt+rnj1S2FuKv1rPHdD4pzoey4HaxdCqFuZCbrx4rq/xXlp4vnAIKA3dof4IdoAqe7i7SnA+v58Scjy6jljRRORSwIBco/QRihRECOOcqoEXjRTGDrj4HB6bKUfa1YeidxglUMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=sGlsvYoq; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="sGlsvYoq"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so2034969a12.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:59:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782489570; cv=none;
        d=google.com; s=arc-20260327;
        b=lleTuA9AZrDipYTnHLDaYaAwxo5DCGb0jxV5GuE52W2UYteAWK2+oLCAoiVhnDQL4G
         R7ZI46p8NhmBPNW3vj2SW6iaDUC5Zbfybszezct3WeEfY3m9U6JKiT/kFU7PN20ocb5w
         FVFL7FeoYx2jzKekrjn59+1nn4xRruWU8Wa20S1vvMTxC8h0VH348U1XgjUZ/Muok9CR
         K6XqStztL4z/pRJlou3G38ngzyLX7h53tgqkXYOYojV/5j3bQMz0IPHO1+PtU5fM98h+
         m4x0g4vGnW5/hQ25pc6qAuWbmfG2GIXqT2VHvcSEk99I7dNZuT1KBnD0EAfHfjfXUIRp
         NpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bSdNcjBKXhemYGAFxDX0HcEA04mDXXcRsTRsV6T4JXY=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=TvBMyUUPDhX3Il7DnSDPDNPf/x/Vu/zWZhpTSI1CxNVkhiqqO63zVy2aOoK470Gy99
         REkLuyPO6VyGqlHO+UjlrJbpmsQSw7Inpde0TazoShr8E1tXSmFLngplqZ4WP/Y39VFD
         ZFQT1fKJjCzF7wo/kgtkc1XIQefWIrrPixNJlr2b9fZJ33aZoHiVlOVq1SuwV4M1L52z
         YEe/csUNc0NAwtbu11H/lQYSGWOnvDr4kOo+tgjpn1oUCiy+GFlAnUKIyysmBiutszV6
         y5qit5Lr8cxZLJsLAoAJ2RTXdRgLxt8QrGjE/nNVxkoUADkvyJ3aPQtHMYfJc5QrFg6f
         bPSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1782489570; x=1783094370; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bSdNcjBKXhemYGAFxDX0HcEA04mDXXcRsTRsV6T4JXY=;
        b=sGlsvYoqUouUKkZpLqc8T2x8unpWJ3aA2q4r3asF21ConTTRxIJ0wPls2VmM8R45Mq
         ugV1tlXUFDnki6RINkXgSySKq6ok4jaZaSouO4vwbt3rcDqpms6mNANuQz+sdcT2sQ9z
         jQjGaoME87HIXADtp8qna0uMhAi18/q3IVsMzGGzo/bLU8Vhf6pBuLIXquRD0UqNMgKW
         nh9853imMOUJLPVl9vn76sKFQnkDPC/lKXrrFmy61+LmL/JBqY4AbU4qOdwFKmgms8dz
         iwP8+pWrv+mCXijgVpyYm51z46lUJF93/bWr2YH4hCmyCxZXZq/wClc9gKnntnczCxkd
         Nljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489570; x=1783094370;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSdNcjBKXhemYGAFxDX0HcEA04mDXXcRsTRsV6T4JXY=;
        b=SwusfQ8zzSI5WLMTwlqTjF7rBStALLec/pfMc39S7Cp4/JEQvBYviGIPJ3zPCleJfv
         HiIeyESgqtd4ppU8IyUg/OdMmlVcq1CeMp69kSMbOfb/8xgzGHPWvbz0sM6JECGNV7E3
         M/SNGwKYUhEjprULWcunSE01G04KbMxaMIEuM/Ij1+emes7iisEqA22DCDvcxoEwmZCF
         m7A4Fm4LE6q9yTv0rQ5Cx3MtmtW31gYcaKuw1fsQL8cmKPAsKSiZfI00mgLi4SmT4uHE
         /2x4qCroDBZ5GBjfUA8MwMCUyofIjAlygfccW1g1U8Gt2EVqbkEA3RTVN5vgvuduFyNQ
         WkOQ==
X-Gm-Message-State: AOJu0YwUVxdjgigFxO8xH9DzsQ93p1cn6HMydVfYFC39MunOyGjY87Ke
	Sb/uLmXl1PFC1VCzWvpJ13WQms3pwBG+uxeEbBZWEzU6PwR/dGEjD7gkKs/kH06J6imL7jR2hoe
	3sibZC3ggXxVbNJlRhsqWpkzvrT0f4PLkKn58cmjYSA==
X-Gm-Gg: AfdE7cl2Z452FLXbDgn0JU4NZBQoO7ftxOsHrsx7I0OyPaOEsAWNRrEizSwbNZwwcPS
	p8AzfFGYrInXn+NDJrblqSFFTenJCgWxgUpjja0SZ8CD4zUgaQB0N9UNyKjX0o1NON4ZNgi0yT5
	cjpEj5jAv4l+U/WCnF0l1gSS9Y1VpUUNhE78dfCQx2soIiBfJkvwXTq7OVmpSVqvBuhPCBgwDOB
	b1f2UyO7dPdK6EWP9nvosmevdgAveRLXIDUbBcPmheVuerp6nnxEiAtYx6klbyYdmUkzRfzlsfL
	7lJzuL/AFC2aHy60PSThvrotcNHgMf8frtsfl8g+HX791vYmsADGBXcuqJNc3ZW6JmWDcBPgRea
	PSQ3hDhmk0oVNliBXKYu89ujDK5Hdj60cwp5hdlp3
X-Received: by 2002:a17:907:c49a:b0:c11:f528:869f with SMTP id
 a640c23a62f3a-c1205dc1c57mr485522066b.19.1782489569622; Fri, 26 Jun 2026
 08:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625125613.243729608@linuxfoundation.org>
In-Reply-To: <20260625125613.243729608@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Fri, 26 Jun 2026 21:28:53 +0530
X-Gm-Features: AVVi8CcVlvFIWZ3IZYi9detLPFCd_waRaCiCuFqo098eJ3zgk-_5YmbutM7qhfU
Message-ID: <CAG=yYwmzH+qbJPpZpk6UEWGzS-S-4VJ=az46wPJuJUuZrGyU-A@mail.gmail.com>
Subject: Re: [PATCH 7.1 00/21] 7.1.2-rc1 review
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

 Compiled and booted  7.1.2-rc1+
----------------x---------------------x-------------------
$sudo dmesg -l err
[   23.704215] ACPI Error: No handler for Region [VRTC]
(0000000042f760aa) [SystemCMOS] (20251212/evregion-131)
[   23.704246] ACPI Error: Region SystemCMOS (ID=5) has no handler
(20251212/exfldio-261)
[   23.704275] ACPI Error: Aborting method \TAAD.RTWT due to previous
error (AE_NOT_EXIST) (20251212/psparse-529)
[   23.704359] ACPI Error: Aborting method \TAAD._GRT due to previous
error (AE_NOT_EXIST) (20251212/psparse-529)
[   28.080686] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Index
(0x000000032) is beyond end of object (length 0x32)
(20251212/exoparg2-393)
[   28.080708] ACPI Error: Aborting method \_SB.WMID.WQBZ due to
previous error (AE_AML_BUFFER_LIMIT) (20251212/psparse-529)
[   28.080732] ACPI Error: Aborting method \_SB.WMID.WQBE due to
previous error (AE_AML_BUFFER_LIMIT) (20251212/psparse-529)
[   28.081634] ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field
[D008] at bit offset/length 128/8 exceeds size of target Buffer (128
bits) (20251212/dsopcode-198)
[   28.081647] ACPI Error: Aborting method \HWMC due to previous error
(AE_AML_BUFFER_LIMIT) (20251212/psparse-529)
[   28.081662] ACPI Error: Aborting method \_SB.WMID.WMAA due to
previous error (AE_AML_BUFFER_LIMIT) (20251212/psparse-529)
$
-----------------x---------------------x------------------

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
