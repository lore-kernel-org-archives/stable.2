Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795183450;
	b=D6Ut1jdljT9OUz2E18V53Vfft22QeTuNlkvNElVpLN/QLjkzgakLH/9qAxE4x3edwMSF
	 sAv4zeuyVRCw3dqH3DKTKmDK8tdw9iukDl4p3QFOtI3wSwR0GHYfIO52kYW++6oWFTWLq
	 KLKic7LvIaB0o07+3isr3sJfyCU/J2QM2T1KxXymSbnFEhxztoLh1iRy8NzhYtPCmDkcK
	 MDjnqU40cdGF1ptGwmxI067mJSWgvocz3O5UIyt32/H+mTx4MWph+802qiANF8+q6u+6A
	 N0FIyXqu5KsjyIGLmJJbNBenO3ZaYT9MtTDXE2G75VNb/c02/ktsRrVL720fsRozdMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ebuT+f5EamFeEjXTBFPk8/I7Ne4UNxLTYT0YdYlrjqo=;
	b=u0FkLGGIGL+fuZHqqjK1Cnk/l0yvR9ZXy0/3IEjPtNvhsDxlygeSLe/yfkfYzexgdlZS
	 xUOAvMNUTCX+W28XtIxe5GA5RYlDyJoF0mngrC9cgkdrP+bVMO6n2nwtpL3EM3cD/Isii
	 l0a7IMrA/x8MXyBE18HtnFGZpStagG5zJQA08vcIY+OB8Y8jCVIJYu6xj6/zT4zrRiysq
	 yRlgZ8rb84pzDQVDtYHWZREkS+uTBkw8SB1+7Bzj76bzxrHJHz+9mRrhTa/UIxXLzqLc8
	 mPfaYG0I12VphcrXjsDNY/xZ9y1VOPX/P1eukoNvUmGoZfYFPb0K1vCpOh0hRcW//uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoYphyFW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C61606A326
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 14:04:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VoYphyFW
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c1ad0d0b72so71820e87.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 06:04:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795183448; cv=none;
        d=google.com; s=arc-20260327;
        b=r49z/ljfvO8XfcjsNvxAXqfNQArT7J5x0iNm+gxT4tZ4Rpyw+RfL4fv3lmUThKgiM3
         MzhC28xO1UUzzHHNiVDJyAQ86iaMWG4A0C+hd9K/ihAncnxKYZbthpeMKtckzObV/xPT
         WBvWq4Ma2pS8KMwELGe1CLK0KYp0bUFVpb++jCbPh8pnKgQxRqZ7IUPN30cDOViiV5GV
         UpoCJqpdcr89GtJM/efiDkIBPgiZoR5L00NKxsUmcPfqV7WpY+CjqiVxaSyaMPI93EOz
         DM0YnrfoMMFdGsFQOTnwwEJZ96PNSKC2PmxPAashGAzQydxde7UJmJzs0Lofd0VgSB75
         LzNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ebuT+f5EamFeEjXTBFPk8/I7Ne4UNxLTYT0YdYlrjqo=;
        fh=g6l0dnLknDer1a8jxS97hLhVs681EqJBS9+1NsAZ6I8=;
        b=hXg8p8XpiFwXTuHxYqmceI9sIbBlo+5nwYVh/O4RwBZaKOJygki4CwFiqYxVdqEYUY
         Q4sM6Eb7nTrlrK7n77ff0VhyT+V9ygQFeimWOrJzyuhT5pEXQXHrdSWaRJHJfkAnNUph
         G/LW1EPPl6myp05JE2q96MHQ5MZ746ZmZVO/VvkmrEr3F9ukPrLzqNMv9xliOwc6cQ1z
         ayxg9f91y+Cno4/0/Ft2Gf5WMPkv/xMuI1lzntPO6m6RC/4+Y3y8Ws5hzmYOKLTP2VBV
         lSot+PzoWRupU4YP1CEJDUXSC5zIEShX+yhEpfHwGDQgcQvaiXVd7oWcbfOkJNC4HGyg
         rX0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795183448; x=1795788248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ebuT+f5EamFeEjXTBFPk8/I7Ne4UNxLTYT0YdYlrjqo=;
        b=VoYphyFWXM4AGbcXNiAOU/5SGkTu5veOcuFcWpY6IanI2yTDIh8K6CJVivxrIIwUBx
         vGlltNI+xJERP4f0Y5AvoviqlV0xnMQ5ASom/1zvTqmkZ8b6KufD6ZiorgnytX9LzwGe
         6Bg298xFKOhKs3kCvGeC7eOJR79keAbdT3ghEGTB9Y5NJg5oIzWQtuJvblqRh+0RimdA
         bcZz4Y5YImAUdrB1W5EYt1z70Li3MdaPSlh2mB8WD29ituHKo2UHBNG6iHY3srA3uRRy
         aPqnggBm7RqdDS+ne2vQK0bRqwAjIvbFRhNEiIFuCtaczlg3XsxpkTP5EXNaImbA7oZk
         qSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795183448; x=1795788248;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ebuT+f5EamFeEjXTBFPk8/I7Ne4UNxLTYT0YdYlrjqo=;
        b=aIkTdWDktNKIl5MTE2tMmsVWg4vDp8rCeYQ2D4Jplu/MdFoojg8HIRiC1XSf1rSGIZ
         zgPGj6L1XwRhrbH0a8iB52It8l19MnXtyEVRqHxAe6r1IjQPUZGjCNw24s0UiNhMTOGu
         Alay8h7ULBqpjJy5eynLBmB2+hdLaV2umQjgsBYQz4gVPoEMd6N1JT3kDHIT4XxIaJrI
         qR2qMdsGsvOCaz8ClSgIE9Q6xABfInjmsDKpnKE9GGoy29Ttnta/i9KoXBTunxUZ30Jj
         VqULUi9jz8G3lFKZIZPVIbKTSvpka9XlN6a20FKY5MGSJgX5HS/GMcMp3l80qAE7VEVG
         HPHw==
X-Forwarded-Encrypted: i=1; AL+hErEJ2r6xkUVrlb2ux86tJfPIAVBRZJyA1bCMUAu3/qX58IS29DlYIvKNDMcAeDgLRVa/tJS8/Xs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xD4IDM5CG3fmHrI3Tjw/z9K+mP7d3rnXBuUtF66CEF6tkjCjU
	y/u2H1imjblal6iHJC056KBvam7RJYw6YbnCFGZeEVhTRCdKRgy3clmV99kdzn8NIWjHxz04Ya+
	EENsIEVUcpuz6+KOZFJcEYQH51eTpwr0=
X-Gm-Gg: AZFdTZfTJqm+VZRIK3WrRTYpOFx11CS4TI7Pi3Nt5pEJa9OSuxVR8VoEaOT3bAXs1/h
	aIKq+vsFcv++WKnsOfablybOTRYaErEchfn5aRISlz+E54IhlIeqiLF8DrOb7vLvw+bsAF0njn3
	PSIsOr81lArOPoDWe1z5SaOPAOOQFbQ96ixFKi17lj5qA+bKxtR3RnDUVulkIgqVrdWyqxDp7/g
	tc6rQq2z9cuww2HFaW2bdG9ix+XA80wZ0T1qvLUWm5ndiAjZ57bKVcHy3xxb7OkYjW4CO5ZQR2m
	380a0pNtKhe+eh4BLK6tfh/b0a2RMvitSwjxOrFspIGA939j7tYUDD6WmsMfo1TCh1x7BLglwyY
	I3X8Tj1YBK5jiqLS3OhJgSAzDyoB2k8ssV1KzPAOOGkiDlp33A/IM1TWew1osvAg3q51kCDE2My
	CrhwfA5MeDaDidpXqtqGXrwrrDWEj4zdggJDJ/fTqH0hkaHJaI/l2CVAuMdg6w1iI1Hu1twNUP4
	bvRzJ0LcSxxJ59p9+Sj2ZW0SZs6fNfFttBfEHcwMza1iKf7GB/zTVSoULQZf9emUQt/A6/ZGhI=
X-Received: by 2002:a05:6512:304a:b0:5c1:57b9:90d3 with SMTP id
 2adb3069b0e04-5c1bc6d29ffmr1168124e87.1.1795183447989; Fri, 20 Nov 2026
 06:04:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261120055200.707545519@linuxfoundation.org> <20261120135123.16092-1-ojeda@kernel.org>
In-Reply-To: <20261120135123.16092-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 15:03:56 +0100
X-Gm-Features: Aa3M54oqTlpP7aqhlAYeu20Jbztbh7rwwB7_36t7sUXGwDuDu1WrpuuSK4L4S9A
Message-ID: <CANiq72m0P8SjfLHKFh+NqOtxanEx1Q61NO=dRsuUwEKyTueOSQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 0000/2812] 6.1.193-rc2 review
To: Miguel Ojeda <ojeda@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 2:51=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Boot-tested under QEMU for Rust x86_64:
>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>

I forgot to mention that Pavel's issue about `__pud_trans_huge_lock`
in -rc1 is resolved now, i.e. I am not hitting it anymore.

Cheers,
Miguel
