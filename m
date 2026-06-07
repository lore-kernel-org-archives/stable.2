Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFC33AA4E8
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780840807; cv=pass; b=C03WrnItJgHsDXZw316YKWnnqx0Lw5PMaAjIWFyw0vxfsVijwcLjNDZa2ryg1UvMaSjGL5v2sO7yqyTaO/qjElfxEn+Cm0VSKR5uQwNMj3tLIO+Cxa0jvGyPlTYfonF1XCGSqqwwaIgPBmkiwhYYanOrfphzk4JAamGAg5Xl7NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780840807; c=relaxed/simple;
	bh=FFaZCZCI1aLwrKSfB/eohEPXsMJlsUISmfq99wdbCHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQ1S0wzmJ1OFBZ1/hTN07Eoj/h0Fn21R021zXa2mpKY+sElcL0KxG54rcXxSM2Zgy2L8B1qddHcYEs3uLWC6fbGdZkUXmCRgg3FYitJwE0YtwadshciAQ8GVh6FwZ6F6dE2mrRbbSKlxI3oybz9gjTUaf5u/xu1PxkYueCCk5SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=rDguZXgR; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="rDguZXgR"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-13809223fd4so2412694c88.1
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 07:00:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780840805; cv=none;
        d=google.com; s=arc-20240605;
        b=JDm1/BU6kLnaXcRQHJQJ16+4+hM6m6R7wV9przDihGWYfXjg0etaAmn8KeucqwClOh
         fjoYMjYPfLIUN8j9w3PCfW4QNbgEFNVut4ioBYu21gfixCTtQ7kZyHVkmkGot4WMHa+F
         0yCdFkarUR3roKx8K4XN2UiWaH6AEMNbMTdXzpDiA2j665dXgSX0iY513WMO2Pe3Af07
         YzI92IrMM/rbih0gVjA3UpcHiVtCq/VBqemNBEeTvKeODITvqQSnSSz9XEJB6QTlBQn2
         j9EsNhkXUX/DnNxd108wlZR7IQ4Z2Km/jCvJ3BiuPNtitP2iurtQEQhOPEYJcHDZtwqj
         y3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RkQeYfFIuOUrnCngJydWaqMe29Hx6hUsX++EJF0iQCc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=iCBWrPePbsIXRetInbliGPlUhEruHvDUZelijUGiMp8nWsCfzue9tdUIAlzeXfrNou
         kYh9sDugxuPXmvTqsRbWszraRoaPMyDFjdAGLUoOPYC1witmBC/HpeKvJP9vM7oH2am9
         ijcnm7GkBSBn8+pxXn7oYPXkF1aDSZhHpf1JH300dVFRTFs0rZoj+wXcM6joivWILJDD
         l2ODIzfmIyYTVj5ayK9MgmqO37/EU8OhBmkggcB4/bq+O9xfXl646/dwPc5cKnzGtZS5
         FUcm0SI2S0nB9cSQS2VBHlKUbKEIikLTkOIbR13irbC7rXJMD9YpQTicOBsbvqyPso6+
         8/cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1780840805; x=1781445605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkQeYfFIuOUrnCngJydWaqMe29Hx6hUsX++EJF0iQCc=;
        b=rDguZXgR++dhbAivfYAvNVVb5R2cvZvkuIN/mwfsCt3P+aSjIhGuOYoNzvfV+orwU0
         cFAz0i5JU7EcSoAulCCmL4mjahAnK/eL3cw+p7gURzL6KPjga3lVAcY7NY4Yt/4pYIvy
         RtirZaR8WVFDutu1R2cQXlgOEnA3LMt8pt892AX/V5M9Hl2k91SsMgbHaQp6t22ESX6D
         ubTnHoSbgAABvDbK4b8Oi8EVuqZtyQTpEWfCHPjdgU8V0RVjHaAJIynlF4NDu7Fk+D9r
         chK85lAXkNO3Q4QkwdkJLdHmLz54CKZP6DgalnCFIhY8syoDbxl0RhYkI8qmUsS9YKfO
         Kg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780840805; x=1781445605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RkQeYfFIuOUrnCngJydWaqMe29Hx6hUsX++EJF0iQCc=;
        b=oIuA1JuJ78S2fIMQn8cjHhLxLZdaGlN8slQHgGBWwq1tWTiWqoG4+bdN2L4+fDdFuY
         zeuTP/8ANKz0sG/L+s0HItnMc/U7hatJcMXz9DlnHiretWTlvM0fUKOBFNP7HbX8K99N
         LlLKmNWX1Dqlyao27gmXc4S4+S/j7hdEQV86qHCv/8WWSQj5JZUjzmfyA4d0tlmoYsGS
         l5qvl1YgPRd7pKr3cB00LCiqcJmaB1RN/UDx5Sch7VJ4/6+OA6hGqo9MziRAxMPaUXNL
         /IKAvFsB6WJW8wyfT+t/vCdGrckb0dplc+AK1spfko+OA3exaf29FZ6x5o7H13TtGdNd
         yAtQ==
X-Gm-Message-State: AOJu0YzbQOcuy3Yv3H7/LmeJCoOS+LQ6liu3oNK8vQMI0z0+vbP/OnDX
	Fkfu3gY0EpXldWhh5fvqeRTInoRDOOLWg1w8C6duazFqtjnGhCEbFjE2kUz3zNX5oSQOZQ5gRz9
	8U1ZR46U759sAcl9oZONUlhaskz1M1TW3zQmDx5IaDg==
X-Gm-Gg: Acq92OHyFplC4pV+0NGvhNBk4+Du5wmbIUoGxlIs4Aqt24XGw0ciOH/oXiQwxuHMbkx
	1H4Xa/Uyx+0LJ9rlGmPW3dtXQgUDVKZNPP/5At9ZLtTtQN4u/pNKfd1Q0MibD/IiIoQbTmnfYQ6
	28kwz2yGksT+EnPmN9MQfeJhcf9EtzrJmDUzM57lZR5jO8IFUrPPi5A27teo7LVW9YuVxUAn4dq
	9pMCvzPx3iMMUhFr8ZAIie/vgzmr8jH8wUGqHGzJlv2pQdgx8u5eAxDn6f3L/4tNCQ7vpA39fm8
	JSzl/QQqfIwcHN8wCkA=
X-Received: by 2002:a05:7022:1e11:b0:138:12fa:378d with SMTP id
 a92af1059eb24-13812fa38ddmr4360570c88.22.1780840805119; Sun, 07 Jun 2026
 07:00:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095728.031258202@linuxfoundation.org>
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 7 Jun 2026 22:59:47 +0900
X-Gm-Features: AVVi8Cd2KuRVPwE0_H31aM_kSW1Og_JUoZOaOfYaAHe7xAiu1CLPvdl7yB5cjr0
Message-ID: <CAKL4bV7=32jD92C9yJ2d40Z3dnWLC3zZt2b_74JExDsu0SJovQ@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/332] 7.0.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Sun, Jun 7, 2026 at 7:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.0.12 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Jun 2026 09:56:44 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.0.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.0.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.0.12-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.0.12-rc1rv-g877a01113f80
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.1.1 20260430, GNU ld (GNU
Binutils) 2.46.0) #1 SMP PREEMPT_DYNAMIC Sun Jun  7 21:38:28 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
