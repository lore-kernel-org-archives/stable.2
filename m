Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F90D50E5B3
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792059591; cv=pass; b=SMgoS0trBKeScEFHKu7HUoX13ElWPy2y0cs4LMJWeGgfGNL9dxoRWlED4a4sb8ADfFra4UGj3U1zQ1wPqlNrn8+/2FuHw3oM+9V6sDs6ON8ALzvd3fHfbVPqsVSMZQmRP/XTqD1IqUwDqrOV11HDlc+qxtEHh0G7RHe7585UEM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792059591; c=relaxed/simple;
	bh=aLnGdcn8SVT+l8zY1DVp9E1OXpgrWCKYi41UBV9MLZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OoSVYOuCwbm2KiBlZdlniIbNrpBEt6gonq2nrv1gLwSgcpUKFqrknAMoh5zBsJq32S/UShVU0lZA5ix36xTXaF9ZpuFJzPoN4zSYjUoQnkUIfAOwzhgAEaJlTYZkQuIY9zVP9LSkU1lRAqPjxLo3yhVD/L+mZB2c3KifQPTz04s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b=oNXVPavk; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl.com header.i=@futuring-girl.com header.b="oNXVPavk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2e8e738ae0so902849366b.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 03:19:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792059588; cv=none;
        d=google.com; s=arc-20260327;
        b=ZjcuS2jiM1SxLUvdFeiiLIKgNoXfSmT3zUeDT4qmiRJCgNm/8B6m2DUWnvfNmWbJ7M
         xPDDMMY7unQGgDn/pjJjH9f5oQ6kfRiCjB61gC/yWXc72t5tSUwBV1G0TGFS4/s7xHi2
         BOz719ZzeoV3HR/XopzCK3KSLq6xcoLfvQkc9uxwuzKiP7uwYIcngmMuvygjymuX/rNJ
         aVr8VKR6TcwhjMd3Ed922t8Qt/9yFMIJ75Tzl4J5EKOf8B2aa0rHNzKQh/zxNR+0ougs
         QMdIlMZBzWhS/cH7sE0KBlZOxOEQS8KjLXrv+oV5snmZeag0Rx2ub69stFnGofCI0Squ
         rbLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6G9qdhvcH8NEbAp7bRobDvF91lk/yeFcW7ZExqFVdy8=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=PSehLD3RAFyupWV9qBO7srAI0g9n/dB8SXpKmrcnH7PkEfEngM2KEXmiUlRxgfve69
         9G4sxOzXOD7LoBTwSSP7nFd977zsKnZ5HXSeCdkZnOiLdC1u9bRnwLZAGwBPJZcDE4GR
         mq8JweUMHqD4t0KrDXSW/Z35gJDBzbBakuz14yKJrFS2ViXBTpFGYhEdm4Pe3RUUrI3U
         yCPE6Tdnodvd8dNDYNrzOEUPvbVsBFCgTspHUCdTT6wIs67rRTWnRLpEtJz7eHk1aXwX
         TvF5bzaf/2a855Ofhi+k0HW27tO+xXvGzzSji+mmFk649CM/RPbUG9AdXvw2IMDfsvFi
         uH/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl.com; s=google; t=1792059588; x=1792664388; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6G9qdhvcH8NEbAp7bRobDvF91lk/yeFcW7ZExqFVdy8=;
        b=oNXVPavkUKdhK9dNFHpW3f3xGAMaLawKG0w5W21No41wwr1MIUfqVnyHETF+uBO36/
         sQ1sze9wfKKxfpMKOxEJRtOMrQs0upGSNiDnv026BUfP5dML89eQ9Ql74DQbVf3tvAy9
         Zl64to6Uof/SOfQ2eXT+/o+nwbbIGAwOSVfcQYs7ik+GweMMVVW8QbXGizUQVhdoacAZ
         hRepJ69Po3QVF5+OL6FHc6Q2MZU5VR7gErcF/2oDNzlj/zBXidailhjXNrrjUIaYCSOY
         vaVILKwdtScrVeHfH9wEJSiSK9XVkVvb5ECm73rg5kjCPgdtgINNGLPzdppz0m2bUapH
         MszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792059588; x=1792664388;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6G9qdhvcH8NEbAp7bRobDvF91lk/yeFcW7ZExqFVdy8=;
        b=APpqoLYVMWRrNLELDD36AZOIfeBmrj71xagqLky12dKbEP0e70DbyHyMbAqcXkdoue
         omOnro4NZEVvnd6oyeOh/cdMaDNvSHghrxMwIWNvn2kAsdAYE3NW6g09OLMhqjaddH9/
         pZJ/V6owIa7/OOyL7Hq9rVbb0g7kmW8j9I6MnW2LJPmwUIH1MbzZdXUvJc6jluhL6f+C
         6ATpJBe1ea3FOL+rymVpz+C3W2awFRga9gMK/zAvvCWOr2MaVQGsA5D1BW9hZcAViWk5
         bMR/KtkM8zaRxs+9cwyzAq/j5t3Efw1W99Sth6vO0q2Bq16+6C7CTQ3TQD0nA7j/ntqx
         PIfw==
X-Gm-Message-State: AFq9FYJjCglysXhRWq3z09IMiFLCcQuquagnqEZqud72mFirJpczcnlp
	2IkXfKASrPLgbDE5Od7Pv64WaMA7Yi1XTPeRiqMgEtMUw5WrLg+Agdqveuvna4U1e3PxFBYCymh
	/iY93ByQKuOLG/m0d8FFO1j33bJmh/00J4MknPRIz0A==
X-Gm-Gg: AYBFou0oGx2LuC5AG6C1JEzPESjYcZa69koinG1xzZCb2xV4cA7sNZgNzUv9clQbVyM
	PkpgPYsdOfH4UaFJhXEwy0jRADF3/9nADgNBKlme1wHjoXOQCJO8yplMmYXFuaRfzYXik+fGErn
	ePeurX6CaTDG1BlfDXSCuVCyaga8zsxLbrd2DS426N6h8GLKI7KYYdO3zGLrLS6K6xCtuICr2Ii
	UyhyxFWJv1Kqe6vJQPlqpKUtgMjMYwvQVkHWnEkXk9C+KrbOkx7ZwApaji7ZSSxkkgeyhB5dfGd
	4ehptGE1Q3+YxwBCE0IjetcmXGHMQRJ01DMiR/8gdr/h1XqKUTjtnsLwnwov1qmdeA==
X-Received: by 2002:a17:907:7fa0:b0:c29:4490:50d6 with SMTP id
 a640c23a62f3a-c31aa022de1mr1644018966b.47.1792059587420; Thu, 15 Oct 2026
 03:19:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014123758.782265692@linuxfoundation.org>
In-Reply-To: <20261014123758.782265692@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Thu, 15 Oct 2026 19:19:29 +0900
X-Gm-Features: AclHuK_fNn4KLGlruklVpvCw979MIpATa3NA0dr2zzs2gEVM47exlU8CVc0L7T4
Message-ID: <CAKL4bV4yy39e_UswA068F9favpRSmVbEUMqe0cQrFNPJ8EB2=A@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/284] 7.2.11-rc2 review
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

On Wed, Oct 14, 2026 at 9:58=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 7.2.11 release.
> There are 284 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 16 Oct 2026 12:37:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-=
7.2.11-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-7.2.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Linux version 7.2.11-rc2 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 7.2.11-rc2rv-g62eb344d00f7
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 16.2.1 20260810, GNU ld (GNU
Binutils) 2.47) #1 SMP PREEMPT_DYNAMIC Thu Oct 15 18:54:27 JST 2026

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
