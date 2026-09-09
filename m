Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FD37C11F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 23:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788995350; cv=pass; b=WUYdCLErL7+jx9CBtApnESMW6dfS8DiitrGBxNdrv+8r93SyxW8Y1PQ8CmWjiqui6t/rdnN2P1mKF84m+AU2Rh+w6hrYOAAgafncDYydAOMLlnHqqYTgwOa4+TetG+ihJZhoE4RFzp1q8MwzxR9fp88rnDRuUcWT4pNu86C29YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788995350; c=relaxed/simple;
	bh=nb1YblmrUlr2sa2V2CZkzLqPe6bh6GMBpVgP0JRYHCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etNUM+g4t7HmnMevhRiD5baVgJI+U+s9mrKthbUUScK1c8RvsTYwApxw7OKcU7gXPxY5NdU0UWIHO3AImTCpuqe23WNev1VvChCiD+mRcUrcEeHqos/9ingmOvCSNL31BMzzNqj7QpThP83iS6Jk2EMymZGZq2rcF238qqmvPUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=gpQ3LkG3; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="gpQ3LkG3"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a7ea0046deso8213966a12.3
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 16:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788995345; cv=none;
        d=google.com; s=arc-20260327;
        b=kNu7pMoEHZRf/iusHwHeY5f1FQG2IM/hDzuZdeBUsAkirSeO8TAjuUw0v9Emtrs2U3
         g13NSALEgnMMyParKSn24Z+XyJMKJXU0vNTtoNJ94zS//jun4VyEdn9Htm4rD3snawFb
         3zqObW8MqhBJAJX+n6BJqlEyhiLVKjz6bzjkq7gf9r42mMn97yIzK24JS5laHUykCkvz
         VjOFKGYoJKZhlxT7dSYkM71/DUEd7sNvvD+t/9ZFm9Wzzqdilrq/mcQFLCWTzzH/mgLS
         eMQRKj9ErthFgdVc5l0KTVDgpQeEFoba5Q7KNAvW3UO9/TwBSoaeYcasGv6YycTEjOXY
         eSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GqZtypdgnQbkzEFaLVtmtAULjzYK8mwtxUr5PWfFkcc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=HbTQbmcLNKqP81ZABFJTlchfUb8EoMqazRfELQromGtHQwBKeP8xXSbRTHW89YBYTv
         QgMh7NYc7c+ck3WSeKJ2ufdPvqTiPj4DHgcuhD7YA880plf9uy+F9lJsTnVPZFyuLr57
         Q6TD5VuqQpFzHy4HRg+n04u7UHc5dbi4uL+l/36zMK8I/kDsX61aR3R2ZvIh76zBx67W
         K4t1mWLygl9QLbE0Kf3kSMI3vJnN7Q3zVEipgd+7cJx7/it6KL01lBIgVEMTNXZnxmy/
         aQYyIRaUWctIhx43HBhzNGTiolPwLFpfQGyPXLNxjVRI+s6Tpmm5eWHkpOXOCRiDm33B
         B8TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1788995345; x=1789600145; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GqZtypdgnQbkzEFaLVtmtAULjzYK8mwtxUr5PWfFkcc=;
        b=gpQ3LkG3bzlKZr/h03MwBWovXuDOnbT694YKP5hiJq0/pZS7VHZDhdBwhCLKSqx7tL
         SpL+GRjq6d4qZ9ru5QoYB1ylqz2jxzB22uL7FEEtY+s5ZlvARG+debVQNRO2vOhIwYgZ
         fXC6PI+1ZmodS9MEkQdgGNx1VmAQVBs0DcBfgmUQJmyqImFDx0XXpps1gAyazAUR6/fg
         YLwP9JP2L54sE5ffFt7/FoloFckvTDhk8SJbCZpPVMHxOTLb4hDbRqNqLJhi/Ft66IAS
         OaEHYczx8hj3SQCVFKtqQ754KsjBHOyYNdb3Iynq1j6+F8UJV2uDegRNQeBvrKsyah59
         RwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788995345; x=1789600145;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GqZtypdgnQbkzEFaLVtmtAULjzYK8mwtxUr5PWfFkcc=;
        b=GJ3Sj1tiEqkjNG5yi/6Fsyp4lcDl0aE7iRc6G/1j5oLUCLlnauqq3EAu51NNALUG98
         k8P9+X6RqJspdAjUayUwiBQD3899sILHazINkXj+zpsVuuC6VOxPnAvkLmwsfElJ/X0W
         Ls1K5a2lhIqjnXt6KWpGuux431hszZOBuU8Bw+vp8rPF7yewFpNPsEwkqdyBFP+zMSQ2
         L5TAmAE9Q0XcaVxXebeK4kyTupD7gjqUQ2raFhNJOLSBBWKOjhsxoKZGNzT0H1J9FCr2
         xJGgw9dWrf2EoPdJX7VYXjcy+v9rPJXQgiCPusoHJ1GpV74sB63QhxR5hSIFCNntQthS
         c+Wg==
X-Gm-Message-State: AFuF++k3W0jXDDHd+/L7Hj8iZNppRkN/kKzgLe4AWDoYj4MVy8IIpHsn
	4WGBn0VmExesaCTH8eSyn6y9wLmXOij1h9uZDMfX0mEbVkzv5fyIGdmTUMJ0S2032sBdMbr/f8h
	6IOl9iR2sok/S/54HXrjRXzcHWW2O692ryIE6ySQqfw==
X-Gm-Gg: AYBFou0HuucRr10mmi+Z9oTdQwEJCtS1371+QXGWqJ/Kll7JMRarFl2FyWAFxRer4+6
	eHqwMRsIYah7d4a/pY6hiq+LVXuYNnZSvFBbVJ0EsH1VOnnYQIWWk6LTEubte9rhw00Lwg3gTFJ
	+pFLok66MkYmwxg1h4PrLsBbgptmOdABuGzq3YUvRdwqvjCDmiAJuG8hYYEqqBCV2W1eIrVGGcJ
	Y6mPiIMo1KzSNLYMc7ZJnRP8I86LprIIj0/8nY4y1ardF6MLK8oq3ACF9BihRGMCPSef5Ar3zQt
	L1OfT+sMEfKUzJqcptev4ftb1Q2DWFOuT//Pyl9Eu36p2lRR3Cxf+6q1bzuc06iUq40=
X-Received: by 2002:a05:6402:3546:b0:6a7:ee56:8158 with SMTP id
 4fb4d7f45d1cf-6a7ee56823emr13010872a12.38.1788995345102; Wed, 09 Sep 2026
 16:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909134230.441546314@linuxfoundation.org>
In-Reply-To: <20260909134230.441546314@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 10 Sep 2026 08:08:46 +0900
X-Gm-Features: AcwNN1XsZj6QFOQ_6a3WQsNELHQa_nUcIhH5WCykY4cQ6hErmSK2vs3WnidzMYE
Message-ID: <CAKL4bV6sASyrDc81R648XH+kV-BSOa+-v_4CpEp38KiHzU8_CA@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/556] 7.2.5-rc1 review
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

On Wed, Sep 9, 2026 at 11:14=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.5 release.
> There are 556 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Sep 2026 13:40:31 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.5-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.5-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.5-rc1rv-ge01c81012950
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Sep 10 07:34:49 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
