Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B863F65F6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 12:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787745828; cv=pass; b=P/uXeYpiPRwZ4YxczyXqtOJeOrRKiU7Jdy2+JBypPzjJxQPlNsdf/QwTmpGs457Ne2F00RVAwtx+167ExlejNshOWXzbjp5w+8R7V/XxtSMlBhcK0+vNZXkEbqjRyZfQ+qWSgxHlLerzsQGY68D8tGsD+p8HGHaqVrF3gMNFss0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787745828; c=relaxed/simple;
	bh=VgpSkfkt9+IsahxI1cQp4xeSvCEjsBixCuyMoUcG8B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwrVyJ+irz0S85W1u/o+Ki83yqa9xo8mBOwj3hJAcV8jgmYuPc10URGgSEwUWWIlVHnLANvGf6EyfzLjR0Ov9WO+PckFFSdeH5iUvYsYXcG2N7CXca//+aXHYqHhHycOXj+a7w4P72ZHfsSr6l2gsmF9u1GvWCzYW5cltMIdKxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=aeznCf7h; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="aeznCf7h"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c1c52d920b8so105651466b.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 05:03:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787745823; cv=none;
        d=google.com; s=arc-20260327;
        b=boRkW8Dne7t+Q5NKaaWoIUHik30fYYdlgKliCO6XK+qFAltWHyBUfsGiuzNHMatiuz
         DZAYjmYojaPNB5NqBMzTQrps/N3EZwwEl4KG2Caftv5IcyESnFLu9jJA7zQijb8HztKa
         204Kpc+dgVqMXtWoepfTh2Zny57+Y/uXNKDswE3V94FwxZprpLYiaa0KrzbNVjjajxgg
         1qkFjvFaW/0g2OyhhfMxPxh7P6j8TM4fwTVvrA5ktzm6mUbdojEyRl0N5cNWtJGoq+td
         jZlrUdgkw/Vmg3HC/S1oaN8MlaPAsH/knBwJsLJQMiTZGA1vwRnR8a6OlwVTs7U0XJUn
         BS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KHczRSOUNQAOaPV0/pSLE0qgfPRAm7Vb+2aII/l1HUg=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=CeJLtPNVobkAfKVmQxBoJbizuEAdC3a5ltWXteI4sMOyMM0clDwPYVCQuv2BBItQBr
         S31hI/mntq/E4DxGrMfl1kFrsmPs7ub8kNJ5RfUwEL8q+KzVjFWs8RrqPOkgarYgNDA/
         /DvDMgp6r3nhVXnZzsNkISf+yhPbZfHWhBbKiByu+YFjVHHUe8YeDWYcvz/0s3DKI4x+
         2xLsgJ3uFT/gjooVyGnRkThaeh1NT7erI7dAQo78Aoji0PWtEb2rEZzYl80IWBffsh2D
         MFskSK2YKxqH/FQr3PAhXBm6/3ZnyNOJ68mXp33Hj8yoFOCEhARE5fgGVC9FBz3tnvnO
         oEEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1787745823; x=1788350623; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KHczRSOUNQAOaPV0/pSLE0qgfPRAm7Vb+2aII/l1HUg=;
        b=aeznCf7hTlqCxVFeifQu9uQE8Z60OAY04d4nwCwUqMH87dRKvGqlIcUnZdiQsdHB3C
         PvYYFijYXBlhLEmlkA9JK6KvTJ7S3NmH4EJOROoU+FqhpVBrTvrCp39GBcdpVTaY6yiK
         qU6J8KwvCIy4LgAIlHg4R8BwBWMOmXni4JykFIkC9Ysvk7OSHGnhkKLBVkmd8QtaCF7R
         A23z0bPfVSSo4FWV10Oz04dALfNKbEwtpzAlFZVH1doPd3J/IZ31HcJmEunyno80a6iJ
         DOF8LNyURbFBh7Ls3NNcq+U5zsPiD9MBJqfZPEblkVqLpVLNliKZBsip3HxZyzsQb4d8
         b91g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787745823; x=1788350623;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KHczRSOUNQAOaPV0/pSLE0qgfPRAm7Vb+2aII/l1HUg=;
        b=KYgVw9xStUjpyM8gjqRU3N2TYC2VGoaSMsoiVq3lICLulU53fb0h81oJeV9eIdQB7u
         b3zRRnQidjtmFzy93+VHF1CHymN7XD+g6R4c41J8XbjG7l1/l+olgFLLbjkL65mC/N6Z
         iOi3Gb1S3SRSYkByqz1390Ht1Y4wD8tfuR9+fx85rvydgg+tx+WBWNm7LTj0mzI1yn/a
         wBiXc/dIasAfHomaImqxqGaHdsZLqKrwarko9PcBx79iBqRn5C16o6fx30HCGXQ0/80I
         TAzBNvHNEvVUwRng3Iensibf+b0Zj3Z7NjA1/ubli52wC/Db7Ji8+ooCNu8+CV2DvQw2
         qDmg==
X-Gm-Message-State: AFuF++lo07VkLaZ2aP0BkCvHpluXBHYVCADOBXjMncAUFMKqOrcsj5tN
	yZBQMqto+L8nFu00ekY2HwMwCH5hoew6mlfala8JtfFye4UJQtZvkbLYEgHeVy4F9jzae8Crtpy
	a4yTKoUWk9bbQjcMhz4kKe2e7v5EAQdX9av25CtO6Tg==
X-Gm-Gg: AR+sD13Iq2uWPB1Hp/WxyFDZyO1qcp8BmtfB8ObHQSC2n4SSqKBVvlAyoNEh67mGEIT
	fPmzcwnl8SQps6Ev20ULo6Uqku4uml43yqs4YplA0z2xdxpbEd7sHnMW5/KKjio2vKeCZYpjfKc
	iypuGsx/efKJY05UBM7LUBs88lKfZ3YMuViDVKALjy5H0fUk5QwMH766+xv6hy8Mjfj6IphBCbD
	KdIFzfDczTx7clCWcc/0kZcpLq+sYLMUVN/nnRSUDCwnD8SY9waoAGPR0lxwaPiudOzmFqiRv1m
	sKdBRQ9pzGEINrtaiTFve4YVDMYOBO+DaUCca3SjDMiBNVxkobioAzQS
X-Received: by 2002:a17:907:9616:b0:c24:457b:86fc with SMTP id
 a640c23a62f3a-c250c329bf3mr603822266b.21.1787745777707; Wed, 26 Aug 2026
 05:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825132541.986300899@linuxfoundation.org>
In-Reply-To: <20260825132541.986300899@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Wed, 26 Aug 2026 21:02:40 +0900
X-Gm-Features: AcwNN1WueC4r3S8GatTaKBZIWNFDc6UcKGJRNI-BkTohTSoeo8p9V_YfbG8RAPM
Message-ID: <CAKL4bV4730AgqL6=U3bABvedwAtA5Kr5stJfCaCHJ9ZVyvn2XA@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/101] 7.1.11-rc1 review
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

On Tue, Aug 25, 2026 at 10:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.1.11 release.
> There are 101 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Aug 2026 13:25:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.1.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.1.11-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.1.11-rc1rv-g822f846a60fc
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Wed Aug 26 20:10:08 JST 2026

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
