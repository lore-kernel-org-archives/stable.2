Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04765423160
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511705; cv=pass; b=ELPJFJyK6Qxnsa1slqDDQlMYYrrs9qzqByvchYpA9pLAE/2sZ/zkUU07TzN3qBpBHvgQtb825A5ExgKd3q5hGBpBlcu2e/Ng4pBRl1Dhy/MoiRvbvPGTTeUyqZDqlkfLfy8X4fnsUcu0IejG/DF34tdbsAnxTefVFPBTlu0to0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511705; c=relaxed/simple;
	bh=csbZ5KAl4vKfesLimfYyTmN73lP+bB8BTXIrPZQ6Haw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p0DIS1206zjUgcbiuOrD0f0KbEWNlVGskBG82C7rKy55oASdScazQlZwl2BFxsQxzhQ67Z0ll7tKlKLPfzz7J+nk3iqaiUgvDS2UWfFQjTQQwsfC2rMDbT1L44KNASz76ljklDXnVBuZAE8SwxeSM94MK+jGC614Cz8jgmrVrMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=bYvD+FjS; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="bYvD+FjS"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c255c58156bso134090266b.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 01:48:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788511702; cv=none;
        d=google.com; s=arc-20260327;
        b=aXOiTSJOtAr53fb4KQ4kHM12pfd+ewku69urLURkBVkPQN1ter+FBzGhe2Uj5hermV
         MtZ5gfGU4NlAfSNO2HuEcAw6rlXmSKI5CdE8zorLwPdL2vn8eC2xEdmdiSmYT+xTBFX2
         gfJHD9QnI8IJXSHFDn6yYfRbUua9X1bqdczHMaKKaIvfBgXYRgLg394b0yq+PZ/2B1FT
         9qlE+lTetQTH//I0YsrYSsiRwOT0CLXzrvt7Itwl5B9iB0dAwF5UBiQ3ClwZpwvjz9Xo
         xVN2COGMcmFKEcaBSHjarAqEqR/WXt/upZlMazgnb2ZojUu2oI2JA6hJipmRJxitvG8j
         Q5kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFwA+0YYo9We0NL/A/S6sLwbGWp28OfVIR7TYbYUxkI=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=pyy+7HcKk7Owwrmuyhs96SdjHWhApUmsP/Px1xKogyNJlyfAHmkhkacC/2Ampf5Y/0
         Fd66NK/tvOTizOTGtCjZw3oS6c3WF+O0XW2YbPxD7VHwoHgST8nfQh6qHMkA9M5S11XF
         GR5yld4WbT9obO0L6Z3VDEKEct1D9ZpVye5U/gcj2RIwesVRnfYiZpCJ6lM98QSxr1fY
         c05OZUHWAbT1IjsV288wqHHfj+jA5Nd8GQIQsfAd5qr8dL8t60bWxaA7IUZDGstIFhpf
         gXEnd6qFRsbMK3cjfRUwMtxEY01W3s0Atwtzwr6B8NIRfieIltJAaWMnZZlK+k49pXCq
         WdEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1788511702; x=1789116502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TFwA+0YYo9We0NL/A/S6sLwbGWp28OfVIR7TYbYUxkI=;
        b=bYvD+FjSus3KiZ7Ep9GrhGd1vV4HUQ2foQkActPMvP34kXZUgntJJ7WWTBDFSn2pSx
         fChjSzjQGuE6diDlqVc/5lNU3eo2PnLhf1uFJDC8Jef4eAPxLJmWmL8oMFHrBDVGcUlF
         0EC9B/5kOSzwbdqkby4tAhbOQ2Iu3vJjiu5pYpS1l4l+ZihFR7Sdp3aO1kv/vPW21YNs
         RtkOD5pr/hSza8zQ4cP8pSjFwos+hk9Vd5DVaF2IEqxMLCZwZgK/r6VbSVHQBYl92tNb
         aX6beMzfnJYAgc7SysJseH79d9j3xyiZ0Zac+Taj0siulsJxGFu7Eu7T/Ux6db/8caCO
         moHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511702; x=1789116502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TFwA+0YYo9We0NL/A/S6sLwbGWp28OfVIR7TYbYUxkI=;
        b=heJG5xojrYBJCwZ/v+Ll9HG2TxO/slST5YvfmrNSjsMJ+L9EuCNBi/2YZSIBqHvT4v
         /0kisV01HEXAoSovFUuDVi3g+/LNRJgYWC2OjEBgtXYn2bksFfzdO3dxPZHqt9icpcVS
         H306Bl4GTeOQcBIOe7a/TQAKKpdA7RqjdvatBI1aHa0gNQ9EHQbd3zVmcNyGNm2MQIvO
         L1FOJBozzJAH494vgJjpJaIjr8fUF3whYV0riFsZNyGY/i9ITQIdLY7L9dmIODM52KJQ
         Bubv8xMjug+KZ+F8t2SMizUn/UxABa6Yl0OJeXc2iJAZHpRS0SfKPc6B3nW7RooH6WSR
         c+ng==
X-Gm-Message-State: AFuF++nD26cE/VxXZZyfSWcvtte7DgOur0tOrUQDAlMGUYtrIIDDmGaO
	5HPTqVSaJ+fFU5keC+za4KfHDavaUku9M/KwO6SYX9Mm/lRuhJwSS1WmXRPvMy+AxcNdUSvSRk2
	qWAiA+GF9j3Kmar5zFGn+lQsX53qi91z46tFStLyqjdvMt7+WFeb2qsA=
X-Gm-Gg: AYBFou0CiV9Tkqac1szXXq3FQ2SoZ9N9HXewwCIjSS0s+rENPZ3PcSEqdjzKl8B5nVp
	dO9ts1iAT7vD+Z6dOjX2XdHL+ubt+I16gtCR4xPO7ggHmDb5DPBPDZXGYcAykqYQd7QNCYMPFbg
	tmgKbh0lABoW5RzMDirC9VYu5HQp9VVrc1+zZwoV6GVWEzZAbI3fur0T3WPLqXzCFNZKq2DgBjJ
	EYy6D7t01FhjiOCnLLzxxHd1/LrHqz8/mZlvPrQ6D7xijyL30mcrXyhDb6eqIZB64Z9eq/y4zs9
	VcQ8D/+ZvCvqtZLMBxO596PI8j2nWd6ejHnsz6BJWjz1gZ3FgyQZV8cO
X-Received: by 2002:a17:907:d206:b0:c26:19de:9ac6 with SMTP id
 a640c23a62f3a-c2619dea68emr60778666b.30.1788511701432; Fri, 04 Sep 2026
 01:48:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904045803.810145556@linuxfoundation.org>
In-Reply-To: <20260904045803.810145556@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 4 Sep 2026 17:48:03 +0900
X-Gm-Features: AcwNN1V5JEyMRQOoTWxhoYs55bOvO-Fzg6C42vOCqnnnM8kKEll9MIurC3WByhw
Message-ID: <CAKL4bV6vhyqtFHw8Mb0XywmooHnFp6AFYsYGEUT2vm804HXTFw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Fri, Sep 4, 2026 at 2:09=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.4 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 06 Sep 2026 04:56:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.4-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Linux version 7.2.4-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.4-rc1rv-ga5fdedcba898
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri Sep  4 17:16:05 JST 2026
Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
