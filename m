Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A1D39DBC5
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787309099; cv=pass; b=avF2xHEeDdncJKWptubkenFU0ILjqB1l4kjBjRMNLE4mjcfPCZ39QkD8UhunvWJ4XlYWMBMKFYUtkdJ7yidCGE3j43CAmLVRqUnas9GUNK6Ostc7pwx89Dh40CDeSkNewsMMHgOyZTnCOtLjLwYA2fnh2K2nQuRMc7jUcyma+FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787309099; c=relaxed/simple;
	bh=fp9bZkcQ7bqK+lUV7+jm5JjDcb1xcI/JKOhPfKDJpCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eb+L0YxG4kz2+9+4aBOFBPEH1f5l8RE2+uOoVMRjtiMnPOG82oYHoxMiblR0I/yiaPHY85U8hYXp1MHhjzENWz5nwqBILilHw3r4X2IJpnRErMQo4EBfy8th8HTNgbtYx2sr445Qr8a1/24WRbzhPQs44cwUDC2g3+JelzRDPyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=EXUOmfc4; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="EXUOmfc4"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so1870790a12.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 03:44:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787309096; cv=none;
        d=google.com; s=arc-20260327;
        b=XuF8gChanJUl1F5uuACkWNKUYmd/xXY04LB0sCpm02+u2siuYenvoko9uHGs0UyK4j
         u+uvAvVjKNgrXC++hUmjsPQ6WD+//1WZEXyLo0U/bte/ENSmnF8m3jkde65vLjDtrMfX
         bzL0977cxkVpCrphbwJmQOitkVQP7SQM1so3RbMuq4yMg6ZRxo+MgtGBjZzPjUTUFlZj
         8MadCgZSHKXtufCfDvORodWFKluUwKJ5YouBj+FepGCv1IRKzeGpqDK6zlZu5hW1uY4E
         wNZN/PdwvZxmpTxq28oP+rS7TEX1/rhA8EDPmx7xgeW9EPxMFyeENGzro/sLpy7FMpny
         u3RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oc+ndhOPFFgR0ZyqbDiLolDffh9s6ShIWGnHuTpSOok=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ly1vXwJ8k89LI3p+w91pR6mJ37+sOJAO9tpnMxY4u/U3u0uVYO0YBaOqR4zS2wXEPg
         mhcbpc9M2OUGCh5kSLC0kO8z1MgYSjQax4yShDOvmYlbsfNMazm0GCoJKuH8F+rkUHoA
         c08RBxS4JGlpWHOqEblen7IYxM8jIdXcvuhkWT68Zr1Aa2Bur5QVE/KEVp4b3x4l5Epe
         qS7tOq1H7WMEWwwvKWFwAhcuCvn4IzUo1T8yfxRzu+Ln8kQgiN3/DTTyUWAPNNZrh25Y
         +E/30g1BfBdhRTYmWWmjTrMyZhAJsXXWp/wh0+sYaT+X1LFPfohsz/36jnX0f/+i2dc4
         iB7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1787309096; x=1787913896; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oc+ndhOPFFgR0ZyqbDiLolDffh9s6ShIWGnHuTpSOok=;
        b=EXUOmfc4uILV4BNdBvPSbJNKmtRrEl47ikJVNeXXqDU5eI8BObL4YZvWZd6qOUr7Ws
         csXMGFK1+mju/CsIM9F4N3I1ffSnW+5ztILDbUzP2blt2GAAdG+r3qZrAkdTr+p4dWet
         EQzLkuNSIBDXwVg8Yn0BBnGUFzq9Dponjz36pQYlAE86MMVKwbjJNXsC41hW9ETym2wI
         LBuWzuh/nniyL7J27mx+QmVF/bO670s/YF0ZqvZRyPWhfMWtaCAEAgsSHgazwbLBiJZj
         yTEUcQ8z9hhtUlwGSsupskQ2+qiaD1OMG+rUn61rgCmjo6cR3UEwz2bygQvg05OocM2f
         qQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787309096; x=1787913896;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oc+ndhOPFFgR0ZyqbDiLolDffh9s6ShIWGnHuTpSOok=;
        b=ese31r+r9yumxyWOPm3wImBYynZMLiT6foG6HbgsfGTZ556sOfnqORfKZmZtZbhTTu
         IyAP9YAbxy4E49rkyLdjprumZWD2Er50Nh0+WfDE6NROigSCLpcnnSzLqo3lROcpSfkx
         +T7GoZ65vDVWPYEBKAnu+NwED7AhYFLJuSUC65BD4C4bFKTyOVX8BXu/Zg89+2/uVo3n
         au+aOR5WiaiL81X+mqCaaNNattbjD44NW2d91EWx9DMvCmPfYkNTlpWh5cjiaC0M3m5u
         L5r/J4WDk3lCBVDdq1gM7Im4OQJ3ttLwXmFBamnv7a8A+S/qdhpD/eGo52ayF0pAmnY/
         KHLQ==
X-Gm-Message-State: AFuF++mafgmDO4d3ak3LnYBvgyoOk+aD0yEuVDIZl8L9QdmGI2cgkHJS
	Ruxoz7TpnZf80Rrv3Yn6mdb2shJoYYVcNZO+uKq1vTtv87OlkdQmj1T9ek9CIyX/ySc1iUHA5V1
	FV0RUu5JUniWqepbe2Mc1WzI0fWol83L7DYKeH7DT/hYZV6JV+DdDRi0=
X-Gm-Gg: AR+sD13DvHA2tAZdgszdhT4KEICjn0IXSa77jFRHbOc8d37yifnoO+TzfpSDx6s5/ZU
	S23GCobsOlGoMLOX81//YegZxiwprRR5ToaXJq5MWegmBJl5S7hSfcwrPrlw0qCR9svhaTXwGNo
	/tcX7vocX/Ybn8kQT3JfQX8eO6Pg1q4p8GfXdl8JGpj2bA3sHtFMFB3D5ZM934J5TcviR8W5Xcb
	DsT1R4SgnI5s5/GdaPEa9H837r7jiun97e2kKUetc49mFcWEJr/NRLqqnRJzQqQ12rhgNhZ+qp7
	wxDw1r1QkXF24rkmm6XaedQP4mAxHGDZY/kuZNVoX4Ikvz0S8IrfGf+e3YPZYQH++L17fSbfcUu
	1YQ==
X-Received: by 2002:a05:6402:1906:b0:6a1:f8ad:6c0c with SMTP id
 4fb4d7f45d1cf-6a42f1fce20mr6511161a12.16.1787309096180; Fri, 21 Aug 2026
 03:44:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820145244.450574346@linuxfoundation.org>
In-Reply-To: <20260820145244.450574346@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Fri, 21 Aug 2026 19:44:39 +0900
X-Gm-Features: AcwNN1UOrJ47YyCM5Zn3W-Ss_-CHmv8VQveQ7gr5WrWunN0pW2PWUBlYOmL9jio
Message-ID: <CAKL4bV5HtTnp8etw2DiV1oDQOOqew77_OaM=vwC85aFoC6KR6g@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/228] 7.1.10-rc1 review
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

On Fri, Aug 21, 2026 at 12:03=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.10 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 22 Aug 2026 14:51:11 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.10-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.10-rc1rv-g02db8575a623
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Fri Aug 21 19:13:06 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
