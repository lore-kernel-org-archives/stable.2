Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792924601;
	b=ygsoPxVkISGBOkJcAJKzL3KzPFyGSf2rfcJ2CJNhpFfDzShm+iERh3rwa/dVc/hjlGpx
	 7d+wpvzCpRzW746Ov8JoQXWaAoj663vJ+wywBclaUMqBGDdEoz1HCLPJt1KMVdA7YOjDb
	 M0NkFlYBiB+eVZg4IpEu+NjwKc6SxuO5uDQjcDTquR1QERFDrWxBtXhr9rYYWDU3+S6h5
	 IG3FJYpkXdOEQmLQs4NRrjk6ZzZ1dxG8x60LrHbTboi9qVGAK3FDxT6VroOxMQFNSgd2P
	 RmuEIpCY8dWRHZPp7FEmG0OxZ8I+aV3t5mr+HWNtHhIiTTz21tHwkaOWv6Y8w2IpVUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792924601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=24txbqcyguXG46xJluEhBf0wsoM68TC1uArTVqKrpRo=;
	b=0vQgG2AEXAVq2P/IL+NdzbG/W1oY7HnfEJpNMyl5vUBAc8zWrNu490Jn1uWU8EFphwpl
	 vxG17PoqVJCrmQrGivV8oMKVsEiq2UtTQc/v7OztfspUFM5choA6rOWu284OcYVcZvXul
	 XA5tuwncStIltB6JiQeVyXuDH1VZrpPl7z/ZBRywPGkqdWJsSZ2mLkm1HekoBXyv20YdW
	 M4uPUcgZQU19MOgah97+mdgNdo24qInCB9y8nvCj+HAS1jsyCHvu02zY7zGDbb0gHpyaF
	 hPJBm/JQsK8dRcdnz2o05DLWAo9Dvr7DXF2CPEK4ouE4/cmz1cPVgLthvT7jGV3KRIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=futuring-girl.com;
	spf=pass smtp.mailfrom=futuring-girl.com;
	dkim=pass header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=PBdOQ+cu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38E1606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 10:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B38E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=futuring-girl.com header.i=@futuring-girl.com header.a=rsa-sha256 header.s=google header.b=PBdOQ+cu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c46bd7a7345so143488766b.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792924599; cv=none;
        d=google.com; s=arc-20260327;
        b=pk3zG7B/T7oHx865jHH3NLnOd0Be22uR4xwoubfsAv6qevJon+a8u7lXAIhDwYy8Zq
         1HQW0x70DTu8VQeC9xBFhdcQxwBq/v+L6vDeMTWO5r1gGSpsU8M7mVM1wTpCYw8b9l+/
         hNEPQzQ+VZH9E/wUg+4ta3sTsq4aJWIDio29F2baz6gcOAbngFP1tmbDc+k+WU9177Qi
         zL7i6bHXJDAnwgVuynjOW+RWD0KLAPiyF78nGYAsddWWkAaZft9/MiGZ9d/2nsgaCcME
         L5Ak2RZNO09Fr7VMhd/pi7WoEhPMVu/PPkfrY2NnY0fwE1NRwe4U7JXi+Sk2LXZQfdeW
         ndFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=24txbqcyguXG46xJluEhBf0wsoM68TC1uArTVqKrpRo=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=pELZLA+FauNSAqoS+smn8Ij69unIYQC1I8UF64egM3CPBV48LPqUF5jRpE3GynC0ll
         MMSVquSyFcV3oTqEOnqzDfVg9SFpbkBbhfTw9B6kUsEEi+c7vj07sCuSA1SW/ifFZBwX
         4iMvkA1OnZwdHRt9s6aW+qLXqFGbhrH8CI4lZWZH5vsv+oQ+jMldnzvYJL9Krhhea1bC
         RSM00sL9zMZ+Oan4R4SkWv3wr8/q6CTYqM3TGZPm+x4d9OdypXP/GzRT5V6+ALX7NLHL
         Teo947+JgBIMHBd78OvDZ5GPTUHTHr+LT+/0Kwinmvt/w+6yfmaRSjkrcN9jNJEc0z+8
         lZDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1792924599; x=1793529399; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=24txbqcyguXG46xJluEhBf0wsoM68TC1uArTVqKrpRo=;
        b=PBdOQ+cuopQLFrQPiwFLE9BaP3lrPDoKCzZ0k7UZNxz7TapvWizxnrb1pQMf3MLpNB
         8vXXl87IA+j0lRceZejRrgpr+hw71oYY/jbNkCZE718SlqUFVcy7WuSRZM1X6UNCBFyy
         1VYTVJbxkcKtrn0IltcXLElcS2ZiVJaWQ2JH3b2fNQuG5Iuz08zNxkxDOIQ2nCcrab1v
         e+KbfHo2YGYRJr+UjV3SsaqMsoeuNaP+3d4hEenW7jD218gSPjmi1nBML5Xa7io+m/M9
         0Gnj+/5vYuKGGEsuLmJbmRFWEJZF2pc96BJORCAiLDhvQk8gUPDag/hjtmnmtXo3045I
         OQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792924599; x=1793529399;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=24txbqcyguXG46xJluEhBf0wsoM68TC1uArTVqKrpRo=;
        b=2RZVQcVyJbZT0usefkfHUdBgDCD/pIaqIgg/5flF9M1fFfXjIHczZptoSz9giqbfnn
         8ycfh0rNkr4V9axplE8B8dQwUQzDZvhj4N/7boV4gMSmt2WoFMLNmCQPXLn4c51lxwkc
         B2IL8YSGYUoKRxMRdWTtlkqvP4BtoU9GJhoHVJ4MV0ovyL6188UAt0hNJZNsBV3i6Gey
         q2mD8sHy4cEjXGjK5kp7/DOJ4W0mWLQQw5fOCi1vQV9T83ORvXnLBmXQNUoI/lQAv3rl
         B6/VRwFouCGcVNDnKKmUPod3fhmVu89YMfPINlO16WQ6xc4gewpzEHP4zo2PkW1q1mxn
         pGNA==
X-Gm-Message-State: AFq9FYLGu3zAgrBW+3ti4zWniPkXSCU2eB4BR2mYhpGe0QJAzwq2JQvu
	QQjEtZl+yVnuQhsWeXYQqWxsVSUy2h+JitV6VOq6enXiLFC6eRp0I/XnyNcadx6bA6aAq6f3oa7
	QsHipDKvvweKu5km84TdcpWhZftoyZgeKadc1tx/8vg==
X-Gm-Gg: AYBFou3y5sazj9033YMOQF0Nltxauh3Xi0SRZz8h95mZ2tOm04IdruKYENPlRR5lyki
	G0trUrx6JGupIOTF1z4nnLInHR7cy+qVVaFvDKwRRwChARbaxVcafNa1LeUG8fwPdIH8BdFlcyZ
	vvvIJES2TE1PB+KRd/+thekOCkKtEHgJTyxBeCfNiFa+Vyp4nCW+gE1gCBbUAkO69+o/fwSvZRz
	G91scPRWFE90pE5CkaglGauvkKh3VKnPOWNfr08l16vVcTQ29lNULcY/WDHGGVhcur4DlB6oFcT
	osLuOETxYUwZKVIG0fnB9WSC2xOiSPLituHgApjpVOgN+wa4VC3u0F5hT9EOvaAbieYAZQx2XoH
	a0Z8sFs8IhXTsbnFNXAKr8C3jhGLOra9J0IV7o2XsohZe86Y83sKWFtHpSJbJjvYbpYKRqg==
X-Received: by 2002:a17:907:96a4:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c46bdbf337bmr464489666b.11.1792924598905; Sun, 25 Oct 2026
 03:36:38 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024064731.125251200@linuxfoundation.org>
In-Reply-To: <20261024064731.125251200@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sun, 25 Oct 2026 19:36:22 +0900
X-Gm-Features: AclHuK_Ev7MJ0UlkIUNpIuHy-qSRb0ZmswNvaVNZebfMs2Yp7BHznY1L4EcdhRA
Message-ID: <CAKL4bV72vvEwMwvDXvgZWio85xJf_SF1-XsNJOtXYdXR9hN5ug@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/243] 7.2.13-rc2 review
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

On Sat, Oct 24, 2026 at 3:59=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.13 release.
> There are 243 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 26 Oct 2026 06:46:54 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.13-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.2.13-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.13-rc2rv-g7694d244b4f8
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Sun Oct 25 18:47:34 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
